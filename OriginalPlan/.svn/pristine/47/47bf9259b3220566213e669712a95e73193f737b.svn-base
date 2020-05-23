#include "char_move_core.h"
#include "obj_character.h"
#include "scene_util.h"
#include "map_data_base.h"
#include "map_scene_base.h"

void CCharMoveCore::cleanUp()
{
	_moveTimer.setMaxInterval(MAX_CHART_UPDATE_MOVE_TIME*3);
	_lastMoveTime = 0;
}

bool CCharMoveCore::init( const TCharacterInit* inits )
{
	return true;
}

bool CCharMoveCore::update( GXMISC::TDiffTime_t diff )
{
//	if(_character->canMove())	@TODO
	{
		doMoveUpdate(diff);
	}

	return true;
}

bool CCharMoveCore::updateOutBlock( GXMISC::TDiffTime_t diff )
{
	return true;
}

void CCharMoveCore::setCharacter( CCharacterObject* character )
{
	_character = character;
}

bool CCharMoveCore::moveable( const TAxisPos *tempPos,const TAxisPos *destPos,const int radius )
{
	CMapSceneBase* scene = _character->getScene();
	if(NULL == scene)
	{
		return false;
	}

// 	if(!_character->canMove())	@TODO
// 	{
// 		return false;
// 	}

	if (!_character->isInValidRadius(scene->getMapID(), tempPos->x, tempPos->y, destPos->x, destPos->y, radius))
	{
		return false;
	}

	if(*tempPos == *destPos)
	{
		return true;
	}

	if(scene->checkBlock(tempPos))
	{
		return false;
	}

	return true;
}

const TAxisPos CCharMoveCore::doMoveUpdate( GXMISC::TDiffTime_t diff, sint32 movePosNum /*= MAX_MOVE_POS_NUM*/, bool forceSend /*= false*/ )
{
	if(!forceSend)
	{
		if(!_moveTimer.update(diff))
		{
			return *_character->getAxisPos();
		}
	}

	if(_logicMovePosList.empty())
	{
		return *_character->getAxisPos();
	}

	uint32 moveNum = getMovePosNum((GXMISC::TDiffTime_t)_moveTimer.getCurInterval());
	if(moveNum <= 0)
	{
		return *_character->getAxisPos();
	}

	_moveTimer.reset();

	TPackMovePosList posList;		// 移动路点

	moveNum = moveNum < (uint32)movePosNum ? moveNum : movePosNum;
	if ( moveNum >= _logicMovePosList.size() )
	{
		moveNum = (uint32)_logicMovePosList.size();
	}
	if(moveNum <= 0)
	{
		return *_character->getAxisPos();
	}

	for(uint32 i = 0; i < moveNum && !posList.isMax(); ++i)
	{
		posList.pushBack(_logicMovePosList.front());
		_logicMovePosList.pop_front();
	}

	if(posList.empty())
	{
		return *_character->getAxisPos();
	}

	DBreakable
	{
		if(_character->getScene()->checkBlock(&posList.back()))
		{
			TAxisPos tarPos = posList.back();
			if(!_logicMovePosList.empty())
			{
				tarPos = _logicMovePosList.back();
			}

			if(_character->getScene()->checkBlock(&tarPos))
			{
				if(!_character->getScene()->findEmptyPos(&tarPos, 5, true))
				{
					break;
				}
			}

			_logicMovePosList.clear();
			if(move(&tarPos, false))
			{
				return *_character->getAxisPos();
			}

			return *_character->getAxisPos();
		}
	}

	for(uint32 i = 0; i < posList.size(); ++i)
	{
		_character->setDir(CGameMisc::GetDir(*_character->getAxisPos(), posList[i]));
		_character->setAxisPos(&posList[i]);
		onMove(&posList[i]);
	}

	if(posList.size() > 0)
	{
		_character->onMoveUpdate(&posList, _character->getObjUID(), _character->getObjType());

		if(_character->getObjType() == OBJ_TYPE_PET)
		{
			gxDebug("Role:curPos={0}:{1}, Dir={2}, ObjUID={3}", 
				_character->getAxisPos()->x, _character->getAxisPos()->y, (uint32)_character->getDir(), _character->getObjUID());
		}
		_character->updateBlock();
		onMoveOneTimes(_character->getAxisPos());
		_lastMoveTime = DTimeManager.nowAppTime();
		if(posListEmpty())
		{
			onArriveDestPos();
		}
		return posList.back();
	}

	return *_character->getAxisPos();
}

