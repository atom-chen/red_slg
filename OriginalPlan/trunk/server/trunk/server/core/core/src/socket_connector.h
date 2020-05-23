#ifndef _SOCKET_CONNECTOR_H_
#define _SOCKET_CONNECTOR_H_

#include "types_def.h"
#include "socket.h"
#include "socket_handler.h"
#include "debug.h"
#include "socket_util.h"

namespace GXMISC
{
	class CSocketConnector : public CSocket
	{
	protected:
		CSocketConnector(sint32 tag, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE,
			sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE);
	public:
		virtual ~CSocketConnector();

    public:
        // 必须为new的handler, 在以后的管理中会释放此handler
        virtual TSocketParmHandler getHandler() = 0;

    public:
		bool connect(const char* host, TPort_t port, uint32 diff);
		bool reconnect(const char* host, TPort_t port, uint32 diff);

	public:
		void setReconnectDiff(TDiffTime_t diff);
		TDiffTime_t getReconnectDiff();
		std::string getServerIP() const { return _serverIP; }
		void setServerIP(std::string val) { _serverIP = val; }
		GXMISC::TPort_t getServerPort() const { return _serverPort; }
		void setServerPort(GXMISC::TPort_t val) { _serverPort = val; }
		void updateLastConnectTime();
		bool canReconnect();
		GXMISC::TDiffTime_t getConnectDiff() const { return _connectDiff; }
		void setConnectDiff(GXMISC::TDiffTime_t val) { _connectDiff = val; }

	public:
		virtual std::string toString(){ return ""; }

	protected:
		TDiffTime_t _connectDiff;
		TDiffTime_t _reconnectDiff;
		std::string _serverIP;
		TPort_t _serverPort;
		TGameTime_t _lastConnectTime;
		sint32 _socketHandlerTag;
	};

	typedef std::set<CSocketConnector*> TSocketConnectorQue;

    template<class SocketHandlerType, class PacketHandlerType>
    class CDefaultSocketConnector : public CSocketConnector
    {
    public:
        CDefaultSocketConnector(sint32 tag, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE) 
            : CSocketConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen) {};
        ~CDefaultSocketConnector(){};

