#ifndef _PARSE_MISC_H_
#define _PARSE_MISC_H_

#include "types_def.h"
#include "string_common.h"
#include "string_parse.h"

namespace GXMISC
{
	template<uint32 num>
	class MultiInt;

	template<>
	class MultiInt<1>
	{
	public:
		MultiInt()
		{
			value1 = 0;
		}

	public:
		bool parse(const std::string& str, const std::string& pstr)
		{
			return GXMISC::gxFromString(str, value1);
		}

	public:
		sint32 value1;
	};

	template<>
	class MultiInt<2>
	{
	public:
		MultiInt()
		{
			value1 = 0;
			value2 = 0;
		}

	public:
		bool parse(const std::string& str, const std::string& pstr)
		{
			GXMISC::CStringParse<sint32> strParse(pstr);
			strParse.parse(str);
			if(strParse.size() != 2)
			{
				return false;
			}

			value1 = strParse[0];
			value2 = strParse[1];

			return true;
		}

	public:
		sint32 value1;
		sint32 value2;
	};

	template<>
	class MultiInt<3>
	{
	public:
		MultiInt()
		{
			value1 = 0;
			value2 = 0;
			value3 = 0;
		}

	public:
		bool parse(const std::string& str, const std::string& pstr)
		{
			GXMISC::CStringParse<sint32> strParse(pstr);
			strParse.parse(str);
			if(strParse.size() != 3)
			{
				return false;
			}

			value1 = strParse[0];
			value2 = strParse[1];
			value3 = strParse[2];

			return true;
		}

	public:
		sint32 value1;
		sint32 value2;
		sint32 value3;
	};

	template<>
	class MultiInt<4>
	{
	public:
		MultiInt()
		{
			value1 = 0;
			value2 = 0;
			value3 = 0;
			value4 = 0;
		}

	public:
		bool parse(const std::string& str, const std::string& pstr)
		{
			GXMISC::CStringParse<sint32> strParse(pstr);
			strParse.parse(str);

			if(strParse.size() != 4)
			{
				return false;
			}

			value1 = strParse[0];
			value2 = strParse[1];
			value3 = strParse[2];
			value4 = strParse[3];

			return true;
		}

	public:
		sint32 value1;
		sint32 value2;
		sint32 value3;
		sint32 value4;
	};

	template<>
	class MultiInt<5>
	{
	public:
		MultiInt()
		{
			value1 = 0;
			value2 = 0;
			value3 = 0;
			value4 = 0;
			value5 = 0;
		}

	public:
		bool parse(const std::string& str, const std::string& pstr)
		{
			GXMISC::CStringParse<sint32> strParse(pstr);
			strParse.parse(str);

			if(strParse.size() != 5)
			{
				return false;
			}

			value1 = strParse[0];
			value2 = strParse[1];
			value3 = strParse[2];
			value4 = strParse[3];
			value5 = strParse[4];

			return true;
		}

	public:
		sint32 value1;
		sint32 value2;
		sint32 value3;
		sint32 value4;
		sint32 value5;
	};

	template<>
	class MultiInt<6>
	{
	public:
		MultiInt()
		{
			value1 = 0;
			value2 = 0;
			value3 = 0;
			value4 = 0;
			value5 = 0;
			value6 = 0;
		}

	public:
		bool parse(const std::string& str, const std::string& pstr)
		{
			GXMISC::CStringParse<sint32> strParse(pstr);
			strParse.parse(str);

			if(strParse.size() != 6)
			{
				return false;
			}

			value1 = strParse[0];
			value2 = strParse[1];
			value3 = strParse[2];
			value4 = strParse[3];
			value5 = strParse[4];
			value6 = strParse[5];

			return true;
		}

	public:
		sint32 value1;
		sint32 value2;
		sint32 value3;
		sint32 value4;
		sint32 value5;
		sint32 value6;
	};

	template<>
	class MultiInt<7>
	{
	public:
		MultiInt()
		{
			value1 = 0;
			value2 = 0;
			value3 = 0;
			value4 = 0;
			value5 = 0;
			value6 = 0;
			value7 = 0;
		}

