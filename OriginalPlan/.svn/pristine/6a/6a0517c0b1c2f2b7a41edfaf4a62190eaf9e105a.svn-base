#include "item_containter.h"
#include "game_struct.h"
#include "item_build.h"
#include "constant_tbl.h"
#include "../bagitem_tbl.h"
#include "../mod_bag.h"
#include "../role.h"

CItemContainer::CItemContainer()
{
	_initContainerInfo();
}

CItemContainer::~CItemContainer()
{
	_itemGUID = 0;
	_pRole = NULL;
}

EGameRetCode CItemContainer::initItemContainter(const TDBItemInfoAry & dbItemAry)
{
	TItemUID_t maxItemGUID = 0;

	for (TDBItemInfoAry::const_iterator iter = dbItemAry.begin(); iter != dbItemAry.end(); ++iter)
	{
		TItemInfo itemInfo;
		itemInfo.itemTypeID = iter->itemTypeID;
		itemInfo.itemNum = iter->itemNum;

		// 流水记录(目前先用log文件记录)
		gxInfo("Add Item Detail Data! marknum{0}, itemnum{1}, itemindex{2}, updatetime{3}", 
			iter->itemTypeID,
			iter->itemNum,
			iter->itemIndex,
			DTimeManager.nowSysTime());

		CItemData * pItem = _objPool.newObj();
		if (pItem == NULL)
		{
			gxError("addBagItem is NULL with itemTypeID{0}!", itemInfo.itemTypeID);
			continue;
		}

		if (!GItemBuild.createItem(&itemInfo, pItem, _bagType))
		{
			gxError("addBagItem is failed with itemTypeID{0}!", itemInfo.itemTypeID);
			continue;
		}

		// 分配GUID
		pItem->_itemData.itemGUID = iter->itemGUID;
		// 设置下标
		pItem->_itemData.itemIndex = iter->itemIndex;
		// 更新时间
		pItem->_itemData.updateTime = iter->updateTime;

		_addItemVecMap(pItem);

		if (iter->itemGUID > maxItemGUID)
		{
			maxItemGUID = iter->itemGUID;
		}
	}

	setItemGUID(maxItemGUID);
	
	return RC_SUCCESS;
}

EGameRetCode CItemContainer::addItem(const TItemInfo * itemInfo, EItemRecordType itemRecordType, TItemIndexID_t * pIndex)
{
	if (itemInfo->itemNum <= 0)
	{
		return RC_BAG_CANNOT_ADDITEM_BYNULL;
	}

	//查找类型
	TItemIndexID_t itemIndex = 0;
	if (!_findEmptyIndex(itemIndex))
	{
		// 背包已满
		gxError("Add item container is full!!!ItemTypeID={0},ItemNum={1}", itemInfo->itemTypeID, itemInfo->itemNum);
		return RC_BAG_IS_FULL;
	}

	EGameRetCode retCode = addItemByIndex(itemInfo, itemIndex, itemRecordType);
	if (pIndex)
	{
		*pIndex = itemIndex;
	}

	return retCode;
}

EGameRetCode CItemContainer::addItemByIndex(const TItemInfo* itemInfo, TItemIndexID_t itemIndex, EItemRecordType itemRecordType)
{
	if (!_isEmptyIndex(itemIndex))
	{
		gxError("Add item by index failed, destIndex is not empty!ItemTypeID={0},ItemNum={1},ItemIndex={2}",
			itemInfo->itemTypeID, itemInfo->itemNum, itemIndex);
		return RC_BAG_ADDITEM_FAILED;
	}

	// 流水记录(目前先用log文件记录)
	gxInfo("Add item Log! itemTypeID={0}, ItemNum={1}, ItemIndex={2}, CreateTime={3}",
		itemInfo->itemTypeID,
		itemInfo->itemNum,
		itemIndex,
		DTimeManager.nowSysTime());

	CItemData * pItem = _objPool.newObj();
	if (pItem == NULL)
	{
		gxError("addBagItem is NULL with ItemTypeID={0}!", itemInfo->itemTypeID);
		return RC_FAILED;
	}

	if (!GItemBuild.createItem(itemInfo, pItem, _bagType))
	{
		gxError("addBagItem is failed with ItemTypeID={0}!", itemInfo->itemTypeID);
		//释放之前的道具对象
		_objPool.deleteObj(pItem);
		return RC_FAILED;
	}

	// 分配GUID
	pItem->_itemData.itemGUID = _genItemGUID();
	// 设置下标
	pItem->_itemData.itemIndex = itemIndex;
	// 更新时间(没有操作时间)
	pItem->_itemData.updateTime = DTimeManager.nowSysTime();

	_addItemVecMap(pItem);

	return RC_SUCCESS;
}

