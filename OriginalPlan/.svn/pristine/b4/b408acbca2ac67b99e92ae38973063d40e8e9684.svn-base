#include "core/game_exception.h"

#include "object.h"
#include "role_base.h"
#include "module_def.h"
#include "game_config.h"
#include "map_scene_base.h"
#include "ai_avoid_overlap.h"
#include "packet_cm_base.h"
#include "map_server_util.h"

bool CMapSceneBase::isBlockDirty( TBlockID_t blockID )
{
	if(!checkBlockID(blockID) || blockID > (TBlockID_t)_blockDirty.size())
	{
		return true;
	}

	return _blockDirty.get(blockID);
}

bool CMapSceneBase::findEmptyPos( TAxisPos* pos, TRange_t range )
{
	TAxisPos top;
	TAxisPos bottom;

	top.x = pos->x-range;
	top.y = pos->y - range;
	bottom.x = pos->x + range;
	bottom.y = pos->y + range;
	getMapData()->verifyPos(&top);
	getMapData()->verifyPos(&bottom);

	TAxisPos destPos;
	if(findEmptyPos(&top, &bottom, &destPos))
	{
		pos->x = destPos.x;
		pos->y = destPos.y;
		return true;
	}

	return false;
}

bool CMapSceneBase::findEmptyPos( TAxisPos* pos, TRange_t range, bool cycle )
{
	if(cycle)
	{
		if(range > (MAX_ATTACK_RANGE-1))
		{
			range = (MAX_ATTACK_RANGE-1);
		}

		for(sint32 i = 1; i <= range; ++i)
		{
			for(sint32 j = NightGridAdjust[i][0]; j <= NightGridAdjust[i][1]; ++j)
			{
				TAxisPos tempPos = *pos;
				tempPos += NightGrid[j];
				if(!checkBlock(&tempPos))
				{
					pos->x = tempPos.x;
					pos->y = tempPos.y;
					return true;
				}
			}
		}

		return false;
	}
	else
	{
		return findEmptyPos(pos, range);
	}
}

bool CMapSceneBase::findEmptyPos( TAxisPos* top, TAxisPos* bottom, TAxisPos* pos )
{
	getMapData()->verifyPos(top);
	getMapData()->verifyPos(bottom);

	gxAssert(top->x <= bottom->x);
	gxAssert(top->y <= bottom->y);

	TAxisPos_t minY;
	TAxisPos_t maxY;
	TAxisPos_t minX;
	TAxisPos_t maxX;

	minX = std::min(top->x, bottom->x);
	maxX = std::max(top->x, bottom->x);
	minY = std::min(top->y, bottom->y);
	maxY = std::max(top->y, bottom->y);

	for(TAxisPos_t y = minY; y <= maxY; ++y)
	{
		for(TAxisPos_t x = minX; x <= maxX; ++x)
		{
			TAxisPos tempPos;
			tempPos.x = x;
			tempPos.y = y;
			if(!checkBlock(&tempPos))
			{
				pos->x = x;
				pos->y = y;
				return true;
			}
		}
	}

	return false;
}

bool CMapSceneBase::findRandEmptyPos( TAxisPos* pos, TRange_t range )
{
	TAxisPos top;
	TAxisPos bottom;

	top.x = pos->x - range;
	top.y = pos->y - range;
	bottom.x = pos->x + range;
	bottom.y = pos->y + range;
	getMapData()->verifyPos(&top);
	getMapData()->verifyPos(&bottom);

	TAxisPos destRandPos;
	if(findRandEmptyPos(&top, &bottom, &destRandPos))
	{
		pos->x = destRandPos.x;
		pos->y = destRandPos.y;
		return true;
	}

	return false;
}

bool CMapSceneBase::findRandEmptyPos( TAxisPos* top, TAxisPos* bottom, TAxisPos* pos )
{
	getMapData()->verifyPos(top);
	getMapData()->verifyPos(bottom);

	TAxisPos destRandPos;
	for(uint32 i = 0; i < MAX_RAND_POS_NUM; ++i)
	{
		randPos(top, bottom, &destRandPos);
		if(!checkBlock(&destRandPos))
		{
			pos->x = destRandPos.x;
			pos->y = destRandPos.y;
			return true;
		}
	}

	destRandPos.cleanUp();
	destRandPos = *pos;

	if(findEmptyPos(top, bottom, &destRandPos))
	{
		pos->x = destRandPos.x;
		pos->y = destRandPos.y;
		return true;
	}

	return false;
}

bool CMapSceneBase::findRandPos( TAxisPos* pos, TRange_t range )
{
	TAxisPos top;
	TAxisPos bottom;

	top.x = pos->x - range;
	top.y = pos->y - range;
	bottom.x = pos->x + range;
	bottom.y = pos->y + range;
	getMapData()->verifyPos(&top);
	getMapData()->verifyPos(&bottom);

	TAxisPos destRandPos;
	randPos(&top, &bottom, &destRandPos);
	pos->x = destRandPos.x;
	pos->y = destRandPos.y;

	return true;
}

void CMapSceneBase::randStepPos( TListPos* poss, TAxisPos* srcPos, TRange_t nRange, uint32 maxSteps /*= 0*/ )
{
	std::set<uint64> sets;

	if(maxSteps == 0)
	{
		maxSteps = nRange*nRange;
	}

	TAxisPos lastPos = *srcPos;
	for(uint32 i = 0; i < maxSteps; ++i)
	{
		sint32 xInc = DRandGen.randUInt()%2;
		sint32 yInc = DRandGen.randUInt()%2;
		if(DRandGen.randBool())
		{
			xInc = 0-xInc;
		}
		if(DRandGen.randBool())
		{
			yInc = 0-yInc;
		}

		TAxisPos tempPos = lastPos;
		tempPos.x += xInc;
		tempPos.y += yInc;

		getMapData()->verifyPos(srcPos, nRange, &tempPos);
		if(checkBlock(&tempPos))
		{
			continue;
		}

		uint64 id = tempPos.toSinglePos();
		if(sets.find(id) != sets.end())
		{
			continue;
		}

		poss->push_back(tempPos);
		sets.insert(id);

		lastPos = tempPos;
	}
}

void CMapSceneBase::randPos( const TAxisPos* top, const TAxisPos* buttom, TAxisPos* randP )
{
	TAxisPos tempTop = *top;
	TAxisPos tempButtom = *buttom;
	getMapData()->findRandEmptyPos(&tempTop, &tempButtom, randP);
}

