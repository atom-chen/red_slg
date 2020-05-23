#ifndef _MAP_PATH_FINDER_H_
#define _MAP_PATH_FINDER_H_

#include "path_finder.h"
#include "game_struct.h"

class CMapBase;

class CMapPathFinder : public CAStar<1, 200>
{
public:
	CMapPathFinder(CMapBase* mapData)
	{
		_pMapData = mapData;
	}
public:
	virtual bool moveable(const TAxisPos *tempPos,const TAxisPos *destPos,const sint32 rads = 200)
	{
		TAxisPos_t x, y;

		x = tempPos->x - destPos->x;
		y = tempPos->y - destPos->y;

		uint8 radius = GXMISC::gxDouble2Int<uint8>(std::sqrt(((double)(x*x) + y*y)));
		return rads >= radius ;
	}

	virtual bool move(TLogicMovePosList& posAry)
	{
		return false;
	}

private:
	CMapBase* _pMapData;
};

#endif // _MAP_PATH_FINDER_H_