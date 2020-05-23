#include "stdcore.h"
#include "file_api.h"

#ifdef OS_WINDOWS
#include <io.h>			// for _open()
#include <fcntl.h>		// for _open()/_close()/_read()/_write()...
#include <string.h>		// for memcpy()
#elif defined(OS_UNIX)
#include <sys/types.h>	// for open()
#include <sys/stat.h>	// for open()
#include <unistd.h>		// for fcntl()
#include <fcntl.h>		// for fcntl()
#include <sys/ioctl.h>	// for ioctl()
#include <errno.h>		// for errno
#endif

namespace GXMISC
{
    sint32 FILE_API::gx_open ( const char * filename , sint32 flags ) 
    {
#ifdef OS_UNIX
        sint32 fd = open(filename,flags);
#elif defined(OS_WINDOWS)
        sint32 fd = _open(filename,flags);
#endif
        if ( fd < 0 )
        {
#if defined(OS_UNIX)
            switch ( errno ) 
            {
            case EEXIST : 
            case ENOENT  : 
            case EISDIR : 
            case EACCES : 
            case ENAMETOOLONG : 
            case ENOTDIR : 
            case ENXIO   : 
            case ENODEV  : 
            case EROFS   : 
            case ETXTBSY : 
            case EFAULT  : 
            case ELOOP   : 
            case ENOSPC  : 
            case ENOMEM  : 
            case EMFILE  : 
            case ENFILE  : 
            default :
                {
                    break;
                }
            }//end of switch
#elif defined( OS_WINDOWS )
            // ...
#endif
        }

        return fd;
    }

    sint32 FILE_API::gx_open ( const char * filename , sint32 flags , sint32 mode ) 
    {
#if defined(OS_UNIX)
        sint32 fd = open(filename,flags,mode);
#elif defined( OS_WINDOWS )
        sint32 fd = _open(filename,flags,mode);
#endif

        if ( fd < 0 )
        {
#if defined(OS_UNIX)
            switch ( errno ) 
            {
            case EEXIST : 
            case EISDIR : 
            case EACCES : 
            case ENAMETOOLONG : 
            case ENOENT  : 
            case ENOTDIR : 
            case ENXIO   : 
            case ENODEV  : 
            case EROFS   : 
            case ETXTBSY : 
            case EFAULT  : 
            case ELOOP   : 
            case ENOSPC  : 
            case ENOMEM  : 
            case EMFILE  : 
            case ENFILE  : 
            default :
                {
                    break;
                }
            }//end of switch
#elif defined( OS_WINDOWS )
            // ...
#endif
        }

        return fd;
    }


    //////////////////////////////////////////////////////////////////////
    //
    // exception version of read()
    //
    // Parameters 
    //     fd  - file descriptor
    //     buf - reading buffer
    //     len - reading length
    //
    // Return
    //     length of reading bytes
    //
    //
    //////////////////////////////////////////////////////////////////////
    sint32 FILE_API::gx_read ( sint32 fd , void * buf , sint32 len ) 
    {
#if defined(OS_UNIX)
        sint32 result = read ( fd , buf , len );
#elif defined( OS_WINDOWS )
        sint32 result = _read ( fd , buf , len );
#endif

        if ( result < 0 ) {

#if defined(OS_UNIX)
            switch ( errno ) {
            case EINTR : 
            case EAGAIN : 
            case EBADF : 
            case EIO : 
            case EISDIR : 
            case EINVAL : 
            case EFAULT : 
            case ECONNRESET :
            default : 
                {
                    break;
                }
            }
#elif defined( OS_WINDOWS )
            // ...
#endif
        } else if ( result == 0 ) {
        }

        return result;
    }