bool CMapSceneBase::isLineEmpty( const TAxisPos* srcPos, const TAxisPos* destPos )
{
	if(srcPos == destPos)
	{
		return true;
	}

	TAxisPos_t x0 = srcPos->x;
	TAxisPos_t x1 = destPos->x;
	TAxisPos_t y0 = srcPos->y;
	TAxisPos_t y1 = destPos->y;
	double x,y;
	double d,k;	

	if(fabs(float(x0-x1))<1e-6)
	{
		if(y0>y1)
		{
			std::swap(x0, x1);
			std::swap(y0, y1);
		}
		x=x0;y=y0;
		for(y=y0; y<y1;y++)
		{
			TAxisPos_t tempX = (TAxisPos_t)DRound(x);
			TAxisPos_t tempY = (TAxisPos_t)DRound(y);
			if(checkBlock(tempX, tempY))
			{
				return false;
			}
		}

		return true;
	}

	k=(y1-y0)/(x1-x0);
	if(0<=k && k<=1)
	{
		if(x0>x1)
		{
			std::swap(x0, x1);
			std::swap(y0, y1);
		}
		x=x0;y=y0;
		d=0.5-k;

		for(x=x0;x<=x1;x++)
		{
			TAxisPos_t tempX = (TAxisPos_t)DRound(x);
			TAxisPos_t tempY = (TAxisPos_t)DRound(y);
			if(checkBlock(tempX, tempY))
			{
				return false;
			}
			if(d<0)
			{
				y++;
				d+=1-k;
			}
			else 
			{
				d-=k;
			}
		}
	}
	if(k>1)
	{
		if(y0>y1)
		{
			std::swap(x0, x1);
			std::swap(y0, y1);
		}
		x=x0;y=y0;
		d=1-0.5*k;

		for(y=y0;y<=y1;y++)
		{
			TAxisPos_t tempX = (TAxisPos_t)DRound(x);
			TAxisPos_t tempY = (TAxisPos_t)DRound(y);
			if(checkBlock(tempX, tempY))
			{
				return false;
			}
			if(d>=0)
			{
				x++;
				d += 1-k;
			}
			else 
			{
				d += 1;
			}
		}
	}
	if(k<-1)
	{
		if(y0<y1)
		{
			std::swap(x0, x1);
			std::swap(y0, y1);
		}
		x=x0;y=y0;

		d=-1-0.5*k;

		for(y=y0;y>y1;y--)
		{
			TAxisPos_t tempX = (TAxisPos_t)DRound(x);
			TAxisPos_t tempY = (TAxisPos_t)DRound(y);
			if(checkBlock(tempX, tempY))
			{
				return false;
			}
			if(d<0)
			{
				x++;
				d-=1+k;
			}
			else 
			{
				d-=1;
			}
		}
	}
	if(-1<=k && k<0)
	{
		if(x0>x1)
		{
			std::swap(x0, x1);
			std::swap(y0, y1);
		}
		x=x0;y=y0;

		d=-0.5-k;

		for(x=x0;x<=x1;x++)
		{
			TAxisPos_t tempX = (TAxisPos_t)DRound(x);
			TAxisPos_t tempY = (TAxisPos_t)DRound(y);
			if(checkBlock(tempX, tempY))
			{
				return false;
			}
			if(d>0)
			{
				y--;
				d-=1+k;
			}
			else 
			{
				d-=k;
			}
		}
	}

	return true;
}

bool CMapSceneBase::getLineEmptyPos( const TAxisPos* srcPos, const TAxisPos* destPos, TAxisPos* targetPos )
{
	TRange_t range = std::max(abs(destPos->x - srcPos->x), abs(destPos->y - srcPos->y));
	return getLineEmptyPos(srcPos, destPos, range, targetPos);
}

bool CMapSceneBase::getLineEmptyPos( const TAxisPos* srcPos, const TAxisPos* destPos, TRange_t range, TAxisPos* targetPos )
{
	targetPos->x = srcPos->x;
	targetPos->y = srcPos->y;
	TAxisPos tempPos = *srcPos;

	if(srcPos == destPos)
	{
		targetPos->x = srcPos->x;
		targetPos->y = srcPos->y;
		return true;
	}

	TAxisPos_t x0 = srcPos->x;
	TAxisPos_t x1 = destPos->x;
	TAxisPos_t y0 = srcPos->y;
	TAxisPos_t y1 = destPos->y;
	double x,y;
	double d,k;	
	if(fabs(float(x0-x1))<1e-6)
	{
		if(y0>y1)
		{
			std::swap(x0, x1);
			std::swap(y0, y1);
		}
		x=x0;y=y0;
		for(y=y0+1; y<y1&&range>0;y++, range--)
		{
			TAxisPos_t tempX = (TAxisPos_t)DRound(x);
			TAxisPos_t tempY = (TAxisPos_t)DRound(y);
			if(!checkBlock(tempX, tempY))
			{
				targetPos->x = tempX;
				targetPos->y = tempY;
				return true;
			}
		}

		return false;
	}

	k=(y1-y0)/(x1-x0);
	if(0<=k && k<=1)
	{
		if(x0>x1)
		{
			x=x0;y=y0;
			d=0.5-k;

			for(x=x0-1;x>=x1&&range>0;x--,range--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(!checkBlock(tempX, tempY))
				{
					targetPos->x = tempX;
					targetPos->y = tempY;
					return true;
				}
				if(d<0)
				{
					y--;
					d+=1-k;
				}
				else 
				{
					d-=k;
				}
			}
		}
		else
		{
			x=x0;y=y0;
			d=0.5-k;

			for(x=x0+1;x<=x1&&range>0;x++,range--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(!checkBlock(tempX, tempY))
				{
					targetPos->x = tempX;
					targetPos->y = tempY;
					return true;
				}
				if(d<0)
				{
					y++;
					d+=1-k;
				}
				else 
				{
					d-=k;
				}
			}
		}
	}
	if(k>1)
	{
		if(y0>y1)
		{
			x=x0;y=y0;
			d=1-0.5*k;

			for(y=y0-1;y>=y1&&range>0;y--,range--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(!checkBlock(tempX, tempY))
				{
					targetPos->x = tempX;
					targetPos->y = tempY;
					return true;
				}
				if(d>=0)
				{
					x--;
					d += 1-k;
				}
				else 
				{
					d += 1;
				}
			}
		}
		else
		{
			x=x0;y=y0;
			d=1-0.5*k;

			for(y=y0+1;y<=y1&&range>0;y++,range--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(!checkBlock(tempX, tempY))
				{
					targetPos->x = tempX;
					targetPos->y = tempY;
					return true;
				}
				if(d>=0)
				{
					x++;
					d += 1-k;
				}
				else 
				{
					d += 1;
				}
			}
		}
	}
	if(k<-1)
	{
		if(y0 < y1)
		{
			x=x0;y=y0;
			d=-1-0.5*k;
			for(y=y0+1;y<=y1&&range>0;y++,range--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(!checkBlock(tempX, tempY))
				{
					targetPos->x = tempX;
					targetPos->y = tempY;
					return true;
				}
				if(d < 0)
				{
					x--;
					d -= 1+k;
				}
				else 
				{
					d -= 1;
				}
			}
		}
		else
		{
			x=x0;y=y0;
			d=-1-0.5*k;
			for(y=y0-1;y>y1&&range>0;y--,range--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(!checkBlock(tempX, tempY))
				{
					targetPos->x = tempX;
					targetPos->y = tempY;
					return true;
				}
				if(d<0)
				{
					x++;
					d-=1+k;
				}
				else 
				{
					d-=1;
				}
			}
		}
	}
	if(-1<=k && k<0)
	{
		if(x0>x1)
		{
			x=x0;y=y0;
			d=-0.5-k;
			for(x=x0-1;x>=x1&&range>0;x--,range--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(!checkBlock(tempX, tempY))
				{
					targetPos->x = tempX;
					targetPos->y = tempY;
					return true;
				}
				if(d>0)
				{
					y++;
					d-=1+k;
				}
				else 
				{
					d-=k;
				}
			}
		}
		else
		{
			x=x0;y=y0;

			d=-0.5-k;

			for(x=x0+1;x<=x1&&range>0;x++,range--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(!checkBlock(tempX, tempY))
				{
					targetPos->x = tempX;
					targetPos->y = tempY;
					return true;
				}
				if(d>0)
				{
					y--;
					d-=1+k;
				}
				else 
				{
					d-=k;
				}
			}
		}
	}

	return false;
}

