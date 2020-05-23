#include "object.h"
#include "game_util.h"
#include "map_scene_base.h"
#include "role_base.h"

CGameObject::CGameObject()
{
	cleanUp();
	_objUID = INVALID_OBJ_UID;
}

CGameObject::~CGameObject()
{
	cleanUp();
	_objUID = INVALID_OBJ_UID;
}

bool CGameObject::updateBlock()
{
	if ( getScene() == NULL )
	{
		return false;
	}

	TBlockID_t idNew = getScene()->calcBlockID( getAxisPos() );
	TBlockID_t idOld = _blockID;
	if ( idNew != idOld )
	{
		if ( isActive() )
		{
			if ( idNew != INVALID_BLOCK_ID )
			{
				_blockID = idNew;
				if ( idOld != INVALID_BLOCK_ID )
				{
					getScene()->objBlockChanged( this, idNew, idOld );
				}
				else
				{
					getScene()->objBlockRegister( this, _blockID );
					onRegisterToBlock();
				}
			}
		}
	}

	return true;
}

bool CGameObject::isInValidRadius(TMapID_t mapID, TAxisPos_t x1, TAxisPos_t y1, TAxisPos_t x2, TAxisPos_t y2, uint8 range)
{
	if(getMapID() != mapID)
	{
		return false;
	}

	return CGameObject::IsInValidRadius(x1, y1, x2, y2, range);
}

bool CGameObject::IsInValidRadius(TAxisPos_t x1, TAxisPos_t y1, TAxisPos_t x2, TAxisPos_t y2, uint8 range)
{
	TAxisPos_t x, y;

	x = x1 - x2;
	y = y1 - y2;

	uint8 radius = GXMISC::gxDouble2Int<uint8>(std::sqrt(((double)(x*x) + y*y)));
	return range >= radius ;
}

bool CGameObject::isInValidRadius(const CGameObject *pObj, uint8 range)
{
	TAxisPos pos = *(((CGameObject*)pObj)->getAxisPos());
	return isInValidRadius(pObj->getMapID(), &pos, range);
}

bool CGameObject::isInValidRadius(TMapID_t mapID, const TAxisPos* pos, uint8 range)
{
	return isInValidRadius(mapID, _axisPos.x, _axisPos.y, pos->x, pos->y, range);
}

bool CGameObject::init( const TObjInit* inits )
{
	_axisPos = inits->axisPos;
	_dir = inits->dir;
	_objType = inits->type;
	_objUID = inits->objUID;
	_objGUID = inits->objGUID;
	_mapID = inits->mapID;
	_objNode.setObj(this);
	_active = false;

	if(isNeedUpdateBlock())
	{
		updateBlock();
	}

	return true;
}

bool CGameObject::update( uint32 diff/*=0 */ )
{
	if(isNeedUpdateBlock())
	{
		updateBlock();
	}

	return true;
}

void CGameObject::cleanUp()
{
	_objGUID = INVALID_OBJ_GUID;	// 对象GUID
	_objType = INVALID_OBJ_TYPE;	// 对象类型
	_objNode.cleanUp();				// 在block中的存储结点   
	setBlockID(INVALID_BLOCK_ID);
	_active = false;;				// 是否活动的
	_axisPos.cleanUp();				// 坐标位置
	_dir = DIR_3;					// 方向
	_scene = NULL;					// 场景
	_sceneID = INVALID_SCENE_ID;	// 场景ID
	_mapID = INVALID_MAP_ID;		// 地图ID
}

void CGameObject::onEnterScene( CMapSceneBase* pScene )
{
	if(_objNode.next != NULL || _objNode.prev != NULL)
	{
		gxError("ObjEnter scene, objnode is invalid!{0}", toString());
	}

	_objNode.setObj(this);
	setActive(true);
	setScene(pScene);
	setMapID(pScene->getMapID());
	setSceneID(pScene->getSceneID());
	if(isNeedUpdateBlock())
	{
		updateBlock();
	}
}

void CGameObject::onLeaveScene( CMapSceneBase* pScene )
{
	getScene()->clearBlock(&_axisPos);
	getScene()->objBlockUnregister( this, _blockID );
	setScene(NULL);
	setBlockID(INVALID_BLOCK_ID);
	_sceneID = INVALID_SCENE_ID;
	setActive(false);
	if(_objNode.next != NULL || _objNode.prev != NULL)
	{
		gxError("Obj leave scene, objnode is invalid!{0}", toString());
	}
}

void CGameObject::onRegisterToBlock( void )
{
}

void CGameObject::onUnregisterFromBlock( void )
{
}


void CGameObject::setRoleAttr( EObjType objType )
{
	_objType = objType;
}

void CGameObject::setMonsterAttr( EObjType objType )
{

}

void CGameObject::setPetAttr( EObjType objType )
{

}

bool CGameObject::IsCharacter(const CGameObject* pObj)
{
	switch(pObj->getObjType())
	{
	case OBJ_TYPE_ROLE:
	case OBJ_TYPE_MONSTER:
	case OBJ_TYPE_NPC:
	case OBJ_TYPE_PET:
		{
			return true;
		};
	default:
		{
			return false;
		}
	}
}

bool CGameObject::IsDynamic( const CGameObject* pObj )
{
	return true;
}

const char* CGameObject::ObjTypeToStr( EObjType objType )
{
	switch(objType)
	{
	case OBJ_TYPE_ROLE:                 // 角色
		return "Role";
	case OBJ_TYPE_MONSTER:              // 怪物
		return "Monster";
	case OBJ_TYPE_PET:				    // 宠物
		return "Pet";
	case OBJ_TYPE_NPC:				    // NPC
		return "Npc";
	default:
		{
			return "";
		}
	}

	return "";
}

CRoleBase* CGameObject::toRoleBase()
{
	if(isRole())
	{
		return dynamic_cast<CRoleBase*>(this);
	}

	return NULL;
}

const CRoleBase* CGameObject::toRoleBase() const
{
	if(isRole())
	{
		return dynamic_cast<const CRoleBase*>(this);
	}

	return NULL;
}

CCharacterObject* CGameObject::toCharacter()
{
	if(isCharacter())
	{
		return dynamic_cast<CCharacterObject*>(this);
	}

	return NULL;
}

bool CGameObject::isCanLeaveScene()
{
	return isRole() || !isActive();
}

bool CGameObject::isCanUpdateLeaveScene()
{
	return !isRole() && !isActive();
}

const char* CGameObject::toString() const
{
	return _strName.c_str();
}

void CGameObject::genStrName()
{
	_strName = GXMISC::gxToString("ObjUID=%u,ObjType=%s,SceneID=%"I64_FMT"u,MapID=%u", getObjUID(), CGameObject::ObjTypeToStr(getObjType()), getSceneID(), getMapID());
}

void CGameObject::setAxisPos( const TAxisPos* pos )
{
	_dir = CGameMisc::GetDir(_axisPos, *pos);
	if(_axisPos.isValid() && getScene() != NULL)
	{
		getScene()->clearBlock(&_axisPos); 
	}
	_axisPos = *pos;
	if(getScene() != NULL)
	{
		getScene()->setBlock(&_axisPos);
	}
}

bool CGameObject::isNeedUpdateBlock()
{
	return false;
}

void CGameObject::leaveBlock()
{
	if(NULL != getScene())
	{
		getScene()->leaveBlock(this);
	}
}

const std::string CGameObject::getObjString() const
{
	return _strName + _axisPos.toString();
}

void CGameObject::setSceneID( TSceneID_t sceneID )
{
	_sceneID = sceneID;
}