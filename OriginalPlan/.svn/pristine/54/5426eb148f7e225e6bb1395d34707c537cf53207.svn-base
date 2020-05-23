#ifndef _SCRIPT_OBJECT_BASE_H_
#define _SCRIPT_OBJECT_BASE_H_

#include "script/script_lua_inc.h"

namespace GXMISC
{
	class IScriptObject : public IFreeable
	{
	protected:
		IScriptObject()
		{
			_scriptEngine = NULL;
		}
	public:
		~IScriptObject()
		{
			_scriptEngine = NULL;
		}

	public:
		template<typename T>
 		bool initScript(CLuaVM* scriptEngine, T p)
 		{
 			_scriptEngine = scriptEngine;
			if (!_scriptHandleClassName.empty())
			{
				_scriptHandler = _scriptEngine->call<lua_tinker::s_object>(_scriptHandleClassName.c_str(), lua_tinker::s_object(), p);
			}

			return _scriptHandler;
 		}
		std::string getScriptHandleClassName() const
		{
			return _scriptHandleClassName;
		}
		void setScriptHandleClassName(std::string newObjectFuncName)
		{
			_scriptHandleClassName = newObjectFuncName;
		}
		lua_tinker::s_object getScriptObject()
		{
			return _scriptHandler;
		}
	public:
		bool isExistMember(const char* functionName) const
		{
			return _scriptHandler.is_member(functionName);
		}
		// 重云
		template<typename R>
		inline R call(const char* functionName, const R& defVal)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<R>(_scriptEngine->getState(), _scriptHandler, functionName);
			}

			return defVal;
		}
		template<typename R, typename T>
		inline R call(const char* functionName, const R& defVal, T p1)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<R>(_scriptEngine->getState(), _scriptHandler, functionName, p1);
			}

			return defVal;
		}
		template<typename R, typename T, typename T2>
		inline R call(const char* functionName, const R& defVal, T p1, T2 p2)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<R>(_scriptEngine->getState(), _scriptHandler, functionName, p1, p2);
			}

			return defVal;
		}
		template<typename R, typename T, typename T2, typename T3>
		inline R call(const char* functionName, const R& defVal, T p1, T2 p2, T3 p3)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<R>(_scriptEngine->getState(), _scriptHandler, functionName, p1, p2, p3);
			}

			return defVal;
		}
		template<typename R, typename T, typename T2, typename T3, typename T4>
		inline R call(const char* functionName, const R& defVal, T p1, T2 p2, T3 p3, T4 p4)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<R>(_scriptEngine->getState(), _scriptHandler, functionName, p1, p2, p3, p4);
			}

			return defVal;
		}
		template<typename R, typename T, typename T2, typename T3, typename T4, typename T5>
		inline R call(const char* functionName, const R& defVal, T p1, T2 p2, T3 p3, T4 p4, T5 p5)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<R>(_scriptEngine->getState(), _scriptHandler, functionName, p1, p2, p3, p4, p5);
			}

			return defVal;
		}

	public:
		// 重云
		inline void vCall(const char* functionName)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<void>(_scriptEngine->getState(), _scriptHandler, functionName);
			}
		}
		template<typename T>
		inline void vCall(const char* functionName, T p1)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<void>(_scriptEngine->getState(), _scriptHandler, functionName, p1);
			}
		}
		template<typename T, typename T2>
		inline void vCall(const char* functionName, T p1, T2 p2)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<void>(_scriptEngine->getState(), _scriptHandler, functionName, p1, p2);
			}
		}
		template<typename T, typename T2, typename T3>
		inline void vCall(const char* functionName, T p1, T2 p2, T3 p3)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<void>(_scriptEngine->getState(), _scriptHandler, functionName, p1, p2, p3);
			}
		}
		template<typename T, typename T2, typename T3, typename T4>
		inline void vCall(const char* functionName, T p1, T2 p2, T3 p3, T4 p4)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<void>(_scriptEngine->getState(), _scriptHandler, functionName, p1, p2, p3, p4);
			}
		}
		template<typename T, typename T2, typename T3, typename T4, typename T5>
		inline void vCall(const char* functionName, T p1, T2 p2, T3 p3, T4 p4, T5 p5)
		{
			if (_scriptHandler.is_member(functionName))
			{
				return lua_tinker::callt<void>(_scriptEngine->getState(), _scriptHandler, functionName, p1, p2, p3, p4, p5);
			}
		}
	public:
		// 重云
		inline bool bCall(const char* functionName)
		{
			return call<bool>(functionName, false);
		}
		template<typename T>
		inline bool bCall(const char* functionName, T p1)
		{
			return call<bool>(functionName, false, p1);
		}
		template<typename T, typename T2>
		inline bool bCall(const char* functionName, T p1, T2 p2)
		{
			return call<bool>(functionName, false, p1, p2);
		}
		template<typename T, typename T2, typename T3>
		inline bool bCall(const char* functionName, T p1, T2 p2, T3 p3)
		{
			return call<bool>(functionName, false, p1, p2, p3);
		}
		template<typename T, typename T2, typename T3, typename T4>
		inline bool bCall(const char* functionName, T p1, T2 p2, T3 p3, T4 p4)
		{
			return call<bool>(functionName, false, p1, p2, p3, p4);
		}
		template<typename T, typename T2, typename T3, typename T4, typename T5>
		inline bool bCall(const char* functionName, T p1, T2 p2, T3 p3, T4 p4, T5 p5)
		{
			return call<bool>(functionName, false, p1, p2, p3, p4, p5);
		}
	public:
		// 重云
		inline std::string sCall(const char* functionName)
		{
			return call<std::string>(functionName, "");
		}
		template<typename T>
		inline std::string sCall(const char* functionName, T p1)
		{
			return call<std::string>(functionName, "", p1);
		}
		template<typename T, typename T2>
		inline std::string sCall(const char* functionName, T p1, T2 p2)
		{
			return call<std::string>(functionName, "", p1, p2);
		}
		template<typename T, typename T2, typename T3>
		inline std::string sCall(const char* functionName, T p1, T2 p2, T3 p3)
		{
			return call<std::string>(functionName, "", p1, p2, p3);
		}
		template<typename T, typename T2, typename T3, typename T4>
		inline std::string sCall(const char* functionName, T p1, T2 p2, T3 p3, T4 p4)
		{
			return call<std::string>(functionName, "", p1, p2, p3, p4);
		}
		template<typename T, typename T2, typename T3, typename T4, typename T5>
		inline std::string sCall(const char* functionName, T p1, T2 p2, T3 p3, T4 p4, T5 p5)
		{
			return call<std::string>(functionName, "", p1, p2, p3, p4, p5);
		}

	protected:
		CLuaVM* _scriptEngine;
		lua_tinker::s_object _scriptHandler;
		std::string _scriptHandleClassName;
	};
}

#endif // _SCRIPT_OBJECT_BASE_H_