#include "mod_mission.h"
#include "game_exception.h"
#include "module_def.h"
#include "map_db_role_process.h"
#include "role.h"
#include "packet_cm_mission.h"
#include "new_role_tbl.h"

bool CModMission::init( CRole* pRole )
{
	FUNC_BEGIN(MISSION_MOD);

	if(!TBaseType::init(pRole))
	{
		return false;
	}

	_missions = &(getRole()->getHumanDB()->missionLoad);
	_eventFlags.clearAll();

	return true;

	FUNC_END(false);
}

EGameRetCode CModMission::acceptMission( TMissionTypeID_t missionID )
{
	FUNC_BEGIN(MISSION_MOD);

	CMissionConfigTbl* missionRow = DMissionTblMgr.find(missionID);
	if(NULL == missionRow)
	{
		return RC_MISSION_NO_EXIST;
	}
	EGameRetCode retCode = RC_MISSION_NO_EXIST;

	DBreakable
	{
		if(NULL != missionRow)
		{
			// 接任务NPC检测
// 			if(missionRow->acceptNpcId != 0 && !getRole()->isVisitNpc(missionRow->acceptNpcId))	@TODO
// 			{
// 				return RC_NPC_NO_RANGE;
// 			}

			retCode = checkAccept(missionRow);
			if(!IsSuccess(retCode))
			{
				gxWarning("Accept mission, can't pass check!ReturnCode={0}", (sint32)retCode);
				break;
			}

			TOwnMission mission;
			mission.missionID = missionID;
			mission.eventType = missionRow->getEventType();
			mission.status = MISSION_STATUS_EXECUTED;
			mission.acceptTime = DTimeManager.nowSysTime();
			mission.acceptLevel = getRole()->getLevel();
			mission.params.addSize();
			mission.params[0].nMaxParam = missionRow->paramNum;
			mission.params[0].nParam = 0;

			// 接取后事件
			retCode = afterAccept(&mission);
			if(!IsSuccess(retCode))
			{
				gxWarning("Accept mission, after accept failed!ReturnCode={0}", (sint32)retCode);
				return retCode;
			}

			addToAcceptMission(&mission);
			addCall(&mission, true);
			rebuildData();
			getRole()->onMissionAccept(missionID, (EMissionType)missionRow->type, &mission);
			sendUpdateMission(&mission);

			retCode = RC_SUCCESS;
		}
	}

	return retCode;

	FUNC_END(RC_MISSION_NO_EXIST);
}

EGameRetCode CModMission::submitMission( TMissionTypeID_t missionID )
{
	FUNC_BEGIN(MISSION_MOD);

	gxAssert(missionID >= 0 && missionID < MAX_CHAR_FINISH_MISSION_NUM);
	if(missionID < 0 || missionID >= MAX_CHAR_FINISH_MISSION_NUM)
	{
		gxError("Mission id is too big!MissionID={0}", missionID);
		return RC_FAILED;
	}

	TAcceptMissionMap::iterator iter = _acceptMissionMap.find(missionID);
	if(iter == _acceptMissionMap.end())
	{
		gxWarning("Submit mission failed, can't find mission!MissionID={0},ReturnCode={1},{2}",
			missionID, (sint32)RC_MISSION_NO_EXIST, getRole()->toString());
		return RC_MISSION_NO_EXIST;
	}
	CMissionConfigTbl* missionRow = DMissionTblMgr.find(missionID);
	if(NULL == missionRow)
	{
		gxWarning("Submit mission failed, can't find mission!MissionID={0},ReturnCode={1},{2}",
			missionID, (sint32)RC_MISSION_NO_EXIST, getRole()->toString());
		return RC_MISSION_NO_EXIST;
	}
	TOwnMission& mission = iter->second;

	EGameRetCode retCode = checkSubmit(&mission);
	if(!IsSuccess(retCode))
	{
		gxWarning("Submit mission failed, can't pass check!MissionID={0},ReturnCode={1},{2}",
			missionID, (sint32)retCode, getRole()->toString());
		return retCode;
	}

	getRole()->onMissionSubmit(missionID, (EMissionType)missionRow->type, &mission);

	// 提交奖励
	submitGains(missionRow);
	onCompleteMission(missionRow);

	// 删除提交消耗, 放在删除任务后面提高性能
	submitConsume(missionRow);

	gxInfo("Submit mission!MissionID={0}", missionID);

	return RC_SUCCESS;

	FUNC_END(RC_MISSION_NO_EXIST);
}

void CModMission::onDeleteMission( CMissionConfigTbl* missionRow, bool sendMsg )
{
	FUNC_BEGIN(MISSION_MOD);

	TAcceptMissionMap::iterator iter = _acceptMissionMap.find(missionRow->id);
	if(iter != _acceptMissionMap.end())
	{
		if(sendMsg)
		{
			sendDelMission(missionRow->id);
		}

		deleteFromAcceptMission(missionRow->id);
		rebuildData();
	}

	FUNC_END(DRET_NULL);
}

void CModMission::onCompleteMission( CMissionConfigTbl* missionRow )
{
	FUNC_BEGIN(MISSION_MOD);

	// @TODO
	onDeleteMission(missionRow, true);
	rebuildEvent();
	rebuildCallFunc(missionRow->getEventType());
	setLastFinishMissionID(missionRow->id);
	sendAcceptableMission();

	FUNC_END(DRET_NULL);
}