const bool CMapSceneBase::checkBlock( const TAxisPos *pos,const sint8 block )
{
	if (posValidate(pos))
	{
		return checkBlock(pos->x, pos->y, block);
	}

	return true;
}

const bool CMapSceneBase::checkBlock( TAxisPos_t x, TAxisPos_t y, const sint8 block )
{
	if (getMapData()->isCanWalk(x,y))
	{
		return (0 != (_allTiles[y * getMapData()->getX() + x].flags & block));
	}

	return true;
}

const bool CMapSceneBase::checkBlock( TAxisPos_t x, TAxisPos_t y )
{
	return checkBlock(x, y, TILE_BLOCK | TILE_ENTRY_BLOCK);
}

const bool CMapSceneBase::checkBlock( const TAxisPos *pos )
{
	return checkBlock(pos, TILE_BLOCK | TILE_ENTRY_BLOCK); 
}

void CMapSceneBase::setBlock( const TAxisPos* pos, const sint8 block )
{
	if (posValidate(pos))
	{
		_allTiles[pos->y * getMapData()->getX() + pos->x].flags |= block;
	}
}

void CMapSceneBase::setBlock( const TAxisPos *pos, TRange_t range, const sint8 block )
{
	for (int x = pos->x; x < pos->x + range; x++)
	{
		for (int y = pos->y; y < pos->y + range; y++)
		{
			TAxisPos tempPos;
			tempPos.x = x;
			tempPos.y = y;
			if (posValidate(&tempPos))
				_allTiles[tempPos.y * getMapData()->getX() + tempPos.x].flags |= block;
		}
	}
}

void CMapSceneBase::setBlock( const TAxisPos *pos )
{
	setBlock(pos,TILE_ENTRY_BLOCK);
}

void CMapSceneBase::clearBlock( const TAxisPos *pos, const sint8 block )
{
	if (posValidate(pos))
		_allTiles[pos->y * getMapData()->getX() + pos->x].flags &= ~block;
}

void CMapSceneBase::clearBlock( const TAxisPos *pos )
{
	clearBlock(pos,TILE_ENTRY_BLOCK);
}

const bool CMapSceneBase::checkObjectBlock( const TAxisPos *pos )
{
	return checkBlock(pos,TILE_BLOCK | TILE_OBJECT_BLOCK);
}

void CMapSceneBase::setObjectBlock( const TAxisPos *pos )
{
	setBlock(pos,TILE_OBJECT_BLOCK);
}

void CMapSceneBase::clearObjectBlock( const TAxisPos *pos )
{
	clearBlock(pos,TILE_OBJECT_BLOCK);
}

const TTile* CMapSceneBase::getTile( const TAxisPos *pos )
{
	if (posValidate(pos))
	{
		return &_allTiles[pos->y * getMapData()->getX() + pos->x];
	}

	return NULL;
}

bool CMapSceneBase::init( CMapBase* data )
{
	_mapData = data;

	sint32 cx = (sint32)(_mapData->getX()/g_GameConfig.blockSize);
	sint32 cy = (sint32)(_mapData->getY()/g_GameConfig.blockSize);

	if( (sint32)_mapData->getX() / g_GameConfig.blockSize > 0 ){ cx ++;}
	if( (sint32)_mapData->getY() / g_GameConfig.blockSize > 0 ){ cy ++;}

	_blockInfo.blockSize = (uint32)(cx*cy) ;
	_blockInfo.blockWidth = (uint32)cx ;
	_blockInfo.blockHeight = (uint32)cy ;

	_blockList.resize(_blockInfo.blockSize);
	for( sint32 i=0; i < _blockInfo.blockSize; i++ )
	{
		_blockList[i].cleanUp();
		_blockList[i].setBlockID( (TBlockID_t)i ) ;
		_blockList[i].calcAxisPos(&_blockInfo);
	}
	_blockDirty.resize(_blockInfo.blockSize);
	_blockRoleNum = 0;

	if(!onInit())
	{
		return false;
	}

	_openTime = DTimeManager.nowSysTime();

	_mapID = data->getMapID();
	setSceneType((ESceneType)data->getMapType());
	gxDebug("Set scene type!!! SceneType = {0}, mapID = {1}", (uint32)_sceneType, _mapID);
	if ( !proInit(_mapID) )
	{
		gxError("Init sub class scene failed!!! mapID = {1}", _mapID);
		gxAssert(false);
		return false;
	}

	_allTiles.resize(_mapData->getY()*_mapData->getX());
	for(TAxisPos_t y = 0; y < _mapData->getY(); ++y)
	{
		for(TAxisPos_t x = 0; x < _mapData->getX(); ++x)
		{
			_allTiles[y*_mapData->getX()+x].flags = 0;
			if(!_mapData->isCanWalk(x, y))
			{
				_allTiles[y*_mapData->getX()+x].flags |= TILE_BLOCK;
			}
		}
	}

	if ( !isNormalScene() )
	{
		return true;
	}

	return true;
}

bool CMapSceneBase::load()
{
	FUNC_BEGIN(SCENE_MOD);

	return true;

	FUNC_END(false);
}

void CMapSceneBase::unload()
{
	FUNC_BEGIN(SCENE_MOD);

	//     for(CSceneRoleManager::Iterator iter = _roleMgr.begin(); iter != _roleMgr.end(); ++iter)
	//     {
	//         CRole* pRole = iter->second;
	//         pRole->setActive(false);
	// 
	//         if(!pRole->isCanLeaveScene())
	//         {
	//             gxError("Role can't leave scene! {0}", pRole->toString());
	//         }
	// 
	//         pRole->onLeaveScene(this);
	//         _objMgr.delObj(pRole->getObjUID());
	//          onRoleLeave(pRole);
	//     }

	FUNC_END(DRET_NULL);
}

bool CMapSceneBase::update( GXMISC::TDiffTime_t diff )
{
	if (_roleMgr.size() > 0)
	{
		// 场景中有人才更新
		signUpdateBlock(_blockRoleNum);
	}

	return proUpdate(diff);
}

void CMapSceneBase::cleanUp()
{
	_mapData = NULL;
	_objMgr.setScene(this);
	_roleMgr.setScene(this);
	_blockList.clear();	
	_sceneID = INVALID_SCENE_ID;
	_sceneType = SCENE_TYPE_INVALID;
	_mapID = INVALID_MAP_ID;
	_maxMonsterNum = 0;
	_openTime = GXMISC::MAX_GAME_TIME;
	_allTiles.clear();
	_blockDirty.clearAll();
	_blockRoleNum = 0;
	_ownerObjUID = INVALID_OBJ_UID;
	_blockInfo.blockSize = 0;
	_curGroupID = INVALID_SCENE_GROUP_ID;
	_maxRoleNumInGroup = 30;
	_maxRoleNum = 1000000;
}

