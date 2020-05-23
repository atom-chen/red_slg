#ifndef _HASH_UTIL_H_
#define _HASH_UTIL_H_

#include "types_def.h"
#include "fix_string.h"
// @TODO 重新检查接口设计是否合理
// CHashMap, CHashSet and CHashMultiMap definitions
#if defined(_STLPORT_VERSION) // STLport detected
#	include <hash_map>
#	include <hash_set>
#	ifdef _STLP_HASH_MAP
#		define CHashMap ::std::hash_map
#		define CHashSet ::std::hash_set
#		define CHashMultiMap ::std::hash_multimap
#	endif // _STLP_HASH_MAP
#elif defined(ISO_STDTR1_AVAILABLE) // use std::tr1 for CHash* classes, if available (gcc 4.1+ and VC9 with TR1 feature pack):
#	include ISO_STDTR1_HEADER(unordered_map)
#	include ISO_STDTR1_HEADER(unordered_set)
#	define CHashMap std::tr1::unordered_map
#	define CHashSet std::tr1::unordered_set
#	define CHashMultiMap std::tr1::unordered_multimap

#ifdef OS_WINDOWS
namespace std
{
	namespace tr1
	{
		typedef struct _DivLL
		{
			uint64 quot;
			uint64 rem;
		}TDivLL;

		template<typename T>
		TDivLL DivLL(T t, uint32 v)
		{
			TDivLL result;

			result.quot = t / v;
			result.rem = t % v;

			return result;
		}
#ifndef COMP_VC10
		template<>
		class hash<uint64>
			: public unary_function<uint64, sint32>
		{	// hash functor
		public:
			sint32 operator()(const uint64& _Keyval) const
			{	
				// hash _Keyval to size_t value by pseudorandomizing transform
				TDivLL _Qrem = DivLL(_Keyval, 127773);

				_Qrem.rem = 16807 * _Qrem.rem - 2836 * _Qrem.quot;
				if (_Qrem.rem < 0)
					_Qrem.rem += 2147483647;
				sint32 retval = _Qrem.rem & 0xFFFFFFFF;
				return retval;
			}
		};

		template<>
		class hash<sint64 >
			: public unary_function<sint64, sint32>
		{	// hash functor
		public:
			sint32 operator()(const sint64& _Keyval) const
			{	
				// hash _Keyval to size_t value by pseudorandomizing transform
				TDivLL _Qrem = DivLL(_Keyval, 127773);

				_Qrem.rem = 16807 * _Qrem.rem - 2836 * _Qrem.quot;
				if (_Qrem.rem < 0)
					_Qrem.rem += 2147483647;
				sint32 retval = _Qrem.rem & 0xFFFFFFFF;
				return retval;
			}
		};

		template<>
		struct hash<char*>
			: public std::unary_function< char*, size_t>
		{
			sint32 operator()(const char*& str) const
			{ 
				sint32 _Val = 2166136261U;
				sint32 _First = 0;
				sint32 _Last = strlen(str);
				sint32 _Stride = 1 + _Last / 10;

				if (_Stride < _Last)
					_Last -= _Stride;
				for(; _First < _Last; _First += _Stride)
					_Val = 16777619U * _Val ^ (size_t)str[_First];
				return (_Val);
			}
		};
#endif
	}
}
#endif

#elif (COMP_VC9) || (COMP_VC10) // VC9
#   include <hash_map>
#   include <hash_set>
#	define CHashMap stdext::hash_map
#	define CHashSet stdext::hash_set
#	define CHashMultiMap stdext::hash_multimap
namespace std
{
	inline sint32 hash_value(const uint64& _Keyval)
	{
		sint32 val = (sint32)(_Keyval ^ _HASH_SEED);
		return val;
	}
	inline sint32 hash_value(const sint64& _Keyval)
	{
		sint32 val = (sint32)(_Keyval ^ _HASH_SEED);
		return val;
	}
}

namespace std
{
	template<>
	struct less<uint64>
	{
		bool operator()(const uint64& key1, const uint64& key2) const
		{
			return key1 < key2;
		}
	};

