#include "service.h"
#include "time_manager.h"
#include "service_profile.h"
#include "debug_control.h"
#include "lib_config.h"
#include "game_exception.h"
#include "inifile.h"
#include "file_system_util.h"

namespace GXMISC
{
	GxService* g_LibService = NULL;
	CGxServiceConfig::CGxServiceConfig( const std::string& moduleName /*= "GxService"*/ ) : IModuleConfig(moduleName)
	{
	}

	CGxServiceConfig::~CGxServiceConfig()
	{
	}

	void CGxServiceConfig::loadProfile()
	{
	}

	bool CGxServiceConfig::onLoadConfig( const CConfigMap* configs )
	{
		if (!TBaseType::onLoadConfig(configs))
		{
			return false;
		}

		return true;
	}
	CNetModule* GxService::getNetMgr()
	{
		return &_netWrapMgr;
	}

	CDatabaseConnMgr* GxService::getDbMgr()
	{
		return &_dbConnMgr;
	}

	CNetBroadcastModule* GxService::getNetBroadcast()
	{
		return &_netBroadcast;
	}

	GxService::GxService(CGxServiceConfig* config, const std::string& serverName)
		: IServiceModule(config), _gxServiceConfig(config), _context(serverName)
	{
		_totalLoopCount = 0;
		_maxLoopCount = 0;
		_curLoopCount = 0;
		_startTime = 0;
		_lastLoopProfileTime = 0;
		_curTime = 0;
		_lastReadProfileVarTime = 0;
		_netWrapMgr.setService(this);
		_dbConnMgr.setService(this);
		_netBroadcast.setService(this);
		_serverTaskMgr.setService(this);
		g_LibService = this;
		_scriptEngine = NULL;
	}

	GxService::~GxService()
	{

	}

	bool GxService::doLoop(TDiffTime_t diff)
	{
		TBaseType::doLoop(diff);

		if(false == _netWrapMgr.loop(diff))
		{
			return false;
		}

		if (false == _dbConnMgr.loop(diff))
		{
			return false;
		}

		if (false == _netBroadcast.loop(diff))
		{
			return false;
		}

		if (false == _serverTaskMgr.loop(diff))
		{
			return false;
		}

		_taskQue.update(diff);

		DGxContext.update(diff);

		return true;
	}

	void GxService::addTimer( CIntervalTimer* timer, bool isNeedFree /* = true */ )
	{
		DIntervalTimerMgr.addTimer(timer, isNeedFree);
	}

	void GxService::waitQuit(sint32 waitSecs)
	{
		uint32 sleepPerCount = 100;
		uint32 count = (waitSecs * 1000) / sleepPerCount;

		sint32 stopCount = 0;

		for (uint32 i = 0; i < count; ++i)
		{
			stopCount = 0;
			
			if (_netWrapMgr.checkAllLoopStop())
			{
				stopCount++;
			}

			if (_dbConnMgr.checkAllLoopStop())
			{
				stopCount++;
			}

			if (_netBroadcast.checkAllLoopStop())
			{
				stopCount++;
			}

			if (_serverTaskMgr.checkAllLoopStop())
			{
				stopCount++;
			}

			if (stopCount == 4)
			{
				break;
			}

			gxSleep(sleepPerCount);
		}

		if (stopCount != 4)
		{
			// 未全部关闭，等待一段额外时间, 然后彻底退出
			gxError("Cant stop all module!!!");
		}
	}

	void GxService::cleanUp()
	{
		gxInfo("=============================Stop service!=============================");

		// @todo Service还做循环, 以便关闭底层的时候可以输出日志, 等底层关闭的时候才退出循环 stopLoop()
		_netWrapMgr.cleanUp();

		_dbConnMgr.cleanUp();

		_netBroadcast.cleanUp();

		_serverTaskMgr.cleanUp();
	}

	void GxService::onStop()
	{
		_netWrapMgr.onStop();

		_dbConnMgr.onStop();

		_netBroadcast.onStop();

		_serverTaskMgr.onStop();

		waitQuit(30);
	}

