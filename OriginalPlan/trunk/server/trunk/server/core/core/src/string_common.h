#ifndef	_STRING_COMMON_H_
#define	_STRING_COMMON_H_


#include "types_def.h"
#include "fix_string.h"
#include "string_util.h"

namespace GXMISC
{
    template<typename T>
    struct TFS
    {
        static const char* FMT;
    };
    template<typename T>
    const char* GXMISC::TFS<T>::FMT = "%u";

    template<>
    struct TFS<uint8>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<sint8>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<uint16>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<sint16>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<uint32>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<sint32>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<uint64>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<sint64>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<bool>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<float>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<double>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<const char*>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<char*>
    {
        static const char* FMT;
    };
    template<>
    struct TFS<const char* const>
    {
        static const char* FMT;
    };

    // 将对象类类型转换成基本类型
	inline bool&			_toBase(bool& a) { return a; }   
	inline sint32&          _toBase(sint32& a ) {  return a;}
	inline uint32&			_toBase(uint32& a ) { return a; }
	inline char&            _toBase(char&  a ) { return a; }
	inline unsigned char&   _toBase(unsigned char&  a ) { return a; }
    inline sint8&           _toBase(sint8& a) { return a; }
    inline uint16&          _toBase(uint16& a) { return a; }
    inline sint16&          _toBase(sint16& a) { return a; }
    inline uint64&          _toBase(uint64& a) { return a; }
    inline sint64&          _toBase(sint64& a) { return a; }
    inline float&           _toBase(float& a) { return a; }
    inline double&          _toBase(double& a) { return a; }
    inline const char *&    _toBase(const char *& a) { return a; }
    inline const char*const& _toBase(const char*const& a) { return a;}
    inline const void *&    _toBase(const void *& a) { return a; }
    inline char*&           _toBase(char*& a) { return a; }
    inline void*&           _toBase(void*& a ) { return a; }
    inline const char*     _toBase(const std::string& a) { return a.c_str(); }
    template<typename T>
    inline const T*&        _toBase(const T*& a) { return a; }
    template<typename T>
    inline T* const&        _toBase(T* const& a){ return a; }
#define _DToBase(SrcType) \
    inline SrcType&         _toBase(SrcType& a ) {  return a;}
#define DToStringDef(SrcType)   \
    _DToBase(SrcType);	\
	inline std::string gxToString(const SrcType &val) { return GXMISC::gxToString("%u", (uint32)val); }

