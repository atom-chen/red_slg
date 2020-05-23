#ifndef _FIX_STRING_H_
#define _FIX_STRING_H_

#include <string>
#include <assert.h>
#include <functional>

#include "string_util.h"

#pragma pack(push, 1)

namespace GXMISC
{
	// @TODO 需要测试所有接口是否可用
	class CFixNullBase
	{

	};
	class CFixLenBase
	{
	public:
	protected:
		uint16 _strLen;
	};
	template<uint32 N>
	class CFixMemory
	{
	public:
		CFixMemory()
		{
			memset(_ary, 0, N);
		}
		~CFixMemory()
		{
			memset(_ary, 0, N);
		}

	public:
		char* data()
		{
			return _ary;
		}
		sint32 size() const
		{
			return N;
		}
	protected:
		char _ary[N];
	};
	/**
	* 定长字符串
	*/
	template<uint32 N>
	class CFixString : public CFixMemory<N>
	{
	public:
		typedef char HashKeyType;
		const static HashKeyType InvalidKey = '0';

	public:
		
		CFixString(HashKeyType key)
		{
			memset(_ary, 0, N);
			_ary[0] = key;
		}

		CFixString()
		{
			memset(_ary, 0, N);
		}

		CFixString(const char *s)
		{
			uint32 strLen = (uint32)strlen(s);
			uint32 n = std::min(strLen, N);
			memset(_ary, 0, N);
			gxStrcpy(_ary, N, s, n);
			refix();

			check();
		}

		CFixString(const std::string &s)
		{
			uint32 strLen = (uint32)s.size();
			uint32 n = std::min(strLen, N);

			memset(_ary, 0, N);

			gxStrcpy(_ary, N, s.c_str(), strLen);
			refix();

			check();
		}

	public:
		char* data()
		{
			return _ary;
		}

		sint32 size() const
		{
			return (sint32)strlen(_ary);
		}

		const char* c_str() const
		{
			check();
			return _ary;
		}

		const std::string toString() const
		{
			return std::string(_ary);
		}

		operator std::string() const
		{
			return std::string(_ary);
		}

		void check() const 
		{
		}

		operator const char*()
		{
			return _ary;
		}

		operator const char* const() const
		{
			return _ary;
		}

		bool empty()
		{
			check();
			refix();
			return ::strlen(_ary) == 0;
		}

		char& operator[](sint32 i)
		{
			check();
			return _ary[i];
		}

		void refix()
		{
			_ary[N-1] = 0;
		}

		void clear()
		{
			memset(_ary, 0, sizeof(_ary));
		}

		CFixString<N>& operator=(const char *s);
		CFixString<N>& operator=(const std::string &s);
		CFixString<N>& operator=(const CFixString<N>& rhs);

		bool operator==(const CFixString<N> &other) const;
		bool operator==(const std::string &other) const;
		bool operator==(const char* other) const;

		bool operator!=(const CFixString<N> &other) const;
		bool operator!=(const std::string &other) const;
		bool operator!=(const char* other) const;

		bool operator<=(const CFixString<N> &other) const;
		bool operator<=(const std::string &other) const;
		bool operator<=(const char* other) const;

		bool operator>=(const CFixString<N> &other) const;
		bool operator>=(const std::string &other) const;
		bool operator>=(const char* other) const;

		bool operator>(const CFixString<N> &other) const;
		bool operator>(const std::string &other) const;
		bool operator>(const char* other) const;

		bool operator<(const CFixString<N> &other) const;
		bool operator<(const std::string &other) const;
		bool operator<(const char* other) const;

	private:
		sint32 _dataCmp(const char* src, const char* dest) const
		{
			return gxStricmp(src, dest);
		}

	private:
		char _ary[N];
	};

	template<uint32 N>
	inline CFixString<N>& CFixString<N>::operator=(const char *s)
	{
		uint32 strLen = (uint32)strlen(s);
		uint32 n = std::min(strLen, N);
		
		memset(_ary, 0, N);

		gxStrcpy(_ary, N, s, strLen);
		refix();

		check();
		return *this;
	}
	
	template<uint32 N>
	CFixString<N>&  CFixString<N>::operator=(const CFixString<N>& rhs)
	{
		return this->operator =(rhs.c_str());
	}

	template<uint32 N>
	inline CFixString<N>& CFixString<N>::operator=(const std::string &s)
	{
		uint32 strLen = (uint32)s.size();
		uint32 n = std::min(strLen, N);

		memset(_ary, 0, N);

		gxStrcpy(_ary, N, s.c_str(), n);
		refix();

		check();
		return *this;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator==(const CFixString<N> &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str())==0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator==(const std::string &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str())==0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator==(const char* other) const
	{
		check();
		return _dataCmp(c_str(),other)==0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator!=(const CFixString<N> &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str())!=0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator!=(const std::string &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str())!=0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator!=(const char* other) const
	{
		check();
		return _dataCmp(c_str(),other)!=0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator<=(const CFixString<N> &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str())<=0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator<=(const std::string &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str())<=0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator<=(const char* other) const
	{
		check();
		return _dataCmp(c_str(),other)<=0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator>=(const std::string &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str())>=0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator>=(const char* other) const
	{
		check();
		return _dataCmp(c_str(),other)>=0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator>(const CFixString<N> &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str())>0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator>(const std::string &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str())>0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator>(const char* other) const
	{
		check();
		return _dataCmp(c_str(),other)>0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator<(const CFixString<N> &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str())<0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator<(const std::string &other) const
	{
		check();
		return _dataCmp(c_str(),other.c_str()) < 0;
	}

	template<uint32 N>
	inline bool CFixString<N>::operator<(const char* other) const
	{
		check();
		return _dataCmp(c_str(),other) < 0;
	}
}

#pragma pack(pop)

#endif