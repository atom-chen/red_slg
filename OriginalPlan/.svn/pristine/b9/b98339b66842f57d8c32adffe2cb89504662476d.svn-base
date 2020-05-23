#include "lib_init.h"
#include "base_util.h"
#include "debug.h"
#include "logger.h"
#include "debug_control.h"
#include "interface.h"

#ifdef OS_WINDOWS
#include "win_thread.h"
#else
#include "p_thread.h"
#endif

#pragma comment(lib,"ws2_32.lib")

namespace GXMISC
{
	DStaticAssert(sizeof(TSigno_t) == 4);

	static CDebugControl ctrl;
	static bool _SetSocketEvn()
	{
#ifdef OS_WINDOWS
		WORD wVersionRequested;
		WSADATA wsaData;
		int err; 

		wVersionRequested = MAKEWORD(2, 2);

		err = WSAStartup(wVersionRequested,&wsaData);
		if( err != 0)
		{
			printf("socket err = %d", err);
			return false;  
		}
#endif
		return true;
	}
	static void _UnsetSocketEvn()
	{
#ifdef OS_WINDOWS
		WSACleanup();
#endif
	}

	static void _SetThreadEvn(const std::vector<sint32>& cpuFlag)
	{
//		try{
#ifdef OS_WINDOWS
			static CWinThread MainThread ((void*)GetCurrentThread (), GetCurrentThreadId());
#else
			static CPThread MainThread(pthread_self());
#endif
			if(!cpuFlag.empty())
			{
				MainThread.clearCPUMask(cpuFlag.at(0));
			}
			for(uint32 i = 0; i < cpuFlag.size(); ++i)
			{
				MainThread.setRunCPU(cpuFlag.at(i));
			}
// 		}catch(...)
// 		{
// 			gxError("Exception ...");
// 		}
	}

	void CGxContext::setRunCPU( const std::vector<sint32>& cpuFlag )
	{
		_SetThreadEvn(cpuFlag);
	}

	bool CGxContext::init(const std::string& serverName)
	{
		static sint32 initCount = 0;

		if(initCount == 0){
			DStaticAssert(sizeof(char) == 1);
			if(!_SetSocketEvn())
			{
				return false;
			}

			// @notice 日志在debug版本和release版本是不同的, debug版本日志输出加锁保证输出先后顺序, release版本日志输出不能保证先后顺序
#ifndef LIB_DEBUG
			_mainLog = new CLogger();
#else
			_mainLog = new CSafeLog();
#endif
			assert(_mainLog);

			// 初始化逻辑日志
#ifdef LIB_DEBUG

#ifdef OS_WINDOWS
			_mainLog->addDisplayer(new CStdDisplayer(true, serverName.c_str()));
#endif

#endif
			_mainLog->addDisplayer(new CFileDisplayer(true, serverName.c_str()));

			_mainThreadID = gxGetThreadID();

			setFastLogThread(_mainThreadID);
			setServerName(serverName);
			gxSetDumpHandler();
#ifdef OS_WINDOWS
			setStopSigno();
#else
			setStopSigno(10);
#endif
			_dumpHandler = NULL;
		}

		initCount++;

		return true;
	}

    void CGxContext::clear()
    {
        DSafeDelete(_mainLog);
    }

    CLogger* CGxContext::getMainLog()
    {
        return _mainLog;
    }

    GXMISC::TThreadID_t CGxContext::getMainThread()
    {
        return _mainThreadID;
    }

    void CGxContext::setFastLogThread( TThreadID_t threadID )
    {
        _fastLogThread = threadID;
    }

    GXMISC::TThreadID_t CGxContext::getFastLogThread()
    {
        return _fastLogThread;
    }

    const std::string& CGxContext::getServerName()
    {
        return _serverName;
    }

    void CGxContext::setServerName( const std::string& serverName )
    {
        _serverName = serverName;
        _mainLog->SetProcessName(_serverName);
    }

    void CGxContext::setStopHandler( GXMISC::IStopHandler* stopHandler )
    {
        _stopHandler = stopHandler;
    }

    void CGxContext::StopService(sint32 signo)
    {
        gxWarning("Stop signo = {0}", signo);
        IStopHandler* stopHandler = GetInstance().getStopHandler();
        if(stopHandler)
        {
            stopHandler->setStop();
        }
    }

    GXMISC::IStopHandler* CGxContext::getStopHandler()
    {
        return _stopHandler;
    }

    void CGxContext::GetStack(std::string& str)
    {
        gxGetCallStack(str, 0);
    }

    void CGxContext::update( uint32 diff )
    {
        _mainLog->update(diff);
    }

	CGxContext::CGxContext(const std::string& serverName) : CManualSingleton<CGxContext>()
	{
		_stopSigno = 255;
		_stopHandler = NULL;
		_dumpHandler = NULL;
		_mainLog = NULL;
		_mainThreadID = 0;
		_fastLogThread = 0;

		_serverName = serverName;
	}
    CGxContext::~CGxContext()
    {
        DSafeDelete(_mainLog);
        _UnsetSocketEvn();
    }

    void CGxContext::exitCallback( EExitCode code )
    {
        _mainLog->flush();
    }
	
    void CGxContext::setStopSigno( TSigno_t sig )
    {
        _stopSigno = sig;
        ::signal(sig, StopService);
    }

    TSigno_t CGxContext::getStopSigno()
    {
        return _stopSigno;
    }

	void CGxContext::callOnCrash( const std::string& dumpName )
	{
		gxError("Call dump back!");
		if(NULL != _dumpHandler)
		{
			_dumpHandler->onDump(dumpName);
		}
	}

	void CGxContext::setDumpHandler( GXMISC::IDumpHandler* dumpHandler )
	{
		_dumpHandler = dumpHandler;
	}
}