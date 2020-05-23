
#ifndef _LOG_RECORDE_STRUCT_H_
#define _LOG_RECORDE_STRUCT_H_

#include "game_util.h"

#pragma pack(push, 1)


// 金钱（游戏币、元宝）改变途径枚举
enum EMoneyChangeType
{
	// 同时改变游戏币和元宝
	MONEY_CHANGE_GM = 0,						// GM获取
	MONEY_CHANGE_MAIL,							// 邮件发送扣除
	MONEY_CHANGE_RECV_MAIL_AFFIX,				// 提取邮件附件增加
	MONEY_CHANGE_SEND_MAIL_FAILED,				// 发送邮件失败返还
	MONEY_CHANGE_EXCHANGE_DEL,					// 交易扣除
	MONEY_CHANGE_EXCHANGE_SUCCESS,				// 交易获得
	MONEY_CHANGE_EXCHANGE_FAILED,				// 交易失败返还
	MONEY_CHANGE_CONSIGN_SUCCESS,				// 寄售获得
	MONEY_CHANGE_RELATION_TEACHER,				// 师徒奖励
	MONEY_CHANGE_RELATION_ONLINE,				// 好友在线奖励
	MONEY_CHANGE_RISK_MAP,						// 副本奖励
	MONEY_CHANGE_LEVEL_AWARD,					// 等级奖励
	MONEY_CHANGE_PK_AWARD,						// 战场奖励
	MONEY_CHANGE_GIFT_AWARD,					// 开启礼包赠送
	MONEY_CHANGE_TRAVEL_AWARD,					// 环游奖励
	MONEY_CHANGE_AIM_AWARD,						// 江湖目标奖励
	MONEY_CHANGE_BOSS_AWARD,					// 杀死世界BOSS奖励
	MONEY_CHANGE_TREASURE_AWARD,				// 夺宝奇兵奖励
	MONEY_CHANGE_GUILD_GROUND_AWARD,			// 帮派地盘奖励
	MONEY_CHANGE_CROP_GATHER,					// 收获种植奖励
	MONEY_CHANGE_CROP_STEAL,					// 偷取植物奖励
	MONEY_CHANGE_CROP_SHOVEL,					// 铲除植物奖励

	// 改变游戏币
	MONEY_CHANGE_GOLD_OPERATION_EQUIP=50,		// 强化装备扣除游戏币
	MONEY_CHANGE_GOLD_EXCHANGE,					// 交易扣除游戏币
	MONEY_CHANGE_GOLD_CREATE_GUILD,				// 创建帮派扣除游戏币
	MONEY_CHANGE_GOLD_GUILD_CONTRIBUTE,			// 捐献帮派扣除游戏币
	MONEY_CHANGE_GOLD_PET_STUDY_SKILL,			// 宠物学习技能扣除游戏币
	MONEY_CHANGE_GOLD_ACCEPT_MISSION,			// 接取任务扣除游戏币
	MONEY_CHANGE_GOLD_MISSION_ADD,              // 任务奖励增加游戏币
	MONEY_CHANGE_GOLD_ESCORT_DES_PLEDGE,        // 接取镖车扣除押金
	MONEY_CHANGE_GOLD_REPEAT_MISSION_REFRESH,   // 循环任务刷新扣除游戏币
	MONEY_CHANGE_GOLD_ESCORT_MISSION_REFRESH,   // 押镖任务刷新扣除的游戏币
	MONEY_CHANGE_GOLD_ESCORT_ADD_PLEDGE,        // 押镖任务返还押金
	MONEY_CHANGE_GOLD_STUDY_SKILL,              // 角色学习技能扣除游戏币
	MONEY_CHANGE_GOLD_CONSIGN_CONSUME,			// 寄售扣除游戏币
	MONEY_CHANGE_GOLD_CONSIGN_FAILED_RETURN,	// 寄售失败返还游戏币
	MONEY_CHANGE_GOLD_CONSIGN_BUY,				// 寄售购买扣除游戏币
	MONEY_CHANGE_GOLD_CONSIGN_BUY_FAILED,		// 寄售购买失败返还游戏币
	MONEY_CHANGE_GOLD_ENTRUST_CONSUME,			// 托付扣除游戏币
	MONEY_CHANGE_GOLD_ENTRUST_FAILED,			// 托付失败返还游戏币
	MONEY_CHANGE_GOLD_RENT_CONSUME,				// 租赁扣除游戏币
	MONEY_CHANGE_GOLD_FOSTER_CONSUME,			// 培养成功增加游戏币
	MONEY_CHANGE_GOLD_CHAT_CONSUME,				// 聊天频道扣除游戏币
	MONEY_CHANGE_GOLD_SHOP_SELL,				// 商店卖物品增加游戏币
	MONEY_CHANGE_GOLD_SHOP_BUY,					// 商店购买扣除游戏币
	MONEY_CHANGE_GOLD_SHOP_RECV,				// 商店回购扣除扣除游戏币
	MONEY_CHANGE_GOLD_ITEMBOX,					// 物品掉落增加游戏币
	MONEY_CHANGE_GOLD_TELEPORT,					// 传送扣除游戏币
	MONEY_CHANGE_GOLD_LIMIT_MALL,				// 限购商城购买扣除游戏币

