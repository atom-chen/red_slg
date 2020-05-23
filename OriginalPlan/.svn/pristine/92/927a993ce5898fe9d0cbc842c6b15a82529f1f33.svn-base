// lua_tinker.cpp
//
// LuaTinker - Simple and light C++ wrapper for Lua.
//
// Copyright (c) 2005-2007 Kwon-il Lee (zupet@hitel.net)
// 
// please check Licence.txt file for licence and legal issues. 

#include <iostream>

#include "lua_tinker.h"
#include "debug.h"


/*---------------------------------------------------------------------------*/ 
/* init                                                                      */ 
/*---------------------------------------------------------------------------*/ 
void lua_tinker::init(lua_State *L)
{
	init_s64(L);
	init_u64(L);
}

/*---------------------------------------------------------------------------*/ 
/* __s64                                                                     */ 
/*---------------------------------------------------------------------------*/ 
static int tostring_s64(lua_State *L)
{
	char temp[64];
	sprintf_s(temp, "%I64d", *(long long*)lua_topointer(L, 1));
	lua_pushstring(L, temp);
	return 1;
}

/*---------------------------------------------------------------------------*/ 
static int eq_s64(lua_State *L)
{
	lua_pushboolean(L, memcmp(lua_topointer(L, 1), lua_topointer(L, 2), sizeof(long long)) == 0);
	return 1;
}

/*---------------------------------------------------------------------------*/ 
static int lt_s64(lua_State *L)
{
	lua_pushboolean(L, memcmp(lua_topointer(L, 1), lua_topointer(L, 2), sizeof(long long)) < 0);
	return 1;
}

/*---------------------------------------------------------------------------*/ 
static int le_s64(lua_State *L)
{
	lua_pushboolean(L, memcmp(lua_topointer(L, 1), lua_topointer(L, 2), sizeof(long long)) <= 0);
	return 1;
}

/*---------------------------------------------------------------------------*/ 
void lua_tinker::init_s64(lua_State *L)
{
	const char* name = "__s64";
	lua_newtable(L);

	lua_pushstring(L, "__name");
	lua_pushstring(L, name);
	lua_rawset(L, -3);

	lua_pushstring(L, "__tostring");
	lua_pushcclosure(L, tostring_s64, 0);
	lua_rawset(L, -3);

	lua_pushstring(L, "__eq");
	lua_pushcclosure(L, eq_s64, 0);
	lua_rawset(L, -3);	

	lua_pushstring(L, "__lt");
	lua_pushcclosure(L, lt_s64, 0);
	lua_rawset(L, -3);	

	lua_pushstring(L, "__le");
	lua_pushcclosure(L, le_s64, 0);
	lua_rawset(L, -3);	

	lua_setglobal(L, name);
}

/*---------------------------------------------------------------------------*/ 
/* __u64                                                                     */ 
/*---------------------------------------------------------------------------*/ 
static int tostring_u64(lua_State *L)
{
	char temp[64];
	sprintf_s(temp, "%I64u", *(unsigned long long*)lua_topointer(L, 1));
	lua_pushstring(L, temp);
	return 1;
}

/*---------------------------------------------------------------------------*/ 
static int eq_u64(lua_State *L)
{
	lua_pushboolean(L, memcmp(lua_topointer(L, 1), lua_topointer(L, 2), sizeof(unsigned long long)) == 0);
	return 1;
}

/*---------------------------------------------------------------------------*/ 
static int lt_u64(lua_State *L)
{
	lua_pushboolean(L, memcmp(lua_topointer(L, 1), lua_topointer(L, 2), sizeof(unsigned long long)) < 0);
	return 1;
}

/*---------------------------------------------------------------------------*/ 
static int le_u64(lua_State *L)
{
	lua_pushboolean(L, memcmp(lua_topointer(L, 1), lua_topointer(L, 2), sizeof(unsigned long long)) <= 0);
	return 1;
}

