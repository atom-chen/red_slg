
#ifndef _GAME_STRUCT_PARSE_H_
#define _GAME_STRUCT_PARSE_H_

#include "lib_misc.h"
#include "db_filed_parse.h"

#pragma pack(push, 1)

namespace GXMISC
{
	// ���½ӿ���ñ���á�����
	inline uint8 BinaryCharToNumber( uint32& index, const char* pBStr )
	{
		index += 2;
		return (GXMISC::AsciiToValue(pBStr[index-1]) << 4) + GXMISC::AsciiToValue(pBStr[index-2]);
	}

	inline void	NumberToBinaryChar( uint8 n, char* ary, uint32& index )
	{
		for ( uint32 i=0; i<2; ++i )
		{
			// ����λ�洢�ڵ���λ�ĺ��棬����18���ǰ�1�洢�ں�4λ�У�2�洢��ǰ4λ��,��0010 0001
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