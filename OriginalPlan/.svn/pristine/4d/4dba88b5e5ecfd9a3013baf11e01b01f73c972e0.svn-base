#ifndef MUTEX_H
#define MUTEX_H

#include "types_def.h"

// @TODO 重新整理

#ifdef OS_WINDOWS
#	include <intrin.h>
#elif defined(OS_UNIX)
#	include <pthread.h>	
#	include <semaphore.h>
#	include <unistd.h>
#	define __forceinline
#endif // OS_WINDOWS

namespace GXMISC 
{
	/**
	* @brief 这个define必须禁止掉, 当一个mutex在多个进程之间共享时可能会出现问题;
	*        因为多个进程会有不同的调试模式(因为当__STL_DEBUG被开启, sizeof(string)是普通字符串的2倍)
	*/
#define STORE_MUTEX_NAME

#ifdef OS_WINDOWS
	// 在windows上, 所有mutex/synchronization使用CFair*类, 避免释放问题
#	define CMutex			CFairMutex
#	define CSynchronized	CFairSynchronized
#else
	// 在GNU/Linux上, 我们使用CUnfair*避免死锁问题
#	define CMutex			CUnfairMutex
#	define CSynchronized	CUnfairSynchronized
#endif

    /**
     * @brief 锁类
     */
    class ILockable
    {
    public:
        virtual void enter() = 0;
        virtual void leave() = 0;
    };

    class CEmptyLock : ILockable
    {
    public:
        virtual void enter(){}
        virtual void leave(){}
    };

	/**
	* @brief mutex类实现(一定不会失败)
	*        不要认为mutex会可递归(即对同一个mutex在同一个进程不能连续调用enter()多次而没有调用对应的leave())
	*        同样也不要认为线程会按照sleep的顺序醒过来
	* Windows: 使用Mutex, 不能在多个进程之间共享
	* Linux:   使用PThread POSIX Mutex, 不能在多个进程之间共享
	*\code
	CUnfairMutex m;
	m.enter ();
	// do critical stuffs
	m.leave ();
	*\endcode
	*/
	class CUnfairMutex
	{
	public:
		CUnfairMutex();
		CUnfairMutex( const std::string &name );

		~CUnfairMutex();

	public:
		void	enter ();
		void	leave ();

	private:
#ifdef OS_WINDOWS
		void *          _mutex;
#elif defined OS_UNIX
		pthread_mutex_t _mutex;
#else
#	error "No unfair mutex implementation for this OS"
#endif

	};

#ifdef OS_WINDOWS
#pragma managed(push, off)
#endif

	class CFastLock
	{
	public:
		enum LockState
		{
			LOCK_STATE_UNLOCK = 0,
			LOCK_STATE_LOCK = 1,
		};
	public:
		// 快锁类型
		typedef volatile uint32 Lock_t;

	public:
		static bool isLocked(Lock_t& lockVar);
		static bool tryLock(Lock_t& lockVar);
		static void unlock(Lock_t& lockVar);
        static void Increase(Lock_t& lockVar, sint32 val);
        static void Descrease(Lock_t& lockVar, sint32 val);
		static void Set(Lock_t& lockVar, sint32 val);
	};

#ifdef OS_WINDOWS
	// 避免包含<windows.h>
	struct SGxRtlCriticalSection
	{
		void	*DebugInfo;
		long	 LockCount;
		long	 RecursionCount;
		void	*OwningThread;
		void	*LockSemaphore;
		uint32	 SpinCount;
	};
#endif // OS_WINDOWS


	/**
	* Windows: 使用关键区, 不能在进程之间共享
	* Linux: 使用信号量, 不能在进程之间共享
	* 
	*\code
	CUnfairMutex m;
	m.enter ();
	// do critical stuffs
	m.leave ();
	*\endcode
	*
	*\code
	CFairMutex m;
	m.enter ();
	// do critical stuffs
	m.leave ();
	*\endcode
	*/
	class CFairMutex
	{
	public:

		CFairMutex();
		CFairMutex(const std::string &name);