bool CModMission::onLoad()
{
	FUNC_BEGIN(MISSION_MOD);

	_missions = &(getRole()->getHumanDB()->missionLoad);

	// 接受任务重置
	for(sint32 i = 0; i < _missions->data->acceptMissions.size(); ++i)
	{
		if(_missions->data->acceptMissions[i].isActiveMission())
		{
			TOwnMission mission;
			CMissionConfigTbl* missionRow = DMissionTblMgr.find(_missions->data->acceptMissions[i].missionID);
			if(NULL == missionRow)
			{
				gxError("Can't find mission!{0},{1}", _missions->data->acceptMissions[i].toString(), getRole()->toString());
				return false;
			}

			memcpy(&mission, &(_missions->data->acceptMissions[i]), sizeof(_missions->data->acceptMissions[i]));

			std::pair<TAcceptMissionMap::iterator, bool> insertIter = 
				_acceptMissionMap.insert(TAcceptMissionMap::value_type(_missions->data->acceptMissions[i].missionID, mission));
			if(insertIter.second)
			{
				onLoadMission(&insertIter.first->second);
			}
		}
	}

	rebuildCallFunc();
	rebuildEvent();
	rebuildData();

	return true;

	FUNC_END(false);
}

void CModMission::onSave(bool offLineFlag)
{
	FUNC_BEGIN(MISSION_MOD);

	if(offLineFlag)
	{
		onOffline();
	}

	_missions->data->acceptMissions.resize((sint32)_acceptMissionMap.size());
	uint32 i = 0;
	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter, ++i)
	{
		TOwnMission& mission = iter->second;
		onSaveMission(&mission, offLineFlag);
		memcpy(&(_missions->data->acceptMissions[i]), &mission, sizeof(_missions->data->acceptMissions[i]));
	}

	FUNC_END(DRET_NULL);
}

void CModMission::onOffline()
{
	FUNC_BEGIN(MISSION_MOD);

	// 下线清除相关临时数据

	FUNC_END(DRET_NULL);
}

EGameRetCode CModMission::checkAccept( CMissionConfigTbl* missionRow )
{
	FUNC_BEGIN(MISSION_MOD);

	EGameRetCode retCode = RC_MISSION_NO_EXIST;

	// 任务是否已经接取
	if(_acceptMissionMap.find(missionRow->id) != _acceptMissionMap.end())
	{
		return RC_MISSION_HAS_ACCEPT;
	}

	// 等级
	if(_role->getLevel() < missionRow->openLevel)
	{
		return RC_MISSION_NO_LEVEL;
	}

	// 任务已经完成过
	if(missionRow->type == MISSION_TYPE_MAJOR)
	{
		// 主线和支线不能重复完成
		if(_missions->data->finishMissions.get(missionRow->id))
		{
			return RC_MISSION_HAS_FINISH;
		}
	}

	// 前置任务
	CNewRoleTbl* pNewRowTbl = DNewRoleTblMgr.find(getRole()->getProtypeID());
	if(NULL != pNewRowTbl)
	{
		if(pNewRowTbl->initMissionID != missionRow->id && missionRow->preId != INVALID_MISSION_TYPE_ID
			&& !_missions->data->finishMissions.get(missionRow->preId))
		{
			return RC_MISSION_NO_PRI_ID;
		}
	}

	return RC_SUCCESS;

	FUNC_END(RC_MISSION_NO_EXIST);
}

EGameRetCode CModMission::checkSubmit( TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	EGameRetCode retCode = RC_SUCCESS;

	gxAssert(mission->status == MISSION_STATUS_EXECUTED || mission->status == MISSION_STATUS_FINISHED);

	// 检测交任务NPC是否已经访问
// 	if(mission.missionRow->finishNpcId != 0 && !_role->isVisitNpc(mission.missionRow->finishNpcId))	 @TODO
// 	{
// 		return RC_NPC_NO_RANGE;
// 	}

	// 检测任务是否已经完成
	switch (mission->getMissionRow()->getEventType())
	{
	case MISSION_TYPE_INVALID:
		{
			gxAssert(false);
		}break;
	case MISSION_EVENT_COLLECT_ITEM:	// 收集物品
		{
			if (!mission->isItemFull(getRole()))
			{
				retCode = RC_MISSION_NO_COLLECT_ITEM;
			}
		}break;
	case MISSION_EVENT_KILL_MONSTER:	// 杀怪
	case MISSION_EVENT_DIALOG:			// 对话
	case MISSION_EVENT_GUANQIA:			// 关卡
		{
			if (!mission->isFinish())
			{
				retCode = RC_MISSION_NO_FINISHED;
			}
		}
		break;
	default:
		{
			gxAssert(false);
		}
	}

	// 提交奖励背包空间是否足够
	CMissionConfigTbl* pMissionRow = mission->getMissionRow();
// 	if (getRole()->getBagMod()->getEmptyGirdNum(BAGCONTAINTER_TYPE) < pMissionRow->awardItems.size())
// 	{
// 		return RC_MISSION_BAG_NO_EMPTY;
// 	}

	return retCode;

	FUNC_END(RC_MISSION_NO_EXIST);
}

void CModMission::submitGains( CMissionConfigTbl* missionRow)
{
	FUNC_BEGIN(MISSION_MOD);

	switch(missionRow->type)
	{
	case MISSION_TYPE_MAJOR:
		{
			submitNormalGains(missionRow);
		}break;
	default :
		{
		}break;
	}

	FUNC_END(DRET_NULL);
}

