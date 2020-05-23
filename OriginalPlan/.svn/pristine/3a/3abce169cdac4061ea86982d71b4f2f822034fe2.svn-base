#ifndef TYPES_DEF_H
#define TYPES_DEF_H

#include "stdcore.h"

/**
* C函数重新定义
*/
// #define c_time      time
// #define c_mktime    mktime
// #define c_gmtime    gmtime
// #define c_localtime localtime
// #define c_difftime  difftime

// 是否有编译配置文件
#ifdef HAVE_GXCONFIG_H
#	include "gxlib_config.h"
#endif // HAVE_GXCONFIG_H

// 操作系统类型
#if OS_BIT == 32
#	define OS_32BIT
#	define SIZEOF_SIZE_T 4
#elif OS_BIT == 64
#	define OS_64BIT
#	define SIZEOF_SIZE_T 8
#else
#	error "Can't get os bits"
#endif

// 大小端控制
#if WORDS_BIGENDIAN
#ifndef BIG_ENDIAN
#	define BIG_ENDIAN				// big endian
#endif
#else
#ifndef LITTLE_ENDIAN
#	define LITTLE_ENDIAN			// little endian
#endif
#endif

// 库类型(debug|release)
#	ifdef _DEBUG
#		define LIB_DEBUG
#	else
#		define LIB_RELEASE
#	endif

// 操作系统定义
#ifdef OS_WIN
// os type
#	define OS_WINDOWS				// windows
#   ifndef _WIN32_WINNT
#		define _WIN32_WINNT 0x0500	// Minimal OS = Windows 2000
#   endif
#	ifdef _WIN64
#		define OS_WIN64
#		if OS_BIT != 64
#	error "Can't define OS_WIN64, because OS_BIT not 64"
#		endif
#	elif _WIN32
#		define OS_WIN32
#		if OS_BIT != 32
#	error "Can't define OS_WIN32, because OS_BIT not 32"
#		endif
#	else
#		error "Can't define OS type!!!"
#	endif
// cpu type
#	define CPU_INTEL				// intel CPU
// compiler version
#	if _MSC_VER == 1500
#		define COMP_VC9	1			// VS2008
#	elif _MSC_VER >= 1600
#		define COMP_VC10 1			// VS2010
#	endif
#	ifndef _STLPORT_VERSION		// STLport doesn't depend on MS STL features
#		if defined(_HAS_TR1)
#			define ISO_STDTR1_AVAILABLE
#			define ISO_STDTR1_HEADER(header) <header>
#		endif
#	endif
//#	endif
#else
// these define are set the GNU/Linux
// os type
#	define OS_UNIX
// compiler version
#	define COMP_GCC
// cpu type
#	define CPU_INTEL

// gcc 4.1+ provides std::tr1
#ifdef COMP_GCC
#	define GCC_VERSION (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__)
#	if GCC_VERSION > 40100
#		define ISO_STDTR1_AVAILABLE
#		define ISO_STDTR1_HEADER(header) <tr1/header>
#	endif
#endif

#endif

// Remove stupid Visual C++ warnings
#ifdef OS_WINDOWS
#	pragma warning (disable : 4503)			// STL: Decorated name length exceeded, name was truncated
#	pragma warning (disable : 4786)			// STL: too long identifier
#	pragma warning (disable : 4290)			// throw() not implemented warning
#	pragma warning (disable : 4250)			// inherits via dominance (informational warning).
#	pragma warning (disable : 4390)			// don't warn in empty block "if(exp) ;"
#	pragma warning (disable : 4996)			// 'vsnprintf': This function or variable may be unsafe. Consider using vsnprintf_s instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. See online help for details.
#   pragma warning (disable : 4819)         // 该文件包含不能在当前代码页(936)中表示的字符。请将该文件保存为 Unicode 格式以防止数据丢失
#	pragma warning (disable : 4509)
#	pragma warning(disable:4731)			// Visual C++ warning : ebp maybe modified
// Debug : Sept 01 2006
#	if defined(COMP_VC9) || defined(COMP_VC10)
#		pragma warning (disable : 4005)			// don't warn on redefinitions caused by xp platform sdk
#	endif // COMP_VC9 || COMP_VC10
#endif // OS_WINDOWS

// Standard types

