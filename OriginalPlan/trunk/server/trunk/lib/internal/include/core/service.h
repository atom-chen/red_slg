#ifndef _SERVICE_H_
#define _SERVICE_H_

#include <string>

#include "types_def.h"
#include "singleton.h"
#include "socket_connector.h"
#include "socket_listener.h"
#include "socket_event_loop_wrap_mgr.h"
#include "socket_server_listener.h"
#include "hash_util.h"
#include "service_task.h"
#include "server_task_pool_wrap_mgr.h"
#include "database_conn_mgr.h"

#include "time/interval_timer.h"

namespace GXMISC
{
	extern GxService* g_LibService;
	extern GxService* GetLibService();
	class CGxServiceConfig : public IModuleConfig
	{
		friend class GxService;

	public:
		typedef IModuleConfig TBaseType;

	public:
		CGxServiceConfig(const std::string& moduleName = "GxService");
		~CGxServiceConfig();

	public:
		virtual bool onLoadConfig(const CConfigMap* configs) override;

	protected:
		void loadProfile();

	protected:
		CHashMap<TUniqueIndex_t, bool> _socketLogFilter;		// Socket开启日志显示
		CHashMap<TUniqueIndex_t, bool> _dbLogFilter;			// 数据库开启日志显示
	};

	class CSerivceScriptObject : public IScriptObject
	{
	public:
	};

	class GxService : public IServiceModule
	{
		friend class CNetModule;
		friend class CDatabaseConnMgr;

	public:
		typedef IServiceModule TBaseType;

	public:
		GxService(CGxServiceConfig* config, const std::string& serverName = "GxService");
		~GxService();
		
	public:
		// 测试
		virtual void test();

	public:
		// 加载配置
		virtual bool load(const std::string& serverName);
		// 添加新配置
		virtual bool addLoad(const std::string& configBuff);
		// 初始化服务
		virtual bool init();
		// 启动服务
		virtual bool start();
		// 清理资源
		virtual void cleanUp();

	protected:
		// 等待退出
		void waitQuit(sint32 waitSecs);

	public:
		// 设置系统环境
		bool setSystemEnvironment();
	
	protected:
		// 通过文件名加载配置
		TConfigMap loadByFileName(const std::string& fileName);
		// 通过文件数据加载配置
		TConfigMap loadByFileData(const std::string& fileData);

	protected:
		// 设置系统环境事件
		virtual bool onSystemEnvironment();
		// 配置加载事件
		virtual bool onLoadConfig(const CConfigMap* configs) override;
		// 解析配置数据
		virtual bool onLoad(const std::string& inData, std::string& outData);
		// 帧循环
		virtual bool doLoop(TDiffTime_t diff);
		// 循环前后事件
		virtual void onLoopBefore();
		virtual void onLoopAfter();
		// 第一次循环
		virtual void onFirstLoop();
		// 定时更新事件
		virtual void onBreath(TDiffTime_t diff) override;
		// 更新前后事件
		virtual bool onBeforeStart();
		virtual bool onAfterStart();
		// 加载前后事件
		virtual bool onBeforeLoad();
		virtual bool onAfterLoad();
		// 初始化前后事件
		virtual bool onBeforeInit();
		virtual bool onAfterInit();
		// Socket事件
		virtual bool onAcceptSocket(CSocket* socket, CSocketHandler* sockHandler, ISocketPacketHandler* packetHandler, sint32 tag);
		virtual bool onConnectSocket(CSocket* socket, CSocketHandler* sockHandler, ISocketPacketHandler* packetHandler, sint32 tag);
		// 统计事件
		virtual void onStat();
		// 停止事件
		virtual void onStop();

