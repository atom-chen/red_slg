#include "item_base.h"

CItemData::CItemData()
{

}

CItemData::~CItemData()
{

}

void CItemData::updateTables(TItemTypeID_t itemTypeID)
{
	_itemTbl._pItemTbl = DItemTblMgr.find(itemTypeID);
}

void CItemData::clean()
{
	_itemTbl.clean();
	_itemData.clean();
}

TItemData* CItemData::getItemData()
{
	return &_itemData;
}

CItemTbl* CItemData::getItemTbl()
{
	return _itemTbl._pItemTbl;
}

TItemTypeID_t CItemData::getItemTypeID() const
{
	return _itemData.itemTypeID;
}

TItemUID_t CItemData::getItemGUID() const
{
	return _itemData.itemGUID;
}

TItemIndexID_t CItemData::getItemIndex() const
{
	return _itemData.itemIndex;
}
