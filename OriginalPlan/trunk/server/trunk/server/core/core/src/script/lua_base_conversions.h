#ifndef __LUA_BAIS_CONVERSIONS_H__
#define __LUA_BAIS_CONVERSIONS_H__

#include <unordered_map>

extern "C" {
#include "lua.h"
#include "tolua++.h"
}

#include "fix_string.h"
#include "carray.h"

#include "tolua_fix.h"

#define LUA_PRECONDITION( condition, ...)
#define CCLOG(...)

extern std::unordered_map<std::string, std::string>  g_luaType;
extern std::unordered_map<std::string, std::string>  g_typeCast;

class CScriptString
{
public:
	const char* buffer;
	sint32 len;

public:
	CScriptString(const char* buf, sint32 bufLen)
	{
		buffer = buf;
		len = bufLen;
	}
	CScriptString()
	{
		buffer = NULL;
		len = 0;
	}
};

/**
Because all override functions wouldn't be bound,so we must use `typeid` to get the real class name
*/
template <typename T>
const char* getLuaTypeName(T* ret, const char* type = "")
{
	std::string hashName = typeid(T).name();
	auto iter = g_luaType.find(hashName);
	if (g_luaType.end() != iter)
	{
		return iter->second.c_str();
	}

	return nullptr;
}

void luaval_to_native_err(lua_State* L,const char* msg,tolua_Error* err, const char* funcName = "");

extern bool luaval_is_usertype(lua_State* L,int lo,const char* type, int def);

// to native
extern bool luaval_to_boolean(lua_State* L, int lo, bool* outValue, const char* funcName = "");
extern bool luaval_to_sint8(lua_State* L, int lo, sint8* outValue, const char* funcName = "");
extern bool luaval_to_uint8(lua_State* L, int lo, uint8* outValue, const char* funcName = "");
extern bool luaval_to_sint16(lua_State* L, int lo, sint16* outValue, const char* funcName = "");
extern bool luaval_to_uint16(lua_State* L, int lo, uint16* outValue, const char* funcName = "");
extern bool luaval_to_sint32(lua_State* L,int lo,sint32* outValue, const char* funcName = "");
extern bool luaval_to_uint32(lua_State* L, int lo, uint32* outValue, const char* funcName = "");
extern bool luaval_to_sint64(lua_State* L, int lo, sint64* outValue, const char* funcName = "");
extern bool luaval_to_uint64(lua_State* L, int lo, uint64* outValue, const char* funcName = "");
extern bool luaval_to_number(lua_State* L, int lo, double* outValue, const char* funcName = "");
extern bool luaval_to_std_string(lua_State* L, int lo, std::string* outValue, const char* funcName = "");
extern bool luaval_to_script_string(lua_State*L, int lo, CScriptString* outValue, const char* funcName = "");
extern bool luaval_to_std_vector_string(lua_State* L, int lo, std::vector<std::string>* ret, const char* funcName = "");
extern bool luaval_to_std_vector_int(lua_State* L, int lo, std::vector<sint32>* ret, const char* funcName = "");
extern bool luaval_to_std_vector_float(lua_State* L, int lo, std::vector<float>* ret, const char* funcName = "");
extern bool luaval_to_std_vector_ushort(lua_State* L, int lo, std::vector<uint16>* ret, const char* funcName = "");

template<int N>
bool luaval_to_fixstring(lua_State* L, int lo, GXMISC::CFixString<N>* outValue, const char* funcName = "")
{
	if (NULL == L || NULL == outValue)
		return false;

	bool ok = true;

	tolua_Error tolua_err;
	if (!tolua_iscppstring(L, lo, 0, &tolua_err))
	{
		luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
		ok = false;
	}

	if (ok)
	{
		*outValue = lua_tostring(L, lo);
	}

	return ok;
}

template<int N, typename LenType>
bool luaval_to_array_string(lua_State* L, int lo, GXMISC::CCharArray<N, LenType>* outValue, const char* funcName = "")
{
	if (NULL == L || NULL == outValue)
		return false;

	bool ok = true;

	tolua_Error tolua_err;
	if (!tolua_iscppstring(L, lo, 0, &tolua_err))
	{
		luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
		ok = false;
	}

	if (ok)
	{
		size_t len;
		const char* buf = lua_tolstring(L, lo, &len);
		outValue->pushBack(buf, len);
	}

	return ok;
}

