#ifndef _MAP_DB_MISSION_H_
#define _MAP_DB_MISSION_H_

#include "core/db_struct_base.h"

#include "map_db_common.h"
#include "mission_struct.h"

#pragma pack(push, 1)

/// 任务数据
typedef struct CHumanMissionData : public GXMISC::TDBStructBase
{
	TAcceptMissionAry acceptMissions;			///< 接受任务列表
	TFinishMissionBit finishMissions;			///< 完成任务列表
	TMissionTypeID_t lastFinishTypeID;				///< 当前完成的任务ID
}TDBMissionData;

#pragma pack(pop)

#endif	// _MAP_DB_MISSION_H_