/*---------------------------------------------------------------------------*/ 
void lua_tinker::init_u64(lua_State *L)
{
	const char* name = "__u64";
	//lua_pushstring(L, name);
	lua_newtable(L);

	lua_pushstring(L, "__name");
	lua_pushstring(L, name);
	lua_rawset(L, -3);

	lua_pushstring(L, "__tostring");
	lua_pushcclosure(L, tostring_u64, 0);
	lua_rawset(L, -3);

	lua_pushstring(L, "__eq");
	lua_pushcclosure(L, eq_u64, 0);
	lua_rawset(L, -3);	

	lua_pushstring(L, "__lt");
	lua_pushcclosure(L, lt_u64, 0);
	lua_rawset(L, -3);	

	lua_pushstring(L, "__le");
	lua_pushcclosure(L, le_u64, 0);
	lua_rawset(L, -3);	

	//lua_settable(L, LUA_GLOBALSINDEX);
	lua_setglobal(L, name);
}

/*---------------------------------------------------------------------------*/ 
/* excution                                                                  */ 
/*---------------------------------------------------------------------------*/ 
void lua_tinker::dofile(lua_State *L, const char *filename)
{
	lua_pushcclosure(L, on_error, 0);
	int errfunc = lua_gettop(L);

    if(luaL_loadfile(L, filename) == 0)
	{
		lua_pcall(L, 0, 1, errfunc);
	}
	else
	{
		print_error(L, "%s", lua_tostring(L, -1));
	}

	lua_remove(L, errfunc);
	lua_pop(L, 1);
}

/*---------------------------------------------------------------------------*/ 
void lua_tinker::dostring(lua_State *L, const char* buff)
{
	lua_tinker::dobuffer(L, buff, strlen(buff));
}

/*---------------------------------------------------------------------------*/ 
void lua_tinker::dobuffer(lua_State *L, const char* buff, size_t len)
{
	lua_pushcclosure(L, on_error, 0);
	int errfunc = lua_gettop(L);

    if(luaL_loadbuffer(L, buff, len, "lua_tinker::dobuffer()") == 0)
	{
		lua_pcall(L, 0, 1, errfunc);
	}
	else
	{
		print_error(L, "%s", lua_tostring(L, -1));
	}

	lua_remove(L, errfunc);
	lua_pop(L, 1);
}

/*---------------------------------------------------------------------------*/ 
/* debug helpers                                                             */ 
/*---------------------------------------------------------------------------*/ 
static void call_stack(lua_State* L, int n)
{
    lua_Debug ar;
    if(lua_getstack(L, n, &ar) == 1)
	{
		lua_getinfo(L, "nSlu", &ar);

		const char* indent;
		if(n == 0)
		{
			indent = "->\t";
			lua_tinker::print_error(L, "\t<call stack>");
		}
		else
		{
			indent = "\t";
		}

		if(ar.name)
			lua_tinker::print_error(L, "%s%s() : line %d [%s : line %d]", indent, ar.name, ar.currentline, ar.source, ar.linedefined);
		else
			lua_tinker::print_error(L, "%sunknown : line %d [%s : line %d]", indent, ar.currentline, ar.source, ar.linedefined);

		call_stack(L, n+1);
	}
}

/*---------------------------------------------------------------------------*/ 
int lua_tinker::on_error(lua_State *L)
{
	print_error(L, "%s", lua_tostring(L, -1));
	call_stack(L, 0);

	gxAssert(false);
	return 0;
}

/*---------------------------------------------------------------------------*/ 
void lua_tinker::print_error(lua_State *L, const char* fmt, ...)
{
	char text[4096];

	va_list args;
	va_start(args, fmt);
	vsprintf_s(text, fmt, args);
	va_end(args);

	lua_getglobal(L, "_ALERT");
	if(lua_isfunction(L, -1))
	{
		lua_pushstring(L, text);
		lua_call(L, 1, 0);
	}
	else
	{
		//printf("%s\n", text);
		gxError("{0}\n", text);
		lua_pop(L, 1);
	}
}