		~CFairMutex();

		void enter ();
		void leave ();

#ifdef STORE_MUTEX_NAME
		std::string Name;
#endif

	private:

#ifdef OS_WINDOWS
		SGxRtlCriticalSection	_cs;
#elif defined OS_UNIX
		sem_t					_sem;
#else
#	error "No fair mutex implementation for this OS"
#endif

	};

	template <class T>
	class CUnfairSynchronized
	{
	public:

		CUnfairSynchronized (const std::string &name) : _mutex(name) { }
		class CAccessor
		{
			CUnfairSynchronized<T> *Synchronized;
		public:

			CAccessor(CUnfairSynchronized<T> *cs)
			{
				Synchronized = cs;
				const_cast<CMutex&>(Synchronized->_mutex).enter();
			}
			~CAccessor()
			{
				const_cast<CMutex&>(Synchronized->_mutex).leave();
			}
			T &value()
			{
				return const_cast<T&>(Synchronized->_value);
			}
		};

	private:

		friend class CUnfairSynchronized::CAccessor;
		volatile CUnfairMutex	_mutex;
		volatile T				_value;
	};

	template <class T>
	class CFairSynchronized
	{
	public:

		CFairSynchronized (const std::string &name) : _cs(name) { }
		class CAccessor
		{
			CFairSynchronized<T> *Synchronized;
		public:
			CAccessor(CFairSynchronized<T> *cs)
			{
				Synchronized = cs;
				const_cast<CFairMutex&>(Synchronized->_cs).enter();
			}
			~CAccessor()
			{
				const_cast<CFairMutex&>(Synchronized->_cs).leave();
			}
			T &value()
			{
				return const_cast<T&>(Synchronized->_value);
			}
		};

	private:

		friend class CFairSynchronized::CAccessor;
		volatile CFairMutex	_cs;
		volatile T			_value;
	};

	template <class TMutex=CMutex>
	class CAutoMutex
	{
		TMutex	&_mutex;

		CAutoMutex(const CAutoMutex &other)
		{
		}

		CAutoMutex &operator = (const CAutoMutex &other)
		{
			return *this;
		}

	public:
		CAutoMutex(TMutex &mutex)
			:	_mutex(mutex)
		{
			_mutex.enter();
		}

		~CAutoMutex()
		{
			_mutex.leave();
		}

	};

}	// GXMISC



/*
 * linux sync 函数
 *
 * type __sync_fetch_and_add (type *ptr, type value, ...)
 * type __sync_fetch_and_sub (type *ptr, type value, ...)
 * type __sync_fetch_and_or (type *ptr, type value, ...)
 * type __sync_fetch_and_and (type *ptr, type value, ...)
 * type __sync_fetch_and_xor (type *ptr, type value, ...)
 * type __sync_fetch_and_nand (type *ptr, type value, ...)
 *
 *
 * type __sync_add_and_fetch (type *ptr, type value, ...)
 * type __sync_sub_and_fetch (type *ptr, type value, ...)
 * type __sync_or_and_fetch (type *ptr, type value, ...)
 * type __sync_and_and_fetch (type *ptr, type value, ...)
 * type __sync_xor_and_fetch (type *ptr, type value, ...)
 * type __sync_nand_and_fetch (type *ptr, type value, ...)
 *
 * 这两组函数的区别在于第一组返回更新前的值，第二组返回更新后的值。
 *
 * type __sync_lock_test_and_set (type *ptr, type value, ...)
 * 将*ptr设为value并返回*ptr操作之前的值。
 *
 * void __sync_lock_release (type *ptr, ...)
 * 将*ptr置0
 *
 * bool __sync_bool_compare_and_swap (type *ptr, type oldval type newval, ...)
 * type __sync_val_compare_and_swap (type *ptr, type oldval type newval, ...)
 * 这两个函数提供原子的比较和交换，如果*ptr == oldval,就将newval写入*ptr,
 * 第一个函数在相等并写入的情况下返回true.
 * 第二个函数在返回操作之前的值。
 */



#endif // MUTEX_H