typedef	int8_t		sint8;
typedef	uint8_t		uint8;
typedef	int16_t		sint16;
typedef	uint16_t	uint16;
typedef	int32_t		sint32;
typedef	uint32_t	uint32;
typedef	int64_t		sint64;
typedef	uint64_t	uint64;

#ifdef OS_WINDOWS

static_assert(sizeof(signed __int8) == sizeof(sint8), "sizeof(signed __int8) == sizeof(sint8)");
static_assert(sizeof(unsigned __int8) == sizeof(uint8), "sizeof(unsigned __int8) == sizeof(uint8)");
static_assert(sizeof(signed __int16) == sizeof(sint16), "sizeof(signed __int16) == sizeof(sint16)");
static_assert(sizeof(unsigned __int16) == sizeof(uint16), "sizeof(unsigned __int16) == sizeof(uint16)");
static_assert(sizeof(signed __int32) == sizeof(sint32), "(sizeof(signed __int32) == sizeof(sint32)");
static_assert(sizeof(unsigned __int32) == sizeof(uint32), "sizeof(unsigned __int32) == sizeof(uint32)");
static_assert(sizeof(signed __int64) == sizeof(sint64), "sizeof(signed __int64) == sizeof(sint64)");
static_assert(sizeof(unsigned __int64) == sizeof(uint64), "sizeof(unsigned __int64) == sizeof(uint64)");

// int64输出格式
#define	I64_FMT "I64"

#elif defined (OS_UNIX)

#include <sys/types.h>
#include <stdint.h>
#include <climits>
#include <errno.h>

// int64输出格式
#if __SIZEOF_LONG__ == 8
#	define	I64_FMT "l"
#else
#	define	I64_FMT "ll"
#endif // __SIZEOF_LONG__ == 8

#endif // OS_UNIX

// #define s8 sint8
// #define s16 sint16
// #define s32 sint32
// #define s64 sint64
// #define u8  uint8
// #define u16 uint16
// #define u32 uint32
// #define u64 uint64

/**
* \typedef ucchar
* An Unicode character (16 bits)
*/
typedef	uint16	ucchar;

// To define a 64bits constant; ie: UINT64_CONSTANT(0x123456781234)
#ifdef OS_WINDOWS
#	if defined(COMP_VC9)
#		define INT64_CONSTANT(c)	(c##LL)
#		define SINT64_CONSTANT(c)	(c##LL)
#		define UINT64_CONSTANT(c)	(c##LL)
#	else
#		define INT64_CONSTANT(c)	(c)
#		define SINT64_CONSTANT(c)	(c)
#		define UINT64_CONSTANT(c)	(c)
#	endif
#else
#	define INT64_CONSTANT(c)		(c##LL)
#	define SINT64_CONSTANT(c)	    (c##LL)
#	define UINT64_CONSTANT(c)	    (c##ULL)
#endif

// 使用最大路径
#if !defined(MAX_PATH) && !defined(OS_WINDOWS)
#	define MAX_PATH 255
#endif

#ifdef LIB_DEBUG
const std::string gxLibMode("LIB_DEBUG");
#else
const std::string gxLibMode("LIB_RELEASE");
#endif

// Sanity checks
#if defined (LIB_DEBUG) && defined (LIB_RELEASE)
#	error "GXLib cannot be configured for debug and release in the same time"
#endif
#if !defined (LIB_DEBUG) && !defined (LIB_RELEASE)
#	error "GXLib must be configured for debug or release"
#endif

// 解决Socket多链接问题
#ifdef OS_WINDOWS
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <winsock2.h>
#include <windows.h>
#undef WIN32_LEAN_AND_MEAN
#elif defined(OS_UNIX)
#endif

#ifdef OS_WINDOWS
#define SIGKILL SIGABRT          // 终止信号
#endif

// 系统调用, 凡是调用系统函数或标准C++函数都必须加此前缀, 如: SystemCall::time()
#define SystemCall

#ifndef UNREFERENCED_PARAMETER
#define UNREFERENCED_PARAMETER(P) (P)
#endif

#define FALSE_COND 0 > 1

#define DIFFALSE(code)	\
if ((code) == false)	{ return false; }
#define DIFTRUE(code) \
if ((code) == true)	{ return true; }

namespace GXMISC
{
	typedef std::map<std::string, std::string> TConfigKeyMap;
	typedef std::map<std::string, TConfigKeyMap> TConfigMap;
}

#endif // TYPES_DEF_H
