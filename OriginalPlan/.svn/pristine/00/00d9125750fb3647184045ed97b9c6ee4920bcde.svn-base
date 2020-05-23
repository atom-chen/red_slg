#ifndef _MAP_DATA_BASE_H_
#define _MAP_DATA_BASE_H_

#include "core/multi_index.h"
#include "core/common.h"

#include "game_util.h"
#include "game_struct.h"
#include "game_rand.h"
#include "game_pos.h"
#include "scene_util.h"
#include "tbl_config.h"

#pragma pack(push, 1)
typedef struct _MapDataHeader
{
	sint16 ID;					// 地图ID
	sint16 width;				// 地图宽度
	sint16 height;				// 地图高度
	sint16 blockWidth;			// 格子宽度
	sint16 blockHeight;			// 格子高度
	sint32 blockXWidth;			// 切片宽度(保留)
	sint32 blockXHeight;		// 切片高度(保留)
	sint16 bak1;				// 保留字节
	sint16 blockNum;			// 块大小, 客户端使用

	inline bool isValid(const TAxisPos& pos) const
	{
		return GXMISC::gxBetweenLQ(pos.x, 0, blockNum) && GXMISC::gxBetweenLQ(pos.y, 0, blockNum); 
	}

	inline bool isValid(TAxisPos_t x, TAxisPos_t y) const
	{
		return GXMISC::gxBetweenLQ(x, 0, blockNum) && GXMISC::gxBetweenLQ(y, 0, blockNum); 
	}

}TMapDataHeader;

typedef struct _MapData
{
	TMapDataHeader header;
	uint8** blockAry;

	_MapData()
	{
		blockAry = NULL;
		memset(&header, 0, sizeof(header));
	}
}TMapData;

#pragma pack(pop)

typedef std::vector<TAxisPos> TListPos;
typedef std::vector<TNPCTypeID_t> TMapNpcVec;
typedef std::vector<TTransportTypeID_t> TTransportVec;
typedef std::vector<TMonsterDistributeID_t> TMapMonsterVec;

class CMapBase
{
public:
	CMapBase();
	virtual ~CMapBase();

public:
	void cleanUp();
	bool load( const std::string& name );

	// 子类实现
public:
	virtual uint8 getMapType() { return 0; };	

private :
	//						   (0,0)	(x,0)
	//           		        -------------
	//          	     	    |			|
	//         		            |			|
	//         +-------> X		|			|
	//         |			    |			|
	//         |                |			|
	//         Y                -------------
	//       					(y,0)	(x,y)

public :
	// 地图位置
	inline bool isCanWalk(const TAxisPos* pos, uint8 flag = BLOCK_FLAG_WALK) const;
	inline bool isCanWalk(TAxisPos_t x, TAxisPos_t y, uint8 flag = BLOCK_FLAG_WALK) const;

	// 查找一个范围空位置
	bool findEmptyPos( TAxisPos* pos, TRange_t range );
	// 在一个矩形中查找一个空位置
	bool findEmptyPos( TAxisPos* top, TAxisPos* bottom, TAxisPos* pos );
	bool findRandEmptyPos(TAxisPos* pos, uint8 range);
	bool findRandEmptyPos(TAxisPos* top, TAxisPos* bottom, TAxisPos* pos);
	void randStepPos(TListPos* poss, TAxisPos* srcPos, uint16 nRange, uint32 maxSteps = 0);
	void findRobotPos(TListPos* poss, TAxisPos* srcPos, TAxisPos* destPos);
	bool isLineEmpty(const TAxisPos* srcPos, const TAxisPos* destPos, uint8 flag = BLOCK_FLAG_WALK);
	bool isSkillLineEmpty(const TAxisPos* srcPos, const TAxisPos* destPos, uint8 flag = BLOCK_FLAG_SKILL);
	bool getLineEmptyPos(const TAxisPos* srcPos, const TAxisPos* destPos, TAxisPos* targetPos, uint8 flag = BLOCK_FLAG_WALK);
	// 调整坐标
	void verifyPos(TAxisPos* pos);
	void verifyPos(TAxisPos* top, TAxisPos* bottom, TAxisPos* pos);
	void verifyPos(TAxisPos* srcPos, uint16 range, TAxisPos* pos);

