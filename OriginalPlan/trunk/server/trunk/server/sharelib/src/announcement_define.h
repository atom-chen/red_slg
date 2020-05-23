#ifndef _ANNOUNCEMENT_DEFINE_H_
#define _ANNOUNCEMENT_DEFINE_H_

#include "game_util.h"

// enum EAnnouncementID
// {
// 	AID_LOGIN_GIFT = 1,					///< 每日登陆都有礼物可以获取喔。
// 	AID_ROLE_LEVELUP = 2,				///< 恭喜玩家%s达到%d级！
// 	AID_ROLE_VIPUP = 3,					///< 恭喜玩家%s达到VIP%d！特此公告！
// 	AID_ROLE_GET_COMMANDER = 4,			///< 恭喜玩家%s获得英雄%d！
// 	AID_ROLE_PASS_GUANQIA = 5,			///< 恭喜%s通关精英关卡获得%d！
// 	AID_ROLE_PASS_ENDLESS_GUANQIA = 6,	///< 恭喜%s在无尽长廊活动中获得%d！
// 	AID_ROLE_BUY_ITEM = 7,				///< 恭喜%s在商城购买获得%d！
// 	AID_ROLE_GET_ELF = 8,				///< 恭喜玩家获得战灵%d！
// 	AID_ROLE_RANK_LIST10 = 9,			///< 玩家%s在竞技场有如神助，连胜10场，威风凛凛！
// 	AID_ROLE_RANK_LIST20 = 10,			///< 玩家%s在竞技场连战连胜，连胜20场，所向披靡！
// 	AID_ROLE_RANK_LIST30 = 11,			///< 玩家%s在竞技场大发神威，连胜30场，前无古人后无来者！
// 	AID_ROLE_RANK_LIST40 = 12,			///< 玩家%s在竞技场遇神杀神，遇佛杀佛，连胜40场，独孤求败！
// };

class CAnnouncementID
{
public:
	static sint32 AID_LOGIN_GIFT;					///< 每日登陆都有礼物可以获取喔。
	static sint32 AID_ROLE_LEVELUP;					///< 恭喜玩家%s达到%d级！
	static sint32 AID_ROLE_VIPUP;					///< 恭喜玩家%s达到VIP%d！特此公告！
	static sint32 AID_ROLE_GET_COMMANDER;			///< 恭喜玩家%s获得英雄%d！
	static sint32 AID_ROLE_PASS_GUANQIA;			///< 恭喜%s通关精英关卡获得%d！
	static sint32 AID_ROLE_PASS_ENDLESS_GUANQIA;	///< 恭喜%s在无尽长廊活动中获得%d！
	static sint32 AID_ROLE_BUY_ITEM;				///< 恭喜%s在商城购买获得%d！
	static sint32 AID_ROLE_GET_ELF;					///< 恭喜玩家获得战灵%d！
	static sint32 AID_ROLE_RANK_LIST10;				///< 玩家%s在竞技场有如神助，连胜10场，威风凛凛！
	static sint32 AID_ROLE_RANK_LIST20;				///< 玩家%s在竞技场连战连胜，连胜20场，所向披靡！
	static sint32 AID_ROLE_RANK_LIST30;				///< 玩家%s在竞技场大发神威，连胜30场，前无古人后无来者！
	static sint32 AID_ROLE_RANK_LIST40;				///< 玩家%s在竞技场遇神杀神，遇佛杀佛，连胜40场，独孤求败！
};

#endif	// _ANNOUNCEMENT_DEFINE_H_