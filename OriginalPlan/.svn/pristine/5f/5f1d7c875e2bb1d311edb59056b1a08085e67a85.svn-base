#ifndef _MOD_MISSION_H_
#define _MOD_MISSION_H_

#include "game_errno.h"
#include "game_util.h"
#include "game_module.h"
#include "mission_tbl.h"
#include "mission_struct.h"

class CHumanDBMissionLoad;
class CRole;

// 任务掉落物品结构
typedef struct _MissionDropItem
{
	TItemTypeID_t itemTypeID;
	TMissionTypeID_t missionID;

	_MissionDropItem(TItemTypeID_t itemTypeID)
	{
		this->itemTypeID = itemTypeID;
		this->missionID = INVALID_MISSION_TYPE_ID;
	}

	_MissionDropItem(TItemTypeID_t itemTypeID, TMissionTypeID_t missionID)
	{
		this->itemTypeID = itemTypeID;
		this->missionID = missionID;
	}

	bool operator == (TItemTypeID_t itemTypeID) const
	{
		return itemTypeID == this->itemTypeID;
	}

	bool operator == (const _MissionDropItem& rhs) const
	{
		return rhs.itemTypeID == itemTypeID;
	}
}TMissionDropItem;
typedef std::multimap<TMonsterTypeID_t, TMissionTypeID_t> TMissionMonsterMap;		// 杀怪表
typedef std::vector<TMissionDropItem> TMissionItemMap;								// 物品表 @TODO
typedef std::multimap<TNPCTypeID_t, TMissionTypeID_t> TMissionNpcDlgMap;			// NPC对话
typedef std::multimap<TChapterTypeID, TMissionTypeID_t> TMissionGuanQiaMap;		// 通过关卡任务

#pragma  pack(push, 1)
typedef struct _OwnMission : public TMissionBase
{
public:
	_OwnMission()
	{
		cleanUp();
	}

public:
	bool isFinish();
	CMissionConfigTbl* getMissionRow();
	uint32 getRemainItem(TItemTypeID_t itemTypeID);
	bool isItemFull(CRole* pRole);
}TOwnMission;
#pragma pack(pop)
typedef std::map<TMissionTypeID_t, TOwnMission> TAcceptMissionMap;					// 已接任务表
typedef std::map<TMissionTypeID_t, TOwnMission*> TAcceptMissionPtrMap;				// 已接任务表

class CRole;

class CModMission : public CGameRoleModule
{
	friend class CGmCmdFunc;

public:
	typedef CGameRoleModule TBaseType;

public:
	CModMission() : TBaseType() {
		_missions = NULL;
	}
	~CModMission() {}

public:
	virtual bool onLoad();
	virtual void onSave(bool offLineFlag);
	virtual bool init(CRole* role);
	virtual void onSendData();

	// 任务逻辑处理
public:
	// 接受任务
	EGameRetCode acceptMission(TMissionTypeID_t missionID);
	// 提交任务
	EGameRetCode submitMission(TMissionTypeID_t missionID);                              

	// 任务数据管理
private:
	void onDeleteMission(CMissionConfigTbl* missionRow, bool sendMsg);				// 删除任务
	void onCompleteMission(CMissionConfigTbl* missionRow);							// 任务已经完成
	void onSaveMission(TOwnMission* mission, bool offLineFlag);						// 保存任务
	void onLoadMission(TOwnMission* mission);										// 加载任务
public:
	void addToAcceptMission(TOwnMission* mission);
	void deleteFromAcceptMission(TMissionTypeID_t missionTypeID);
	void setLastFinishMissionID(TMissionTypeID_t missionTypeID);