bool CMapSceneBase::isDynamicScene()
{
	return !(_sceneType == SCENE_TYPE_NORMAL);
}

bool CMapSceneBase::isNormalScene()
{
	return !(isDynamicScene());
}

static bool ObjEnterView(MCEnterView& enterViewPack, CGameObject* pObj)
{
// 	if(enterViewPack.isMax(pObj->getObjType()))
// 	{
// 		gxError("Enter view is max!");
// 		return false;
// 	}
// 	enterViewPack.pushObjType(pObj->getObjType());
// 	uint16 shapeLen = pObj->getShapeData(enterViewPack.curData(), enterViewPack.getShapePackLen(pObj->getObjType()));
// 	enterViewPack.addLen(shapeLen);


	if (pObj->isRole())
	{
		if (enterViewPack.roleList.isMax())
		{
			return false;
		}

		pObj->getShapeData((char*)&(enterViewPack.roleList.addSize()), sizeof(TRoleDetail));
	}

	return true;
}

CMapBase* CMapSceneBase::getMapData()
{
	return _mapData;
}

const bool CMapSceneBase::posValidate( const TAxisPos *pos )
{
	return getMapData()->isCanWalk(pos->x, pos->y);
}

void CMapSceneBase::getRectInRange( TBlockRect* rect, sint8 range, TBlockID_t blockID )
{
	gxAssert( blockID != INVALID_BLOCK_ID ) ;
	if( !checkBlockID(blockID) )
	{
		return;
	}

	sint32 w = blockID%_blockInfo.blockWidth;
	sint32 h = blockID/_blockInfo.blockHeight;

	0 > range ? range=0 : range;

	rect->startW = (w - range) < 0 ? 0 : (w - range);
	rect->startH = (h - range) < 0 ? 0 : (h - range);
	rect->endW = (w + range) >= _blockInfo.blockWidth ? _blockInfo.blockWidth - 1 : (w + range);
	rect->endH = (h + range) >= _blockInfo.blockHeight ? _blockInfo.blockHeight - 1 : (h + range);
}

void CMapSceneBase::getBlocksInRange( TBlockIDList* ids, TRange_t range, TBlockID_t blockID, bool rectOrCurFlag )
{
	gxAssert( blockID != INVALID_BLOCK_ID ) ;
	if( !checkBlockID(blockID) )
	{
		return;
	}

	sint32 w = blockID%_blockInfo.blockWidth;
	sint32 h = blockID/_blockInfo.blockHeight;

	0 > range ? range=0 : range;

	if(rectOrCurFlag)
	{
		ids->push_back(blockID);
		for(TRange_t i = 1; i <= range; ++i)
		{
			TBlockID_t tempBlockID = INVALID_BLOCK_ID;
			for(sint32 j = NightGridAdjust[i][0]; j <= NightGridAdjust[i][1]; ++j)
			{
				tempBlockID = _blockInfo.getBlockID(w+NightGrid[j].x, h+NightGrid[j].y);
				if(checkBlockID(tempBlockID))
				{
					ids->push_back(tempBlockID);
				}
			}
		}
	}
	else
	{
		TAxisPos_t startW = (w-range) < 0 ? 0 : (w-range);
		TAxisPos_t startH = (h-range) < 0 ? 0 : (h-range);
		TAxisPos_t endW = (w+range) >= _blockInfo.blockWidth ? _blockInfo.blockWidth-1 : (w+range) ;
		TAxisPos_t endH = (h+range) >= _blockInfo.blockHeight ? _blockInfo.blockHeight-1 : (h+range);

		for ( TAxisPos_t h = startH; h <= endH; h++ )
		{
			for ( TAxisPos_t w = startW; w <= endW; w++ )
			{
				TBlockID_t bid = _blockInfo.getBlockID(w, h);
				if(checkBlockID(bid) && bid != blockID)
				{
					ids->push_back(bid);
				}
			}
		}
	}
}

bool CMapSceneBase::isInCurBlock( TBlockID_t blockID, TAxisPos* axisPos, uint8 range )
{
	if(!checkBlockID(blockID))
	{
		return false;
	}

	_mapData->verifyPos(axisPos);
	TAxisPos topPos = *axisPos;
	TAxisPos bottomPos = *axisPos;
	topPos -= (uint16)range;
	bottomPos += (uint16)range;
	_mapData->verifyPos(&topPos);
	_mapData->verifyPos(&bottomPos);
	return (calcBlockID(&topPos) == calcBlockID(&bottomPos)) == blockID;
}

uint8 CMapSceneBase::axisRange2BlockRange( const TAxisPos* axisPos, uint8 range )
{
	TBlockID_t blockID = calcBlockID(axisPos);
	if(!checkBlockID(blockID))
	{
		return 0;
	}

	TAxisPos topPos = *axisPos;
	TAxisPos bottomPos = *axisPos;
	topPos -= (uint16)range;
	bottomPos += (uint16)range;
	_mapData->verifyPos(&topPos);
	_mapData->verifyPos(&bottomPos);

	TBlockID_t topBlockID = calcBlockID(&topPos);
	TBlockID_t bottomBlockID = calcBlockID(&bottomPos);
	if(!checkBlockID(topBlockID) || !checkBlockID(bottomBlockID))
	{
		return 0;
	}

	return std::max(blockRangeInTwo(blockID, topBlockID), blockRangeInTwo(blockID, bottomBlockID));
}

uint8 CMapSceneBase::blockRangeInTwo( TBlockID_t blockID1, TBlockID_t blockID2 )
{
	if(blockID1 == blockID2)
	{
		return 0;
	}

	TAxisPos topBlock;
	TAxisPos bottomBlock;
	topBlock.x = blockID1%_blockInfo.blockWidth;
	topBlock.y = blockID1/_blockInfo.blockWidth;
	bottomBlock.x = blockID2%_blockInfo.blockWidth;
	bottomBlock.y = blockID2/_blockInfo.blockWidth;

	return GXMISC::gxDouble2Int<uint8>(std::max(abs((double)(bottomBlock.x-topBlock.x)), abs((double)(bottomBlock.y-topBlock.y))));
}

bool CMapSceneBase::checkBlockID( TBlockID_t blockID )
{
	if(blockID == INVALID_BLOCK_ID || blockID >= (TBlockID_t)_blockList.size())
	{
		return false;
	}

	return true;
}

CBlock* CMapSceneBase::getBlock( TBlockID_t blockID )
{
	if(blockID > (TBlockID_t)_blockList.size())
	{
		return NULL;
	}

	return &_blockList[blockID];
}

TBlockID_t CMapSceneBase::calcBlockID( const TAxisPos* pos )
{
	if (pos->x == INVALID_AXIS_POS || pos->y == INVALID_AXIS_POS)
	{
		gxAssertEx(false, "Invalid pos! {0}", pos->toString());
		return INVALID_BLOCK_ID;
	}

	TAxisPos_t w = (TAxisPos_t)(pos->x / g_GameConfig.blockSize);
	TAxisPos_t h = (TAxisPos_t)(pos->y / g_GameConfig.blockSize);

	return _blockInfo.getBlockID(w, h);
}

