#include "item.h"
#include "item_container.h"
#include "item_operator.h"
#include "packet_cm_bag.h"

#include "../role.h"

EGameRetCode CItemOperator::EraseItem(CItemContainer *itemConSRC,TContainerIndex_t indexSRC)
{
	if (NULL == itemConSRC)
	{
		return RC_FAILED;
	}
	if (indexSRC >= itemConSRC->getContainerSize() || indexSRC < 0)
	{
		return RC_FAILED;
	}
	CItem* temp = itemConSRC->getItemByIndex(indexSRC);
	if (temp == NULL)
	{
		gxAssert(false);
		return RC_FAILED;
	}
	if (temp->empty())
	{
		gxAssert(false);
		return RC_PACK_SOUROPERATOR_EMPTY;
	}
	if (temp->isLock())
	{
		return RC_PACK_DESTOPERATOR_LOCK;
	}

	return itemConSRC->delItemByIndex(ITEM_RECORD_DROP, indexSRC, true);
}

EGameRetCode  CItemOperator::MoveToEmptyInDiff(CItemContainer *itemConSRC, TContainerIndex_t indexSRC, CItemContainer * itemConDest, TContainerIndex_t indexDest)
{
    CItem* pItemSRC = itemConSRC->getItemByIndex(indexSRC);
    gxAssert(NULL != pItemSRC);

    CTempItem item;
    item.setItem(pItemSRC);
	itemConSRC->delItemByIndex(indexSRC, false);
    itemConDest->setItem(&item, indexDest);

	MCMoveItems moveItems;
    TMoveItem  moveItem;
	moveItem.srcType = itemConSRC->getContainerType();
    moveItem.objUID = item.getObjUID();
    moveItem.destType = itemConDest->getContainerType();
    moveItem.destIndex = indexDest;
    moveItems.items.pushBack(moveItem);
    itemConDest->getOwner()->sendPacket(moveItems);

    return RC_SUCCESS;
}

EGameRetCode CItemOperator::MoveItem(CItemContainer *itemConSRC, TContainerIndex_t indexSRC, TContainerIndex_t indexDest)
{
	if (itemConSRC == NULL)
	{
		return RC_FAILED;
	}
	if (indexSRC >= itemConSRC->getContainerSize() || indexSRC < 0)
	{
		return RC_FAILED;
	}

	if (indexDest >= itemConSRC->getContainerSize() || indexDest < 0)
	{
		return RC_PACK_DESTOPERATOR_HASITEM;
	}
    
	if(indexSRC == indexDest)
	{
		return RC_SUCCESS;
	}

	CItem* pItemSRC = itemConSRC->getItemByIndex(indexSRC);
	if (pItemSRC->empty())
	{
		return RC_PACK_SOUROPERATOR_EMPTY;
	}
	if (pItemSRC->isLock())
	{
		return RC_PACK_SOUROPERATOR_LOCK;
	}

	// 找一个可以叠加的位置
	CItem* pItemDest = itemConSRC->getItemByIndex(indexDest);
	if(NULL == pItemDest)
	{
		return RC_PACK_DESTOPERATOR_FULL;
	}
	bool canLay = false;
	if(!pItemDest->empty())
	{
		if(pItemSRC->getTypeID() == pItemDest->getTypeID() && !pItemDest->isMaxNum())
		{
            // 目标处可以叠加
			canLay = true;
		}
	}
	else
	{
        return CItemOperator::MoveToEmptyInDiff(itemConSRC, indexSRC, itemConSRC, indexDest);
	}

	if(canLay)
	{
		// 叠加
		TItemNum_t layNum = 0;
		if ( pItemSRC->getNum() < pItemDest->getRemainLayNum() )
		{
			layNum = pItemSRC->getNum();
		}
		else
		{
			layNum = pItemDest->getRemainLayNum();
		}
		itemConSRC->layItems(pItemSRC, pItemDest, layNum, true);
		if(pItemSRC->getNum() == 0)
		{
			itemConSRC->delItemByIndex(indexSRC, true);
		}

		return RC_SUCCESS;
	}
	else
	{
		// 交换
		return CItemOperator::ExchangeItem(itemConSRC, indexSRC, itemConSRC, indexDest);
	}

	return RC_FAILED;
}