	// 任务条件检测
public:
	// 是否可接受
	EGameRetCode checkAccept(CMissionConfigTbl* missionRow);
	// 是否可提交
	EGameRetCode checkSubmit(TOwnMission* mission);
	// 接取之后处理的事情
	EGameRetCode afterAccept(TOwnMission* mission);
	// 任务奖励
public:
	// 提交奖励
	void submitGains(CMissionConfigTbl* missionRow);
	// 主支线普通奖励
	void submitNormalGains(CMissionConfigTbl* missionRow);
	// 奖励经验
	void awardExp(CRole* pRole, TExp_t exp);
	// 提交扣除
	EGameRetCode submitConsume(CMissionConfigTbl* missionRow);

	// 事件回调
public:
	void onOffline();
	void onMonsterKill(TMonsterTypeID_t monsterTypeID, sint32 num = 1);
	void onAddItem(TItemTypeID_t itemTypeID, TItemNum_t itemNum);
	void onDesItem(TItemTypeID_t itemTypeID, TItemNum_t itemNum);
	void onNpcDlg(TNPCTypeID_t npcID);
	void onFinishChapter(TChapterTypeID chapterTypeID);

	// 重建回调函数
	void rebuildCallFunc();
	void rebuildCallFunc(EMissionEvent eventType);
	void rebuildKillMonsterFunc();
	void rebuildNpcDlgFunc();
	void rebuildItemFunc();
	void rebuildGuanQiaFunc();

	// 添加回调函数
	void addCall(TOwnMission* mission, bool rebuildEventFlag = false);
	void addItemCall(TOwnMission* mission);
	void addKillCall(TOwnMission* mission);
	void addDlgCall(TOwnMission* mission);
	void addGuanQiaCall(TOwnMission* mission);

	// 通知任务变化
public:
	void sendUpdateCompleted(TOwnMission* mission);
	void sendUpdateCompleted(CMissionConfigTbl* missionRow);
	void sendUpdateFinish(TOwnMission* mission);
	void sendUpdateMission(TOwnMission* mission);
	void sendUpdateParams(TOwnMission* mission);
	void sendDelMission(TMissionTypeID_t missionID);
	void sendAcceptableMission();
	void sendAcceptedMission();

	// 是否有事件
public:
	inline void rebuildEvent();
	inline bool isEvent(EMissionEvent events){ return _eventFlags.get(events); }
	inline bool isDialog(){ return _eventFlags.get(MISSION_EVENT_DIALOG); }
	inline bool isKillMonster(){ return _eventFlags.get(MISSION_EVENT_KILL_MONSTER); }
	inline bool isCollectItem(){ return _eventFlags.get(MISSION_EVENT_COLLECT_ITEM); }
	inline bool isGuanQia(){ return _eventFlags.get(MISSION_EVENT_GUANQIA); }

public:
	// 怪物掉落任务物品
	bool isTaksItem(TItemTypeID_t itemID);						
	// 得到任务物品剩余数目
	uint32 getTaskItemRemainNum(TItemTypeID_t itemID);			
	// 任务是否存在
	bool isExist(TMissionTypeID_t missionID);     

	// 数据存储
public:
	void rebuildData();
	TAcceptMissionPtrMap getAcceptMissionPtrMap();

	// 为GM命令接口
private:
	EGameRetCode checkForceFinish(TOwnMission* mission);
	void finishAll();
	void forceFinishAll();
	void forceFinishNoAccept(TMissionTypeID_t missionID);
	void forceFinish(TMissionTypeID_t missionID);
	void cleanAcceptedMission(TMissionTypeID_t missionID);
	void cleanAllAcceptedMission();
	std::string showAll();
	void show(const char* msg, TMissionTypeID_t missionID);
	void show(const char* msg, TOwnMission* mission);

private:
	CHumanDBMissionLoad* _missions;             // 任务数据
	TAcceptMissionMap _acceptMissionMap;        // 接取任务列表
	TMissionEventFlag _eventFlags;              // 事件标记

	TMissionMonsterMap killsMap;                // 杀怪
	TMissionItemMap itemMap;                    // 物品
	TMissionNpcDlgMap dlgMap;                   // 对话
	TMissionGuanQiaMap guanQiaMap;				// 关卡
};

#endif	// _MOD_MISSION_H_