template <typename T>
bool luaval_to_object(lua_State* L, int lo, const char* type, T** ret, const char* funcName = "")
{
	if (nullptr == L || lua_gettop(L) < lo)
		return false;

	tolua_Error tolua_err;
	if (!tolua_isusertype(L, lo, type, 0, &tolua_err))
	{
		luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
		return false;
	}

	*ret = static_cast<T*>(tolua_tousertype(L, lo, 0));

	if (nullptr == ret){
		LUA_PRECONDITION(ret, "Invalid Native Object");
	}

	return true;
}

template<typename T>
bool luaval_to_basetype(lua_State* L, int lo, T* outValue, const char* funcName = "");
template<typename T>
struct is_base_type
{
	enum{
		value = false
	};
};
#define luaval_to_basetype_macro(name, T)\
	inline bool luaval_to_basetype(lua_State* L, int lo, T* outValue, const char* funcName = ""){	\
		return luaval_to_##name(L, lo, outValue, funcName);	\
	}\
template<>\
struct is_base_type<T>{ enum{ value = true }; };

luaval_to_basetype_macro(boolean, bool);
luaval_to_basetype_macro(uint8,uint8);
luaval_to_basetype_macro(sint8,sint8);
luaval_to_basetype_macro(uint16,uint16);
luaval_to_basetype_macro(sint16, sint16);
luaval_to_basetype_macro(sint32, sint32);
luaval_to_basetype_macro(uint32, uint32);
luaval_to_basetype_macro(sint64, sint64);
luaval_to_basetype_macro(uint64, uint64);
luaval_to_basetype_macro(number, double);
luaval_to_basetype_macro(std_string, std::string);

// 转换成对象列表
template <typename T, typename Cont, bool>
struct _luaval_to_container
{
	static bool Invoke(lua_State* L, int lo, const char* type, Cont* ret, const char* funcName = "")
	{
		static_assert(std::is_pointer<T>::value == true && std::is_pointer<typename std::remove_pointer<T>::type>::value == false && std::is_object<typename std::remove_pointer<T>::type>::value == true, "false");

		if (nullptr == L || nullptr == ret)
			return false;

		bool ok = true;

		tolua_Error tolua_err;
		if (!tolua_istable(L, lo, 0, &tolua_err))
		{
			luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
			ok = false;
		}

		if (ok)
		{
#if LUA_VERSION_NUM > 501
			size_t len = lua_rawlen(L, lo);
#else
			size_t len = lua_objlen(L, lo);
#endif
			for (size_t i = 0; i < len; i++)
			{
				lua_pushnumber(L, i + 1);
				lua_gettable(L, lo);

				T val = NULL;
				if (!luaval_to_object(L, lo, getLuaTypeName(val), &val, funcName))
				{
					lua_pop(L, 1);
					ok = false;
					break;
				}

				ret->push_back(val);

				lua_pop(L, 1);
			}
		}

		if (!ok)
		{
			ret->clear();
		}

		return ok;
	}
};

template <typename T, typename Cont>
struct _luaval_to_container<T, Cont, true>
{
	static bool Invoke(lua_State* L, int lo, const char* type, Cont* ret, const char* funcName = "")
	{
		if (nullptr == L || nullptr == ret)
			return false;

		bool ok = true;

		tolua_Error tolua_err;
		if (!tolua_istable(L, lo, 0, &tolua_err))
		{
			luaval_to_native_err(L, "#ferror:", &tolua_err);
			ok = false;
		}

		if (ok)
		{
#if LUA_VERSION_NUM > 501
			size_t len = lua_rawlen(L, lo);
#else
			size_t len = lua_objlen(L, lo);
#endif
			for (size_t i = 0; i < len; i++)
			{
				lua_pushnumber(L, i + 1);
				lua_gettable(L, lo);

				T val;
				if (!luaval_to_basetype(L, lo, &val, funcName))
				{
					lua_pop(L, 1);
					ok = false;
					break;
				}

				ret->push_back(val);

				lua_pop(L, 1);
			}
		}

		if (!ok)
		{
			ret->clear();
		}

		return ok;
	}
};

template <typename T>
inline bool luaval_to_vector(lua_State* L, int lo, const char* type, std::vector<T>* ret, const char* funcName)
{
	return _luaval_to_container<T, std::vector<T>, is_base_type<T>::value>::Invoke(L, lo, type, ret, funcName);
}