EGameRetCode CModMission::afterAccept( TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	// 检测任务是否能完成
	switch (mission->eventType)
	{
	case MISSION_EVENT_DIALOG:        // 对话任务
		{
			mission->status = MISSION_STATUS_FINISHED;
		}break;
	default:
		{
		}
	}

	return RC_SUCCESS;

	FUNC_END(RC_MISSION_NO_EXIST);
}

void CModMission::onMonsterKill( TMonsterTypeID_t monsterTypeID, sint32 num  )
{
	FUNC_BEGIN(MISSION_MOD);

	if(isKillMonster())
	{
		bool needRebuild = false;
		std::pair<TMissionMonsterMap::iterator, TMissionMonsterMap::iterator> iterPair = killsMap.equal_range(monsterTypeID);
		for(TMissionMonsterMap::iterator iter = iterPair.first; iter != iterPair.second; ++iter)
		{
			TAcceptMissionMap::iterator missionIter = _acceptMissionMap.find(iter->second);
			if(missionIter == _acceptMissionMap.end())
			{
				gxError("Can't find mission!MissionID={0},{1}", iter->second, getRole()->toString());
				gxAssert(false);
				continue;
			}
			TOwnMission& mission = missionIter->second;
			if(mission.isFinish())
			{
				continue;
			}
			CMissionConfigTbl* pMissionRow = DMissionTblMgr.find(mission.missionID);
			if(NULL == pMissionRow)
			{
				return;
			}
			for(uint32 i = 0; i < pMissionRow->aimMonsters.size(); ++i)
			{
				if(pMissionRow->aimMonsters[i].id == monsterTypeID)
				{
					mission.params[i].nParam += num;
					gxDebug("Monster num add!MonsterID={0},{1}", monsterTypeID, mission.toString());
					if(mission.params[i].isMaxParam())
					{
						needRebuild = true;
					}
					if(mission.isFinish())
					{
						gxDebug("Finish Mission!{0}", mission.toString());
						sendUpdateFinish(&mission);	
					}
					else
					{
						mission.status = MISSION_STATUS_EXECUTED;
						sendUpdateParams(&mission);
					}
					break;
				}
			}
		}

		if(needRebuild)
		{
			rebuildKillMonsterFunc();
			rebuildEvent();
		}
	}

	FUNC_END(DRET_NULL);
}

void CModMission::onAddItem( TItemTypeID_t itemTypeID, TItemNum_t itemNum )
{
	FUNC_BEGIN(MISSION_MOD);

	if(isCollectItem())
	{
		TMissionItemMap::iterator iter = std::find(itemMap.begin(), itemMap.end(), itemTypeID);
		if(iter == itemMap.end())
		{
			return;
		}
		TAcceptMissionMap::iterator missionIter = _acceptMissionMap.find(iter->missionID);
		if(missionIter == _acceptMissionMap.end())
		{
			gxError("Can't find mission!MissionID={0},{1}", iter->missionID, getRole()->toString());
			gxAssert(false);
			return;
		}
		TOwnMission& mission = missionIter->second;
// 		if(mission.isFinish())
// 		{
// 			return;
// 		}
		CMissionConfigTbl* pMissionRow = DMissionTblMgr.find(mission.missionID);
		if(NULL == pMissionRow)
		{
			return;
		}
		bool needRebuild = false;
		for(uint32 i = 0; i < pMissionRow->aimItems.size(); ++i)
		{
			if(pMissionRow->aimItems[i].id == itemTypeID)
			{
				sint32 oldParam = mission.params[i].nParam;
//				mission.params[i].nParam = getRole()->getBagMod()->findBagtype(BAGCONTAINTER_TYPE)->countItemByMarkNum(itemTypeID);
				//gxAssert(mission.params[i].nParam == oldParam+itemNum); @TODO
				gxDebug("Task item num add!ItemID={0},{1}", itemTypeID, mission.toString());

				// @TODO这里可以优化, 不需要重建函数
				if(mission.params[i].isMaxParam())
				{
					needRebuild = true;
				}
				if(mission.isFinish())
				{
					sendUpdateFinish(&mission);
					gxDebug("Finish Mission!{0}", mission.toString());
				}else{
					mission.status = MISSION_STATUS_EXECUTED;
					sendUpdateParams(&mission);
				}

				break;
			}
		}

		if(needRebuild){
			rebuildItemFunc();
			rebuildEvent();
		}
	}

	FUNC_END(DRET_NULL);
}

