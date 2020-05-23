#include "game_config.h"
#include "game_struct.h"

#include "block.h"
#include "object.h"
#include "role_base.h"

CBlock::CBlock() : _roleList(OBJ_TYPE_ROLE), _objList(INVALID_OBJ_TYPE)
{
	cleanUp();
}

CBlock::~CBlock()
{
}

void CBlock::cleanUp()
{
	_roleList.cleanUp() ;
	_objList.cleanUp() ;
}

void CBlock::onObjectEnter( CGameObject *pObj )
{
	EObjType objType = pObj->getObjType();

	switch(objType)
	{
	case OBJ_TYPE_ROLE:
		{
			CRoleBase* pRole = (CRoleBase*)pObj;
			_roleList.addNode( pRole->getRoleNode() );
		}break;
	default:
		{
		}
	}

	switch ( objType )
	{
	case OBJ_TYPE_ROLE:
	case OBJ_TYPE_MONSTER:
	case OBJ_TYPE_NPC:
	case OBJ_TYPE_PET:
		{
			_objList.addNode( pObj->getObjNode() );
		}break;
	default:
		{
			gxError("Unknow obj type! {0}", pObj->toString());
			gxAssertEx( false, "Unknow obj type! {0}", pObj->toString() );
			break;
		}
	}
}

void CBlock::onObjectLeave( CGameObject *pObj )
{
	EObjType eObjType = pObj->getObjType();

	switch(eObjType)
	{
	case OBJ_TYPE_ROLE:
		{
			CRoleBase* pRole = (CRoleBase*)pObj;
			_roleList.deleteNode( pRole->getRoleNode() );
			pRole->getRoleNode()->cleanUp();
			pRole->getRoleNode()->node = pRole;
		}break;
	default:
		{

		}
	}

	switch ( eObjType )
	{
	case OBJ_TYPE_ROLE:
	case OBJ_TYPE_MONSTER:
	case OBJ_TYPE_NPC:
	case OBJ_TYPE_PET:
		{
			_objList.deleteNode( pObj->getObjNode() );
			pObj->getObjNode()->cleanUp();
			pObj->getObjNode()->node = pObj;
		}
		break;
	default:
		{
			gxError("Unknow obj type! {0}", pObj->toString());
			gxAssertEx( false, "Unknow obj type! {0}", pObj->toString() );
			break;
		}
	}
}

const CArea* CBlock::getCurrentArea( const TAxisPos& axisPos ) const
{
	TAxisPos_t x, y;
	x = axisPos.x;
	y = axisPos.y;

	for( uint32 i = 0; i < _areaList.size(); ++i )
	{
		if( _areaList[i] != NULL && _areaList[i]->isContain(x, y) )
		{
			return _areaList[i];
		}
	}

	return NULL;
}

void CBlock::addArea( CArea* area )
{
	if( _areaList.size() >= MAX_AREA_IN_BLOCK )
	{
		gxAssertEx(false, "too many area!");
		return;
	}

	_areaList.push_back(area);
}

void CBlock::calcAxisPos( const TBlockInfo* blockInfo )
{
	TAxisPos_t h = _blockID/blockInfo->blockWidth;
	TAxisPos_t w = _blockID%blockInfo->blockWidth;

	_top.x = w*g_GameConfig.blockSize;
	_top.y = h*g_GameConfig.blockSize;
	_bottom.x = (w+1)*g_GameConfig.blockSize;
	_bottom.y = (h+1)*g_GameConfig.blockSize;
}

bool CBlock::hasRole()
{
	return _roleList.getSize() > 0;
}

TBlockID_t _BlockInfo::getBlockIDByAxis(TAxisPos_t x, TAxisPos_t y) const
{
	return getBlockID(x/g_GameConfig.blockSize, y/g_GameConfig.blockSize);
}