bool CMapSceneBase::isForceUpdateAllBlock()
{
	return false;
}

void CMapSceneBase::signUpdateBlock( sint32 roleBlockNum )
{
	bool noDirtyFlag = (roleBlockNum*100/_blockList.size() > 30);
	if(noDirtyFlag || isForceUpdateAllBlock())
	{
		_blockRoleNum = 0;
		// 设置所有的为脏
		_blockDirty.setAll();
		return;
	}
	else
	{
		// 动态设置脏点
		_blockDirty.clearAll();
	}

	_blockRoleNum = 0;
	TBlockIDList blockIDS;
	blockIDS.reserve(20);
	for(uint32 i = 0; i < _blockList.size(); ++i)
	{
		if(!_blockList[i].hasRole())
		{
			continue;
		}

		_blockRoleNum++;
		if(noDirtyFlag)
		{
			continue;
		}
		blockIDS.clear();
		getBlocksInRange(&blockIDS, g_GameConfig.broadcastRange, i, true);
		sint32 num = (sint32)blockIDS.size();
		for(sint32 i = 0; i < num; ++i)
		{
			_blockDirty.set(blockIDS[i]);
		}
	}
}

bool CMapSceneBase::scan( CScanOperator* pScan, bool flag )
{
	if( pScan == NULL )
	{
		gxWarning("Scan operator is null!");
		gxAssert( false );
		return false ;
	}

	if(pScan->getBlockID() >= (TBlockID_t)_blockList.size())
	{
		return false;
	}

	if( !pScan->onBeforeScan( ) )
	{
		return false ;
	}

	TBlockIDList blockIDs;
	getBlocksInRange(&blockIDs, pScan->getScanRange(), pScan->getBlockID(), flag);

	bool bNeedRet = false ;
	for(TBlockIDList::iterator iter = blockIDs.begin(); iter != blockIDs.end(); ++iter)
	{
		TBlockID_t blockID = *iter;
		if( !pScan->isNeedScan( blockID ) )
		{
			continue ;
		}

		CObjList* pList = NULL ;
		if( pScan->isOnlyScanRole() )
		{
			pList = _blockList[blockID].getRoleList();
		}
		else
		{
			pList = _blockList[blockID].getObjList();
		}

		TObjListNode* pPoint = pList->getHead()->next;
		while(pPoint != pList->getTail())
		{
			CGameObject* pObj = pPoint->node;
			pPoint = pPoint->next ;

			EScanReturn ret = pScan->onFindObject( pObj ) ;
			if( ret == SCAN_RETURN_CONTINUE )
			{
				continue ;
			}
			else if( ret == SCAN_RETURN_BREAK )
			{
				break ;
			}
			else if( ret == SCAN_RETURN_RETURN )
			{
				bNeedRet = true ;
				break ;
			}
			else
			{
				gxAssert(false) ;
			}
		}
	}

	pScan->onAfterScan() ;

	return true ;
}

bool CMapSceneBase::scanRole( TAxisPos* pos, uint8 range, TScanRoleBaseList& roleList )
{
	TBlockID_t blockID = calcBlockID( pos ) ;
	if( !_blockInfo.isValidBlockID(blockID) )
	{
		gxError("Invalid block id! BlockID={0}, {1}", blockID, _blockInfo.toString());
		return false ;
	}

	return scanRole(blockID, range, roleList);
}

bool CMapSceneBase::scanRole( TBlockID_t blockID, uint8 range, TScanRoleBaseList& roleList )
{
	if ( !_blockInfo.isValidBlockID(blockID) )
	{
		gxError("Invalid block id!BlockID = {0}, {1}", blockID, _blockInfo.toString());
		gxAssert(false);
		return false;
	}

	TBlockRect rc ;
	getRectInRange( &rc, range, blockID );

	TAxisPos_t h, w;
	for ( h = rc.startH; h <= rc.endH; h++ )
	{
		for ( w = rc.startW; w <= rc.endW; w++ )
		{
			TBlockID_t bid = _blockInfo.getBlockID(w, h);
			getRoleList(&_blockList[bid], roleList, INVALID_OBJ_UID);
		}
	}

	return true;
}

bool CMapSceneBase::scanRoleSub( TBlockID_t blockIDA, TBlockID_t blockIDB, uint8 range, TScanRoleBaseList& roleList)
{
	if ( !_blockInfo.isValidBlockID(blockIDA) || !_blockInfo.isValidBlockID(blockIDB) )
	{
		gxWarning("Block is valid! BlockA={0},BlockB={1},{2}",blockIDA,blockIDB,_blockInfo.toString());
		gxAssert(false);
		return false;
	}

	TBlockRect rcA, rcB;
	getRectInRange( &rcA, range, blockIDA );
	getRectInRange( &rcB, range, blockIDB );

	for ( TAxisPos_t h = rcA.startH; h <= rcA.endH; h++ )
	{
		for ( TAxisPos_t w = rcA.startW; w <= rcA.endW; w++ )
		{
			if ( !rcB.isContain( w, h ) )
			{
				TBlockID_t bid = _blockInfo.getBlockID(w, h);
				getRoleList(&_blockList[bid], roleList);
			}
		}
	}

	return true;
}

bool CMapSceneBase::scanObject( TBlockID_t blockID, uint8 range, TScanObjList& objList )
{
	if ( !_blockInfo.isValidBlockID(blockID) )
	{
		gxWarning("Invalid block id!BlockID = {0}, {1}", blockID, _blockInfo.toString());
		gxAssert(false);
		return false;
	}

	TBlockRect rc ;
	getRectInRange( &rc, range, blockID );

	TAxisPos_t h, w;
	for ( h = rc.startH; h <= rc.endH; h++ )
	{
		for ( w = rc.startW; w <= rc.endW; w++ )
		{
			TBlockID_t bid = _blockInfo.getBlockID(w, h);
			CObjList* pList = _blockList[bid].getObjList();
			pList->getObjectList(objList);
		}
	}

	return true;
}

bool CMapSceneBase::scanObjSub( TBlockID_t blockIDA, TBlockID_t blockIDB, uint8 range, TScanObjList& objList )
{
	if ( !_blockInfo.isValidBlockID(blockIDA) || !_blockInfo.isValidBlockID(blockIDB) )
	{
		gxWarning("Block is valid! BlockA={0},BlockB={1},{2}",blockIDA,blockIDB,_blockInfo.toString());
		return false;
	}

	TBlockRect rcA, rcB;
	getRectInRange( &rcA, range, blockIDA );
	getRectInRange( &rcB, range, blockIDB );

	for ( TAxisPos_t h = rcA.startH; h <= rcA.endH; h++ )
	{
		for ( TAxisPos_t w = rcA.startW; w <= rcA.endW; w++ )
		{
			if ( !rcB.isContain( w, h ) )
			{
				TBlockID_t bid = _blockInfo.getBlockID(w, h);
				CObjList* pList = _blockList[bid].getObjList();
				pList->getObjectList(objList);
			}
		}
	}

	return true;
}

