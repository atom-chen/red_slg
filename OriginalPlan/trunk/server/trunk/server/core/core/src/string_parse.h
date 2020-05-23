#ifndef _STRING_PARSE_H_
#define _STRING_PARSE_H_

#include "types_def.h"
#include "string_util.h"

using namespace std;

namespace GXMISC
{
	// 字符串解析
	template<typename T>
	class CStringParse
	{
	public:
		typedef T ValueType;
		typedef std::vector<T> ValueList;

	public:
		CStringParse(const std::string& str=",") : _parseFlag(str){}
		~CStringParse(){}

	public:
		void setParseFlag(const std::string& str=",")
		{
			_parseFlag = str;
		}

		void parse(const std::string& tempStr)
		{
			char* cur = NULL;
			char* str = new char[tempStr.length()+1];
			memset(str, 0, tempStr.length()+1);
			memcpy(str, tempStr.c_str(), tempStr.length());
			char *tokenPtr = gxStrtok(str, _parseFlag.c_str(), &cur);
			while(tokenPtr != NULL)
			{
				T t;
				gxFromString(tokenPtr, t);
				_contain.push_back(t);
				tokenPtr = gxStrtok(NULL, _parseFlag.c_str(), &cur);
			}
			delete []str;
		}

		ValueList& getValueList()
		{
			return _contain;
		}

		void* data()
		{
			return &_contain[0];
		}

		T& operator[](uint32 i)
		{
			return _contain[i];
		}

		uint32 size()
		{
			return (uint32)_contain.size();
		}

	private:
		std::string     _parseFlag;
		ValueList       _contain;
	};

	template<>
	class CStringParse<string>
	{
	public:
		typedef std::string ValueType;
		typedef std::vector<std::string> ValueList;

	public:
		CStringParse(const std::string& str=",") : _parseFlag(str){}
		~CStringParse(){}

	public:
		void setParseFlag(const std::string& str=",")
		{
			_parseFlag = str;
		}

		void parse(const std::string& tempStr)
		{
			char* cur = NULL;
			char* str = new char[tempStr.length()+1];
			memset(str, 0, tempStr.length()+1);
			memcpy(str, tempStr.c_str(), tempStr.length());
			char *tokenPtr = gxStrtok(str, _parseFlag.c_str(), &cur);
			while(tokenPtr != NULL)
			{
				_contain.push_back(tokenPtr);
				tokenPtr = gxStrtok(NULL, _parseFlag.c_str(), &cur);
			}
			delete []str;
		}

		uint32 size()
		{
			return (uint32)_contain.size();
		}

		ValueList& getValueList()
		{
			return _contain;
		}

		template<typename T>
		T toValue(uint32 i)
		{
			T t;
			gxFromString(_contain[i], t);
			return t;
		}

		std::string & operator[](uint32 i)
		{
			return _contain[i];
		}

	private:
		std::string     _parseFlag;
		ValueList       _contain;
	};
}

#endif