CItemData * CItemContainer::findItemByIndex( TItemIndexID_t index )
{
	if(index >=  _itemDataVec.size())
	{
		gxError("find item fall outside with index!Index={0}", index);
		return NULL;
	}

	return _itemDataVec[index];
}

EGameRetCode CItemContainer::deleteItem( const CItemData * pItem )
{
	CItemData * pTempItem = findItemByIndex(pItem->getItemIndex());
	if (!pTempItem)
	{
		gxError("deleteTargetitem is null with Index{0}!", pItem->_itemData.itemIndex);
		return RC_FAILED;
	}

	TDeleteItemAry tempary;
	TDeleteItem deitem;
	deitem.itemGUID = pTempItem->getItemGUID();
	tempary.pushBack(deitem);
	_pRole->getBagMod()->sendActDeleteItem(tempary, _bagType);

	_deleteItemVecMap(pItem->getItemIndex());
	_objPool.deleteObj(pTempItem);

	return RC_SUCCESS;
}

EGameRetCode CItemContainer::updateItemPosition( CItemData * pItem, TItemIndexID_t destIndex )
{
	if (!pItem)
	{
		return RC_FAILED;
	}
	if (_itemDataVec[destIndex] != NULL)
	{
		return RC_FAILED;
	}

	TActUpdateItemAry updateary;
	TUpdateItem updateitem;
	updateitem.itemGUID = pItem->_itemData.itemGUID;
	updateitem.itemIndex = destIndex;
	updateitem.itemNum = pItem->_itemData.itemNum;
	updateary.pushBack(updateitem);
	_pRole->getBagMod()->sendActUpdateList(updateary, _bagType);

	return RC_SUCCESS;
}

bool CItemContainer::_findEmptyIndex( TItemIndexID_t & itemindex )
{
	for(TItemIndexID_t index = 0; index < _vecSize; index++)
	{
		if(_itemDataVec[index] == NULL)
		{
			itemindex = index;

			return true;
		}
	}

	return false;
}

bool CItemContainer::_isEmptyIndex( TItemIndexID_t itemindex )
{
	if(_vecSize > itemindex && !_itemDataVec[itemindex])
	{
		return true;
	}

	return false;
}

void CItemContainer::initCapacity(TItemContainerSize_t size, TItemContainerSize_t maxSize, EBagType type)
{
	_itemDataVec.clear();
	_itemDataVec.resize(maxSize, 0);
	_vecCapacity = maxSize;
	_vecSize = size;
	_bagType = type;

	//在这里对对象池初始化
	if(false == _objPool.init(_vecCapacity, true))
	{
		gxError("bagitempoll init is failed");
	}
}

CItemData* CItemContainer::findItemByGUID( TItemUID_t guid )
{
	CItemDataMap::iterator iter = _itemDataMap.find(guid);
	if(iter != _itemDataMap.end())
	{
		return iter->second;
	}

	return NULL;
}

CItemData * CItemContainer::findItemByTypeID(TItemTypeID_t itemTypeID)
{
	CItemDataVec::iterator iter = _itemDataVec.begin();
	for(; iter != _itemDataVec.end(); ++iter)
	{
		if(!(*iter))
			continue;

		if ((*iter)->_itemData.itemTypeID == itemTypeID)
		{
			return (*iter);
		}
	}

	return NULL;
}

void CItemContainer::resetContainer()
{
	_itemDataVec.clear();
	_itemDataVec.resize(_vecCapacity, 0);
}

void CItemContainer::_initContainerInfo()
{
	_itemGUID = 0;
	_pRole = NULL;
	_itemOperator.setBagContainter(this);
}

