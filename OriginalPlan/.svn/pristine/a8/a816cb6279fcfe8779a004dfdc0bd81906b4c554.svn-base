#include "socket_listener.h"

namespace GXMISC
{
    CSocketListener::CSocketListener( CNetModule* loop, const char* ip, uint32 port, uint32 backlog /*= ACCEPT_ONCE_NUM*/ ) : CSocket(ip, port)
    {
        _backlog = backlog;
        _eventArg._loop = loop;
        _eventArg._listener = this;
    }

    CSocketListener::~CSocketListener()
    {
    }

    bool CSocketListener::start()
    {
        bool ret;
        ret = create( ) ;
        if( ret == false )
        {
            return false;
        }

        ret = setReuseAddr( ) ;
        if( ret == false )
        {
            return false;
        }

        ret = bind() ;
        if( ret == false )
        {
            return false;
        }

        ret = listen( _backlog ) ;
        if( ret == false )
        {
            return false;
        }
        
        setReuseAddr(true);
        setLinger(0);
        setNonBlocking(true);

        return true;
    }

    CSocket* CSocketListener::accept()
    {
        return CSocket::accept();
    }

    uint32 CSocketListener::getBacklog()
    {
        return _backlog;
    }

    TSocketEvent_t& CSocketListener::getListenEvent()
    {
        return _readEvent;
    }

    SMainLoopEventArg& CSocketListener::getListenEventArg()
    {
        return _eventArg;
    }
}   