    // 用于传入参数的检查
    inline void _check(sint32 /* a */) { }
    inline void _check(uint32 /* a */) { }
    inline void _check(char /* a */) { }
    inline void _check(unsigned char /* a */) { }
    inline void _check(sint8 /* a */) { }
    inline void _check(uint16 /* a */) { }
    inline void _check(sint16 /* a */) { }
    inline void _check(uint64 /* a */) { }
    inline void _check(sint64 /* a */) { }
    inline void _check(float /* a */) { }
    inline void _check(double /* a */) { }
    inline void _check(const char * /* a */) { }
    inline void _check(const void * /* a */) { }
    inline void _check(char* /* a */) {}
    inline void _check(void* /* a */ ) {}
    template<typename T>
    inline void _check(const T* t) {}
    template<typename T>
    inline void _check(T* const t){}

#define CHECK_TYPES(__a,__b) \
    inline __a(const char *fmt) { __b(fmt); } \
    template<class A> __a(const char *fmt, A a) { _check(a); __b(fmt, _toBase(a)); } \
    template<class A, class B> __a(const char *fmt, A a, B b) { _check(a); _check(b); __b(fmt, _toBase(a), _toBase(b)); } \
    template<class A, class B, class C> __a(const char *fmt, A a, B b, C c) { _check(a); _check(b); _check(c); __b(fmt, _toBase(a), _toBase(b), _toBase(c)); } \
    template<class A, class B, class C, class D> __a(const char *fmt, A a, B b, C c, D d) { _check(a); _check(b); _check(c); _check(d); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d)); } \
    template<class A, class B, class C, class D, class E> __a(const char *fmt, A a, B b, C c, D d, E e) { _check(a); _check(b); _check(c); _check(d); _check(e); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e)); } \
    template<class A, class B, class C, class D, class E, class F> __a(const char *fmt, A a, B b, C c, D d, E e, F f) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f)); } \
    template<class A, class B, class C, class D, class E, class F, class G> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p), _toBase(q)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p), _toBase(q), _toBase(r)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p), _toBase(q), _toBase(r), _toBase(s)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p), _toBase(q), _toBase(r), _toBase(s), _toBase(t)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p), _toBase(q), _toBase(r), _toBase(s), _toBase(t), _toBase(u)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U, class V> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u, V v) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); _check(v); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p), _toBase(q), _toBase(r), _toBase(s), _toBase(t), _toBase(u), _toBase(v)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U, class V, class W> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u, V v, W w) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); _check(v); _check(w); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p), _toBase(q), _toBase(r), _toBase(s), _toBase(t), _toBase(u), _toBase(v), _toBase(w)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U, class V, class W, class X> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u, V v, W w, X x) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); _check(v); _check(w); _check(x); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p), _toBase(q), _toBase(r), _toBase(s), _toBase(t), _toBase(u), _toBase(v), _toBase(w), _toBase(x)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U, class V, class W, class X, class Y> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u, V v, W w, X x, Y y) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); _check(v); _check(w); _check(x); _check(y); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p), _toBase(q), _toBase(r), _toBase(s), _toBase(t), _toBase(u), _toBase(v), _toBase(w), _toBase(x), _toBase(y)); } \
    template<class A, class B, class C, class D, class E, class F, class G, class H, class I, class J, class K, class L, class M, class N, class O, class P, class Q, class R, class S, class T, class U, class V, class W, class X, class Y, class Z> __a(const char *fmt, A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t, U u, V v, W w, X x, Y y, Z z) { _check(a); _check(b); _check(c); _check(d); _check(e); _check(f); _check(g); _check(h); _check(i); _check(j); _check(k); _check(l); _check(m); _check(n); _check(o); _check(p); _check(q); _check(r); _check(s); _check(t); _check(u); _check(v); _check(w); _check(x); _check(y); _check(z); __b(fmt, _toBase(a), _toBase(b), _toBase(c), _toBase(d), _toBase(e), _toBase(f), _toBase(g), _toBase(h), _toBase(i), _toBase(j), _toBase(k), _toBase(l), _toBase(m), _toBase(n), _toBase(o), _toBase(p), _toBase(q), _toBase(r), _toBase(s), _toBase(t), _toBase(u), _toBase(v), _toBase(w), _toBase(x), _toBase(y), _toBase(z)); }

    inline std::string _toString(const char *format, ...)
    {
        do
        {
            DConvertVargs(Result, format, GXMISC::MAX_CSTRING_SIZE);
			return Result;

		} while (FALSE_COND);
        //return NULL;
    }

	CHECK_TYPES(std::string gxToString, return _toString);

    template<class T> std::string gxToString(const T &obj)
    {
        return obj.toString();
    }
    template<class T> std::string ToStringPtr(const T *val) { return gxToString("%p", val); }
    template<class T> std::string ToStringEnum(const T &val) { return gxToString("%u", (uint32)val); }
    inline std::string gxToString(const uint8 &val) { return gxToString("%hu", (uint16)val); }
    inline std::string gxToString(const sint8 &val) { return gxToString("%hd", (sint16)val); }
    inline std::string gxToString(const uint16 &val) { return gxToString("%hu", val); }
    inline std::string gxToString(const sint16 &val) { return gxToString("%hd", val); }
    inline std::string gxToString(const uint32 &val) { return gxToString("%u", val); }
    inline std::string gxToString(const sint32 &val) { return gxToString("%d", val); }
    inline std::string gxToString(const uint64 &val) { return gxToString("%" I64_FMT "u", val); }
    inline std::string gxToString(const sint64 &val) { return gxToString("%" I64_FMT "d", val); }
	inline std::string gxToString(char* const val) { return val; }


