#ifndef _SOCKET_EVENT_LOOP_WRAP_MGR_H_
#define _SOCKET_EVENT_LOOP_WRAP_MGR_H_

#include <list>

#include "types_def.h"
#include "socket_util.h"
#include "module_manager.h"
#include "socket_handler.h"
#include "socket_broad_cast.h"
#include "server_task_pool_wrap_mgr.h"

namespace GXMISC
{
    class CSocketHandler;
	class GxService;

	// 网络模块配置
    class CNetModuleConfig : public IModuleConfig
    {
		typedef IModuleConfig TBaseType;

    public:
        CNetModuleConfig(const std::string moduleName);
        ~CNetModuleConfig();

    public:
		// 读取配置
		virtual bool onLoadConfig(const CConfigMap* configs) override;

	public:
		// 协议处理长度
		sint32 getPackBuffLen()const;
		// 协议临时处理长度
		sint32 getPackTempReadBuffLen()const;
		// 每帧处理的协议数
		sint32 getPacketNumPerFrame()const;

	private:
		// 清理数据
		void _clearSelf();

    private:
        sint32  _msgPerFrame;                           // 每帧每个socket解析的消息包数
		sint32  _packBuffLen;							// 单个包处理缓冲长度(包括压缩包, 长度有可能超过64K)
		sint32  _packTempReadBuffLen;					// 从Socket中一次读取的缓冲长度(一般不超过64K)
    };

    /**
    * @brief 网络层包装管理器
    *        监听连接, 接收已经解析的协议包并处理
    */
	class CNetModule : public CModuleBase
    {
		friend CNetLoopWrap;

	public:
		typedef CModuleBase TBaseType;

    public:
        CNetModule(const std::string& moduleName = "NetModule");
        ~CNetModule();

	private:
		// 清零自身
		void _clearSelf();

	public:
		// 初始化
		virtual bool init();
		// 清理
        virtual void cleanUp();

	public:
		// 获取配置
		CNetModuleConfig* getConfig();
		// 通过唯一标识获取Socket处理对象
		CSocketHandler* getSocketHandler(TUniqueIndex_t index);
    protected:
		// 重载基类的循环
        virtual bool doLoop(TDiffTime_t diff);

    public:
		// 添加监听
        bool addListener(CSocketListener* listener);
		// 添加链接
        bool addConnector(CSocketConnector* connector);

	public:
		// 主动关闭Socket
        void closeSocket(TUniqueIndex_t index, sint32 waitSecs);
	private:
		// 删除Socket
		void delSocket(TUniqueIndex_t index);
		// 添加Socket
        bool addSocket(CSocket* socket, CSocketHandler* handler);

	public:
		// 获取最小的网络循环对象
		CNetLoopWrap* getLeastNetLoop() const;
		// 获取所有的网络循环对象
		CNetLoopWrap** getAllNetLoopWrap() const;

    private:
		// 清理libevent事件
        void cleanEvent();
//		TUniqueIndex_t genUniqueIndex();

    private:
		// Accept事件
        static void OnAccept(TSocket_t fd, short evt, void* arg);
    private:
		// 有连接产生事件
        bool onAccept(CSocketListener* listener);

	private:
		virtual CModuleThreadLoopWrap* createLoopWrap();

    private:
        CNetModuleConfig        _config;					// 配置文件
        ListenerList            _listenerList;              // 监听列表
		THandlerHash			_handleHash;				// handler哈希表
		SocketEventBase_t*      _eventBase;					// libevent对象
    };
}


#endif