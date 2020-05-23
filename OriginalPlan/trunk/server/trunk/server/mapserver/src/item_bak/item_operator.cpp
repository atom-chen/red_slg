#include "item_operator.h"
#include "item_containter.h"
#include "item_base.h"
#include "../bagitem_tbl.h"

CItemOperator::CItemOperator()
{
	_pBagContainter = NULL;
}

CItemOperator::~CItemOperator()
{
	_pBagContainter = NULL;
}

void CItemOperator::neatenBagItem(TUpdateItemInfoAry & updateary, TDeleteItemInfoAry & deleteary )
{
	//记录数据
	SameItemTypeVec tempsametypevec;
	tempsametypevec.resize(MAX_ITEMTYPE);

	CItemDataVec & tempvec = _pBagContainter->getItemDataVec();
	CItemDataVec::iterator iter = tempvec.begin();
	for (CItemDataVec::iterator iter = tempvec.begin(); iter != tempvec.end(); ++iter)
	{
		CItemData * pobj = *iter;
		if(!pobj)
		{
			iter++;
			continue;
		}

		CBagItemTbl * pbag = DBagitemTblMgr.find(pobj->_itemData.itemMarkNum);
		if(!pbag)
		{
			iter++;
			continue;
		}

		uint8 priority = pbag->bagiteminfo.priority;

		TComperaStruct tempstruct;
		tempstruct.itemGUID			= pobj->_itemData.itemGUID;
		tempstruct.itemLastIndex	= pobj->_itemData.itemIndex;
		tempstruct.itemNum			= pobj->_itemData.itemNum;
		tempstruct.itemTypeID		= pobj->_itemData.itemMarkNum;
		tempstruct.itemType			= pbag->bagiteminfo.itemType;
		tempstruct.itemQuality		= pbag->bagiteminfo.itemQuality;
		tempstruct.itemSubType		= pbag->bagiteminfo.itemSubType;

		if(priority == static_cast<uint8>(ON_PRIORITY))
		{
			tempsametypevec[PRIORITYITEM_TYPE].push_back(tempstruct);
		}
		else
		{
			tempsametypevec[pbag->bagiteminfo.itemType].push_back(tempstruct);
		}
	}

	//开始整理
	SameItemTypeVec::iterator sortiter = tempsametypevec.begin();
	for(; sortiter != tempsametypevec.end(); ++sortiter)
	{
		//排序
		(*sortiter).sort(_bagItemSubTypeSort);
		//合并
		_mergeBagitem(*sortiter, updateary, deleteary);
	}

	//重置之前的道具列表
	_pBagContainter->resetContainer();

	//重新添加数据
	_againAddItemBaseData(updateary, tempsametypevec);
}

void CItemOperator::moveItemToNewBag( CItemContainer * srccontainter, TItemIndexID_t srcindex, CItemContainer * descontainter, TItemIndexID_t desindex )
{
	if(!srccontainter || !descontainter)
	{
		return;
	}

	CItemData * ptempboj1 = srccontainter->findTargetItemByIndex(srcindex);
	if(!ptempboj1)
	{
		gxError("moveItemToNewBag is null with Index{0}!", srcindex);
		return;
	}
	
	TItemInfo iteminfo;
	iteminfo.itemTypeID = ptempboj1->_itemData.itemMarkNum;
	iteminfo.itemNum	 = ptempboj1->_itemData.itemNum;

	if(srccontainter->deleteTargetItem(ptempboj1) == RC_FAILED)
	{
		gxError("moveItemToNewBag srcdelete is failed with Index{0}!", srcindex);
		return;
	}

	if(descontainter->addNewItemOperator(iteminfo, desindex) == RC_FAILED)
	{
		gxError("moveItemToNewBag desadditem is failed with Index{0}!", desindex);
		return;
	}
}

void CItemOperator::moveItemToSameBag( TItemIndexID_t desindex )
{
	CItemData * ptempboj1 = _pBagContainter->findTargetItemByIndex(desindex);
	if(!ptempboj1)
	{
		gxError("moveItemToSameBag is null with Index{0}!", desindex);
		return;
	}

	if(_pBagContainter->updateItemPosition(ptempboj1, desindex))
	{
		gxError("moveItemToSameBag updateItemPosition is failed with Index{0}!", desindex);
		return;
	}
}

