#ifndef _SOCKET_H_
#define _SOCKET_H_

#include "types_def.h"
#include "socket_api.h"
#include "socket_util.h"
#include "socket_input_stream.h"
#include "socket_output_stream.h"
#include "base_util.h"
#include "mutex.h"
#include "socket_packet_handler.h"

namespace GXMISC
{
	// @TODO 重新整理接口并检查异常处理是否完整
    class CSocket 
    {
    public:
        CSocket (CSocketEventLoop* loop = NULL, sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE);
        CSocket (const char* host, sint32 port, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE,
            sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE, sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE,
            sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE);

        virtual ~CSocket ();

    public:
        virtual bool onRead();
        virtual bool onWrite();

        sint32 write(const char* msg, sint32 len);
        sint32 read(char* msg, sint32 len);

        CSocketInputStream* getInputStream();
        CSocketOutputStream* getOutputStream();

		void cleanUp(CSocketEventLoop* loop);

    public:
        // 判断当前
        TThreadID_t getThreadID();
        // 需要写入
        bool isNeedWrite();
        // 唯一索引
        TUniqueIndex_t getUniqueIndex();
        void setUniqueIndex(TUniqueIndex_t index);
        // 读写事件
        TSocketEvent_t& getReadEvent();
        TSocketEvent_t& getWriteEvent();
        SSocketLoopEventArg& getReadEventArg();
        SSocketLoopEventArg& getWriteEventArg();

        void setSocketEventLoop(CSocketEventLoop* loop);
        CSocketEventLoop* getSocketEventLoop();

        void setPacketHandler(ISocketPacketHandler* handler);
        ISocketPacketHandler* getPacketHandler();
        bool canUnpacket();
		bool unpacket(CNetSocketLoopTask* task, char* packBuff, sint32 packBuffLen, char* packBuffTempRead, sint32 packBuffTempReadLen);
		sint32 getUnpacketNum();

    protected :
        bool connect (const char* host, sint32 port, sint32 diff);
        bool reconnect (const char* host, sint32 port, sint32 diff);

        CSocket* accept(sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE);

        bool bind( );
        bool bind( sint32 port );
        bool listen( sint32 backlog );
	
		void getLocalAddr();

	private:
		void onAcceptSocket();
		void onConnectSocket(const char* host, sint32 port);

    public :
		// Local Addr
        void setAddr(const char* host, sint32 port);
        void setAddr(SOCKADDR_IN addr);
		
		// Remote Addr
		void setRemoteAddr(const char* host, sint32 port);
		void setRemoteAddr(SOCKADDR_IN addr);

        // send data to peer
        sint32 send (const void* buf, sint32 len, sint32 flags = 0) ;

        // receive data from peer
        sint32 receive (void* buf, sint32 len, sint32 flags = 0) ;
		
		// 当前Socket是数据可读
        sint32 available () const ;
		
		// 创建一个socket
        bool create() ;

        // close connection
        void close () ;
	
		// 重置
        void reset();

        // get/set socket's linger status
        sint32 getLinger ()const ;
        bool setLinger (sint32 lingertime) ;

        bool isReuseAddr ()const ;
        bool setReuseAddr (bool on = true) ;

        // get is Error
        sint32 getSockError() const ;
        bool isSockError() const ;

        // get/set socket's nonblocking status
        bool isNonBlocking ()const ;
        bool setNonBlocking (bool on = true) ;

        // get/set receive buffer size
        sint32 getReceiveBufferSize ()const ;
        bool setReceiveBufferSize (sint32 size) ;

        // get/set send buffer size
        sint32 getSendBufferSize ()const ;
        bool setSendBufferSize (sint32 size) ;

		// get local address
        sint32 getPort () const ;
        TIP_t getHostIP () const ;
		std::string getHostIPStr() const;
		
		// get remote address
		sint32 getRemotePort () const ;
		TIP_t getRemoteHostIP () const ;
		std::string getRemoteHostIPStr() const;

        // check if socket is valid
        bool isValid ()const ;

        // get socket descriptor
        TSocket_t   getSocket () const ;
        void        setSocket(TSocket_t id);

        // 获取缓冲区长度
        sint32 getInputLen();
        sint32 getOutputLen();

		// 是否活动链接
		void setActive(bool flag);
		bool isActive();

		// 等待关闭时间
		uint32 getWaitCloseSecs();
		void setWaitCloseSecs(uint32 secs);
		bool needDel();

    protected :
        // Socket句柄
        TSocket_t _socket;

        // 本地地址
        SOCKADDR_IN _socketAddr;
        char m_Host[IP_SIZE+1];
        sint32 m_Port;

		// 远程服务地址
		SOCKADDR_IN _remoteSocketAddr;
		char m_remoteHost[IP_SIZE+1];
		sint32 m_remotePort;

		// 统计信息
        std::string strProfile;

        // 事件
        TSocketEvent_t _readEvent;
        SSocketLoopEventArg _readEventArg;
        TSocketEvent_t _writeEvent;
        SSocketLoopEventArg _writeEventArg;

        // 唯一索引
        TUniqueIndex_t _index;
        // 创建此socket的线程
        TThreadID_t _threadID;
        // 读流
        CSocketInputStream  _inputStream;
        // 写流
        CSocketOutputStream _outputStream;
        // socket 包处理
        ISocketPacketHandler* _packetHandler;
		// 解包时间
		TTime_t _lastUnpacketTime;
		// 解包个数
		sint32 _unpacketNum;
		// 是否还存活
		bool _activeFlag;
		// 等待关闭时间(s)
		uint32 _waitCloseSecs;
		uint32 _waitCloseStartTime;

        DFastObjToString4Alias(CSocket, TUniqueIndex_t, SocketIndex, _index, TThreadID_t,
            ThreadID, _threadID, uint32, InputLen, getInputLen(), uint32, OutputLen, getOutputLen());
    };
}

#endif