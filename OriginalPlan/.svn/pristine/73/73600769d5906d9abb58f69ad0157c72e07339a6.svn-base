#ifndef _GAME_BINARY_STRING_H_
#define _GAME_BINARY_STRING_H_

#include "db_struct_base.h"
#include "fix_string.h"
#include "game_struct_parse.h"

#include "lib_misc.h"
#include "base_util.h"
#include "types_def.h"
#include "db_util.h"
#include "db_types_def.h"

// BinaryString 简写为 BStr

namespace GXMISC
{
#pragma pack(push, 1)

	typedef struct _BinaryStringHead
	{
		uint32			_realLen;		// 数据真实长度
		TDBVersion_t	_dbVersion;		// 数据库版本
		sint32			_year;			// 年
		sint32			_month;			// 月
		sint32			_day;			// 日
		sint32			_hour;			// 时
		sint32			_minute;		// 分
		sint32			_second;		// 秒

		_BinaryStringHead()
		{
			cleanUp();
		}

		void cleanUp()
		{
			_realLen = 0;
			_dbVersion = INVALID_DB_VERSION;
			_year = 0;
			_month = 0;
			_day = 0;
			_hour = 0;
			_minute = 0;
			_second = 0;
		}
	}TBinaryStringHead;

#pragma pack(pop)

	// 在字符串的前面加上了一个uint32的长度信息
	#define	GET_BINARY_MAX_LENGTH(leng)	(((leng + sizeof(TBinaryStringHead)) << 1) + 1)

	template <typename T>
	struct TBinaryString : public CFixString<GET_BINARY_MAX_LENGTH(sizeof(T))>
	{
	};

	template <typename T, bool isArray>
	struct TParseBinaryString
	{
		static bool ChangeStructToBStr( TBinaryString<T>& outData, const T& data, bool isEmpty );
	};

	template <typename T>
	struct TParseBinaryString<T, false>
	{
		static bool ChangeStructToBStr( TBinaryString<T>& outData, const T& data, bool isEmpty )
		{
			uint32 index = 0;
			TBinaryStringHead strHead;
			strHead._realLen = sizeof(data);
			strHead._year = DTimeManager.getYear();
			strHead._month = DTimeManager.getMonth() + 1;
			strHead._day = DTimeManager.getDay();
			strHead._hour = DTimeManager.getHour();
			strHead._minute = DTimeManager.getMinute();
			strHead._second = DTimeManager.getSecond();
			strHead._dbVersion = data.dbVersion;
			uint32 strHeadLen = sizeof(strHead);
			char* pStrHead = (char*)&strHead;
			for ( uint32 i=0; i<strHeadLen; ++i )
			{
				NumberToBinaryChar(pStrHead[i], outData.data(), index);
			}
			char* pIn = (char*)&data;
			for ( uint32 i=0; i<strHead._realLen; ++i )
			{
				NumberToBinaryChar(pIn[i], outData.data(), index);
			}
			outData[index] = '\0';
			return true;
		}
	};

	template <typename T>
	struct TParseBinaryString<T, true>
	{
		static bool ChangeStructToBStr( TBinaryString<T>& outData, const T& data, bool isEmpty )
		{
			if ( isEmpty )
			{
				return true;
			}
			return TParseBinaryString<T, false>::ChangeStructToBStr(outData, data, isEmpty);
		}
	};

	// 把数据库读到到的字符串转化成相应的结构体数据
	template<typename T>
	inline bool BStrToStruct( T& data, const char* pBStr )
	{
		if ( strlen(pBStr) == 0 )
		{
			return true;
		}
		TBinaryStringHead strHead;
		uint32 strHeadLen = sizeof(strHead);
		if ( strlen(pBStr) <= strHeadLen )
		{
			gxError("Binary string length is too short!!! It must larger than {0}!", strHeadLen);
			gxAssert(false);
			return false;	// 该字符串的长度一定得大于等于字符串头的长度
		}
		uint32 index = 0;	// 当前解析二进制字符串的位置
		char* pStrHead = (char*)&strHead;
		for ( uint32 i=0; i<strHeadLen; ++i )
		{
			pStrHead[i] = BinaryCharToNumber(index, pBStr);
		}
		if ( strHead._dbVersion == data.dbVersion )
		{
			return ParseBStr(data, index, strHead._realLen, pBStr);
		}
		if ( strHead._dbVersion > data.dbVersion )
		{
			gxError("Binary string database version is larger than current version!!! old version = {0}, new version = {1}", strHead._dbVersion, data.dbVersion);
			gxAssert(false);
			return false;
		}
		TDBStructParse<T> dbParse;
		return dbParse.parseVersion(data, strHead._dbVersion, index, strHead._realLen, pBStr);
	}

	// 把结构体转化成相应的二进制字符串,isArray为true代表结构体有且只有一个可变列表(如CArray)
	template <typename T, bool isArray>
	inline bool	StructToBStr( TBinaryString<T>& outData, const T& data, bool isEmpty = false )
	{
		return TParseBinaryString<T, isArray>::ChangeStructToBStr(outData, data, isEmpty);
	}
}

/*
*************************
struct TestStruct
{
	double dd;
	char c;
	int num;
	double d;
	std::string s;
	double ddd;
};

// 使用方法如下:
TestStruct s1, s2;
s1.dd = 3.8;
s1.c = 'x';
s1.num = 110;
s1.s = "Hello";
s1.d = 15.6;
s1.ddd = 25;
TBinaryString<TestStruct> p1;
StructToBStr(p1, s1);
char buf[1024];
memcpy(buf, p1.data(), p1.size());
BStrToStruct(s2, buf);
**************************
*/

#endif