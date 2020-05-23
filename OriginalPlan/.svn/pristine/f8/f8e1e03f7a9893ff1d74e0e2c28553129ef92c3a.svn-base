#ifndef _FIGHT_STRUCT_H_
#define _FIGHT_STRUCT_H_

#include "core/carray.h"

#include "game_define.h"
#include "game_util.h"
#include "game_pos.h"
#pragma pack(push, 1)

/// 战斗记录
typedef struct FightRecord
{
	// @member
public:
	EFightType type;							///< 战斗类型
	TMapID_t mapID;								///< 战斗前的地图
	TChapterTypeID chapterTypeID;				///< 关卡类型ID
//	TLevel_t otherRoleLevel;					///< 对方等级
// 	TRoleUID_t otherRoleUID;					///< 对方的RoleUID
// 	TRankNum_t rankNum;							///< 英雄榜排名
// 	TRankNum_t myRankNum;						///< 挑战时自身的等级
public:
	void cleanUp()
	{
		type = FIGHT_TYPE_INVALID;
		mapID = INVALID_MAP_ID;
//		otherRoleUID = INVALID_ROLE_UID;
		chapterTypeID = INVALID_CHAPTER_TYPE_ID;
	}

	bool isFight()
	{
		return type != FIGHT_TYPE_INVALID;
	}

	void openGuanQiaFight(TChapterTypeID chapterTypeID, TMapID_t mapID)
	{
		cleanUp();

		type = FIGHT_TYPE_CHAPTER;
		this->chapterTypeID = chapterTypeID;
		this->mapID = mapID;
	}

// 	void openChallengeOther(TRoleUID_t otherRoleUID, TMapID_t mapID, TRankNum_t rankNum, TLevel_t level, TRankNum_t myRankNum)
// 	{
// 		cleanUp();
// 
// 		type = FIGHT_TYPE_CHALLENGE_OTHER;
// 		this->otherRoleUID = otherRoleUID;
// 		this->mapID = mapID;
// 		this->rankNum = rankNum;
// 		this->otherRoleLevel = level;
// 		this->myRankNum = myRankNum;
// 	}

	bool isGuanQiaFight()
	{
		return type == FIGHT_TYPE_CHAPTER;
	}

// 	bool isChallengeOther()
// 	{
// 		return type == FIGHT_TYPE_CHALLENGE_OTHER;
// 	}
}TFightRecord;	/// 战斗记录


#pragma pack(pop)

#endif	// _FIGHT_STRUCT_H_