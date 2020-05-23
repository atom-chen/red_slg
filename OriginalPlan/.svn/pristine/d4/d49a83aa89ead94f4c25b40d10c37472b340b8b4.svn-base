#include "core/common.h"
#include "core/path.h"

#include "map_data_base.h"
#include "game_struct.h"
#include "game_rand.h"
#include "game_define.h"
#include "path_finder.h"
#include "map_path_finder.h"

TMapID_t CMapBase::getMapID() const
{
	return _mapID;
}

TAxisPos_t CMapBase::getX() const
{
	return _mapData.header.blockNum;
}

TAxisPos_t CMapBase::getY() const
{
	return _mapData.header.blockNum;
}

void CMapBase::randStepPos(TListPos* poss, TAxisPos* srcPos, uint16 nRange, uint32 maxSteps /*= 0*/)
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

		verifyPos(srcPos, nRange, &tempPos);
		if(!isCanWalk(&tempPos))
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

void CMapBase::findRobotPos( TListPos* poss, TAxisPos* srcPos, TAxisPos* destPos )
{
	CMapPathFinder finder(this);
	TLogicMovePosList listPos;
	if(!finder.gotoFindPath(srcPos, destPos, &listPos))
	{
		gxAssert(false);
		return;
	}
	poss->insert(poss->begin(), listPos.begin(), listPos.end());
}

void CMapBase::randPos( const TAxisPos* top, const TAxisPos* buttom, TAxisPos* randP )
{
	randP->x = DRandGen.getRand(buttom->x, top->x);
	randP->y = DRandGen.getRand(buttom->y, top->y);
	verifyPos(randP);
}

void CMapBase::verifyPos( TAxisPos* srcPos, uint16 range, TAxisPos* pos )
{
	TAxisPos top;
	TAxisPos bottom;
	top.x = srcPos->x - range;
	top.y = srcPos->y - range;
	bottom.x = srcPos->x + range;
	bottom.y = srcPos->y + range;

	verifyPos(&top, &bottom, pos);
}

void CMapBase::verifyPos( TAxisPos* top, TAxisPos* bottom, TAxisPos* pos )
{
	verifyPos(top);
	verifyPos(bottom);

	GXMISC::gxClamp(pos->x, top->x, bottom->x);
	GXMISC::gxClamp(pos->y, top->y, bottom->y);
}

void CMapBase::verifyPos( TAxisPos* pos )
{
	GXMISC::gxClamp(pos->x, 0, _mapData.header.blockNum);
	GXMISC::gxClamp(pos->y, 0, _mapData.header.blockNum);
}

bool CMapBase::findRandEmptyPos( TAxisPos* top, TAxisPos* bottom, TAxisPos* pos )
{
	verifyPos(top);
	verifyPos(bottom);

	TAxisPos destRandPos;
	for(uint32 i = 0; i < MAX_RAND_POS_NUM; ++i)
	{
		randPos(top, bottom, &destRandPos);
		if(isCanWalk(&destRandPos))
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

bool CMapBase::findRandEmptyPos( TAxisPos* pos, uint8 range )
{
	TAxisPos top;
	TAxisPos bottom;

	top.x = pos->x-range;
	top.y = pos->y - range;
	bottom.x = pos->x + range;
	bottom.y = pos->y + range;
	verifyPos(&top);
	verifyPos(&bottom);

	TAxisPos destRandPos;
	if(findRandEmptyPos(&top, &bottom, &destRandPos))
	{
		pos->x = destRandPos.x;
		pos->y = destRandPos.y;
		return true;
	}

	return false;
}

bool CMapBase::findEmptyPos( TAxisPos* top, TAxisPos* bottom, TAxisPos* pos )
{
	verifyPos(top);
	verifyPos(bottom);

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
			if(isCanWalk(x, y))
			{
				pos->x = x;
				pos->y = y;
				return true;
			}
		}
	}

	return false;
}