#if (SIZEOF_SIZE_T) == 8
//    inline std::string gxToString(const size_t &val) { return gxToString("%"I64_FMT"u", val); }
#endif

    inline std::string gxToString(const float &val) { return gxToString("%f", val); }
    inline std::string gxToString(const double &val) { return gxToString("%lf", val); }
    inline std::string gxToString(const bool &val) { return gxToString("%u", val?1:0); }
    inline std::string gxToString(const std::string &val) { return val; }

    template<class T>
    bool gxFromString(const std::string &str, T &obj)
    {
        return obj.fromString(str);
    }
    inline bool gxFromString(const std::string &str, uint32 &val) { if (str.find('-') != std::string::npos) { val = 0; return false; } char *end; unsigned long v; errno = 0; v = strtoul(str.c_str(), &end, 10); if (errno || v > UINT_MAX || end == str.c_str()) { val = 0; return false; } else { val = (uint32)v; return true; } }
    inline bool gxFromString(const std::string &str, sint32 &val) { char *end; long v; errno = 0; v = strtol(str.c_str(), &end, 10); if (errno || v > INT_MAX || v < INT_MIN || end == str.c_str()) { val = 0; return false; } else { val = (sint32)v; return true; } }
    inline bool gxFromString(const std::string &str, uint8 &val) { char *end; long v; errno = 0; v = strtol(str.c_str(), &end, 10); if (errno || v > UCHAR_MAX || v < 0 || end == str.c_str()) { val = 0; return false; } else { val = (uint8)v; return true; } }
    inline bool gxFromString(const std::string &str, sint8 &val) { char *end; long v; errno = 0; v = strtol(str.c_str(), &end, 10); if (errno || v > SCHAR_MAX || v < SCHAR_MIN || end == str.c_str()) { val = 0; return false; } else { val = (sint8)v; return true; } }
    inline bool gxFromString(const std::string &str, uint16 &val) { char *end; long v; errno = 0; v = strtol(str.c_str(), &end, 10); if (errno || v > USHRT_MAX || v < 0 || end == str.c_str()) { val = 0; return false; } else { val = (uint16)v; return true; } }
    inline bool gxFromString(const std::string &str, sint16 &val) { char *end; long v; errno = 0; v = strtol(str.c_str(), &end, 10); if (errno || v > SHRT_MAX || v < SHRT_MIN || end == str.c_str()) { val = 0; return false; } else { val = (sint16)v; return true; } }
    inline bool gxFromString(const std::string &str, uint64 &val) { bool ret = sscanf(str.c_str(), "%" I64_FMT "u", &val) == 1; if (!ret) val = 0; return ret; }
    inline bool gxFromString(const std::string &str, sint64 &val) { bool ret = sscanf(str.c_str(), "%" I64_FMT "d", &val) == 1; if (!ret) val = 0; return ret; }
    inline bool gxFromString(const std::string &str, float &val) { bool ret = sscanf(str.c_str(), "%f", &val) == 1; if (!ret) val = 0.0f; return ret; }
    inline bool gxFromString(const std::string &str, double &val) { bool ret = sscanf(str.c_str(), "%lf", &val) == 1; if (!ret) val = 0.0; return ret; }
    inline bool gxFromString(const std::string &str, bool &val) { val = (str.length() == 1) && str[0] != '0'; return (str.length() == 1) && (str[0] == '0' || str[0] == '1'); }
    inline bool gxFromString(const std::string &str, std::string &val) { val = str; return true; }


    /** Convert a string in lower case.
    * \param str a string to transform to lower case
    */

    std::string	gxToLower ( const std::string &str );
    void		gxToLower ( char *str );
    char		gxToLower ( const char ch );	// convert only one character

    /** Convert a string in upper case.
    * \param a string to transform to upper case
    */

    std::string	gxToUpper ( const std::string &str);
    void		gxToUpper ( char *str);

    // Remove all the characters <= 32 (tab, space, new line, return, vertical tab etc..) at the beginning and at the end of a string
    template <class T> T gxTrim (const T &str)
    {
        typename T::size_type start = 0;
        const typename T::size_type size = str.size();
        while (start < size && str[start] <= 32)
            start++;
        typename T::size_type end = size;
        while (end > start && str[end-1] <= 32 && str[end-1] > 0)
            end--;
        return str.substr (start, end-start);
    }

    // remove spaces at the end of the string
