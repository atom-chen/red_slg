#ifndef _SOCKET_EVENT_LOOP_H_
#define _SOCKET_EVENT_LOOP_H_

#include "types_def.h"
#include "socket_util.h"
#include "socket.h"
#include "msg_queue.h"
#include "thread.h"
#include "net_task.h"
#include "socket_packet_handler.h"
#include "module_base.h"

namespace GXMISC
{
    typedef CMsgQueue<CSocket*> TSyncSocketQue;
	typedef std::list<TUniqueIndex_t> TDelSockList;
    class CNetLoopWrap;
	class CNetModuleConfig;

	// Socket线程循环对象
	class CSocketEventLoop : public CModuleThreadLoop
    {
		typedef CModuleThreadLoop TBaseType;

    public:
        CSocketEventLoop();
        ~CSocketEventLoop();
	private:
		// 清零自身
		void _clearSelf();

	public:
		// 初始化
		virtual bool init();
		// 清理数据
		virtual void cleanUp();

	protected:
		// 每帧循环事件
		virtual bool onBreath();
		// 处理一个输入任务
		virtual void onHandleTask(CTask* task);
		// 在运行前初始化
		virtual void initBeforeRun();
		// 停止事件
		virtual void onStop();
	public:
		// 是否已经停止消息处理
		bool isStopMsgHandle();
		// 设置停止消息处理
		void stopMsgHandle();
		// 设置新连接消息队列
		void setNewSocketQueue(TSyncSocketQue* newSocketQ);
		// 设置每帧能够处理的消息数
		void setMsgPerFrame(uint32 msgPerFrame);
		// 设置广播队列
		void setBroadCastQ(CSyncActiveQueue* inputQ, CSyncActiveQueue* outputQ);
		// 获取广播任务队列
		CSyncActiveQueueWrap* getBroadcastQWrap();

	public:
		// 向队列中压入消息
        void pushTask(CNetSocketLoopTask* task, TUniqueIndex_t index);

    private:
        // 删除所有的socket
        void clearEvent();
		// 将Socket数据写入流
        void clearFlushStream();
		// 清理Socket
        void clearSocket();
		// 清理循环对象中所有成员
        void clearLoop();
		// 断言Socket
        void assertSocket(TUniqueIndex_t index, bool flag);
		// 通过索引获取Socket
        CSocket* getSocket(TUniqueIndex_t index);

	private:
		// 写入事件
        static void OnWriteEvent(TSocket_t fd, short evt, void* arg);
		// 读取事件
        static void OnReadEvent(TSocket_t fd, short evt, void* arg);

    private:
		// 写入事件
        void onWrite(CSocket* socket);
		// 读取事件
        void onRead(CSocket* socket);

    private:
		// @检查Socket大小通过发送或接收消息事件来输出
        void doSocketProfile(); 
		// 执行循环统计
        void doLooProfile(); 
		
	private:
		// 接收到一个协议
		void onRecvPacket(const char* msg, uint32 len);

        // 定时更新
    private:
		// 处理新的Socket连接, 从其他线程发送过来的
        void handleNewSocket(TDiffTime_t diff);
		// 处理广播消息
		void handleBroadcastMsg(TDiffTime_t diff);
		// 执行统计
        void handleProfile(TDiffTime_t diff);
		// 处理Socket解包操作
		void handleSocketUnPacket(TDiffTime_t diff);
		// 处理需要等待删除的Socket
		void handleWaitDelSocket(TDiffTime_t diff);
		// 更新循环状态
		void updateLoopState(TDiffTime_t diff);
		// 处理Socket事件
		bool handleEventLoop(TDiffTime_t diff);

    public:
		// 处理删除Socket
        void handleDelSocket(TUniqueIndex_t index, sint32 waitCloseSecs, sint32 noDataNeedDel);
		// 处理发送消息
        void handleWriteMsg(TUniqueIndex_t index, char* msg, uint32 len);

    private:
		// 发送添加Socket返回
        void sendAddSocketRet(TUniqueIndex_t index);
		// 发送关闭Socket
        void sendCloseSocket(TUniqueIndex_t index);

    private:
		// 处理Socket的关闭
        void handleCloseSocket(CSocket* socket, bool writeFlag);
		// 处理Socket的解包
        void handleUnPacket(CSocket* socket);
		
	private:
		/**
		* @brief 添加连接
		*        如果添加失败则必须销毁此连接 @TODO
		*/
		void addSocket(CSocket* socket);
		// 删除Socket
		void delSocket(CSocket* socket);

	private:
		// 生成名字
		void genName();

    private:
		CNetModuleConfig*       _config;					// 配置文件 @TODO 去掉这个配置
        TSyncSocketQue          *_newSocketQueue;           // 新连接队列
		CSyncActiveQueueWrap	_broadcastTaskQueue;		// 广播队列
        TSocketHash				_socketMgr;                 // socket管理
        SocketEventBase_t*      _base;                      // libevent base
        uint32                  _msgPerFrame;               // 每帧每个socket解析的协议包
        uint32                  _frameSleepDiff;            // 每帧暂停时间
        bool                    _stopHandleMsg;             // 停止处理消息标记
		TDelSockList			_delSockList;				// 等待删除的Socket
		char*					_packHandleBuff;			// 用于写包处理的Buff缓冲
		char*					_packHandleTempReadBuff;	// 用于读包的临时缓冲区

		uint32					_totalSendMsgCount;			// 发送消息的个数
		uint32					_totalRecvMsgCount;			// 接收消息的个数
		uint32					_averageSendMsgCount;		// 平均消息个数
		uint32					_averageRecvMsgCount;		// 平均接收消息个数
		uint32					_maxSendMsgLen;				// 最长的发送消息包
		uint32					_maxRecvMsgLen;				// 最长的接收消息包
		uint32					_totalSendMsgLen;			// 总的发送消息字节数
		uint32					_totalRecvMsgLen;			// 总的接收消息字节数
		uint32					_averageSendFlow;			// 平均发送流量
		uint32					_averageRecvFlow;			// 平均接收流量
        uint32					_remainOutputLen;			// 剩余输出长度
        uint32					_remainInputLen;			// 剩余读取长度
        uint32					_outputCapacity;			// 输出缓冲区总大小
        uint32					_inputCapacity;				// 输入缓冲区总大小

        TTime_t                 _lastProfileTime;           // 上次统计时间
		std::string				_strSocketProfile;			// Socket统计信息
		std::string				_strLoopProfile;			// 循环统计信息
    };
}

#endif