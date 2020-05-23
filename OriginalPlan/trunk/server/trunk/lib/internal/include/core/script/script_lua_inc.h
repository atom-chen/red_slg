#ifndef _SCRIPT_LUA_INC_H_
#define _SCRIPT_LUA_INC_H_


extern "C"
{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
}

#include "debug.h"
#include "script_base.h"
#include "script/lua_tinker.h"

namespace lua_tinker
{
#define VectorL2O(T) \
	template<>	\
	struct lua2object<std::vector<T>>	\
	{	\
	static std::vector<T> invoke(lua_State *L, int index)	\
	{	\
	s_object tab(from_stack(L, index));	\
	std::vector<T> ary;	\
	\
	if (!tab.is_null())	\
	{	\
	for (lua_tinker::iterator iter(tab), end; iter != end; ++iter)	\
	{	\
	ary.push_back((*iter).to<T>());	\
}	\
}	\
	\
	return ary;	\
}	\
};
#define VectorO2L(T) \
	template<>	\
	struct object2lua<std::vector<T>>	\
	{	\
	static void invoke(lua_State *L, const std::vector<T>& val)	\
	{	\
	s_object obj = s_object::Create(L, val.size());	\
	uint32 index = 1;	\
	for (std::vector<T>::const_iterator iter = val.begin(); iter != val.end(); ++iter, index++)	\
	{	\
	obj.set(index, *iter);	\
}	\
	\
}	\
};	\
	inline void push(lua_State *L, const std::vector<T>& val)	\
	{	\
		type2lua(L, val);	\
	}

	VectorL2O(sint8);
	VectorL2O(uint8);
	VectorL2O(sint16);
	VectorL2O(uint16);
	VectorL2O(sint32);
	VectorL2O(uint32);
	VectorL2O(std::string);

	VectorO2L(sint8);
	VectorO2L(uint8);
	VectorO2L(sint16);
	VectorO2L(uint16);
	VectorO2L(sint32);
	VectorO2L(uint32);
	VectorO2L(std::string);

#define MapIntL2O(T) \
	template<>	\
	struct lua2object<std::map<sint32, T>>	\
	{	\
	typedef std::map<sint32, T> _ObjectType;	\
	\
	static _ObjectType invoke(lua_State *L, int index)	\
	{	\
	s_object tab(from_stack(L, index));	\
	_ObjectType ary;	\
	\
	if (!tab.is_null())	\
	{	\
	for (lua_tinker::iterator iter(tab), end; iter != end; ++iter)	\
	{	\
	ary[sint32(iter.key())] = (*iter).to<T>();	\
	}	\
	}	\
	\
	return ary;	\
	}	\
	};


#define MapStringO2L(T) \
	template<>	\
	struct object2lua<std::map<sint32, T>>	\
	{	\
	static void invoke(lua_State *L, const std::map<sint32, T>& val)	\
	{	\
	s_object obj = s_object::Create(L, val.size());	\
	for (std::map<sint32, T>::const_iterator iter = val.begin(); iter != val.end(); ++iter)	\
	{	\
	obj.set(iter->first, iter->second);	\
	}	\
	\
	}	\
	};	\
	inline void push(lua_State *L, const std::map<sint32, T>& val)	\
	{	\
	type2lua(L, val);	\
	}

	MapIntL2O(sint8);
	MapIntL2O(uint8);
	MapIntL2O(sint16);
	MapIntL2O(uint16);
	MapIntL2O(sint32);
	MapIntL2O(uint32);
	MapIntL2O(std::string);

	MapStringO2L(sint8);
	MapStringO2L(uint8);
	MapStringO2L(sint16);
	MapStringO2L(uint16);
	MapStringO2L(sint32);
	MapStringO2L(uint32);
	MapStringO2L(std::string);

#define MapStringL2O(T) \
	template<>	\
	struct lua2object<std::map<std::string, T>>	\
	{	\
	typedef std::map<std::string, T> _ObjectType;	\
	\
	static _ObjectType invoke(lua_State *L, int index)	\
	{	\
	s_object tab(from_stack(L, index));	\
	_ObjectType ary;	\
	\
	if (!tab.is_null())	\
	{	\
	for (lua_tinker::iterator iter(tab), end; iter != end; ++iter)	\
	{	\
	ary[iter.key().to<std::string>()] = (*iter).to<T>();	\
			}	\
			}	\
			\
			return ary;	\
			}	\
			};

#define MapStringO2L(T) \
	template<>	\
	struct object2lua<std::map<std::string, T>>	\
	{	\
	static void invoke(lua_State *L, const std::map<std::string, T>& val)	\
	{	\
	s_object obj = s_object::Create(L, val.size());	\
	for (std::map<std::string, T>::const_iterator iter = val.begin(); iter != val.end(); ++iter)	\
	{	\
	obj.set(iter->first.c_str(), iter->second);	\
	}	\
	\
	}	\
	};	\
	inline void push(lua_State *L, const std::map<std::string, T>& val)	\
	{	\
	type2lua(L, val);	\
	}

	MapStringL2O(sint8);
	MapStringL2O(uint8);
	MapStringL2O(sint16);
	MapStringL2O(uint16);
	MapStringL2O(sint32);
	MapStringL2O(uint32);
	MapStringL2O(std::string);

	MapStringO2L(sint8);
	MapStringO2L(uint8);
	MapStringO2L(sint16);
	MapStringO2L(uint16);
	MapStringO2L(sint32);
	MapStringO2L(uint32);
	MapStringO2L(std::string);
}

namespace GXMISC{

	class CLuaVM : public CScriptBase<CLuaVM, lua_State>
	{
	public:
		typedef lua_State TScriptState;

	public:
		CLuaVM(bool bOpenStdLib = true);
		virtual ~CLuaVM();

	public:
		virtual bool init(lua_State* pState);
		virtual bool doScript();
		virtual bool loadFileToBuffer(lua_State *L, const char *filename, char* szbuffer, int &maxlen, bool& loadlocal);
		virtual bool loadFile(const char* fileName);
		virtual bool doFile(const char* filename);
		virtual bool doString(const char* buffer);
		virtual bool doBuffer(const char* buffer, size_t size);
		virtual bool initScript(const char* fileName);
		virtual bool uninitScript();

	public:
		template<typename T>
		T getGlobal(const char* name)
		{
			return lua_tinker::get<T>(getState(), name);
		}

		lua_tinker::s_object getGlobal(const char* name)
		{
			return lua_tinker::get<lua_tinker::s_object>(getState(), name);
		}

	protected:
		virtual bool bindToScript();

	private:
		void exportAPI();

	public:
		void openStdLib();
		bool isExistFunction(const char* name);

#include "script_lua_inc.inl"
	};
}
#endif