// void CItemContainer::_deleteItemMap( TItemUID_t guid )
// {
// 	CItemDataMap::iterator  iter = _itemDataMap.find(guid);
// 	if(iter == _itemDataMap.end())
// 	{
// 		gxError("deleteitem is failed with guid is {0}!", guid);
// 		return;
// 	}
// 	else
// 	{
// 		iter->second = NULL;
// 		_itemDataMap.erase(iter);
// 	}
// }

EGameRetCode CItemContainer::addNewItem(TItemInfo* itemInfo, EItemRecordType itemRecordType/* = DEFAULT_ADDITEM*/, bool sendMsg /*= true*/, bool checkPile /*= true*/)
{
	if(!_pRole)
	{
		return RC_FAILED;
	}

	gxInfo("Add item ItemTypeID: {0} ItemNum: {1} ItemRecordType: {2}", itemInfo->itemTypeID, itemInfo->itemNum, (sint16)itemRecordType);

	TActUpdateItemAry updateary;		// 下发主更新
	TItemInfoAry additemary;			// 下发主动添加

	if(checkPile)
	{
		CItemDataVec tempItemVec;
		// 查找可以叠加的
		_findSameTypeIDItemList(itemInfo->itemTypeID, tempItemVec);
		// 查出主动更新列表
		// _actUpdateItem(itemInfo, updateary, tempItemVec);
	}

	TItemInfo tempItemInfo = *itemInfo;

	//注意添加的数量超过上限
	while (tempItemInfo.itemNum > 0)
	{
		CItemTbl * pItemTbl = DItemTblMgr.find(tempItemInfo.itemMarkNum);
		if (!pItemTbl)
		{
			return RC_FAILED;
		}

		TItemInfo tempitem;
		tempitem.itemMarkNum = iteminfo.itemMarkNum;
		tempitem.itemNum = iteminfo.itemNum > pItemTbl->bagiteminfo.itemPileLimit ? pItemTbl->bagiteminfo.itemPileLimit : iteminfo.itemNum;

		TItemIndexID_t itemindex = 0;
		EGameRetCode retcode = RC_SUCCESS;
		retcode = addBagItem(tempitem, itemcirs, &itemindex);

		if(retcode == RC_FAILED)
		{
			return RC_FAILED;
		}
		else if(retcode == RC_BAG_IS_FULL)
		{
			return RC_BAG_IS_FULL;
		}

		CItemData * ptempboj = findTargetItemByIndex(itemindex);
		if(!ptempboj)
		{
			gxError("addNewItemOperator is null with Index{0}!", ptempboj->_itemData.itemIndex);
			return RC_FAILED;
		}

		TSendItemInfo sendinteinfo;
		sendinteinfo.itemGUID				= ptempboj->_itemData.itemGUID;
		sendinteinfo.itemIndex				= ptempboj->_itemData.itemIndex;
		sendinteinfo.itemInfo.itemMarkNum	= ptempboj->_itemData.itemMarkNum;
		sendinteinfo.itemInfo.itemNum		= ptempboj->_itemData.itemNum;
		//sendinteinfo.updatetime				= _surplusCDTime;

		//下发给客户端加1
		sendinteinfo.itemIndex	+= 1;
		additemary.pushBack(sendinteinfo);

		//这里才减去
		iteminfo.itemNum -= tempitem.itemNum;
	}

	if(sendmsg)
	{
		if(!updateary.empty())
		{
			_pRole->getBagMod()->sendActUpdateList(updateary, _bagType);
		}

		if(!additemary.empty())
		{
			_pRole->getBagMod()->sendActAdditemList(additemary, itemcirs, _bagType);
		}
	}

	return RC_SUCCESS;
}

