#include "module_manager.h"
#include "time_manager.h"
#include "common.h"
#include "interval_timer.h"
#include "lib_config.h"
#include "string_parse.h"

namespace GXMISC
{
#pragma region module_manager
	IModuleManager::IModuleManager( IModuleConfig* config ) : IStopHandler()
	{
		_moduleConfig = config;
	}

	IModuleManager::~IModuleManager()
	{
	}

	bool IModuleManager::onLoadConfig(const CConfigMap* configs)
	{
		return _moduleConfig->onLoadConfig(configs);
	}

	bool IModuleManager::loop(TDiffTime_t diff)
	{
		return doOnceLoop(diff);
	}

	bool IModuleManager::doOnceLoop(TDiffTime_t diff)
	{
		gxAssert(diff > 0);
		if(diff <= 0)
		{
			gxError("Get error diff time!");
			return false;
		}

		// 循环
		onLoopBefore();	// 循环前
		if(false == doLoop(diff)) // 处理其他模块循环
		{
			return false;
		}
		onLoopAfter(); // 循环后

		return true;
	}

    void IModuleManager::setModuleName( const std::string& name )
    {
        _moduleConfig->setModuleName(name);
    }

	std::string IModuleManager::getModuleName() const
	{
		return _moduleConfig->getModuleName();
	}

	IModuleConfig* IModuleManager::getModuleConfig() const
	{
		return _moduleConfig;
	}

#pragma endregion module_manager


#pragma region module_config

    IModuleConfig::IModuleConfig( const std::string& moduleName ) : _moduleName(moduleName)
    {
		_clearSelf();
    }

    IModuleConfig::~IModuleConfig()
    {
		_clearSelf();
    }

	void IModuleConfig::_clearSelf()
	{
		_loaded = false;
		_frameNum = 0;
		_loopThreadNum = 0;
		_maxUserNumPerLoop = 0;
		_closeWaitSecsPerLoop = 0;
		_closeWaitSecsAllLoop = 0;
	}

    void IModuleConfig::setModuleName( const std::string& name )
    {
        _moduleName = name;
    }

    std::string IModuleConfig::getModuleName() const
    {
        return _moduleName;
    }

	sint32 IModuleConfig::getLoopThreadNum() const
	{
		return _loopThreadNum;
	}

	sint32 IModuleConfig::getMaxUserNumPerLoop() const
	{
		return _maxUserNumPerLoop;
	}

	sint32 IModuleConfig::getCloseWaitSecsAllLoop()const
	{
		return _loopThreadNum*_closeWaitSecsPerLoop + _closeWaitSecsAllLoop;
	}

	bool IModuleConfig::check() const
	{
		return _loaded;
	}

	bool IModuleConfig::onLoadConfig(const CConfigMap* configs) 
	{
		// 帧数
		uint32 frameNum = 0;
		if ((frameNum = configs->readConfigValue(_moduleName.c_str(), "FrameNum")) == -1)
		{
			if (_frameNum == 0)
			{
				_frameNum = 30;
			}
		}
		else
		{
			_frameNum = frameNum;
		}

		// CPU绑定
		std::string str;
		if ((str = configs->readConfigText(_moduleName.c_str(), "CPUFlag")) != "")
		{
			CStringParse<sint32> parser;
			parser.parse(str);

			_runCPUFlag = parser.getValueList();
		}

		// 线程数
		sint32 loopThreadNum = 0;
		if ((loopThreadNum = configs->readConfigValue(_moduleName.c_str(), "LoopThreadNum")) == -1)
		{
			if (_loopThreadNum == 0)
			{
				_loopThreadNum = 1;
			}
		}
		else
		{
			_loopThreadNum = loopThreadNum;
		}

		// 每个线程最大的用户数
		sint32 maxUserNumPerLoop = 0;
		if ((maxUserNumPerLoop = configs->readConfigValue(_moduleName.c_str(), "MaxUserNumPerLoop")) == -1)
		{
			if (_maxUserNumPerLoop == 0)
			{
				_maxUserNumPerLoop = 0;
			}
		}
		else
		{
			_maxUserNumPerLoop = maxUserNumPerLoop;
		}

		// 每个线程停止等待的时间(@TODO 所有线程共用一个值就行了，要不然会)
		sint32 closeWaitSecsPerLoop = 0;
		if ((closeWaitSecsPerLoop = configs->readConfigValue(_moduleName.c_str(), "CloseWaitTimePerLoop")) = -1)
		{
			if (_closeWaitSecsPerLoop == 0)
			{
				_closeWaitSecsPerLoop = 1;
			}
		}
		else
		{
			_closeWaitSecsPerLoop = closeWaitSecsPerLoop;
		}

		// 所有线程停止需要等待的时间
		sint32 closeWaitSecsAllLoop = 0;
		if ((closeWaitSecsAllLoop = configs->readConfigValue(_moduleName.c_str(), "AllLoopExtraWaitTime")) = -1)
		{
			if (_closeWaitSecsAllLoop == 0)
			{
				_closeWaitSecsAllLoop = 5;
			}
		}
		else
		{
			_closeWaitSecsAllLoop = closeWaitSecsAllLoop;
		}

		return true;
	}

