#ifndef _MEMORY_UTIL_H_
#define _MEMORY_UTIL_H_

namespace GXMISC
{
	template< typename T >
	inline void checked_delete(T * x) 
	{  
#ifdef LIB_DEBUG
		typedef char type_must_be_complete[sizeof(T) ? 1 : -1];
		(void) sizeof(type_must_be_complete);
#endif
	}
	template<bool val>
	struct _SStaticAssert;

	// 编译期断言
	template<>
	struct _SStaticAssert<true> { typedef bool _AssertType; };
#define DStaticAssert( val ) static_assert(val, "compiler failed!!!");
//	typedef _SStaticAssert<val>::_AssertType TestStaticAssertType;

	/**
	* @brief 将常量变成字符串
	*  eg : #define M1 foo
	*		 #define MESSAGE "the message is "MACRO_TO_STR(M1)
	*		 #pragma message(MESSAGE)
	*		 printf(MACRO_TO_STR(M1));
	*/
#define DMacroToStrSubpart(x) #x
#define DMacroToStr(x) DMacroToStrSubpart(x)

	//根据指针值删除内存
#ifndef DSafeDelete
#define DSafeDelete(x)	if( (x)!=NULL ) { GXMISC::checked_delete(x); delete (x); (x)=NULL; }
#endif
	//根据指针值删除数组类型内存
#ifndef DSafeDeleteArray
#define DSafeDeleteArray(x)	if( (x)!=NULL ) { GXMISC::checked_delete(x); delete[] (x); (x)=NULL; }
#endif
	// 根据指针删除数据类型内存
#ifndef DSafeDeleteArrays
#define DSafeDeleteArrays(x, n) \
	if( (x) != NULL ){   \
	for(sint32 i = 0; i < (n); ++i){    \
	if(x[i] != NULL){ DSafeDelete(x[i]); }  \
	}   \
	DSafeDeleteArray(x);    \
	}
#endif
	// 根据指针分配

#define DCleanSubStruct(BaseType)  \
	char* ba = ((char*)this)+sizeof(BaseType);   \
	sint32 len = sizeof(*this)-sizeof(BaseType); \
	memset(ba, 0, len);

	// 堆栈临时缓冲区的分配, 超过了函数作用域则自动释放
	struct _stAutoAlloc
	{
		char* m_p;
		_stAutoAlloc()
		{
			m_p = NULL;
		};
		~_stAutoAlloc()
		{
			DSafeDeleteArray(m_p);
		};
	};
#define DStackAllocate(t,p,n)		t p=NULL;sint32 sas##p=(std::max<sint32>(n,16)*sizeof(p[0]));_stAutoAlloc aac##p;if (sas##p>32*1024)	\
	{p=(t)(new char[sas##p]);			aac##p.m_p=(char*)p;*((uint32*)p)=0; }else{p=(t)(new char[sas##p]);aac##p.m_p=(char*)p;*((uint32*)p)=0;};
#define DZStackAllocate(t,p,n)		DStackAllocate(t,p,n);if(p){ZeroMemory(p,sas##p);};

	// 移位操作
#define DMakeBit(x) (1<<(x))
#define DBit(X)  DMakeBit(X)

	// 统计数组长度
#define DCountOf(X) (sizeof(X)/sizeof((X)[0]))
	// 对指针清零
#define DZeroPtr(p) memset((p), 0, sizeof(*(p)));
	// 对当前类清零
#define DZeroSelf DZeroPtr(this);

	// retrieve size of a static array
//#define DSizeOfArray(v) (sizeof(v) / sizeof((v)[0]))

	/** \c contReset take a container like std::vector or std::deque and put his size to 0 like \c clear() but free all buffers.
    * This function is useful because \c resize(), \c clear(), \c erase() or \c reserve() methods never realloc when the array size come down.
    * \param a is the container to reset.
    */
    template<class T>
	inline void gxContReset (T& a)
    {
        a.~T();
        new (&a) T;
    }
	
	template<typename T>
	inline void gxFreeArrays(T** &p, uint32 num)
	{
		if( p != NULL )
		{
			for(uint32 i = 0; i < num; ++i)
			{
				DSafeDelete(p[i]);
			} 

			DSafeDeleteArray(p); 
		}
	}

	template<typename T>
	inline void gxFree2Arrays(T** &p, uint32 num)
	{
		if( p != NULL )
		{
			for(uint32 i = 0; i < num; ++i)
			{
				DSafeDeleteArray(p[i]);
			} 

			DSafeDeleteArray(p); 
		}
	}

	// 分配内存块
	template<typename T>
	inline bool gxAllocArrays(T** & p, uint32 num)
	{
		uint32 count = 0;

		p = new T*[num];
		if(p == NULL)
		{
			return false;
		}

		for(uint32 i = 0; i < num; ++i)
		{
			p[i] = new T();
			if(p[i] == NULL)
			{
				gxFreeArrays(p, count);
				return false;
			}

			count++;
		}

		return true;
	}

	template<typename T>
	inline bool gxAllocArrays(T** & p, uint32 x, uint32 y)
	{
		uint32 count = 0;

		p = new T*[y];
		if(p == NULL)
		{
			return false;
		}

		for(uint32 i = 0; i < y; ++i)
		{
			p[i] = new T[x];
			if(p[i] == NULL)
			{
				gxFree2Arrays(p, count);
				return false;
			}
			memset(p[i], 0, sizeof(T)*x);

			count++;
		}

		return true;
	}

	template<typename T>
	inline T* gxReallocAry(T* data, uint32 srcCount, uint32 destCount)
	{
		T* temp = new T[destCount];
		memset(temp, 0, sizeof(destCount));
		memcpy(temp, data, srcCount*sizeof(T));
		return temp;
	}
}

#endif // _MEMORY_UTIL_H_