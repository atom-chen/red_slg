#include "lookaside_allocator.h"

namespace GXMISC
{
	char* CSimpleAllocator::allocate(int n)
	{
		int nbufsize=(int)ROUNDNUM2(n+sizeof(CAllocNode), 4);

		CAllocNode* node;
		if (nbufsize<=128)
		{
			node = (CAllocNode*)( _ty_alloc_0_128.allocate( (uint8)nbufsize,NULL ) );
			node->size = n;
			node->flag = (uint8)nbufsize;
		}else if (nbufsize<=256)
		{
			node=(CAllocNode*)LOOKASIDE_GETMEM(_ty_alloc_128);
			node->flag = 128+1;
			node->size = 128;
		}else if (nbufsize<=512)
		{
			node=(CAllocNode*)LOOKASIDE_GETMEM(_ty_alloc_256);
			node->flag = 128+2;
			node->size = 256;
		}else if (nbufsize<=512*2)
		{
			node=(CAllocNode*)LOOKASIDE_GETMEM(_ty_alloc_512);
			node->flag = 128+3;
			node->size = 512;
		}else if (nbufsize<=512*3)
		{
			node=(CAllocNode*)LOOKASIDE_GETMEM(_ty_alloc_512x2);
			node->flag = 128+4;
			node->size = 512*2;
		}else if (nbufsize<=512*4)
		{
			node=(CAllocNode*)LOOKASIDE_GETMEM(_ty_alloc_512x3);
			node->flag = 128+5;
			node->size = 512*3;
		}else if (nbufsize<=512*5)
		{
			node=(CAllocNode*)LOOKASIDE_GETMEM(_ty_alloc_512x4);
			node->flag = 128+6;
			node->size = 512*4;
		}else
		{
			node=(CAllocNode*)(new char[nbufsize]);
			node->flag = 0xff;
			node->size = n;
		}

		if(NULL != node)
		{
			char* ptr = (char*)node;
			ptr += sizeof(CAllocNode);

			_totalSize += node->size;

			return ptr;
		}
		
		return NULL;
	}

	void CSimpleAllocator::deallocate(void* p)
	{
		gxAssert(p != NULL);

		if(NULL == p)
		{
			return;
		}

		char* pret=(char*)p;
		pret -= sizeof(CAllocNode);
		CAllocNode* node = (CAllocNode*)pret;

		int nbufsize=node->flag;
		_totalSize -= node->size;

		switch (nbufsize)
		{
		case (128+1):	_ty_alloc_128.freemem(pret); break;
		case (128+2):	_ty_alloc_256.freemem(pret); break;
		case (128+3):	_ty_alloc_512.freemem(pret); break;
		case (128+4):	_ty_alloc_512x2.freemem(pret); break;
		case (128+5):	_ty_alloc_512x3.freemem(pret); break;
		case (128+6):	_ty_alloc_512x4.freemem(pret); break;
		case 0xff: DSafeDeleteArray(pret); break;
		default:
			{
				if (nbufsize<=128)
				{
					_ty_alloc_0_128.deallocate((char*)pret, nbufsize);
				}
				else
				{
					gxError("Can't delete memory!");
				}
			}
			break;
		}

		
	}
	
}