	template<>
	struct less<sint64>
	{
		bool operator()(const sint64& key1, const sint64& key2) const
		{
			return key1 < key2;
		}
	};
}
_STDEXT_BEGIN

template<>
inline size_t hash_value(const uint64& _Keyval) 
{
	size_t val = (_Keyval ^ _HASH_SEED) & 0xFFFFFFFF;
	return val;
}
inline size_t hash_value(const sint64& _Keyval)
{
	size_t val = (_Keyval ^ _HASH_SEED) & 0xFFFFFFFF;
	return val;
}

template<>
class hash_compare<uint64, std::less<uint64> >
{
protected:
	typedef uint64 _Kty;
	typedef std::less<uint64> _Pr;

public:
	enum
	{	// parameters for hash table
		bucket_size = 4,	// 0 < bucket_size
		min_buckets = 8};	// min_buckets = 2 ^^ N, 0 < N

		hash_compare()
			: comp()
		{	// construct with default comparator
		}

		hash_compare(_Pr _Pred)
			: comp(_Pred)
		{	// construct with _Pred comparator
		}

		sint32 operator()(const _Kty& _Keyval) const
		{	// hash _Keyval to size_t value by pseudorandomizing transform
			long _Quot = (long)(hash_value(_Keyval) & LONG_MAX);
			ldiv_t _Qrem = ldiv(_Quot, 127773);

			_Qrem.rem = 16807 * _Qrem.rem - 2836 * _Qrem.quot;
			if (_Qrem.rem < 0)
				_Qrem.rem += LONG_MAX;
			return ((sint32)_Qrem.rem);
		}

		bool operator()(const _Kty& _Keyval1, const _Kty& _Keyval2) const
		{	// test if _Keyval1 ordered before _Keyval2
			return (comp(_Keyval1, _Keyval2));
		}

protected:
	_Pr comp;	// the comparator object
};
template<>
class hash_compare<sint64, std::less<sint64> >
{
protected:
	typedef sint64 _Kty;
	typedef std::less<sint64> _Pr;

public:
	enum
	{	// parameters for hash table
		bucket_size = 4,	// 0 < bucket_size
		min_buckets = 8};	// min_buckets = 2 ^^ N, 0 < N

		hash_compare()
			: comp()
		{	// construct with default comparator
		}

		hash_compare(_Pr _Pred)
			: comp(_Pred)
		{	// construct with _Pred comparator
		}

		sint32 operator()(const _Kty& _Keyval) const
		{	// hash _Keyval to size_t value by pseudorandomizing transform
			long _Quot = (long)(hash_value(_Keyval) & LONG_MAX);
			ldiv_t _Qrem = ldiv(_Quot, 127773);

			_Qrem.rem = 16807 * _Qrem.rem - 2836 * _Qrem.quot;
			if (_Qrem.rem < 0)
				_Qrem.rem += LONG_MAX;
			return ((sint32)_Qrem.rem);
		}

		bool operator()(const _Kty& _Keyval1, const _Kty& _Keyval2) const
		{	// test if _Keyval1 ordered before _Keyval2
			return (comp(_Keyval1, _Keyval2));
		}

protected:
	_Pr comp;	// the comparator object
};

_STDEXT_END

#elif defined(COMP_GCC) // GCC4
#	include <ext/hash_map>
#	include <ext/hash_set>
#	define CHashMap ::__gnu_cxx::hash_map
#	define CHashSet ::__gnu_cxx::hash_set
#	define CHashMultiMap ::__gnu_cxx::hash_multimap

namespace __gnu_cxx {

	template<> struct hash<std::string>
	{
		sint32 operator()(const std::string &s) const
		{
			return __stl_hash_string(s.c_str());
		}
	};

	template<> struct hash<uint64>
	{
		sint32 operator()(const uint64 x) const
		{
			return x;
		}
	};

	template<> struct hash<sint64>
	{
		sint32 operator()(const sint64 x) const
		{
			return x;
		}
	};

} // END NAMESPACE __GNU_CXX

#else
#	pragma error("You need to update your compiler")
#endif // _STLPORT_VERSION

#endif
