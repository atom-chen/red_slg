#ifndef _SOCKET_EVENT_LOOP_WRAP_H_
#define _SOCKET_EVENT_LOOP_WRAP_H_

#include "types_def.h"
#include "socket_util.h"
#include "socket_event_loop.h"

namespace GXMISC
{
    class CSocketHandler;
    class CNetSocketLoopWrapTask;
    class CNetSendPacketTask;
    class IThread;

    /**
    * @brief 网络循环包装器
    */
	class CNetLoopWrap : public CSimpleThreadLoopWrap
    {
		typedef CSimpleThreadLoopWrap TBaseType;

    public:
        CNetLoopWrap(CNetModule* mgr, sint32 msgNumPerBreath);
		virtual ~CNetLoopWrap();
	private:
		// 清零自身
		void _clearSelf();

	protected:
		// 帧循环
		virtual void onBreath(TDiffTime_t diff);

    public:
		// 得到用户数目
		virtual sint32 getUserNum() const;
		// 获取配置
		const CNetModuleConfig* getNetConfig() const;
	public:;
		// 获取Socket线程循环对象
        CSocketEventLoop*   getSocketEventLoop();

    public:
		// 添加Socket
        void    			addSocket(CSocket* socket, CSocketHandler* handler);
		// 删除Socket
        void    			delSocket(TUniqueIndex_t index);

	public:
		// 获取Socket处理对象
        CSocketHandler*		getSocketHandler(TUniqueIndex_t index);
		// 在所有列表中获取Socket处理对象
        CSocketHandler*		getSocketHandlerAll(TUniqueIndex_t index);
		// 获取网络管理模块
		CNetModule*			getNetLoopWrapMgr();

	public:
		// 初始化广播队列
		void initBroadcastQ(CSyncActiveQueue* loopInputQ, CSyncActiveQueue* loopOutputQ);

	protected:
		// 创建一个线程对象
		virtual CModuleThreadLoop* createThreadLoop();
		// 有线程对象产生
		virtual void onCreateThreadLoop(CModuleThreadLoop* threadLoop);
		
    public:
		// 关闭Socket
        void    closeSocket(TUniqueIndex_t index, sint32 waitSecs);
		// 写入消息
        void    writeMsg(const char* msg, sint32 len, TUniqueIndex_t index, const char* name=NULL);
		// 广播消息
		void	broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks);

	public:
		// 压入消息任务
		void    pushTask(CNetSocketLoopWrapTask* task, TUniqueIndex_t index);

    public:
		// 处理Socket的关闭
        void    handleCloseSocket(TUniqueIndex_t index);
		// 处理消息
        void    handlePacket(TUniqueIndex_t index, char* msg, sint32 len);
		// 添加Socket返回
        void    handleAddSocketRet(TUniqueIndex_t index);

    private:
		// 更新所有的Socket处理对象
		void    updateSocketHandlers(TDiffTime_t diff);

    private:
        sint32                  _msgNumPerBreath;           	// 每次循环处理的消息数
        THandlerHash			_handlerMap;					// 处理消息句柄
        CNetModule				*_netLoopMgr;               	// 网络管理器 (@TODO 以后废弃掉不用)

	private:
		CSocketEventLoop        _socketEventLoop;           	// 网络循环
		TSyncSocketQue          _newSocketQueue;           		// 新的Socket连接队列
    };
}

#endif