#ifndef _SOCKET_LISTENER_H_
#define _SOCKET_LISTENER_H_

#include "types_def.h"
#include "socket.h"
#include "socket_handler.h"
#include "socket_util.h"

namespace GXMISC
{
    /**
    * @brief 监听Socket 
    */
    class CSocketListener : public CSocket
    {
	protected:
        CSocketListener (CNetModule* loop, const char* ip, uint32 port, uint32 backlog = ACCEPT_ONCE_NUM);
	public:
        virtual ~CSocketListener () ;

    public :
        bool             start();
        virtual CSocket* accept();
        uint32           getBacklog();
    public:
        virtual TSocketParmHandler onAccept() = 0;

	public:
		TSocketEvent_t&         getListenEvent();
		SMainLoopEventArg&      getListenEventArg();

    private:
        uint32 _backlog;                        // 同时能接受连接的数目
        SMainLoopEventArg _eventArg;            // 事件参数
    };

    template<typename SocketHandlerType, typename PacketHandlerType, sint32 tag>
    class CDefaultSocketListener : public CSocketListener
    {
    public:
        CDefaultSocketListener(CNetModule* loop, const char* ip, uint32 port, uint32 backlog = 50);
        ~CDefaultSocketListener();

    public:
        virtual TSocketParmHandler onAccept();
    };

    template<typename SocketHandlerType, typename PacketHandlerType, sint32 tag>
    GXMISC::CDefaultSocketListener<SocketHandlerType, PacketHandlerType, tag>::~CDefaultSocketListener()
    {
    }

    template<typename SocketHandlerType, typename PacketHandlerType, sint32 tag>
    GXMISC::CDefaultSocketListener<SocketHandlerType, PacketHandlerType, tag>::CDefaultSocketListener( CNetModule* loop, const char* ip, uint32 port, uint32 backlog /*= 5*/ )
        : CSocketListener(loop, ip, port, backlog)
    {
    }

    template<typename SocketHandlerType, typename PacketHandlerType, sint32 tag>
    TSocketParmHandler GXMISC::CDefaultSocketListener<SocketHandlerType, PacketHandlerType, tag>::onAccept()
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

        return TSocketParmHandler(socketHandler, packetHandler, tag);
    }
}

#endif