#ifndef _MODULE_MANAGER_H_
#define _MODULE_MANAGER_H_

#include <string>

#include "types_def.h"
#include "debug.h"
#include "interface.h"
#include "time_gx.h"
#include "time/interval_timer.h"

namespace GXMISC
{
	// 配置项
	class CConfigMap
	{
	public:
		CConfigMap();
		~CConfigMap();

	public:
		///		bool load(const luabind::object& options); @TODO 脚本加载配置

	public:
		// 读取配置整形值
		sint32 readConfigValue(const char* section, const char* key) const;
		// 读取配置字符串值
		std::string readConfigText(const char* section, const char* key) const;

		// 根据类型读取数据
		template<typename T>
		bool readTypeIfExist(const char* section, const char* key, T& value) const
		{
			value = (T)readConfigValue(section, key);
			if ((value) == -1){
				return false;
			}

			return true;
		}

		bool readTypeIfExist(const char* section, const char* key, bool& value) const
		{
			sint32 ret = readConfigValue(section, key);
			if (ret == -1){
				value = false;
				return false;
			}
			value = true;
			return true;
		}
		
		bool readTypeIfExist(const char* section, const char* key, std::string& value) const;

	public:
		// 获取配置键值表
		const TConfigMap* getConfigs();
		// 设置配置键值表
		void setConfigs(TConfigMap* configs);

	protected:
		TConfigMap _configs;
	};

	// 模块配置接口
	class IModuleConfig
	{
	public:
		IModuleConfig(const std::string& moduleName);
		virtual ~IModuleConfig();

	private:
		// 清零自身
		void _clearSelf();

	public:
		// 加载配置事件
		virtual bool onLoadConfig(const CConfigMap* configs);

	public:
		// 是否已经加载成功 (@TODO 去掉virtual)
		virtual bool check() const;

	public:
		// 获取CPU绑定运行标记
		const std::vector<sint32>& getRunCPUFlag()const;
		// 获取帧率
		sint32 getFrameNumPerSecond()const;
		// 设置模块名
		void setModuleName(const std::string& name);
		// 获取模块名
		std::string getModuleName() const;
		// 获取循环线程数
		sint32 getLoopThreadNum() const;
		// 获取每个线程能够处理的用户数
		sint32 getMaxUserNumPerLoop() const;
		// 关闭所有循环线程需要等待的时间
		sint32 getCloseWaitSecsAllLoop()const;

	protected:
		std::string	_moduleName;			// 模块名字
		bool        _loaded;				// 是否已经加载成功
		uint32		_frameNum;				// 每秒循环帧数
		std::vector<sint32> _runCPUFlag;	// 当前模块的线程能在指定的CPU上运行
		sint32		_loopThreadNum;			// 循环线程数
		sint32		_maxUserNumPerLoop;		// 每个线程能够处理的用户数
		sint32		_closeWaitSecsPerLoop;  // 关闭单个线程循环对象等待的秒数
		sint32		_closeWaitSecsAllLoop;  // 关闭所有线程循环对象额外等待的秒数
	};

	// 模块管理接口
	// 如: 网络模块, 数据库模块等
	class IModuleManager : public IStopHandler
	{
	protected:
		IModuleManager(IModuleConfig* _config);
	public:
		virtual ~IModuleManager();

	public:
		// 配置加载事件
		virtual bool onLoadConfig(const CConfigMap* configs);

	public:
		// 初始化数据, 如(内存)等
		virtual bool init() = 0;
		// 模块启动, 如(连接建立)等
		virtual bool start() = 0;
		// 清理内存
		virtual void cleanUp() = 0;
		// 模块循环
		// diff >0上一帧与当前帧的时间差, 其他值无效
		virtual bool loop(TDiffTime_t diff);

	public:
		// 统计回调函数
		virtual void onStat(){}

	public:
		// 设置模块名
		void setModuleName(const std::string& name);
		// 获取模块名
		std::string getModuleName() const;
		// 获取模块配置
		IModuleConfig* getModuleConfig() const;
	protected:
		// 循环前事件
		inline virtual void onLoopBefore(){};
		// 循环后事件
		inline virtual void onLoopAfter(){};
		// 处理循环
		virtual bool doLoop(TDiffTime_t diff) = 0;

	protected:
		// 执行一次循环
		// diff >0前一帧与当前帧的时间差, <=0值无效
		bool doOnceLoop(TDiffTime_t diff);

	protected:
		IModuleConfig*		_moduleConfig;				// 模块配置
	};

	// 服务模块
	class IServiceModule : public IModuleManager
	{
	protected:
		IServiceModule(IModuleConfig* _config);
	public:
		virtual ~IServiceModule();

	public:
		// 服务循环
		// diff =-1表示无限循环, 否则为单次循环
		//      =0表示用自己内部的时间, >0表示用外部传入的时间, >=0
		virtual bool loop(TDiffTime_t diff);
		// 模块启动, 如(连接建立)等
		virtual bool start();
	public:
		// 循环是否已经初始化
		bool isInitLoop();
		// 上一帧执行的开始时间
		GXMISC::TAppTime_t getLastLoopTime() const;
		// 当前帧执行的开始时间
		GXMISC::TAppTime_t getCurrentLoopTime() const;
	protected:
		// 当前每秒循环的总时间
		sint32 getTotalTimePerSecond();
		// 当前每秒循环的总帧数
		sint32 getTotalFrameNumPerSecond();

	protected:
		// 空闲事件
		virtual void onIdle(){};
		// 帧更新
		virtual void onBreath(TDiffTime_t diff) = 0;
	protected:
		virtual bool doLoop(TDiffTime_t diff);
	protected:
		// 得到剩余的空闲时间
		TDiffTime_t getRemainIdleDiff();
		// 得到前一帧与当前帧时间差值
		TDiffTime_t getDiffTime();
		// 是否已经跑完了指定的帧数
		bool isFullFrameNum();
		// 是否已经循环一秒了
		bool isLoopSecond();
	protected:
		// 初始化循环
		bool initLoop();
		// 重置统计时间
		void resetStatTime();

	private:
		// 执行当前循环需要处理的事件
		void _doMainLoop(TDiffTime_t diff);
		// 更新当前系统时间
		TDiffTime_t _updateSystemTime();
		// 执行无限循环
		bool _doMultiLoop();
		// 一秒后重置循环状态
		void _resetLoopStateSecond();
		// 重置空闲状态
		void _resetIdleState();

	private:
		bool _initLoopFlag;						// 是否已经初始化循环
		TAppTime_t _lastUpdateTime;				// 上次更新时间
		TAppTime_t _currentTime;				// 当前更新时间
		CManualIntervalTimer _statTimer;		// 统计定时器
		TDiffTime_t _totalDiffPerSec;			// 当前每秒循环的总时间(单位为毫秒)
		sint32 _totalFrameNumPerSec;			// 当前每秒循环的总帧数
		TDiffTime_t _idleDiff;					// 空闲的时间长
		TAppTime_t _idleStartTime;				// 空闲开始时间
	};
}

#endif // _MODULE_MANAGER_H_