	bool GxService::init()
	{
		if ( !onBeforeInit() )
		{
			return false;
		}

		if (!_dbConnMgr.init())
		{
			return false;
		}

		static sint32 initCount = 0;
		if(_gxServiceConfig->_moduleName.empty() && initCount == 0)
		{
			return true;
		}

		if (initCount == 0)
		{
			if (!_netWrapMgr.init())
			{
				return false;
			}

			if (!_netBroadcast.init())
			{
				return false;
			}

			if (!_serverTaskMgr.init())
			{
				return false;
			}
		}

		initCount++;

		if( !onAfterInit() )
		{
			return false;
		}

		gxInfo("init success!");

		return true;
	}

	bool GxService::start()
	{
		if (!TBaseType::start())
		{
			return false;
		}
		if (false == onBeforeStart())
		{
			return false;
		}

		THREAD_TRY;

		if (!_dbConnMgr.start())
		{
			return false;
		}

		if (!_netWrapMgr.start())
		{
			return false;
		}

		if (!_netBroadcast.start())
		{
			return false;
		}

		if (!_serverTaskMgr.start())
		{
			return false;
		}

		if(false == onAfterStart())
		{
			return false;
		}

		if (!initLoop())
		{
			return false;
		}

		gxLog(false, DMainLog, GXMISC::CLogger::LOG_INFO, 
			__LINE__, __FILE__,  __FUNCTION__, "SERVICE;", "start success!");

		return true;

		THREAD_CATCH ;

		return false;
	}

	void GxService::setStopSigno( sint32 signo )
	{
		::signal(signo, CGxContext::StopService);
	}

	bool GxService::_addConnector( const char* hosts, TPort_t port, uint32 diff, CSocketConnector* connector, bool blockFlag )
	{
		if(blockFlag){
			return _blockConnect(hosts, port, diff, connector);
		}else{
			return _asynConnect(hosts, port, diff, connector);
		}
	}

	void GxService::closeSocket( TUniqueIndex_t index, sint32 waitSecs )
	{
		gxDebug("Close socket! Index = {0}", index);
		_netWrapMgr.closeSocket(index, waitSecs);
	}

	bool GxService::setSystemEnvironment()
	{
		_g_LibConfig.init();
		DGxContext.init(getServiceName());
		DGxContext.setStopHandler(this);
		DGxContext.setFastLogThread(gxGetThreadID());
		DGxContext.setServerName(_gxServiceConfig->_moduleName);
		DGxContext.setStopSigno(SIGINT);

		if (!_mainScriptName.empty())
		{
			if (!_scriptEngine->initScript(_mainScriptName.c_str()))
			{
				gxError("Can't init main script!!!");
				return false;
			}
		}
		_scriptObject.setScriptHandleClassName(_newServiceFunctionName);
		if (!_scriptObject.initScript(_scriptEngine, this))
		{
			gxError("Can't init server script handler!!!");
			return false;
		}

		return onSystemEnvironment();
	}

	bool GxService::onLoadConfig(const CConfigMap* configs)
	{
		if (!TBaseType::onLoadConfig(configs))
		{
			return false;
		}

		if (false == _netWrapMgr.onLoadConfig(&_configMap))
		{
			return false;
		}

		if (false == _dbConnMgr.onLoadConfig(&_configMap))
		{
			return false;
		}

		if (false == _netBroadcast.onLoadConfig(&_configMap))
		{
			return false;
		}

		if (false == _serverTaskMgr.onLoadConfig(&_configMap))
		{
			return false;
		}

		_context.setRunCPU(_gxServiceConfig->getRunCPUFlag());

		return true;
	}

	bool GxService::onLoad(const std::string& inData, std::string& outData)
	{
		outData = inData;
		return true;
	}