    //////////////////////////////////////////////////////////////////////
    //
    // exception version of write()
    //
    // Parameters 
    //     fd  - file descriptor
    //     buf - writing buffer
    //     len - writing length
    //
    // Return
    //     length of reading bytes
    //
    //
    //////////////////////////////////////////////////////////////////////
    sint32 FILE_API::gx_write ( sint32 fd , const void * buf , sint32 len ) 
    {
#if defined(OS_UNIX)
        sint32 result = write ( fd , buf , len );
#elif defined( OS_WINDOWS )
        sint32 result = _write ( fd , buf , len );
#endif

        if ( result < 0 )
        {
#if defined(OS_UNIX)
            switch ( errno ) 
            {
            case EAGAIN : 
            case EINTR : 
            case EBADF : 
            case EPIPE : 
            case EINVAL: 
            case EFAULT: 
            case ENOSPC : 
            case EIO : 
            case ECONNRESET :
            default : 
                {
                    break;
                }
            }
#elif defined( OS_WINDOWS )
            //...
#endif
        }

        return result;
    }

    //////////////////////////////////////////////////////////////////////
    //
    // exception version of close()
    //
    // Parameters
    //     fd - file descriptor
    //
    // Return
    //     none
    //
    //
    //////////////////////////////////////////////////////////////////////
    void FILE_API::gx_close ( sint32 fd ) 
    {
        if ( close(fd) < 0 )
        {
#if defined(OS_UNIX)
            switch ( errno ) 
            {
            case EBADF : 
            default :
                {
                    break;
                }
            }
#elif defined( OS_WINDOWS )
#endif
        }
    }

    //////////////////////////////////////////////////////////////////////
    //
    // Parameters
    //     fd  - file descriptor
    //     cmd - file control command
    //
    // Return
    //     various according to cmd
    //
    //
    //////////////////////////////////////////////////////////////////////
    sint32 FILE_API::gx_fcntl ( sint32 fd , sint32 cmd ) 
    {
#if defined(OS_UNIX)
        sint32 result = fcntl ( fd , cmd );
        if ( result < 0 )
        {
            switch ( errno ) 
            {
            case EINTR : 
            case EBADF : 
            case EACCES : 
            case EAGAIN : 
            case EDEADLK : 
            case EMFILE  : 
            case ENOLCK : 
            default : 
                {
                    break;
                }
            }
        }
        return result;
#elif defined( OS_WINDOWS )
        return 0 ;
#endif
    }

    //////////////////////////////////////////////////////////////////////
    //
    // Parameters
    //     fd  - file descriptor
    //     cmd - file control command
    //     arg - command argument
    //
    // Return
    //     various according to cmd
    //
    //
    //////////////////////////////////////////////////////////////////////
    sint32 FILE_API::gx_fcntl ( sint32 fd , sint32 cmd , sint32 arg ) 
    {
#if defined(OS_UNIX)
        sint32 result = fcntl ( fd , cmd , arg );
        if ( result < 0 )
        {
            switch ( errno ) 
            {
            case EINTR : 
            case EINVAL : 
            case EBADF : 
            case EACCES : 
            case EAGAIN : 
            case EDEADLK : 
            case EMFILE  : 
            case ENOLCK : 
            default : 
                {
                    break;
                }
            }
        }
        return result;
#elif defined( OS_WINDOWS )
        return 0 ;
#endif
    }


    //////////////////////////////////////////////////////////////////////
    //
    // check if this file is nonblocking mode
    //
    // Parameters
    //     fd - file descriptor
    //
    // Return
    //     TRUE if nonblocking, FALSE if blocking
    //
    //
    //////////////////////////////////////////////////////////////////////
    bool FILE_API::gx_getfilenonblocking ( sint32 fd ) 
    {
#if defined(OS_UNIX)
        sint32 flags = gx_fcntl( fd , F_GETFL , 0 );
        return flags | O_NONBLOCK;
#elif defined( OS_WINDOWS )
        return false;
#endif
    }

