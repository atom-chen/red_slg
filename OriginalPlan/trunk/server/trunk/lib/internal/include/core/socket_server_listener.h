#ifndef _SOCKET_SERVER_LISTENER_H_
#define _SOCKET_SERVER_LISTENER_H_

#include "socket_listener.h"
#include "socket_handler.h"

namespace GXMISC
{
    /**
    * @brief 监听连接过来的服务器socket, 如监听其他服务器的连接
    *        主要是服务器socket数据吞吐量都较大, 需要较大的缓冲区
    */
    class CSocketServerListener : public CSocketListener
    {
	protected:
        CSocketServerListener(CNetModule* loop, const char* ip, uint32 port, sint32 tag, uint32 backlog = ACCEPT_ONCE_NUM);
	public:
        virtual ~CSocketServerListener();
    public:
        virtual CSocket* accept(sint32 inputStreamLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 outputStreamLen = DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE,
            sint32 maxInputStreamLen = DISCONNECT_SOCKET_INPUT_SIZE, sint32 maxOutputStreamLen = DISCONNECT_SOCKET_OUTPUT_SIZE);

	protected:
		sint32 _socketHandlerTag;
    };

    template<typename SocketHandlerType, typename PacketHandlerType>
    class CDefaultSocketServerListener : public CSocketServerListener
    {
    public:
        CDefaultSocketServerListener(CNetModule* loop, const char* ip, uint32 port, sint32 tag, uint32 backlog = ACCEPT_ONCE_NUM)
			: CSocketServerListener(loop, ip, port, tag, backlog)
		{
		}
        ~CDefaultSocketServerListener(){}

    public:
        virtual TSocketParmHandler onAccept()
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

	template<typename SocketHandlerType, typename PacketHandlerType, typename P>
	class CDefaultSocketServerListener1 : public CSocketServerListener
	{
	public:
		CDefaultSocketServerListener1(CNetModule* loop, const char* ip, uint32 port, sint32 tag, P& p1, uint32 backlog = ACCEPT_ONCE_NUM)
			: CSocketServerListener(loop, ip, port, tag, backlog)
		{
			_p1 = p1;
		}
		~CDefaultSocketServerListener1(){}

	public:
		virtual TSocketParmHandler onAccept()
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

	protected:
		P _p1;
	};

	template<typename SocketHandlerType, typename PacketHandlerType, typename P, typename P2>
	class CDefaultSocketServerListener2 : public CSocketServerListener
	{
	public:
		CDefaultSocketServerListener2(CNetModule* loop, const char* ip, uint32 port, sint32 tag, P& p1, P2& p2, uint32 backlog = ACCEPT_ONCE_NUM)
			: CSocketServerListener(loop, ip, port, tag, backlog)
		{
			_p1 = p1;
			_p2 = p2;
		}
		~CDefaultSocketServerListener2(){}

	public:
		virtual TSocketParmHandler onAccept()
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

	protected:
		P _p1;
		P2 _p2;
	};
}

#endif