	bool GxService::load( const std::string& configName )
	{
		if (configName.empty())
		{
			return false;
		}

		if(!onBeforeLoad())
		{
			return false;
		}

		TConfigMap configs;
		configs = loadByFileName(configName);
		_configMap.setConfigs(&configs);

		if (!onLoadConfig(&_configMap))
		{
			return false;
		}

		if(!onAfterLoad())
		{
			return false;
		}

		gxInfo("load config success!");

		return true;
	}

	bool GxService::addLoad(const std::string& configBuff)
	{
		TConfigMap configs;
		//configs = loadByFileData(configBuff);
		configs = loadByFileName(configBuff);
		_configMap.setConfigs(&configs);

		if (!onLoadConfig(&_configMap))
		{
			return false;
		}

		return true;
	}

	std::string GxService::getModuleName() const
	{
		return _gxServiceConfig->getModuleName();
	}

	void GxService::_genName()
	{
		_strLoopProfile = gxToString("MainService: TotalLoopCount=%"I64_FMT"u, CurrentLoopCount=%u,MaxLoopCount=%u", _totalLoopCount, _curLoopCount, _maxLoopCount);
	}

	void GxService::onLoopBefore()
	{
		_curTime = DTimeManager.nowSysTime();
		if(_curTime-_lastLoopProfileTime > SERVICE_LOOP_PROFILE_TIME)
		{
			if(_curLoopCount>_maxLoopCount)
			{
				_maxLoopCount = _curLoopCount;
			}

			_lastLoopProfileTime = _curTime;
			_curLoopCount = 0;
			_doLooProfile();
		}

		_totalLoopCount++;
		_curLoopCount++;
		_genName();

		//doServerEvent("onLoopBefore");
	}

	void GxService::_doLooProfile()
	{
		DMainLoopProfileLog("{0}", _strLoopProfile.c_str());
	}

	void GxService::test()
	{
		std::cout << "service test!!!" << std::endl;
	}

	void GxService::onBreath( TDiffTime_t diff )
	{
		// 		if(_isReadProfileVar())
		// 		{
		// 			_readProfileVar();
		// 		}

		_updateReconnector(diff);
	}

	bool GxService::_isReadProfileVar()
	{
		return (_curTime-_lastReadProfileVarTime) > SERVICE_READ_PROFILE_VAR_TIME;
	}

	void GxService::_readProfileVar()
	{
		/*
		std::string iniFileName = _getConfigName();

		GXMISC::CIni ini;
		if(false == ini.open(iniFileName.c_str()))
		{
		gxError("Can't open ini!");
		}

		_gxServiceConfig->loadProfile();
		*/
		gxAssert(false); // @TODO 完成功能
		_lastReadProfileVarTime = _curTime;
	}

	std::string GxService::_getConfigName() // @TODO 删除此接口
	{
		return _context.getServerName() + ".ini";
	}

	void GxService::addLogger( IDisplayer* displayer )
	{
		DGxContext.getMainLog()->addDisplayer(displayer);
	}

	CServiceTaskQue* GxService::getTaskQue()
	{
		return &_taskQue;
	}

	void GxService::setOption( uint32 cfgOpt, uint32 val )
	{
		_g_LibConfig.setConfig((ELibConfig)cfgOpt, val);
		switch(cfgOpt)
		{
		case LIB_CONFIG_STAT_INTERVAL:	// 更新统计时间
			{
				resetStatTime();
			}break;
		default:
			{

			}
		}
	}

	void GxService::onStat()
	{
		//getNetMgr()->onStat();
		//doServerEvent("onStat");
	}

	void GxService::onLoopAfter()
	{
		if(_totalLoopCount == 1){
			onFirstLoop();
		}

		// doServerEvent("onLoopAfter");
	}

	CServerTaskPoolMgr* GxService::getServerTaskMgr()
	{
		return &_serverTaskMgr;
	}

	CLuaVM* GxService::getScriptEngine()
	{
		return _scriptEngine;
	}

	bool GxService::_blockConnect( const char* hosts, TPort_t port, uint32 diff, CSocketConnector* connector )
	{
		gxAssert(connector);
		if(false == connector->connect(hosts, port, diff))
		{
			gxInfo("Socket connect failed!IP={0},Port={1}", hosts, port);
			return false;
		}

		if(false == _netWrapMgr.addConnector(connector))
		{
			return false;
		}

		return true;
	}