	public:
		bool parse(const std::string& str, const std::string& pstr)
		{
			GXMISC::CStringParse<sint32> strParse(pstr);
			strParse.parse(str);

			if(strParse.size() != 7)
			{
				return false;
			}

			value1 = strParse[0];
			value2 = strParse[1];
			value3 = strParse[2];
			value4 = strParse[3];
			value5 = strParse[4];
			value6 = strParse[5];
			value7 = strParse[6];

			return true;
		}

	public:
		sint32 value1;
		sint32 value2;
		sint32 value3;
		sint32 value4;
		sint32 value5;
		sint32 value6;
		sint32 value7;
	};

	template<>
	class MultiInt<8>
	{
	public:
		MultiInt()
		{
			value1 = 0;
			value2 = 0;
			value3 = 0;
			value4 = 0;
			value5 = 0;
			value6 = 0;
			value7 = 0;
			value8 = 0;
		}

	public:
		bool parse(const std::string& str, const std::string& pstr)
		{
			GXMISC::CStringParse<sint32> strParse(pstr);
			strParse.parse(str);

			if(strParse.size() != 8)
			{
				return false;
			}

			value1 = strParse[0];
			value2 = strParse[1];
			value3 = strParse[2];
			value4 = strParse[3];
			value5 = strParse[4];
			value6 = strParse[5];
			value7 = strParse[6];
			value8 = strParse[7];

			return true;
		}

	public:
		sint32 value1;
		sint32 value2;
		sint32 value3;
		sint32 value4;
		sint32 value5;
		sint32 value6;
		sint32 value7;
		sint32 value8;
	};


	const static uint32 MAX_MULTI_INT_NUM = 1024;
	template<>
	class MultiInt<MAX_MULTI_INT_NUM>
	{
	public:
		typedef std::vector<sint32> TBaseType;
		typedef TBaseType::iterator iterator;
		typedef TBaseType::const_iterator const_iterator;
		typedef TBaseType::const_reference const_reference;

	public:
		MultiInt()
		{
			vec.clear();
		}

	public:
		bool parse(const std::string& str, const std::string& pstr)
		{
			GXMISC::CStringParse<sint32> strParse(pstr);
			strParse.parse(str);
			vec = strParse.getValueList();

			return true;
		}

		iterator begin()
		{
			return vec.begin();
		}

		iterator end()
		{
			return vec.end();
		}

		const_iterator begin() const
		{
			return vec.begin();
		}

		const_iterator end() const
		{
			return vec.end();
		}

		uint32 size()
		{
			return (uint32)vec.size();
		}

		const_reference at(uint32 i)
		{
			return vec[i];
		}

		sint32& operator[](uint32 i)
		{
			return vec[i];
		}


		template<typename Ary>
		void get(Ary& ary)
		{
			ary.clear();
			for(uint32 i = 0; i < vec.size(); ++i)
			{
				ary.pushBack((typename Ary::value_type)vec[i]);
			}
		}

		template<typename Ary>
		void getCont(Ary& ary)
		{
			ary.clear();
			for(uint32 i = 0; i < vec.size(); ++i)
			{
				ary.push_back((typename Ary::value_type)vec[i]);
			}
		}

	public:
		std::vector<sint32> vec;
	};

	typedef MultiInt<1> Int;
	typedef MultiInt<2> Int2;
	typedef MultiInt<3> Int3;
	typedef MultiInt<4> Int4;
	typedef MultiInt<5> Int5;
	typedef MultiInt<MAX_MULTI_INT_NUM> IntX;

	template<typename T>
	class CIntAry2LParser
	{
	public:
		typedef std::vector<T> TBaseType;
		typedef typename TBaseType::iterator iterator;
		typedef typename TBaseType::const_iterator const_iterator;

	public:
		bool parse(const char* str, const std::string& pstr1, const std::string& pstr2)
		{
			if(str == NULL)
			{
				return true;
			}

			GXMISC::CStringParse<std::string> strParse(pstr1);
			strParse.parse(str);

			if(strParse.size() <= 0)
			{
				return true;
			}

			_vec.resize(strParse.size());

			for(uint32 i = 0; i < strParse.size(); ++i)
			{
				if(false == _vec[i].parse(strParse[i].c_str(), pstr2))
				{
					return false;
				}
			}

			return true;
		}

		T& operator[](uint32 _Pos)
		{
			return _vec[_Pos];
		}