bool CMapSceneBase::objBlockRegister( CGameObject *pObj, TBlockID_t blockID )
{
	gxAssert(pObj != NULL);
	if( pObj == NULL )
	{
		gxError("Obj is NULL!" );
		return false;
	}

	if( !_blockInfo.isValidBlockID(blockID) )
	{
		gxAssert(false);
		gxError("Invalid block id! BlockID = {0}, {1}", blockID, pObj->toString());
		return false;
	}

	// 刷新Obj消息到客户端
	TScanRoleBaseList roleList;
	scanRole( blockID, g_GameConfig.broadcastRange, roleList );

	// 可见性过滤
	TScanRoleBaseList newRoleList;
	for ( uint32 i = 0; i < roleList.size(); i++ )
	{
		if ( pObj->isCanViewMe( roleList[i] ) && roleList[i]->getObjUID() != pObj->getObjUID() )
		{
			newRoleList.push_back(roleList[i]);
		}
	}

	if ( !newRoleList.empty() )
	{
		MCEnterView meToOtherEnterView;

		ObjEnterView(meToOtherEnterView, pObj);
		sendPacket(meToOtherEnterView, newRoleList);
		if(pObj->isCharacter())
		{
			CCharacterObject* pChart = pObj->toCharacter();
			// 是角色则发送Buff	@TODO
// 			MCAddBuffer addBuffer;
// 			pChart->getBufferMgr().getBuffAry(addBuffer.ary);
// 			if(!addBuffer.ary.empty())
// 			{
// 				sendPacket(addBuffer, newRoleList);
// 			}
		}
	}

	// 新进入区域,把新进入的区域中的所有角色发往新进来的客户端
	if( pObj->isRole() )
	{
		MCEnterView otherToMeEnterView;
		TScanObjList listObj;
		scanObject( blockID, g_GameConfig.broadcastRange, listObj );

		CCharacterObject *pChart = NULL;

		pChart = pObj->toCharacter();

		CGameObject *pFindObj;
		for ( uint32 i = 0; i < listObj.size(); i++ )
		{
			pFindObj = listObj[i];
			if(NULL != pChart)
			{
				// 进入视野, 发送外观数据给当前玩家
				if ( pFindObj->isCanViewMe( pChart ) && pFindObj->getObjUID() != pChart->getObjUID() )
				{
					ObjEnterView(otherToMeEnterView, pFindObj);
				}
			}
		}

		if(NULL != pChart && otherToMeEnterView.size() > 0)
		{
			if(pChart->isRole())
			{
				CRoleBase* pRole = pChart->toRoleBase();
				if(NULL != pRole)
				{
					pRole->sendPacket(otherToMeEnterView);
				}
			}
		}

		// 进入视野, 发送Buff数据给当前玩家
// 		MCAddBuffer addBuffer;
// 		for ( uint32 i = 0; i < listObj.size(); i++ )
// 		{
// 			pFindObj = listObj[i];
// 			if(NULL != pChart)
// 			{
// 				if ( pFindObj->isCanViewMe( pChart ) && pFindObj->getObjUID() != pChart->getObjUID() )
// 				{
// 					if(pFindObj->isCharacter())
// 					{
// 						CCharacterObject* pChart = pFindObj->toCharacter();
// 						pChart->getBufferMgr().getBuffAry(addBuffer.ary);
// 					}
// 				}
// 			}
// 		}
// 		if(NULL != pChart && !addBuffer.ary.empty())
// 		{
// 			if(pChart->isRole())
// 			{
// 				CRole* pRole = pChart->toRoleBase();
// 				if(NULL != pRole)
// 				{
// 					pRole->sendPacket(addBuffer);
// 				}
// 			}
// 		}
	}

	_blockList[blockID].onObjectEnter(pObj);

	return true;
}

bool CMapSceneBase::objBlockUnregister( CGameObject *pObj, TBlockID_t blockID )
{
	if( pObj == NULL )
	{
		gxAssert(false);
		gxError("Object is null! BlockID = {0}", blockID);
		return false;
	}

	if( !_blockInfo.isValidBlockID(blockID))
	{
		gxAssert(false);
		gxError("Invalid block id! BlockID = {0}, {1}, {2}", blockID, pObj->toString(), pObj->getAxisPos()->toString());
		//GXMISC::gxExit(EXIT_CODE_CRASH);
		return false;
	}

	_blockList[blockID].onObjectLeave( pObj );

	// 刷新Obj消息到客户端
	TScanRoleBaseList listRole;
	scanRole( blockID, g_GameConfig.broadcastRange, listRole );

	// 可见性过滤
	TScanRoleBaseList newListRole;
	for ( uint32 i = 0; i < listRole.size(); i++ )
	{
		if ( pObj->isCanViewMe( listRole[i] ) && pObj->getObjUID() != listRole[i]->getObjUID() )
		{
			if(g_GameConfig.dbgEnterView && g_GameConfig.dbgOption[CGameConfig::DBG_OPTION_ENTER_VIEW].size())
			{
				if(listRole[i]->getObjUID() == g_GameConfig.dbgOption[CGameConfig::DBG_OPTION_ENTER_VIEW].toValue<TObjUID_t>(0))
				{
					gxInfo("Leave view: {0}", pObj->toString());
				}
			}
			newListRole.push_back(listRole[i]);
		}
	}

	if ( newListRole.size() > 0 )
	{
		MCLeaveView meToOtherLeaveView;

		meToOtherLeaveView.push(pObj->getObjUID(), pObj->getObjType());
		sendPacket( meToOtherLeaveView, newListRole );
	}

	// 把原来区域中的所有角色的删除消息发往的客户端
	if ( pObj->isRole() )
	{
		MCLeaveView otherToMeLeaveView;
		TScanObjList listObj;
		scanObject( blockID, g_GameConfig.broadcastRange, listObj );

		CCharacterObject *pChart = pObj->toCharacter();
		CGameObject *pFindObj;
		for ( uint32 i = 0; i < listObj.size(); i++ )
		{
			pFindObj = listObj[i];
			if ( pFindObj->isCanViewMe( pChart ) && pObj->getObjUID() != pFindObj->getObjUID() )
			{
				if(g_GameConfig.dbgEnterView && g_GameConfig.dbgOption[CGameConfig::DBG_OPTION_ENTER_VIEW].size())
				{
					if(pChart->getObjUID() == g_GameConfig.dbgOption[CGameConfig::DBG_OPTION_ENTER_VIEW].toValue<TObjUID_t>(0))
					{
						gxInfo("Leave view: {0}", pFindObj->toString());
					}
				}

				otherToMeLeaveView.push(pFindObj->getObjUID(), pFindObj->getObjType());
			}
		}

		if(NULL != pChart && !otherToMeLeaveView.objAry.empty())
		{
			if(pChart->isRole())
			{
				CRoleBase* pRole = pChart->toRoleBase();
				if(NULL != pRole)
				{
					pRole->sendPacket(otherToMeLeaveView);
				}
			}
		}
	}

	pObj->onUnregisterFromBlock();

	return true;
}

