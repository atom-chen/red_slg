#ifndef _LIB_INIT_H_
#define _LIB_INIT_H_

#include <string>
#include <iostream>

#include "singleton.h"
#include "base_util.h"
#include "common.h"
#include "time_manager.h"

// @todo 添加枚举对应的字符串
enum EExitCode
{
	EXIT_CODE_NORMAL = 0,
	EXIT_CODE_CRASH,
	EXIT_CODE_LOG_ERREX,
	EXIT_CORE_BREAKPOINT
};

// @TODO 所有单例全部放置到一起处理
namespace GXMISC
{
    class IStopHandler;
    class CLogger;
	class IDumpHandler;
    class CGxContext : public CManualSingleton<CGxContext>
    {
    public:
		CGxContext(const std::string& serverName);
        ~CGxContext();

    public:
        bool init(const std::string& serverName);    
        void clear();
        void update(uint32 diff);

    public:
        CLogger*            getMainLog();
        TThreadID_t         getMainThread();
        void                setFastLogThread(TThreadID_t threadID);
        TThreadID_t         getFastLogThread();
        const std::string&  getServerName();
        void                setServerName(const std::string& serverName);
        void                setStopHandler(GXMISC::IStopHandler* stopHandler);
        IStopHandler*       getStopHandler();
        void                exitCallback(EExitCode code);
        void                setStopSigno(TSigno_t sig = SIGKILL);
        TSigno_t            getStopSigno();
		void				setRunCPU(const std::vector<sint32>& cpuFlag);
		void				callOnCrash(const std::string& dumpName);
		void				setDumpHandler(GXMISC::IDumpHandler* dumpHandler);
    public:
        static void         StopService(sint32 signo = SIGKILL);
        static void         GetStack(std::string& str);

    private:
        TSigno_t        _stopSigno;                 // 停止信号
        IStopHandler*   _stopHandler;               // 停止句柄
		IDumpHandler*	_dumpHandler;				// Dump处理句柄
        std::string     _serverName;                // 服务名字
        CLogger*        _mainLog;                   // 日志
        TThreadID_t     _mainThreadID;              // 主线程ID
        TThreadID_t     _fastLogThread;             // 用于快速写入日志的线程, 此线程下需要记录日志的操作均是不用加锁的速度比较快, 多用于游戏主逻辑
                                                    // 其他线程的话则需要线程安全的加锁操作, 速度比较慢, 且日志记录不是即时记录的, 多用于多线程网络模块,多线程数据库模块
    };

#define DGxContext      GXMISC::CGxContext::GetInstance()
#define DMainLog        DGxContext.getMainLog()
#define DStopHandler    DGxContext.getStopHandler()
#define DServiceName    DGxContext.getServerName()
#define DStopService    DGxContext.StopService(DGxContext.getStopSigno())
}

#endif