void CModMission::onDesItem( TItemTypeID_t itemTypeID, TItemNum_t itemNum )
{
	FUNC_BEGIN(MISSION_MOD);

	if(isCollectItem())
	{
		TMissionItemMap::iterator iter = std::find(itemMap.begin(), itemMap.end(), itemTypeID);
		if(iter == itemMap.end())
		{
			return;
		}
		TAcceptMissionMap::iterator missionIter = _acceptMissionMap.find(iter->missionID);
		if(missionIter == _acceptMissionMap.end())
		{
			gxError("Can't find mission!MissionID={0},{1}", iter->missionID, _role->toString());
			gxAssert(false);
			return;
		}
		TOwnMission& mission = missionIter->second;

		CMissionConfigTbl* pMissionRow = DMissionTblMgr.find(mission.missionID);
		if(NULL == pMissionRow)
		{
			return;
		}
		mission.status = MISSION_STATUS_FINISHED;
		bool needRebuild = false;
		for(uint32 i = 0; i < pMissionRow->aimItems.size(); ++i)
		{
			if(pMissionRow->aimItems[i].id == itemTypeID)
			{
				gxDebug("Task item num desc!ItemID={0},{1}", itemTypeID, mission.toString());
				sint32 oldParam = mission.params[i].nParam;
//				mission.params[i].nParam = getRole()->getBagMod()->findBagtype(BAGCONTAINTER_TYPE)->countItemByMarkNum(itemTypeID);
				//gxAssert(mission.params[i].nParam == oldParam-itemNum); @TODO
				// @TODO这里可以优化, 不需要重建函数
				if(mission.params[i].isMaxParam())
				{
					needRebuild = true;
				}
				if(mission.isFinish()){
					sendUpdateFinish(&mission);
					gxDebug("Finish mission!{0}", mission.toString());
				}else{
					mission.status = MISSION_STATUS_EXECUTED;
					sendUpdateParams(&mission);
				}
			}
		}

		if(needRebuild){
			rebuildEvent();
			rebuildItemFunc();
		}
	}

	FUNC_END(DRET_NULL);
}

void CModMission::onNpcDlg( TNPCTypeID_t npcID )
{
	FUNC_BEGIN(MISSION_MOD);

	if(isDialog())
	{
		bool needRebuild = false;
		std::pair<TMissionNpcDlgMap::iterator, TMissionNpcDlgMap::iterator> iterPair = dlgMap.equal_range(npcID);
		for(TMissionNpcDlgMap::iterator iter = iterPair.first; iter != iterPair.second; ++iter)
		{
			TAcceptMissionMap::iterator missionIter = _acceptMissionMap.find(iter->second);
			if(missionIter == _acceptMissionMap.end())
			{
				gxError("Can't find mission!MissionID={0},{1}", iter->second, _role->toString());
				gxAssert(false);
				continue;
			}
			TOwnMission& mission = missionIter->second;
			CMissionConfigTbl* pMissionRow = DMissionTblMgr.find(mission.missionID);
			if(NULL == pMissionRow)
			{
				continue;
			}

			if(pMissionRow->paramTarget == npcID)
			{
				gxDebug("Npc dialog!NpcID={0},{1}", npcID, mission.toString());
				sendUpdateFinish(&mission);
				needRebuild = true;
			}
		}

		if(needRebuild)
		{
			rebuildEvent();
			rebuildNpcDlgFunc();
		}
	}

	FUNC_END(DRET_NULL);
}

void CModMission::onFinishChapter(TChapterTypeID chapterTypeID)
{
	FUNC_BEGIN(MISSION_MOD);

	if(isGuanQia())
	{
		bool needRebuild = false;
		std::pair<TMissionGuanQiaMap::iterator, TMissionGuanQiaMap::iterator> iterPair = guanQiaMap.equal_range(chapterTypeID);
		for(TMissionGuanQiaMap::iterator iter = iterPair.first; iter != iterPair.second; ++iter)
		{
			TAcceptMissionMap::iterator missionIter = _acceptMissionMap.find(iter->second);
			if(missionIter == _acceptMissionMap.end())
			{
				gxError("Can't find mission!MissionID={0},{1}", iter->second, _role->toString());
				gxAssert(false);
				continue;
			}
			TOwnMission& mission = missionIter->second;
			CMissionConfigTbl* pMissionRow = DMissionTblMgr.find(mission.missionID);
			if(NULL == pMissionRow)
			{
				continue;
			}

			if (pMissionRow->paramTarget == chapterTypeID)
			{
				gxDebug("Finish guan qia!GuanQiaTypeID={0},{1}", chapterTypeID, mission.toString());
				mission.params[0].nParam++; 

				if(mission.params[0].isMaxParam())
				{
					needRebuild = true;
				}
				if(mission.isFinish())
				{
					sendUpdateFinish(&mission);
					gxDebug("Finish Mission!{0}", mission.toString());
				}else{
					mission.status = MISSION_STATUS_EXECUTED;
					sendUpdateParams(&mission);
				}

				break;
			}
		}

		if(needRebuild){
			rebuildGuanQiaFunc();
			rebuildEvent();
		}
	}

	FUNC_END(DRET_NULL);
}

void CModMission::rebuildEvent()
{
	FUNC_BEGIN(MISSION_MOD);

	gxDebug("Rebuild all event!");
	_eventFlags.clearAll();

	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter)
	{
		TOwnMission& mission = iter->second;
		if(mission.isCollectItem() || !mission.isFinish())
		{
			_eventFlags.set(mission.eventType);
		}
	}

	FUNC_END(DRET_NULL);
}

void CModMission::rebuildCallFunc()
{
	FUNC_BEGIN(MISSION_MOD);

	killsMap.clear();
	dlgMap.clear();
	itemMap.clear();
	guanQiaMap.clear();

	gxDebug("Rebuild all call func!");

	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter)
	{
		TOwnMission& mission = iter->second;
		addCall(&mission);
	}

	FUNC_END(DRET_NULL);
}

void CModMission::rebuildCallFunc( EMissionEvent eventType )
{
	FUNC_BEGIN(MISSION_MOD);
	switch(eventType)
	{
	case MISSION_EVENT_KILL_MONSTER:
		{
			rebuildKillMonsterFunc();
		}break;
	case MISSION_EVENT_DIALOG:
		{
			rebuildNpcDlgFunc();
		}break;
	case MISSION_EVENT_COLLECT_ITEM:
		{
			rebuildItemFunc();
		}break;
	case MISSION_EVENT_GUANQIA:
		{
			rebuildGuanQiaFunc();
		}break;
	default:
		{
		}
	}
	FUNC_END(DRET_NULL);
}