	const std::vector<sint32>& IModuleConfig::getRunCPUFlag()const
	{
		return _runCPUFlag;
	}

	sint32 IModuleConfig::getFrameNumPerSecond() const
	{
		return _frameNum;
	}

	sint32 CConfigMap::readConfigValue(const char* section, const char* key) const
	{
		TConfigMap::const_iterator iter = _configs.find(section);
		if(iter == _configs.end())
		{
			return -1;
		}

		TConfigKeyMap::const_iterator keyIter = iter->second.find(key);
		if(keyIter == iter->second.end())
		{
			return -1;
		}

		sint32 configValue = -1;
		gxFromString(keyIter->second, configValue);
		return configValue;
	}

	std::string CConfigMap::readConfigText(const char* section, const char* key) const
	{
		TConfigMap::const_iterator iter = _configs.find(section);
		if(iter == _configs.end())
		{
			return "";
		}

		TConfigKeyMap::const_iterator keyIter = iter->second.find(key);
		if(keyIter == iter->second.end())
		{
			return "";
		}

		return keyIter->second;
	}

	bool CConfigMap::readTypeIfExist(const char* section, const char* key, std::string& value) const
	{
		value = readConfigText(section, key);
		return (value) != "";
	}

	const TConfigMap* CConfigMap::getConfigs()
	{
		return &_configs;
	}

	void CConfigMap::setConfigs( TConfigMap* configs )
	{
		_configs = *configs;
	}

	CConfigMap::CConfigMap()
	{

	}

	CConfigMap::~CConfigMap()
	{

	}

// 	bool CConfigMap::load( const luabind::object& options )
// 	{
// 		std::string fileName = object_cast<std::string>(options);
// 
// 		lua_State* pState = options.interpreter();
// 		lua_getfield(pState, LUA_GLOBALSINDEX, "__CoreScriptEngine");
// 		CLuaVM *pScriptEngine = (CLuaVM*)lua_touserdata(pState, -1);
// 		lua_pop(pState, 1);
// 
// 		_configs = pScriptEngine->call("LoadServerConfig", TConfigMap(), fileName);
// 
// 		return true;
// 	}

#pragma endregion module_config

#pragma region service_module

	IServiceModule::IServiceModule(IModuleConfig* _config) : IModuleManager(_config)
	{
		_initLoopFlag = false;
		_currentTime = DTimeManager.update();
		_lastUpdateTime = _currentTime;
		_idleDiff = 0;
		_idleStartTime = 0;
		_totalDiffPerSec = 0;
		_totalFrameNumPerSec = 0;
	}
	IServiceModule::~IServiceModule()
	{

	}
	TDiffTime_t IServiceModule::_updateSystemTime()
	{
		TAppTime_t diff = 0;
		_currentTime = DTimeManager.update();
		if(_lastUpdateTime != _currentTime){
			diff = _currentTime-_lastUpdateTime;
			_lastUpdateTime = _currentTime;
		}

		return (TDiffTime_t)diff;
	}