bool CItemOperator::_bagItemSubTypeSort( const TComperaStruct & obj1, const TComperaStruct & obj2 )
{
	if(obj1.itemQuality == obj2.itemQuality)
	{
		if(obj1.itemSubType == obj2.itemSubType)
		{
			return(obj1.itemTypeID < obj2.itemTypeID);
		}
		else
		{
			return(obj1.itemSubType < obj2.itemSubType);
		}
	}
	else
	{
		return(obj1.itemQuality > obj2.itemQuality);
	}

	return false;
}

void CItemOperator::_mergeBagitem( ComperaStructList & comlist, TUpdateItemInfoAry & updateary, TDeleteItemInfoAry & deleteary )
{
	TItemTypeID_t tempmarknum = 0;
	TComperaStruct * temps = NULL;
	ComperaStructList::iterator iter = comlist.begin();
	while(iter != comlist.end())
	{
		CItemData * pobj1 = _pBagContainter->findTargetItemByGUID(iter->itemGUID);
		if(!pobj1)
		{
			++iter;
			gxError("CItemBaseObj pobj1 is null with itemGUID{0}!", iter->itemGUID);
			continue;
		}

		CBagItemTbl * bagitem1 = DBagitemTblMgr.find(pobj1->_itemData.itemMarkNum);
		if(!bagitem1)
		{
			iter++;
			gxError("_BagItem bagitem1 is null with itemGUID{0}!", iter->itemGUID);
			continue;
		}

		if (tempmarknum != bagitem1->bagiteminfo.itemTypeID)
		{
			//找到新的道具ID
			temps = &(*iter);
			tempmarknum = bagitem1->bagiteminfo.itemTypeID;

			++iter;
		}
		else
		{
			//以下是合并
			TItemNum_t tempnum = 0;
			if(!_isCanPile(temps->itemGUID, tempnum))
			{
				//把下一个设置为新的道具ID
				temps = &(*iter);
				tempmarknum = bagitem1->bagiteminfo.itemTypeID;

				++iter;
				continue;
			}
			else
			{
				if(pobj1->_itemData.itemNum >= tempnum)
				{
					temps->itemNum += tempnum;
					pobj1->_itemData.itemNum -= tempnum;
				}
				else
				{
					temps->itemNum += pobj1->_itemData.itemNum;
					pobj1->_itemData.itemNum = 0;
				}

				TUpdateItemInfoAry::iterator upiter = updateary.findByKey(temps->itemGUID);
				if(upiter == updateary.end())
				{
					TNeatenUpdataItemAttr neatenupdate1;
					neatenupdate1.itemGUID	= temps->itemGUID;
					neatenupdate1.itemIndex	= temps->itemLastIndex;
					neatenupdate1.itemNum	= temps->itemNum;

					//下发给客户端加1
					neatenupdate1.itemIndex += 1;

					updateary.pushBack(neatenupdate1);
				}
				else
				{
					upiter->itemNum = temps->itemNum;
				}

				if(pobj1->_itemData.itemNum > 0)
				{
					TNeatenUpdataItemAttr neatenupdate2;
					neatenupdate2.itemGUID	= pobj1->_itemData.itemGUID;
					neatenupdate2.itemIndex	= pobj1->_itemData.itemIndex;
					neatenupdate2.itemNum	= pobj1->_itemData.itemNum;

					//下发给客户端加1
					neatenupdate2.itemIndex += 1;

					updateary.pushBack(neatenupdate2);
				}

				//查检上一个道具是否已满
				CBagItemTbl * bagitem2 = DBagitemTblMgr.find(temps->itemTypeID);
				if(!bagitem2)
				{
					iter++;
					gxError("_BagItem bagitem2 is null with itemGUID{0}!", temps->itemGUID);
					continue;
				}

				//更新合并后的数据(上一个)
				CItemData * pobj0 = _pBagContainter->findTargetItemByGUID(temps->itemGUID);
				if(!pobj0)
				{
					iter++;
					gxError("_BagItem findTargetItemByGUID pobj0 is null with itemGUID{0}!", temps->itemGUID);
					continue;
				}

				pobj0->getItemData()->itemNum = temps->itemNum;

				if(temps->itemNum >= bagitem2->bagiteminfo.itemPileLimit &&
					pobj1->_itemData.itemNum >= 0)
				{
					//把下一个设置为新的（同编号）
					iter->itemNum = pobj1->_itemData.itemNum;
					temps = &(*iter);
					tempmarknum = bagitem1->bagiteminfo.itemTypeID;

					++iter;
					continue;
				}
			}

			//检查是否要删除合并后的
			if(pobj1->_itemData.itemNum == 0)
			{
				NeatenDeleteItem neatendel;
				neatendel.itemGUID = pobj1->_itemData.itemGUID;
				deleteary.pushBack(neatendel);
				//注意delete
				_pBagContainter->deleteTargetItem(pobj1);
				
				iter = comlist.erase(iter);
			}
		}
	}
}