EGameRetCode CItemOperator::MoveItem(CItemContainer *itemConSRC,TContainerIndex_t indexSRC,CItemContainer *itemConDest,TContainerIndex_t indexDest)
{
	if (itemConSRC == NULL || itemConDest == NULL)
	{
		return RC_FAILED;
	}
	if (indexSRC >= itemConSRC->getContainerSize() || indexSRC < 0)
	{
		return RC_FAILED;
	}
	
	// 容器类型相同则执行同类型容器移动操作
	if(itemConSRC->getContainerType() == itemConDest->getContainerType())
	{
		return CItemOperator::MoveItem(itemConSRC, indexSRC, indexDest);
	}
	
    return CItemOperator::MoveInDiffCont(itemConSRC, indexSRC, itemConDest, indexDest);
}

EGameRetCode CItemOperator::ExchangeItem(CItemContainer *itemConSRC,TContainerIndex_t indexSRC,CItemContainer *itemConDest,TContainerIndex_t indexDest)
{
	if (itemConSRC == NULL || itemConDest == NULL)
	{
		return RC_FAILED;
	}
	if (indexSRC >= itemConSRC->getContainerSize() || indexSRC < 0)
	{
		return RC_FAILED;
	}
	if (indexDest >= itemConDest->getContainerSize() || indexDest < 0)
	{
		return RC_FAILED;
	}
	CItem* itemSRC = itemConSRC->getItemByIndex(indexSRC);
	gxDebug("Exchange item!SrcObjUID={0},SrcIndex={1}",itemSRC->getObjUID(),indexSRC);
	if (itemSRC->empty())
	{
		return RC_PACK_SOUROPERATOR_EMPTY;
	}
	if (itemSRC->isLock())
	{
		return RC_PACK_SOUROPERATOR_LOCK;
	}
	CItem* itemDest = itemConDest->getItemByIndex(indexDest);
	gxDebug("exchange item dext {0}    {1}",itemDest->getObjUID(),indexDest);
	if(NULL == itemDest || itemDest->empty())
	{
		return RC_PACK_SOUROPERATOR_EMPTY;
	}
	
	if (itemDest->isLock())
	{
		return RC_PACK_DESTOPERATOR_LOCK;
	}

	TObjUID_t srcObjUID = itemSRC->getObjUID();
	TObjUID_t destObjUID = itemDest->getObjUID();
	CTempItem tempDestItem;
	tempDestItem.setItem(itemDest);
	CTempItem tempSrcItem;
	tempSrcItem.setItem(itemSRC);
	itemConDest->_eraseItem(indexDest, false);
	itemConSRC->_eraseItem(indexSRC, false);
	itemConDest->setItem(&tempSrcItem, indexDest);
	itemConSRC->setItem(&tempDestItem, indexSRC);

	MCExchangeItem exchangeItem;
	exchangeItem.srcBagType = itemConSRC->getContainerType();
	exchangeItem.srcItemUID = srcObjUID;
	exchangeItem.destBagType = itemConDest->getContainerType();
	exchangeItem.destItemUID = destObjUID;
	itemConDest->getOwner()->sendPacket(exchangeItem);

	return RC_SUCCESS;

}
EGameRetCode CItemOperator::SplitItem(CItemContainer *itemConSRC, TContainerIndex_t indexSRC, TItemNum_t splitCount,CItemContainer *itemConDest,TContainerIndex_t indexDest)
{
	if(splitCount <= 0)
	{
		gxError("No enough item!");
		return RC_NO_ENOUGH_ITEM;
	}

	if (itemConSRC == NULL || itemConDest == NULL)
	{
		return RC_PACK_DESTOPERATOR_FULL;
	}
	if (indexSRC >= itemConSRC->getContainerSize() || indexSRC < 0)
	{
		return RC_PACK_DESTOPERATOR_FULL;
	}
   
	CItem* itemSRC = itemConSRC->getItemByIndex(indexSRC);
	gxDebug("split item!SrcObjUID={0},SrcIndex={1}", itemSRC->getObjUID(),indexSRC);
	if (itemSRC->empty())
	{
		gxAssert(false);
		return RC_PACK_SOUROPERATOR_EMPTY;
	}
	if (itemSRC->isLock())
	{
		return RC_PACK_SOUROPERATOR_LOCK;
	}
	if (splitCount >= itemSRC->getNum())
	{
		return RC_PACK_SPLIT_NUM_ERR;
	}
	if (indexDest >= itemConDest->getContainerSize() || indexSRC < 0)
	{
		TContainerIndex_t newIndex = itemConDest->getEmptyIndex();
		if (newIndex == INVALID_CONTAINER_INDEX)
		{
			return RC_PACK_DESTOPERATOR_FULL;
		}
		indexDest = newIndex ;
	}
    CItem* itemDest = itemConDest->getItemByIndex(indexDest);
	if (itemDest == NULL)
	{
		return RC_PACK_DESTOPERATOR_FULL;
	}
	if (!itemDest->empty())
	{
		return RC_PACK_DESTOPERATOR_HASITEM;
	}

	sint32 tempCount = itemSRC->getNum() - splitCount ;
	gxAssert(tempCount);
	if(tempCount <= 0)
	{
		return RC_PACK_SPLIT_NUM_ERR;
	}
	itemSRC->setNum(tempCount);
	
	CTempItem item;
	item.setItem(itemSRC);
	bool ret = itemConDest->createItem(&item, indexDest);
	gxDebug("split result item {0}  {1}",itemConDest->getObjUIDByIndex(indexDest),indexDest);
	gxAssert(ret);
	itemDest->setNum(splitCount);
	
	MCUpdateItems updateItems;
	updateItems.bagType = itemConSRC->getContainerType();
	CItemContainer::PushPackItem(&updateItems, itemSRC);
	CItemContainer::PushPackItem(&updateItems, itemDest);

	return RC_SUCCESS;
	
}
EGameRetCode CItemOperator::MoveSpliceItem(CItemContainer *itemConSRC,TContainerIndex_t indexSRC,CItemContainer *itemConDest,TContainerIndex_t indexDest)
{
	if (itemConSRC == NULL || itemConDest == NULL)
	{
		return RC_FAILED;
	}
	if (indexSRC >= itemConSRC->getContainerSize() || indexSRC < 0)
	{
		return RC_FAILED;
	}
	if (indexDest >= itemConDest->getContainerSize() || indexDest < 0)
	{
		return RC_FAILED;
	}
	CItem* pItemSRC = itemConSRC->getItemByIndex(indexSRC);
	gxDebug("movesplice item src  {0}   {1}",pItemSRC->getObjUID(),indexSRC);
	if (pItemSRC->empty())
	{
		return RC_PACK_SOUROPERATOR_EMPTY;
	}
	if (pItemSRC->isLock())
	{
		return RC_PACK_SOUROPERATOR_LOCK;
	}
	CItem* pItemDest = itemConDest->getItemByIndex(indexDest);
	gxDebug("movesplice item dest {0} {1} ",pItemDest->getObjUID(),indexDest);
	if (pItemDest->empty())
	{
		bool result = itemConDest->setItem(pItemSRC,indexDest);
		if (!result)
		{
			return RC_FAILED;
		}
        itemConSRC->_eraseItem(indexSRC);
		return RC_SUCCESS;
	}
	if (pItemSRC->getTypeID() != pItemDest->getTypeID())
	{
         
	}
	sint32 tempCount = pItemSRC->getNum() + pItemDest->getNum();
	if (tempCount > pItemDest->getMaxLayNum())
	{
		pItemSRC->setNum(pItemSRC->getNum() - (pItemDest->getMaxLayNum() - pItemDest->getNum()));
		pItemDest->setNum(pItemDest->getMaxLayNum());
		itemConSRC->_eraseItem(indexSRC);
	}
    pItemDest->setNum(tempCount);
	itemConSRC->_eraseItem(indexSRC);
	return RC_SUCCESS;
}

