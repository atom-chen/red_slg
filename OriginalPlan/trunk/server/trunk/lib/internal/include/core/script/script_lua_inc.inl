
template<typename R>
R callFunc(const char* funcname, R defVal)
{
	if(isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}

template<typename R, typename P1>
R callFunc(const char* funcname, R defVal, P1 p1)
{
	if (isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname, p1);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}

template<typename R, typename P1, typename P2>
R callFunc(const char* funcname, R defVal, P1 p1, P2 p2)
{
	if(isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname, p1, p2);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}

template<typename R, typename P1, typename P2, typename P3>
R callFunc(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3)
{
	if(isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname, p1, p2, p3);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}

template<typename R, typename P1, typename P2, typename P3, typename P4>
R callFunc(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4)
{
	if(isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname, p1, p2, p3, p4);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}

template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5>
R callFunc(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5)
{
	if(isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname, p1, p2, p3, p4, p5);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}

template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5, typename P6>
R callFunc(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6)
{
	if(isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname, p1, p2, p3, p4, p5, p6);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}

template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7>
R callFunc(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7)
{
	if(isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname, p1, p2, p3, p4, p5, p6, p7);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}

template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8>
R callFunc(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8)
{
	if(isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname, p1, p2, p3, p4, p5, p6, p7, p8);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}

template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9>
R callFunc(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9)
{
	if(isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname, p1, p2, p3, p4, p5, p6, p7, p8, p9);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}
template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9, typename P10>
R callFunc(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9, P10 p10)
{
	if(isExistFunction(funcname))
	{
		//LUABIND_TRY_ERRORMSG(errmsg, _scriptState);
		return lua_tinker::call<R>(_scriptState, funcname, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10);
		//LUABIND_CATCH_ERRORMSG(errmsg, _scriptState, funcname);
	}

	return defVal;
}

bool bCallFunc(const char* funcname)
{
	return callFunc(funcname, false);
}

template<typename P1>
bool bCallFunc(const char* funcname, P1 p1)
{
	return callFunc(funcname, false, p1);
}
template< typename P1, typename P2>
bool bCallFunc(const char* funcname, P1 p1, P2 p2)
{
	return callFunc(funcname, false, p1, p2);
}
template< typename P1, typename P2, typename P3>
bool bCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3)
{
	return callFunc(funcname, false, p1, p2, p3);
}
template< typename P1, typename P2, typename P3, typename P4>
bool bCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4)
{
	return callFunc(funcname, false, p1, p2, p3, p4);
}
template< typename P1, typename P2, typename P3, typename P4, typename P5>
bool bCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5)
{
	return callFunc(funcname, false, p1, p2, p3, p4, p5);
}
template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6>
bool bCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6)
{
	return callFunc(funcname, false, p1, p2, p3, p4, p5, p6);
}
template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7>
bool bCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7)
{
	return callFunc(funcname, false, p1, p2, p3, p4, p5, p6, p7);
}

template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8>
bool bCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8)
{
	return callFunc(funcname, false, p1, p2, p3, p4, p5, p6, p7, p8);
}

template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9>
bool bCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9)
{
	return callFunc(funcname, false, p1, p2, p3, p4, p5, p6, p7, p8, p9);
}

template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9, typename P10>
bool bCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9, P10 p10)
{
	return callFunc(funcname, false, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10);
}

//=========================================================
void vCallFunc(const char* funcname)
{
	return lua_tinker::call<void>(_scriptState, funcname);
}

template<typename P1>
void vCallFunc(const char* funcname, P1 p1)
{
	return lua_tinker::call<void>(_scriptState, funcname, p1);
}
template< typename P1, typename P2>
void vCallFunc(const char* funcname, P1 p1, P2 p2)
{
	return lua_tinker::call<void>(_scriptState, funcname, p1, p2);
}
template< typename P1, typename P2, typename P3>
void vCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3)
{
	return lua_tinker::call<void>(_scriptState, funcname, p1, p2, p3);
}
template< typename P1, typename P2, typename P3, typename P4>
void vCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4)
{
	return lua_tinker::call<void>(_scriptState, funcname, p1, p2, p3, p4);
}
template< typename P1, typename P2, typename P3, typename P4, typename P5>
void vCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5)
{
	return lua_tinker::call<void>(_scriptState, funcname, p1, p2, p3, p4, p5);
}
template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6>
void vCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6)
{
	return lua_tinker::call<void>(_scriptState, funcname, p1, p2, p3, p4, p5, p6);
}
template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7>
void vCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7)
{
	return lua_tinker::call<void>(_scriptState, funcname, p1, p2, p3, p4, p5, p6, p7);
}

template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8>
void vCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8)
{
	return lua_tinker::call<void>(_scriptState, funcname, p1, p2, p3, p4, p5, p6, p7, p8);
}

template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9>
void vCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9)
{
	return lua_tinker::call<void>(_scriptState, funcname, p1, p2, p3, p4, p5, p6, p7, p8, p9);
}

template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9, typename P10>
void vCallFunc(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9, P10 p10)
{
	return lua_tinker::call<void>(_scriptState, funcname, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10);
}