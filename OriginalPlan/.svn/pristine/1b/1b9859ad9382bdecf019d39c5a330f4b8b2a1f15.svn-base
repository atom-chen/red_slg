#ifndef _SOCKET_API_H_
#define _SOCKET_API_H_

#include "types_def.h"
#include "socket_errno.h"
#include "socket_util.h"
#include "base_util.h"
#include "time_val.h"

namespace GXMISC
{
    namespace SOCKET_API
    {
        TSocket_t gx_socket (sint32 domain, sint32 type, sint32 protocol) ;

        bool gx_bind (TSocket_t s, const struct sockaddr* name, sint32 namelen) ;

        bool gx_connect (TSocket_t s, const struct sockaddr* name, sint32 namelen) ;
        // 可以指定超时时间
        bool gx_connect2(TSocket_t s, const struct sockaddr* name, sint32 namelen, sint32 diff) ;

        bool gx_listen (TSocket_t s, sint32 backlog) ;

        TSocket_t gx_accept (TSocket_t s, struct sockaddr* addr, uint32* addrlen) ;

        bool gx_getsockopt (TSocket_t s, sint32 level, sint32 optname, void* optval, uint32* optlen) ;

        sint32 gx_getsockopt2 (TSocket_t s, sint32 level, sint32 optname, void* optval, uint32* optlen) ;

        bool gx_setsockopt (TSocket_t s, sint32 level, sint32 optname, const void* optval, sint32 optlen) ;

        sint32 gx_send (TSocket_t s, const void* buf, sint32 len, sint32 flags) ;

        sint32 gx_sendto (TSocket_t s, const void* buf, sint32 len, sint32 flags, const struct sockaddr* to, sint32 tolen) ;

        sint32 gx_recv (TSocket_t s, void* buf, sint32 len, sint32 flags) ;

        sint32 gx_recvfrom (TSocket_t s, void* buf, sint32 len, sint32 flags, struct sockaddr* from, uint32* fromlen) ;

        bool gx_closesocket (TSocket_t s) ;

        bool gx_ioctlsocket (TSocket_t s, long cmd, unsigned long* argp) ;

        bool gx_getsocketnonblocking (TSocket_t s) ;

        bool gx_setsocketnonblocking (TSocket_t s, bool on) ;

        sint32 gx_availablesocket (TSocket_t s) ;

        bool gx_shutdown (TSocket_t s, sint32 how) ;

        sint32 gx_select (TSocket_t maxfdp1, fd_set* readset, fd_set* writeset, fd_set* exceptset, TTimeVal_t* timeout) ;
    }
}

#endif