/*---------------------------------------------------------------------------*/ 
void lua_tinker::enum_stack(lua_State *L)
{
	int top = lua_gettop(L);
	print_error(L, "Type:%d", top);
	for(int i=1; i<=lua_gettop(L); ++i)
	{
		switch(lua_type(L, i))
		{
		case LUA_TNIL:
			print_error(L, "\t%s", lua_typename(L, lua_type(L, i)));
			break;
		case LUA_TBOOLEAN:
			print_error(L, "\t%s	%s", lua_typename(L, lua_type(L, i)), lua_toboolean(L, i)?"true":"false");
			break;
		case LUA_TLIGHTUSERDATA:
			print_error(L, "\t%s	0x%08p", lua_typename(L, lua_type(L, i)), lua_topointer(L, i));
			break;
		case LUA_TNUMBER:
			print_error(L, "\t%s	%f", lua_typename(L, lua_type(L, i)), lua_tonumber(L, i));
			break;
		case LUA_TSTRING:
			print_error(L, "\t%s	%s", lua_typename(L, lua_type(L, i)), lua_tostring(L, i));
			break;
		case LUA_TTABLE:
			print_error(L, "\t%s	0x%08p", lua_typename(L, lua_type(L, i)), lua_topointer(L, i));
			break;
		case LUA_TFUNCTION:
			print_error(L, "\t%s()	0x%08p", lua_typename(L, lua_type(L, i)), lua_topointer(L, i));
			break;
		case LUA_TUSERDATA:
			print_error(L, "\t%s	0x%08p", lua_typename(L, lua_type(L, i)), lua_topointer(L, i));
			break;
		case LUA_TTHREAD:
			print_error(L, "\t%s", lua_typename(L, lua_type(L, i)));
			break;
		}
	}
}
 
/*---------------------------------------------------------------------------*/ 
/* read                                                                      */ 
/*---------------------------------------------------------------------------*/ 
template<>
char* lua_tinker::read(lua_State *L, int index)
{
	return (char*)lua_tostring(L, index);				
}

template<>
const char* lua_tinker::read(lua_State *L, int index)
{
	return (const char*)lua_tostring(L, index);		
}

template<>
char lua_tinker::read(lua_State *L, int index)
{
	return (char)lua_tonumber(L, index);				
}

template<>
unsigned char lua_tinker::read(lua_State *L, int index)
{
	return (unsigned char)lua_tonumber(L, index);		
}

template<>
short lua_tinker::read(lua_State *L, int index)
{
	return (short)lua_tonumber(L, index);				
}

template<>
unsigned short lua_tinker::read(lua_State *L, int index)
{
	return (unsigned short)lua_tonumber(L, index);	
}

template<>
long lua_tinker::read(lua_State *L, int index)
{
	return (long)lua_tonumber(L, index);				
}

template<>
unsigned long lua_tinker::read(lua_State *L, int index)
{
	return (unsigned long)lua_tonumber(L, index);		
}

template<>
int lua_tinker::read(lua_State *L, int index)
{
	return (int)lua_tonumber(L, index);				
}

template<>
unsigned int lua_tinker::read(lua_State *L, int index)
{
	return (unsigned int)lua_tonumber(L, index);		
}

template<>
float lua_tinker::read(lua_State *L, int index)
{
	return (float)lua_tonumber(L, index);				
}

template<>
double lua_tinker::read(lua_State *L, int index)
{
	return (double)lua_tonumber(L, index);			
}

template<>
bool lua_tinker::read(lua_State *L, int index)
{
	if(lua_isboolean(L, index))
		return lua_toboolean(L, index) != 0;				
	else
		return lua_tonumber(L, index) != 0;
}

template<>
void lua_tinker::read(lua_State *L, int index)
{
	L;
	index;
	return;											
}

template<>
sint64 lua_tinker::read(lua_State *L, int index)
{
	if (lua_isnumber(L, index)){
		return (long long)lua_tonumber(L, index);
	}
	else{
		return *(long long*)lua_touserdata(L, index);
	}
}

template<>
uint64 lua_tinker::read(lua_State *L, int index)
{
	if (lua_isnumber(L, index)){
		return (unsigned long long)lua_tonumber(L, index);
	}
	else{
		return *(unsigned long long*)lua_touserdata(L, index);
	}
}

