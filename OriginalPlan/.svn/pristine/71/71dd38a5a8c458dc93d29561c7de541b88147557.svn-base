#ifndef _OBJ_MEM_POOL_H_
#define _OBJ_MEM_POOL_H_

#include <list>
#include <vector>

#include "types_def.h"
#include "debug.h"

namespace GXMISC
{
	/**
	* Block memory allocation
	*
	* This memory manager is a fast memory allocator, doing same thing as new/delete. It works by blocks. Blocks are always
	* allocated, never deleted.  Allocation/free are in O(1).
	*
	* Elements with sizeof(T)<sizeof(void*) should not be used with this allocator, because
	* sizeEltInMemory= max(sizeof(T),sizeof(void*)).
	*
	* free() check invalid ptr in debug only, for extra cost of 8 octets per element.
	*
	* NB: if template parameter __ctor_dtor__ is false, then ctor and dtor are not called when an element is allocate()-ed
	*	or deallocate()-ed.
	*/
	template<class T, bool __ctor_dtor__= true >
	class CObjMemPool
	{
	public:

		/// Constructor
		CObjMemPool(uint32 blockSize= 16)
		{
			gxAssert(blockSize);
			_blockSize= blockSize;
			_eltSize= std::max((uint32)sizeof(T), (uint32)sizeof(void*));
			_nextFreeElt= NULL;
			_nAllocatedElts= 0;
		}

		// just copy setup from other blockMemory, don't copy data!
		CObjMemPool(const CObjMemPool<T, __ctor_dtor__> &other)
		{
			_blockSize= other._blockSize;
			// if other block is rebinded, don't copy its rebinded size.
			_eltSize= (uint32)std::max(sizeof(T), sizeof(void*));
			// No elts allocated
			_nextFreeElt= NULL;
			_nAllocatedElts= 0;
		}

		/** purge()
		*/
		~CObjMemPool()
		{
			purge();
		}

		/// allocate an element. ctor is called.
		T*				allocate()
		{
			// if not enough memory, aloc a block.
			if(!_nextFreeElt)
			{
				_blocks.push_front(CBlock());
				buildBlock(*_blocks.begin());
				// new free elt points to the beginning of this block.
				_nextFreeElt= (*_blocks.begin())._data;
#ifdef LIB_DEBUG
				// if debug, must decal for begin check.
				_nextFreeElt= (uint32*)_nextFreeElt + 1;
#endif
			}

			// choose next free elt.
			gxAssert(_nextFreeElt);
			T*		ret= (T*)_nextFreeElt;

			// update _NextFreeElt, so it points to the next free element.
			_nextFreeElt= *(void**)_nextFreeElt;

			// construct the allocated element.
			if( __ctor_dtor__ )
				new (ret) T;

			// some simple Check.
#ifdef LIB_DEBUG
			uint32	*checkStart= (uint32*)(void*)ret-1;
			uint32	*checkEnd  = (uint32*)((uint8*)(void*)ret+_eltSize);
			gxAssert( *checkStart == CheckDeletedIdent);
			gxAssert( *checkEnd   == CheckDeletedIdent);
			// if ok, mark this element as allocated.
			*checkStart= CheckAllocatedIdent;
			*checkEnd  = CheckAllocatedIdent;
#endif

			_nAllocatedElts++;

			return ret;
		}

		/// delete an element allocated with this manager. dtor is called. NULL is tested.
		void			free(T* ptr)
		{
			if(!ptr)
			{
				return;
			}

			// some simple Check.
			gxAssert(_nAllocatedElts>0);
#ifdef LIB_DEBUG
			uint32	*checkStart= (uint32*)(void*)ptr-1;
			uint32	*checkEnd  = (uint32*)((uint8*)(void*)ptr+_eltSize);
			gxAssert( *checkStart == CheckAllocatedIdent);
			gxAssert( *checkEnd   == CheckAllocatedIdent);
			// if ok, mark this element as deleted.
			*checkStart = *checkEnd = uint32(CheckDeletedIdent);
#endif

			// destruct the element.
			if( __ctor_dtor__ )
				ptr->~T();

			// just append this freed element to the list.
			*(void**)ptr= _nextFreeElt;
			_nextFreeElt= (void*) ptr;

			_nAllocatedElts--;
		}