	// 改变元宝
	MONEY_CHANGE_RMB_CREATE_GUILD=100,			// 创建帮派扣除元宝
	MONEY_CHANGE_RMB_GUILD_CONTRIBUTE,			// 捐献帮派扣除元宝
	MONEY_CHANGE_RMB_ENTER_RISK_MAP,			// 进入雷锋塔扣除变元宝
	MOENY_CHANGE_RMB_EXTED_PACK,				// 扩展背包扣除元宝
	MONEY_CHANGE_RMB_OPEN_PET_GRID,				// 开启宠物扣除变元宝
	MONEY_CHANGE_RMB_MALL_BUY,					// 商城购买扣除元宝
	MONEY_CHANGE_RMB_ADD_RISK_MAP_TIMES,		// 增加进入副本次数扣除元宝
    MONEY_CHANGE_RMB_FAST_FINISH_MISSION,       // 快速完成任务扣除元宝
    MONEY_CHANGE_RMB_ACCPET_MISSION,            // 接取任务扣除元宝
    MONEY_CHANGE_RMB_ACCPET_MISSION_EXCEED_NUM, // 接取任务超过免费次数扣除元宝
    MONEY_CHANGE_RMB_REPEAT_MISSION_REFRESH,    // 刷新循环任务扣除元宝
    MONEY_CHANGE_RMB_ESCORT_MISSION_REFRESH,    // 刷新押镖任务扣除元宝
    MONEY_CHANGE_RMB_MISSION_ADD,               // 任务奖励增加元宝
    MONEY_CHANGE_RMB_CONSIGN_CONSUME,			// 寄售扣除元宝
	MONEY_CHANGE_RMB_CONSIGN_FAILED_RETURN,		// 寄售失败返还元宝
    MONEY_CHANGE_RMB_CONSIGN_BUY,				// 寄售购买扣除元宝
	MONEY_CHANGE_RMB_CONSIGN_BUY_FAILED,		// 寄售购买失败返还元宝
	MONEY_CHANGE_RMB_ENTRUST_CONSUME,			// 托付扣除元宝
	MONEY_CHANGE_RMB_ENTRUST_FAILED,			// 托付失败返还元宝
	MONEY_CHANGE_RMB_RENT_CONSUME,				// 租赁扣除改变
    MONEY_CHANGE_RMB_FOSTER_CONSUME,			// 培养扣除元宝
    MONEY_CHANGE_RMB_WELFARE,					// 离线福利扣除
	MONEY_CHANGE_RMB_TRAVEL_ROUND,				// 增加环游次数扣除元宝
	MONEY_CHANGE_RMB_RECHARGE,					// 充值增加
	MONEY_CHANGE_RMB_RECHARGE_GET,				// 充值提取增加
	MONEY_CHARGE_RMB_SEND,						// 充值赠送的元宝
	MONEY_CHANGE_RMB_LOTTERY_BEGIN,				// 增加大乐透次数消耗元宝
	MONEY_CHANGE_RMB_LOTTERY_REFRESH,			// 刷新大乐透消耗元宝
	MONEY_CHANGE_RMB_LIMIT_MALL,				// 限购商城购买扣除元宝