	// 随机一个地图点位置
	void randPos(const TAxisPos* top, const TAxisPos* buttom, TAxisPos* randP);

	// 找出非相交区域的所有点
	template<typename T>
	void rangePosSub(const TAxisPos& pos, uint16 inRange, uint16 outRange, T& cont);

public:
	void pushNpc(TNPCTypeID_t npcTypeID, sint32 num = 1);
	void pushMonster(TMonsterDistributeID_t monsterDistributeID, sint32 num = 1);
	void pushTransport(TTransportTypeID_t transID, sint32 num = 1);
	TMapNpcVec* getNpcs() { return &_npcs; }
	TTransportVec* getTransports(){ return &_transports; }
	TMapMonsterVec* getMonsters() { return &_monsters; }
	sint32 getNpcNum(){ return _npcNum; }
	sint32 getMonsterNum() { return _monsterNum; }

public:
	void setEmptyPos(const TAxisPos* pos) { _emptyPos = *pos; }
	TAxisPos* getEmptyPos() { return &_emptyPos; }
	void setMapID(TMapID_t mapID) { _mapID = mapID; }
	void setMapConfig(CConfigTbl* config){ _mapConfig = config; }
	CConfigTbl* getMapConfig() { return _mapConfig; }
	TMapID_t getMapID() const;
	TAxisPos_t getX() const;
	TAxisPos_t getY() const;

private:
	void initTestMap();

protected:
	TMapData _mapData;				// 地图数据
	TMapID_t _mapID;				// 地图ID
	TMapNpcVec		_npcs;			// NPC的列表
	TMapMonsterVec	_monsters;		// 怪物的列表
	TTransportVec	_transports;	// 传送点列表
	sint32			_npcNum;		// NPC的数目
	sint32 			_monsterNum;	// 怪物的数目
	TAxisPos		_emptyPos;		// 在地图上可行走的位置
	CConfigTbl*		_mapConfig;		// 地图配置表

	DMultiIndexImpl1(TMapID_t, _mapID, INVALID_MAP_ID);
	DFastObjToStringAlias(CMapBase, TMapID_t, MapID, _mapID);
};

template<typename T>
void CMapBase::rangePosSub( const TAxisPos& pos, uint16 inRange, uint16 outRange, T& cont )
{
	TAreaRect inRect;
	TAxisPos inTop;
	TAxisPos inBottom;
	TAxisPos outTop;
	TAxisPos outBottom;

	inTop = pos;
	inTop -= inRange;
	inBottom = pos;
	inBottom += inRange;

	outTop = pos;
	outBottom = pos;
	outTop -= outRange;
	outBottom += outRange;

	verifyPos(&inTop);
	verifyPos(&inBottom);
	verifyPos(&outTop);
	verifyPos(&outBottom);

	inRect.set(inTop, inBottom);

	for(sint32 y = outTop.y; y <= outBottom.y; ++y)
	{
		for(sint32 x = outTop.x; x <= outBottom.x; ++x)
		{
			if(inRect.isContain(x, y))
			{
				continue;	
			}

			if(!isCanWalk(x, y))
			{
				continue;
			}

			TAxisPos p;
			p.x = x;
			p.y = y;
			cont.push_back(p);
		}
	}
}

bool CMapBase::isCanWalk( const TAxisPos* pos, uint8 flag ) const
{
	return isCanWalk(pos->x, pos->y);
}

bool CMapBase::isCanWalk( TAxisPos_t x, TAxisPos_t y, uint8 flag ) const
{
	if(!_mapData.header.isValid(x, y))
	{
		return false;
	}

	return (_mapData.blockAry[x][y] & flag) != 0;
}

#endif	// _MAP_DATA_BASE_H_