void CModMission::rebuildKillMonsterFunc()
{
	FUNC_BEGIN(MISSION_MOD);

	gxDebug("Rebuild monster call func!");

	killsMap.clear();

	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter)
	{
		TOwnMission& mission = iter->second;
		if(mission.isKillMonster())
		{
			addKillCall(&mission);
		}
	}

	FUNC_END(DRET_NULL);
}

void CModMission::rebuildNpcDlgFunc()
{
	FUNC_BEGIN(MISSION_MOD);

	gxDebug("Rebuild npc dlg call func!");

	dlgMap.clear();
	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter)
	{
		TOwnMission& mission = iter->second;
		if(mission.isDialog())
		{
			addDlgCall(&mission);
		}
	}

	FUNC_END(DRET_NULL);
}

void CModMission::rebuildGuanQiaFunc()
{
	FUNC_BEGIN(MISSION_MOD);

	gxDebug("Rebuild guan qia call func!");

	guanQiaMap.clear();
	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter)
	{
		TOwnMission& mission = iter->second;
		if(mission.isGuanQia())
		{
			addGuanQiaCall(&mission);
		}
	}

	FUNC_END(DRET_NULL);
}


void CModMission::rebuildItemFunc()
{
	FUNC_BEGIN(MISSION_MOD);

	gxDebug("Rebuild item call func!");

	itemMap.clear();

	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter)
	{
		TOwnMission& mission = iter->second;
		if(mission.isCollectItem())
		{
			addItemCall(&mission);
		}
	}

	FUNC_END(DRET_NULL);
}

void CModMission::addCall( TOwnMission* mission, bool rebuildEventFlag )
{
	FUNC_BEGIN(MISSION_MOD);

	switch (mission->eventType)
	{
	case MISSION_EVENT_KILL_MONSTER:
		{
			addKillCall(mission);
		}break;
	case MISSION_EVENT_DIALOG:
		{
			addDlgCall(mission);
		}break;
	case MISSION_EVENT_COLLECT_ITEM:
		{
			addItemCall(mission);
		}break;
	case MISSION_EVENT_GUANQIA:
		{
			addGuanQiaCall(mission);
		}break;
	default:
		{
		}
	}

	if(rebuildEventFlag){
		rebuildEvent();
	}

	FUNC_END(DRET_NULL);
}

void CModMission::addItemCall( TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	CMissionConfigTbl* missionRow = DMissionTblMgr.find(mission->missionID);
	if(NULL == missionRow)
	{
		gxError("Can't find mission row!MissionID={0}", mission->missionID);
		return;
	}

	for(uint32 i = 0; i < missionRow->aimItems.size(); ++i)
	{
		// 物品有可能会减少, 所以此类任务不管怎么样都需要重新建立事件回调函数
// 		if(mission.params[i].isMaxParam()) 
// 		{
// 			// 达到最大任务物品数
// 			continue;
// 		}

		itemMap.push_back(TMissionDropItem(missionRow->aimItems[i].id, mission->missionID));
	}

	FUNC_END(DRET_NULL);
}

void CModMission::addKillCall( TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	if (mission->isFinish()){
		return;
	}

	CMissionConfigTbl* missionRow = DMissionTblMgr.find(mission->missionID);
	if(NULL == missionRow)
	{
		gxError("Can't find mission row!MissionID={0}", mission->missionID);
		return;
	}

	for(uint32 i = 0; i < missionRow->aimMonsters.size(); ++i)
	{
		if (mission->params[i].isMaxParam())
		{
			continue;
		}

		killsMap.insert(TMissionMonsterMap::value_type(missionRow->aimMonsters[i].id, mission->missionID));
	}

	FUNC_END(DRET_NULL);
}

void CModMission::addDlgCall( TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	if (mission->isFinish())
	{
		return;
	}

	CMissionConfigTbl* missionRow = DMissionTblMgr.find(mission->missionID);
	if(NULL == missionRow)
	{
		gxError("Can't find mission row!MissionID={0}", mission->missionID);
		return;
	}

	gxAssert(missionRow->isDialog() == true);

	dlgMap.insert(TMissionNpcDlgMap::value_type((TNPCTypeID_t)missionRow->paramTarget, mission->missionID));

	FUNC_END(DRET_NULL);
}


void CModMission::addGuanQiaCall( TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	if (mission->isFinish())
	{
		return;
	}

	CMissionConfigTbl* missionRow = DMissionTblMgr.find(mission->missionID);
	if(NULL == missionRow)
	{
		gxError("Can't find mission row!MissionID={0}", mission->missionID);
		return;
	}

	gxAssert(missionRow->isGuanQia() == true);

	guanQiaMap.insert(TMissionGuanQiaMap::value_type((TChapterTypeID)missionRow->paramTarget, mission->missionID));

	FUNC_END(DRET_NULL);
}


void CModMission::sendUpdateMission( TOwnMission* mission )
{
	MCUpdateMissionList missionUpdateList;
	missionUpdateList.missions.resize(1);
	missionUpdateList.missions[0].missionID = mission->missionID;
	missionUpdateList.missions[0].missionStatus = mission->status;
	missionUpdateList.missions[0].params = mission->params;
	_role->sendPacket(missionUpdateList);
}


