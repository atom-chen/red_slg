#include "debug.h"
#include "hash_util.h"
#include "mutex.h"

#ifdef OS_UNIX

#include <sched.h>
#include <pwd.h>

#include "p_thread.h"

namespace GXMISC 
{
	typedef CHashMap<TThreadID_t, IThread*> TTheadMap;

	static CMutex lock;
	static TTheadMap ThreadMap;
	void PushThreadToMap(pthread_t threadID, IThread* pThread)
	{
		CAutoMutex<CMutex> locks(lock);
		ThreadMap.insert(TTheadMap::value_type(threadID, pThread));
	}

	IThread* GetThread(TThreadID_t threadID)
	{
		CAutoMutex<CMutex> locks(lock);
		TTheadMap::iterator iter = ThreadMap.find(threadID);
		if(iter != ThreadMap.end())
		{
			return iter->second;
		}

		return NULL;
	}

	IThread *IThread::create( IRunnable *runnable, uint32 stackSize)
	{
		return new CPThread( runnable, stackSize );
	}

	CPThread CurrentThread(NULL, 0);
	IThread *IThread::getCurrentThread ()
	{
		return CPThread::getCurrentThread();
	}

	static void *ProxyFunc( void *arg )
	{
		CPThread *parent = (CPThread*)arg;

		// 设置线程可以在任何时候被取消
		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, 0);
		PushThreadToMap(pthread_self(), parent);
        THREAD_TRY ;
		parent->getRunnable()->run();
        THREAD_CATCH ;
		return NULL;
	}

	CPThread::CPThread(IRunnable *runnable, uint32 stackSize) :	Runnable(runnable), _state(0), _stackSize(stackSize){}

	CPThread::CPThread( TThreadID_t key )
	{
		_threadHandle = key;
		this->Runnable = NULL;

		if (pthread_self() == key)
		{
			_state = 1;
			_stackSize = 0;
			PushThreadToMap(key, this);
		}
	}

	CPThread::~CPThread()
	{
		if(_state == 1)
		{
			terminate(); // force the end of the thread if not already ended
		}

		if(_state > 0)
		{
			pthread_detach(_threadHandle); // free allocated resources only if it was created
		}
	}

	bool CPThread::start()
	{
		pthread_attr_t tattr;
		int ret;

		ret = pthread_attr_init(&tattr);
		ret = pthread_attr_setstacksize(&tattr, _stackSize);

		if(pthread_create(&_threadHandle, _stackSize != 0 ? &tattr : 0, ProxyFunc, this) != 0)
		{
			return false;
		}

		_state = 1;
		return true;
	}

	bool CPThread::isRunning()
	{
		gxAssert(_threadHandle);
		return _state == 1;
	}

	void CPThread::terminate()
	{
		if(isRunning())
		{
			pthread_cancel(_threadHandle);
			_state = 2;
		}
	}

	void CPThread::wait ()
	{
		if(_state == 1)
		{
			pthread_join(_threadHandle, 0);
			_state = 2;
		}
	}

	bool CPThread::setCPUMask(TBit64_t newMask)
	{
		cpu_set_t cpuMask;
		CPU_ZERO(&cpuMask);
		uint32 num = sysconf(_SC_NPROCESSORS_CONF);
		for(uint32 i = 0; i < num; ++i)
		{
			if(newMask.get(i))
			{
				CPU_SET(i, &cpuMask);
			}
			else
			{
				CPU_CLR(i, &cpuMask);
			}
		}
#ifdef __USE_GNU
		sint32 res = pthread_setaffinity_np(_threadHandle, sizeof(cpu_set_t), &cpuMask);
		if (res)
		{
			gxWarning("pthread_setaffinity_np() returned {0}", res);
			return false;
		}
#endif // __USE_GNU

		return true;
	}

	TBit64_t CPThread::getCPUMask()
	{
		uint32 num = sysconf(_SC_NPROCESSORS_CONF);
		cpu_set_t cpuMask;
		CPU_ZERO(&cpuMask);
#ifdef __USE_GNU
		sint32 res = pthread_getaffinity_np(_threadHandle, sizeof(cpu_set_t), &cpuMask);

		if (res)
		{
			gxWarning("pthread_getaffinity_np() returned {0}", res);
			return 0;
		}
#endif // __USE_GNU

		TBit64_t newMask = 0;
		for(uint32 i = 0; i < num; ++i)
		{
			if(CPU_ISSET(i, &cpuMask))
			{
				newMask.set(i);
			}
		}

		return newMask;
	}

	std::string CPThread::getUserName()
	{
		struct passwd *pw = getpwuid(getuid());

		if (!pw)
		{
			return "defaut_gxlib";
		}

		return pw->pw_name;
	}

	IThread* CPThread::getCurrentThread()
	{
		return GetThread(pthread_self());
	}

	IRunnable * CPThread::getRunnable()
	{
		return Runnable;
	}

	// 当前进程
	CPProcess CurrentProcess;

	IProcess *IProcess::GetCurrentProcess ()
	{
		return &CurrentProcess;
	}

	uint32 IProcess::GetCPUNum()
	{
		return sysconf(_SC_NPROCESSORS_CONF);
	}

	TBit64_t CPProcess::getCPUMask()
	{	
		uint32 num = sysconf(_SC_NPROCESSORS_CONF);
		cpu_set_t cpuMask;
		CPU_ZERO(&cpuMask);
#ifdef __USE_GNU
		sint32 res = sched_getaffinity(gxGetPID(), sizeof(cpu_set_t), &cpuMask);

		if (res)
		{
			gxWarning("sched_getaffinity() returned {0}, errno = {1}: {2}", res, errno, strerror(errno));
			return 0;
		}
#endif // __USE_GNU

		TBit64_t newMask = 0;
		for(uint32 i = 0; i < num; ++i)
		{
			if(CPU_ISSET(i, &cpuMask))
			{
				newMask.set(i);
			}
		}

		return newMask;
	}

	bool CPProcess::setCPUMask(TBit64_t newMask)
	{
		cpu_set_t cpuMask;
		CPU_ZERO(&cpuMask);
		uint32 num = sysconf(_SC_NPROCESSORS_CONF);
		for(uint32 i = 0; i < num; ++i)
		{
			if(newMask.get(i))
			{
				CPU_SET(i, &cpuMask);
			}
			else
			{
				CPU_CLR(i, &cpuMask);
			}
		}
#ifdef __USE_GNU
		sint32 res = sched_setaffinity(gxGetPID(), sizeof(cpu_set_t), &cpuMask);
		if (res)
		{
			gxWarning("sched_setaffinity() returned {0}, errno = {1}: {2}", res, errno, strerror(errno));
			return false;
		}
#endif // __USE_GNU

		return true;
	}
}		// GXMISC

#endif	// OS_UNIX