template<>
lua_tinker::table lua_tinker::read(lua_State *L, int index)
{
	return table(L, index);
}

template<>	lua_tinker::s_object lua_tinker::read(lua_State *L, int index)
{
	return s_object(handle(L, index));
}

template<>
std::string lua_tinker::read(lua_State *L, int index)
{
	if (lua_isstring(L, index))
	{
		return (char*)lua_tostring(L, index);
	}

	return "";
}

/*---------------------------------------------------------------------------*/ 
/* push                                                                      */ 
/*---------------------------------------------------------------------------*/ 
void lua_tinker::push(lua_State *L, char ret)
{
	lua_pushnumber(L, ret);						
}

void lua_tinker::push(lua_State *L, unsigned char ret)
{
	lua_pushnumber(L, ret);						
}

void lua_tinker::push(lua_State *L, short ret)
{
	lua_pushnumber(L, ret);						
}

void lua_tinker::push(lua_State *L, unsigned short ret)
{
	lua_pushnumber(L, ret);						
}

void lua_tinker::push(lua_State *L, long ret)
{
	lua_pushnumber(L, ret);						
}

void lua_tinker::push(lua_State *L, unsigned long ret)
{
	lua_pushnumber(L, ret);						
}

void lua_tinker::push(lua_State *L, int ret)
{
	lua_pushnumber(L, ret);						
}

void lua_tinker::push(lua_State *L, unsigned int ret)
{
	lua_pushnumber(L, ret);						
}

void lua_tinker::push(lua_State *L, float ret)
{
	lua_pushnumber(L, ret);						
}

void lua_tinker::push(lua_State *L, double ret)
{
	lua_pushnumber(L, ret);						
}

void lua_tinker::push(lua_State *L, char* ret)
{
	lua_pushstring(L, ret);						
}

void lua_tinker::push(lua_State *L, const char* ret)
{
	lua_pushstring(L, ret);						
}

void lua_tinker::push(lua_State *L, bool ret)
{
	lua_pushboolean(L, ret);						
}

void lua_tinker::push(lua_State *L, sint64 ret)			
{ 
	*(long long*)lua_newuserdata(L, sizeof(sint64)) = ret;
	lua_getglobal(L, "__s64");
	lua_setmetatable(L, -2);
}

void lua_tinker::push(lua_State *L, uint64 ret)
{
	*(unsigned long long*)lua_newuserdata(L, sizeof(sint64)) = ret;
	lua_getglobal(L, "__u64");
	lua_setmetatable(L, -2);
}

void lua_tinker::push(lua_State *L, lua_tinker::table ret)
{
	lua_pushvalue(L, ret.m_obj->m_index);
}

void lua_tinker::push(lua_State *L, lua_tinker::s_object ret)
{
	ret.push(L);
}

void lua_tinker::push(lua_State *L, const std::string& ret)
{
	lua_pushstring(L, ret.c_str());
}

/*---------------------------------------------------------------------------*/ 
/* pop                                                                       */ 
/*---------------------------------------------------------------------------*/ 
template<>
void lua_tinker::pop(lua_State *L)
{
}

template<>	
lua_tinker::table lua_tinker::pop(lua_State *L)
{
	return table(L, lua_gettop(L));
}

template<>	lua_tinker::s_object lua_tinker::pop(lua_State *L)
{
	stack_pop sp(L, 1);
	return s_object(from_stack(L, lua_gettop(L)));
}

/*---------------------------------------------------------------------------*/ 
/* Tinker Class Helper                                                       */ 
/*---------------------------------------------------------------------------*/ 
static void invoke_parent(lua_State *L)
{
	lua_pushstring(L, "__parent");
	lua_rawget(L, -2);
	if(lua_istable(L,-1))
	{
		lua_pushvalue(L,2);
		lua_rawget(L, -2);
		if(!lua_isnil(L,-1))
		{
			lua_remove(L,-2);
		}
		else
		{
			lua_remove(L, -1);
			invoke_parent(L);
			lua_remove(L,-2);
		}
	}
}