void CModMission::sendUpdateFinish( TOwnMission* mission )
{
	if (mission->getStatus() != MISSION_STATUS_FINISHED){
		mission->status = MISSION_STATUS_FINISHED;
		sendUpdateMission(mission);
	}
}

void CModMission::sendUpdateParams( TOwnMission* mission )
{
	MCUpdateMissionParam missionParams;
	missionParams.params.pushBack(TPackMissionParams(mission->missionID, &mission->params));
	getRole()->sendPacket(missionParams);
}

void CModMission::sendDelMission( TMissionTypeID_t missionID )
{
	MCDeleteMission delMissions;
	delMissions.missionID = missionID;
	getRole()->sendPacket(delMissions);
}

void CModMission::finishAll()
{
	FUNC_BEGIN(MISSION_MOD);
	std::vector<TMissionTypeID_t> missions;
	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter)
	{
		TOwnMission& mission = iter->second;
		missions.push_back(mission.missionID);
	}
	for(uint32 i = 0; i < missions.size(); ++i)
	{
		submitMission(missions[i]);
	}
	FUNC_END(DRET_NULL);
}

std::string CModMission::showAll()
{
	FUNC_BEGIN(MISSION_MOD);
	std::string str = "=========MissionList=========\n";
	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter)
	{
		TOwnMission& mission = iter->second;
		str += mission.toString();
	}
	return str;
	FUNC_END("");
}

void CModMission::show( const char* msg, TMissionTypeID_t missionID )
{
	FUNC_BEGIN(MISSION_MOD);
	TAcceptMissionMap::iterator iter = _acceptMissionMap.find(missionID);
	if(iter == _acceptMissionMap.end())
	{
		return;
	}
	FUNC_END(DRET_NULL);
}

void CModMission::show( const char* msg, TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	FUNC_END(DRET_NULL);
}

uint32 CModMission::getTaskItemRemainNum( TItemTypeID_t itemID )
{
	TMissionItemMap::iterator iter = std::find(itemMap.begin(), itemMap.end(), itemID);
	if(iter == itemMap.end())
	{
		return 0;
	}

	TAcceptMissionMap::iterator missIter = _acceptMissionMap.find(iter->missionID);
	if(missIter == _acceptMissionMap.end())
	{
		return 0;
	}

	TOwnMission& mission = missIter->second;
	return mission.getRemainItem(itemID);
}

bool CModMission::isTaksItem( TItemTypeID_t itemID )
{
	return std::find(itemMap.begin(), itemMap.end(), itemID) != itemMap.end();
}

void CModMission::sendAcceptableMission()
{
	FUNC_BEGIN(MISSION_MOD);

	if(!_acceptMissionMap.empty()){
		return;
	}
	CNewRoleTbl* pNewRoleRow = DNewRoleTblMgr.find(getRole()->getProtypeID());
	if(NULL == pNewRoleRow){
		gxError("Can't find role row!{0},ProtypeID={1}", getRole()->toString(), (sint32)getRole()->getProtypeID());
		return;
	}
	TMissionTypeID_t nextMissionID = pNewRoleRow->initMissionID;
	MCUpdateMissionList missionList;
	if(_missions->data->lastFinishTypeID != INVALID_MISSION_TYPE_ID)
	{
		CMissionConfigTbl* pTempMissionRow = DMissionTblMgr.find(_missions->data->lastFinishTypeID);	
		if(NULL == pTempMissionRow)
		{
			gxError("Can't find last finish type id!MissionID={0}", _missions->data->lastFinishTypeID);
			return;
		}
		nextMissionID = pTempMissionRow->nextId;
	}
	if(nextMissionID == INVALID_MISSION_TYPE_ID && _missions->data->lastFinishTypeID == INVALID_MISSION_TYPE_ID)
	{
		gxError("Can't find nextMissionID, mission id invalid!");
		return;
	}

	CMissionConfigTbl* pMissionRow = DMissionTblMgr.find(nextMissionID);	
	if(NULL == pMissionRow)
	{
		gxError("Can't find nextMissionID!MissionID={0}", nextMissionID);
		return;
	}

	TPackMission& mission = missionList.missions.addSize();
	mission.missionID = pMissionRow->id;
	if(pMissionRow->openLevel > getRole()->getLevel())
	{
		mission.missionStatus = MISSION_STATUS_ACCEPTING;
	}
	else{
		mission.missionStatus = MISSION_STATUS_ACCEPTED;
	}
	mission.params.addSize();
	mission.params[0].setNMaxParam(pMissionRow->paramNum);
	mission.params[0].setNParam(0);

	for(CArray1<TPackMission>::size_type i = 0; i < missionList.missions.size(); ++i){
		gxDebug("Acceptable mission: MissionID={0}", missionList.missions[i].missionID);
	}

	getRole()->sendPacket(missionList);

	FUNC_END(DRET_NULL);
}

void CModMission::rebuildData()
{
	FUNC_BEGIN(MISSION_MOD);;
	FUNC_END(DRET_NULL);
}

void CModMission::forceFinishAll()
{
	FUNC_BEGIN(MISSION_MOD);

	std::vector<TMissionTypeID_t> missions;
	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter)
	{
		missions.push_back(iter->first);
	}

	for(uint32 i = 0; i < missions.size(); ++i)
	{
		forceFinish(missions[i]);
	}

	FUNC_END(DRET_NULL);
}