EGameRetCode CItemOperator::PackUp(CItemContainer* itemCon)
{
	if(!itemCon->canPackUp())
	{
		return RC_PACK_CONT_COOL_DOWN;
	}
	itemCon->packUp();

    // 合并操作
    if (itemCon == NULL)
    {
        return RC_FAILED;
    }
    CHashMap<TObjUID_t, TContainerIndex_t>*  itemHash  = itemCon->getItemHash();
    if (itemHash == NULL)
    {
        return RC_FAILED;
    }
    if (itemHash->size() == 0 )
    {
        return RC_SUCCESS;
    }
    uint32  containerSize = itemCon->getRoleContainerSize();
    gxDebug("container num is {0}",itemHash->size());
    // 检查有没有物品被加锁了, 如果有物品被加锁, 就不再整理背包
	for (TContainerIndex_t i = 0; i < containerSize; ++i)
    {
		CItem* pItem = itemCon->getItemByIndex(i);
        if (pItem == NULL)
        {
            return RC_FAILED;
        }
        if (pItem->empty())
        {
            continue;
        }
        if (pItem->isLock())
        {
            return RC_PACK_SOUROPERATOR_LOCK;
        }
    }

    // 1. 将物品先保存下来
    std::list<CTempItem> srcTempItemList;
    for (TContainerIndex_t m = 0 ; m < containerSize ; ++m)
    {
        CItem* tempItemSrc= itemCon->getItemByIndex(m);
        if (tempItemSrc->empty())
        {
            continue;
        }
        CTempItem tempItem;
        tempItem.setItem(tempItemSrc);
        srcTempItemList.push_back(tempItem);
    }

    // 2. 合并满足条件的物品
    for (TContainerIndex_t m = 0 ; m < containerSize ; ++m)
    {
        CItem* tempItemSrc= itemCon->getItemByIndex(m);
        if (tempItemSrc->empty())
        {
            continue;
        }
        if (tempItemSrc->getNum() == 0)
        {
            continue;
        }
        if (!tempItemSrc->canLay())
        {
            continue;
        }
        for (TContainerIndex_t k = m ; k < containerSize ; ++ k)
        {
            CItem* tempItemDest = itemCon->getItemByIndex(k);
            if (tempItemDest->empty())
            {
                continue;
            }
            if (tempItemDest->getNum() == 0)
            {
                continue;
            }
            if (tempItemDest->getTypeID() != tempItemSrc->getTypeID())
            {
                continue;
            }
            if (tempItemDest->getObjUID() == tempItemSrc->getObjUID())
            {
                continue;
            }
            if (tempItemDest->isBind() != tempItemSrc->isBind())
            {
                continue;
            }
            if (tempItemSrc->getRemainLayNum() >= tempItemDest->getNum())
            {
                tempItemSrc->setNum(tempItemSrc->getNum()+tempItemDest->getNum());
                tempItemDest->setNum(0);
                continue;
            }
            tempItemDest->setNum(tempItemDest->getNum()- tempItemSrc->getRemainLayNum());
            tempItemSrc->setNum(tempItemSrc->getMaxLayNum());

            break;
        }
    }
	gxDebug("container num is {0}",itemHash->size());
    
    // 3. 删除合并后为空的物品
	MCDelItems deleteItems;
	deleteItems.bagType = itemCon->getContainerType();
    for (TContainerIndex_t i = 0 ; i < containerSize ; ++ i)
    {
        CItem* tempItem  =  itemCon->getItemByIndex(i);
        if (tempItem == NULL)
        {
            return RC_FAILED;
        }
        if (tempItem->empty())
        {
            continue;
        }
        if (tempItem->getNum() <= 0)
        {
			CItemContainer::PushPackItem(&deleteItems, tempItem);
			itemCon->delItemByIndex(i, false);
        }
    }
	if (!deleteItems.items.empty())
    {
		itemCon->getOwner()->sendPacket(deleteItems);
		deleteItems.items.clear();
    }
    
    // 4. 排序
    std::list<CSortList> pristineCon;
    for (TContainerIndex_t i = 0 ; i < containerSize ; ++i)
    {
        CItem* item = itemCon->getItemByIndex(i);
        if (item->empty())
        {
            continue;
        }
        uint8 priority = 0;
        if(NULL != item->getItemTbl())
        {
            priority = item->getItemTbl()->priority;
        }
        CSortList sortList(i,item->getType(),item->getNum(),item->getSubType(),item->getTypeID(), priority, item->getObjUID());
        pristineCon.push_back(sortList);
    }
    pristineCon.sort(CSortList::SortItem);
    
    TContainerIndex_t tempContIndex = 0;

    // 5. 保存排序后的物品, 并将物品移动到缓冲区
    std::list<CTempItem> tempItemTbale;
    for(std::list<CSortList>::iterator iter = pristineCon.begin(); iter != pristineCon.end(); ++iter, ++tempContIndex)
    {
        CItem* item = itemCon->getItemByIndex(iter->containerIndex);
        if (item->empty())
        {
            gxAssert(false);
            continue;
        }

        gxAssert(item->getObjUID() == iter->itemObjUID);

        CTempItem tempItem;
        tempItem.setItem(item);
        tempItemTbale.push_back(tempItem);
    }
    
	gxAssert(tempItemTbale.size() == pristineCon.size());

    // 6. 删除原来的物品
    for(TContainerIndex_t index = 0; index < containerSize; ++index)
    {
		itemCon->delItemByIndex(index, false);
    }

    // 7. 将排序后的物品放入到容器中
    tempContIndex = 0;
    for(std::list<CTempItem>::iterator iter = tempItemTbale.begin(); iter != tempItemTbale.end(); ++iter, ++tempContIndex)
    {
        CItem* pItem = itemCon->getItemByIndex(tempContIndex);
        if(NULL != pItem)
        {
            pItem->copyItemValue(&*iter);
        }
    }

    // 8. 重建索引规则
    itemCon->initItems();
    gxAssert(itemCon->getItemNum() == tempItemTbale.size());

    // 9. 检测哪些物品有变化
    std::vector<bool> unchangeFlags;
    unchangeFlags.assign(itemCon->getItemNum(), false);
    tempContIndex = 0;
    for(std::list<CTempItem>::iterator iter = srcTempItemList.begin(); iter != srcTempItemList.end(); ++iter)
    {
        CItem* pItem = itemCon->getItemByObjUID(iter->getObjUID());
        if(NULL == pItem)
        {
            continue;
        }

        gxAssert(pItem->getTypeID() == iter->getTypeID());

        if(pItem->getNum() == iter->getNum())
        {
            unchangeFlags[pItem->getPos().index] = true;
        }
    }

    // 10. 更新有变化的
	MCUpdateItems updateItems;
	updateItems.bagType = itemCon->getContainerType();
    for(uint32 i = 0; i < unchangeFlags.size(); ++i)
    {
        CItem* pItem = itemCon->getItemByIndex(i);
        if(NULL == pItem)
        {
            gxAssert(false);
            continue;
        }

        if(!unchangeFlags[i])
        {
			CItemContainer::PushPackItem(&updateItems, pItem);
        }
    }
    if(!updateItems.items.empty())
    {
        itemCon->getOwner()->sendPacket(updateItems);
    }

    return RC_SUCCESS;
}

