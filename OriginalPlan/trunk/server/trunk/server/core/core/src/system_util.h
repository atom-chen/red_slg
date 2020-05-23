#ifndef _SYSTEM_UTIL_H_
#define _SYSTEM_UTIL_H_

#include "types_def.h"
#include "base_util.h"
#include "time_util.h"

#ifdef OS_WINDOWS
#	include <process.h>
#	include <intrin.h>
#else
#	include <unistd.h>
#	include <sys/types.h>
#	include<netinet/in.h>
#endif

namespace GXMISC
{
	// 判断当前线程是否为主线程
	bool gxIsMainThread();

    /** Signed 64 bit fseek. Same interface as fseek
    */
    int		gxFseek64( FILE *stream, sint64 offset, int origin );

    // Retrieve position in a file, same interface as ftell
    sint64  gxFtell64(FILE *stream);

    /**
    * Portable Sleep() function that suspends the execution of the calling thread for a number of milliseconds.
    * Note: the resolution of the timer is system-dependant and may be more than 1 millisecond.
    */
    void gxSleep( TDiffTime_t ms );


    /// Returns Process Id (note: on Linux, Process Id is the same as the Thread Id)
#ifdef OS_WINDOWS
#	define gxGetPID _getpid
#	else 
#	define gxGetPID getpid
#endif

    /// Returns Thread Id (note: on Linux, Process Id is the same as the Thread Id)
    TThreadID_t gxGetThreadID();

	/// 是否大端
	bool gxIsBigEndian();

	/// 大小端机器字节转换
	template<typename T>
	T gxNetToHostT(T t);
	uint64 gxNetToHostT(uint64 n);
	uint32 gxNetToHostT(uint32 n);
	uint16 gxNetToHostT(uint16 n);
	sint64 gxNetToHostT(sint64 n);
	sint32 gxNetToHostT(sint32 n);
	sint16 gxNetToHostT(sint16 n);
	template<typename T>
	T gxHostToNetT(T t);
	uint64 gxHostToNetT(uint64 n);
	uint32 gxHostToNetT(uint32 n);
	uint16 gxHostToNetT(uint16 n);
	sint64 gxHostToNetT(sint64 n);
	sint32 gxHostToNetT(sint32 n);
	sint16 gxHostToNetT(sint16 n);

	// 判断当前线程是否为需要快速写入日志的线程
	bool gxIsFastLogThread();
}

#endif // _SYSTEM_UTIL_H_