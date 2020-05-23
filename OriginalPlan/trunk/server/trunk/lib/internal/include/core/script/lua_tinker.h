// lua_tinker.h
//
// LuaTinker - Simple and light C++ wrapper for Lua.
//
// Copyright (c) 2005-2007 Kwon-il Lee (zupet@hitel.net)
// 
// please check Licence.txt file for licence and legal issues. 

#if !defined(_LUA_TINKER_H_)
#define _LUA_TINKER_H_

#include <new>
#include <string.h>
#include <string>
#include <cassert>

extern "C"
{
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
};

#include "lua_base_conversions.h"

namespace lua_tinker
{
	// init LuaTinker
	void	init(lua_State *L);

	static void	init_s64(lua_State *L);
	static void	init_u64(lua_State *L);

	// string-buffer excution
	void	dofile(lua_State *L, const char *filename);
	void	dostring(lua_State *L, const char* buff);
	void	dobuffer(lua_State *L, const char* buff, size_t sz);

	// debug helpers
	void	enum_stack(lua_State *L);
	int		on_error(lua_State *L);
	void	print_error(lua_State *L, const char* fmt, ...);

	// type trait
	template<typename T> struct class_name;
	struct table;
	struct s_object;

	template<bool C, typename A, typename B> struct if_ {};
	template<typename A, typename B>		struct if_<true, A, B> { typedef A type; };
	template<typename A, typename B>		struct if_<false, A, B> { typedef B type; };

	template<typename A>
	struct is_ptr { static const bool value = false; };
	template<typename A>
	struct is_ptr<A*> { static const bool value = true; };

	template<typename A>
	struct is_ref { static const bool value = false; };
	template<typename A>
	struct is_ref<A&> { static const bool value = true; };

	template<typename A>
	struct remove_const { typedef A type; };
	template<typename A>
	struct remove_const<const A> { typedef A type; };

	template<typename A>
	struct base_type { typedef A type; };
	template<typename A>
	struct base_type<A*> { typedef A type; };
	template<typename A>
	struct base_type<A&> { typedef A type; };

	template<typename A>
	struct class_type { typedef typename remove_const<typename base_type<A>::type>::type type; };

	template<typename A>
	struct remove_cr{ typedef typename remove_const<typename std::remove_reference<A>::type>::type type; };
	template<typename A>
	struct remove_crp{ typedef typename base_type<typename remove_const<typename std::remove_reference<A>::type>::type>::type type; };

	template<typename A>
	struct is_obj { static const bool value = true; };
	template<> struct is_obj<char>					{ static const bool value = false; };
	template<> struct is_obj<unsigned char>			{ static const bool value = false; };
	template<> struct is_obj<short>					{ static const bool value = false; };
	template<> struct is_obj<unsigned short>		{ static const bool value = false; };
	template<> struct is_obj<long>					{ static const bool value = false; };
	template<> struct is_obj<unsigned long>			{ static const bool value = false; };
	template<> struct is_obj<int>					{ static const bool value = false; };
	template<> struct is_obj<unsigned int>			{ static const bool value = false; };
	template<> struct is_obj<float>					{ static const bool value = false; };
	template<> struct is_obj<double>				{ static const bool value = false; };
	template<> struct is_obj<char*>					{ static const bool value = false; };
	template<> struct is_obj<const char*>			{ static const bool value = false; };
	template<> struct is_obj<bool>					{ static const bool value = false; };
	template<> struct is_obj<long long>				{ static const bool value = false; };
	template<> struct is_obj<unsigned long long>	{ static const bool value = false; };
	template<> struct is_obj<table>					{ static const bool value = false; };
	template<> struct is_obj<s_object>				{ static const bool value = false; };

	/////////////////////////////////
	enum { no = 1, yes = 2 };
	typedef char(&no_type)[no];
	typedef char(&yes_type)[yes];

	struct int_conv_type { int_conv_type(int); };

	no_type int_conv_tester(...);
	yes_type int_conv_tester(int_conv_type);