		/** delete all blocks, freeing all memory. It is an error to purge() or delete a CBlockMemory, while elements
		* still remains!! You must free your elements with free().
		*	NB: you can disable this assert if you set GX3D_BlockMemoryAssertOnPurge to false
		*	(good to quit a program quickly without uninitialize).
		*/
		void	purge ()
		{
			gxAssert(_nAllocatedElts==0);

			while(_blocks.begin()!=_blocks.end())
			{
				releaseBlock(*_blocks.begin());
				_blocks.erase(_blocks.begin());
			}

			_nextFreeElt= NULL;
			_nAllocatedElts= 0;
		}

	public:
		// This is to be used with CSTLBlockAllocator only!!! It changes the size of an element!!
		void		__stl_alloc_changeEltSize(uint32 eltSize)
		{
			// must not be used with object ctor/dtor behavior.
			gxAssert(__ctor_dtor__ == false);
			// format size.
			eltSize= std::max((uint32)eltSize, (uint32)sizeof(void*));
			// if not the same size as before
			if(_eltSize!= eltSize)
			{
				// verify that rebind is made before any allocation!!
				gxAssert(_blocks.empty());
				// change the size.
				_eltSize= eltSize;
			}
		};

		// This is to be used with CSTLBlockAllocator only!!!
		uint32		__stl_alloc_getEltSize() const
		{
			return _eltSize;
		}


	private:
		/// size of a block.
		uint32		_blockSize;
		/// size of an element in the block.
		uint32		_eltSize;
		/// number of elements allocated.
		sint32		_nAllocatedElts;
		/// next free element.
		void		*_nextFreeElt;
		/// Must be ThreadSafe (eg: important for 3D PointLight and list of transform)

		/// a block.
		struct	CBlock
		{
			/// The data allocated.
			void		*_data;
		};

		/// list of blocks.
		std::list<CBlock>	_blocks;


		/// For debug only, check ident.
		enum  TCheckIdent	{ CheckAllocatedIdent= 0x01234567, CheckDeletedIdent= 0x89ABCDEF };


	private:
		void		buildBlock(CBlock &block)
		{
			uint32	i;
			uint32	nodeSize= _eltSize;
#ifdef LIB_DEBUG
			// must allocate more size for mem checks in debug.
			nodeSize+= 2*sizeof(uint32);
#endif

			// allocate.
			block._data = (void*)new uint8 [_blockSize * nodeSize];

			// by default, all elements are not allocated, build the list of free elements.
			void	*ptr= block._data;
#ifdef LIB_DEBUG
			// if debug, must decal for begin check.
			ptr= (uint32*)ptr + 1;
#endif
			for(i=0; i<_blockSize-1; i++)
			{
				// next elt.
				void	*next= (uint8*)ptr + nodeSize;
				// points to the next element in this array.
				*(void**)ptr= next;
				// next.
				ptr= next;
			}
			// last element points to NULL.
			*(void**)ptr= NULL;


			// If debug, must init all check values to CheckDeletedIdent.
#ifdef LIB_DEBUG
			ptr= block._data;
			// must decal for begin check.
			ptr= (uint32*)ptr + 1;
			// fill all nodes.
			for(i=0; i<_blockSize; i++)
			{
				uint32	*checkStart= (uint32*)ptr-1;
				uint32	*checkEnd  = (uint32*)((uint8*)ptr+_eltSize);
				// mark this element as deleted.
				*checkStart = *checkEnd = uint32(CheckDeletedIdent);

				// next elt.
				ptr= (uint8*)ptr + nodeSize;
			}
#endif

		}
		void		releaseBlock(CBlock &block)
		{
			delete[] ((uint8*)block._data);
            block._data = NULL;
		}

	};


} // GXMISC

#endif