void CCharMoveCore::onMove( const TAxisPos* pos )
{
}

void CCharMoveCore::onMoveOneTimes( const TAxisPos* pos )
{
}

void CCharMoveCore::onArriveDestPos()
{
}

uint8 CCharMoveCore::getMovePosNum( GXMISC::TDiffTime_t diff )
{
	double tempMovePosNum = (double)((double)(diff*MAX_MOVE_STEP_PER_HUNDRED_SEC)/100000)*(_getMoveSpeed()/(double)MAX_SPEED_BASE_NUM);
	uint8 movePosNum = GXMISC::gxDouble2Int<uint8>(tempMovePosNum);
	if(movePosNum < 3)
	{
		return 0;
	}
	if(movePosNum > 5)
	{
		movePosNum = 5;
	}

	return movePosNum;
}

void CCharMoveCore::clearMovePos()
{
	_logicMovePosList.clear();
}

bool CCharMoveCore::isMoving()
{
	return !_logicMovePosList.empty() && ((DTimeManager.nowAppTime()-_lastMoveTime) < MAX_CHECK_MOVE_TIME);
}

TAxisPos* CCharMoveCore::getFinalTarPos()
{
	if(_logicMovePosList.size() == 0)
	{
		return _character->getAxisPos();
	}

	return &_logicMovePosList.back();
}

void CCharMoveCore::directMoveTo( const TAxisPos* tarPos )
{
	_logicMovePosList.clear();
	doMove(1, tarPos);
}

bool CCharMoveCore::move( const TAxisPos* tarPos, bool needRefixPos )
{
	if(!_logicMovePosList.empty() && _logicMovePosList.back() == *tarPos)
	{
		return true;
	}

	_logicMovePosList.clear();

	if(*_character->getAxisPos() == *tarPos)
	{
		return true;
	}

	if(CGameMisc::MySqrt(*tarPos, *_character->getAxisPos()) > TBaseTypeAStar::FindPathRangeL)
	{
		return false;
	}

	TLogicMovePosList posAry;
	if(CGameMisc::MySqrt(*tarPos, *_character->getAxisPos()) <= TBaseTypeAStar::FindPathRange)
	{
		if(!gotoFindPath(_character->getAxisPos(), tarPos, &posAry))
		{
			return false;
		}
	}
	else if(CGameMisc::MySqrt(*tarPos, *_character->getAxisPos()) <= TBaseTypeAStar::FindPathRangeL)
	{
		posAry.clear();
		if(!gotoFindPathL(_character->getAxisPos(), tarPos, &posAry))
		{
			return false;
		}
	}
	else
	{
		return false;
	}

	// 修正防止重叠
	if(needRefixPos)
	{
		posAry.resize(posAry.size()-1);
	}

	return move(&posAry, true);
}

bool CCharMoveCore::move( TLogicMovePosList* posList, bool moveFlag )
{
	_logicMovePosList.insert(_logicMovePosList.end(), posList->begin(), posList->end());
	if(_logicMovePosList.empty())
	{
		return false;
	}

	if(moveFlag)
	{
		doMoveUpdate(0, MAX_MOVE_POS_NUM, true);
		return true;
	}

	return true;
}

bool CCharMoveCore::move( TPackMovePosList* posList )
{
	return IsSuccess(doMove(posList->size(), posList->data()));
}