void CModMission::forceFinish( TMissionTypeID_t missionID )
{
	FUNC_BEGIN(MISSION_MOD);

	gxAssert(missionID >= 0 && missionID < MAX_CHAR_FINISH_MISSION_NUM);
	if(missionID < 0 || missionID >= MAX_CHAR_FINISH_MISSION_NUM)
	{
		gxError("Mission id is too big!MissionID={0}", missionID);
		return ;
	}

	TAcceptMissionMap::iterator iter = _acceptMissionMap.find(missionID);
	if(iter == _acceptMissionMap.end())
	{
		return ;
	}
	TOwnMission& mission = iter->second;

	EGameRetCode retCode = checkForceFinish(&mission);
	if(!IsSuccess(retCode))
	{
		return;
	}

	CMissionConfigTbl* pMissionRow = DMissionTblMgr.find(missionID);
	// 提交奖励
	submitGains(pMissionRow);
	onCompleteMission(pMissionRow);

	FUNC_END(DRET_NULL);
}

void CModMission::cleanAcceptedMission( TMissionTypeID_t missionID )
{
	FUNC_BEGIN(MISSION_MOD);

	TAcceptMissionMap::iterator iter = _acceptMissionMap.find(missionID);
	if(iter == _acceptMissionMap.end())
	{
		return;
	}

	TOwnMission& mission = iter->second;
	mission.status = MISSION_STATUS_EXECUTED;
	for(sint32 i = 0; i < mission.params.size(); ++i){
		mission.params[i].nParam = 0;
	}

	sendUpdateMission(&mission);

	FUNC_END(DRET_NULL);
}

void CModMission::cleanAllAcceptedMission()
{
	FUNC_BEGIN(MISSION_MOD);

	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter)
	{
		cleanAcceptedMission(iter->first);
	}

	FUNC_END(DRET_NULL);
}

void CModMission::submitNormalGains( CMissionConfigTbl* missionRow )
{
	FUNC_BEGIN(MISSION_MOD);

	if(missionRow->awardExps > 0){
		awardExp(getRole(), missionRow->awardExps);
	}
	if(missionRow->awardGameMoney > 0){
		getRole()->handleAddMoneyPort(ATTR_MONEY, missionRow->awardGameMoney, RECORD_MISSION_AWARD);
	}
	if(!missionRow->awardItems.empty()){
//		getRole()->getBagMod()->addItemVec(missionRow->awardItems, BAGCONTAINTER_TYPE);
	}

	FUNC_END(DRET_NULL);
}

EGameRetCode CModMission::checkForceFinish( TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	gxAssert(mission->status == MISSION_STATUS_EXECUTED || mission->status == MISSION_STATUS_FINISHED);

	CMissionConfigTbl* pMissionRow = DMissionTblMgr.find(mission->missionID);
	if(NULL == pMissionRow)
	{
		return RC_MISSION_NO_EXIST;
	}

	// 提交奖励背包空间是否足够
// 	if (getRole()->getBagMod()->getEmptyGirdNum(BAGCONTAINTER_TYPE) < pMissionRow->awardItems.size())
// 	{
// 		return RC_MISSION_BAG_NO_EMPTY;
// 	}

	return RC_SUCCESS;

	FUNC_END(RC_FAILED);
}

void CModMission::forceFinishNoAccept( TMissionTypeID_t missionID )
{
	FUNC_BEGIN(MISSION_MOD);

	CMissionConfigTbl* missionRow = DMissionTblMgr.find(missionID);
	if(NULL == missionRow)
	{
		return;
	}

	// 前置任务
	if(missionRow->preId != INVALID_MISSION_TYPE_ID && !_missions->data->finishMissions.get(missionRow->preId))
	{
		return;
	}

	_missions->data->finishMissions.set(missionID);
	sendUpdateCompleted(missionRow);

	FUNC_END(DRET_NULL);
}

void CModMission::onSaveMission( TOwnMission* mission, bool offLineFlag )
{
	FUNC_BEGIN(MISSION_MOD);


	FUNC_END(DRET_NULL);
}

void CModMission::onLoadMission( TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	CMissionConfigTbl* pMissionRow = mission->getMissionRow();
	mission->params.resize(1);
	mission->params[0].setNMaxParam(pMissionRow->paramNum);
	if (mission->isFinish()){
		mission->status = MISSION_STATUS_FINISHED;
	}
	FUNC_END(DRET_NULL);
}

bool CModMission::isExist( TMissionTypeID_t missionID )
{
	FUNC_BEGIN(MISSION_MOD);

	return _acceptMissionMap.find(missionID) != _acceptMissionMap.end();

	FUNC_END(false);
}

void CModMission::awardExp( CRole* pRole, TExp_t exp )
{
	pRole->addExp(exp);
}

void CModMission::sendUpdateCompleted( TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	// @TODO

	FUNC_END(DRET_NULL);
}

void CModMission::sendUpdateCompleted( CMissionConfigTbl* missionRow )
{
	FUNC_BEGIN(MISSION_MOD);

	// @TODO

	FUNC_END(DRET_NULL);
}

void CModMission::onSendData()
{
	FUNC_BEGIN(MISSION_MOD);

	sendAcceptedMission();
	sendAcceptableMission();

	FUNC_END(DRET_NULL);
}

void CModMission::sendAcceptedMission()
{
	FUNC_BEGIN(MISSION_MOD);

	MCUpdateMissionList missionList;
	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter){
		TOwnMission& mission = iter->second;
		TPackMission& packMission = missionList.missions.addSize();
		packMission.missionID = mission.missionID;
		packMission.missionStatus = mission.getStatus();
		packMission.params = mission.params;
	}

	if(!missionList.missions.empty())
	{
		getRole()->sendPacket(missionList);
	}

	FUNC_END(DRET_NULL);
}

