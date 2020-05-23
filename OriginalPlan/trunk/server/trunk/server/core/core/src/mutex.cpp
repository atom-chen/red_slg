#include "stdcore.h"

#include "mutex.h"
#include "time_gx.h"
#include "debug.h"
#include "types_def.h"
using namespace std;

#ifdef OS_WINDOWS

#define _WIN32_WINDOWS	0x0410
#define WINVER			0x0400



namespace GXMISC
{
	inline void EnterMutex( void *handle )
	{
#ifdef LIB_DEBUG
		DWORD timeout;
		if ( IsDebuggerPresent() )
			timeout = INFINITE;
		else
			timeout = 10000;

		DWORD dwWaitResult = WaitForSingleObject (handle, timeout);
#else
		DWORD dwWaitResult = WaitForSingleObject (handle, 10000);
#endif 
		switch (dwWaitResult)
		{
		case WAIT_OBJECT_0:		break;
		case WAIT_TIMEOUT:		;gxError ("Dead lock in a mutex (or more that 10s for the critical section");
		case WAIT_ABANDONED:	;gxError ("A thread forgot to release the mutex");
		default:				;gxError ("EnterMutex failed");
		}
	}


	inline void LeaveMutex( void *handle )
	{
		if (ReleaseMutex(handle) == 0)
		{
			uint32 errNum = GetLastError();
			gxError ("error while releasing the mutex (0x{0}), {1}", errNum, (uint32)handle);
		}
	}

	CUnfairMutex::CUnfairMutex()
	{
		_mutex = (void *) CreateMutex( NULL, FALSE, NULL );
		gxAssert( _mutex != NULL );
	}


	CUnfairMutex::CUnfairMutex( const std::string & /* name */ )
	{
		_mutex = (void *) CreateMutex( NULL, FALSE, NULL );
		gxAssert( _mutex != NULL );

		// 不使用名字, 仅是为了在调试模式下兼容CFairMutex
	}

	CUnfairMutex::~CUnfairMutex()
	{
		CloseHandle( _mutex );
	}

	void CUnfairMutex::enter()
	{
		EnterMutex( _mutex );
	}

	void CUnfairMutex::leave()
	{
		LeaveMutex( _mutex );
	}

    /////////////////////////// CFairMutex
	CFairMutex::CFairMutex()
	{
#ifdef STORE_MUTEX_NAME
		Name = "unset mutex name";
#endif

		gxAssert( sizeof(SGxRtlCriticalSection)==sizeof(CRITICAL_SECTION) );

#if (_WIN32_WINNT >= 0x0500)
		DWORD dwSpinCount = 0x80000000;
		if ( ! InitializeCriticalSectionAndSpinCount( (CRITICAL_SECTION*)&_cs, dwSpinCount ) )
		{
			gxError( "Error entering critical section" );
		}
#else
		InitializeCriticalSection( (CRITICAL_SECTION*)&_cs );
#endif
	}

	CFairMutex::CFairMutex(const string &name)
	{
#ifdef STORE_MUTEX_NAME
		Name = name;
#endif

		gxAssert( sizeof(SGxRtlCriticalSection)==sizeof(CRITICAL_SECTION) );

#if (_WIN32_WINNT >= 0x0500)
		DWORD dwSpinCount = 0x80000000;
		if ( ! InitializeCriticalSectionAndSpinCount( (CRITICAL_SECTION*)&_cs, dwSpinCount ) )
		{
			gxError( "Error entering critical section" );
		}
#else
		InitializeCriticalSection( (CRITICAL_SECTION*)&_cs );
#endif
	}

	CFairMutex::~CFairMutex()
	{
		DeleteCriticalSection( (CRITICAL_SECTION*)&_cs );
	}

	void CFairMutex::enter()
	{
		EnterCriticalSection( (CRITICAL_SECTION*)&_cs );
	}

