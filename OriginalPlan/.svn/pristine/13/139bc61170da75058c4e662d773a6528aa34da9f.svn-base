#ifndef _DEBUG_H_
#define _DEBUG_H_

#include <cstdio>
#include <set>
#include <string>

#include "common.h"
#include "mutex.h"
#include "displayer.h"
#include "string_common.h"
#include "logger.h"
#include "lib_init.h"
#include "types_def.h"
#include "log_format.h"

// 函数模块名字
const static char* FuncModuleName="UNKOWN_MOD;";			// @todo 以后去掉

namespace GXMISC
{
    /// 得到系统最后的错误码
    uint32 gxGetLastError();

    /// 返回错误码对应的错误信息
    std::string gxFormatErrorMessage(int errorCode);

    /// 将字节以位的形式显示出来
    void gxDisplayByteBits( uint8 b, uint32 nbits, sint32 beginpos, bool displayBegin, CLogger *log );

    /// 将双字以二进制形式表示出来
    void gxDisplayDwordBits( uint32 b, uint32 nbits, sint32 beginpos, bool displayBegin, CLogger *log );

    // 设置dump生成处理句柄
    void gxSetDumpHandler();
	// 获取生成Dump的名字
    std::string gxGetDumpName();
    // 获取调用堆栈
    void gxGetCallStack(std::string &result, sint32 skipNFirst);
    // 退出游戏
    void gxExit(EExitCode code);

#ifdef USE_FAST_FORMAT
#define DFormatLogVargs(_dest,_fmt,_size, ...) \
	std::string _dest;	\
	GXMISC::LogFormat(_dest, _fmt, ##__VA_ARGS__);
#else
#define	DFormatLogVargs(_dest, _fmt, _size, ...) \
	std::string _dest; \
	_dest.assign(_size+1, '\0'); \
	GXMISC::ConvertVargs((char*)_dest.c_str(), _fmt, _size-1, ##__VA_ARGS__);
#endif

#if defined (OS_WINDOWS) && defined (LIB_DEBUG)
#define GXMISC_BREAKPOINT __debugbreak();
#elif defined (OS_UNIX) && defined (LIB_DEBUG)
#define GXMISC_BREAKPOINT GXMISC::gxExit(EXIT_CORE_BREAKPOINT);
#else
#define GXMISC_BREAKPOINT
#endif

	extern void gxLog(bool isOnce, CLogger* lg, CLogger::ELogType logType, sint32 line, const char *file, const char *funcName, const char* module, const char *msg);

#ifdef LIB_RELEASE
#	define gxLogAssert(exp, lg, module, file, line, func)// if(exp){};
#	define gxLogAssertEx(exp, lg, module, file, line, func, fmt, ...)// if(exp){};
#	define gxLogAssertOnce(exp, lg, module, file, line, func)// if(exp){};
#	define gxLogAssertExOnce(exp, lg, moduel, file, line, func, fmt, ...)// if(exp){};
#   define gxStop
#else // LIB_RELEASE

#define gxLogAssert(exp, lg, module, file, line, func) \
    do { \
    bool _expResult = !(exp) ? true : false; \
    if(_expResult)  \
    {   \
    GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_ASSERT, line, file, func, module, #exp);   \
    GXMISC_BREAKPOINT;    \
    }   \
    } while(0)

#define gxLogAssertOnce(exp, lg, module, file, line, func) \
    do { \
    bool _expResult = !(exp) ? true : false; \
    if(_expResult)  \
    {   \
    GXMISC::gxLog(true, lg, GXMISC::CLogger::LOG_ASSERT, __LINE__, __FILE__, __FUNCTION__, module, #exp);   \
    GXMISC_BREAKPOINT;    \
    }   \
    } while(0);

    void gxLogAssertEx(bool exp, CLogger* lg, const char* module, const char* file, uint32 line, const char* func, const char* str, ...);
    void gxLogAssertExOnce(bool exp, CLogger* lg, const char* module, const char* file, uint32 line, const char* func, const char* str, ...) ;

	void _gxLogAssertEx(bool exp, CLogger* lg, const char* module, const char* file, uint32 line, const char* func, const char* str, ...);
    void _gxLogAssertExOnce(bool exp, CLogger* lg, const char* module, const char* file, uint32 line, const char* func, const char* str, ...) ;

#define gxStop \
    do { \
    GXMISC_BREAKPOINT;   \
    } while(0);
#endif // LIB_RELEASE


    // 编译断言
#define gxCompileAssert(cond) sizeof(uint32[(cond) ? 1 : 0])

    // @todo 添加 _toBase()
#define CHECK_LOG_TYPES(__a,__b) \
    inline __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt) { __b(lg, file, line, func, module, fmt); } \
    template<class A> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a) { _check(a); __b(lg, file, line, func, module, fmt, a); } \
    template<class A, class B> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b) { _check(a); _check(b); __b(lg, file, line, func, module, fmt, a, b); } \
    template<class A, class B, class C> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c) { _check(a); _check(b); _check(c); __b(lg, file, line, func, module, fmt, a, b, c); } \
    template<class A, class B, class C, class D> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d) { _check(a); _check(b); _check(c); _check(d); __b(lg, file, line, func, module, fmt, a, b, c, d); } \
    template<class A, class B, class C, class D, class E> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e) { _check(a); _check(b); _check(c); _check(d); _check(e); __b(lg, file, line, func, module, fmt, a, b, c, d, e); } \
    template<class A, class B, class C, class D, class E, class F> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f); } \
    template<class A, class B, class C, class D, class E, class F, class G> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U, class V> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u, V v) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); _check(v); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U, class V, class W> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u, V v, W w) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); _check(v); _check(w); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U, class V, class W, class X> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u, V v, W w, X x) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); _check(v); _check(w); _check(x); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U, class V, class W, class X, class Y> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u, V v, W w, X x, Y y) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); _check(v); _check(w); _check(x); _check(y); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U, class V, class W, class X, class Y, class Z> __a(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u, V v, W w, X x, Y y, Z z) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); _check(v); _check(w); _check(x); _check(y); _check(z); __b(lg, file, line, func, module, fmt, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z); }