	bool GxService::_asynConnect(const char* hosts, TPort_t port, uint32 diff, CSocketConnector* connector)
	{
		connector->setReconnectDiff(10000);
		connector->setConnectDiff(diff);

		CSocketReconnectTask* pTask = getServerTaskMgr()->newTask<CSocketReconnectTask>();
		if(NULL == pTask){
			gxError("Asyn connect, can't new CSocketReconnectTask!Host={0},Port={1}", hosts, port);
			return false;
		}
		pTask->setDebugInfo(connector->toString());

		pTask->pConnector = connector;
		pTask->diff = diff;
		pTask->ip = hosts;
		pTask->port = port;
		pTask->pushToQueue();

		return true;
	}

	bool GxService::addReconnector( CSocketConnector* pConnector )
	{
		pConnector->updateLastConnectTime();
		_connectorQue.insert(pConnector);
		return true;
	}

	void GxService::_updateReconnector( TDiffTime_t diff )
	{
		TSocketConnectorQue tempQue;

		for(TSocketConnectorQue::iterator iter = _connectorQue.begin(); iter != _connectorQue.end();){
			CSocketConnector* pConnector = *iter;
			if(pConnector->canReconnect())
			{
				tempQue.insert(pConnector);
				_connectorQue.erase(iter++);
			}else{
				++iter;
			}
		}

		for(TSocketConnectorQue::iterator iter = tempQue.begin(); iter != tempQue.end(); ++iter){
			CSocketConnector* pConnector = *iter;
			_asynConnect(pConnector->getServerIP().c_str(), pConnector->getServerPort(), pConnector->getConnectDiff(), pConnector);
		}
	}

	bool GxService::addConnector( CSocketConnector* pConnector )
	{
		return _netWrapMgr.addConnector(pConnector);
	}

	CGxServiceConfig* GxService::getServiceConfig()
	{
		return _gxServiceConfig;
	}

	GXMISC::TConfigMap GxService::loadByFileName(const std::string& fileName)
	{
		//return getScriptEngine()->call("LoadServerConfig", TConfigMap(), fileName);
		std::string bufferData;
		if (!GXMISC::MyReadStringFile(fileName, bufferData))
		{
			return GXMISC::TConfigMap();
		}

		return loadByFileData(bufferData);
	}

	GXMISC::TConfigMap GxService::loadByFileData(const std::string& fileData)
	{
		std::string decodeData;
		if (!onLoad(fileData, decodeData))
		{
			return TConfigMap();;
		}

		CIniFile iniFile;
		if (!iniFile.open(decodeData.c_str(), decodeData.length()))
		{
			gxError("Can't open file!FileName={0}", decodeData);
			return TConfigMap();
		}
		TConfigMap configs;
		for (CIniFile::iterator iter = iniFile.begin(); iter != iniFile.end(); ++iter)
		{
			TConfigKeyMap& kvs = configs[iter->first];
			for (CIniSection::iterator it = iter->second->begin(); it != iter->second->end(); ++it)
			{
				kvs[it->key] = it->value;
			}
		}

		return configs;
	}

	bool GxService::onSystemEnvironment()
	{
		return true;
	}

	std::string GxService::getServiceName() const
	{
		return getModuleName();
	}

	void GxService::setScriptEngine(CLuaVM* scriptEngine)
	{
		_scriptEngine = scriptEngine;
	}

	CConfigMap* GxService::getConfigMap()
	{
		return &_configMap;
	}

	GxService* GetLibService()
	{
		return g_LibService;
	}


	void GxService::onFirstLoop()
	{
		gxInfo("first loop start!");

		doServerEvent("onFirstLoop");
	}

