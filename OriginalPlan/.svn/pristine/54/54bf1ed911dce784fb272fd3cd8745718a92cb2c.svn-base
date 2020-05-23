#ifndef _SOCKET_SERVER_CONNECTOR_H_
#define _SOCKET_SERVER_CONNECTOR_H_

#include "socket_connector.h"
#include "socket_handler.h"

namespace GXMISC
{
    class CSocketServerConnector : public CSocketConnector
    {
	protected:
        CSocketServerConnector(sint32 tag, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = SERVER_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = SERVER_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SERVER_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SERVER_SOCKET_OUTPUT_SIZE);
	public:
        virtual ~CSocketServerConnector();
    };

    template<class SocketHandlerType, class PacketHandlerType>
    class CDefaultSocketServerConnector : public CSocketServerConnector
    {
	public:
        CDefaultSocketServerConnector(sint32 tag, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = SERVER_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = SERVER_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SERVER_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SERVER_SOCKET_OUTPUT_SIZE) 
            : CSocketServerConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen) {};
        ~CDefaultSocketServerConnector(){};

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
    class CDefaultSocketServerConnector1  : public CSocketServerConnector
    {
    public:
        CDefaultSocketServerConnector1(sint32 tag, P1& p1, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = SERVER_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = SERVER_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SERVER_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SERVER_SOCKET_OUTPUT_SIZE) 
            : CSocketServerConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen), _p1(p1) { };
        ~CDefaultSocketServerConnector1(){};

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
    private:
        P1 _p1;
    };

    template<class SocketHandlerType, class PacketHandlerType, typename P1, typename P2>
    class CDefaultSocketServerConnector2 : public CSocketServerConnector
    {
    public:
        CDefaultSocketServerConnector2(sint32 tag, P1& p1, P2& p2, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = SERVER_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = SERVER_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SERVER_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SERVER_SOCKET_OUTPUT_SIZE)
            :CSocketServerConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen),  _p1(p1), _p2(p2) { };
        ~CDefaultSocketServerConnector2(){};

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
    private:
        P1 _p1;
        P2 _p2;
    };

    template<class SocketHandlerType, class PacketHandlerType, typename P1, typename P2, typename P3>
    class CDefaultSocketServerConnector3 : public CSocketServerConnector
    {
    public:
        CDefaultSocketServerConnector3(sint32 tag, P1& p1, P2& p2, P3& p3, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = SERVER_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = SERVER_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SERVER_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SERVER_SOCKET_OUTPUT_SIZE)
            :CSocketServerConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen), _p1(p1), _p2(p2), _p3(p3) {};
        ~CDefaultSocketServerConnector3(){};

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
    private:
        P1 _p1;
        P2 _p2;
        P3 _p3;
    };

    template<class SocketHandlerType, class PacketHandlerType, typename P1, typename P2, typename P3, typename P4>
    class CDefaultSocketServerConnector4 : public CSocketServerConnector
    {
    public:
        CDefaultSocketServerConnector4(sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = SERVER_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = SERVER_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SERVER_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SERVER_SOCKET_OUTPUT_SIZE)
            :CSocketServerConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen), _p1(p1), _p2(p2), _p3(p3), _p4(p4) {};
        ~CDefaultSocketServerConnector4(){}

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
    private:
        P1 _p1;
        P2 _p2;
        P3 _p3;
        P4 _p4;
    };

    template<class SocketHandlerType, class PacketHandlerType, typename P1, typename P2, typename P3, typename P4, typename P5>
    class CDefaultSocketServerConnector5 : public CSocketServerConnector
    {
    public:
        CDefaultSocketServerConnector5(sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, P5& p5, CSocketEventLoop* loop = NULL, sint32 inputStreamLen = SERVER_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = SERVER_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SERVER_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SERVER_SOCKET_OUTPUT_SIZE)
            : CSocketServerConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen), _p1(p1), _p2(p2), _p3(p3), _p4(p4), _p5(p5) {};
        ~CDefaultSocketServerConnector5(){};

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
    private:
        P1 _p1;
        P2 _p2;
        P3 _p3;
        P4 _p4;
        P5 _p5;
    };
}

#endif