void CMapBase::initTestMap()
{
	_mapData.header.blockNum = 1024;
	if(false == GXMISC::gxAllocArrays(_mapData.blockAry, _mapData.header.blockNum, _mapData.header.blockNum))
	{
		return;
	}

	for(sint16 i = 0; i < _mapData.header.blockNum; ++i)
	{
		for(sint16 j = 0; j < _mapData.header.blockNum; ++j)
		{
			_mapData.blockAry[j][i] = BLOCK_FLAG_WALK;
		}
	}
}

bool CMapBase::load( const std::string& name )
{
	// 		(1) 地图ID：sint16
	// 		(2) 地图宽度：sint16
	// 		(3) 地图高度：sint16
	// 		(4) 地图格子宽度：sint16
	// 		(5) 地图格子高度：sint16
	// 		(6) 地图切片宽度：sint16
	// 		(7) 地图切片高度：sint16
	// 		(8 地图格子个数：sint16
	// 		(9)
	// 		while(格子个数){
	// 			while(格子个数){
	// 				标记：sbyte
	// 			}
	// 		}
	//

	if(name.empty() || !GXMISC::CFile::IsExists(name) || GXMISC::CFile::isDirectory(name))
	{
		initTestMap();
		return true;
	}

	std::ifstream ifs;
	ifs.open(name.c_str(), std::ios::binary|std::ios::in);
	if(!ifs)
	{
		gxError("Can't open map data file! Name={0}", name.c_str());
		return false;
	}

	if(!GXMISC::gxIsBigEndian())
	{
		if(!ifs.read((char*)&_mapData.header, sizeof(TMapDataHeader)))
		{
			gxError("Can't read map header!Name={0}", name.c_str());
			ifs.close();
			return false;
		}

		_mapData.header.ID = GXMISC::gxHostToNetT(_mapData.header.ID);
		_mapData.header.width = GXMISC::gxHostToNetT(_mapData.header.width);
		_mapData.header.height = GXMISC::gxHostToNetT(_mapData.header.height);
		_mapData.header.blockWidth = GXMISC::gxHostToNetT(_mapData.header.blockWidth);
		_mapData.header.blockHeight = GXMISC::gxHostToNetT(_mapData.header.blockHeight);
		_mapData.header.blockXWidth = GXMISC::gxHostToNetT(_mapData.header.blockXWidth);
		_mapData.header.blockXHeight = GXMISC::gxHostToNetT(_mapData.header.blockXHeight);
		_mapData.header.bak1 = GXMISC::gxHostToNetT(_mapData.header.bak1);
		_mapData.header.blockNum = GXMISC::gxHostToNetT(_mapData.header.blockNum);
	}
	else
	{
		if(!ifs.read((char*)&_mapData.header, sizeof(TMapDataHeader)))
		{
			gxError("Can't read map header!Name={0}", name.c_str());
			ifs.close();
			return false;
		}
	}

	if(false == GXMISC::gxAllocArrays(_mapData.blockAry, _mapData.header.blockNum, _mapData.header.blockNum))
	{
		gxError("Can't alloc map data block!Name={0}", name.c_str());
		ifs.close();
		return false;
	}

	for(sint16 i = 0; i < _mapData.header.blockNum; ++i)
	{
		for(sint16 j = 0; j < _mapData.header.blockNum; ++j)
		{
			if(!ifs.read((char*)&_mapData.blockAry[j][i], 1))
			{
				ifs.close();
				GXMISC::gxFree2Arrays(_mapData.blockAry, _mapData.header.blockNum);
				gxError("Can't read map data {0}:{1} line!Name={2}", i, j, name.c_str());
				return false;
			}

			if(_mapData.blockAry[j][i] & BLOCK_FLAG_WALK)
			{
				TAxisPos emptyPos;
				emptyPos.x = j;
				emptyPos.y = i;
				setEmptyPos(&emptyPos);
			}
		}
	}

	ifs.close();

	genStrName();

	return true;
}

void CMapBase::cleanUp()
{
	memset(&_mapData, 0, sizeof(TMapData));
	_npcNum = 0;
	_monsterNum = 0;
	GXMISC::gxFree2Arrays(_mapData.blockAry, _mapData.header.blockNum);
}

CMapBase::~CMapBase()
{
	cleanUp();
}

CMapBase::CMapBase()
{
	cleanUp();
}