	// 改变绑定元宝
	MONEY_CHANGE_BIND_RMB_MALL_BUY=160,			// 购买商城物品扣除绑定元宝
	MONEY_CHANGE_BIND_RMB_ACCEPT_MISSION,		// 接取任务扣除绑定元宝
	MONEY_CHANGE_BIND_RMB_MISSION_ADD,			// 任务奖励扣除绑定元宝
	MONEY_CHANGE_BIND_RMB_VIP,					// 领取VIP福利扣除绑定元宝
	MONEY_CHANGE_BIND_RMB_RECHARGE,				// 充值赠送
	MONEY_CHANGE_BIND_RMB_RECHARGE_GET,			// 充值赠送提取
	MONEY_CHARGE_BIND_RMB_SEND,					// 充值赠送的元宝
};

// 物品改变途径枚举
enum EItemChangeType
{
	ITEM_CHANGE_GM = 0,							// GM命令增加的
	ITEM_ADD_BY_MALL_BUY,						// 商城购买
	ITEM_ADD_BY_EXCHANGE_FAILED,				// 交易失败返还获得的
	ITEM_ADD_BY_EXCHANGE,						// 交易获得的
	ITEM_DESC_BY_EXCHNAGE,						// 交易减少的
	ITEM_ADD_BY_MAIL,							// 邮件获得的
	ITEM_DESC_BY_MAIL,							// 发送邮件减少的
	ITEM_DESC_BY_SELL,							// 卖商店减少的
	ITEM_DESC_BY_DROP,							// 丢弃减少的
	ITEM_ADD_BY_PICK_UP,						// 拾取减少的
	ITEM_ADD_BY_CONSIGN_FAILED,					// 寄售失败返还
	ITEM_ADD_BY_CONSIGN,						// 寄售增加的
	ITEM_ADD_BY_BATTLE_AWARD,					// 战场奖励的
	ITEM_ADD_BY_OPEN_GIFT,						// 开启礼包
	ITEM_ADD_BY_RANDOM_ITEM,					// 开启随机道具
	ITEM_ADD_BY_COMPOSE,						// 合成宝石
	ITEM_ADD_BY_DISTANLE_EQUIP,					// 拆卸宝石
	ITEM_ADD_BY_MISSION_AWARD,					// 任务奖励
	ITEM_ADD_BY_LOGIN,							// 连续登陆奖励
	ITEM_ADD_BY_CD_KEY,							// 使用激活码
	ITEM_DESC_BY_CREATE_GUILD,					// 创建帮派扣除
	ITEM_DESC_BY_USE,							// 双击使用减少的
	ITEM_DESC_BY_STUDY_PET_SKILL,				// 宠物学习技能消耗的
	ITEM_DESC_BY_GUILD_CONTRIBUTE,				// 帮派捐献消耗的
	ITEM_DESC_BY_CONSIGN,						// 寄售消耗的
	ITEM_ADD_BY_SHOP_BUY,						// 商店购买获得的
	ITEM_ADD_BY_LOTTERY,						// 大乐透增加物品
	ITEM_ADD_BY_LIMIT_MALL,						// 限购商城购买获得
};

// 角色行为枚举
enum ERoleActionType
{
	ROLE_ACTION_EXCHANGE = 0,					// 交易行为
	ROLE_ACTION_MAIL,							// 发邮件
	ROLE_ACTION_CONSIGN,						// 寄售
};


