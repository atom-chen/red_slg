#ifndef _GM_STRING_PARSE_H_
#define _GM_STRING_PARSE_H_

#include <string>

#include "game_errno.h"
#include "game_util.h"
#include "game_misc.h"

#include "core/hash_util.h"
#include "core/singleton.h"
#include "core/fix_string.h"
#include "core/lib_misc.h"

// gm命令格式化类型
enum EGMStandardType
{
	GM_STANDARD_INVALID = 0,	// 无效
	GM_STANDARD_LARGE,			// 只进行大小写转化
	GM_STANDARD_EQUAL,			// 只去除等号
	GM_STANARD_LARGE_EQUAL,		// 去除等号并且进行大小写转化
};

class CGmCmdParse : public GXMISC::CManualSingleton<CGmCmdParse>
{
public:
	DSingletonImpl();

public:
	CGmCmdParse()
	{
		cleanUp();
	}
	~CGmCmdParse()
	{
		cleanUp();
	}

public:
	EGameRetCode	parseGmCmd( char* str, const char* headStr, EGMStandardType standardType = GM_STANARD_LARGE_EQUAL )
	{
		cleanUp();
		if ( str == NULL )
		{
			return RC_FAILED;
		}
		standardGmCmd(str, standardType);
		char* pch = strtok(str, " ");
		if ( strcmp(pch, headStr) != 0 )
		{
			return RC_GM_CMD_FORMAT_ERROR;
		}
		pch = strtok(NULL, " ");
		if ( pch == NULL )
		{
			return RC_GM_CMD_FORMAT_ERROR;
		}
		_gmCmdName = pch;

		char* valueStr = strtok( NULL, " ");
		int i = 0;
		while ( valueStr != NULL )
		{
			pushDataToContainer(GXMISC::gxToString(i).c_str(), valueStr);
			valueStr = strtok(NULL, " ");
			i++;
		}
		return RC_SUCCESS;
	}

public:
	const char*		getGmCmdKeyName() const
	{
		return _gmCmdName.c_str();
	}

	std::map<std::string, std::string>& getArgs()
	{
		return _argsMap;
	}

	const double	getDoubleValue( const char* keyName ) const
	{
		return getValue<double>(keyName, true);
	}

	const sint8		getS8Value( const char* keyName ) const
	{
		return getValue<sint8>(keyName, true);
	}

	const uint8		getU8Value( const char* keyName ) const
	{
		return getValue<uint8>(keyName, false);
	}

	const sint16	getS16Value( const char* keyName ) const
	{
		return getValue<sint16>(keyName, true);
	}

	const uint16	getU16Value( const char* keyName ) const
	{
		return getValue<uint16>(keyName, false);
	}

	const sint32	getS32Value( const char* keyName ) const
	{
		return getValue<sint32>(keyName, true);
	}

	const uint32	getU32Value( const char* keyName ) const
	{
		return getValue<uint32>(keyName, false);
	}

	const sint64	getS64Value( const char* keyName ) const
	{
		return getValue<sint64>(keyName, true);
	}

	const uint64	getU64Value( const char* keyName ) const
	{
		return getValue<uint64>(keyName, false);
	}

	const std::string& getGmCmdStringValue( const char* keyName, EGMStandardType standardType = GM_STANARD_LARGE_EQUAL ) const
	{
		TGmCmdStr_t str = keyName;
		standardGmCmd(str.data(), standardType);
		CHashMap<uint32, std::string>::const_iterator itr = _paramMap.find(GXMISC::StrCRC32(str.data()));
		if ( itr != _paramMap.end() )
		{
			return itr->second;
		}
		return INVALID_STRING;
	}

public:
	void			standardGmCmd( char* str, EGMStandardType standardType = GM_STANARD_LARGE_EQUAL ) const
	{
		while ( *str != '\0' )
		{
			char& val = *str;
			if ( val >= 'A' && val <= 'Z' && (standardType == GM_STANARD_LARGE_EQUAL || standardType == GM_STANDARD_LARGE) )
			{
				val |= 0x20;
			}
			if ( val == '=' && (standardType == GM_STANARD_LARGE_EQUAL || standardType == GM_STANDARD_EQUAL) )
			{
				val = ' ';
			}
			str++;
		}
	}
	bool			isNumber( const char* str ) const
	{
		if ( *str == '-')
		{
			str++;
		}
		sint32 floatCount = 0;
		while ( *str != '\0' )
		{
			const char& val = *str;
			if ( val == '.' )
			{
				floatCount++;
				if ( floatCount > 1 )
				{
					return false;
				}
			}
			else if ( val < '0' || val > '9')
			{
				return false;
			}
			str++;
		}
		return true;
	}
	void			pushDataToContainer( const char* keyStr, const char* valueStr )
	{
		if ( keyStr == NULL || keyStr[0] == '\0' || valueStr == NULL )
		{
			return ;
		}
		std::string str = valueStr;
		_paramMap[GXMISC::StrCRC32(keyStr)] = str;
		_argsMap[keyStr] = str;
	}
	bool			getString( const char* keyName, std::string& str ) const
	{
		TGmCmdStr_t tempStr = keyName;
		standardGmCmd(tempStr.data());
		CHashMap<uint32, std::string>::const_iterator itr = _paramMap.find(GXMISC::StrCRC32(tempStr.data()));
		if ( itr != _paramMap.end() )
		{
			str = itr->second;
			return true;
		}
		return false;
	}

public:
	template <typename T>
	T				getValue( const char* keyName, bool isNeedMinus = true ) const
	{
		std::string str;
		if ( getString(keyName, str) && isNumber(str.c_str()) )
		{
			return strToNumber<T>(str.c_str(), isNeedMinus);
		}
		return 0;
	}
private:
	template <typename T>
	T				strToNumber( const char* str, bool isNeedMinus ) const
	{
		T num = 0;
		T maxNum = 0;
		maxNum = std::numeric_limits<T>::max();
		bool isBeginFloat = false;
		bool isMinus = false;
		sint16 curIndex = 10;
		if ( *str == '-' )
		{
			isMinus = true;
			str++;
		}
		while ( *str != '\0' )
		{
			char val = *str;
			++str;
			if ( val == '.' )
			{
				isBeginFloat = true;
				continue;
			}
			sint16 tempNum = val - '0';
			if ( isBeginFloat)
			{
				num = num + tempNum / curIndex;
				curIndex *= 10;
				if ( curIndex >= 4 )
				{
					// 只精确到小数点后面第4位
					break;
				}
				continue;
			}
			if ( (maxNum / 10 - tempNum) <= num )
			{
				num = maxNum;
				break;
			}
			num = num * 10 + tempNum;
		}
		if ( isMinus  && isNeedMinus )
		{
			num *= -1;
		}
		return num;
	}

private:
	void			cleanUp()
	{
		_argsMap.clear();
		_paramMap.clear();
		_gmCmdName.clear();
	}

private:
	std::map<std::string, std::string> _argsMap;
	CHashMap<uint32, std::string>	_paramMap;
	std::string						_gmCmdName;
};

#define DGmParseMgr CGmCmdParse::GetInstance()

#endif	// _GM_STRING_PARSE_H_