    //////////////////////////////////////////////////////////////////////
    //
    // make this file blocking/nonblocking
    //
    // Parameters
    //     fd - file descriptor
    //     on - TRUE if nonblocking, FALSE if blocking
    //
    // Return
    //     none
    //
    //
    //////////////////////////////////////////////////////////////////////
    void FILE_API::gx_setfilenonblocking ( sint32 fd , bool on ) 
    {
#if defined(OS_UNIX)
        sint32 flags = gx_fcntl( fd , F_GETFL , 0 );

        if ( on )
            // make nonblocking fd
            flags |= O_NONBLOCK;
        else
            // make blocking fd
            flags &= ~O_NONBLOCK;

        gx_fcntl( fd , F_SETFL , flags );
#elif defined( OS_WINDOWS )
#endif
    }

    //////////////////////////////////////////////////////////////////////
    //
    // exception version of ioctl()
    //
    // Parameters
    //     fd      - file descriptor
    //     request - i/o control request
    //     argp    - argument
    //
    // Return
    //     none
    //
    //
    //////////////////////////////////////////////////////////////////////
    void FILE_API::gx_ioctl ( sint32 fd , sint32 request , void * argp )
    {
#if defined(OS_UNIX)
        if ( ioctl(fd,request,argp) < 0 ) 
        {
            switch ( errno ) 
            {
            case EBADF : 
            case ENOTTY : 
            case EINVAL : 
            default :
                {
                    break;
                }
            }
        }
#elif defined( OS_WINDOWS )
#endif
    }



    //////////////////////////////////////////////////////////////////////
    //
    // make this stream blocking/nonblocking using ioctl_ex()
    //
    // Parameters
    //     fd - file descriptor
    //     on - TRUE if nonblocking, FALSE else
    //
    // Return
    //     none
    //
    //
    //////////////////////////////////////////////////////////////////////
    void FILE_API::gx_setfilenonblocking2 ( sint32 fd , bool on )
    {
#if defined(OS_UNIX)
        sint32 arg = ( on == true ? 1 : 0 );
        gx_ioctl(fd,FIONBIO,&arg);
#elif defined( OS_WINDOWS )
#endif
    }


    //////////////////////////////////////////////////////////////////////
    //
    // how much bytes available in this stream? using ioctl_ex()
    //
    // Parameters
    //     fd - file descriptor
    //
    // Return
    //     #bytes available
    //
    //
    //////////////////////////////////////////////////////////////////////
    sint32 FILE_API::gx_availablefile ( sint32 fd )
    {
#if defined(OS_UNIX)
        sint32 arg = 0;
        gx_ioctl(fd,FIONREAD,&arg);
        return arg;
#elif defined( OS_WINDOWS )
        return 0;
#endif
    }

    sint32 FILE_API::gx_dup ( sint32 fd )
    {
#if defined(OS_UNIX)
        sint32 newfd = dup(fd);
#elif defined( OS_WINDOWS )
        sint32 newfd = _dup(fd);
#endif

        if ( newfd < 0 ) {
#if defined(OS_UNIX)
            switch ( errno ) {
        case EBADF : 
        case EMFILE : 
        default :
            {
                break;
            }
            }//end of switch
#elif defined( OS_WINDOWS )
#endif
        }

        return newfd;
    }

    sint32 FILE_API::gx_lseek ( sint32 fd , sint32 offset , sint32 whence )
    {
#if defined(OS_UNIX)
        sint32 result = lseek(fd,offset,whence);
        if ( result < 0 ) {
            switch ( errno ) {
        case EBADF : 
        case ESPIPE : 
        case EINVAL : 
        default :
            {
                break;
            }
            }
        }
#elif defined( OS_WINDOWS )
        sint32 result = _lseek(fd,offset,whence);
        if ( result < 0 ) {
        }
#endif

        return result;
    }

    sint32 FILE_API::gx_tell( sint32 fd )
    {
#if defined(OS_UNIX)
        sint32 result = 0;
#elif defined( OS_WINDOWS )
        sint32 result = _tell(fd);
        if ( result < 0 ) {
        }
#endif

        return result ;
    }
}