	public:
		// 获取网络管理对象
		CNetModule*    getNetMgr();
		// 获取数据库管理对象
		CDatabaseConnMgr* getDbMgr();
		// 获取网络广播对象
		CNetBroadcastModule* getNetBroadcast();
		// 获取服务任务队列
		CServiceTaskQue*	getTaskQue();
		// 获取服务器多线程任务管理对象
		CServerTaskPoolMgr* getServerTaskMgr();
		// 获取脚本引擎
		CLuaVM* getScriptEngine();
		// 获取服务配置
		CGxServiceConfig* getServiceConfig();
		// 获取配置表
		CConfigMap* getConfigMap();
		// 获取模块名
		std::string getModuleName() const;
		// 获取服务名
		std::string getServiceName() const;
		// 设置脚本引擎
		void setScriptEngine(CLuaVM* scriptEngine);
		// 设置脚本入口文件
		void setMainScriptName(std::string scriptName);
		// 设置创建服务的函数名
		void setNewServiceFunctionName(std::string scriptFuncName);
		// 获取服务脚本对象
		CSerivceScriptObject* getScriptObject();
	private:
		// 添加连接
		bool	_addConnector(const char* hosts, TPort_t port, uint32 diff, CSocketConnector* connector, bool blockFlag = true);
		// 生成名字
		void	_genName();
		// 执行统计
		void	_doLooProfile();
		// 是否需要读取统计值
		bool	_isReadProfileVar();
		// 读取统计值
		void	_readProfileVar();
		// 获取配置名字
		std::string	_getConfigName();

		// 服务控制选项 @TODO 完善
	public:
		void setOption(uint32 cfgOpt, uint32 val);

		/// 信号处理
	public:
		// 设置终止服务信号
		void setStopSigno(sint32 signo = SIGKILL);

		/// 日志
	public:
		void addLogger(IDisplayer* displayer);
		
		/// 定时器
	public:
		void addTimer(CIntervalTimer* timer, bool isNeedFree = true);

	public:
		// 新建服务任务
		template<typename T>
		T* newServerTask(){
			return getServerTaskMgr()->newTask<T>();
		}

		/// 网络
	public:
		// 开启监听客户端连接的端口
		template<typename HandlerType, typename PacketHandlerType>
		bool                openClientListener(const char* hosts, TPort_t port, sint32 tag);
		// 开启监听客户端连接的端口
		bool                openClientListener(const char* hosts, TPort_t port, sint32 tag);
		// 开启监听其他服务器连接的端口
		template<typename HandlerType, typename PacketHandlerType>
		bool                openServerListener(const char* hosts, TPort_t port, sint32 tag);
		// 开启监听其他服务器连接的端口
		bool openServerListener(const char* hosts, TPort_t port, sint32 tag);
		// 客户端连接到服务器
		bool openClientConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, bool blockFlag);
	public:
		// 客房端连接到服务器	
		template<typename HandlerType, typename PacketHandlerType>
		bool                openClientConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename P1>
		bool                openClientConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2>
		bool                openClientConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3>
		bool                openClientConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3, typename P4>
		bool                openClientConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3, typename P4, typename P5>
		bool                openClientConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, P5& p5, bool blockFlag);

		// 开启服务器到服务器之间的连接
		template<typename HandlerType, typename PacketHandlerType>
		bool                openServerConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename P1>
		bool                openServerConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1 p1, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2>
		bool                openServerConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3>
		bool                openServerConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3, typename P4>
		bool                openServerConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3, typename P4, typename P5>
		bool                openServerConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, P5& p5, bool blockFlag);

	public:
		// 关闭指定Socket
		void                closeSocket(TSocketIndex_t index, sint32 waitSecs);
		/// 添加重连Socket
		bool				addReconnector(CSocketConnector* pConnector);
		/// 添加连接成功的Socket
		bool				addConnector(CSocketConnector* pConnector);

		// 脚本
	public:
		inline void doScriptEvent(const char* functionName)
		{
			getScriptEngine()->vCall(functionName);
		}

		template<typename T>
		inline void doScriptEvent(const char* functionName, T p1)
		{
			getScriptEngine()->vCall(functionName, p1);
		}

		template<typename T, typename T2>
		inline void doScriptEvent(const char* functionName, T p1, T2 p2)
		{
			getScriptEngine()->vCall(functionName, p1, p2);
		}

		template<typename T, typename T2, typename T3>
		inline void doScriptEvent(const char* functionName, T p1, T2 p2, T3 p3)
		{
			getScriptEngine()->vCall(functionName, p1, p2, p3);
		}

		template<typename T, typename T2, typename T3, typename T4>
		inline void doScriptEvent(const char* functionName, T p1, T2 p2, T3 p3, T4 p4)
		{
			getScriptEngine()->vCall(functionName, p1, p2, p3, p4);
		}

		template<typename T, typename T2, typename T3, typename T4, typename T5>
		inline void doScriptEvent(const char* functionName, T p1, T2 p2, T3 p3, T4 p4, T5 p5)
		{
			getScriptEngine()->vCall(functionName, p1, p2, p3, p4, p5);
		}

		inline void doServerEvent(const char* functionName)
		{
			_scriptObject.vCall(functionName);
		}

		template<typename T>
		inline void doServerEvent(const char* functionName, T p1)
		{
			_scriptObject.vCall(functionName, p1);
		}

		template<typename T, typename T2>
		inline void doServerEvent(const char* functionName, T p1, T2 p2)
		{
			_scriptObject.vCall(functionName, p1, p2);
		}

		template<typename T, typename T2, typename T3>
		inline void doServerEvent(const char* functionName, T p1, T2 p2, T3 p3)
		{
			_scriptObject.vCall(functionName, p1, p2, p3);
		}

		template<typename T, typename T2, typename T3, typename T4>
		inline void doServerEvent(const char* functionName, T p1, T2 p2, T3 p3, T4 p4)
		{
			_scriptObject.vCall(functionName, p1, p2, p3, p4);
		}

		template<typename T, typename T2, typename T3, typename T4, typename T5>
		inline void doServerEvent(const char* functionName, T p1, T2 p2, T3 p3, T4 p4, T5 p5)
		{
			_scriptObject.vCall(functionName, p1, p2, p3, p4, p5);
		}