	void CFairMutex::leave()
	{
		LeaveCriticalSection( (CRITICAL_SECTION*)&_cs );
	}

#elif defined OS_UNIX

#include <pthread.h>
#include <cerrno>
#include <unistd.h>

#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h> 

extern "C"
{
	int pthread_mutexattr_setkind_np( pthread_mutexattr_t *attr, int kind );
}

namespace GXMISC
{
	CUnfairMutex::CUnfairMutex()
	{
		pthread_mutexattr_t attr;
		pthread_mutexattr_init( &attr );
		pthread_mutexattr_settype( &attr, PTHREAD_MUTEX_RECURSIVE );
		pthread_mutex_init( &_mutex, &attr );
		pthread_mutexattr_destroy( &attr );
	}

	CUnfairMutex::CUnfairMutex(const std::string &name)
	{
		pthread_mutexattr_t attr;
		pthread_mutexattr_init( &attr );
		pthread_mutexattr_settype( &attr, PTHREAD_MUTEX_RECURSIVE );
		pthread_mutex_init( &_mutex, &attr );
		pthread_mutexattr_destroy( &attr );
	}

	CUnfairMutex::~CUnfairMutex()
	{
		pthread_mutex_destroy( &_mutex );
	}

	void CUnfairMutex::enter()
	{
		if ( pthread_mutex_lock( &_mutex ) != 0 )
		{
			gxError( "Error locking a mutex" );
		}
	}

	void CUnfairMutex::leave()
	{
		if ( (pthread_mutex_unlock( &_mutex )) != 0 )
		{
			gxError( "Error unlocking a mutex" );
		}
	}

	CFairMutex::CFairMutex()
	{
		sem_init( const_cast<sem_t*>(&_sem), 0, 1 );
	}


	CFairMutex::CFairMutex(	const std::string &name )
	{
		sem_init( const_cast<sem_t*>(&_sem), 0, 1 );
	}

	CFairMutex::~CFairMutex()
	{
		sem_destroy( const_cast<sem_t*>(&_sem) );
	}

	void CFairMutex::enter()
	{
		sem_wait( const_cast<sem_t*>(&_sem) );
	}

	void CFairMutex::leave()
	{
		sem_post( const_cast<sem_t*>(&_sem) );
	}

#endif // OS_WINDOWS/OS_UNIX

    bool CFastLock::isLocked(Lock_t& lockVar)
    {
        return lockVar == LOCK_STATE_LOCK;
    }

    void CFastLock::unlock(Lock_t& lockVar)
    {
        lockVar = LOCK_STATE_UNLOCK;
    }

    bool CFastLock::tryLock(Lock_t& lockVar)
    {
        uint32 result = 0;
#ifdef OS_WINDOWS
        result = InterlockedCompareExchange(reinterpret_cast<volatile long *>(&lockVar), LOCK_STATE_LOCK, LOCK_STATE_UNLOCK);
#elif defined(OS_UNIX)
        result = __sync_val_compare_and_swap(&lockVar, LOCK_STATE_UNLOCK, LOCK_STATE_LOCK);
#endif	// OS_WINDOWS

        return result == LOCK_STATE_UNLOCK;
    }

    void CFastLock::Increase( Lock_t& lockVar, sint32 val )
    {
#ifdef OS_WINDOWS
        InterlockedExchangeAdd((volatile long*)&lockVar, val);
#elif defined(OS_UNIX)
        __sync_add_and_fetch(&lockVar, val);
#endif
    }

    void CFastLock::Descrease(Lock_t& lockVar, sint32 val)
    {
#ifdef OS_WINDOWS
        InterlockedExchangeAdd((volatile long*)&lockVar, 0-val);
#elif defined(OS_UNIX)
        __sync_sub_and_fetch(&lockVar, val);
#endif
    }

	void CFastLock::Set( Lock_t& lockVar, sint32 val )
	{
#ifdef OS_WINDOWS
		InterlockedExchange((volatile long*)&lockVar, val);
#elif defined(OS_UNIX)
		__sync_lock_test_and_set(&lockVar, val);
#endif
	}


} // GXMISC