template <typename T>
inline bool luaval_to_list(lua_State* L, int lo, const char* type, std::list<T>* ret, const char* funcName)
{
	return _luaval_to_container<T, std::list<T>, is_base_type<T>::value>::Invoke(L, lo, type, ret, funcName);
}

template <typename T, int N, typename LenType>
inline bool luaval_to_array(lua_State* L, int lo, const char* type, GXMISC::CArray<T, N, LenType>* ret, const char* funcName)
{
	return _luaval_to_container<T, GXMISC::CArray<T, N, LenType>, is_base_type<T>::value>::Invoke(L, lo, type, ret, funcName);
}

template <typename K, typename V, bool>
struct _luaval_to_map
{
	static bool Invoke(lua_State* L, int lo, const char* type, std::map<K, V>* ret, const char* funcName = "")
	{
		static_assert(is_base_type<K>::value == true, "false");
		static_assert(std::is_pointer<V>::value == true && std::is_pointer<typename std::remove_pointer<V>::type>::value == false && std::is_object<typename std::remove_pointer<V>::type>::value == true, "false");

		if (nullptr == L || nullptr == ret || lua_gettop(L) < lo)
			return false;

		tolua_Error tolua_err;
		bool ok = true;
		if (!tolua_istable(L, lo, 0, &tolua_err))
		{
			luaval_to_native_err(L, "#ferror:", &tolua_err);
			ok = false;
		}

		if (ok)
		{
			K key;
			lua_pushnil(L);                                             /* first key L: lotable ..... nil */
			while (0 != lua_next(L, lo))								/* L: lotable ..... key value */
			{
				if (!luaval_to_basetype(L, -2, &key, funcName))
				{
					lua_pop(L, 2);
					ok = false;
					break;
				}

				V val = NULL;
				if (!luaval_to_object(L, lo, getLuaTypeName(val), &val, funcName))
				{
					lua_pop(L, 2);
					ok = false;
					break;
				}

				ret->insert(std::map<K, V>::value_type(key, val));

				lua_pop(L, 1);                                          /* L: lotable ..... key */
			}
		}

		if (!ok)
		{
			ret->clear();
		}

		return ok;
	}
};

template <typename K, typename V>
struct _luaval_to_map<K, V, true>
{
	static bool Invoke(lua_State* L, int lo, const char* type, std::map<K, V>* ret, const char* funcName = "")
	{
		static_assert(is_base_type<K>::value == true, "false");

		if (nullptr == L || nullptr == ret || lua_gettop(L) < lo)
			return false;

		tolua_Error tolua_err;
		bool ok = true;
		if (!tolua_istable(L, lo, 0, &tolua_err))
		{
			luaval_to_native_err(L, "#ferror:", &tolua_err);
			ok = false;
		}

		if (ok)
		{
			K key;
			lua_pushnil(L);                                             /* first key L: lotable ..... nil */
			while (0 != lua_next(L, lo))								/* L: lotable ..... key value */
			{
				if (!luaval_to_basetype(L, -2, &key, funcName))
				{
					lua_pop(L, 2);
					ok = false;
					break;
				}

				V val;
				if (!luaval_to_basetype(L, lo, &val, funcName))
				{
					lua_pop(L, 2);
					ok = false;
					break;
				}

				ret->insert(std::map<K, V>::value_type(key, val));

				lua_pop(L, 1);                                          /* L: lotable ..... key */
			}
		}

		if (!ok)
		{
			ret->clear();
		}

		return ok;
	}
};

template <typename K, typename V>
bool luaval_to_map(lua_State* L, int lo, const char* type, std::map<K, V>* ret, const char* funcName)
{
	return _luaval_to_map<K, V, is_base_type<V>::value>::Invoke(L, lo, type, ret, funcName);
}

// @TODO 加上Function Name
template <class T>
void object_to_luaval(lua_State* L, const char* type, T* ret)
{
	if (nullptr != ret)
	{
		const char* typen = getLuaTypeName(ret, type);
		if (nullptr == typen)
		{
			tolua_Error tolua_err;
			tolua_err.array = 0;
			tolua_err.index = 0;
			tolua_err.type = typeid(T).name();
			luaval_to_native_err(L, "#ferror:", &tolua_err);

			lua_pushnil(L);
			return;
		}

		tolua_pushusertype(L, (void*)ret, typen);
	}
	else
	{
		lua_pushnil(L);
	}
}

#endif //__LUA_BAIS_CONVERSIONS_H__
