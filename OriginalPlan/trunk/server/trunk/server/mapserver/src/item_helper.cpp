#include "item_helper.h"
#include "game_db_struct.h"
#include "mod_bag.h"
#include "role.h"
#include "item_mod/item_manager.h"
#include "item_mod/item_container.h"
#include "item_mod/item_operator.h"

EGameRetCode CItemHelper::AddItemToBag(EItemRecordType recordType, CRole* pRole, TItemTypeID_t itemTypeID, TItemNum_t itemNum, bool sendMsg)
{
	EGameRetCode retCode = RC_ITEM_NO_EXIST;

	TDbItem dbItem;
	
	// ��������
	if (!DItemMgr.createItem(dbItem, itemTypeID, itemNum))
	{
		return RC_ITEM_NO_EXIST;
	}

	// ��ӵ��ߵ�����
	retCode = pRole->getBagMod()->getBag()->addItem(recordType, &dbItem, true, sendMsg);

	// ��¼��־
	if (IsSuccess(retCode))
	{
		//@TODO ��¼��־
	}

	return retCode;
}

EGameRetCode CItemHelper::BagMoveItem(CRole* pRole, TContainerIndex_t srcIndex, TContainerIndex_t destIndex)
{
	CItemContainer* pSrcBag = pRole->getBagMod()->getBag();
	CItemContainer* pDestBag = pRole->getBagMod()->getBag();

	return CItemOperator::MoveItem(pSrcBag, srcIndex, pDestBag, destIndex);
}