	no_type vfnd_ptr_tester(const volatile char *);
	no_type vfnd_ptr_tester(const volatile short *);
	no_type vfnd_ptr_tester(const volatile int *);
	no_type vfnd_ptr_tester(const volatile long *);
	no_type vfnd_ptr_tester(const volatile double *);
	no_type vfnd_ptr_tester(const volatile float *);
	no_type vfnd_ptr_tester(const volatile bool *);
	yes_type vfnd_ptr_tester(const volatile void *);

	template <typename T> T* add_ptr(T&);

	template <bool C> struct bool_to_yesno { typedef no_type type; };
	template <> struct bool_to_yesno<true> { typedef yes_type type; };

	template <typename T>
	struct is_enum
	{
		static T arg;
		static const bool value = ((sizeof(int_conv_tester(arg)) == sizeof(yes_type)) && (sizeof(vfnd_ptr_tester(add_ptr(arg))) == sizeof(yes_type)));
	};
	/////////////////////////////////
	template<typename T, bool val = false>
	struct lua2enum {
		static T invoke(lua_State *L, int index)
		{
			return (T)(int)lua_tonumber(L, index);
		}
	};

	template<typename T, bool val = false>
	struct lua2object
	{
		static T invoke(lua_State *L, int index)
		{
			if (!(lua_isuserdata(L, index) || lua_istable(L, index) || lua_isnil(L, index)))
			{
				lua_pushstring(L, "no class at first argument. (forgot ':' expression ?)");
				lua_error(L);
			}
			T obj = NULL;
			const char* typen = getLuaTypeName(obj, "");
			if (NULL != typen)
			{
				return luaval_to_object(L, index, typen, &obj) == true ? obj : NULL;
			}

			return obj;
		}
	};

	template<typename T>
	T lua2type(lua_State *L, int index)
	{
		return	if_<is_enum<T>::value
			, lua2enum<T>
			, lua2object<T>
		>::type::invoke(L, index);
	}

	// to lua
	template<typename T>
	struct enum2lua { static void invoke(lua_State *L, T val) { lua_pushnumber(L, (int)val); } };

	template<typename T>
	struct object2lua
	{
		static void invoke(lua_State *L, T val)
		{
			const char* typen = getLuaTypeName(val, "");
			if (NULL != typen)
			{
				object_to_luaval(L, typen, val);
			}
			else
			{
				lua_pushnil(L);
			}
		}
	};

	template<typename T>
	void type2lua(lua_State *L, T val)
	{
		if_<is_enum<T>::value
			, enum2lua<T>
			, object2lua<typename remove_cr<T>::type>
		>::type::invoke(L, val);
	}

	// read a value from lua stack 
	template<typename T>
	T read(lua_State *L, int index)
	{
		return lua2type<T>(L, index);
	}

	template<>	char*				read(lua_State *L, int index);
	template<>	const char*			read(lua_State *L, int index);
	template<>	char				read(lua_State *L, int index);
	template<>	unsigned char		read(lua_State *L, int index);
	template<>	short				read(lua_State *L, int index);
	template<>	unsigned short		read(lua_State *L, int index);
	template<>	long				read(lua_State *L, int index);
	template<>	unsigned long		read(lua_State *L, int index);
	template<>	int					read(lua_State *L, int index);
	template<>	unsigned int		read(lua_State *L, int index);
	template<>	float				read(lua_State *L, int index);
	template<>	double				read(lua_State *L, int index);
	template<>	bool				read(lua_State *L, int index);
	template<>	void				read(lua_State *L, int index);
	template<>	sint64				read(lua_State *L, int index);
	template<>	uint64				read(lua_State *L, int index);
	template<>	table				read(lua_State *L, int index);
	template<>	s_object				read(lua_State *L, int index);
	template<>  std::string			read(lua_State *L, int index);