bool CMapSceneBase::objBlockChanged( CGameObject *pObj, TBlockID_t blockIDNew, TBlockID_t blockIDOld )
{
	if( pObj == NULL )
	{
		gxError("Object is null! NewBlockID={0}, OldBlockID={1}", blockIDNew, blockIDOld);
		gxAssert(false);
		return false;
	}

	if( !_blockInfo.isValidBlockID(blockIDNew) && !_blockInfo.isValidBlockID(blockIDOld))
	{
		gxError("Block is invalid!{0}, {2}, NewBlockID={3},OldBlockID={4}", _blockInfo.toString(), pObj->toString(), blockIDNew, blockIDOld);
		gxAssert(false);
		return false;
	}

	if(!_blockInfo.isValidBlockID(blockIDOld))
	{
		gxError("Old block id is invalid!OldBlockID={0}, {1}, {2}", blockIDOld, _blockInfo.toString(), pObj->toString());
	}
	else
	{
		_blockList[blockIDOld].onObjectLeave( pObj );

		// 刷新Obj删除消息到客户端
		TScanRoleBaseList listRole;
		if ( blockIDNew != INVALID_BLOCK_ID )
		{
			scanRoleSub( blockIDOld, blockIDNew, g_GameConfig.broadcastRange, listRole );
		}
		else
		{
			scanRole( blockIDOld, g_GameConfig.broadcastRange, listRole );
		}

		// 可见性过滤
		TScanRoleBaseList newListRole;
		for ( uint32 i = 0; i < listRole.size(); i++ )
		{
			if ( pObj->isCanViewMe( listRole[i] ) && listRole[i]->getObjUID() != pObj->getObjUID() )
			{
				if(g_GameConfig.dbgEnterView && g_GameConfig.dbgOption[CGameConfig::DBG_OPTION_ENTER_VIEW].size())
				{
					if(listRole[i]->getObjUID() == g_GameConfig.dbgOption[CGameConfig::DBG_OPTION_ENTER_VIEW].toValue<TObjUID_t>(0))
					{
						gxInfo("Leave view: {0}", pObj->toString());
					}
				}

				newListRole.push_back(listRole[i]);
			}
		}

		if ( listRole.size() > 0 )
		{
			MCLeaveView meToOtherLeaveView;
			meToOtherLeaveView.push(pObj->getObjUID(), pObj->getObjType());
			sendPacket( meToOtherLeaveView, newListRole );
		}

		// 如果是玩家,把超出视口的角色删除消息发到客户端
		if ( pObj->isRole() )
		{
			TScanObjList listObj;
			if ( blockIDNew != INVALID_BLOCK_ID )
			{
				scanObjSub( blockIDOld, blockIDNew, g_GameConfig.broadcastRange, listObj);
			}
			else
			{
				scanObject( blockIDOld, g_GameConfig.broadcastRange, listObj );
			}

			CCharacterObject *pChart = pObj->toCharacter();
			MCLeaveView otherToMeLeaveView;
			CGameObject *pFindObj = NULL;
			for ( uint32 i = 0; i < listObj.size(); i++ )
			{
				pFindObj = listObj[i];
				if ( pFindObj->isCanViewMe( pChart ) && pFindObj->getObjUID() != pObj->getObjUID() )
				{
					if(g_GameConfig.dbgEnterView && g_GameConfig.dbgOption[CGameConfig::DBG_OPTION_ENTER_VIEW].size())
					{
						if(pChart->getObjUID() == g_GameConfig.dbgOption[CGameConfig::DBG_OPTION_ENTER_VIEW].toValue<TObjUID_t>(0))
						{
							gxInfo("Leave view: {0}", pFindObj->toString());
						}
					}

					otherToMeLeaveView.push(pFindObj->getObjUID(), pFindObj->getObjType());
				}
			}

			if(NULL != pChart && !otherToMeLeaveView.objAry.empty())
			{
				if(pChart->isRole())
				{
					CRoleBase* pRole = pChart->toRoleBase();
					if(NULL != pRole)
					{
						pRole->sendPacket(otherToMeLeaveView);
					}
				}
			}
		}
	}

	if(!_blockInfo.isValidBlockID(blockIDNew))
	{
		gxError("New block id is invalid!BlockIDNew={0}, {1}, {2};", blockIDNew, _blockInfo.toString(), pObj->toString());
	}
	else
	{
		// 刷新Obj创建消息到客户端
		TScanRoleBaseList listRole;
		if ( blockIDOld != INVALID_BLOCK_ID )
		{
			scanRoleSub( blockIDNew, blockIDOld, g_GameConfig.broadcastRange, listRole);
		}
		else
		{
			scanRole( blockIDNew, g_GameConfig.broadcastRange, listRole );
		}

		// 可见性过滤
		TScanRoleBaseList newListRole;
		for ( uint32 i = 0; i < listRole.size(); i++ )
		{
			if ( pObj->isCanViewMe( listRole[i] ) && pObj->getObjUID() != listRole[i]->getObjUID() )
			{
				newListRole.push_back(listRole[i]);
			}
		}
		if ( newListRole.size() > 0 )
		{
			MCEnterView meToOtherEnterView;
			ObjEnterView(meToOtherEnterView, pObj);

			sendPacket(meToOtherEnterView, newListRole);

			// 发送Buff列表
// 			if(pObj->isCharacter())
// 			{
// 				CCharacterObject* pChart = pObj->toCharacter();
// 				MCAddBuffer addBuffer;
// 				pChart->getBufferMgr().getBuffAry(addBuffer.ary);
// 				if(!addBuffer.ary.empty())
// 				{
// 					sendPacket(addBuffer, newListRole);
// 				}
// 			}
		}

		// 如果是玩家
		if(pObj->isRole())
		{
			// 新进入区域，把新进入的区域中的所有角色发往新进来的客户端
			TScanObjList listObj;
			if ( blockIDOld != INVALID_BLOCK_ID )
			{
				scanObjSub( blockIDNew, blockIDOld, g_GameConfig.broadcastRange, listObj );
			}
			else
			{
				scanObject( blockIDNew, g_GameConfig.broadcastRange, listObj );
			}

			MCEnterView otherToMeEnterView;
			CGameObject *pFindObj;
			CCharacterObject* pChart = pObj->toCharacter();
			for ( uint32 i = 0; i < listObj.size(); i++ )
			{
				pFindObj = listObj[i];
				if(NULL != pChart && NULL != pFindObj)
				{
					// 进入视野, 发送外观数据给当前玩家
					if ( pFindObj->isCanViewMe( pChart ) && pFindObj->getObjUID() != pChart->getObjUID())
					{
						if(g_GameConfig.dbgEnterView && g_GameConfig.dbgOption[CGameConfig::DBG_OPTION_ENTER_VIEW].size())
						{
							if(pChart->getObjUID() == g_GameConfig.dbgOption[CGameConfig::DBG_OPTION_ENTER_VIEW].toValue<TObjUID_t>(0))
							{
								gxInfo("{0}", pFindObj->toString());
							}
						}

						ObjEnterView(otherToMeEnterView, pFindObj);
					}
				}
			}

			if(NULL != pChart && otherToMeEnterView.size() > 0)
			{
				if(pChart->isRole())
				{
					CRoleBase* pRole = pChart->toRoleBase();
					if(NULL != pRole)
					{
						pRole->sendPacket(otherToMeEnterView);
					}
				}
			}

// 			MCAddBuffer addBuffer;
// 			for ( uint32 i = 0; i < listObj.size(); i++ )
// 			{
// 				pFindObj = listObj[i];
// 				if(NULL != pChart && NULL != pFindObj)
// 				{
// 					// 进入视野, 发送Buff数据给当前玩家
// 					if ( pFindObj->isCanViewMe( pChart ) && pFindObj->getObjUID() != pChart->getObjUID() )
// 					{
// 						if(pFindObj->isCharacter())
// 						{
// 							CCharacterObject* pChart = pFindObj->toCharacter();
// 							pChart->getBufferMgr().getBuffAry(addBuffer.ary);
// 						}
// 					}
// 				}
// 			}
// 			if(NULL != pChart && !addBuffer.ary.empty())
// 			{
// 				if(pChart->isRole())
// 				{
// 					CRole* pRole = pChart->toRole();
// 					if(NULL != pRole)
// 					{
// 						pRole->sendPacket(addBuffer);
// 					}
// 				}
// 			}
		}

		_blockList[blockIDNew].onObjectEnter( pObj );
	}

	return true;
}
void CMapSceneBase::leaveBlock( CGameObject* pObject )
{
	_blockList[pObject->getBlockID()].onObjectLeave(pObject);
	pObject->setBlockID(INVALID_BLOCK_ID);
}

