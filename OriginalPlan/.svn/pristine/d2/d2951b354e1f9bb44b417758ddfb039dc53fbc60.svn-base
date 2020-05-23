#include "ai_avoid_overlap.h"


template<typename T>
void CMapSceneBase::getRoleList( CBlock* pBlock, T& roleList, TObjUID_t exceptObjUID )
{
	if(exceptObjUID == INVALID_OBJ_UID)
	{
		pBlock->getRoleList(roleList);
	}
	else
	{
		// ÆÕÍ¨Íæ¼Ò
		CObjList* pList = pBlock->getRoleList();
		TObjListNode* pPoint = pList->getHead()->next;
		while(NULL != pPoint && pPoint != pList->getTail())
		{
			CRoleBase* pObj = pPoint->node->toRoleBase();
			pPoint = pPoint->next ;

			if( pObj==NULL )
			{
				gxAssert( false ) ;
				continue ;
			}

			if( pObj->getObjUID() == exceptObjUID )
			{
				continue ;
			}

			roleList.push_back(pObj);
		}
	}
}

template<typename T>
bool CMapSceneBase::broadCast( T& packet, TBlockID_t blockID, sint32 range )
{
	if ( blockID == INVALID_BLOCK_ID )
	{
		gxWarning("Invalid blockID!");
		return false;
	}


	TBlockRect rc ;
	getRectInRange( &rc, range, blockID );

	for(TAxisPos_t h = rc.startH; h <= rc.endH; h++)
	{
		for(TAxisPos_t w = rc.startW; w <= rc.endW; w++)
		{
			TBlockID_t bid = _blockInfo.getBlockID(w, h);
			TScanRoleBaseList roleList;
			getRoleList(&_blockList[bid], roleList, INVALID_OBJ_UID);
			sendPacket(packet, roleList);
		}
	}

	return true ;
}

template<typename T>
bool CMapSceneBase::broadCast( T& packet, CCharacterObject* pCharacter, bool sendMe/*=false */, sint32 range/*=2*/ )
{
	if( pCharacter==NULL || !pCharacter->isActive())
	{
		return false ;
	}

	if ( pCharacter->getBlockID() == INVALID_BLOCK_ID )
	{
		gxWarning("Invalid block id!");
		return false;
	}

	TBlockRect rc ;
	getRectInRange( &rc, range, pCharacter->getBlockID() ) ;

	for(TAxisPos_t h = rc.startH; h <= rc.endH; h++)
	{
		for(TAxisPos_t w = rc.startW; w <= rc.endW; w++)
		{
			TBlockID_t bid = w+h*_blockInfo.blockWidth;
			TScanRoleBaseList roleList;
			getRoleList(&_blockList[bid], roleList, sendMe? INVALID_OBJ_UID : pCharacter->getObjUID());
			sendPacket(packet, roleList);
		}
	}

	return true;
}

template<typename T>
static void SendPacket(CGameObject*& obj, void* arg)
{
	CRoleBase* role = obj->toRoleBase();
	if(NULL != role)
	{

		T* temp = (T*)arg;
		role->sendPacket(*temp);
	}
}
template<typename T>
bool CMapSceneBase::broadCastScene( T& packet )
{
	_roleMgr.traverse(&SendPacket<T>, &packet);
	return true;
}

template<typename T>
bool CMapSceneBase::broadCastSceneChat( T& packet )
{
	GXMISC::TSockIndexAry socks;
	getAllRoleSocketIndex(&socks);
	if(CMapWorldServerHandlerBase::IsActive() && !socks.empty())
	{
		CMapWorldServerHandlerBase::WorldServerHandler->broadMsg(packet, socks);
	}

	return true;
}

template<typename T>
bool CMapSceneBase::sendPacket( T& packet, TScanRoleBaseList& roleList )
{
	for ( uint32 i = 0; i < roleList.size(); i++ )
	{
		CRoleBase* pRole = roleList[i];
		if( pRole == NULL )
		{
			gxAssert(pRole != NULL);
			continue;
		}
		pRole->sendPacket(packet);
	}

	return true;
}