		uint32 size()
		{
			return (uint32)_vec.size();
		}

		void clear()
		{
			_vec.clear();
		}

		iterator begin()
		{
			return _vec.begin();
		}

		iterator end()
		{
			return _vec.end();
		}

		//     template<typename Cont>
		//     void getCont(Cont& cont)
		//     {
		//         for(uint32 i = 0; i < _vec.size(); ++i)
		//         {
		//             cont.push_back(_vec[i]);
		//         }
		//     }

	private:
		std::vector<T> _vec;
	};

	template<typename T>
	class CIntAry3LParser
	{
	public:
		typedef CIntAry2LParser<T> ValueType;
		typedef std::vector<CIntAry2LParser<T> > TBaseType;
		typedef typename TBaseType::iterator iterator;
		typedef typename TBaseType::const_iterator const_iterator;
	public:
		bool parse(const char* str, const std::string& pstr1, const std::string& pstr2, const std::string& pstr3)
		{
			if(NULL == str)
			{
				return true;
			}

			GXMISC::CStringParse<std::string> strParse(pstr1);
			strParse.parse(str);
			if(strParse.size() <= 0)
			{
				return true;
			}

			_vec.resize(strParse.size());

			for(uint32 i = 0; i < strParse.size(); ++i)
			{
				if(false == _vec[i].parse(strParse[i].c_str(), pstr2, pstr3))
				{
					return false;
				}
			}

			return true;
		}

		CIntAry2LParser<T>& operator[](uint32 _Pos)
		{
			return _vec[_Pos];
		}

		uint32 size()
		{
			return (uint32)_vec.size();
		}

		iterator begin()
		{
			return _vec.begin();
		}

		iterator end()
		{
			return _vec.end();
		}

	private:
		std::vector<CIntAry2LParser<T> > _vec;
	};

	template<typename T>
	class CIntAry1LParser
	{
	public:
		typedef std::vector<T> ContType;
		typedef typename ContType::iterator iterator;

	public:
		bool parse(const char* str, const std::string& pstr1)
		{
			if(NULL == str)
			{
				return true;
			}

			GXMISC::CStringParse<T> strParse(pstr1);
			strParse.parse(str);

			if(strParse.size() <= 0)
			{
				return true;
			}

			std::vector<T> valueList = strParse.getValueList();
			_vec.reserve(valueList.size());
			for(uint32 i = 0; i < valueList.size(); ++i)
			{
				_vec.push_back(valueList[i]);
			}

			return true;
		}

		uint32 size()
		{
			return (uint32)_vec.size();
		}

		T& operator[](uint32 pos)
		{
			return _vec[pos];
		}

		template<typename Ary>
		void get(Ary& ary)
		{
			ary.clear();
			for(uint32 i = 0; i < _vec.size(); ++i)
			{
				ary.pushBack((typename Ary::value_type)_vec[i]);
			}
		}

		template<typename Ary>
		void getCont(Ary& ary)
		{
			ary.clear();
			for(uint32 i = 0; i < _vec.size(); ++i)
			{
				ary.push_back((typename Ary::value_type)_vec[i]);
			}
		}

		void clear()
		{
			_vec.clear();
		}

		iterator begin()
		{
			return _vec.begin();
		}

		iterator end()
		{
			return _vec.end();
		}

	private:
		std::vector<T> _vec;
	};

	typedef CIntAry1LParser<sint32> IntAry;

	typedef CIntAry2LParser<Int>	IntAry2;
	typedef CIntAry2LParser<Int2>   Int2Ary2;
	typedef CIntAry2LParser<Int3>   Int3Ary2;
	typedef CIntAry2LParser<Int4>   Int4Ary2;
	typedef CIntAry2LParser<Int5>   Int5Ary2;
	typedef CIntAry2LParser<IntX>	IntXAry2;

	typedef CIntAry3LParser<Int>	IntAry3;
	typedef CIntAry3LParser<Int2>   Int2Ary3;
	typedef CIntAry3LParser<Int3>   Int3Ary3;
	typedef CIntAry3LParser<Int4>   Int4Ary3;
	typedef CIntAry3LParser<Int5>   Int5Ary3;
	typedef CIntAry3LParser<IntX>	IntXAry3;

}

#endif // _PARSE_MISC_H_