bool CItemOperator::_isCanPile( TItemUID_t guid, TItemNum_t & pilenum )
{
	CItemData * pobj1 = _pBagContainter->findTargetItemByGUID(guid);
	if(!pobj1)
	{
		gxError("CItemBaseObj pobj1 is null with itemGUID{0}!", guid);
		return false;
	}

	CBagItemTbl * pbag = DBagitemTblMgr.find(pobj1->_itemData.itemMarkNum);
	if(!pbag)
	{
		gxError("_BagItem pbag is null with itemGUID{0}!", guid);
		return false;
	}

	if(pobj1->_itemData.itemNum >=  pbag->bagiteminfo.itemPileLimit)
	{
		return false;
	}
	else
	{
		pilenum = pbag->bagiteminfo.itemPileLimit - pobj1->_itemData.itemNum;
		return true;
	}

	return false;
}

void CItemOperator::_againAddItemBaseData( TUpdateItemInfoAry & updateary, SameItemTypeVec & sameitemvec )
{
	//记录下标
	uint16 indexrecode = 0;

	SameItemTypeVec::iterator sameitor = sameitemvec.begin();
	for(; sameitor != sameitemvec.end(); ++sameitor)
	{
		ComperaStructList::iterator iter = sameitor->begin();
		for(; iter != sameitor->end(); ++iter)
		{
			if(indexrecode > _pBagContainter->getTSize())
			{
				//超出添加上限
				return;
			}

			CItemData * pobj1 = _pBagContainter->findTargetItemByGUID(iter->itemGUID);
			if(!pobj1)
			{
				gxError("_againAddItemBaseData CItemBaseObj pobj1 is null with itemGUID{0}!", iter->itemGUID);
				continue;
			}

			//检查是否有此类型道具
			CBagItemTbl * bagitem1 = DBagitemTblMgr.find(pobj1->_itemData.itemMarkNum);
			if(!bagitem1)
			{
				gxError("_againAddItemBaseData _BagItem bagitem1 is null with itemGUID{0}!", iter->itemGUID);
				continue;
			}

			//检查索引的改变
			if(iter->itemLastIndex != indexrecode)
			{
				//记录(更新)
				TUpdateItemInfoAry::iterator temport = updateary.findByKey(iter->itemGUID);
				if(temport == updateary.end())
				{
					TNeatenUpdataItemAttr neatenattr;
					neatenattr.itemIndex	= indexrecode;
					neatenattr.itemGUID		= iter->itemGUID;
					neatenattr.itemNum		= iter->itemNum;

					//下发给客户端加1
					neatenattr.itemIndex += 1;
					updateary.pushBack(neatenattr);
				}
				else
				{
					temport->itemIndex = indexrecode;

					//下发给客户端加1
					temport->itemIndex += 1;
				}
				
				pobj1->_itemData.itemIndex		= indexrecode;

				_pBagContainter->getItemDataVec()[indexrecode] = pobj1;
			}
			else
			{

				_pBagContainter->getItemDataVec()[indexrecode] = pobj1;
			}

			indexrecode++;
		}
	}
}