void CModMission::addToAcceptMission( TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	gxDebug("Add mission!MissionID={0}", mission->missionID);
	_acceptMissionMap.insert(TAcceptMissionMap::value_type(mission->missionID, *mission));

	FUNC_END(DRET_NULL);
}

void CModMission::deleteFromAcceptMission( TMissionTypeID_t missionTypeID )
{
	FUNC_BEGIN(MISSION_MOD);

	gxDebug("Delete mission!MissionID={0}", missionTypeID);
	_acceptMissionMap.erase(missionTypeID);

	FUNC_END(DRET_NULL);
}

void CModMission::setLastFinishMissionID( TMissionTypeID_t missionTypeID )
{
	_missions->data->lastFinishTypeID = missionTypeID;
	_missions->data->finishMissions.set(missionTypeID);
}

EGameRetCode CModMission::submitConsume( CMissionConfigTbl* pMissionRow )
{
	FUNC_BEGIN(MISSION_MOD);

	if(pMissionRow->isCollectItem())
	{
		for(sint32 i = 0; i < (sint32)pMissionRow->aimItems.size(); ++i){
// 			EGameRetCode returnCode = getRole()->getBagMod()->deductTargetItemByMarkNum(
// 				pMissionRow->aimItems[i].id, pMissionRow->aimItems[i].itemNum, BAGCONTAINTER_TYPE);
// 			if(!IsSuccess(returnCode))
// 			{
// 				gxError("Submit mission desc item failed!ItemID={0},MissionID={1}", pMissionRow->aimItems[i].id, pMissionRow->id);
// 				gxAssert(false);
// 				return returnCode;
// 			}
		}
	}

	return RC_SUCCESS;

	FUNC_END(RC_MISSION_NO_EXIST);
}

TAcceptMissionPtrMap CModMission::getAcceptMissionPtrMap()
{
	TAcceptMissionPtrMap accepts;
	for(TAcceptMissionMap::iterator iter = _acceptMissionMap.begin(); iter != _acceptMissionMap.end(); ++iter){
		accepts.insert(TAcceptMissionPtrMap::value_type(iter->first, &(iter->second)));
	}
	return accepts;
}

bool _OwnMission::isFinish()
{
	FUNC_BEGIN(MISSION_MOD);
	gxAssert(status == MISSION_STATUS_EXECUTED || status == MISSION_STATUS_FINISHED);

	if(status == MISSION_STATUS_FINISHED)
	{
		return true;
	}

	CMissionConfigTbl* pMissionRow = DMissionTblMgr.find(missionID);
	if(NULL == pMissionRow)
	{
		return false;
	}

	switch(eventType)
	{
	case MISSION_TYPE_INVALID:
		{
			gxAssert(false);
		}break;
	case MISSION_EVENT_KILL_MONSTER:	// 杀怪
		{            
			for(uint32 i = 0; i < pMissionRow->aimMonsters.size(); ++i)
			{
				if(params[i].nParam < pMissionRow->aimMonsters[i].monsterNum)
				{
					status = MISSION_STATUS_EXECUTED;
					return false;
				}
			}

			//status = MISSION_STATUS_FINISHED;
			return true;

		}break;
	case MISSION_EVENT_COLLECT_ITEM:	// 收集物品
		{
			for(uint32 i = 0; i < pMissionRow->aimItems.size(); ++i)
			{
				if(params[i].nParam < pMissionRow->aimItems[i].itemNum)
				{
					//status = MISSION_STATUS_EXECUTED;
					return false;
				}
			}

			//status = MISSION_STATUS_FINISHED;
			return true;
		}break;
	case MISSION_EVENT_GUANQIA:			// 关卡
		{
			return params[0].getNParam() >= params[0].getNMaxParam();
		}
	case MISSION_EVENT_DIALOG:			// 对话
		{
			return status == MISSION_STATUS_FINISHED;
		}break;
	default:
		{
			gxAssert(false);
		}
	}
	
	return false;

	FUNC_END(false);
}

uint32 _OwnMission::getRemainItem( TItemTypeID_t itemID )
{
	CMissionConfigTbl* pMissionRow = DMissionTblMgr.find(missionID);
	if(NULL == pMissionRow)
	{
		return 0;
	}

	if(isFinish())
	{
		return 0;
	}

	for(uint32 i = 0; i < pMissionRow->aimItems.size(); ++i)
	{
		if(itemID == pMissionRow->aimItems[i].id && params[i].nParam < pMissionRow->aimItems[i].itemNum)
		{
			return pMissionRow->aimItems[i].itemNum-params[i].nParam;
		}
	}

	return 0;
}

CMissionConfigTbl* _OwnMission::getMissionRow()
{
	return DMissionTblMgr.find(missionID);
}

bool _OwnMission::isItemFull(CRole* pRole)
{
	CMissionConfigTbl* pMissionRow = getMissionRow();
	for(sint32 i = 0; i < params.size(); ++i){
// 		if (pRole->getBagMod()->findBagtype(BAGCONTAINTER_TYPE)->countItemByMarkNum(pMissionRow->aimItems[i].id) < pMissionRow->aimItems[i].itemNum)
// 		{
// 			return false;
// 		}
	}

	return true;
}
