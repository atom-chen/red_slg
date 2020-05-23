#include "ai_avoid_overlap.h"
#include "game_rand.h"

bool CAvoidOverlap::getDirPos( TAxisPos* rTar, const TAxisPos* rMonsterPos, const TAxisPos* rPlayerPos, sint8 maxDist, sint8 minDist, sint16* index )
{
	*rTar = *rPlayerPos; // 这样确保目标点是一个有效的点
	sint32 randIndex = DRandGen.randUInt()%9+1;
	*rTar += NightGrid[randIndex];
	*index =randIndex;

	CGameMisc::RefixValue(minDist, (sint8)0, (sint8)MAX_ATTACK_RANGE);
	CGameMisc::RefixValue(maxDist, (sint8)minDist, (sint8)MAX_ATTACK_RANGE);

	float dis = CGameMisc::MySqrt(*rMonsterPos, *rPlayerPos);
	if(dis < minDist)
	{
		// 不需要找位置
		return false;
	}

	sint8 randDist = DRandGen.getRand(minDist, maxDist);
	*index = DRandGen.getRand(NightGridAdjust[randDist][0], NightGridAdjust[randDist][1]);
	if(_used[*index] > 0)
	{
		// 		if(isSmallCycle(maxDist, minDist))
		// 		{
		// 			return smallCycle(rTar, rMonsterPos, rPlayerPos, maxDist, minDist, index);
		// 		}

		if(DRandGen.randBool())
		{
			return insideCycle(rTar, rMonsterPos, rPlayerPos, maxDist, minDist, index);
		}
		else
		{
			return outsideCycle(rTar, rMonsterPos, rPlayerPos, maxDist, minDist, index);
		}
	}
	else
	{
		*rTar = *rPlayerPos;
		*rTar += NightGrid[*index];
		return true;
	}

	return false;
}

bool CAvoidOverlap::smallCycle( TAxisPos* rTar, const TAxisPos* rMonsterPos, const TAxisPos* rPlayerPos, sint8 maxDist, sint8 minDist, sint16* index )
{
	sint32 minUserNum = GXMISC::MAX_SINT32_NUM;

	TAxisPos minPos = *rTar;
	for(sint32 i = maxDist; i >= 1; --i)
	{
		for(sint32 j = NightGridAdjust[i][0]; j <= NightGridAdjust[i][1]; ++j)
		{
			TAxisPos tempPos = *rPlayerPos;
			tempPos += NightGrid[j];
			if(_used[j] < minUserNum && CGameMisc::MySqrt(*rPlayerPos, tempPos) <= maxDist)
			{
				minUserNum = _used[j];
				if(minUserNum == 0)
				{
					*rTar = minPos;
					*index = j;
					minPos = tempPos;
					return true;
				}
			}
		}
	}

	if(minUserNum != GXMISC::MAX_SINT32_NUM)
	{
		*rTar = minPos;
		return true;
	}

	return true;
}

bool CAvoidOverlap::isEmpty( const TAxisPos* curPos, const TAxisPos* tarPos )
{
	sint16 index = getIndex(curPos, tarPos);
	return _used[index] <= 0;
}

bool CAvoidOverlap::isEmpty( sint16 index )
{
	return _used[index] <= 0;
}

void CAvoidOverlap::setSitPos( sint16 index )
{
	gxAssert(index >= 0 && index <= MAX_FRACTION);
	_used[index]++;
}

void CAvoidOverlap::resetUsedDir( void )
{
	memset( _used, 0, MAX_FRACTION+1 );
	_used[MAX_FRACTION] = GXMISC::MAX_UINT8_NUM;
}

bool CAvoidOverlap::isSmallCycle( sint8 maxDist, sint8 minDist )
{
	return maxDist <= MIN_MAX_DIST;
}

sint16 CAvoidOverlap::getIndex( const TAxisPos* curPos, const TAxisPos* tarPos )
{
	sint32 xAdjust = curPos->x - tarPos->x;
	sint32 yAdjust = curPos->y - tarPos->y;

	sint32 row=yAdjust+MAX_ATTACK_RANGE/2;
	sint32 col=xAdjust+MAX_ATTACK_RANGE/2;

	if(row >= 0 && row <= MAX_ATTACK_RANGE && col >= 0 && col <= MAX_ATTACK_RANGE)
	{
		return NightGrid2Index[row][col];
	}

	return MAX_FRACTION-1;
}

bool CAvoidOverlap::insideCycle( TAxisPos* rTar, const TAxisPos* rMonsterPos, const TAxisPos* rPlayerPos, sint8 maxDist, sint8 minDist, sint16* index )
{
	for(sint32 i = minDist; i < maxDist; ++i)
	{
		for(sint32 j = NightGridAdjust[i][0]; j <= NightGridAdjust[i][1]; ++j)
		{
			TAxisPos tempPos = *rPlayerPos;
			tempPos += NightGrid[j];
			if(_used[j] == 0 && CGameMisc::MySqrt(*rPlayerPos, tempPos) <= maxDist)
			{
				*index = j;

				// 已经找到位置
				*rTar = tempPos;
				return true;
			}
		}
	}

	return false;
}

bool CAvoidOverlap::outsideCycle( TAxisPos* rTar, const TAxisPos* rMonsterPos, const TAxisPos* rPlayerPos, sint8 maxDist, sint8 minDist, sint16* index )
{
	for(sint32 i = maxDist; i > 0; --i)
	{
		for(sint32 j = NightGridAdjust[i][0]; j <= NightGridAdjust[i][1]; ++j)
		{
			TAxisPos tempPos = *rPlayerPos;
			tempPos += NightGrid[j];
			if(_used[j] == 0 && CGameMisc::MySqrt(*rPlayerPos, tempPos) <= maxDist)
			{
				*index = j;

				// 已经找到位置
				*rTar = tempPos;
				return true;
			}
		}
	}

	return false;
}

CAvoidOverlap::CAvoidOverlap( void )
{
	memset( _used, 0, sizeof(uint8)*MAX_FRACTION+1 );
}

sint32 CAvoidOverlap::getCyclePosNum( sint8 index )
{
	if(index <= 0 || index > MAX_ATTACK_RANGE )
	{
		return 0;
	}

	return NightGridAdjust[index][1]-NightGridAdjust[index][0];
}

sint32 CAvoidOverlap::getCyclePosNum( sint8 maxDist, sint8 minDist )
{
	sint32 count = 0;
	for( sint8 i = minDist; i < maxDist; ++i )
	{
		count += (NightGridAdjust[i][1]-NightGridAdjust[i][0]);
	}

	return count;
}