private:
		// 打开监听
		template<typename HandlerType, typename PacketHandlerType, typename ListenerType>
		bool _openListener(const char* hosts, TPort_t port, sint32 tag);
		template<typename HandlerType, typename PacketHandlerType, typename ListenerType, typename P>
		bool _openListener(const char* hosts, TPort_t port, sint32 tag, P& p1);
		// 客户端连接到服务器
		template<typename HandlerType, typename PacketHandlerType, typename ConnectorType>
		bool                _openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename ConnectorType, typename P1>
		bool                _openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1 p1, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename ConnectorType, typename P1, typename P2>
		bool                _openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename ConnectorType, typename P1, typename P2, typename P3>
		bool                _openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename ConnectorType, typename P1, typename P2, typename P3, typename P4>
		bool                _openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, bool blockFlag);
		template<typename HandlerType, typename PacketHandlerType, typename ConnectorType, typename P1, typename P2, typename P3, typename P4, typename P5>
		bool                _openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, P5& p5, bool blockFlag);

	protected:
		// 阻塞连接
		bool	_blockConnect(const char* hosts, TPort_t port, uint32 diff, CSocketConnector* connector);
		// 异步连接
		bool	_asynConnect(const char* hosts, TPort_t port, uint32 diff, CSocketConnector* connector);
		// 重新连接
		void	_updateReconnector(TDiffTime_t diff);

	protected:
		CNetModule _netWrapMgr;						///< 网络模块
		CNetBroadcastModule _netBroadcast;			///< 网络广播模块
		CServerTaskPoolMgr _serverTaskMgr;			///< 服务器多线程任务管理
		CDatabaseConnMgr _dbConnMgr;				///< 数据库管理器
		CServiceTaskQue	_taskQue;					///< 任务队列
		CLuaVM*	_scriptEngine;						///< 脚本引擎
		CConfigMap _configMap;						///< 配置列表
		CSerivceScriptObject _scriptObject;		///< 脚本对象
		TSocketConnectorQue _connectorQue;			///< 连接队列
		std::string _mainScriptName;				///< 主脚本入口文件名
		std::string _newServiceFunctionName;		///< 创建服务的函数名

	protected:
		CGxServiceConfig*		_gxServiceConfig;		// 服务配置
		CGxContext              _context;				// 当前环境
		TTime_t					_startTime;				// 开启时间
		TTime_t					_curTime;				// 当前时间

	protected:
		// 统计
		TTime_t					_lastLoopProfileTime;	// 上次循环统计时间
		uint64					_totalLoopCount;		// 总共循环次数
		uint32					_maxLoopCount;			// 循环的最大次数
		uint32					_curLoopCount;			// 当前循环的次数
		std::string				_strLoopProfile;		// 统计日志显示字符串
		TTime_t					_lastReadProfileVarTime;// 上一次读取统计变量的时间
	};

#include "service.inl"
}

#endif
