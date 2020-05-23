#ifndef _LOOKASIDE_ALLOCATOR_H_
#define _LOOKASIDE_ALLOCATOR_H_

 #include "debug.h"

namespace GXMISC
{
	// @TODO 内存重新管理，看是否有内存泄露
	template<class T> 
	inline	void constructInPlace(T  *_Ptr)
	{	
		new ((void  *)_Ptr) T( T() );
	}

	template<class _Ty,class _TParam> 
	inline	void constructInPlace(_Ty  *_Ptr,_TParam param)
	{	
		new ((void  *)_Ptr) _Ty( param );
	}

	template<class _Ty,class _TParam1,class _TParam2> 
	inline	void constructInPlace(_Ty  *_Ptr,_TParam1 param1,_TParam2 param2)
	{	
		new ((void  *)_Ptr) _Ty( param1,param2 );
	}

	template<class _Ty,class _TParam1,class _TParam2,class _TParam3> 
	inline	void constructInPlace(_Ty  *_Ptr,_TParam1 param1,_TParam2 param2,_TParam3 param3)
	{	
		new ((void  *)_Ptr) _Ty( param1,param2 ,param3);
	}

	template<class _Ty,class _TParam1,class _TParam2,class _TParam3,class _TParam4> 
	inline	void constructInPlace(_Ty  *_Ptr,_TParam1 param1,_TParam2 param2,_TParam3 param3,_TParam4 param4)
	{	
		new ((void  *)_Ptr) _Ty( param1,param2 ,param3,param4);
	}

