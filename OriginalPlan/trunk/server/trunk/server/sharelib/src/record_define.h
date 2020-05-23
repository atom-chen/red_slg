#ifndef _RECORD_DEFINE_H_
#define _RECORD_DEFINE_H_

#include "core/string_common.h"

// 金钱触发类型
enum EMoneyRecordTouchType
{
	MONEYRECORDDEFINE = 0,			// 默认类型
	MALL_BUYITEM = 1,				// 商城道具购买
	OPEN_BAGGUID = 2,				// 背包开启消耗
	LEVELRAWARD = 3,				// 升级奖励
	RECORD_SELL_ITEM = 4,			// 出售道具
	RECORD_NEW_ROLE_AWARD = 5,		// 新角色赠送的金钱
	RECORD_COMPENSATE_RMB = 6,		// 后台补偿
	RECORD_NEW_ROLE_RMB = 7,		// 新角色赠送的元宝
	RECORD_MISSION_AWARD = 22,		// 任务奖励金钱

	MONEY_GM = 250,					// GM操作

};
DToStringDef(EMoneyRecordTouchType);

// 道具触发类型
enum EItemRecordType
{
	ITEM_RECORD_DEFAULT = 0,			// 默认(添加与删除)状态
	ITEM_RECORD_MALL_BUY = 1,			// 商城购买
	ITEM_RECORD_USE_ITEM = 2,			// 道具使用
	ITEM_RECORD_NEW_ROLE = 3,			// 新角色赠送
	ITEM_RECORD_EXCHANGE_GIFT = 4,		// 兑换码兑换的奖励
	ITEM_RECORD_DROP = 5,				// 丢弃道具

	ITEM_RECORD_ITEM_GM = 250,			// GM操作
};
DToStringDef(EItemRecordType);

#endif