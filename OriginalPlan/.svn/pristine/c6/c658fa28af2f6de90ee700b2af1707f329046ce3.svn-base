/****************************************************************************
 Copyright (c) 2013-2014 Chukong Technologies Inc.
 
 http://www.cocos2d-x.org
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/

#include "lua_base_conversions.h"
#include "lua_tinker.h"
#include "debug.h"

std::unordered_map<std::string, std::string>  g_luaType;
std::unordered_map<std::string, std::string>  g_typeCast;

void luaval_to_native_err(lua_State* L,const char* msg,tolua_Error* err, const char* funcName)
{
    if (NULL == L || NULL == err || NULL == msg || 0 == strlen(msg))
        return;

    if (msg[0] == '#')
    {
        const char* expected = err->type;
        const char* provided = tolua_typename(L,err->index);
        if (msg[1]=='f')
        {
            int narg = err->index;
			if (err->array)
			{
				gxError("{0}\n     {1} argument #{2} is array of '{3}'; array of '{4}' expected.\n", msg + 2, funcName, narg, provided, expected);
			}
			else
			{
				gxError("{0}\n     {1} argument #{2} is '{3}'; '{4}' expected.\n", msg + 2, funcName, narg, provided, expected);
			}
        }
        else if (msg[1]=='v')
        {
			if (err->array){
				gxError("{0}\n     {1} value is array of '{2}'; array of '{3}' expected.\n", funcName, msg + 2, provided, expected);
			}
			else{
				gxError("{0}\n     {1} value is '{2}'; '{3}' expected.\n", msg + 2, funcName, provided, expected);
			}
        }
    }

	lua_tinker::on_error(L);
}

extern int lua_isusertype(lua_State* L, int lo, const char* type);

bool luaval_is_usertype(lua_State* L,int lo,const char* type, int def)
{
    if (def && lua_gettop(L)<abs(lo))
        return true;
    
    if (lua_isnil(L,lo) || lua_isusertype(L,lo,type))
        return true;
    
    return false;
}

bool luaval_to_boolean(lua_State* L, int lo, bool* outValue, const char* funcName)
{
	if (NULL == L || NULL == outValue)
		return false;

	bool ok = true;

	tolua_Error tolua_err;
	if (!tolua_isboolean(L, lo, 0, &tolua_err))
	{
		luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
		ok = false;
	}

	if (ok)
	{
		if(tolua_toboolean(L, lo, 0) != 0)
		{
			*outValue = true;
		}
		else
		{
			*outValue = false;
		}
	}

	return ok;
}

bool luaval_to_uint8(lua_State* L, int lo, uint8* outValue, const char* funcName)
{
    if (nullptr == L || nullptr == outValue)
        return false;
    
    bool ok = true;
    
    tolua_Error tolua_err;
    if (!tolua_isnumber(L,lo,0,&tolua_err))
    {
        luaval_to_native_err(L,"#ferror:",&tolua_err,funcName);
        ok = false;
    }
    
    if (ok)
    {
		*outValue = (uint8)tolua_tonumber(L, lo, 0);
    }
    
    return ok;
}

bool luaval_to_sint8(lua_State* L, int lo, sint8* outValue, const char* funcName)
{
	if (nullptr == L || nullptr == outValue)
		return false;

	bool ok = true;

	tolua_Error tolua_err;
	if (!tolua_isnumber(L, lo, 0, &tolua_err))
	{
		luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
		ok = false;
	}

	if (ok)
	{
		*outValue = (sint8)tolua_tonumber(L, lo, 0);
	}

	return ok;
}

bool luaval_to_uint16(lua_State* L, int lo, uint16* outValue, const char* funcName)
{
	if (NULL == L || NULL == outValue)
		return false;

	bool ok = true;

	tolua_Error tolua_err;
	if (!tolua_isnumber(L, lo, 0, &tolua_err))
	{
		luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
		ok = false;
	}

	if (ok)
	{
		*outValue = (uint16)tolua_tonumber(L, lo, 0);
	}

	return ok;
}

bool luaval_to_sint16(lua_State* L, int lo, sint16* outValue, const char* funcName)
{
	if (NULL == L || NULL == outValue)
		return false;

	bool ok = true;

	tolua_Error tolua_err;
	if (!tolua_isnumber(L, lo, 0, &tolua_err))
	{
		luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
		ok = false;
	}

	if (ok)
	{
		*outValue = (sint16)tolua_tonumber(L, lo, 0);
	}

	return ok;
}

bool luaval_to_sint32(lua_State* L,int lo,sint32* outValue, const char* funcName)
{
    if (NULL == L || NULL == outValue)
        return false;
    
    bool ok = true;

    tolua_Error tolua_err;
    if (!tolua_isnumber(L,lo,0,&tolua_err))
    {
        luaval_to_native_err(L,"#ferror:",&tolua_err,funcName);
        ok = false;
    }
    
    if (ok)
    {
		*outValue = (sint32)tolua_tonumber(L, lo, 0);
    }
    
    return ok;
}

bool luaval_to_uint32(lua_State* L, int lo, uint32* outValue, const char* funcName)
{
    if (NULL == L || NULL == outValue)
        return false;
    
    bool ok = true;

    tolua_Error tolua_err;
    if (!tolua_isnumber(L,lo,0,&tolua_err))
    {
        luaval_to_native_err(L,"#ferror:",&tolua_err,funcName);
        ok = false;
    }
    
    if (ok)
    {
		*outValue = (uint32)tolua_tonumber(L, lo, 0);
    }
    
    return ok;
}

bool luaval_to_uint64(lua_State* L, int lo, uint64* outValue, const char* funcName)
{
	if (NULL == L || NULL == outValue)
		return false;

	bool ok = true;

	tolua_Error tolua_err;
	if (!(lua_isuserdata(L, lo) || lua_isnumber(L, lo)))
	{
		tolua_err.index = lo;
		tolua_err.array = 0;
		tolua_err.type = "[no number]";
		luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
		ok = false;
	}

	if (ok)
	{
		*outValue = lua_tinker::read<uint64>(L, lo);
	}

	return ok;
}

bool luaval_to_sint64(lua_State* L, int lo, sint64* outValue, const char* funcName)
{
	if (NULL == L || NULL == outValue)
		return false;

	bool ok = true;

	tolua_Error tolua_err;
	if (!(lua_isuserdata(L, lo) || lua_isnumber(L, lo)))
	{
		tolua_err.index = lo;
		tolua_err.array = 0;
		tolua_err.type = "[no number]";
		luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
		ok = false;
	}

	if (ok)
	{
		*outValue = lua_tinker::read<sint64>(L, lo);
	}

	return ok;
}

bool luaval_to_number(lua_State* L,int lo,double* outValue, const char* funcName)
{
    if (NULL == L || NULL == outValue)
        return false;
    
    bool ok = true;

    tolua_Error tolua_err;
    if (!tolua_isnumber(L,lo,0,&tolua_err))
    {
        luaval_to_native_err(L,"#ferror:",&tolua_err,funcName);
        ok = false;
    }
    
    if (ok)
    {
        *outValue = tolua_tonumber(L, lo, 0);
    }
    
    return ok;
}

bool luaval_to_std_string(lua_State* L, int lo, std::string* outValue, const char* funcName)
{
    if (NULL == L || NULL == outValue)
        return false;
    
    bool ok = true;

    tolua_Error tolua_err;
    if (!tolua_iscppstring(L,lo,0,&tolua_err))
    {
        luaval_to_native_err(L,"#ferror:",&tolua_err,funcName);
        ok = false;
    }
    
    if (ok)
    {
        *outValue = tolua_tocppstring(L,lo,NULL);
    }
    
    return ok;
}

bool luaval_to_script_string(lua_State*L, int lo, CScriptString* outValue, const char* funcName)
{
	if (NULL == L)
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
		size_t len = 0;
		outValue->buffer = lua_tolstring(L, lo, &len);
		outValue->len = (sint32)len;
	}

	return ok;
}

bool luaval_to_std_vector_string(lua_State* L, int lo, std::vector<std::string>* ret, const char* funcName)
{
    if (nullptr == L || nullptr == ret || lua_gettop(L) < lo)
        return false;
    
    tolua_Error tolua_err;
    bool ok = true;
    if (!tolua_istable(L, lo, 0, &tolua_err))
    {
        luaval_to_native_err(L,"#ferror:",&tolua_err,funcName);
        ok = false;
    }
    
    if (ok)
    {
#if LUA_VERSION_NUM > 501
			size_t len = lua_rawlen(L, lo);
#else
			size_t len = lua_objlen(L, lo);
#endif
        std::string value = "";
        for (size_t i = 0; i < len; i++)
        {
            lua_pushnumber(L, i + 1);
            lua_gettable(L,lo);
            if(lua_isstring(L, -1))
            {
                ok = luaval_to_std_string(L, -1, &value);
                if(ok)
                    ret->push_back(value);
            }
            else
            {
                gxAssertEx(false, "string type is needed");
            }
            
            lua_pop(L, 1);
        }
    }
    
    return ok;
}

bool luaval_to_std_vector_int(lua_State* L, int lo, std::vector<sint32>* ret, const char* funcName)
{
    if (nullptr == L || nullptr == ret || lua_gettop(L) < lo)
        return false;
    
    tolua_Error tolua_err;
    bool ok = true;
    if (!tolua_istable(L, lo, 0, &tolua_err))
    {
        luaval_to_native_err(L,"#ferror:",&tolua_err,funcName);
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
            lua_gettable(L,lo);
            if(lua_isnumber(L, -1))
            {
                ret->push_back((sint32)tolua_tonumber(L, -1, 0));
            }
            else
            {
				gxAssertEx(false, "int type is needed");
            }
            
            lua_pop(L, 1);
        }
    }
    
    return ok;
}

bool luaval_to_std_vector_float(lua_State* L, int lo, std::vector<float>* ret, const char* funcName)
{
    if (nullptr == L || nullptr == ret || lua_gettop(L) < lo)
        return false;
    
    tolua_Error tolua_err;
    bool ok = true;
    
    if (!tolua_istable(L, lo, 0, &tolua_err))
    {
        luaval_to_native_err(L,"#ferror:",&tolua_err,funcName);
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
            lua_gettable(L,lo);
            if(lua_isnumber(L, -1))
            {
                ret->push_back((float)tolua_tonumber(L, -1, 0));
            }
            else
            {
				gxAssertEx(false, "float type is needed");
            }
            
            lua_pop(L, 1);
        }
    }
    
    return ok;
}


bool luaval_to_std_vector_ushort(lua_State* L, int lo, std::vector<uint16>* ret, const char* funcName)
{
    if (nullptr == L || nullptr == ret || lua_gettop(L) < lo)
        return false;
    
    tolua_Error tolua_err;
    bool ok = true;
    
    if (!tolua_istable(L, lo, 0, &tolua_err))
    {
        luaval_to_native_err(L,"#ferror:",&tolua_err,funcName);
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
            lua_gettable(L,lo);
            if(lua_isnumber(L, -1))
            {
				ret->push_back((uint16)tolua_tonumber(L, -1, 0));
            }
            else
            {
				gxAssertEx(false, "unsigned short type is needed");
            }
            
            lua_pop(L, 1);
        }
    }
    
    return ok;
}

void vector_std_string_to_luaval(lua_State* L, const std::vector<std::string>& inValue)
{
    if (nullptr == L)
        return;
    
    lua_newtable(L);
    
    int index = 1;
    
    for (const std::string value : inValue)
    {
        lua_pushnumber(L, (lua_Number)index);
        lua_pushstring(L, value.c_str());
        lua_rawset(L, -3);
        ++index;
    }
}

void vector_int_to_luaval(lua_State* L, const std::vector<sint32>& inValue)
{
    if (nullptr == L)
        return;
    
    lua_newtable(L);
    
    int index = 1;
    for (const int value : inValue)
    {
        lua_pushnumber(L, (lua_Number)index);
        lua_pushnumber(L, (lua_Number)value);
        lua_rawset(L, -3);
        ++index;
    }
}

void vector_float_to_luaval(lua_State* L, const std::vector<float>& inValue)
{
    if (nullptr == L)
        return;
    
    lua_newtable(L);
    
    int index = 1;
    for (const float value : inValue)
    {
        lua_pushnumber(L, (lua_Number)index);
        lua_pushnumber(L, (lua_Number)value);
        lua_rawset(L, -3);
        ++index;
    }
}

void vector_ushort_to_luaval(lua_State* L, const std::vector<uint16>& inValue)
{
    if (nullptr == L)
        return;
    
    lua_newtable(L);
    
    int index = 1;
    for (const unsigned short value : inValue)
    {
        lua_pushnumber(L, (lua_Number)index);
        lua_pushnumber(L, (lua_Number)value);
        lua_rawset(L, -3);
        ++index;
    }
}

void script_string_to_luaval(lua_State* L, const CScriptString& inValue)
{
	lua_pushlstring(L, inValue.buffer, inValue.len);
}
#ifndef OS_WIN
void object_to_luaval(lua_State* L, const char* type, lua_tinker::s_object* ret)
{
	lua_tinker::push(L, *ret);
}
#endif
void object_to_luaval(lua_State* L, const char* type, lua_tinker::s_object ret)
{
	lua_tinker::push(L, ret);
}
