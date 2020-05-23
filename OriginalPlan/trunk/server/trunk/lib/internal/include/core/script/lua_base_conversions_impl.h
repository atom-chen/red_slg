#ifndef _LUA_BASE_CONVERSIONS_IMPL_H_
#define _LUA_BASE_CONVERSIONS_IMPL_H_

#include "lua_base_conversions.h"
#include "lua_tinker.h"

template <typename T, typename Cont, bool>
struct _container_to_luaval;

template <typename T, typename Cont>
struct _container_to_luaval<T, Cont, false>
{
	static void Invoke(lua_State* L, const char* type, const Cont& inValue)
	{
		static_assert(std::is_pointer<T>::value == true && std::is_pointer<typename std::remove_pointer<T>::type>::value == false && std::is_object<typename std::remove_pointer<T>::type>::value == true, "false");

		lua_newtable(L);

		if (nullptr == L)
			return;

		int indexTable = 1;
		for (const auto& obj : inValue)
		{
			if (nullptr != (obj))
			{
				lua_pushnumber(L, (lua_Number)indexTable);
				object_to_luaval(L, type, obj);
				lua_rawset(L, -3);
				++indexTable;
			}
		}
	}
};

template <typename T, typename Cont>
struct _container_to_luaval<T, Cont, true>
{
	static void Invoke(lua_State* L, const char* type, const Cont& inValue)
	{
		lua_newtable(L);

		if (nullptr == L)
			return;

		int indexTable = 1;
		for (const auto& obj : inValue)
		{
			lua_pushnumber(L, (lua_Number)indexTable);
			lua_tinker::push(L, obj);
			lua_rawset(L, -3);
			++indexTable;
		}
	}
};

template<typename T>
void vector_to_luaval(lua_State* L, const char* type, const std::vector<T>& inValue)
{
	return _container_to_luaval<T, std::vector<T>, is_base_type<T>::value>::Invoke(L, type, inValue);
}

template<typename T>
void list_to_luaval(lua_State* L, const char* type, const std::list<T>& inValue)
{
	return _container_to_luaval<T, std::list<T>, is_base_type<T>::value>::Invoke(L, type, inValue);
}

template<typename T, int N, typename LenType>
void array_to_luaval(lua_State* L, const char* type, const GXMISC::CArray<T, N, LenType>& inValue)
{
	return _container_to_luaval<T, GXMISC::CArray<T, N, LenType>, is_base_type<T>::value>::Invoke(L, type, inValue);
}

template <class K, typename V, bool>
struct _map_to_luaval
{
	static void Invoke(lua_State* L, const char* type, const std::map<K, V>& v)
	{
		static_assert(is_base_type<K>::value == true, "false");
		static_assert(std::is_pointer<V>::value == true && std::is_pointer<typename std::remove_pointer<V>::type>::value == false && std::is_object<typename std::remove_pointer<V>::type>::value == true, "false");

		lua_newtable(L);

		if (nullptr == L)
		{
			return;
		}

		for (auto iter = v.begin(); iter != v.end(); ++iter)
		{
			K key = iter->first;
			V obj = iter->second;
			if (nullptr != (obj))
			{
				lua_tinker::push(L, key);
				object_to_luaval(L, type, obj);
				lua_rawset(L, -3);
			}
		}
	}
};

template <class K, typename V>
struct _map_to_luaval<K, V, true>
{
	static void Invoke(lua_State* L, const char* type, const std::map<K, V>& v)
	{
		static_assert(is_base_type<K>::value == true, "false");

		lua_newtable(L);

		if (nullptr == L)
		{
			return;
		}

		for (auto iter = v.begin(); iter != v.end(); ++iter)
		{
			K key = iter->first;
			V obj = iter->second;
			if (nullptr != (obj))
			{
				lua_tinker::push(L, key);
				lua_tinker::push(L, obj);
				lua_rawset(L, -3);
			}
		}
	}
};

template<typename K, typename V>
void map_to_luaval(lua_State* L, const char* type, const std::map<K, V>& v)
{
	return _map_to_luaval<K, V, is_base_type<V>::value>::Invoke(L, type, v);
}

void vector_std_string_to_luaval(lua_State* L, const std::vector<std::string>& inValue);
void vector_int_to_luaval(lua_State* L, const std::vector<sint32>& inValue);
void vector_float_to_luaval(lua_State* L, const std::vector<float>& inValue);
void vector_ushort_to_luaval(lua_State* L, const std::vector<uint16>& inValue);
void script_string_to_luaval(lua_State* L, const CScriptString& inValue);
template<int N>
void fixstring_to_luaval(lua_State* L, const GXMISC::CFixString<N>& inValue)
{
	lua_pushstring(L, inValue.c_str());
}
template<int N, typename LenType>
void array_string_to_luaval(lua_State* L, const GXMISC::CCharArray<N, LenType>& inValue)
{
	lua_pushlstring(L, (char*)inValue.data(), inValue.size());
}

#endif