EGameRetCode CItemContainer::addNewItemOperator( TItemInfo& iteminfo, TItemIndexID_t desindex, EItemRecordType itemcirs /*= DEFAULT_ADDITEM*/, bool sendmsg /*= true*/ )
{
	if(!_pRole)
	{
		return RC_FAILED;
	}

	gxInfo("add Item markNum: {0} itemNum: {1} itemcirs: {2}", iteminfo.itemMarkNum, iteminfo.itemNum, (sint16)itemcirs);

	TItemInfoAry additemary;			//下发主动添加

	if(iteminfo.itemNum > 0 )
	{
		TItemIndexID_t itemindex = 0;
		EGameRetCode retcode = addBagItemByIndex(iteminfo, desindex, itemcirs);
		if(retcode == RC_FAILED)
		{
			return RC_FAILED;
		}
		else if(retcode == RC_BAG_IS_FULL)
		{
			return RC_BAG_IS_FULL;
		}

		CItemData * ptempboj = findTargetItemByIndex(itemindex);
		if(!ptempboj)
		{
			gxError("addNewItemOperator is null with Index{0}!", ptempboj->_itemData.itemIndex);
			return RC_FAILED;
		}

		TSendItemInfo sendinteinfo;
		sendinteinfo.itemGUID				= ptempboj->_itemData.itemGUID;
		sendinteinfo.itemIndex				= ptempboj->_itemData.itemIndex;
		sendinteinfo.itemInfo.itemMarkNum	= ptempboj->_itemData.itemMarkNum;
		sendinteinfo.itemInfo.itemNum		= ptempboj->_itemData.itemNum;
		//sendinteinfo.updatetime				= _surplusCDTime;

		//下发给客户端加1
		sendinteinfo.itemIndex += 1;
		additemary.pushBack(sendinteinfo);
	}

	if(sendmsg)
	{
		if(!additemary.empty())
		{
			_pRole->getBagMod()->sendActAdditemList(additemary, itemcirs, _bagType);
		}
	}

	return RC_SUCCESS;
}

EGameRetCode CItemContainer::addNewItemVecOperator( TItemInfoVec iteminfovec, TItemInfoVec & recodevec, EItemRecordType itemcirs/* = DEFAULT_ADDITEM*/, bool checkpile /*= true*/, bool sendmsg /*= true*/ )
{
	TActUpdateItemAry updateary;		//下发主更新
	TItemInfoAry additemary;			//下发主动添加

	TItemInfoVec::iterator iter = iteminfovec.begin();
	for(; iter != iteminfovec.end(); ++iter)
	{
		TItemInfo & iteminfo = *iter;

		CBagItemTbl * pbagtbl = DBagitemTblMgr.find(iteminfo.itemMarkNum);
		if(!pbagtbl)
		{
			gxError("addItem pbag is null");
			return RC_BAG_HAVENOT_TARGETITEM;
		}

		if(pbagtbl->bagiteminfo.itemType == static_cast<TItemTypeID_t>(TOKENITEM_TYPE))
		{
			//不能添加代币到背包中
			continue;
		}

		gxInfo("add Item markNum: {0} itemNum: {1} itemcirs: {2}", iteminfo.itemMarkNum, iteminfo.itemNum, (sint16)itemcirs);

		if(checkpile)
		{
			CItemDataVec tempitemvec;
			//查找可以叠加的
			_findSameTypeIDItemList(iteminfo.itemMarkNum, tempitemvec);

			if(!tempitemvec.empty())
			{
				//记录具体奖励情况(注意　是用recodevec　的容器)
				_handleRecode(iteminfo, recodevec);
			}

			//查出主动更新列表
			_actUpdateItem(iteminfo, updateary, tempitemvec);

		}

		if(iteminfo.itemNum > 0 )
		{
			TItemIndexID_t itemindex = 0;
			if(addBagItem(iteminfo, itemcirs, &itemindex) == RC_FAILED)
				return RC_FAILED;

			CItemData * ptempboj = findTargetItemByIndex(itemindex);
			if(!ptempboj)
			{
				gxError("addNewItemOperator is null with Index{0}!", ptempboj->_itemData.itemIndex);
				return RC_FAILED;
			}

			TSendItemInfo sendinteinfo;
			sendinteinfo.itemGUID				= ptempboj->_itemData.itemGUID;
			sendinteinfo.itemIndex				= ptempboj->_itemData.itemIndex;
			sendinteinfo.itemInfo.itemMarkNum	= ptempboj->_itemData.itemMarkNum;
			sendinteinfo.itemInfo.itemNum		= ptempboj->_itemData.itemNum;
			//sendinteinfo.updatetime				= _surplusCDTime;
			//下发给客户端加1
			sendinteinfo.itemIndex += 1;
			additemary.pushBack(sendinteinfo);

			//记录具体奖励情况(注意　是用recodevec　的容器)
			_handleRecode(iteminfo, recodevec);
		}
	}

	if(sendmsg)
	{
		if(!updateary.empty())
		{
			_pRole->getBagMod()->sendActUpdateList(updateary, _bagType);
		}

		if(!additemary.empty())
		{
			_pRole->getBagMod()->sendActAdditemList(additemary, itemcirs, _bagType);
		}
	}

	return RC_SUCCESS;
}

