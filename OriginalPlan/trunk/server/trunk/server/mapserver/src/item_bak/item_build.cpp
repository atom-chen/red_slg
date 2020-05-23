#include "item_build.h"
#include "item_base.h"

#include "../bagitem_tbl.h"

CItemBuild::CItemBuild()
{

}

CItemBuild::~CItemBuild()
{

}

bool CItemBuild::createItem(const TItemInfo * itemInfo, CItemData * pItemData, EBagType type)
{
	if (pItemData == NULL)
	{
		gxError("Can't new CItemBaseObj!ItemTypeID={0},ItemNum={1}", itemInfo->itemTypeID, itemInfo->itemNum);
		return false;
	}

	CItemTbl * pbag = DItemTblMgr.find(itemInfo->itemTypeID);
	if(!pbag)
	{
		return false;
	}
	//编号
	pItemData->_itemData.itemTypeID = itemInfo->itemTypeID;
	//数量
	pItemData->_itemData.itemNum = itemInfo->itemNum;

	////分配GUID
	//pitemobj->_itemData.itemGUID = _updateItemGUID();
	////设置下标
	//pitemobj->_itemData.itemIndex = itemindex;
	////更新时间(没有操作时间)
	//pitemobj->_itemData.updateTime = 0;

	//目前没有绑定
	//itemobj->_itemData.isBind		= pbag->bagiteminfo.
	//itemobj->_itemData.TcommonItemAttr = 

	//根据道具类型，更新对应配置
	//UpdateTargetTable(itemobj, type);

	return true;
}

bool CItemBuild::createItem(TItemTypeID_t itemTypeID, TItemNum_t itemNum, CItemData * pItemData, EBagType type)
{
	TItemInfo itemInfo;
	itemInfo.itemTypeID = itemTypeID;
	itemInfo.itemNum = itemNum;
	return createItem(&itemInfo, pItemData, type);
}

void CItemBuild::updateTables(CItemData * pItemData, EBagType type)
{
	// 目前只有背包类型
	switch(type)
	{
	case BAGCONTAINTER_TYPE:
		{
			pItemData->updateTables(pItemData->getItemTypeID());
			break;
		}
	default:
		break;
	}
}

TItemInfoVec CItemAndTokenHelper::getTItemInfoVec()
{
	TItemInfoVec tempvec;
	for (TItemRewardVec::iterator iter = _ItemInfoVecEX.begin(); iter != _ItemInfoVecEX.end(); ++iter)
	{
		CItemTbl * pItemTbl = DItemTblMgr.find(iter->itemTypeID);
		if (!pItemTbl)
		{
			continue;
		}

		ItemInfo iteminfo;
		if (pItemTbl->itemType != static_cast<TItemType_t>(TOKENITEM_TYPE))
		{
			iteminfo.clean();
			iteminfo.itemTypeID = iter->itemTypeID;
			iteminfo.itemNum = iter->itemNum;
			tempvec.push_back(iteminfo);
		}
	}

	return tempvec;
}

TItemRewardVec CItemAndTokenHelper::getTokenInfoVec()
{
	TItemRewardVec tempvec;
	for (TItemRewardVec::iterator iter = _ItemInfoVecEX.begin(); iter != _ItemInfoVecEX.end(); ++iter)
	{
		CItemTbl * pitem = DItemTblMgr.find(iter->itemTypeID);
		if(!pitem)
		{
			continue;
		}

		ItemReward iteminfo;
		if (pitem->itemType == static_cast<TItemType_t>(TOKENITEM_TYPE))
		{
			iteminfo.clean();
			iteminfo.itemTypeID = iter->itemTypeID;
			iteminfo.itemNum = iter->itemNum;
			tempvec.push_back(iteminfo);
		}
	}

	return tempvec;
}
