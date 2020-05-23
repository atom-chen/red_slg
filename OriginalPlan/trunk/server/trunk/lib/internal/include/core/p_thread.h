#ifndef P_THREAD_H
#define P_THREAD_H

#ifdef OS_UNIX

#include "types_def.h"
#include "thread.h"
#include <pthread.h>


namespace GXMISC 
{
	/**
	* @brief linux线程处理
	*/
	class CPThread : public IThread
	{
	public:
		static IThread* getCurrentThread();

	public:
		CPThread( IRunnable *runnable, uint32 stackSize);
		CPThread( TThreadID_t key);
		virtual ~CPThread();

	public:
		virtual bool start();
		virtual bool isRunning();
		virtual void terminate();
		virtual void wait();
		virtual bool setCPUMask(TBit64_t cpuMask);
		virtual TBit64_t getCPUMask();
		virtual std::string getUserName();
		virtual IRunnable *getRunnable();

	private:
		IRunnable	*Runnable;
        
	private:
		uint8			_state;						///<@brief 0=not created, 1=started, 2=finished
		uint32			_stackSize;					///<@brief 堆栈大小
		TThreadID_t		_threadHandle;				///<@brief 线程句柄
	};

	/**
	* @brief linux线程
	*/
	class CPProcess : public IProcess
	{
	public:
		virtual ~CPProcess() {}
		virtual TBit64_t getCPUMask();
		virtual bool setCPUMask(TBit64_t mask);
	};

} // GXMISC


#endif // OS_UNIX

#endif // P_THREAD_H
