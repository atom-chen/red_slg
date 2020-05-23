#ifndef _ITEM_OPERATOR_H_
#define _ITEM_OPERATOR_H_

#include <list>

#include "item_container.h"
#include "item_struct.h"

class CItem;

class CItemOperator
{
private:
	/**
	 * 将一个容器中的物品移动到另一个容器的空位，在内部删除目的容器的空位
	 * 并在哈希表中添加一条记录
	 */
	static EGameRetCode MoveToEmptyInDiff(CItemContainer *itemConSRC,TContainerIndex_t indexSRC,CItemContainer * itemConDest,TContainerIndex_t indexDest);

    /**
	 * 在不同容器之间移动物品
	 */
    static EGameRetCode MoveInDiffCont(CItemContainer *itemConSRC,TContainerIndex_t indexSRC,CItemContainer *itemConDest,TContainerIndex_t indexDest);
    
    /**
	 * 同容器的移动
	 * 规则: 
	 * 1. 源物品与目标物品类型相同则且能叠加, 则叠加
	 * 2. 源物品与目标物品类型不同则交换
	 */
	static EGameRetCode MoveItem(CItemContainer *itemConSRC,TContainerIndex_t indexSRC,TContainerIndex_t indexDest);

public:
	/**
	 * 不同容器的移动
	 * 规则: 
	 * 1. 必须是不同容器才能移动物品, 如果相同容器则转到相同容器移动物品规则
	 * 2. 指定目标处有物品则找新的空位存放
	 * 3. 指定目标处为空位则直接存放物品
	 */
	static EGameRetCode MoveItem(CItemContainer *itemConSRC,TContainerIndex_t indexSRC,CItemContainer *itemConDest,TContainerIndex_t indexDest);
	
    /**
	 * 将指定位置的物品交换, 交换完之后发送消息
	 * 发送消息步骤:
	 * 1. 将目标物品移动到临时容器中
	 * 2. 将源物品移动到目标容器中
	 * 3. 将目标物品从临时容器移动到源容器中
	 */
	static EGameRetCode ExchangeItem(CItemContainer *itemConSRC,TContainerIndex_t indexSRC,CItemContainer *itemConDest,TContainerIndex_t indexDest);

	/**
	 * 拆分物品
	 * 规则:
	 */
	static EGameRetCode SplitItem(CItemContainer *itemConSRC, TContainerIndex_t indexSRC, TItemNum_t splitCount,CItemContainer *itemConDest,TContainerIndex_t indexDest);

	/**
	 * 移动并合并
	 */
	static EGameRetCode MoveSpliceItem(CItemContainer *itemConSRC,TContainerIndex_t indexSRC,CItemContainer *itemConDest,TContainerIndex_t indexDest);

	/**
	 * 删除物品
	 */
	static EGameRetCode EraseItem(CItemContainer *itemConSRC,TContainerIndex_t indexSRC);

	/**
	 * 整理物品
	 */
	static EGameRetCode PackUp(CItemContainer* itemc);

	/** 
	 * 使用道具
	 */
	static EGameRetCode UseItem(CItemContainer* pItemSrc, TContainerIndex_t index);
};

class CSortList
{
public:
	CSortList(TContainerIndex_t tempContainerIndex, uint8 tempItemType, TItemNum_t tempNum, uint8 tempItemSubType,
		TItemTypeID_t tempItemTypeID, uint8 priority, TObjUID_t objUID);
	~CSortList(){}

public:
    static bool SortItem(CSortList& itemSrc, CSortList& itemDest);
	static bool SortItemType(CSortList* itemTypeSrc, CSortList* itemTypeDest);
	static bool SortItemSubType(CSortList* itemSubTypeSrc, CSortList* itemSubTypeDest);
	static bool SortItemTypeID(CSortList* itemTypeIDSrc, CSortList* itemTypeIDDest);

public:
    TContainerIndex_t containerIndex;
    uint8             itemType;
    TItemNum_t        itemNum;
    uint8             itemSubType;
    TItemTypeID_t     itemTypeID;
    uint8             itemPriority;
    TObjUID_t         itemObjUID;
};

#endif