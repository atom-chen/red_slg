#ifndef WIN_THREAD_H
#define WIN_THREAD_H

#include "types_def.h"
#include "thread.h"
#include "bit_set.h"

#ifdef OS_WINDOWS

namespace GXMISC
{
    /**
    * @brief window下的线程实现类
    */
    class CWinThread : public IThread
    {
    public:
        CWinThread(IRunnable *runnable, uint32 stackSize);
        CWinThread (void* threadHandle, uint32 threadId);	///<@ brief 不要使用这个构造函数, 仅在初始化主线程的时候使用
        virtual ~CWinThread();

	public:
		// 启动
        virtual bool start();
		// 是否运行
        virtual bool isRunning();
		// 结束线程
        virtual void terminate();
		// 等待退出
        virtual void wait();
		// 设置CPU掩码
        virtual bool setCPUMask(TBit64_t cpuMask);
		// 获取CPU掩码
        virtual TBit64_t getCPUMask();
		// 获取用户名
        virtual std::string getUserName();
		// 获取运行对象
        virtual IRunnable *getRunnable();

        // 仅在win32下使用
    public:
        /**
        * @brief 获取暂停次数. 
        * @return -1表示线程暂时未启动
        */
		sint32 getSuspendCount() const;
        // 增加暂停次数, 暂停次数大于1表示线程已经暂停
        sint32 incSuspendCount();
        /**
        * @brief 减少暂停次数.
        *        当次数为0时会唤醒线程.
        *        当暂停次数为0时会抛出断言
        */
        sint32 decSuspendCount();
        // 暂停当前线程, 如果已经暂停没有任何影响
        void suspend();
        // 恢复线程运行, 
        void resume();
        // 设置优先级
        void setPriority(int priority);
        // 是否允许系统动态提高当前线程的优先级
        void enablePriorityBoost(bool enabled);

    private:
        IRunnable	*_runnable;				///<@brief 可执行对象

    private:
        sint32		_suspendCount;			///<@brief 暂停次数
        uint32		_stackSize;				///<@brief 堆栈大小
        void		*_threadHandle;			///<@brief 线程句柄,避免包含windows.h头文件
        TThreadID_t	_threadId;				///<@brief 线程ID,避免包含windows.h头文件
        bool		_mainThread;			///<@brief true表示主线程
    };
    
    /**
    * @brief windows 进程处理
    */
    class CWinProcess : public IProcess
    {
    public:
        CWinProcess (void *handle);
        virtual ~CWinProcess() {}

    public:
        /// 获取CPU掩码
        virtual TBit64_t getCPUMask();
		/// 设置CPU掩码
        virtual bool setCPUMask(TBit64_t mask);

    public:
        /// 枚举所有进程ID
        static bool   EnumProcessesId(std::vector<uint32> &processesId);
        /// 获取当前进程涉及的模块名称
        static bool	  EnumProcessModules(uint32 processId, std::vector<std::string> &moduleNames);
        /// 通过模块名获取进程ID
        static uint32 GetProcessIdFromModuleFilename(const std::string &moduleFileName);
        /// 根据进程ID终止进程
        static bool	  TerminateProcess(uint32 processId, uint32 exitCode = 0);
        /// 根据模块名终止进程
        static bool	  TerminateProcessFromModuleName(const std::string &moduleName, uint32 exitCode = 0);

    private:
        void	*_processHandle;
    };

} // GXMISC

#endif // OS_WINDOWS

#endif // WIN_THREAD_H
