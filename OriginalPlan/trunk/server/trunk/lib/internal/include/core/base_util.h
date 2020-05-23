#ifndef _BASE_UTIL_H_
#define _BASE_UTIL_H_

#include <limits>
#include <ctime>

#include "types_def.h"
#include "fix_string.h"
#include "carray.h"

namespace GXMISC
{
    /// 常量定义
    static const sint64 MAX_SINT64_NUM          = LLONG_MAX;
    static const sint64 INVALID_SINT64_NUM      = MAX_SINT64_NUM;
    static const uint64 MAX_UINT64_NUM          = ULLONG_MAX;
    static const uint64 INVALID_UINT64_NUM      = MAX_UINT64_NUM;
    static const sint32 MAX_SINT32_NUM          = INT_MAX;
    static const sint32 INVALID_SINT32_NUM      = MAX_SINT32_NUM;
    static const uint32 MAX_UINT32_NUM          = UINT_MAX;
    static const uint32 INVALID_UINT32_NUM      = MAX_UINT32_NUM;
    static const uint16 MAX_UINT16_NUM          = USHRT_MAX;
    static const uint16 INVALID_UINT16_NUM      = MAX_UINT16_NUM;
    static const sint16 MAX_SINT16_NUM          = SHRT_MAX;
	static const sint16 INVALID_SINT16_NUM      = MAX_SINT16_NUM;
	static const uint8  MAX_UINT8_NUM           = UCHAR_MAX;
	static const uint8  INVALID_UINT8_NUM       = MAX_UINT8_NUM;
	static const sint8  MAX_SINT8_NUM           = SCHAR_MAX;
	static const sint8  INVALID_SINT8_NUM       = MAX_SINT8_NUM;

	#define MAX_IP_LEN 20												// IP地址的最大长度
	#define MAX_URL_LEN 255												// 域名最大长度

    /// 类型定义
    typedef uint64 TThreadID_t;											// 线程
    static const TThreadID_t INVALID_THREAD_ID = 0;
    typedef uint64 TUniqueIndex_t;										// 唯一标识
    const TUniqueIndex_t INVALID_UNIQUE_INDEX = INVALID_UINT64_NUM;
	typedef CFixString<MAX_IP_LEN>  TIPString_t;						// IP地址
	static const TIPString_t INVALID_IP_STRING = (const char*)("");		// 无效IP地址
	typedef uint16 TPort_t;												// 监听端口
	static const TPort_t INVALID_PORT = 0;								// 无效端口
	typedef CCharArray<MAX_URL_LEN, uint16> TUrlStr_t;					// URL地址
	static const TUrlStr_t INVALID_URL_STRING = "";						// 无效的URL地址
	typedef TUniqueIndex_t TSocketIndex_t;								// 网络唯一索引
	static const TSocketIndex_t INVALID_SOCKET_INDEX = GXMISC::INVALID_UNIQUE_INDEX;
	typedef GXMISC::TUniqueIndex_t TDbIndex_t;							// 数据库唯一索引
	static const TDbIndex_t INVALID_DB_INDEX = GXMISC::INVALID_UNIQUE_INDEX;
	typedef uint8 TDbHandlerTag;										// 数据库处理对象的标识
	static const TDbHandlerTag INVALID_DB_HANDLER_TAG = 0;				// 无效的标识
	typedef CArray<TUniqueIndex_t, 10> TSockIndexAry;					// 索引列表 @TODO 修改常量
	typedef sint16 TErrorCode_t;										// 错误码
	typedef uint32 TSigno_t;											// 信号量类型
	typedef uint64 TTimeDiff_t;											// 时间差
	// 库常量
	static const uint32 LOG_CACHE_NUM = 20;								// 日志缓存数目
	static const uint32 LOG_SINGLE_FILE_SIZE = 5*1024*1024;				// 单个日志文件的
}
#endif // BASE_UTIL_H_