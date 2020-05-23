#ifndef _FILE_API_H_
#define _FILE_API_H_

#include "types_def.h"

namespace GXMISC
{
    namespace FILE_API 
    {
        sint32 gx_open (const char* filename, sint32 flags) ;

        sint32 gx_open (const char* filename, sint32 flags, sint32 mode) ;

        void   gx_close (sint32 fd) ;

        sint32 gx_read (sint32 fd, void* buf, sint32 len) ;

        sint32 gx_write (sint32 fd, const void* buf, sint32 len) ;

        sint32 gx_fcntl (sint32 fd, sint32 cmd) ;

        sint32 gx_fcntl (sint32 fd, sint32 cmd, sint32 arg) ;

        bool   gx_getfilenonblocking (sint32 fd) ;

        void   gx_setfilenonblocking (sint32 fd, bool on) ;

        void   gx_ioctl (sint32 fd, sint32 request, void* argp);

        void   gx_setfilenonblocking2 (sint32 fd, bool on);

        sint32 gx_availablefile (sint32 fd);

        sint32 gx_dup (sint32 fd);

        sint32 gx_lseek(sint32 fd, sint32 offset, sint32 whence);

        sint32 gx_tell( sint32 fd ) ;
    };


}

#endif