	bool GxService::onAcceptSocket( CSocket* socket, CSocketHandler* sockHandler, ISocketPacketHandler* packetHandler, sint32 tag )
	{
		if(sockHandler->isScriptHandler())
		{
			CScriptSocketHandler* pScriptSocketHandler = (CScriptSocketHandler*)sockHandler;
			if (_scriptObject.isExistMember("onAcceptSocket"))
			{
				if (!_scriptObject.bCall("onAcceptSocket", socket, pScriptSocketHandler, packetHandler, tag))
				{
					return false;
				}
			}
			if (!pScriptSocketHandler->getScriptHandleClassName().empty())
			{
				if (!pScriptSocketHandler->initScriptObject(_scriptEngine))
				{
					return false;
				}
			}

			return true;
		}

		return true;
	}

	bool GxService::onConnectSocket( CSocket* socket, CSocketHandler* sockHandler, ISocketPacketHandler* packetHandler, sint32 tag )
	{ 
		if(sockHandler->isScriptHandler())
		{
			CScriptSocketHandler* pScriptSocketHandler = (CScriptSocketHandler*)sockHandler;
			if (_scriptObject.isExistMember("onConnectSocket"))
			{
				if (!_scriptObject.bCall("onConnectSocket", socket, pScriptSocketHandler, packetHandler, tag))
				{
					return false;
				}
			}
			if (!pScriptSocketHandler->getScriptHandleClassName().empty())
			{
				if (!pScriptSocketHandler->initScriptObject(_scriptEngine))
				{
					return false;
				}
			}
		}

		return true;
	}

	bool GxService::openClientListener(const char* hosts, TPort_t port, sint32 tag)
	{
		return _openListener<CScriptSocketHandler, CDefaultPacketHandler, 
			GXMISC::CDefaultSocketServerListener<CScriptSocketHandler, CDefaultPacketHandler> >(hosts, port, tag);
	}

	// 开启监听其他服务器连接的端口
	bool GxService::openServerListener(const char* hosts, TPort_t port, sint32 tag)
	{
		return _openListener<CScriptSocketHandler, CDefaultPacketHandler, 
			GXMISC::CDefaultSocketServerListener<CScriptSocketHandler, CDefaultPacketHandler> >
			(hosts, port, tag);
	}
	// 客户端连接到服务器
	bool GxService::openClientConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, bool blockFlag)
	{
		return _openConnector<CScriptSocketHandler, CDefaultPacketHandler, 
			GXMISC::CDefaultSocketConnector<CScriptSocketHandler, CDefaultPacketHandler>>(hosts, port, diff, tag, blockFlag);
	}

	void GxService::setMainScriptName(std::string scriptName)
	{
		_mainScriptName = scriptName;
	}

	void GxService::setNewServiceFunctionName(std::string scriptFuncName)
	{
		_newServiceFunctionName = scriptFuncName;
	}

	CSerivceScriptObject* GxService::getScriptObject()
	{
		return &_scriptObject;
	}

	bool GxService::onBeforeStart()
	{
		if (!_scriptObject.isExistMember("onBeforeStart"))
		{
			return true;
		}

		return _scriptObject.bCall("onBeforeStart");
	}

	bool GxService::onAfterStart()
	{
		if (!_scriptObject.isExistMember("onAfterStart"))
		{
			return true;
		}

		return _scriptObject.bCall("onAfterStart");
	}

	bool GxService::onBeforeLoad()
	{
		if (!_scriptObject.isExistMember("onBeforeLoad"))
		{
			return true;
		}

		return _scriptObject.bCall("onBeforeLoad");
	}
	bool GxService::onAfterLoad()
	{
		if (!_scriptObject.isExistMember("onAfterLoad"))
		{
			return true;
		}

		return _scriptObject.bCall("onAfterLoad");
	}

	bool GxService::onBeforeInit()
	{
		if (!_scriptObject.isExistMember("onBeforeInit"))
		{
			return true;
		}

		return _scriptObject.bCall("onBeforeInit");
	}
	bool GxService::onAfterInit()
	{
		if (!_scriptObject.isExistMember("onAfterInit"))
		{
			return true;
		}

		return _scriptObject.bCall("onAfterInit");
	}
}