#ifndef _GAME_EXCEPTION_H_
#define _GAME_EXCEPTION_H_

#include <exception>

#include "debug.h"

namespace GXMISC{
#define DRET_NULL (void(0))													// 空返回

inline void _FuncBeginVoid(const char*){}

// 异常
#ifdef OS_WINDOWS
LONG CrashHandler(ULONG code, EXCEPTION_POINTERS *pException);
#define THREAD_TRY      {__try{ ;
#define THREAD_CATCH    }__except(CrashHandler(GetExceptionCode(), GetExceptionInformation())){gxAssert(false);}} ;
#elif defined(OS_UNIX)
#define THREAD_TRY      {try{ ;
#define THREAD_CATCH    }catch(...){gxAssertEx(false,__PRETTY_FUNCTION__);}} ;
#endif

#ifdef LIB_DEBUG
// 游戏异常捕获
#define FUNC_BEGIN(module)  const static char* FuncModuleName=module; try{ ;
#define FUNC_END(ret) ; }catch (std::exception* e){gxError("Exception:{0}", e->what());}  catch(...){gxAssert(false);} return ret;
#else
#define FUNC_BEGIN(module)  const static char* FuncModuleName=module; // try{ ;
#define FUNC_END(ret) //return ret; ; }catch (std::exception* e){gxError("Exception:{0}", e->what());}  catch(...){gxAssertEx(false);} return ret; // 不需要返回值, 这只是在异常的情况下才发生的
#endif

#define DB_BEGIN(module) const static char* FuncModuleName=module;  try{ ;
#define DB_END()  	\
    }   \
    catch (const mysqlpp::BadQuery& er)	\
    {	\
        gxError("Query error: {0}", er.what());	\
    }	\
    catch (const mysqlpp::BadConversion& er)	\
    {	\
        gxError("Conversion error: {0}, \tretrieved data size: {1}, actual size: {2}", er.what(), er.retrieved, er.actual_size);	\
    }	\
    catch (const mysqlpp::Exception& er) \
    {	\
        gxError("Error: {0}", er.what());	\
    }	\
    catch(...) \
    { \
		gxError("Unkown exception!"); \
        gxAssert(false); \
    }

#define DB_END_RET(ret)  	\
	}   \
	catch (const mysqlpp::BadQuery& er)	\
{	\
	gxError("Query error: {0}", er.what());	\
}	\
	catch (const mysqlpp::BadConversion& er)	\
{	\
	gxError("Conversion error: {0}, \tretrieved data size: {1}, actual size: {2}", er.what(), er.retrieved, er.actual_size);	\
}	\
	catch (const mysqlpp::Exception& er) \
    {	\
    gxError("Error: {0}", er.what());	\
    }	\
    catch(...) \
    { \
    gxAssert(false); \
    }   \
    return ret;

#define DB_END_RET_STR(ret, sqlStr)  	\
	}   \
	catch (const mysqlpp::BadQuery& er)	\
	{	\
	gxError("Query error: {0},sql={1}", er.what(), sqlStr);	\
	}	\
	catch (const mysqlpp::BadConversion& er)	\
	{	\
	gxError("Conversion error: {0}, \tretrieved data size: {1}, actual size: {2}, sql={3}", er.what(), er.retrieved, er.actual_size, sqlStr);	\
	}	\
	catch (const mysqlpp::Exception& er) \
	{	\
	gxError("Error: {0}, sql={1}", er.what(), sqlStr);	\
	}	\
	catch(...) \
	{ \
	gxAssert(false); \
	}   \
	return ret;


// 示例:
// 函数无返回 @{
// FUNC_BEGIN(LOGIN)
// FUNC_END(DRET_NULL)
// }
// 函数有返回 @{
// FUNC_BEGIN(LOGIN)
// FUNC_END(true)
// }
}

#endif