EGameRetCode CItemContainer::deductTargetItem( TItemUID_t guid, TItemNum_t itemnum )
{
	if(!_pRole)
		return RC_FAILED;

	CItemData * ptempboj1 = findTargetItemByGUID(guid);
	if(!ptempboj1)
	{
		gxError("deductTargetItem is null with GUID{0}!", guid);
		return RC_FAILED;
	}

	if(ptempboj1->_itemData.itemNum < itemnum)
	{
		return RC_FAILED;
	}

	ptempboj1->_itemData.itemNum -= itemnum;

	TActUpdateItemAry itemary;

	TactUpdateItem updateitem;
	updateitem.itemGUID		= guid;
	updateitem.itemNum		= ptempboj1->_itemData.itemNum;
	updateitem.itemIndex	= ptempboj1->_itemData.itemIndex;

	//下发给客户端加1
	updateitem.itemIndex += 1;

	itemary.pushBack(updateitem);

	_pRole->getBagMod()->sendActUpdateList(itemary, _bagType);

	gxInfo("扣除操作 物品ID{0}, 数量{1}", ptempboj1->_itemData.itemMarkNum, itemnum);
	return RC_SUCCESS;
}

EGameRetCode CItemContainer::deductTargetItem( TItemIndexID_t index, TItemNum_t itemnum )
{
	if(!_pRole)
		return RC_BAG_HAVENOT_TARGETITEM;

	CItemData * pitem = findTargetItemByIndex(index);
	if(!pitem)
	{
		gxError("deductTargetItem is null with Index{0}!", index);
		return RC_FAILED;
	}

	if(pitem->_itemData.itemNum < itemnum)
	{
		return RC_FAILED;
	}

	pitem->_itemData.itemNum -= itemnum;

	// 判断是否在删除
	if(pitem->_itemData.itemNum == 0)
	{
		if(deleteTargetItem(pitem) == RC_FAILED)
		{
			return RC_BAG_DEDUCTITEM_FAILED;
		}

		return RC_SUCCESS;
	}

	TActUpdateItemAry itemary;

	TactUpdateItem updateitem;
	updateitem.itemGUID		= pitem->_itemData.itemGUID;
	updateitem.itemNum		= pitem->_itemData.itemNum;
	updateitem.itemIndex	= pitem->_itemData.itemIndex;

	//下发给客户端加1
	updateitem.itemIndex += 1;

	itemary.pushBack(updateitem);

	_pRole->getBagMod()->sendActUpdateList(itemary, _bagType);

	return RC_SUCCESS;
}

EGameRetCode CItemContainer::deductTargetItemByMark( TItemMarkNum_t mark, TItemNum_t itemnum )
{
	if(!_pRole)
		return RC_LOGIN_NO_ROLE;

	CItemDataVec::iterator iter = _itemDataVec.begin();
	for(; iter != _itemDataVec.end(); )
	{
		CItemData * pitem = *iter;
		if(!pitem)
		{
			++iter;
			continue;
		}

		if((pitem)->_itemData.itemMarkNum == mark &&
			itemnum > 0)
		{
			TItemNum_t tempnum = pitem->_itemData.itemNum;
			TItemNum_t wastenum = 0;
			if(tempnum > itemnum)
			{
				if(deductTargetItem(pitem->_itemData.itemGUID, itemnum) == RC_FAILED)
				{
					return RC_BAG_DEDUCTITEM_FAILED;
				}

				itemnum = 0;
				++iter;
				continue;
			}
			else
			{
				//TactdeleteItem deitem;
				//deitem.itemGUID = pitem->_itemData.itemGUID;

				//保留
				if(deleteTargetItem(pitem) == RC_FAILED)
				{
					return RC_BAG_DEDUCTITEM_FAILED;
				}

				//(注意此操作)
				iter = _itemDataVec.begin();
				// 求出剩余要扣除的道具数量
				itemnum -= tempnum;
				continue;
			}
		}

		iter++;
	}

	return RC_SUCCESS;
}

