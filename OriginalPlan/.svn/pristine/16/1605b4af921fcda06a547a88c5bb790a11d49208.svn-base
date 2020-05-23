#ifndef _STREAM_H_
#define _STREAM_H_

#include "types_def.h"
#include "stream_traits.h"
#include "static_construct_enable.h"
#include "memory_util.h"

namespace GXMISC
{
	// ÐòÁÐ»¯Á÷
	class IStream
	{
	protected:
		IStream(){}
	public:
		virtual ~IStream(){}

	public:
		template<class T, bool flag>
		class _StreamUtil
		{
		public:
			static void Serial(IStream* stream, T& obj);
			static uint32 SerialLen(T* obj);
		};

		template<class T>
		class _StreamUtil<T, true>
		{
		public:
			static uint8 Serial(IStream& stream, T* obj)
			{
				obj->serial(stream);
				return 1;
			}

			static uint32 SerialLen(T* obj)
			{
				return obj->serialLen();
			}
		};

		template<class T>
		class _StreamUtil<T, false>
		{
		public:
			static uint8 Serial(IStream& stream, T* obj)
			{
				if(stream.serialBuffer((char*)obj, sizeof(*obj)))
				{
					return 1;
				}

				return 0;
			}

			static uint32 SerialLen(T* obj)
			{
				return sizeof(T);
			}
		};

	public:
		template<typename T>
		uint8 serial(const T &obj)
		{	
			return _StreamUtil<T, std::is_base_of<IStreamable, T>::value
			|| std::is_base_of<IStreamableAll, T>::value>::Serial(*this, const_cast<T*>(&obj));
		}

	public:
		template<typename T>
		uint32 serialLen(const T& obj)
		{
			return _StreamUtil<T, std::is_base_of<IStreamable, T>::value
			|| std::is_base_of<IStreamableAll, T>::value>::SerialLen(const_cast<T*>(&obj));
		}

		template<typename T>
		static uint32 SerialLen(const T& obj)
		{
			return _StreamUtil<T, std::is_base_of<IStreamable, T>::value
			|| std::is_base_of<IStreamableAll, T>::value>::SerialLen(const_cast<T*>(&obj));
		}