//    template <class T> T gxTrimRightWhiteSpaces (const T &str)
//    {
//        typename T::size_type end = str.size();
//        while (end > 0 && isspace(str[end-1]))
//            end--;
//        return str.substr (0, end);
//    }

	/*去掉str后面的c字符*/
	void gxTrimleft(std::string &str, char c=' '); 
	/*去掉str前面的c字符*/ 
	void gxTrimright(std::string &str, char c=' '); 

    //////////////////////////////////////////////////////////////////////////
    // ****  DEPRECATED *****: PLEASE DON'T USE THESE METHODS BUT FUNCTIONS ABOVE toLower() and toUpper()
    //////////////////////////////////////////////////////////////////////////
    inline std::string		&gxStrlwr ( std::string &str )		{ str = gxToLower(str); return str; }
    inline std::string		gxStrlwr ( const std::string &str )	{ return gxToLower(str); }
    inline char				*gxStrlwr ( char *str )				{ gxToLower(str); return str; }
    inline std::string		&gxStrupr ( std::string &str )		{ str = gxToUpper(str); return str; }
    inline std::string		gxStrupr ( const std::string &str )	{ return gxToUpper(str); }
    inline char				*gxStrupr ( char *str )				{ gxToUpper(str); return str; }

    /// Returns a readable string from a vector of bytes. unprintable char are replaced by '?'
    std::string gxStringFromVector( const std::vector<uint8>& v, bool limited = true );


    /// Convert a string into an sint64 (same as atoi() function but for 64 bits intergers)
    sint64 gxAtoiInt64 (const char *ident, sint64 base = 10);

    /// Convert an sint64 into a string (same as itoa() function but for 64 bits intergers)
    void gxItoaInt64 (sint64 number, char *str, sint64 base = 10);


    /// Convert a number in bytes into a string that is easily readable by an human, for example 105123 -> "102kb"
    std::string gxBytesToHumanReadable (const std::string &bytes);
    std::string gxBytesToHumanReadable (uint64 bytes);

    /// Convert a human readable into a bytes,  for example "102kb" -> 105123
    uint32 gxHumanReadableToBytes (const std::string &str);

    /// Convert a time into a string that is easily readable by an human, for example 3600 -> "1h"
    std::string gxSecondsToHumanReadable (uint32 time);


    /// Get a bytes or time in string format and convert it in seconds or bytes
    uint32 gxFromHumanReadable (const std::string &str);


    /** Explode a string (or ucstring) into a vector of string with *sep* as separator. If sep can be more than 1 char, in this case,
    * we find the entire sep to separator (it s not a set of possible separator)
    *
    * \param skipEmpty if true, we don't put in the res vector empty string
    */
    template <class T> void gxExplode (const T &src, const T &sep, std::vector<T> &res, bool skipEmpty = false)
    {
        std::string::size_type oldpos = 0, pos;

        res.clear ();

        do
        {
            pos = src.find (sep, oldpos);
            T s;
            if(pos == std::string::npos)
                s = src.substr (oldpos);
            else
                s = src.substr (oldpos, (pos-oldpos));

            if (!skipEmpty || !s.empty())
                res.push_back (s);

            oldpos = pos+sep.size();
        }
        while(pos != std::string::npos);
    }

	const static bool gxExplode(const char* src, const char* p1, const char* p2, std::string& outStr);

	typedef GXMISC::CFixString<1024> TLogString;

    // 定义一些需要打印的变量及toString()函数, 其中变量会主动定义
#define DObjToStringDef(ObjType, VarType, Var)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public:     \
    VarType Var;    \
    const char* toString() \
    {   \
    DStaticAssert(sizeof(VarType) == sizeof(Var));   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s;", GXMISC::TFS<VarType>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var);    \
	return _objStrName.c_str();	\
    }

#define DObjToString2Def(ObjType, VarType, Var, VarType2, Var2)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    VarType Var;    \
    VarType2 Var2;  \
    const char* toString() \
    {   \
    DStaticAssert(sizeof(VarType) == sizeof(Var));   \
    DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2);    \
	return _objStrName.c_str();	\
    }

