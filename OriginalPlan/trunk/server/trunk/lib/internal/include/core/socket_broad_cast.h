#ifndef _SOCKET_BROAD_CAST_H_
#define _SOCKET_BROAD_CAST_H_

#include "module_base.h"

namespace GXMISC
{
	class CNetLoopWrap;
	
	// 网络广播(用于聊天或对顺序没有要求的广播协议)
	class CSocketBroadCast : public CModuleThreadLoop
	{
		typedef CModuleThreadLoop TBaseType;

	public:
		CSocketBroadCast();
		~CSocketBroadCast();

	public:
		// 初始化(分配线程等)
		virtual bool init();
		// 清理
		virtual void cleanUp();
	
	public:
		// 设置网络封装对象
		void setNetLoopWraps(CNetLoopWrap** wraps, sint32 wrapNum);

	protected:
		// 在Run之前初始化
		virtual void initBeforeRun();
		// 帧循环
		virtual bool onBreath();
		// 停止处理
		virtual void onStop();
	public:
		// 广播消息
		void broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks);
	private:
		// 广播消息
		void broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks, CNetLoopWrap* wrap, uint32 index);

	private:
		std::vector<CNetLoopWrap*> _netWraps;						///< 主逻辑线程Socket包装层列表
		std::vector<CSyncActiveQueueWrap>	_sockTaskQueueWrap;		///< 底层多线程任务队列

	private:
		std::vector<CSyncActiveQueue>     _sockLoopInputQ;			///< 底层多线程输入队列
		std::vector<CSyncActiveQueue>     _sockLoopOutputQ;			///< 底层多线程输出队列
	};

	class CNetBroadcastModule;
	// 广播线程封装对象
	class CNetBroadcastWrap : public CSimpleThreadLoopWrap
	{
		typedef CSimpleThreadLoopWrap TBaseType;

	public:
		CNetBroadcastWrap(CNetBroadcastModule* moduleMgr);
		~CNetBroadcastWrap();

	public:
		// 广播消息
		void broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks);

	protected:
		// 创建一个线程对象
		virtual CModuleThreadLoop* createThreadLoop();
	protected:
		// 有线程对象产生
		virtual void onCreateThreadLoop(CModuleThreadLoop* threadLoop);

	private:
		CSocketBroadCast _broadcastThread;	///< 广播线程
	};

	// 广播模块
	class CNetBroadcastModule : public CModuleBase
	{
	public:
		CNetBroadcastModule(const std::string& moduleName = "SocketBroadCastModule");
		~CNetBroadcastModule();
	
	public:
		// 广播消息
		void broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks);

	private:
		// 创建循环对象
		virtual CModuleThreadLoopWrap* createLoopWrap();

	private:
		IModuleConfig _config;
	};
}

#endif // _SOCKET_BROAD_CAST_H_