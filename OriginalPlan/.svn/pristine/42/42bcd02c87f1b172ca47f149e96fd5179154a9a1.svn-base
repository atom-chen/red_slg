
#ifndef _GAME_STRUCT_PARSE_H_
#define _GAME_STRUCT_PARSE_H_

#include "lib_misc.h"
#include "db_filed_parse.h"

#pragma pack(push, 1)

namespace GXMISC
{
	// 以下接口最好别调用。。。
	inline uint8 BinaryCharToNumber( uint32& index, const char* pBStr )
	{
		index += 2;
		return (GXMISC::AsciiToValue(pBStr[index-1]) << 4) + GXMISC::AsciiToValue(pBStr[index-2]);
	}

	inline void	NumberToBinaryChar( uint8 n, char* ary, uint32& index )
	{
		for ( uint32 i=0; i<2; ++i )
		{
			// 高四位存储在低四位的后面，比如18，是把1存储在后4位中，2存储在前4位中,即0010 0001
			ary[index] = GXMISC::ValueToAscii((n >> (4 * i)) & 0xF);
			++index;
		}
	}

	template<typename T>
	inline bool ParseBStr( T& data, uint32 index, uint32 len, const char* pBStr )
	{
		if ( sizeof(data) != len )
		{
			gxError("Binary string length is not equal the struct size!!!");
			gxAssert(false);
			return false;
		}
		char* tempData = (char*)&data;
		for ( uint32 i=0; i<len; ++i )
		{
			tempData[i] = BinaryCharToNumber(index, pBStr);
		}
		return true;
	}

	inline bool ParseBStr( uint8* data, uint32 index, uint32 len, const char* pBStr )
	{
		uint8* tempData = (uint8*)&data;
		for ( uint32 i=0; i<len; ++i )
		{
			tempData[i] = BinaryCharToNumber(index, pBStr);
		}
		return true;
	}

	inline bool ParseBStr( TDBBuffer& data, uint32 index, uint32 len, const char* pBStr )
	{
		data.resize(len);
		for ( uint32 i=0; i<len; ++i )
		{
			data[i] = (BinaryCharToNumber(index, pBStr));
		}
		return true;
	}
}

#pragma pack(pop)

#endif