#ifdef LIB_RELEASE
#	define gxLogDebug(lg, file, line, func, module, fmt, ...)
#   define gxLogDbgWarning(lg, file, line, func, module, fmt, ...)
#else   // LIB_RELEASE
    void _gxLogDebug(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ...);
    // 在调试模式下显警告日志, 但是在运行时不显示任何日志
    void _gxLogDbgWarning(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char*  fmt, ...);
    CHECK_LOG_TYPES(void gxLogDebug, return _gxLogDebug);
    CHECK_LOG_TYPES(void gxLogDbgWarning, return _gxLogDbgWarning);
#endif  // LIB_RELEASE
    void _gxLogInfo(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char*  fmt, ...);
    void _gxLogWarning(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char*  fmt, ...);
    // @todo 加上堆栈
    void _gxLogError(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char*  fmt, ...);
    void _gxLogErrorEx(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char*  fmt, ...);
    void _gxLogStat(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ...);
	void _gxLogGm(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ...);
    CHECK_LOG_TYPES(void gxLogInfo, return _gxLogInfo);
    CHECK_LOG_TYPES(void gxLogWarning, return _gxLogWarning);
    CHECK_LOG_TYPES(void gxLogError, return _gxLogError);
    CHECK_LOG_TYPES(void gxLogErrorEx, return _gxLogErrorEx);
    CHECK_LOG_TYPES(void gxLogStat, return _gxLogStat);
	CHECK_LOG_TYPES(void gxLogGm, return _gxLogGm);

	// 调试日志
#ifdef LIB_DEBUG
	#define gxDebug(_fmt, ...)       {DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
		gxLog(false, DMainLog, GXMISC::CLogger::LOG_DEBUG, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());}
		// 在调试模式下显警告日志, 但是在运行时不显示任何日志
	#define gxDbgWarning(_fmt, ...)  {DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
		gxLog(false, DMainLog, GXMISC::CLogger::LOG_WARNING, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());}
#else
	#define gxDebug(_fmt, ...)
	#define gxDbgWarning(_fmt, ...)
#endif

    // 显示正常日志信息
#define gxInfo(_fmt, ...)        {DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLog(false, DMainLog, GXMISC::CLogger::LOG_INFO, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());}
    // 显示警告日志
#define gxWarning(_fmt, ...)     {DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLog(false, DMainLog, GXMISC::CLogger::LOG_WARNING, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());}
    // 显示错误日志, 但不退出程序
#define gxError(_fmt, ...)       {DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLog(false, DMainLog, GXMISC::CLogger::LOG_ERROR, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());}
    // 显示错误日志, 且退出
#define gxErrorEx(_fmt, ...)     {DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLog(false, DMainLog, GXMISC::CLogger::LOG_ERROR, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());	\
	gxAssert(false);}
    // 统计日志
#define gxStatistic(_fmt, ...)   {DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLog(false, DMainLog, GXMISC::CLogger::LOG_STAT, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());}
	// 条件日志
#define gxCondLog(val, cond, _fmt, ...) {if(val == cond){ DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLog(false, DMainLog, GXMISC::CLogger::LOG_INFO, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());}}
	// 条件日志
#define gxCondLogB(cond, _fmt, ...) {if(true == cond){ DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLog(false, DMainLog, GXMISC::CLogger::LOG_INFO, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());}}
	// GM日志
#define gxGm(_fmt, ...) {DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLog(false, DMainLog, GXMISC::CLogger::LOG_GM, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());}
	// 测试
#define gxTestLog(_fmt, ...)	{DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLog(false, DMainLog, GXMISC::CLogger::LOG_DEBUG, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, _dest.c_str());}

    // 断言
#define gxAssert(var)                   gxLogAssert((var), (DMainLog), FuncModuleName, __FILE__, __LINE__, __FUNCTION__);
#define gxAssertOnce(var)               gxLogAssert((var), (DMainLog), FuncModuleName, __FILE__, __LINE__, __FUNCTION__);
#define gxAssertEx(var, _fmt, ...)       {DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLogAssertEx((var), (DMainLog), FuncModuleName, __FILE__, __LINE__, __FUNCTION__, _dest.c_str());}
#define gxAssertExOnce(var, _fmt, ...)   {DFormatLogVargs(_dest, _fmt, GXMISC::MAX_CSTRING_SIZE, ##__VA_ARGS__);	\
	gxLogAssertExOnce((var), (DMainLog), FuncModuleName, __FILE__, __LINE__, __FUNCTION__, _dest.c_str());}
	
} // GXMISC

#endif