/*---------------------------------------------------------------------------*/ 
/* table s_object on stack                                                     */ 
/*---------------------------------------------------------------------------*/ 
lua_tinker::table_obj::table_obj(lua_State* L, int index)
	:m_L(L)
	,m_index(index)
	,m_ref(0)
{
	if(lua_isnil(m_L, m_index))
	{
		m_pointer = NULL;
		lua_remove(m_L, m_index);
	}
	else
	{
		m_pointer = lua_topointer(m_L, m_index);
	}
}

lua_tinker::table_obj::~table_obj()
{
	if(validate())
	{
		lua_remove(m_L, m_index);
	}
}

void lua_tinker::table_obj::inc_ref()
{
	++m_ref;
}

void lua_tinker::table_obj::dec_ref()
{
	if(--m_ref == 0)
		delete this;
}

bool lua_tinker::table_obj::validate()
{
	if(m_pointer != NULL)
	{
		if(m_pointer == lua_topointer(m_L, m_index))
		{
			return true;
		}
		else
		{
			int top = lua_gettop(m_L);

			for(int i=1; i<=top; ++i)
			{
				if(m_pointer == lua_topointer(m_L, i))
				{
					m_index = i;
					return true;
				}
			}

			m_pointer = NULL;
			return false;
		}
	}
	else
	{
        return false;
	}
}

/*---------------------------------------------------------------------------*/ 
/* Table Object Holder                                                       */ 
/*---------------------------------------------------------------------------*/ 
lua_tinker::table::table()
{
	m_obj = NULL;
}

lua_tinker::table::table(lua_State* L)
{
	lua_newtable(L);

	m_obj = new table_obj(L, lua_gettop(L));
	m_obj->inc_ref();
}

lua_tinker::table::table(lua_State* L, const char* name)
{
	lua_getglobal(L, name);

	if(lua_istable(L, -1) == 0)
	{
		lua_pop(L, 1);
		lua_newtable(L);
		lua_setglobal(L, name);
	}

	m_obj = new table_obj(L, lua_gettop(L));
	m_obj->inc_ref();
	stack_pop(L, 1);
}

lua_tinker::table::table(lua_State* L, int index)
{
	if(index < 0)
	{
		index = lua_gettop(L) + index + 1;
	}

	m_obj = new table_obj(L, index);
	m_obj->inc_ref();
}

lua_tinker::table::table(const table& input)
{
	m_obj = input.m_obj;
	if (m_obj)
	{
		m_obj->inc_ref();
	}
}

lua_tinker::table::~table()
{
	if (m_obj)
	{
		m_obj->dec_ref();
	}
}

int lua_tinker::table::get_index()
{
	if (m_obj != NULL)
	{
		return m_obj->m_index;
	}

	return 0;
}

lua_tinker::table::operator bool() const
{
	return m_obj != NULL;
}

void lua_tinker::table::assign(s_object& object)
{
	int index = object.stack_index();
	if (index < 0)
	{
		index = lua_gettop(object.interpreter()) + index + 1;
	}

	m_obj = new table_obj(object.interpreter(), index);
	m_obj->inc_ref();
}

lua_tinker::handle::handle()
: m_interpreter(0)
, m_index(LUA_NOREF)
{}

lua_tinker::handle::handle(lua_tinker::handle const& other)
: m_interpreter(other.m_interpreter)
, m_index(LUA_NOREF)
{
	if (m_interpreter == 0) return;
	lua_rawgeti(m_interpreter, LUA_REGISTRYINDEX, other.m_index);
	m_index = luaL_ref(m_interpreter, LUA_REGISTRYINDEX);
}

lua_tinker::handle::handle(lua_State* interpreter, int stack_index)
: m_interpreter(interpreter)
, m_index(LUA_NOREF)
{
	lua_pushvalue(interpreter, stack_index);
	m_index = luaL_ref(interpreter, LUA_REGISTRYINDEX);
}

lua_tinker::handle::handle(lua_State* main, lua_State* interpreter, int stack_index)
: m_interpreter(main)
, m_index(LUA_NOREF)
{
	lua_pushvalue(interpreter, stack_index);
	m_index = luaL_ref(interpreter, LUA_REGISTRYINDEX);
}