typedef struct _MoneyLogParam
{
	TRoleUID_t		_roleUID;
	TObjUID_t		_objUID;
	TRoleName_t		_roleName;
	TGold_t			_addGoldNum;		// 增加的游戏币
	TGold_t			_descGoldNum;		// 消耗的游戏币
	TRmb_t			_addRmbNum;			// 增加的元宝
	TRmb_t			_descRmbNum;		// 消耗的元宝
	TRmb_t			_addBindRmbNum;		// 增加的绑定元宝
	TRmb_t			_descBindRmbNum;	// 消耗的绑定元宝
	TCalluppoint_t	_addCalluppoint;	// 增加的征召令
	TCalluppoint_t	_desCalluppoint;	// 消耗的征召令
	TGold_t			_curGoldNum;		// 当前拥有的总游戏币
	TRmb_t			_curRmbNum;			// 当前拥有的总元宝
	TRmb_t			_curBindRmbNum;		// 当前拥有的总绑定元宝
	TCalluppoint_t	_curCalluppoint;	// 当前拥有的总征召令
	uint8			_changeType;		// 消耗途径（参与EChangeType）
	GXMISC::TGameTime_t		_curTime;			// 当前时间

	_MoneyLogParam()
	{
		cleanUp();
	}

	void cleanUp()
	{
		//_roleUID = INVALID_ROLE_UID;
		//_objUID = INVALID_OBJ_UID;
		//_roleName = INVALID_ROLE_NAME;
		//_addGoldNum = INVALID_GOLD;
		//_descGoldNum = INVALID_GOLD;
		//_addRmbNum = INVALID_RMB;
		//_descRmbNum = INVALID_RMB;
		//_addBindRmbNum = INVALID_RMB;
		//_descBindRmbNum = INVALID_RMB;
		//_curGoldNum = INVALID_GOLD;
		//_curRmbNum = INVALID_RMB;
		//_curBindRmbNum = INVALID_RMB;
		//_changeType = (uint8)MONEY_CHANGE_GM;
		//_curTime = GXMISC::INVALID_GAME_TIME;
		::memset(this, 0, sizeof(*this));
	}
}TMoneyLogParam;


typedef struct _RecordeItemLogParam
{
	TObjUID_t				_objUID;		// 玩家UID
	TRoleName_t				_roleName;
	TItemGUID_t				_itemGuid;		// 物品唯一ID
	TItemMarkNum_t			_itemMarkNum;	// 物品编号
	TItemTypeID_t			_itemTypeID;	// 物品类型ID
	TItemSubTypeID_t		_itemSubType;	// 物品类型子类形ID
	TItemNum_t				_buyNum;		// 购买数量
	TItemNum_t				_useNum;		// 使用数量
	TLevel_t				_roleLevel;		// 角色等级
	GXMISC::TGameTime_t		_curTime;		// 当前时间

	_RecordeItemLogParam()
	{
		cleanUp();
	}

	_RecordeItemLogParam( TItemGUID_t guid, TItemMarkNum_t itemmarknum, TItemTypeID_t itemTypeID, 
		TItemSubTypeID_t itemSubID, TItemNum_t buyNum, TItemNum_t useNum, 
		TObjUID_t objUID, const TRoleName_t& roleName, TLevel_t level )
	{
		cleanUp();
		_objUID			= objUID;
		_roleName		= roleName;
		_itemGuid		= guid;
		_itemMarkNum	= itemmarknum;
		_itemTypeID		= itemTypeID;
		_itemSubType	= itemSubID;
		_buyNum			= buyNum;
		_useNum			= useNum;
		_roleLevel		= level;
		_curTime		= DTimeManager.nowSysTime();
	}

	void cleanUp()
	{
		::memset(this, 0, sizeof(*this));
	}
}TRecordeItemLogParam;

#pragma pack(pop)

#endif