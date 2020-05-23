#ifndef _STRING_UTIL_H_
#define _STRING_UTIL_H_

// #include <cstdio>
// #include <cstdarg>
// #include <errno.h>
// #include <cstring>
// #include <string>
// #include <vector>
// #include <cstdlib>
// #include <string.h>

#include "types_def.h"

namespace GXMISC
{
	/** Compare 2 C-Style strings without regard to case
	* \return 0 if strings are equal, < 0 if lhs < rhs, > 0 if lhs > rhs
	*
	* On Windows,   use stricmp
	* On GNU/Linux, create stricmp using strcasecmp and use stricmp
	*/
#ifndef OS_WINDOWS
	inline char* gxStrtok(char* src, const char* split, char** cur) { return strtok_r(src, split, cur); }
	inline sint32 gxStricmp(const char *lhs, const char *rhs) { return strcasecmp(lhs, rhs); }
	inline sint32 gxStricmp(const char *lhs, const char *rhs, size_t n) { return strncasecmp(lhs, rhs, n); }
	inline sint32 gxStricmp(const std::string &lhs, const std::string &rhs) { return strcasecmp(lhs.c_str(), rhs.c_str()); }
	inline sint32 gxStricmp(const std::string &lhs, const char *rhs) { return strcasecmp(lhs.c_str(),rhs); }
	inline sint32 gxStricmp(const char *lhs, const std::string &rhs) { return strcasecmp(lhs,rhs.c_str()); }
#else
	inline char* gxStrtok(char* src, const char* split, char** cur) { return strtok_s(src, split, cur); }
	inline sint32 gxStricmp(const char *lhs, const char *rhs) { return stricmp(lhs, rhs); }
	inline sint32 gxStricmp(const char *lhs, const char *rhs, size_t n){ return strnicmp(lhs, rhs, n); }
	inline sint32 gxStricmp(const std::string &lhs, const std::string &rhs) { return stricmp(lhs.c_str(), rhs.c_str()); }
	inline sint32 gxStricmp(const std::string &lhs, const char *rhs) { return stricmp(lhs.c_str(),rhs); }
	inline sint32 gxStricmp(const char *lhs, const std::string &rhs) { return stricmp(lhs,rhs.c_str()); }
#endif

	// 拷贝字符串, 并在目标字符串结尾加'\0'
#define gxStrcpy(dest, dsize, src, ssize)  \
	assert(dsize >= ssize);   \
	uint32 count = std::min((dsize-1), (ssize));   \
	strncpy(dest, src, count);  \
	dest[count] = '\0';

#if defined(OS_WINDOWS)
#define		DVsnprintf		_vsnprintf
#define		DStricmp		_stricmp
#define		DSnprintf		_snprintf
#elif defined(OS_UNIX)
#define		DVsnprintf		vsnprintf
#define		DStricmp		strcasecmp
#define		DSnprintf		snprintf
#endif

	// 如果\n之前缺少\r则添加
    std::string gxAddSlashR (std::string str);
    std::string gxRemoveSlashR (std::string str);

    // 在栈上创建一个C风格的字符串缓冲区的最大大小
    const int MAX_CSTRING_SIZE = 2048;

    /**
    * @brief 将变量格式化到字符串中
    *
    * Example:
    *\code
    void MyFunction(const char *format, ...)
    {
    string str;
    GXMISC_CONVERT_VARGS (str, format, GXMISC::MaxCStringSize);
    }
    *\endcode
    *
    * \param _dest \c string or \c char* that contains the result of the convertion
    * \param _format format of the string, it must be the last argument before the \c '...'
    * \param _size size of the buffer that will contain the C string
    */
#define DConvertVargs(_dest,_format,_size) \
    char* _dest = NULL;  \
    char _cstring[_size]; \
    va_list _args; \
    va_start (_args, _format); \
    int _res = vsnprintf (_cstring, _size-1, _format, _args); \
    if (_res == -1 || _res == _size-1) \
    { \
    _cstring[_size-1] = '\0'; \
    } \
    va_end (_args); \
    _dest = _cstring

	static void ConvertVargs(char* cstring, char* fmt, int size, ...)
	{ 
		va_list _args; 
		va_start (_args, size); 
		int _res = vsnprintf (cstring, size-1, fmt, _args); 
		if (_res == -1 || _res == size-1) 
		{ 
			cstring[size-1] = '\0'; 
		} 
		va_end (_args); 
	}

#define DSprintf(dest, fmt, size) \
	char* dest = NULL; \
	DConvertVargs(dest, fmt, size)

    /** 
    * @brief 类似于sprintf函数, 但在字符串的后面加上了\0, 防止溢出
    *
    * \param buffer a C string
    * \param count Size of the buffer
    * \param format of the string, it must be the last argument before the \c '...'
    */
    sint32 gxSprintf( char *buffer, sint32 count, const char *format, ... );

	/// this wrapping is due to a visual bug when calling isprint with big value
	/// example of crash with VC6 SP4:	int a = isprint(0x40e208);
#ifdef OS_WINDOWS
	inline int gxIsPrint(int c)
	{
		if(c>255||c<0) return 0;
		return isprint(c);
	}
#else
#define gxIsPrint isprint
#endif
}
#endif
