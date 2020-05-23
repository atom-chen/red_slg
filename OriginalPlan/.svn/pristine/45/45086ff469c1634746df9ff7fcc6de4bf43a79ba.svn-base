#ifndef _SOCKET_INPUT_STREAM_H_
#define _SOCKET_INPUT_STREAM_H_

#include "types_def.h"
#include "socket_util.h"
#include "mutex.h"

namespace GXMISC
{
    class CSocketInputStream
    {
    public :
        CSocketInputStream() ;
        virtual ~CSocketInputStream( ) ;

    public :
        sint32						read( char* buf, sint32 len ) ;
        sint32                      peakInt();
        uint32                      peakUint();
        sint16                      peakInt16();
        uint16                      peakUint16();
        sint8                       peakByte();
        bool						peek( char* buf, sint32 len ) ;
        bool						skip( sint32 len ) ;
        sint32						fill( ) ;

        void						initsize( CSocket* sock, sint32 BufferLen = DEFAULT_SOCKET_INPUT_BUFFER_SIZE, sint32 MaxBufferLen = DISCONNECT_SOCKET_INPUT_SIZE) ;
        bool						resize( sint32 size ) ;

        sint32						capacity( )const { return _bufferLen; }
        sint32						size( )const { return length(); }
        sint32                      length() const;
        bool						isEmpty( )const { return _head==_tail; }
        void						cleanUp( ) ;

        sint32						getHeadPos(){return _head;}
        sint32						getTailPos(){return _tail;}
        sint32						getBuffLen(){return _bufferLen;}
		char*						getBuffer(){ return _buffer; }

    private:
        sint32						_length() const ;

    private :
        CSocket*                _socket;
        char*		            _buffer ;
        sint32		            _bufferLen ;
        sint32		            _maxBufferLen ;
        sint32		            _head ;
        sint32		            _tail ;
        CFastLock::Lock_t       _inputLen;                  // 当前缓冲区长度, 必须实时改变数值
    };
}

#endif