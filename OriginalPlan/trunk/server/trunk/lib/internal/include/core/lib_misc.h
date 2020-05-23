#ifndef _LIB_MISC_H_
#define _LIB_MISC_H_

#include <vector>
#include <functional>

#include "debug.h"
#include "string_parse.h"
#include "time_util.h"

// @TODO 接口重新分类
namespace GXMISC{
	static uint32 StrCRC32( const char* str )
	{
		if(str==NULL || str[0]==0) return 0;

		uint32 dwCrc32 = 0xFFFFFFFF;
		sint32 nSize = (sint32)strlen(str);
		for(sint32 i=0; i<nSize; i++)
		{
			dwCrc32 = dwCrc32*33 + (unsigned char)str[i];
		}

		return dwCrc32;
	}

	static uint64 StrCRC64( const char* str )
	{
		if(str==NULL || str[0]==0) return 0;

		uint64 dwCrc64 = 0xFFFFFFFFFFFFFFFF;
		sint32 nSize = (sint32)strlen(str);
		for(sint32 i=0; i<nSize; i++)
		{
			dwCrc64 = dwCrc64*33 + (unsigned char)str[i];
		}

		return dwCrc64;
	}

	static char	ValueToAscii( uint8 inValue )
	{
		static const char ValueToAscciiArray[] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
		if ( inValue > 15 )
		{
			gxAssert(false);
			return '?';
		}
		return ValueToAscciiArray[inValue];
	}

	static uint8 AsciiToValue( char inValue )
	{
		sint32 tempAsciiValue = (sint32)inValue;
		if ( tempAsciiValue >= '0' && tempAsciiValue <= '9' )
		{
			return inValue - '0';	// 把字符‘0’到‘9’转化为相应的数字0-9
		}
		else if ( tempAsciiValue >=  'A' && tempAsciiValue <= 'F' )
		{
			return inValue - 55;	// 把字符‘A’到‘F’转化为相应的数字10－15
		}
		else
		{
			gxAssert(false);
			return '?';
		}
	}

	static void	ChangeToHex( char* outBuff, const char* inBuff, uint32 len )
	{
		uint32 index = 0;
		for ( ; index<len; ++index )
		{
			uint8 highIndex = inBuff[index] >> 4;
			uint8 lowIndex = inBuff[index] & 0xF;
			outBuff[2*index] = ValueToAscii(highIndex);
			outBuff[2*index+1] = ValueToAscii(lowIndex);
		}
		outBuff[2*index] = '\0';
	}

	static unsigned char EncryChar( unsigned char c )
	{
		unsigned char bit1 = (c >> 1) & 0x1;
		unsigned char bit2 = (c >> 5) & 0x1;
		unsigned char newc = c & 0xDD;
		newc |= (bit1 << 5);
		newc |= (bit2 << 1);
		newc ^= 0x3C;
		unsigned char beforec = newc & 0xF;
		unsigned char afterc = (newc >> 4);
		unsigned char encryc = (beforec << 4) + afterc;
		return encryc;
	}

	static unsigned char DecryChar( unsigned char c )
	{
		unsigned char beforec = c & 0xF;
		unsigned char afterc = c >> 4;
		unsigned char newc = (beforec << 4) + afterc;
		newc ^= 0x3C;
		unsigned char bit1 = (newc >> 1) & 0x1;
		unsigned char bit2 = (newc >> 5) & 0x1;
		unsigned char descryc = newc & 0xDD;
		descryc |= (bit1 << 5);
		descryc |= (bit2 << 1);
		return descryc;
	}

	static void EncryCharArray( char* inBuff, sint32 buffLen, char* outBuff )
	{
		sint32 curIndex = 0;
		while ( curIndex < buffLen )
		{
			outBuff[curIndex] = EncryChar(inBuff[curIndex]);
			++curIndex;
		}
		outBuff[curIndex] = '\0';
	}

	static void DecryCharArray( char* inBuff, sint32 buffLen, char* outBuff )
	{
		sint32 curIndex = 0;
		while ( curIndex < buffLen )
		{
			outBuff[curIndex] = DecryChar(inBuff[curIndex]);
			++curIndex;
		}
		outBuff[curIndex] = '\0';
	}

	static uint16 GetPassDay( TGameTime_t curTime )
	{
		return (uint16)((curTime + UTC_DIFF_TIME) / SECOND_IN_DAY);
	}

	static uint16 GetPassWeekDay( TGameTime_t newTime, TGameTime_t oldTime )
	{
		return ((GetPassDay(newTime) - GetPassDay(oldTime)) % DAY_IN_WEEKDAY);
	}

	static uint16 GetPassWeek( TGameTime_t newTime, TGameTime_t oldTime )
	{
		return ((GetPassDay(newTime) - GetPassDay(oldTime)) / DAY_IN_WEEKDAY);
	}
};

#endif		// _LIB_MISC_H_