EGameRetCode CItemContainer::deleteTargetItem( TItemUID_t guid )
{
	CItemData * ptempboj1 = findTargetItemByGUID(guid);
	if(!ptempboj1)
	{
		gxError("deleteTargetitem is null with itemGUID {0}!", guid);
		return RC_FAILED;
	}

	//CItemBaseObj * ptempboj = findTargetItemByIndex(ptempboj1->_itemData.itemIndex);
	//if(!ptempboj)
	//{
	//	gxError("deleteTargetitem is null with Index{0}!", ptempboj1->_itemData.itemIndex);
	//	return RC_FAILED;
	//}
	//保存guid 和 index
	TItemUID_t		tempguid  = ptempboj1->_itemData.itemGUID;
	TItemIndexID_t	tempindex = ptempboj1->_itemData.itemIndex;

	gxInfo("删除操作 物品ID{0}, 数量{1}", ptempboj1->_itemData.itemMarkNum, ptempboj1->_itemData.itemNum);
	_objPool.deleteObj(ptempboj1);

	_itemDataVec[tempindex] = NULL;
	_deleteItemMap(tempguid);

	//注意：这里赋值
	TDeleteItemAry tempary;
	TactdeleteItem deitem;
	deitem.itemGUID = tempguid;
	tempary.pushBack(deitem);
	_pRole->getBagMod()->sendActDeleteItem(tempary, _bagType);

	return RC_SUCCESS;
}

EGameRetCode CItemContainer::deleteItem( TItemIndexID_t index )
{
	CItemData * ptempboj = findItemByIndex(index);
	if(!ptempboj)
	{
		gxError("deleteTargetitem is null with Index{0}!", index);
		return RC_BAG_DELETEITEM_FAILED;
	}

	//保存guid 和 index
	TItemUID_t		tempguid  = ptempboj->_itemData.itemGUID;
	TItemIndexID_t	tempindex = ptempboj->_itemData.itemIndex;

	gxInfo("删除操作 物品ID{0}, 数量{1}", ptempboj->_itemData.itemMarkNum, ptempboj->_itemData.itemNum);
	_objPool.deleteObj(ptempboj);

	_itemDataVec[tempindex] = NULL;
	_deleteItemMap(tempguid);

	//注意：这里赋值
	TDeleteItemAry tempary;
	TactdeleteItem deitem;
	deitem.itemGUID = tempguid;
	tempary.pushBack(deitem);
	_pRole->getBagMod()->sendActDeleteItem(tempary, _bagType);

	return RC_SUCCESS;
}

TItemNum_t CItemContainer::countItemByType( TItemTypeID_t type )
{
	TItemNum_t countrecode = 0;
	CItemDataVec::iterator iter = _itemDataVec.begin();
	for(; iter != _itemDataVec.end(); ++iter)
	{
		CBagItemTbl * pbag = DBagitemTblMgr.find((*iter)->_itemData.itemMarkNum);
		if(!pbag)
		{
			return countrecode;
		}

		if(pbag->bagiteminfo.itemType == type)
		{
			countrecode += (*iter)->_itemData.itemNum;
		}
	}
	return countrecode;
}

TItemNum_t CItemContainer::countItemByMarkNum( TItemMarkNum_t marknum )
{
	TItemNum_t countrecode = 0;
	CItemDataVec::iterator iter = _itemDataVec.begin();
	for(; iter != _itemDataVec.end(); ++iter)
	{
		if(!(*iter))
		{
			continue;
		}

		if((*iter)->_itemData.itemMarkNum == marknum)
		{
			countrecode += (*iter)->_itemData.itemNum;
		}
	}
	return countrecode;
}