#define DObjToString3Def(ObjType, VarType, Var, VarType2, Var2, VarType3, Var3)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    VarType Var;    \
    VarType2 Var2;  \
    VarType3 Var3;  \
    const char* toString() \
    {   \
    DStaticAssert(sizeof(VarType) == sizeof(Var));   \
    DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
    DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3);    \
	return _objStrName.c_str();	\
    }

#define DObjToString4Def(ObjType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    VarType Var;    \
    VarType2 Var2;  \
    VarType3 Var3;  \
    VarType4 Var4;  \
    const char* toString() \
    {   \
    DStaticAssert(sizeof(VarType) == sizeof(Var));   \
    DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
    DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
    DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s;", \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT); \
    _objStrName = GXMISC::gxToString(fmt, Var, Var2, Var3, Var4);    \
	return _objStrName.c_str();	\
    }

#define DObjToString5Def(ObjType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4, VarType5, Var5)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    VarType Var;    \
    VarType2 Var2;  \
    VarType3 Var3;  \
    VarType4 Var4;  \
    VarType5 Var5;  \
    const char* toString() \
    {   \
    DStaticAssert(sizeof(VarType) == sizeof(Var));   \
    DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
    DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
    DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
    DStaticAssert(sizeof(VarType5) == sizeof(Var5));   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s,"#Var5"=%s;", \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5);    \
	return _objStrName.c_str();	\
    }


    // 定义一些需要打印的变量及toString()函数, 变量不会定义
#define DObjToString(ObjType, VarType, Var)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    const char* toString() \
    {   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s;", GXMISC::TFS<VarType>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var);    \
	return _objStrName.c_str();	\
    }

#define DObjToString2(ObjType, VarType, Var, VarType2, Var2)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    const char* toString() \
    {   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2);    \
	return _objStrName.c_str();	\
    }

#define DObjToString3(ObjType, VarType, Var, VarType2, Var2, VarType3, Var3)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    const char* toString() \
    {   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3);    \
	return _objStrName.c_str();	\
    }

#define DObjToString4(ObjType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    const char* toString()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s;", \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4);    \
	return _objStrName.c_str();	\
    }

#define DObjToString5(ObjType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4, VarType5, Var5)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    const char* toString() \
    {   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s,"#Var5"=%s;", \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5);    \
	return _objStrName.c_str();	\
    }

    // 定义一些需要打印的变量及toString()函数, 变量不会定义, toString()会显示变量的别名
#define DObjToStringAlias(ObjType, VarType, VarName, Var)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    const char* toString() \
    {   \
    std::string fmt = GXMISC::gxToString(""#VarName"=%s;", GXMISC::TFS<VarType>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var);    \
	return _objStrName.c_str();	\
    }

#define DObjToString2Alias(ObjType, VarType, VarName, Var, VarType2, VarName2, Var2)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    const char* toString()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2);    \
	return _objStrName.c_str();	\
    }

#define DObjToString3Alias(ObjType, VarType, VarName, Var, VarType2, VarName2, Var2, VarType3, VarName3, Var3)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    const char* toString()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s,"#VarName3"=%s;",    \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3);    \
	return _objStrName.c_str();	\
    }

#define DObjToString4Alias(ObjType, VarType, VarName, Var, VarType2, VarName2, Var2, VarType3, VarName3, Var3, VarType4, VarName4, Var4)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    const char* toString()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s,"#VarName3"=%s,"#VarName4"=%s;", \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4);    \
	return _objStrName.c_str();	\
    }

