#ifndef _INTERFACE_H_
#define _INTERFACE_H_

#include "types_def.h"
#include "base_util.h"
#include "mutex.h"
#include "lookaside_allocator.h"

// 把所有的接口全部移动到这个文件
namespace GXMISC
{
	class IStopHandler
	{
	public:
		IStopHandler(){ _isDone = true; }
		virtual ~IStopHandler(){}

	public:
		virtual void onStop(){}

	public:
		void setStop() { _isDone = true; }
		void setStart(){ _isDone = false; }
		bool isStop() { return _isDone; }
	protected:
		bool    _isDone;
	};

    class IRunnable : public IStopHandler
    {
	protected:
        IRunnable()
		{
			cleanUp(); 
		}
	public:
        virtual ~IRunnable(){}

    public:
        virtual void run()=0;

    public:
		void cleanUp()
		{
			_threadID = INVALID_THREAD_ID;
			_objectName = "NoName";
			_exitRunFlag = false;
		}
		virtual const std::string getName()const
        {
            return _objectName;
        }
        void setName(const std::string& name)
        {
            _objectName = name;
        }
        void setThreadID(TThreadID_t tid)
        {
            _threadID = tid;
        }
        TThreadID_t getThreadID() const
        {
            return _threadID;
        }
		void setExitRun()
		{
			_exitRunFlag = true;
		}
		bool isExitRun()
		{
			return _exitRunFlag;
		}
    protected:
		TThreadID_t _threadID;                  // 当前运行线程
		std::string _objectName;				// 对象名字
		bool _exitRunFlag;						// 退出运行标记
    };

    class IAllocatable
    {
    protected:
        IAllocatable(){}
	public:
        virtual ~IAllocatable(){}

    public:
        template<typename Arg>
        Arg* allocArg()
        {
            return (Arg*)_blockAllocator.alloc(sizeof(Arg));
        }
        char* allocArg(uint32 size);
        void freeArg(char* arg);

    protected:
        CSimpleAllocator        _blockAllocator;          // 内存池
    };

    class ISyncable : public IRunnable
    {
    protected:
        ISyncable() : IRunnable()
        {
            cleanUp();
            //_lockVar = CFastLock::LOCK_STATE_UNLOCK;
            //CFastLock::unlock(_lockVar);
        }
	public:
        virtual ~ISyncable()
        {
            CFastLock::unlock(_lockVar);
        }
    public:
		void cleanUp()
		{
			IRunnable::cleanUp();
			_lockVar = CFastLock::LOCK_STATE_UNLOCK;
			//CFastLock::unlock(_lockVar);
		}
		
		// 使用后事件(释放内存等操作)
        virtual void doAfterUsed() = 0;
		// 重置操作
        //virtual void reset(){}; // @TODO 查找使用方式

        // @notice 这两个函数对数据库操作有用, 对网络底层性能影响很大
        // 可以做一些初始化操作
        virtual void doBeforeToQueueue(){};
        // 可以做一些统计操作及日志记录操作
		// 注意只能做一些测试用途, 这里在发布模式下不会执行
        virtual void doAfterFromQueue(){};

    public:
        // 检测是否可以释放
        bool canFree();
        // 设置可以释放
        void setFreed();
        // 设置已经被使用
        void setUsed();

    protected:
        CFastLock::Lock_t   _lockVar;		// 原子锁变量
    };

    // @todo 将IPacketHandler, CSocketHandler改成从这里继承
    class IFreeable
    {
    protected:
        IFreeable()
        {
            _needFree = false;
        }
	public:
        virtual ~IFreeable()
        {
        }

    public:
        void setNeedFree()
        {
            _needFree = true;
        }
        bool isNeedFree()
        {
            return _needFree;
        }
    private:
        bool _needFree;
    };

	class IDumpHandler
	{
	public:
		IDumpHandler(){}
		virtual ~IDumpHandler(){}
	public:
		virtual void onDump(const std::string& dumpName) {}
	};

	class ISimpleNoncopyable
	{
	public:
		ISimpleNoncopyable() {};
		virtual ~ISimpleNoncopyable() {};
	private:
		ISimpleNoncopyable(const ISimpleNoncopyable&);
		const ISimpleNoncopyable & operator= (const ISimpleNoncopyable &);

	};

	class INoncopyable
	{
	protected:
		INoncopyable() {};
	public:
		virtual ~INoncopyable() {};
	private:
		INoncopyable(const INoncopyable&);
		const INoncopyable & operator= (const INoncopyable &);

	};
}

#endif