void CItemContainer::_findSameTypeIDItemList( TItemMarkNum_t type, CItemDataVec & objvec )
{
	for(TSize_t index = 0; index < _vecSize; index++)
	{
		if(!_itemDataVec[index])
			continue;

		//找出可以叠加的
		CBagItemTbl * pbag = DBagitemTblMgr.find(type);
		if(!pbag)
		{
			gxError("_findSameMarkItemList find table baginfo is failed with marknum {0}!", type);
			return;
		}
		if(_itemDataVec[index]->_itemData.itemMarkNum == type &&
			_itemDataVec[index]->_itemData.itemNum < pbag->bagiteminfo.itemPileLimit)
		{
			objvec.push_back(_itemDataVec[index]);
		}
	}
}

void CItemContainer::_actUpdateItem( TItemInfo* iteminfo, TActUpdateItemAry & itemary, CItemDataVec & objvec )
{
	CItemDataVec::iterator iter = objvec.begin();
	for(; iter != objvec.end(); ++iter)
	{
		CBagItemTbl * pbag = DBagitemTblMgr.find((*iter)->_itemData.itemMarkNum);
		if(!pbag)
		{
			gxError("_actUpdateItem find table baginfo is failed with marknum {0}!", (*iter)->_itemData.itemMarkNum);
			return;
		}

		TItemNum_t tempnum = pbag->bagiteminfo.itemPileLimit - (*iter)->_itemData.itemNum;
		if(tempnum > 0 && iteminfo.itemNum > 0)
		{
			if(iteminfo.itemNum > tempnum)
			{
				iteminfo.itemNum -= tempnum;
				(*iter)->_itemData.itemNum += tempnum;
			}
			else
			{
				(*iter)->_itemData.itemNum += iteminfo.itemNum;
				iteminfo.itemNum = 0;
			}

			TactUpdateItem itemtemp;
			itemtemp.itemGUID	= (*iter)->_itemData.itemGUID;
			itemtemp.itemIndex	= (*iter)->_itemData.itemIndex;
			itemtemp.itemNum	= (*iter)->_itemData.itemNum;

			//下发给客户端加1
			itemtemp.itemIndex += 1;
			itemary.pushBack(itemtemp);
		}
	}
}

EGameRetCode CItemContainer::sellItem( TItemUID_t guid )
{
	CItemDataMap::iterator iter = _itemDataMap.find(guid);
	if(iter == _itemDataMap.end())
	{
		return RC_BAG_HAVENOT_TARGETITEM;
	}

	CItemData * pitem = iter->second;
	if(!pitem)
	{
		return RC_BAG_HAVENOT_TARGETITEM;
	}

	CBagItemTbl * pbagtbl = DBagitemTblMgr.find(pitem->_itemData.itemMarkNum);
	if(!pbagtbl)
	{
		return RC_BAG_HAVENOT_TARGETITEM;
	}

	//不能卖
	if(pbagtbl->bagiteminfo.sale == CANNOT_SELL)
	{
		return RC_BAG_SELLTITEM_FAILED;
	}

	//加钱
	TGold_t tempgold = 0;
	for(TItemNum_t count = pitem->_itemData.itemNum; count > 0; count--)
	{
		tempgold += pbagtbl->bagiteminfo.gold;
	}

	_pRole->handleAddMoneyPort(ATTR_MONEY, tempgold, RECORD_SELL_ITEM);

	return deleteTargetItem(guid);
}

EGameRetCode CItemContainer::sellItem( TItemIndexID_t index )
{
	if(_itemDataVec[index] == NULL)
	{
		return RC_BAG_HAVENOT_TARGETITEM;
	}
	
	CItemData * pitem = _itemDataVec[index];
	if(!pitem)
	{
		return RC_BAG_HAVENOT_TARGETITEM;
	}

	CBagItemTbl * pbagtbl = DBagitemTblMgr.find(pitem->_itemData.itemMarkNum);
	if(!pbagtbl)
	{
		return RC_BAG_HAVENOT_TARGETITEM;
	}

	//不能卖
	if(pbagtbl->bagiteminfo.sale == CANNOT_SELL)
	{
		return RC_BAG_SELLTITEM_FAILED;
	}

	//加钱
	TGold_t tempgold = 0;
	for(TItemNum_t count = pitem->_itemData.itemNum; count > 0; count--)
	{
		tempgold += pbagtbl->bagiteminfo.gold;
	}

	_pRole->handleAddMoneyPort(ATTR_MONEY, tempgold, RECORD_SELL_ITEM);

	return deleteTargetItem(index);
}


