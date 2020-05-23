#ifndef _BLOCK_H_
#define _BLOCK_H_

#include "core/carray.h"
#include "core/string_common.h"

#include "area.h"
#include "game_util.h"
#include "game_struct.h"
#include "server_define.h"

class CRoleBase;

typedef struct _BlockRect
{
	TAxisPos_t		startW;
	TAxisPos_t		startH;
	TAxisPos_t		endW;
	TAxisPos_t		endH;

	_BlockRect( )
	{
		cleanUp( ) ;
	}

	void cleanUp( )
	{
		startW = 0 ;
		startH =0 ;
		endW =0 ;
		endH=0 ;
	}

	bool isContain( TAxisPos_t x, TAxisPos_t y ) const
	{
		if ( x < startW || x > endW || y < startH || y > endH )
		{
			return false;
		}
		else
		{
			return true;
		}
	}
}TBlockRect;

typedef struct _AxisRect
{
	TAxisPos top;
	TAxisPos bottom;
	_AxisRect( )
	{
		cleanUp( ) ;
	}

	void cleanUp( )
	{
		top.cleanUp();
		bottom.cleanUp();
	}
}TAxisRect;


typedef struct _BlockInfo
{
	TAxisPos_t	blockWidth;         // 整个地图的宽度块个数
	TAxisPos_t	blockHeight;        // 整个地图的高度块个数
	TBlockID_t	blockSize;          // 整个地图的块总个数blockWidth*blockHeight

public:
	bool isValidBlockID(TBlockID_t blockID) const
	{
		return blockID != INVALID_BLOCK_ID && blockID <= blockSize;
	}

	TBlockID_t getBlockID(TAxisPos_t w, TAxisPos_t h) const
	{
		if(w < 0 || h < 0)
		{
			return INVALID_BLOCK_ID;
		}

		return w+h*blockWidth;
	}

	TBlockID_t getBlockIDByAxis(TAxisPos_t x, TAxisPos_t y) const;

	DObjToString3Alias(TBlockInfo, TAxisPos_t, BlockWidth, blockWidth, TAxisPos_t, BlockHeight, blockHeight, TBlockID_t, BlockSize, blockSize);
}TBlockInfo;

class CGameObject;

typedef struct _ObjListNode
{
	CGameObject*  node ;
	_ObjListNode* next ;
	_ObjListNode* prev ;

	_ObjListNode( )
	{
		node = NULL ;
		next = NULL ;
		prev = NULL ;
	}

	_ObjListNode( CGameObject* pNode )
	{
		node = pNode ;
		next = NULL ;
		prev = NULL ;
	}

	void setObj(CGameObject* pObj)
	{
		node = pObj;
		next = NULL ;
		prev = NULL ;
	}

	void cleanUp()
	{
		node = NULL ;
		next = NULL ;
		prev = NULL ;
	}

}TObjListNode;

class CObjList
{
private:
	_ObjListNode    _head;
	_ObjListNode    _tail;
	sint32          _size;
	EObjType        _objType;

public:
	CObjList(EObjType objType)
	{
		cleanUp();
		_objType = objType;
	}

	virtual ~CObjList()
	{
	}

	TObjListNode* getHead()
	{
		return &_head;
	}
	TObjListNode* getTail()
	{
		return &_tail;
	}

	void cleanUp( )
	{
		_size = 0 ;
		_head.next = &_tail;
		_head.prev = &_head;
		_tail.next = &_tail;
		_tail.prev = &_head;
	}

	bool addNode(_ObjListNode* pNode)
	{
		gxAssert( pNode->prev == NULL );
		gxAssert( pNode->next == NULL );
		gxAssert( pNode->node != NULL );

		pNode->next = &_tail;
		pNode->prev = _tail.prev;
		_tail.prev->next = pNode;
		_tail.prev = pNode;

		_size++;

		return true;
	}

	bool deleteNode(_ObjListNode* pNode)
	{
		gxAssert( pNode->prev != NULL );
		gxAssert( pNode->next != NULL );
		gxAssert( pNode->node != NULL );

		_ObjListNode* pPoint = _head.next;
		while(pPoint != (&_tail))
		{
			if(pPoint == pNode)
			{
				pPoint->prev->next = pPoint->next;
				pPoint->next->prev = pPoint->prev;
				pPoint->next = NULL;
				pPoint->prev = NULL;

				_size--;
				return true;
			}
			else
			{
				pPoint = pPoint->next;
			}
		}

		gxAssert(false) ;

		return true;
	}

	template<typename T>
	void getObjectList(T& t)
	{
		sint32 count = 0;
		TObjListNode* pPoint = _head.next;
		while(pPoint != (&_tail) && NULL != pPoint)
		{
			if(NULL != pPoint->node)
			{
				t.push_back(pPoint->node);
			}
			else
			{
				gxError("Invalid object!");
				//                break;
			}

			pPoint = pPoint->next ;
			count++;
			if(count > 1024)
			{
				count = 0;
				gxError("Endless loop!");
			}
		}
	}

	template<typename T>
	void getRoleList(T& t)
	{
		if(_objType == OBJ_TYPE_ROLE)
		{
			sint32 count = 0;
			TObjListNode* pPoint = _head.next;
			while(pPoint != (&_tail) &&  NULL != pPoint)
			{
				CRoleBase* pRole = (CRoleBase*)(pPoint->node);
				if(NULL != pRole)
				{
					t.push_back(pRole);
				}
				else
				{
					gxError("Invalid role!");
				}

				pPoint = pPoint->next ;

				count++;
				if(count > 1024)
				{
					count = 0;
					gxError("Endless loop!");
				}
			}
		}
	}

	sint32 getSize()
	{
		return _size;
	}
};

typedef std::vector<CArea*> TBlockAreaList;

class CBlock
{
public:
	CBlock();
	~CBlock();

	void cleanUp();

public:
	void setBlockID( TBlockID_t id )
	{
		_blockID = id;
	}

	TBlockID_t getBlockID( )
	{
		return _blockID;
	}

	CObjList* getObjList( void )
	{
		return &_objList;
	}

	CObjList* getRoleList( void )
	{
		return &_roleList;
	}

	bool hasRole();

	template<typename T>
	void getRoleList(T& t)
	{
		_roleList.getRoleList(t);
	}

	void onObjectEnter( CGameObject *pObj );
	void onObjectLeave( CGameObject *pObj );

	void addArea(CArea* area);

	const TAxisPos& getTop() const
	{
		return _top;
	}

	void calcAxisPos(const TBlockInfo* blockInfo);

	const TAxisPos getBottom() const
	{
		return _bottom;
	}

	const CArea* getCurrentArea( const TAxisPos& axisPos ) const;
	uint32 getAreaCount() { return (uint32)_areaList.size(); }

protected:
	CObjList				_roleList;      // 角色列表
	CObjList				_objList;		// 包含_roleList中的所有内容
	TBlockID_t			    _blockID;       // 块ID
	TBlockAreaList          _areaList;      // 事件列表
	TAxisPos				_top;			// 左上角坐标
	TAxisPos				_bottom;		// 右下角坐标
};

typedef std::vector<CBlock> TBlockList;
typedef std::vector<TBlockID_t> TBlockIDList;

#endif	// _BLOCK_H_