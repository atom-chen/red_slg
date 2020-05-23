#ifndef _MISSION_TBL_H_
#define _MISSION_TBL_H_

#include "game_util.h"
#include "tbl_config.h"
#include "tbl_loader.h"
#include "game_struct.h"
#include "bag_struct.h"
#include "item_struct.h"

/// 任务杀怪
typedef struct _MissionKills
{
	_MissionKills(TMonsterTypeID_t id, sint32 num)
	{
		this->id = id;
		this->monsterNum = num;
	}
	TMonsterTypeID_t id;			///< 怪物类型ID
	sint32 monsterNum;				///< 怪物数目
}TMissionKills;

///< 任务收集物品
typedef struct _MissionItem
{
	_MissionItem(TItemType_t id, TItemNum_t num)
	{
		this->id = id;
		this->itemNum = num;
	}
	TItemTypeID_t	id;				///< 物品类型ID
	TItemNum_t itemNum;				///< 物品数目

	bool operator == (_MissionItem& rhs)
	{
		return id == rhs.id;
	}
}TMissionItem;

/// 任务表
class CMissionConfigTbl : public CConfigTbl
{
public:
	TMissionTypeID_t id;										///< ID
	uint8 type;													///< 任务类型(当前所有的任务都为主线任务)
	uint8 aimType;												///< 目标类型
	std::vector<TMissionKills> aimMonsters;						///< 目标怪物
	std::vector<TMissionItem> aimItems;							///< 目标道具
	TMissionTypeID_t nextId;									///< 后置ID
	TLevel_t openLevel;											///< 任务开放等级
	TNPCTypeID_t acceptNpcId;									///< 接任务NPC
	TNPCTypeID_t finishNpcId;									///< 交任务NPC
	TGold_t awardGameMoney;										///< 奖励的游戏币
	TExp_t awardExps;											///< 奖励的经验
	TItemVec awardItems;										///< 奖励的物品
	TMissionTypeID_t preId;										///< 前置任务

public:
	TScriptID_t scriptID;										///< 脚本ID
	EMissionEvent eventFlag;									///< 事件标记
	sint32 paramTarget;											///< 目标参数
	sint32 paramNum;											///< 目标数目
	TItemTypeID_t itemTypeID1;									///< 奖励物品
	TItemNum_t itemNum1;										///< 奖励物品
	TItemTypeID_t itemTypeID2;									///< 奖励物品
	TItemNum_t itemNum2;										///< 奖励物品
	TItemTypeID_t itemTypeID3;									///< 奖励物品
	TItemNum_t itemNum3;										///< 奖励物品

public:
	inline bool isEvent(EMissionEvent events){ return eventFlag == events; }
	inline bool isDialog(){ return isEvent(MISSION_EVENT_DIALOG); }
	inline bool isKillMonster(){ return isEvent(MISSION_EVENT_KILL_MONSTER); }
	inline bool isCollectItem(){ return isEvent(MISSION_EVENT_COLLECT_ITEM); }
	inline bool isGuanQia(){ return isEvent(MISSION_EVENT_GUANQIA); }

public:
	virtual bool onAfterLoad(void* arg);		///< 加载后事件
	bool checkConfig();							///< 检查配置
	bool initConfig();							///< 配置初始化

public:
	// 获取事件类型
	EMissionEvent getEventType()
	{
		return (EMissionEvent)eventFlag;
	}

public:
	DObjToStringAlias(CMissionConfigTbl, TMissionTypeID_t, MissionID, id);
	DMultiIndexImpl1(TMissionTypeID_t, id, INVALID_MISSION_TYPE_ID);
};

typedef std::vector<std::vector<CMissionConfigTbl*> > TMissionVec;
typedef CHashMap<TMissionTypeID_t, CMissionConfigTbl*> TMissionHash;

class CMissionTblLoader :
	public CConfigLoader<CMissionTblLoader, CMissionConfigTbl> 
{
public:
	//typedef CConfigLoader<CMissionTblLoader, CMissionConfigTbl> TBaseType;
	DSingletonImpl();
	DConfigFind();
public:
	CMissionTblLoader();
	~CMissionTblLoader();

public:
	virtual bool readRow(ConfigRow* row, sint32 count, CMissionConfigTbl* missionRow);
	virtual bool onAfterLoad(void* arg);

public:
	TMissionTypeID_t maxMissionID;		// 最大任务ID
	TMissionHash majorTbl;				// 主线任务
};

#define DMissionTblMgr CMissionTblLoader::GetInstance() 

#endif	// _MISSION_TBL_H_