TMapID_t CMapSceneBase::getMapID() const
{
	return CGameMisc::GetMapID(getSceneID());
}

bool CMapSceneBase::enter( CGameObject* obj )
{
	if(_objMgr.isObjExist(obj->getObjUID()))
	{
		CGameObject* oldObj = _objMgr.findObj(obj->getObjUID());
		gxAssert(oldObj != NULL);
		gxError("CGameObject has exist! {0}, {1}", obj->toString(), oldObj->toString());
		return false;
	}

	obj->onEnterScene(this);
	_objMgr.addObj(obj);
	setBlock(obj->getAxisPos());
	if(obj->isRole())
	{
		onRoleEnter(obj->toRoleBase());
	}

	return true;
}

void CMapSceneBase::leave( CGameObject* obj, bool exitFlag )
{
	obj->onLeaveScene(this);
	_objMgr.delObj(obj->getObjUID());
	if(obj->isRole())
	{
		onRoleLeave(obj->toRoleBase(), exitFlag);
	}
}

uint16 CMapSceneBase::getMaxRoleNum()
{
	return g_GameConfig.maxSceneRoleNum;
}

bool CMapSceneBase::isMaxRoleNum()
{
	return getMaxRoleNum() <= _roleMgr.size();
}

bool CMapSceneBase::onInit()
{
	return true;
}

void CMapSceneBase::onUnload()
{
	FUNC_BEGIN(SCENE_MOD);

	FUNC_END(DRET_NULL);
}

void CMapSceneBase::onRoleEnter( CRoleBase* obj )
{
	_roleMgr.addObj(obj);
	proRoleEnterScene(obj);
}

void CMapSceneBase::onRoleLeave( CRoleBase* obj, bool exitFlag )
{
	_roleMgr.delObj(obj->getObjUID());
	proRoleLeaveScene(obj, exitFlag);
}


void CMapSceneBase::getAllRoleSocketIndex( GXMISC::TSockIndexAry* socks )
{
	for(CSceneRoleManager::Iterator iter = _roleMgr.begin(); iter != _roleMgr.end(); ++iter)
	{
		CRoleBase* pRole = iter->second->toRoleBase();
		if(NULL != pRole)
		{
			socks->pushBack(pRole->getSocketIndex());
		}
	}
}


CGameObject* CMapSceneBase::getObjByUID(TObjUID_t objUID)
{
	if (objUID == INVALID_OBJ_UID)
	{
		return NULL;
	}

	return _objMgr.findObj(objUID);
}

CCharacterObject* CMapSceneBase::getCharacterByUID(TObjUID_t objUID)
{
	if (objUID == INVALID_OBJ_UID)
	{
		return NULL;
	}
	return dynamic_cast<CCharacterObject*>(_objMgr.findObj(objUID));
}


bool CMapSceneBase::proInit( TMapID_t mapID )
{
	return true;	
}

bool CMapSceneBase::proUpdate( GXMISC::TDiffTime_t diff )
{
	return true;
}

void CMapSceneBase::proRoleEnterScene( CRoleBase* pRole )
{

}

void CMapSceneBase::proRoleLeaveScene( CRoleBase* pRole, bool exitFlag )
{
	if (!isNormalScene() && _roleMgr.size() <= 0)
	{
		setIsNeedClose(true);
	}
}

void CMapSceneBase::proMonsterLeaveScene( uint32 monsterNum, TMonsterTypeID_t monsterTypeID, TObjUID_t objUID )
{

}

void CMapSceneBase::kickAllRole()
{

}

bool CMapSceneBase::getKickPos( TMapIDRangePos* kickPos, CRoleBase* pRole ) const
{
	return false;
}

EGameRetCode CMapSceneBase::getRelivePos( CRoleBase* pRole, EReliveType reliveType, TMapIDRangePos* relivePos ) const
{
	return RC_FAILED;
}

bool CMapSceneBase::canEnter()
{
	// 检测最大人数
	if(isMaxRoleNum())
	{
		gxError("Scene num reach max!!! MapID = {0},SceneID={1}", _mapID, getSceneID());
		return false;
	}

	return true;
}

void CMapSceneBase::getSceneData( TSceneData* data )
{
	data->mapServerID = DMapServerBase->getServerID();
	data->sceneID = _sceneID;
	data->sceneType = _sceneType;
	data->maxRoleNum = getMaxRoleNum();
	data->curRoleNum = getRoleMgr()->size();
	data->openTime = _openTime;
	data->lastTime = GXMISC::MAX_GAME_TIME;
	data->objUID = _ownerObjUID;
}

CMapSceneBase::CMapSceneBase()
{
	cleanUp();
}

CMapSceneBase::~CMapSceneBase()
{
	cleanUp();
}

void CMapSceneBase::kickSingleRole( CRoleBase* pRole )
{
}

TSceneGroupID_t CMapSceneBase::getEmptyGroupID()
{
	for(sint32 i = 0; i < (sint32)_emptyIndex.size(); ++i)
	{
		if(_emptyIndex[i] < _maxRoleNumInGroup)
		{
			_emptyIndex[i]++;
			return i;
		}
	}

	return DRandGen.randUInt()%_emptyIndex.size();
}

void CMapSceneBase::initRoleInfo( TSceneGroupID_t maxRoleNum, sint32 maxRoleNumInGroup )
{
	_maxRoleNum = maxRoleNum;
	_maxRoleNumInGroup = maxRoleNumInGroup;
	
	sint32 count = maxRoleNum/maxRoleNumInGroup;
	_emptyIndex.resize(count);
	for(sint32 i = 0; i < (sint32)_emptyIndex.size(); ++i)
	{
		_emptyIndex[i] = 0;
	}
}

void CMapSceneBase::putEmptyGourpID(TSceneGroupID_t groupID)
{
	if(groupID != INVALID_SCENE_GROUP_ID)
	{
		_emptyIndex[groupID]--;
	}
}

sint32 CMapSceneBase::getMaxNumInGroup() const
{
	return _maxRoleNumInGroup;
}