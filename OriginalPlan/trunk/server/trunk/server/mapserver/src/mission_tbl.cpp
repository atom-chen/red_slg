#include "mission_tbl.h"

bool CMissionConfigTbl::onAfterLoad( void* arg )
{
	switch(aimType)
	{
	case MISSION_EVENT_DIALOG:
		{
		}break;
	case MISSION_EVENT_GUANQIA:
		{
		}break;
	case MISSION_EVENT_KILL_MONSTER:
		{
			aimMonsters.push_back(TMissionKills(paramTarget, paramNum));
		}break;
	case MISSION_EVENT_COLLECT_ITEM:
		{
			aimItems.push_back(TMissionItem(paramTarget, paramNum));
		}break;
	default:
		{
			gxAssertEx(false, "Invalid mission aim type!AimType={0}");
		}
	}

	if(itemTypeID1 != INVALID_ITEM_TYPE_ID && itemNum1 != 0){
		awardItems.push_back(TSimpleItem(itemTypeID1, itemNum1));
	}
	if (itemTypeID2 != INVALID_ITEM_TYPE_ID && itemNum2 != 0){
		awardItems.push_back(TSimpleItem(itemTypeID2, itemNum2));
	}
	if (itemTypeID3 != INVALID_ITEM_TYPE_ID && itemNum3 != 0){
		awardItems.push_back(TSimpleItem(itemTypeID3, itemNum3));
	}

	preId = INVALID_MISSION_TYPE_ID;
	eventFlag = (EMissionEvent)aimType;

	return true;
}

bool CMissionConfigTbl::checkConfig()
{
	return true;
}

bool CMissionConfigTbl::initConfig()
{
	return true;
}

CMissionTblLoader::CMissionTblLoader()
{
	maxMissionID = 0;
}

CMissionTblLoader::~CMissionTblLoader()
{
}

bool CMissionTblLoader::onAfterLoad( void* arg )
{
	maxMissionID = 0;
	for(Iterator iter = begin(); iter != end(); ++iter){
		if(iter->second->type == MISSION_TYPE_MAJOR)
		{
			majorTbl.insert(TMissionHash::value_type(iter->first, iter->second));
		}
		if(iter->first > maxMissionID){
			maxMissionID = iter->first;
		}

		CMissionConfigTbl* pMissionRow = find(iter->second->nextId);
		if(NULL != pMissionRow){
			pMissionRow->preId = iter->first;
		}
	}

	return true;
}

bool CMissionTblLoader::readRow( ConfigRow* row, sint32 count, CMissionConfigTbl* destRow )
{
	DReadConfigInt(id, id, destRow);
	destRow->type = MISSION_TYPE_MAJOR;
	DReadConfigInt(aimType, type, destRow);
	DReadConfigInt(paramTarget, taget, destRow);
	DReadConfigInt(paramNum, task_num, destRow);
	DReadConfigInt(nextId, hx_id, destRow);
	DReadConfigInt(openLevel, require_lv, destRow);
	DReadConfigInt(acceptNpcId, npc_re, destRow);
	DReadConfigInt(finishNpcId, npc_cp, destRow);
	DReadConfigInt(awardGameMoney, reward_gold, destRow);
	DReadConfigInt(awardExps, reward_ep, destRow);
	DReadConfigInt(itemTypeID1, reward_item1, destRow);
	DReadConfigInt(itemNum1, item_num1, destRow);
	DReadConfigInt(itemTypeID2, reward_item2, destRow);
	DReadConfigInt(itemNum2, item_num2, destRow);
	DReadConfigInt(itemTypeID3, reward_item3, destRow);
	DReadConfigInt(itemNum3, item_num3, destRow);


	DAddToLoader(destRow);

	return true;
}