lua_tinker::handle::~handle()
{
	if (m_interpreter && m_index != LUA_NOREF){
		luaL_unref(m_interpreter, LUA_REGISTRYINDEX, m_index);
	}
}

lua_tinker::handle& lua_tinker::handle::operator=(lua_tinker::handle const& other)
{
	if (this == &other)
	{
		return *this;
	}

	handle(other).swap(*this);
	return *this;
}

void lua_tinker::handle::swap(lua_tinker::handle& other)
{
	std::swap(m_interpreter, other.m_interpreter);
	std::swap(m_index, other.m_index);
}

void lua_tinker::handle::push(lua_State* interpreter) const
{
	if (interpreter == NULL)
	{
		interpreter = m_interpreter;
	}
	lua_rawgeti(interpreter, LUA_REGISTRYINDEX, m_index);
}

bool lua_tinker::handle::is_table() const
{
	push();

	stack_pop sp(m_interpreter, 1);
	
	return lua_istable(m_interpreter, lua_gettop(m_interpreter));
}

bool lua_tinker::handle::is_valid() const
{
	return m_interpreter != NULL;
}

bool lua_tinker::handle::is_null() const
{
	push();

	stack_pop sp(m_interpreter, 1);

	return lua_isnil(m_interpreter, lua_gettop(m_interpreter));
}

bool lua_tinker::handle::is_member(const char* name) const
{
	push();
	lua_pushstring(m_interpreter, name);
	lua_gettable(m_interpreter, -2);

	stack_pop sp(m_interpreter, 2);
	
	return lua_isfunction(m_interpreter, lua_gettop(m_interpreter));
}

lua_State* lua_tinker::handle::interpreter() const
{
	return m_interpreter;
}

void lua_tinker::handle::replace(lua_State* interpreter, int stack_index)
{
	lua_pushvalue(interpreter, stack_index);
	lua_rawseti(interpreter, LUA_REGISTRYINDEX, m_index);
}

int lua_tinker::handle::stack_index() const
{
	return m_index;
}

lua_tinker::s_object::operator bool() const
{
	return is_valid();
}
void lua_tinker::s_object::push(lua_State* interpreter) const
{
	m_handle.push(interpreter);
}
lua_State* lua_tinker::s_object::interpreter() const
{
	return m_handle.interpreter();
}

bool lua_tinker::s_object::is_valid() const
{
	return m_handle.interpreter() != 0 && m_handle.stack_index() != -1;
}

bool lua_tinker::s_object::is_table() const
{
	return m_handle.is_table();
}

bool lua_tinker::s_object::is_null() const
{
	return m_handle.is_null();
}

void lua_tinker::s_object::test_assert() const
{
	stack_pop sp(interpreter(), 1);
	m_handle.push();
	assert(lua_istable(m_handle.interpreter(), lua_gettop(m_handle.interpreter())));
}

int lua_tinker::s_object::stack_index() const
{
	return m_handle.stack_index();
}

// lua_tinker::s_object& lua_tinker::s_object::operator=(lua_tinker::s_object const& other)
// {
// 	if (this == &other)
// 	{
// 		return *this;
// 	}
// 
// 	m_handle = other.m_handle;
// 	return *this;
// }

bool lua_tinker::s_object::is_member(const char* name) const
{
	if (!is_valid())
	{
		return false;
	}

	if (!m_handle.is_table())
	{
		return false;
	}

	return m_handle.is_member(name);
}

void lua_tinker::s_object::swap(s_object& other)
{
	m_handle.swap(other.m_handle);
}

lua_tinker::top_check::top_check(lua_State* L, int retnum)
{
	_ls = L;
	_top = lua_gettop(L);
	_retnum = retnum;
}

lua_tinker::top_check::~top_check()
{
	int top = lua_gettop(_ls);
	if((_top) != top)
	{
		//printf("lua stack is no cleanup!!!\n");
		assert(false);
	}
}



/*---------------------------------------------------------------------------*/ 