	// push a value to lua stack 
	template<typename T>
	void push(lua_State *L, T* ret)
	{
		type2lua<T*>(L, ret);
	}
// 	template<typename T>
// 	void push(lua_State *L, const T& ret)
// 	{
// 		type2lua<T>(L, ret);
// 	}
	void push(lua_State *L, char ret);
	void push(lua_State *L, unsigned char ret);
	void push(lua_State *L, short ret);
	void push(lua_State *L, unsigned short ret);
	void push(lua_State *L, long ret);
	void push(lua_State *L, unsigned long ret);
	void push(lua_State *L, int ret);
	void push(lua_State *L, unsigned int ret);
	void push(lua_State *L, float ret);
	void push(lua_State *L, double ret);
	void push(lua_State *L, char* ret);
	void push(lua_State *L, const char* ret);
	void push(lua_State *L, bool ret);
	void push(lua_State *L, sint64 ret);
	void push(lua_State *L, uint64 ret);
	void push(lua_State *L, table ret);
	void push(lua_State *L, s_object ret);
	void push(lua_State *L, const std::string& ret);

	// pop a value from lua stack
	template<typename T>
	T pop(lua_State *L) { T t = read<T>(L, -1); lua_pop(L, 1); return t; }

	template<>	void	pop(lua_State *L);
	template<>	table	pop(lua_State *L);
	template<>	s_object	pop(lua_State *L);

	// global variable
	template<typename T>
	void set(lua_State* L, const char* name, T obj)
	{
		push(L, obj);
		lua_setglobal(L, name);
	}

	template<typename T>
	T get(lua_State* L, const char* name)
	{
		lua_getglobal(L, name);
		return pop<T>(L);
	}

	template<typename T>
	void decl(lua_State* L, const char* name, T object)
	{
		set(L, name, object);
	}

	class top_check
	{
	public:
		top_check(lua_State* L, int retnum = 0);
		~top_check();

	private:
		lua_State* _ls;
		int _top;
		int _retnum;
	};

#pragma region script_call
	// call=======================================================================
	template<typename RVal>
	RVal call(lua_State* L, const char* name)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		if (name != NULL)
		{
			lua_getglobal(L, name);
		}
		else
		{
			lua_pushnil(L);
		}