	template<class _Ty,class _TParam1,class _TParam2,class _TParam3,class _TParam4,class _TParam5> 
	inline	void constructInPlace(_Ty  *_Ptr,_TParam1 param1,_TParam2 param2,_TParam3 param3,_TParam4 param4,_TParam5 param5)
	{	
		new ((void  *)_Ptr) _Ty( param1,param2 ,param3,param4,param5);
	}
	template<class _Ty,class _TParam1,class _TParam2,class _TParam3,class _TParam4,class _TParam5,class _TParam6> 
	inline	void constructInPlace(_Ty  *_Ptr,_TParam1 param1,_TParam2 param2,_TParam3 param3,_TParam4 param4,_TParam5 param5,_TParam6 param6)
	{	
		new ((void  *)_Ptr) _Ty(param1, param2, param3, param4, param5, param6);
	}
	template<class _Ty,class _TParam1,class _TParam2,class _TParam3,class _TParam4,class _TParam5,class _TParam6,class _TParam7> 
	inline	void constructInPlace(_Ty  *_Ptr,_TParam1 param1,_TParam2 param2,_TParam3 param3,_TParam4 param4,_TParam5 param5,_TParam6 param6,_TParam7 param7)
	{	
		new ((void  *)_Ptr) _Ty(param1, param2, param3, param4, param5, param6, param7);
	}
	template<class _Ty,class _TParam1,class _TParam2,class _TParam3,class _TParam4,class _TParam5,class _TParam6,class _TParam7,class _TParam8> 
	inline	void constructInPlace(_Ty  *_Ptr,_TParam1 param1,_TParam2 param2,_TParam3 param3,_TParam4 param4,_TParam5 param5,_TParam6 param6,_TParam7 param7,_TParam8 param8)
	{	
		new ((void  *)_Ptr) _Ty(param1, param2, param3, param4, param5, param6, param7, param8);
	}
	template<class _Ty,class _TParam1,class _TParam2,class _TParam3,class _TParam4,class _TParam5,class _TParam6,class _TParam7,class _TParam8,class _TParam9> 
	inline	void constructInPlace(_Ty  *_Ptr,_TParam1 param1,_TParam2 param2,_TParam3 param3,_TParam4 param4,_TParam5 param5,_TParam6 param6,_TParam7 param7,_TParam8 param8,_TParam9 param9)
	{	
		new ((void  *)_Ptr) _Ty(param1, param2, param3, param4, param5, param6, param7, param8, param9);
	}
	template<class _Ty,class _TParam1,class _TParam2,class _TParam3,class _TParam4,class _TParam5,class _TParam6,class _TParam7,class _TParam8,class _TParam9,class _TParam10> 
	inline	void constructInPlace(_Ty  *_Ptr,_TParam1 param1,_TParam2 param2,_TParam3 param3,_TParam4 param4,_TParam5 param5,_TParam6 param6,_TParam7 param7,_TParam8 param8,_TParam9 param9,_TParam10 param10)
	{	
		new ((void  *)_Ptr) _Ty(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
	}
	template <class T>
	inline void destructInPlace(T* p)
	{
		p->~T();
	}

	template<class _T> 
	inline	void constructInPlaceCount(_T  *_Ptr,size_t count)
	{	
		for(size_t i=0;i<count;++i)
		{
			constructInPlace(_Ptr++);
		}
	}

	template <class T>
	inline void destructInPlaceCount(T* p,size_t count)
	{
		for(size_t i=0;i<count;++i)
		{
			destructInPlace(p++);
		}
	}

	template<class _Ty>
	struct lookaside_node
	{
		typedef lookaside_node< _Ty > _Myt;
		unsigned char data[sizeof(_Ty)];
		_Myt* next;
	};

	template<class _Ty, size_t blockNodeNum = 64>
	class lookaside_allocator
	{	
	protected:
		typedef lookaside_node< _Ty > _MyNode;

		_MyNode * m_freePool;

		struct stPool
		{
			_MyNode nodes[blockNodeNum];
			stPool* next;
		};
		stPool*		mPools;
	public:

		typedef _Ty *pointer;
		typedef _Ty & reference;
		typedef const _Ty *const_pointer;
		typedef const _Ty & const_reference;

		typedef size_t size_type;
		typedef ptrdiff_t difference_type;

		lookaside_allocator() : m_freePool(NULL) , mPools(NULL)
		{	
		}

		virtual ~lookaside_allocator()
		{
			freeall();
		}

		void freeall()
		{
			while(mPools)
			{
				stPool* p = mPools;
				mPools = p->next;
				free(p);
			}
			m_freePool = NULL;
		}

		lookaside_allocator(const lookaside_allocator<_Ty>&)
		{	
			//assert(0);
		}

		void deallocate(pointer _Ptr, size_type size)
		{	

			//assert(size == 1);
			_MyNode* pNode = (_MyNode*)_Ptr;
			pNode->next = m_freePool;
			m_freePool = pNode;
		}

		void destroy(pointer _Ptr)
		{	
			_Ptr->~_Ty();
		}

		void addPoolBlock()
		{
			stPool* pool = (stPool*)malloc(sizeof(stPool));

			pool->next = mPools;
			mPools = pool;
			_MyNode* p = &pool->nodes[0];
			for(size_t i=0 ; i < blockNodeNum - 1;++i)
			{
				p[i].next = &p[i+1];
			}
			p[blockNodeNum-1].next = NULL;
			m_freePool = p;
		}

		pointer allocate(size_type _Count)
		{	
			if(!m_freePool) 
				addPoolBlock();

			_MyNode* pNode = m_freePool;
			m_freePool = m_freePool->next;
			pNode->next = NULL;
			return (pointer)&pNode->data;
		}

		void* getmem(){
			return allocate(1);
		}
		pointer alloc()
		{
			pointer _Ptr = allocate(1);
			constructInPlace(_Ptr);
			return _Ptr;
		}

		template < class _TParam>
		pointer alloc(_TParam param)
		{
			pointer _Ptr = allocate(1);
			constructInPlace(_Ptr,param);
			return _Ptr;
		}

		template < class _TParam1, class _TParam2>
		pointer alloc(_TParam1 param1,_TParam2 param2)
		{
			pointer _Ptr = allocate(1);
			constructInPlace(_Ptr,param1,param2);
			return _Ptr;
		}

		template < class _TParam1, class _TParam2,class _TParam3>
		pointer alloc(_TParam1 param1,_TParam2 param2,_TParam3 param3)
		{
			pointer _Ptr = allocate(1);
			constructInPlace(_Ptr,param1,param2,param3);
			return _Ptr;
		}

		template < class _TParam1, class _TParam2,class _TParam3,class _TParam4>
		pointer alloc(_TParam1 param1,_TParam2 param2,_TParam3 param3,_TParam4 param4)
		{
			pointer _Ptr = allocate(1);
			constructInPlace(_Ptr,param1,param2,param3,param4);
			return _Ptr;
		}

		template < class _TParam1, class _TParam2,class _TParam3,class _TParam4,class _TParam5 >
		pointer alloc(_TParam1 param1,_TParam2 param2,_TParam3 param3,_TParam4 param4,_TParam5 param5)
		{
			pointer _Ptr = allocate(1);
			constructInPlace(_Ptr,param1,param2,param3,param4,param5);
			return _Ptr;
		}

		void freemem(void* _Ptr){
			return deallocate(((pointer)_Ptr),1);
		}

		void freeobj(void* _Ptr)
		{
			destroy(((pointer)_Ptr));
			deallocate(((pointer)_Ptr),1);
		}
	};

#define LOOKASIDE_GETMEM(lookasideAllocator)  (lookasideAllocator).getmem()
#define LOOKASIDE_ALLOC(lookasideAllocator) (lookasideAllocator).alloc()
#define LOOKASIDE_PALLOC(lookasideAllocator,param) (lookasideAllocator).alloc(param)
#define LOOKASIDE_PALLOC1(lookasideAllocator,param) (lookasideAllocator).alloc(param)
#define LOOKASIDE_PALLOC2(lookasideAllocator,param1,param2) (lookasideAllocator).alloc(param1,param2)
#define LOOKASIDE_PALLOC3(lookasideAllocator,param1,param2,param3) (lookasideAllocator).alloc(param1,param2,param3)
#define LOOKASIDE_PALLOC4(lookasideAllocator,param1,param2,param3,param4) (lookasideAllocator).alloc(param1,param2,param3,param4)
#define LOOKASIDE_PALLOC5(lookasideAllocator,param1,param2,param3,param4,param5) (lookasideAllocator).alloc(param1,param2,param3,param4,param5)

#define ROUNDNUM2(value,num)		( ((value) + ((num)-1)) & (~((num)-1)) )

	class CSimpleAllocator
	{
		struct CAllocNode
		{
			uint8 flag;
			uint32 size;
		};

	public:
		void setThreadID(TThreadID_t tid = gxGetThreadID())
		{
			_threadID = tid;
		}

		char* alloc(int n)
		{
			return allocate(n);
		}

		void free(char* p)
		{
			deallocate(p);
		}
	
		uint32 getTotalAllocSize() const { return _totalSize; }

	private:
		char* allocate(int n);
		void deallocate(void* p);

		template < class _TP >
		bool allocate(_TP*& pret,int n)
		{
			pret=(_TP*)allocate(sizeof(_TP)*n);
			return (pret!=NULL);
		}

	protected:
		std::allocator< char >					_ty_alloc_0_128;
		lookaside_allocator< char[256],64 >		_ty_alloc_128; 
		lookaside_allocator< char[512],48 >		_ty_alloc_256;
		lookaside_allocator< char[512*2],32 >	_ty_alloc_512;
		lookaside_allocator< char[512*3],16 >	_ty_alloc_512x2;
		lookaside_allocator< char[512*4],16 >	_ty_alloc_512x3;
		lookaside_allocator< char[512*5],16 >	_ty_alloc_512x4; 
	
		TThreadID_t _threadID;
		uint32 _totalSize;
	};
}

#endif