bool CItemContainer::isCDTime( const CItemData * pitem )
{
	CBagItemTbl * pbag = DBagitemTblMgr.find(pitem->_itemData.itemMarkNum);
	if(!pbag)
	{
		return false;
	}

	GXMISC::CGameTime cdtime = DTimeManager.nowSysTime() - pitem->_itemData.updateTime.getGameTime();
	//比较是用秒(注意使用公共cd)
	if(cdtime.getGameTime() < GetConstant<GXMISC::TGameTime_t>(TREASUREHUNT_ITEM_COMCD))
	{
		return false;
	}

	return true;
}

GXMISC::CGameTime CItemContainer::surplusCDTime( const CItemData * pitem )
{
	GXMISC::CGameTime cdtime;
	cdtime.setGameTime(0);

	CBagItemTbl * pbag = DBagitemTblMgr.find(pitem->_itemData.itemMarkNum);
	if(!pbag)
	{
		return 0;
	}

	cdtime = DTimeManager.nowSysTime() - pitem->_itemData.updateTime.getGameTime();

	if(cdtime.getGameTime() > 0)
	{
		return cdtime;
	}
	else
	{
		return 0;
	}
}

EGameRetCode CItemContainer::isFullBagGuird()
{
	if(_vecSize > _vecCapacity ||
		_itemDataMap.size() >= _vecSize)
	{
		return RC_FAILED;
	}
	else
	{
		return RC_SUCCESS;
	}
}

void CItemContainer::_handleRecode( const TItemInfo & info, TItemInfoVec & tempvec )
{
	TItemInfoVec::iterator iter = tempvec.begin();
	for(; iter != tempvec.end(); ++iter)
	{
		if(iter->itemMarkNum == info.itemMarkNum)
		{
			iter->itemNum += info.itemNum;
			return;
		}
	}

	tempvec.push_back(info);
}

EGameRetCode CItemContainer::updateTSise(TItemContainerSize_t var)
{
	CHumanDBData * phudata = _pRole->getHumanDBData();
	if(!phudata)
	{
		return RC_FAILED;
	}

	_vecSize += var;
	TItemContainerSize_t maxgridnum = GetConstant<TItemContainerSize_t>(BUY_MAX_GRIDNUM);
	_vecSize = _vecSize >= maxgridnum ? maxgridnum : _vecSize;

	TItemContainerSize_t tempgridnum = _vecSize - GetConstant<TItemContainerSize_t>(BUY_INIT_GRIDNUM);
	phudata->baseData.setbagOpenGridNum(tempgridnum);

	return RC_SUCCESS;
}

bool CItemContainer::isEnoughItemNum(TItemType_t type, TItemNum_t itemNum)
{
	return countItemByType(type) >= itemNum;
}

bool CItemContainer::isEnoughItemNum(TItemTypeID_t itemTypeID, TItemNum_t itemNum)
{
	return countItemByTypeID(itemTypeID) >= itemNum;
}

void CItemContainer::_addItemVecMap(CItemData* pItem)
{
	_itemDataVec[pItem->_itemData.itemIndex] = pItem;
	_itemDataMap.insert(std::make_pair(pItem->_itemData.itemGUID, pItem));
}

void CItemContainer::_deleteItemVecMap(TItemIndexID_t index)
{
	if (index < _vecSize)
	{
		CItemData* pItem = _itemDataVec[index];
		if (NULL == pItem)
		{
			return;
		}

		_itemDataVec[index] = NULL;
		_itemDataMap.erase(pItem->getItemGUID());
	}
}

bool CItemContainer::canPileItems(TItemTypeID_t itemTypeID, TItemNum_t itemNum)
{

}