EGameRetCode CItemOperator::MoveInDiffCont(CItemContainer *itemConSRC,TContainerIndex_t indexSRC,CItemContainer *itemConDest,TContainerIndex_t indexDest)
{
    FUNC_BEGIN(ITEM_MOD);

    // 以下操作在不同容器中执行
    CItem* pItemSRC = itemConSRC->getItemByIndex(indexSRC);
    if (pItemSRC->empty())
    {
        return RC_PACK_SOUROPERATOR_EMPTY;
    }
    if (pItemSRC->isLock())
    {
        return RC_PACK_SOUROPERATOR_LOCK;
    }

    // 1. 将物品放在空位
    if(!pItemSRC->canLay() || pItemSRC->isMaxNum())
    {
        if(itemConDest->isEmpty(indexDest))
        {
            return CItemOperator::MoveToEmptyInDiff(itemConSRC,indexSRC,itemConDest,indexDest);
        }
        else
        {
            indexDest = itemConDest->getEmptyIndex();
            if (indexDest ==INVALID_CONTAINER_INDEX)
            {
                return RC_PACK_DESTOPERATOR_FULL;
            }
            return CItemOperator::MoveToEmptyInDiff(itemConSRC,indexSRC,itemConDest,indexDest);
        }
    }

    // 2. 物品只能叠加上去
    // 2.1. 如果目标容器位置不合法, 则在目标容器中优先叠加
    if (indexDest >= itemConDest->getRoleContainerSize() || indexDest < 0)
    {
        // 不指定位置则自动叠加, 自动叠加不会将绑定和非绑定叠加在一起
        TContainerIndex_t tempIndex = 0;
        if(!itemConDest->autoCanLaying(pItemSRC->getTypeID(), pItemSRC->getNum(), pItemSRC->getBind(), tempIndex))
        {
            return RC_PACK_DESTOPERATOR_FULL;
        }

        CTempItem tempItem;
        tempItem.setItem(pItemSRC);
        bool layingResult = itemConDest->layItemInDiffCont(&tempItem, true);
        if (layingResult)
        {
			itemConSRC->delItemByIndex(indexSRC, true);
            return RC_SUCCESS;
        }

        return RC_PACK_DESTOPERATOR_FULL;
    }

    // 2.2 位置合法,如果指定位置处为空, 则直接放置在空位
    CItem* pItemDest = itemConDest->getItemByIndex(indexDest);
    if (pItemDest->empty())
    {
        return CItemOperator::MoveToEmptyInDiff(itemConSRC,indexSRC,itemConDest,indexDest);
    }

    // 2.3 物品被加锁
    if(pItemDest->isLock())
    {
        return RC_PACK_DESTOPERATOR_LOCK;
    }

    // 2.4 如果目的容器的指定位置物品不一样, 交换物品！
    if (pItemSRC->getTypeID() != pItemDest->getTypeID())
    {
        return CItemOperator::ExchangeItem(itemConSRC, indexSRC, itemConDest, indexDest);
    }

    // 2.5 能够完全叠加在一起, 全部叠加
    if (pItemSRC->getNum() <= pItemDest->getRemainLayNum())
    {
        if (pItemSRC->isBind())
        {
            pItemDest->setBind();
        }

        pItemDest->setNum(pItemDest->getNum() + pItemSRC->getNum());
		itemConSRC->delItemByIndex(indexSRC, true);
        itemConDest->sendUpdateItem(indexDest);
        return RC_SUCCESS;
    }

    return RC_SUCCESS;

    FUNC_END(RC_FAILED);
}