		lua_pcall(L, 0, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1>
	RVal call(lua_State* L, const char* name, T1 arg)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		if (name != NULL)
		{
			lua_getglobal(L, name);
		}
		else
		{
			lua_pushnil(L);
		}

		push(L, arg);
		lua_pcall(L, 1, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2>
	RVal call(lua_State* L, const char* name, T1 arg1, T2 arg2)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);
		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		if (name != NULL)
		{
			lua_getglobal(L, name);
		}
		else
		{
			lua_pushnil(L);
		}

		push(L, arg1);
		push(L, arg2);
		lua_pcall(L, 2, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2, typename T3>
	RVal call(lua_State* L, const char* name, T1 arg1, T2 arg2, T3 arg3)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		if (name != NULL)
		{
			lua_getglobal(L, name);
		}
		else
		{
			lua_pushnil(L);
		}

		push(L, arg1);
		push(L, arg2);
		push(L, arg3);
		lua_pcall(L, 3, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2, typename T3, typename T4>
	RVal call(lua_State* L, const char* name, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		if (name != NULL)
		{
			lua_getglobal(L, name);
		}
		else
		{
			lua_pushnil(L);
		}

		push(L, arg1);
		push(L, arg2);
		push(L, arg3);
		push(L, arg4);
		lua_pcall(L, 4, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2, typename T3, typename T4, typename T5>
	RVal call(lua_State* L, const char* name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		if (name != NULL)
		{
			lua_getglobal(L, name);
		}
		else
		{
			lua_pushnil(L);
		}

		push(L, arg1);
		push(L, arg2);
		push(L, arg3);
		push(L, arg4);
		push(L, arg5);
		lua_pcall(L, 5, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2, typename T3, typename T4, typename T5, typename T6>
	RVal call(lua_State* L, const char* name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		if (name != NULL)
		{
			lua_getglobal(L, name);
		}
		else
		{
			lua_pushnil(L);
		}

		push(L, arg1);
		push(L, arg2);
		push(L, arg3);
		push(L, arg4);
		push(L, arg5);
		push(L, arg6);
		lua_pcall(L, 6, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2, typename T3, typename T4, typename T5, typename T6, typename T7>
	RVal call(lua_State* L, const char* name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		if (name != NULL)
		{
			lua_getglobal(L, name);
		}
		else
		{
			lua_pushnil(L);
		}

		push(L, arg1);
		push(L, arg2);
		push(L, arg3);
		push(L, arg4);
		push(L, arg5);
		push(L, arg6);
		push(L, arg7);
		lua_pcall(L, 7, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

#pragma endregion script_call

	// Table Object on Stack
	struct table_obj
	{
		table_obj(lua_State* L, int index);
		~table_obj();

		void inc_ref();
		void dec_ref();

		bool validate();

		template<typename T>
		void set(const char* name, T object)
		{
			if (validate())
			{
				lua_pushstring(m_L, name);
				push(m_L, object);
				lua_settable(m_L, m_index);
			}
		}

		template<typename T>
		T get(const char* name)
		{
			if (validate())
			{
				lua_pushstring(m_L, name);
				lua_gettable(m_L, m_index);
			}
			else
			{
				lua_pushnil(m_L);
			}

			return pop<T>(m_L);
		}

		lua_State*		m_L;
		int				m_index;
		const void*		m_pointer;
		int				m_ref;
	};

	// Table Object Holder
	struct table
	{
		table();
		table(lua_State* L);
		table(lua_State* L, int index);
		table(lua_State* L, const char* name);
		table(const table& input);
		~table();

		template<typename T>
		void set(const char* name, T object)
		{
			m_obj->set(name, object);
		}

		template<typename T>
		T get(const char* name)
		{
			return m_obj->get<T>(name);
		}

		int get_index();
		operator bool() const;
		void assign(s_object& object);

		table_obj*		m_obj;
	};

	struct from_stack
	{
		from_stack(lua_State* interpreter, int index)
		: interpreter(interpreter)
		, index(index)
		{}

		lua_State* interpreter;
		int index;
	};

	struct stack_pop
	{
		stack_pop(lua_State* L, int n)
		: m_state(L)
		, m_n(n)
		{
		}

		~stack_pop()
		{
			lua_pop(m_state, m_n);
		}

	private:

		lua_State* m_state;
		int m_n;
	};

	struct handle
	{
	public:
		handle();
		handle(lua_State* interpreter, int stack_index);
		handle(lua_State* main, lua_State* interpreter, int stack_index);
		handle(handle const& other);
		~handle();

		handle& operator=(handle const& other);
		void swap(handle& other);
		void push(lua_State* interpreter = NULL) const;

		bool is_table() const;
		bool is_valid() const;
		bool is_null() const;
		bool is_member(const char* name) const;
		int stack_index() const;
		lua_State* interpreter() const;

		void replace(lua_State* interpreter, int stack_index);

		template<typename T>
		T get(const char* name) const
		{
			stack_pop sp(m_interpreter, 1);
			if (is_valid())
			{
				push();
				lua_pushstring(m_interpreter, name);
				lua_gettable(m_interpreter, -2);
			}
			else
			{
				lua_pushnil(m_interpreter);
				lua_pushnil(m_interpreter);
			}

			return pop<T>(m_interpreter);
		}

		template<typename T>
		T get(const handle& key) const
		{
			stack_pop sp(m_interpreter, 1);
			if (is_valid())
			{
				push();
				key.push();
				lua_gettable(m_interpreter, -2);
			}
			else
			{
				lua_pushnil(m_interpreter);
				lua_pushnil(m_interpreter);
			}

			return pop<T>(m_interpreter);
		}

	private:
		lua_State* m_interpreter;
		int m_index;
	};

	struct s_object
	{
	public:
		static s_object Create(lua_State* interpreter, uint32 size)
		{
			lua_createtable(interpreter, (int)size, 0);
			return s_object(from_stack(interpreter, -1));
		}

	public:
		template<typename T>
		struct ObjectTo
		{
			static T To(s_object* pObject)
			{
				pObject->push();
				return pop<T>(pObject->interpreter());
			}
		};
	public:
		s_object()
		{}
		explicit s_object(handle const& other)
			: m_handle(other)
		{}
		explicit s_object(from_stack const& stack_reference)
			: m_handle(stack_reference.interpreter, stack_reference.index)
		{
		}

//		s_object& operator=(s_object const& other);

		template<class T>
		s_object(lua_State* interpreter, T const& value)
		{
			lua_tinker::push(interpreter, value);
			lua_tinker::stack_pop pop(interpreter, 1);
			handle(interpreter, -1).swap(m_handle);
		}

	public:
		void push(lua_State* interpreter = NULL) const;
		lua_State* interpreter() const;
		bool is_valid() const;
		bool is_table() const;
		bool is_null() const;
		void test_assert() const;
		int stack_index() const;
		operator bool() const;
		bool is_member(const char* name) const;
		void swap(s_object& other);

		s_object operator[](const char* name) const
		{
			return m_handle.get<s_object>(name);
		}
		template<class T>
		T get(const char* name) const
		{
			return m_handle.get<T>(name);
		}
		template<class T>
		void set(uint32 index, const T& val)
		{
			lua_tinker::push(m_handle.interpreter(), index);
			lua_tinker::push(m_handle.interpreter(), val);
			lua_rawset(m_handle.interpreter(), -3);
		}
		template<class T>
		void set(const char* name, const T& val)
		{
			lua_tinker::push(m_handle.interpreter(), name);
			lua_tinker::push(m_handle.interpreter(), val);
			lua_rawset(m_handle.interpreter(), -3);
		}
		s_object get(const char* name) const
		{
			return m_handle.get<s_object>(name);
		}
		template<typename T>
		T get(const handle& key) const
		{
			return m_handle.get<T>(key);
		}
		s_object get(const handle& key) const
		{
			return m_handle.get<s_object>(key);
		}
		template<typename T>
		operator T() const
		{
			push();
			return pop<T>(interpreter());
		}
		template<typename T>
		T to() const
		{
			return ObjectTo<T>::To((s_object*)this);
		}

	protected:
		handle m_handle;
	};
	template<>
	struct s_object::ObjectTo<std::string>
	{
		static std::string To(s_object* pObject)
		{
			pObject->push();
			return pop<std::string>(pObject->interpreter());
		}
	};
	typedef s_object TScriptObject;
//	typedef s_object object;

	struct iterator : s_object
	{
	public:
		iterator(){}

		explicit iterator(s_object const& tab)
		{
			s_object(tab).swap(*this);

			push();
			stack_pop sp(interpreter(), 1);

			lua_pushnil(interpreter());
			if (lua_next(interpreter(), -2) != 0)
			{
				stack_pop sp(interpreter(), 2);
				handle(interpreter(), -2).swap(m_key);
			}
			else
			{
				handle().swap(m_handle);
				handle().swap(m_key);
				return;
			}
		}

		s_object key() const
		{
			return s_object(m_key);
		}

	public:
		bool operator != (iterator const& other) const
		{
			return !equal(other);
		}
		iterator& operator++()
		{
			increment();
			return *this;
		}

		s_object operator*() const
		{
			return this->get(m_key);
		}

	private:
		void increment()
		{
			m_handle.push();
			m_key.push();

			stack_pop sp(interpreter(), 1);

			if (lua_next(interpreter(), -2) != 0)
			{
				stack_pop sp(interpreter(), 2);

				m_key.replace(interpreter(), -2);
			}
			else
			{
				handle().swap(m_handle);
				handle().swap(m_key);
			}
		}

		bool equal(iterator const& other) const
		{
			if (interpreter() == 0 && other.interpreter() == 0)
				return true;

			if (interpreter() != other.interpreter())
				return false;

			stack_pop sp(interpreter(), 2);
			m_key.push();
			other.m_key.push();
			//return lua_compare(interpreter(), -2, -1, LUA_OPEQ) != 0;
			return lua_equal(interpreter(), -2, -1) != 0;
		}

		handle m_key;
	};

#pragma region script_callt
	// call=======================================================================
#define GET_TABLE_MEM(index) \
	lua_rawgeti(L, LUA_REGISTRYINDEX, index); \
	lua_pushstring(L, name); \
	lua_gettable(L, -2); \
	lua_remove(L, -2);	\
	lua_rawgeti(L, LUA_REGISTRYINDEX, index);

	template<typename RVal>
	RVal callt(lua_State* L, s_object& obj, const char* name)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		GET_TABLE_MEM(obj.stack_index());
		lua_pcall(L, 1, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1>
	RVal callt(lua_State* L, s_object& obj, const char* name, T1 arg)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);
		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		GET_TABLE_MEM(obj.stack_index());
		push(L, arg);
		lua_pcall(L, 2, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2>
	RVal callt(lua_State* L, s_object& obj, const char* name, T1 arg1, T2 arg2)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		GET_TABLE_MEM(obj.stack_index());
		push(L, arg1);
		push(L, arg2);
		lua_pcall(L, 3, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2, typename T3>
	RVal callt(lua_State* L, s_object& obj, const char* name, T1 arg1, T2 arg2, T3 arg3)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		GET_TABLE_MEM(obj.stack_index());
		push(L, arg1);
		push(L, arg2);
		push(L, arg3);
		lua_pcall(L, 4, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2, typename T3, typename T4>
	RVal callt(lua_State* L, s_object& obj, const char* name, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		GET_TABLE_MEM(obj.stack_index());
		push(L, arg1);
		push(L, arg2);
		push(L, arg3);
		push(L, arg4);
		lua_pcall(L, 5, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2, typename T3, typename T4, typename T5>
	RVal callt(lua_State* L, s_object& obj, const char* name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		GET_TABLE_MEM(obj.stack_index());
		push(L, arg1);
		push(L, arg2);
		push(L, arg3);
		push(L, arg4);
		push(L, arg5);
		lua_pcall(L, 6, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2, typename T3, typename T4, typename T5, typename T6>
	RVal callt(lua_State* L, s_object& obj, const char* name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		GET_TABLE_MEM(obj.stack_index());
		push(L, arg1);
		push(L, arg2);
		push(L, arg3);
		push(L, arg4);
		push(L, arg5);
		push(L, arg6);
		lua_pcall(L, 7, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

	template<typename RVal, typename T1, typename T2, typename T3, typename T4, typename T5, typename T6, typename T7>
	RVal callt(lua_State* L, s_object& obj, const char* name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		top_check tc(L, std::is_void<RVal>::value ? 0 : 1);

		lua_pushcclosure(L, on_error, 0);
		int errfunc = lua_gettop(L);

		GET_TABLE_MEM(obj.stack_index());
		push(L, arg1);
		push(L, arg2);
		push(L, arg3);
		push(L, arg4);
		push(L, arg5);
		push(L, arg6);
		push(L, arg7);
		lua_pcall(L, 8, std::is_void<RVal>::value ? 0 : 1, errfunc);

		lua_remove(L, errfunc);
		return pop<RVal>(L);
	}

#pragma endregion script_callt

} // namespace lua_tinker

#ifdef OS_WIN
template<>
static void object_to_luaval<lua_tinker::s_object>(lua_State* L, const char* type, lua_tinker::s_object* ret)
{
	lua_tinker::push(L, *ret);
}
#else
template<>
void object_to_luaval<lua_tinker::s_object>(lua_State* L, const char* type, lua_tinker::s_object* ret);
#endif

void object_to_luaval(lua_State* L, const char* type, lua_tinker::s_object ret);

#endif //_LUA_TINKER_H_