	public:
		template<class T0,class T1>
		uint8 serial(const T0 &a, const T1 &b)
		{ return serial(a)+serial(b);}
		template<class T0,class T1,class T2>
		uint8 serial(const T0 &a,const T1 &b, const T2 &c)
		{ return serial(a)+serial(b)+serial(c);}
		template<class T0,class T1,class T2,class T3>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d)
		{ return serial(a)+serial(b)+serial(c)+serial(d);}
		template<class T0,class T1,class T2,class T3,class T4>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e)
		{ return serial(a)+serial(b)+serial(c)+serial(d)+serial(e);}
		template<class T0,class T1,class T2,class T3,class T4,class T5>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f)
		{ return serial(a)+serial(b)+serial(c)+serial(d)+serial(e)+serial(f);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g)
		{ return serial(a)+serial(b)+serial(c)+serial(d)+serial(e)+serial(f)+serial(g); }
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h)
		{ return serial(a)+serial(b)+serial(c)+serial(d)+serial(e)+serial(f)+serial(g)+serial(h); }
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7, class T8>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &j)
		{ return serial(a)+serial(b)+serial(c)+serial(d)+serial(e)+serial(f)+serial(g)+serial(h)+serial(j); }

		template<class T0,class T1>
		uint32 serialLen(const T0 &a, const T1 &b)
		{ return serialLen(a)+serialLen(b);}
		template<class T0,class T1,class T2>
		uint32 serialLen(const T0 &a,const T1 &b, const T2 &c)
		{ return serialLen(a)+serialLen(b)+serialLen(c);}
		template<class T0,class T1,class T2,class T3>
		uint32 serialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d)
		{ return serialLen(a)+serialLen(b)+serialLen(c)+serialLen(d);}
		template<class T0,class T1,class T2,class T3,class T4>
		uint32 serialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e)
		{ return serialLen(a)+serialLen(b)+serialLen(c)+serialLen(d)+serialLen(e);}
		template<class T0,class T1,class T2,class T3,class T4,class T5>
		uint32 serialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f)
		{ return serialLen(a)+serialLen(b)+serialLen(c)+serialLen(d)+serialLen(e)+serialLen(f);}

		template<class T0,class T1>
		static uint32 SerialLen(const T0 &a, const T1 &b)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b);}
		template<class T0,class T1,class T2>
		static uint32 SerialLen(const T0 &a,const T1 &b, const T2 &c)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c);}
		template<class T0,class T1,class T2,class T3>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d);}
		template<class T0,class T1,class T2,class T3,class T4>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e);}
		template<class T0,class T1,class T2,class T3,class T4,class T5>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e)+IStream::SerialLen(f);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e)+IStream::SerialLen(f)+IStream::SerialLen(g);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e)+IStream::SerialLen(f)+IStream::SerialLen(g)+IStream::SerialLen(h);}	
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e)+IStream::SerialLen(f)+IStream::SerialLen(g)+IStream::SerialLen(h)+IStream::SerialLen(i);}	
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e)+IStream::SerialLen(f)+IStream::SerialLen(g)+IStream::SerialLen(h)+IStream::SerialLen(i)+IStream::SerialLen(j);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9,class T10>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j, const T10 &k)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e)+IStream::SerialLen(f)+IStream::SerialLen(g)+IStream::SerialLen(h)+IStream::SerialLen(i)+IStream::SerialLen(j)+IStream::SerialLen(k);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9,class T10,class T11>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j, const T10 &k, const T11 &l)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e)+IStream::SerialLen(f)+IStream::SerialLen(g)+IStream::SerialLen(h)+IStream::SerialLen(i)+IStream::SerialLen(j)+IStream::SerialLen(k)+IStream::SerialLen(l);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9,class T10,class T11,class T12>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j, const T10 &k, const T11 &l, const T12 &m)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e)+IStream::SerialLen(f)+IStream::SerialLen(g)+IStream::SerialLen(h)+IStream::SerialLen(i)+IStream::SerialLen(j)+IStream::SerialLen(k)+IStream::SerialLen(l)+IStream::SerialLen(m);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9,class T10,class T11,class T12,class T13>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j, const T10 &k, const T11 &l, const T12 &m, const T13 &n)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e)+IStream::SerialLen(f)+IStream::SerialLen(g)+IStream::SerialLen(h)+IStream::SerialLen(i)+IStream::SerialLen(j)+IStream::SerialLen(k)+IStream::SerialLen(l)+IStream::SerialLen(m)+IStream::SerialLen(n);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9,class T10,class T11,class T12,class T13,class T14>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j, const T10 &k, const T11 &l, const T12 &m, const T13 &n, const T14 &o)
		{ return IStream::SerialLen(a)+IStream::SerialLen(b)+IStream::SerialLen(c)+IStream::SerialLen(d)+IStream::SerialLen(e)+IStream::SerialLen(f)+IStream::SerialLen(g)+IStream::SerialLen(h)+IStream::SerialLen(i)+IStream::SerialLen(j)+IStream::SerialLen(k)+IStream::SerialLen(l)+IStream::SerialLen(m)+IStream::SerialLen(n)+IStream::SerialLen(o);}

	public:
		virtual bool serialBuffer(const char *buf, uint32 len) = 0;
	};

	class IUnStream
	{
	protected:
		IUnStream(){}
	public:
		virtual ~IUnStream(){}

	public:
		template<class T, bool flag>
		class _StreamUtil
		{
		public:
			static void Serial(IUnStream* stream, T& obj);
			static uint32 SerialLen(T* obj);
		};

		template<class T>
		class _StreamUtil<T, true>
		{
		public:
			static uint8 Serial(IUnStream& stream, T* obj)
			{
				obj->unSerial(stream);
				return 1;
			}

			static uint32 SerialLen(T* obj)
			{
				return obj->unSerialLen();
			}
		};

		template<class T>
		class _StreamUtil<T, false>
		{
		public:
			static uint8 Serial(IUnStream& stream, T* obj)
			{
				if(stream.serialBuffer((char*)obj, sizeof(*obj)))
				{
					return 1;
				}

				return 0;
			}

			static uint32 SerialLen(T* obj)
			{
				return sizeof(T);
			}
		};

	public:
		template<typename T>
		uint8 serial(const T &obj)
		{	
			return _StreamUtil<T, std::is_base_of<IUnStreamable, T>::value 
				|| std::is_base_of<IStreamableAll, T>::value>::Serial(*this, const_cast<T*>(&obj));
		}

	public:
		template<typename T>
		uint32 serialLen(const T& obj)
		{
			return _StreamUtil<T, std::is_base_of<IUnStreamable, T>::value
			|| std::is_base_of<IStreamableAll, T>::value>::SerialLen(const_cast<T*>(&obj));
		}

		template<typename T>
		static uint32 SerialLen(const T& obj)
		{
			return _StreamUtil<T, std::is_base_of<IUnStreamable, T>::value
			|| std::is_base_of<IStreamableAll, T>::value>::SerialLen(const_cast<T*>(&obj));
		}

	public:
		template<class T0,class T1>
		uint8 serial(const T0 &a, const T1 &b)
		{ return serial(a)+serial(b);}
		template<class T0,class T1,class T2>
		uint8 serial(const T0 &a,const T1 &b, const T2 &c)
		{ return serial(a)+serial(b)+serial(c);}
		template<class T0,class T1,class T2,class T3>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d)
		{ return serial(a)+serial(b)+serial(c)+serial(d);}
		template<class T0,class T1,class T2,class T3,class T4>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e)
		{ return serial(a)+serial(b)+serial(c)+serial(d)+serial(e);}
		template<class T0,class T1,class T2,class T3,class T4,class T5>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f)
		{ return serial(a)+serial(b)+serial(c)+serial(d)+serial(e)+serial(f);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g)
		{ return serial(a)+serial(b)+serial(c)+serial(d)+serial(e)+serial(f)+serial(g); }
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h)
		{ return serial(a)+serial(b)+serial(c)+serial(d)+serial(e)+serial(f)+serial(g)+serial(h); }
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7, class T8>
		uint8 serial(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &j)
		{ return serial(a)+serial(b)+serial(c)+serial(d)+serial(e)+serial(f)+serial(g)+serial(h)+serial(j); }

		template<class T0,class T1>
		uint32 serialLen(const T0 &a, const T1 &b)
		{ return serialLen(a)+serialLen(b);}
		template<class T0,class T1,class T2>
		uint32 serialLen(const T0 &a,const T1 &b, const T2 &c)
		{ return serialLen(a)+serialLen(b)+serialLen(c);}
		template<class T0,class T1,class T2,class T3>
		uint32 serialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d)
		{ return serialLen(a)+serialLen(b)+serialLen(c)+serialLen(d);}
		template<class T0,class T1,class T2,class T3,class T4>
		uint32 serialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e)
		{ return serialLen(a)+serialLen(b)+serialLen(c)+serialLen(d)+serialLen(e);}
		template<class T0,class T1,class T2,class T3,class T4,class T5>
		uint32 serialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f)
		{ return serialLen(a)+serialLen(b)+serialLen(c)+serialLen(d)+serialLen(e)+serialLen(f);}

		template<class T0,class T1>
		static uint32 SerialLen(const T0 &a, const T1 &b)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b);}
		template<class T0,class T1,class T2>
		static uint32 SerialLen(const T0 &a,const T1 &b, const T2 &c)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c);}
		template<class T0,class T1,class T2,class T3>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d);}
		template<class T0,class T1,class T2,class T3,class T4>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e);}
		template<class T0,class T1,class T2,class T3,class T4,class T5>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e)+IUnStream::SerialLen(f);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e)+IUnStream::SerialLen(f)+IUnStream::SerialLen(g);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e)+IUnStream::SerialLen(f)+IUnStream::SerialLen(g)+IUnStream::SerialLen(h);}	
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e)+IUnStream::SerialLen(f)+IUnStream::SerialLen(g)+IUnStream::SerialLen(h)+IUnStream::SerialLen(i);}	
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e)+IUnStream::SerialLen(f)+IUnStream::SerialLen(g)+IUnStream::SerialLen(h)+IUnStream::SerialLen(i)+IUnStream::SerialLen(j);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9,class T10>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j, const T10 &k)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e)+IUnStream::SerialLen(f)+IUnStream::SerialLen(g)+IUnStream::SerialLen(h)+IUnStream::SerialLen(i)+IUnStream::SerialLen(j)+IUnStream::SerialLen(k);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9,class T10,class T11>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j, const T10 &k, const T11 &l)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e)+IUnStream::SerialLen(f)+IUnStream::SerialLen(g)+IUnStream::SerialLen(h)+IUnStream::SerialLen(i)+IUnStream::SerialLen(j)+IUnStream::SerialLen(k)+IUnStream::SerialLen(l);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9,class T10,class T11,class T12>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j, const T10 &k, const T11 &l, const T12 &m)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e)+IUnStream::SerialLen(f)+IUnStream::SerialLen(g)+IUnStream::SerialLen(h)+IUnStream::SerialLen(i)+IUnStream::SerialLen(j)+IUnStream::SerialLen(k)+IUnStream::SerialLen(l)+IUnStream::SerialLen(m);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9,class T10,class T11,class T12,class T13>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j, const T10 &k, const T11 &l, const T12 &m, const T13 &n)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e)+IUnStream::SerialLen(f)+IUnStream::SerialLen(g)+IUnStream::SerialLen(h)+IUnStream::SerialLen(i)+IUnStream::SerialLen(j)+IUnStream::SerialLen(k)+IUnStream::SerialLen(l)+IUnStream::SerialLen(m)+IUnStream::SerialLen(n);}
		template<class T0,class T1,class T2,class T3,class T4,class T5,class T6,class T7,class T8,class T9,class T10,class T11,class T12,class T13,class T14>
		static uint32 SerialLen(const T0 &a, const T1 &b, const T2 &c, const T3 &d, const T4 &e, const T5 &f, const T6 &g, const T7 &h, const T8 &i, const T9 &j, const T10 &k, const T11 &l, const T12 &m, const T13 &n, const T14 &o)
		{ return IUnStream::SerialLen(a)+IUnStream::SerialLen(b)+IUnStream::SerialLen(c)+IUnStream::SerialLen(d)+IUnStream::SerialLen(e)+IUnStream::SerialLen(f)+IUnStream::SerialLen(g)+IUnStream::SerialLen(h)+IUnStream::SerialLen(i)+IUnStream::SerialLen(j)+IUnStream::SerialLen(k)+IUnStream::SerialLen(l)+IUnStream::SerialLen(m)+IUnStream::SerialLen(n)+IUnStream::SerialLen(o);}

	public:
		virtual bool serialBuffer(char *buf, uint32 len) = 0;
	};
}

#endif