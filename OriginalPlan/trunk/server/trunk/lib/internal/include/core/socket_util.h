#ifndef _SOCKET_UTIL_H_
#define _SOCKET_UTIL_H_

#include "types_def.h"
#include "base_util.h"

#if defined(OS_WINDOWS)
#elif defined(OS_UNIX)
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <fcntl.h>
#endif

#include "event.h"
#include "event2/event.h"
#include "base_util.h"
#include "hash_util.h"

namespace GXMISC
{
#define _ESIZE 256

#if defined(OS_UNIX)
    typedef		sint32	TSocket_t;
#define         INVALID_SOCKET   -1
#define		    SOCKET_ERROR	 -1
#elif defined(OS_WINDOWS)
    typedef     SOCKET TSocket_t;
	typedef		sint32	 socklen_t;
#endif

#ifdef OS_UNIX
    DStaticAssert(sizeof(socklen_t) == sizeof(uint32));
#endif

#define IP_SIZE			24

    typedef unsigned long       TIP_t;
    typedef struct sockaddr     SOCKADDR;
    typedef struct sockaddr_in  SOCKADDR_IN;

    static const sint32 SOCKET_ERROR_WOULDBLOCK = -100;                     // 阻塞
    static const uint32 SOCKADDR_IN_LEN = sizeof(SOCKADDR_IN);              // 地址长度

    /// 网络错误码定义
#ifdef OS_WINDOWS
#define gx_socket_errno WSAGetLastError()
#elif defined(OS_UNIX)
#define gx_socket_errno errno
#endif

    //初始化的接收缓存长度
#define DEFAULT_SOCKET_INPUT_BUFFER_SIZE 64*1024
    //最大可以允许的缓存长度，如果超过此数值，则断开连接
#define DISCONNECT_SOCKET_INPUT_SIZE 10*1024*1024
    // 警告值
#define WARNING_SOCKET_INPUT_SIZE 5*1024*1024

    //初始化的发送缓存长度
#define DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE 64*1024
    //最大可以允许的缓存长度，如果超过此数值，则断开连接
#define DISCONNECT_SOCKET_OUTPUT_SIZE 10*1024*1024
    // 警告值
#define WARNING_SOCKET_OUTPUT_SIZE 5*1024*1024

    // 服务器socket接收缓存长度
#define SERVER_SOCKET_INPUT_BUFFER_SIZE 50*1024*1024
    // 服务器socket接收缓存最大可以允许长度, 如果超过此数值, 则断开连接
#define DISCONNECT_SERVER_SOCKET_INPUT_SIZE 200*1024*1024

    // 服务器socket发送缓存长度
#define SERVER_SOCKET_OUTPUT_BUFFER_SIZE 50*1024*1024
    // 服务器socket发送缓存最大可以允许长度, 如果超过此数值, 则断开连接
#define DISCONNECT_SERVER_SOCKET_OUTPUT_SIZE 200*1024*1024

    // @todo 等待socket关闭的时间
#define DEFAULT_CLOSE_SOCKET_WAIT_SECS 0
    
    // @todo 写成配置文件
#define PROFILE_SOCKET_SECONDS 10
#define PROFILE_LOOP_SOCKET_SECONDS 1

	// 一帧发送数据的缓冲区最大长度
#define SOCKET_HANDLER_BUFF_LEN 1024*100

	// 每次Accept时接收的最大连接数
#define ACCEPT_ONCE_NUM 500

		// 最大可以等待的时间
#define MAX_CLOSE_SOCK_WAIT_SECS 20

	// 最大的Socket线程个数(@TODO 所有地方保持一致)
#define MAX_SOCK_THREAD_NUM 20

    class CSocket;
    class CMsgBlock;
    class CSocketEventLoop;
    class CSocketConnector;
    class CSocketInputStream;
    class CSocketOutputStream;
    class CNetModule;
    class CSocketListener;
	class CSocketHandler;

    typedef struct event        TSocketEvent_t;
    typedef struct event_base   SocketEventBase_t;

    typedef std::list<CSocket*>                         SocketList;
    typedef CHashMap<TUniqueIndex_t, CSocket*>          TSocketHash;
	typedef CHashMap<TUniqueIndex_t, CSocketHandler*>   THandlerHash;
    typedef std::list<CSocketListener*>                 ListenerList;

    class CSocketEventLoop;
    struct SSocketLoopEventArg
    {
        CSocketEventLoop* _loop;      
        CSocket* _socket;
    };

    class CNetModule;
    struct SMainLoopEventArg
    {
        CNetModule* _loop;      
        CSocketListener* _listener;
    };
}

#endif