bool CCharMoveCore::moveLine( const TAxisPos* tarPos )
{
	if(NULL == _character->getScene())
	{
		return false;
	}

	CMapBase* pMap = _character->getScene()->getMapData();
	TAxisPos srcPos = *_character->getAxisPos();

	if(srcPos == *tarPos)
	{
		return true;
	}

	TAxisPos_t x0 = srcPos.x;
	TAxisPos_t x1 = tarPos->x;
	TAxisPos_t y0 = srcPos.y;
	TAxisPos_t y1 = tarPos->y;
	double x,y;
	double d,k;	
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
			if(!pMap->isCanWalk(tempX, tempY))
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
			if(!pMap->isCanWalk(tempX, tempY))
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
			if(!pMap->isCanWalk(tempX, tempY))
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
			if(!pMap->isCanWalk(tempX, tempY))
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
			if(!pMap->isCanWalk(tempX, tempY))
			{
				return false;
			}
		}
	}

	return true;
}

bool CCharMoveCore::isRangeEmptyPos( TRange_t range )
{
	if(_character->getScene() == NULL)
	{
		return false;
	}

	if(!_character->isActive())
	{
		return false;
	}

	TAxisPos curPos = *_character->getAxisPos();
	return _character->getScene()->getMapData()->findEmptyPos(&curPos, range);
}

bool CCharMoveCore::findEmptyPos( TAxisPos* pos, TRange_t range )
{
	if(_character->getScene() == NULL)
	{
		return false;
	}

	if(!_character->isActive())
	{
		return false;
	}

	TAxisPos curPos = *_character->getAxisPos();
	if(_character->getScene()->findEmptyPos(&curPos, range))
	{
		*pos = curPos;
		return true;
	}

	return false;
}

bool CCharMoveCore::findRandEmptyPos( TAxisPos* pos, TRange_t range )
{
	if(_character->getScene() == NULL)
	{
		return false;
	}

	if(!_character->isActive())
	{
		return false;
	}

	TAxisPos curPos = *_character->getAxisPos();
	if(_character->getScene()->findRandEmptyPos(&curPos, range))
	{
		*pos = curPos;
		return true;
	}

	return false;
}

bool CCharMoveCore::posListEmpty()
{
	return _logicMovePosList.empty();
}

TRange_t CCharMoveCore::getRange( const TAxisPos* tarPos )
{
	return GXMISC::gxDouble2Int<TRange_t>(CGameMisc::MySqrt(*_character->getAxisPos(), *tarPos));
}

bool CCharMoveCore::isSafeZone()
{
	if(_character->getScene() != NULL)
	{
		return _character->getScene()->getMapData()->isCanWalk(_character->getAxisPos()->x, _character->getAxisPos()->y, BLOCK_FLAG_SAFE_ZONE);
	}
	else
	{
		return true;
	}
}

EGameRetCode CCharMoveCore::doIdle( void )
{
	return RC_SUCCESS;
}

EGameRetCode CCharMoveCore::doStop( bool flag )
{
	if(flag == true)
	{
		doMoveUpdate(_character->getLogicTime(), 2);
	}
	_logicMovePosList.clear();
	const TAxisPos& lastPos = *_character->getAxisPos();

	// 停止在目标位置 @todo
	return RC_SUCCESS;
}

EGameRetCode CCharMoveCore::doMove( uint32 posNum, const TAxisPos *paTargetPos )
{
// 	if(_character->isDie())	@TODO
// 	{
// 		return RC_DIE;
// 	}
// 
// 	if(!_character->canMove())
// 	{
// 		return RC_LIMIT_MOVE;
// 	}

	for(uint32 i = 0; i < posNum; ++i)
	{
		_logicMovePosList.push_back(paTargetPos[i]);
	}

	if(_logicMovePosList.empty())
	{
		return RC_SUCCESS;
	}

	doMoveUpdate(_character->getLogicTime());

	return RC_SUCCESS;
}

EGameRetCode CCharMoveCore::doMove( TLogicMovePosList* posList )
{
// 	if(_character->isDie())		@TODO
// 	{
// 		return RC_DIE;
// 	}
// 
// 	if(!_character->canMove())
// 	{
// 		return RC_LIMIT_MOVE;
// 	}

	_logicMovePosList.insert(_logicMovePosList.end(), posList->begin(), posList->end());

	if(_logicMovePosList.empty())
	{
		return RC_SUCCESS;
	}

	doMoveUpdate(_character->getLogicTime());

	return RC_SUCCESS;
}

TMoveSpeed_t CCharMoveCore::_getMoveSpeed()
{
	return _character->getMoveSpeed();
}
