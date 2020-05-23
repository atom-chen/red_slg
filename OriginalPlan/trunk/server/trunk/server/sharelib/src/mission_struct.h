#ifndef _MISSION_STRUCT_H_
#define _MISSION_STRUCT_H_

#include "core/db_struct_base.h"
#include "core/bit_set.h"
#include "core/fix_array.h"
#include "core/time_manager.h"

#include "server_define.h"
#include "game_define.h"
#include "game_util.h"
#include "streamable_util.h"
#include "base_packet_def.h"

#pragma pack(push, 1)

/// 任务条件参数
typedef struct MissionParam
{
	// @member
public:
	sint32 nMaxParam;		///< 最大的条件个数
	sint32 nParam;			///< 当前已经得到的数目

public:
	sint32 getNMaxParam() const { return nMaxParam; }
	void setNMaxParam(sint32 val) { nMaxParam = val; }
	sint32 getNParam() const { return nParam; }
	void setNParam(sint32 val) { nParam = val; }

public:
	bool isMaxParam(){return getNMaxParam() <= getNParam(); }
}TMissionParam;			///< 任务条件参数

typedef CArray1<TMissionParam, 5> TMissionParamAry;
/// 任务基本结构
typedef struct MissionBase
{
	// @member
public:
	TMissionTypeID_t			missionID;		///< 任务ID
	EMissionEvent				eventType;		///< 任务目标事件(参考EMissionEvent)
	TMissionParamAry			params;			///< 任务参数
	EMissionStatus				status;			///< 状态
	GXMISC::TGameTime_t			acceptTime;		///< 任务接取时间
	TLevel_t					acceptLevel;	///< 接取等级

public:
	MissionBase()
	{
		cleanUp();
	}

public:
	TMissionTypeID_t getMissionID() const { return missionID; }
	void setMissionID(TMissionTypeID_t val) { missionID = val; }
	EMissionEvent getEventType() const { return eventType; }
	void setEventType(EMissionEvent val) { eventType = val; }
	EMissionStatus getStatus() const { return status; }
	void setStatus(EMissionStatus val) { status = val; }
	GXMISC::TGameTime_t getAcceptTime() const { return acceptTime; }
	void setAcceptTime(GXMISC::TGameTime_t val) { acceptTime = val; }
	TLevel_t getAcceptLevel() const { return acceptLevel; }
	void setAcceptLevel(TLevel_t val) { acceptLevel = val; }

public:
	void cleanUp()
	{
		missionID = INVALID_MISSION_TYPE_ID;
		eventType = MISSION_EVENT_INVALID;
		params.clear();
		status = MISSION_STATUS_ACCEPTING;
		acceptTime = DTimeManager.nowSysTime();
		acceptLevel = 1;
	}

	bool isActiveMission( ) const 
	{
		return missionID != INVALID_MISSION_TYPE_ID;
	}

	// 事件
	inline bool isEvent(EMissionEvent events){ return events == eventType; }
	inline bool isDialog(){ return isEvent(MISSION_EVENT_DIALOG); }
	inline bool isKillMonster(){ return isEvent(MISSION_EVENT_KILL_MONSTER); }
	inline bool isCollectItem(){ return isEvent(MISSION_EVENT_COLLECT_ITEM); }
	inline bool isGuanQia() { return isEvent(MISSION_EVENT_GUANQIA); }

	std::string toString()
	{
		std::string str;
		str += GXMISC::gxToString("MissionID=%u,EventType=%s,Status=%u", missionID, getEventTypeStr(eventType).c_str(), status);
		for(uint32 i = 0; i < params.size(); ++i)
		{
			str += GXMISC::gxToString(",MaxParam%u=%u,CurrentParam%u=%u", i, params[i].getNMaxParam(), i, params[i].getNParam());
		}

		str += "\n";
		return str;
	}

	std::string getEventTypeStr(EMissionEvent eventType)
	{
		switch(eventType)
		{
		case MISSION_TYPE_INVALID:
			{
				gxAssert(false);
			}break;
		case MISSION_EVENT_DIALOG:			// 对话
			{
				return "NpcDlg";
			}break;
		case MISSION_EVENT_KILL_MONSTER:	// 杀怪
			{
				return "KillMonster";
			}break;
		case MISSION_EVENT_COLLECT_ITEM:	// 收集物品
			{
				return "CollectItem";
			}break;
		case MISSION_EVENT_GUANQIA:			// 关卡
			{
				return "GuanQia";
			}break;
		default:
			{
				gxAssert(false);
				return "";
			}
		}

		return "";
	}

}TMissionBase;

/// 协议任务结构
typedef struct PackMission : public GXMISC::IStreamableAll
{
	// @member
public:
	TMissionTypeID_t		missionID;		///< 任务ID
	uint8					missionStatus;	///< 任务状态 参考见: @ref EMissionStatus
	TMissionParamAry		params;			///< 任务参数

public:
	DSTREAMABLE_IMPL1(params);

public:
	PackMission()
	{
		cleanUp();
	}

	void cleanUp()
	{
		missionID = INVALID_MISSION_TYPE_ID;
		missionStatus = MISSION_STATUS_ACCEPTING;
		params.clear();
	}
}TPackMission;

/// 任务参数更新结构
typedef struct PackMissionParams : public GXMISC::IStreamableAll
{
	// @member
public:
	TMissionTypeID_t missionID;				///< 任务ID
	TMissionParamAry missionParam;			///< 任务参数

public:
	PackMissionParams()
	{
		missionID = INVALID_MISSION_TYPE_ID;
	}
	PackMissionParams(TMissionTypeID_t missionID, TMissionParamAry* missionParam)
	{
		this->missionID = missionID;
		this->missionParam = *missionParam;
	}

public:
	DSTREAMABLE_IMPL1(missionParam);
}TPackMissionParams;

typedef GXMISC::CFixBitSet<MAX_MISSION_EVENT_NUM> TMissionEventFlag;
typedef GXMISC::CArray<TMissionBase, MAX_CHAR_EXIST_MISSION_NUM> TAcceptMissionAry;		///< 已接任务表
typedef GXMISC::CFixBitSet<MAX_CHAR_FINISH_MISSION_NUM>	TFinishMissionBit;				///< 完成标记

typedef struct DBAcceptMission : public GXMISC::TDBStructBase
{
	TAcceptMissionAry data;
}TDBAcceptMission;
typedef struct DBFinishMissionBit : public GXMISC::TDBStructBase
{
	TFinishMissionBit data;
}TDBFinishMissionBit;

#pragma pack(pop)

#endif