    public:
        virtual TSocketParmHandler getHandler()
        {
            CSocketHandler* socketHandler = new SocketHandlerType();
            gxAssert(socketHandler != NULL);
            if(socketHandler == NULL)
            {
                return TSocketParmHandler();
            }

            socketHandler->setNeedFree();
            ISocketPacketHandler* packetHandler = new PacketHandlerType();
            if(packetHandler == NULL)
            {
                DSafeDelete(socketHandler);
                return TSocketParmHandler();
            }

            gxAssert(packetHandler != NULL);
            packetHandler->setNeedFree();

            return TSocketParmHandler(socketHandler, packetHandler, _socketHandlerTag);
        }
    };

    template<class SocketHandlerType, class PacketHandlerType, typename P1>
    class CDefaultSocketConnector1 : public CSocketConnector
    {
    public:
        CDefaultSocketConnector1(sint32 tag, P1& p1,CSocketEventLoop* loop = NULL, sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE) 
            :  CSocketConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen), _p1(p1) { };
        ~CDefaultSocketConnector1(){};
    public:
        virtual TSocketParmHandler getHandler()
        {
            CSocketHandler* socketHandler = new SocketHandlerType(_p1);
            gxAssert(socketHandler != NULL);
            if(socketHandler == NULL)
            {
                return TSocketParmHandler();
            }

            socketHandler->setNeedFree();
            ISocketPacketHandler* packetHandler = new PacketHandlerType();
            if(packetHandler == NULL)
            {
                DSafeDelete(socketHandler);
                return TSocketParmHandler();
            }

            gxAssert(packetHandler != NULL);
            packetHandler->setNeedFree();

            return TSocketParmHandler(socketHandler, packetHandler, _socketHandlerTag);
        }

		virtual std::string toString(){ return gxToString("Param=%s", gxToString(_p1).c_str()); }

    private:
        P1 _p1;
    };

    template<class SocketHandlerType, class PacketHandlerType, typename P1, typename P2>
    class CDefaultSocketConnector2 : public CSocketConnector
    {
    public:
        CDefaultSocketConnector2(sint32 tag, P1& p1, P2& p2, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE)
            : CSocketConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen), _p1(p1), _p2(p2) { };
        ~CDefaultSocketConnector2(){};

    public:
        virtual TSocketParmHandler getHandler()
        {
            CSocketHandler* socketHandler = new SocketHandlerType(_p1, _p2);
            gxAssert(socketHandler != NULL);
            if(socketHandler == NULL)
            {
                return TSocketParmHandler();
            }

            socketHandler->setNeedFree();
            ISocketPacketHandler* packetHandler = new PacketHandlerType();
            if(packetHandler == NULL)
            {
                DSafeDelete(socketHandler);
                return TSocketParmHandler();
            }

            gxAssert(packetHandler != NULL);
            packetHandler->setNeedFree();

           return TSocketParmHandler(socketHandler, packetHandler, _socketHandlerTag);
        }

		virtual std::string toString(){ return gxToString("Param=%s,Param2=%s", gxToString(_p1).c_str(), gxToString(_p2).c_str()); }
    private:
        P1 _p1;
        P2 _p2;
    };

    template<class SocketHandlerType, class PacketHandlerType, typename P1, typename P2, typename P3>
    class CDefaultSocketConnector3 : public CSocketConnector
    {
    public:
        CDefaultSocketConnector3(sint32 tag, P1& p1, P2& p2, P3& p3, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE)
            : CSocketConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen),_p1(p1), _p2(p2), _p3(p3) {};
        ~CDefaultSocketConnector3(){};

    public:
        virtual TSocketParmHandler getHandler()
        {
            CSocketHandler* socketHandler = new SocketHandlerType(_p1, _p2, _p3);
            gxAssert(socketHandler != NULL);
            if(socketHandler == NULL)
            {
                return TSocketParmHandler();
            }

            socketHandler->setNeedFree();
            ISocketPacketHandler* packetHandler = new PacketHandlerType();
            if(packetHandler == NULL)
            {
                DSafeDelete(socketHandler);
                return TSocketParmHandler();
            }

            gxAssert(packetHandler != NULL);
            packetHandler->setNeedFree();

            return TSocketParmHandler(socketHandler, packetHandler, _socketHandlerTag);
        }

		virtual std::string toString(){ return gxToString("Param=%s,Param2=%s,Param3=%s",
			gxToString(_p1).c_str(), gxToString(_p2).c_str(), gxToString(_p3).c_str()); }
    private:
        P1 _p1;
        P2 _p2;
        P3 _p3;
    };

    template<class SocketHandlerType, class PacketHandlerType, typename P1, typename P2, typename P3, typename P4>
    class CDefaultSocketConnector4 : public CSocketConnector
    {
    public:
        CDefaultSocketConnector4(sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE) 
            : CSocketConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen), _p1(p1), _p2(p2), _p3(p3), _p4(p4) {};
        ~CDefaultSocketConnector4(){};

    public:
        virtual TSocketParmHandler getHandler()
        {
            CSocketHandler* socketHandler = new SocketHandlerType(_p1, _p2, _p3, _p4);
            gxAssert(socketHandler != NULL);
            if(socketHandler == NULL)
            {
                return TSocketParmHandler();
            }

            socketHandler->setNeedFree();
            ISocketPacketHandler* packetHandler = new PacketHandlerType();
            if(packetHandler == NULL)
            {
                DSafeDelete(socketHandler);
                return TSocketParmHandler();
            }

            gxAssert(packetHandler != NULL);
            packetHandler->setNeedFree();

            return TSocketParmHandler(socketHandler, packetHandler, _socketHandlerTag);
        }

		virtual std::string toString(){ return gxToString("Param=%s,Param2=%s,Param3=%s,Param4=%s",
			gxToString(_p1).c_str(), gxToString(_p2).c_str(), gxToString(_p3).c_str(), gxToString(_p4).c_str()); }

    private:
        P1 _p1;
        P2 _p2;
        P3 _p3;
        P4 _p4;
    };

    template<class SocketHandlerType, class PacketHandlerType, typename P1, typename P2, typename P3, typename P4, typename P5>
    class CDefaultSocketConnector5 : public CSocketConnector
    {
    public:
        CDefaultSocketConnector5(sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, P5& p5, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE) 
            : CSocketConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen), _p1(p1), _p2(p2), _p3(p3), _p4(p4), _p5(p5) {};
        ~CDefaultSocketConnector5(){};

    public:
        virtual TSocketParmHandler getHandler()
        {
            CSocketHandler* socketHandler = new SocketHandlerType(_p1, _p2, _p3, _p4, _p5);
            gxAssert(socketHandler != NULL);
            if(socketHandler == NULL)
            {
                return TSocketParmHandler();
            }

            socketHandler->setNeedFree();
            ISocketPacketHandler* packetHandler = new PacketHandlerType();
            if(packetHandler == NULL)
            {
                DSafeDelete(socketHandler);
                return TSocketParmHandler();
            }

            gxAssert(packetHandler != NULL);
            packetHandler->setNeedFree();

            return TSocketParmHandler(socketHandler, packetHandler, _socketHandlerTag);
        }

		virtual std::string toString(){ return gxToString("Param=%s,Param2=%s,Param3=%s,Param4=%s,Param5=%s",
			gxToString(_p1).c_str(), gxToString(_p2).c_str(), gxToString(_p3).c_str(), gxToString(_p4).c_str(), gxToString(_p5).c_str()); }

    private:
        P1 _p1;
        P2 _p2;
        P3 _p3;
        P4 _p4;
        P5 _p5;
    };
}

#endif