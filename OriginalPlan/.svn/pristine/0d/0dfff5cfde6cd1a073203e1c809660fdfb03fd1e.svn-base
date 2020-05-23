#ifndef _ITEM_HELPER_H_
#define _ITEM_HELPER_H_

#include "record_define.h"
#include "game_util.h"

class CRole;
class CItemHelper
{
public:
	/// 添加道具到背包
	static EGameRetCode AddItemToBag(EItemRecordType recordType, CRole* pRole, TItemTypeID_t itemTypeID, TItemNum_t itemNum, bool sendMsg);
	/// 在背包中移动道具
	static EGameRetCode BagMoveItem(CRole* pRole, TContainerIndex_t srcIndex, TContainerIndex_t destIndex);
};

#endif // _ITEM_HELPER_H_