#define DObjToString5Alias(ObjType, VarType, VarName, Var, VarType2, VarName2, Var2, VarType3, VarName3, Var3, VarType4, VarName4, Var4, VarType5, VarName5, Var5)   \
	private:	\
	GXMISC::TLogString _objStrName;	\
    public: \
    const char* toString() \
    {   \
    std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s,"#VarName3"=%s,"#VarName4"=%s,"#VarName5"=%s;", \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5);    \
	return _objStrName.c_str();	\
    }

// 定义一些需要打印的变量及toString()函数, 变量不会定义
#define DFastObjToString(ObjType, VarType, Var)   \
    private:    \
    GXMISC::TLogString _objStrName;   \
    private:    \
    void genStrName()   \
    {   \
        std::string fmt = GXMISC::gxToString(""#Var"=%s;", GXMISC::TFS<VarType>::FMT); \
        _objStrName = GXMISC::gxToString(fmt.c_str(), Var);    \
    }   \
    public: \
    const char* toString() const \
    {   \
        return _objStrName.c_str();    \
    }

#define DFastObjToString2(ObjType, VarType, Var, VarType2, Var2)   \
    private:    \
    GXMISC::TLogString _objStrName;   \
    private: \
    void genStrName()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2);    \
    }   \
    public: \
    const char* toString() const \
    {   \
        return _objStrName.c_str();    \
    }

#define DFastObjToString3(ObjType, VarType, Var, VarType2, Var2, VarType3, Var3)   \
    private:    \
    GXMISC::TLogString _objStrName;   \
    private: \
    void genStrName()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3);    \
    }   \
    public: \
    const char* toString() const \
    {   \
        return _objStrName.c_str();    \
    }
    
#define DFastObjToString4(ObjType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4)   \
    private:    \
    GXMISC::TLogString _objStrName;   \
    private: \
    void genStrName()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s;", \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4);    \
    }   \
    public: \
    const char* toString() const \
    {   \
        return _objStrName.c_str();    \
    }

#define DFastObjToString5(ObjType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4, VarType5, Var5)   \
    private:    \
    GXMISC::TLogString _objStrName;   \
    private: \
    void genStrName()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s,"#Var5"=%s;", \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5);    \
    }   \
    public: \
    const char* toString() const \
    {   \
    return _objStrName.c_str();    \
    }

// 定义一些需要打印的变量及toString()函数, 变量不会定义, toString()会显示变量的别名
#define DFastObjToStringAlias(ObjType, VarType, VarName, Var)   \
    private:    \
    GXMISC::TLogString _objStrName;   \
    private: \
    void genStrName()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#VarName"=%s;", GXMISC::TFS<VarType>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var);    \
    }   \
    public: \
    const char* toString() const \
    {   \
    return _objStrName.c_str();    \
    }

#define DFastObjToString2Alias(ObjType, VarType, VarName, Var, VarType2, VarName2, Var2)   \
    private:    \
    GXMISC::TLogString _objStrName;   \
    private: \
    void genStrName()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2);    \
    }   \
    public: \
    const char* toString() const \
    {   \
    return _objStrName.c_str();    \
    }

#define DFastObjToString3Alias(ObjType, VarType, VarName, Var, VarType2, VarName2, Var2, VarType3, VarName3, Var3)   \
    private:    \
    GXMISC::TLogString _objStrName;   \
    private: \
    void genStrName()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s,"#VarName3"=%s;",    \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3);    \
    }   \
    public: \
    const char* toString() const \
    {   \
    return _objStrName.c_str();    \
    }

#define DFastObjToString4Alias(ObjType, VarType, VarName, Var, VarType2, VarName2, Var2, VarType3, VarName3, Var3, VarType4, VarName4, Var4)   \
    private:    \
    GXMISC::TLogString _objStrName;   \
    private: \
    void genStrName()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s,"#VarName3"=%s,"#VarName4"=%s;", \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4);    \
    }   \
    public: \
    const char* toString() const \
    {   \
    return _objStrName.c_str();    \
    }

#define DFastObjToString5Alias(ObjType, VarType, VarName, Var, VarType2, VarName2, Var2, VarType3, VarName3, Var3, VarType4, VarName4, Var4, VarType5, VarName5, Var5)   \
    private:    \
    GXMISC::TLogString _objStrName;   \
    private: \
    void genStrName()  \
    {   \
    std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s,"#VarName3"=%s,"#VarName4"=%s,"#VarName5"=%s;", \
    GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT); \
    _objStrName = GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5);    \
    }   \
    public: \
    const char* toString() const \
    {   \
    return _objStrName.c_str();    \
    }
}

#endif