EGameRetCode CItemOperator::UseItem(CItemContainer* pItemSrc, TContainerIndex_t index)
{
	gxAssert(false);
	return RC_SUCCESS;
}

bool CSortList::SortItem( CSortList& itemSrc, CSortList& itemDest )
{
	if(itemSrc.itemPriority < itemDest.itemPriority)
	{
		return true;
	}
	else if(itemSrc.itemPriority == itemDest.itemPriority)
	{
		if(itemSrc.itemType < itemDest.itemType)
		{
			return true;
		}
		else if(itemSrc.itemType == itemDest.itemType)
		{
			if(itemSrc.itemSubType < itemDest.itemSubType)
			{
				return true;
			}
			else if(itemSrc.itemSubType == itemDest.itemSubType)
			{
				if(itemSrc.itemTypeID > itemDest.itemTypeID)
				{
					return true;
				}
				else if(itemSrc.itemTypeID < itemSrc.itemTypeID)
				{
					return itemSrc.itemNum > itemDest.itemNum;
				}
			}
		}
	}

	return false;
}

bool CSortList::SortItemType(CSortList* itemTypeSrc, CSortList* itemTypeDest)
{
	if (itemTypeSrc->itemType == itemTypeDest->itemType)
	{
		return itemTypeSrc->itemNum > itemTypeDest->itemNum;
	}
	return itemTypeSrc->itemType < itemTypeDest->itemType;
}

bool CSortList::SortItemSubType(CSortList* itemSubTypeSrc, CSortList* itemSubTypeDest)
{
	return itemSubTypeSrc->itemSubType < itemSubTypeDest->itemSubType;
}

bool CSortList::SortItemTypeID(CSortList* itemTypeIDSrc, CSortList* itemTypeIDDest)
{
	return itemTypeIDSrc->itemTypeID > itemTypeIDDest->itemTypeID;
}

CSortList::CSortList(TContainerIndex_t tempContainerIndex, uint8 tempItemType, TItemNum_t tempNum, uint8 tempItemSubType, TItemTypeID_t tempItemTypeID, uint8 priority, TObjUID_t objUID)
{
	containerIndex = tempContainerIndex;
	itemType = tempItemType;
	itemNum = tempNum;
	itemSubType = tempItemSubType;
	itemTypeID = tempItemTypeID;
	itemPriority = priority;
	itemObjUID = objUID;
}