void CMapBase::pushNpc( TNPCTypeID_t npcTypeID, sint32 num )
{
	_npcs.push_back(npcTypeID);
	_npcNum += num;
}

void CMapBase::pushMonster( TMonsterDistributeID_t monsterDistributeID, sint32 num )
{
	_monsters.push_back(monsterDistributeID);
	_monsterNum += num;
}

void CMapBase::pushTransport(TTransportTypeID_t transID, sint32 num )
{
	_transports.push_back(transID);
}

bool CMapBase::findEmptyPos( TAxisPos* pos, TRange_t range )
{
	TAxisPos top;
	TAxisPos bottom;

	top.x = pos->x - range;
	top.y = pos->y - range;
	bottom.x = pos->x + range;
	bottom.y = pos->y + range;
	verifyPos(&top);
	verifyPos(&bottom);

	TAxisPos destPos;
	if(findEmptyPos(&top, &bottom, &destPos))
	{
		pos->x = destPos.x;
		pos->y = destPos.y;
		return true;
	}

	return false;
}

bool CMapBase::isLineEmpty( const TAxisPos* srcPos, const TAxisPos* destPos, uint8 flag )
{
	if(srcPos == destPos)
	{
		return true;
	}

	double x0 = srcPos->x;
	double x1 = destPos->x;
	double y0 = srcPos->y;
	double y1 = destPos->y;
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
			if(!isCanWalk(tempX, tempY, flag))
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
			if(!isCanWalk(tempX, tempY, flag))
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
			if(!isCanWalk(tempX, tempY, flag))
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
			if(!isCanWalk(tempX, tempY, flag))
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
			if(!isCanWalk(tempX, tempY, flag))
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
};

bool CMapBase::isSkillLineEmpty( const TAxisPos* srcPos, const TAxisPos* destPos, uint8 flag /*= BLOCK_FLAG_SKILL*/ )
{
	if(srcPos == destPos)
	{
		return true;
	}

	double x0 = srcPos->x;
	double x1 = destPos->x;
	double y0 = srcPos->y;
	double y1 = destPos->y;
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
			if(isCanWalk(tempX, tempY, flag))
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
			if(isCanWalk(tempX, tempY, flag))
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
			if(isCanWalk(tempX, tempY, flag))
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
			if(isCanWalk(tempX, tempY, flag))
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
			if(isCanWalk(tempX, tempY, flag))
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

bool CMapBase::getLineEmptyPos( const TAxisPos* srcPos, const TAxisPos* destPos, TAxisPos* targetPos, uint8 flag )
{
	*targetPos = *srcPos;
	TAxisPos tempPos = *srcPos;

	if(srcPos == destPos)
	{
		*targetPos = *srcPos;
		return true;
	}

	double x0 = srcPos->x;
	double x1 = destPos->x;
	double y0 = srcPos->y;
	double y1 = destPos->y;
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
		for(y=y0+1; y<y1;y++)
		{
			TAxisPos_t tempX = (TAxisPos_t)DRound(x);
			TAxisPos_t tempY = (TAxisPos_t)DRound(y);
			if(isCanWalk(tempX, tempY, flag))
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

			for(x=x0-1;x>=x1;x--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(isCanWalk(tempX, tempY, flag))
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

			for(x=x0+1;x<=x1;x++)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(isCanWalk(tempX, tempY, flag))
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

			for(y=y0-1;y>=y1;y--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(isCanWalk(tempX, tempY, flag))
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

			for(y=y0+1;y<=y1;y++)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(isCanWalk(tempX, tempY, flag))
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
			for(y=y0+1;y<=y1;y++)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(isCanWalk(tempX, tempY, flag))
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
			for(y=y0-1;y>y1;y--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(isCanWalk(tempX, tempY, flag))
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
			for(x=x0-1;x>=x1;x--)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(isCanWalk(tempX, tempY, flag))
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

			for(x=x0+1;x<=x1;x++)
			{
				TAxisPos_t tempX = (TAxisPos_t)DRound(x);
				TAxisPos_t tempY = (TAxisPos_t)DRound(y);
				if(isCanWalk(tempX, tempY, flag))
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