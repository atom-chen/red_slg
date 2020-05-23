// @BEGNODOC
/********************************************************************
	created:	2013/08/15
	created:	15:8:2013   15:07
	file base:	game_randdropstruct
	file ext:	h
	author:		Z_Y_R
	
	purpose:	随机掉落模块结构
*********************************************************************/
#ifndef _GAME_RANDDROPSTRUCT_H_
#define _GAME_RANDDROPSTRUCT_H_

#include "core/base_util.h"

#include "game_util.h"
#include "game_struct.h"
#include "server_define.h"

#pragma pack(push, 1)
// @ENDDOC

/// 公用随机掉落结构(权重的)
typedef struct RandDropComInfo
{
	TItemTypeID_t	itemTypeID;		///< 道具编号ID
	TItemNum_t		minNum;			///< 最小数量
	TItemNum_t		maxNum;			///< 最大数量
	TOdd_t			oddsmin;		///< 起始权重
	TOdd_t			oddsmax;		///< 结束权重

	RandDropComInfo()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}
}TRandDropComInfo;

typedef std::vector<struct RandDropComInfo> TRandDropComInfoVec;

/// 对应单个随机掉落结构体
typedef struct RandDropConfigInfo
{
	TRandDropID_t			dropid;			///< 掉落ID
	TRandDropComInfoVec		cominfovec;	///< 具体随机的列表对象
	//TOdd_t					allWeigth;	///< 对应机率总权重

	RandDropConfigInfo()
	{
		clean();
	}

	void clean()
	{
		dropid = 0;
		cominfovec.clear();
		//allWeigth = 0;
	}
}TRandDropConfigInfo;


/// 公用随机掉落结构 机率的
typedef struct RandDropComInfoEx
{
	TItemTypeID_t	itemTypeID;		///< 道具编号ID
	sint32			minNum;			///< 最小数量
	sint32			maxNum;			///< 最大数量
	TOdd_t			oddsmin;		///< 起始机率(权重)
	TOdd_t			oddsmax;		///< 结束机率(权重)

	RandDropComInfoEx()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}
}TRandDropComInfoEx;

//随机奖励列表
typedef std::vector<struct RandDropComInfoEx> TRandDropComInfoVecEx;
//必奖励列表
typedef std::vector<struct RandDropComInfoEx> TRewardComInfoVecEx;

/// 对应单个随机掉落结构体
typedef struct RandDropConfigInfoEx
{
	TRandDropID_t			dropid;				///< 掉落ID
	TValueType_t			oddandweitype;		///< 概率权重类型
	TOdd_t					allWeigth;			///< 对应机率总权重
	TRandDropComInfoVecEx	dropcominfovec;		///< 具体随机的列表对象
	TRewardComInfoVecEx		rewardcominfovec;	///< 必需奖励列表

	RandDropConfigInfoEx()
	{
		clean();
	}

	void clean()
	{
		dropid			= 0;
		allWeigth		= 0;
		oddandweitype	= 0;
		dropcominfovec.clear();
		rewardcominfovec.clear();
	}
}TRandDropConfigInfoEx;

// @BEGNODOC
#pragma pack(pop)

#endif //_GAME_RANDDROPSTRUCT_H_
// @ENDDOC