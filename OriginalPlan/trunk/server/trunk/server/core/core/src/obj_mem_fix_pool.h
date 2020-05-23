#ifndef _OBJ_MEM_FIX_POOL_H_
#define _OBJ_MEM_FIX_POOL_H_

#include <limits>

#include "types_def.h"
#include "debug.h"
#include "hash_util.h"

namespace GXMISC
{
#pragma pack(push, 1)
    typedef uint32 ObjPoolID_t ;
    const uint32 INVALID_POOL_ID = std::numeric_limits<ObjPoolID_t>::max();
    const uint32 NEW_POOL_ID = 0x1fffffff;
    // 固定大小的对象池, flag表示将对象返回到池中时是否重新构造
    template<class T, bool flag = true>
    class CFixObjPool
    {
#pragma pack(push, 1)
		struct PoolNode
		{
			ObjPoolID_t id;
			T           obj;
		};
#pragma pack(pop)

	public:
		CFixObjPool( void )
		{
			_ObjList	    = NULL;
			_maxCount		= -1;
			_position		= -1;
		}

        ~CFixObjPool( void )
        {
            term() ;
        }

        bool init( sint32 nMaxCount, bool minFlag = true )
        {
            gxAssert( nMaxCount > 0 );
            if ( nMaxCount <= 0 )
            {
                return false;
            }

			if(minFlag)
			{
				nMaxCount = 1;
			}

            _maxCount		= nMaxCount;
            _position		= 0;
            _ObjList	= new PoolNode* [_maxCount];

            sint32 i;
            for( i = 0; i < _maxCount; i++ )
            {
                _ObjList[i] = new PoolNode;
                if ( _ObjList[i] == NULL )
                {
                    gxAssert( _ObjList[i] != NULL );
                    return false;
                }
                _ObjList[i]->id = INVALID_POOL_ID;
            }

            return true;
        }

        void term( void )
        {
            if ( _ObjList != NULL )
            {
                sint32 i;
                for ( i = 0; i < _maxCount; i++ )
                {
                    DSafeDelete( _ObjList[i] );
                }

                DSafeDeleteArray(_ObjList);
                _ObjList = NULL;
            }

            _maxCount		= -1;
            _position		= -1;
        }

        T* newObj( void )
        {
            gxAssert(_maxCount > 0);
            //            gxAssert( _position < _maxCount );
            if ( _position >= _maxCount )
            {
                PoolNode *pObj = new PoolNode;
                if(NULL == pObj)
                {
                    return NULL;
                }

				pObj->id = NEW_POOL_ID;
				return &(pObj->obj);
            }

            PoolNode *pObj = _ObjList[_position];
            gxAssert(pObj->id == INVALID_POOL_ID);
            pObj->id = (ObjPoolID_t)_position;
            _position++;
            return &(pObj->obj);
        }

        void deleteObj( T *pObj )
        {
            gxAssert( pObj != NULL );	
            if ( pObj == NULL )
            {
                return ;
            }

            gxAssert( _position >= 0 );	
            if ( _position < 0 )
            {
                return ;
			}
			sint32 offsetLen = offsetof(PoolNode, obj);
			PoolNode* pNode = (PoolNode*)(((const char*)pObj)-offsetLen);
			uint32 uDelIndex = pNode->id;
			if (uDelIndex >= (uint32)_position)
			{
				if(uDelIndex == NEW_POOL_ID)
				{
					delete pNode;
					return;
				}
				return ;
			}

			gxAssert(uDelIndex < (uint32)_position );

			_position--;
			PoolNode *pDelObj           = _ObjList[uDelIndex];
			_ObjList[uDelIndex]	        = _ObjList[_position];
			_ObjList[_position]	        = pDelObj;
			_ObjList[uDelIndex]->id     = uDelIndex;
			_ObjList[_position]->id     = INVALID_POOL_ID;

            if(flag)
            {
                gxContReset(_ObjList[_position]->obj);
            }
        }

        sint32 getCount( void )const
        {
            return _position;
        }

    private:
        PoolNode        **_ObjList;
        sint32          _maxCount;
        sint32          _position;
    };

#pragma pack(pop)
}

#endif