	void IServiceModule::_doMainLoop(TDiffTime_t diff)
	{
		// 统计
		if(_statTimer.update(diff))
		{
			_statTimer.reset(true);
			if(_g_LibConfig.getStatDb()==1)
			{
				onStat();
			}
		}

		// 增加循环计数及总的运行时间
		_totalFrameNumPerSec++;
		_totalDiffPerSec += diff;
		
		// Sleep
		TAppTime_t perFrameHasTime = (1000/_moduleConfig->getFrameNumPerSecond());
		TAppTime_t newCurrTime = DTimeManager.AppNowTime();
		TAppTime_t sleepTime = 0;
		sleepTime = perFrameHasTime-(newCurrTime-_currentTime);
		if(sleepTime > 0)
		{
			_idleDiff = (TDiffTime_t)sleepTime;
			_idleStartTime = newCurrTime;
			onIdle();

			sleepTime = getRemainIdleDiff();
			if(sleepTime > 0)
			{
				gxSleep((TDiffTime_t)sleepTime);
			}
		}
		else
		{
			_resetIdleState();
		}
		
		if(isLoopSecond() || isFullFrameNum())
		{
			// 已经超过一秒或跑完了指定的帧数
			_resetLoopStateSecond();
			gxSleep(0);
		}
	}

	bool IServiceModule::doLoop(TDiffTime_t diff)
	{
		onBreath(diff);
		return true;
	}
	bool IServiceModule::_doMultiLoop()
	{
		TDiffTime_t diff = 0;
		while(!isStop())
		{
			diff = _updateSystemTime();
			if(diff <= 0)
			{
				continue;
			}

			if(!IModuleManager::loop(diff))
			{
				break;
			}

			_doMainLoop(diff);
		}

		onStop();
		cleanUp();

		return true;
	}

	TDiffTime_t IServiceModule::getRemainIdleDiff()
	{
		if(_idleDiff == 0 || _idleStartTime == 0)
		{
			return 0;
		}

		TAppTime_t appNowTime = DTimeManager.AppNowTime();
		if(appNowTime > (_idleDiff+_idleStartTime))
		{
			return 0;
		}

		return TDiffTime_t((_idleDiff+_idleStartTime)-appNowTime);
	}

	GXMISC::TDiffTime_t IServiceModule::getDiffTime()
	{
		return TDiffTime_t(_currentTime - _lastUpdateTime);
	}

	bool IServiceModule::initLoop()
	{
		_updateSystemTime();
		_statTimer.init(20000);
		_idleStartTime = _currentTime;
		_idleDiff = 0;
		_initLoopFlag = true;
		_totalDiffPerSec = 0;
		_totalFrameNumPerSec = 0;

		return true;
	}

	bool IServiceModule::isInitLoop()
	{
		return _initLoopFlag;
	}

	// 上一帧执行的开始时间
	GXMISC::TAppTime_t IServiceModule::getLastLoopTime() const
	{
		return _lastUpdateTime;
	}
	// 当前帧执行的开始时间
	GXMISC::TAppTime_t IServiceModule::getCurrentLoopTime() const
	{
		return _currentTime;
	}

	bool IServiceModule::loop( TDiffTime_t diff )
	{
		if(!isInitLoop())
		{
			return false;
		}

		if(diff >= 0)
		{
			if (diff == 0)
			{
				diff = _updateSystemTime();
				if (diff <= 0){
					return true;
				}
			} 
			//else
			//{
			//	_updateSystemTime();
			//}

			return IModuleManager::loop(diff);
		}
		else
		{
			return _doMultiLoop();
		}
	}

	bool IServiceModule::start()
	{
		setStart();

		return true;
	}

	void IServiceModule::resetStatTime()
	{
		_statTimer.init(_g_LibConfig.getStatInterval());
	}

	bool IServiceModule::isFullFrameNum()
	{
		return _totalFrameNumPerSec >= _moduleConfig->getFrameNumPerSecond();
	}

	bool IServiceModule::isLoopSecond()
	{
		return _totalDiffPerSec > 1000;
	}

	void IServiceModule::_resetLoopStateSecond()
	{
		_totalDiffPerSec = 0;
		_totalFrameNumPerSec = 0;
	}

	void IServiceModule::_resetIdleState()
	{
		_idleDiff = 0;
		_idleStartTime = 0;
	}

#pragma endregion service_module
}