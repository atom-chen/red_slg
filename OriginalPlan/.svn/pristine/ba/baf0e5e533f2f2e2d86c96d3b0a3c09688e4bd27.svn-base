#include "item_container.h"
#include "debug.h"
#include "item.h"
#include "module_def.h"
#include "game_exception.h"
#include "packet_cm_bag.h"
#include "../role.h"

#ifdef SERVER_DEBUG
class CItemContainerAutoCheck
{
public:
    CItemContainerAutoCheck(CItemContainer* itemContainer)
    {
        _itemContainer = itemContainer;
        _itemContainer->checkContainerSize();
        _itemContainer->checkContainerItems();
    }
    ~CItemContainerAutoCheck()
    {
        _itemContainer->checkContainerSize();
        _itemContainer->checkContainerItems();
    }

private:
    CItemContainer* _itemContainer;
};

#define DAutoCheck CItemContainerAutoCheck autoCheck(this);
#else
#define DAutoCheck
#endif

CItemContainer::CItemContainer()
{
    _containerSize = 0;
    _roleContainerSize = 0;
    _itemContainer = NULL;
	_dbItems = NULL;
    _pOwner = NULL;
    _bagType = PACK_TYPE_INVALID;
	_lastAddItemIndex = INVALID_CONTAINER_INDEX;

//  _updateTimer.init(MAX_ITEM_CONTAINER_UPDATE_TIME);
// 	_updateTimer.update(MAX_ITEM_CONTAINER_UPDATE_TIME);
// 	_upPackTime.init(MAX_UP_PACK_TIME);
// 	_upPackTime.update(MAX_UP_PACK_TIME);
}

CItemContainer::~CItemContainer()
{
	DSafeDeleteArray(_itemContainer);
	DSafeDeleteArray(_dbItems);
}
bool CItemContainer::isBind(TContainerIndex_t index)
{   
    DAutoCheck;
    if (index >= _roleContainerSize || index < 0)
    {
        return false;
    }
    CItem* item = &_itemContainer[index];
    if (item->empty())
    {
        return false;
    }  
    return item->isBind();
}
bool CItemContainer::setBind(TContainerIndex_t index, TItemBind_t bind)
{
    DAutoCheck;
    if (index >= _roleContainerSize || index < 0)
    {
        return false;
    }
    CItem* item = &_itemContainer[index];
    if (item->empty())
    {
        return false;
    }
    if (item->isLock())
    {
        return false;
    }
    item->setBind(bind);
    CItemContainer::sendUpdateItem(index);
    return true;
}
bool CItemContainer::extendContainer(TItemContainerSize_t extendSzie, TItemContainerSize_t srcSzie)
{
    DAutoCheck;

    if (srcSzie>= _containerSize || srcSzie < 0)
    {
        return false;
    }
	if ((_roleContainerSize+extendSzie) >= _containerSize || extendSzie < 0)
    {
        return false;
    }
    for (uint32 i = 0 ; i < extendSzie ; ++i)
    {
        if (_roleContainerSize > _containerSize)
        {
            return false;
        }
        pushList(_roleContainerSize++);
    }
    return true;
}

TContainerHash* CItemContainer::getItemHash()
{
    DAutoCheck;
    return &_itemHash;
}

void CItemContainer::init(const TItemContainerSize_t maxSize, TItemContainerSize_t enableSize, const EPackType bagType, CRole* role)
{
    DAutoCheck;

	_containerSize = maxSize;
    _bagType = bagType ;
    _emptyIndexSet.clear();
	_roleContainerSize = enableSize;
    _pOwner = role;
	for (TContainerIndex_t i = 0; i < enableSize; ++i)
    {
        pushList(i);
    }

	_itemContainer = new CItem[_containerSize];
	_dbItems = new TDbItem[_containerSize];
	for (TContainerIndex_t i = 0; i < _containerSize; ++i)
	{
		_itemContainer[i].setDbItem(&_dbItems[i]);
		_itemContainer[i].setItemPos(bagType, i);
	}
}

void CItemContainer::initItems()
{
    DAutoCheck;

    for (TContainerIndex_t i = 0 ; i < _roleContainerSize ; ++ i)
    {
        CItem* item = &_itemContainer[i];
        if (item->empty())
        {
            continue;
        }
        pushHash(item->getObjUID(), i);
        popList(i);
    }
}

void CItemContainer::update( GXMISC::TDiffTime_t diff, std::vector<TContainerIndex_t>& items )
{
    DAutoCheck;
    FUNC_BEGIN(ITEM_MOD);
    
	_upPackTime.update(diff);

	if(_bagType == PACK_TYPE_EQUIP)
	{
		if(getContainerSize() == 0)
		{
			return;
		}
		if(_updateTimer.update(diff))
		{
			_updateTimer.reset(true);
			checkOutDayItem(items);
		}
	}

    FUNC_END(DRET_NULL);
}

EGameRetCode CItemContainer::setItem(CItem* item, TContainerIndex_t index)
{
    DAutoCheck;
    if (item == NULL)
    {
        return RC_FAILED;
    }

    if (item->isLock())
    {
        return RC_PACK_SOUROPERATOR_LOCK;
    }

    if (index >= _containerSize || index < 0)
    {
        index = getEmptyIndex();
        if(index == INVALID_CONTAINER_INDEX)
        {
            return RC_PACK_DESTOPERATOR_FULL;
        }
    }

    CItem* tempItem = &_itemContainer[index];
    if (!tempItem->empty())
    {
        return RC_PACK_DESTOPERATOR_HASITEM;
    }

    tempItem->copyItemValue(item);
    popList(index);
    pushHash(tempItem->getObjUID(), index);
    return RC_SUCCESS;
}

CItem* CItemContainer::getItemByObjUID(TObjUID_t objUID)
{
    DAutoCheck;
    TContainerHash::iterator itr = _itemHash.find(objUID);
    if (itr == _itemHash.end())
    {
        return NULL;
    }
    int temp = itr->second;
    CItem* item = &_itemContainer[temp];
    return item;
}

CItem* CItemContainer::getItemByIndex(const TContainerIndex_t index)
{
    DAutoCheck;
    if (index >= this->_containerSize || index < 0)
    {
        return NULL;
    }
    return &_itemContainer[index];
}

CItem* CItemContainer::getItemByTypeID(const TItemTypeID_t itemTypeID)
{
    DAutoCheck;
    CItem* temp = NULL;
    for (TContainerIndex_t i = 0 ; i < this->_containerSize ; ++i)
    {
        if (_itemContainer[i].empty())
        {
            continue;
        }
        if (_itemContainer[i].getTypeID() == itemTypeID)
        {
            temp = &_itemContainer[i];
            break;
        }
    }
    return temp;
}

bool CItemContainer::countItems(std::vector<TSimpleItem>& items)
{
	DAutoCheck;
	FUNC_BEGIN(ITEM_MOD);

	return countItems(items, ITEM_ATTR_TYPE_BIND_ALL);

	FUNC_END(false);
}

bool CItemContainer::countItems( std::vector<TSimpleItem>& items, EItemAttrBindType bindType )
{
    DAutoCheck;
    FUNC_BEGIN(ITEM_MOD);

    // 叠加相同的物品
    std::map<TItemTypeID_t, sint32> itemMap;
    for(uint32 i = 0; i < items.size(); ++i)
    {
        itemMap[items[i].id] += items[i].itemNum;
    }

    for(std::map<TItemTypeID_t, sint32>::iterator iter = itemMap.begin(); iter != itemMap.end(); ++iter)
    {
        if(iter->second > countItems(iter->first, bindType))
        {
            return false;
        }
    }

    return true;

    FUNC_END(false);
}

sint32 CItemContainer::countItems(const TItemTypeID_t itemTypeID, EItemAttrBindType itemArrType)
{
    DAutoCheck;
    
    FUNC_BEGIN(ITEM_MOD);

    uint32 itemCount = 0;
    for (TContainerHash::iterator iter = _itemHash.begin(); iter != _itemHash.end() ; ++iter)
    {
        if (_itemContainer[iter->second].empty())
        {
            continue;
        }
        if(_itemContainer[iter->second].isLock())
        {
            continue;
        }
        if (_itemContainer[iter->second].getTypeID() == itemTypeID)
        {
            if(itemArrType == ITEM_ATTR_TYPE_BIND_ALL || itemArrType == _itemContainer[iter->second].getBind())
            {
                itemCount += _itemContainer[iter->second].getNum() ;
            }
        }
    }

    return itemCount;

    FUNC_END(0);
}

sint32 CItemContainer::countCanLay(const TItemTypeID_t itemTypeID, EItemAttrBindType bindType /*= ITEM_ATTR_TYPE_BIND_ALL*/)
{
	uint32 itemCount = 0;
	for (TContainerHash::iterator iter = _itemHash.begin(); iter != _itemHash.end(); ++iter)
	{
		if (_itemContainer[iter->second].empty())
		{
			continue;
		}
		if (_itemContainer[iter->second].isLock())
		{
			continue;
		}
		if (_itemContainer[iter->second].getTypeID() == itemTypeID)
		{
			if (bindType == ITEM_ATTR_TYPE_BIND_ALL || bindType == _itemContainer[iter->second].getBind())
			{
				itemCount += _itemContainer[iter->second].getCanLayNum();
			}
		}
	}

	return itemCount;
}

sint32 CItemContainer::countItems(EItemType type, uint8 subType, EItemAttrBindType bindType, bool isLock)
{
    DAutoCheck;

    uint32 itemCount = 0 ;
    for (TContainerHash::iterator iter = _itemHash.begin(); iter != _itemHash.end() ; ++iter)
    {
        CItem* item = &_itemContainer[iter->second];
        if (item->empty())
        {
            continue;
        }
        if (isLock)
        {
            if (item->isLock())
            {
                continue;
            }
        }

        if (ITEM_ATTR_TYPE_BIND_ALL != bindType && item->getBind() != bindType)
        {
            continue;
        }

        if (subType != item->getSubType() || type != item->getType())
        {
            continue;
        }

        itemCount += item->getNum();
    }

    return itemCount;
}

TItemTypeID_t   CItemContainer::getItemTypeByIndex(TContainerIndex_t index)
{
    DAutoCheck;
    if (index >= _containerSize || index < 0)
    {
        return INVALID_ITEM_TYPE_ID;
    }
    CItem* item = &_itemContainer[index];

    if (item->empty())
    {
        return INVALID_ITEM_TYPE_ID;
    }
    TItemTypeID_t temp = item->getTypeID();
    return temp;
}

TObjUID_t CItemContainer::getObjUIDByIndex(const TContainerIndex_t index)
{
    DAutoCheck;
    if (index >= this->_containerSize || index < 0)
    {
        return INVALID_OBJ_UID;
    }
    CItem* temp = &_itemContainer[index];
    if (temp->empty())
    {
        return INVALID_OBJ_UID;
    }
    return temp->getObjUID();
}

TDbItem* CItemContainer::getDbItem(TContainerIndex_t index)
{
    DAutoCheck;
    if (index >= _roleContainerSize || index < 0)
    {
        return NULL;
    }
    CItem* item = &_itemContainer[index];
    TDbItem* temp = item->_item ;
    if (temp == NULL)
    {
		gxError("no find tdbItem {0}",index);
    }
    return temp;
}

bool CItemContainer::isFull() const
{
    FUNC_BEGIN(ITEM_MOD);

    return _emptyIndexSet.size() == 0;

    FUNC_END(false);
}

TContainerIndex_t CItemContainer::getEmptyIndex()
{
    if (_emptyIndexSet.size() == 0)
    {
        return INVALID_CONTAINER_INDEX;
    }
    TContainerIndex_t temp = *(_emptyIndexSet.begin());
    checkContainerSize();
    return temp;
}

EGameRetCode CItemContainer::_eraseItem(const TContainerIndex_t index, bool sendMsg)
{
    DAutoCheck;
    if (index >= this->_containerSize || index < 0)
    {
        return RC_PACK_SOUROPERATOR_EMPTY;
    }
    CItem* temp = &_itemContainer[index];
    if (temp->empty())
    {
        return RC_PACK_SOUROPERATOR_EMPTY;
    }

    if (temp->isLock())
    {
        return RC_PACK_DESTOPERATOR_LOCK;
    }

    TObjUID_t tempObjUID = temp->getObjUID();
    bool deleteResult = popHash(tempObjUID);
    if (!deleteResult)
    {
        gxAssert(false);
        return  RC_FAILED;
    }

    if(sendMsg)
    {
        sendDelItem(index);
    }
    temp->cleanUp();
    pushList(index);

    return RC_SUCCESS;
}

EGameRetCode CItemContainer::_layItems(const TDbBaseItem* pItem, bool sendMsg, uint8 bind, TContainerIndex_t& retIndex )
{
    FUNC_BEGIN(ITEM_MOD);
    
    retIndex = INVALID_CONTAINER_INDEX;
    TItemNum_t srcItemCount = pItem->count;
    MCAddItems addItems;
	addItems.bagType = _bagType;
    if(pItem->count > 0)
    {
        for(TContainerHash::iterator iter = _itemHash.begin(); iter != _itemHash.end(); ++iter)
        {
            CItem* tempItem = &_itemContainer[iter->second];
            if (tempItem->empty())
            {
                continue;
            }
            if (tempItem->isLock())
            {
                continue;
            }

            TItemNum_t canLayNum = 0;
			if ( tempItem->getRemainLayNum() < srcItemCount )
			{
				canLayNum = tempItem->getRemainLayNum();
			}
			else
			{
				canLayNum = srcItemCount;
			}
            if(canLayNum > 0)
            {
                if(tempItem->canLay(pItem->itemTypeID, canLayNum, pItem->bind))
                {
                    tempItem->addNum(canLayNum);
                    srcItemCount -= canLayNum;
                    if(retIndex == INVALID_CONTAINER_INDEX)
                    {
                        retIndex = tempItem->getPos().index;
                    }
                    if(sendMsg)
                    {
                        // 是否需要通知客户端
                        //addItems.pushItem(*(tempItem->getItemValue()), tempItem->getObjUID(), tempItem->getPos());
						PushPackItem(&addItems, tempItem);
                    }
                }
            }

            if(srcItemCount <= 0)
            {
                break;
            }
        }
    }

    if (srcItemCount > 0)
    {
        TContainerIndex_t newIndex = getEmptyIndex();
        _itemContainer[newIndex].setItemValue(pItem);
        _itemContainer[newIndex].setNum(srcItemCount);

        TObjUID_t tempObjUID = _itemContainer[newIndex].getObjUID();
        pushHash(tempObjUID, newIndex);
        popList(newIndex);
        if(sendMsg)
        {
            //addItems.pushItem(*(_itemContainer[newIndex].getItemValue()), tempObjUID, _itemContainer[newIndex].getPos(), true);
			PushPackItem(&addItems, &_itemContainer[newIndex]);
        }
		retIndex = newIndex;
    }

    if(sendMsg)
    {
        _pOwner->sendPacket(addItems);
    }

    return RC_SUCCESS;

    FUNC_END(RC_FAILED);
}

EGameRetCode CItemContainer::addItem(EItemRecordType recordType, TDbBaseItem* pItem, bool checkLayItem, bool sendMsg /*= false*/, TContainerIndex_t nIndex /*= 0*/)
{
	DAutoCheck;

	if (NULL == pItem)
	{
		return RC_FAILED;
	}
	EGameRetCode retCode = RC_SUCCESS;
	TContainerIndex_t retIndex = INVALID_CONTAINER_INDEX;

	TItemNum_t addNum = pItem->count;
	TItemTypeID_t itemTypeID = pItem->itemTypeID;

	// 检测是否可以叠加
	if (!checkLayItem)
	{
		if (!autoCanLaying(pItem->itemTypeID, pItem->count, pItem->bind, nIndex))
		{
			return RC_PACK_DESTOPERATOR_FULL;
		}
	}
	gxAssert(nIndex < _containerSize && nIndex >= 0);

	MCAddItems addItems;
	addItems.bagType = _bagType;
	CItem* temp = &_itemContainer[nIndex];
	if (temp->empty())
	{
		bool result = temp->setItemValue(pItem);
		gxAssert(result);
		if (result)
		{
			popList(nIndex);
			pushHash(temp->getObjUID(), nIndex);
			if (sendMsg)
			{
				PushPackItem(&addItems, temp);
			}
			retIndex = nIndex;
		}
	}
	else if (temp->canLay(pItem->itemTypeID, pItem->count, pItem->bind))
	{
		// 可以完全叠加
		temp->addNum(pItem->count);
		pItem->count = 0;
		PushPackItem(&addItems, temp);
		retIndex = nIndex;
	}
	else
	{
		// 遍历叠加
		retCode = _layItems(pItem, sendMsg, true, retIndex);
	}
	if (addItems.items.size() > 0 && sendMsg)
	{
		_pOwner->sendPacket(addItems);
	}
	if (IsSuccess(retCode))
	{
		_lastAddItemIndex = retIndex;
		_pOwner->onAddItem(recordType, _bagType, itemTypeID, addNum, pItem->quality);
	}

	return retCode;
}

EGameRetCode CItemContainer::addItem(EItemRecordType recordType, TContainerIndex_t& retIndex, TDbBaseItem* pItem, bool checkLayItem, bool sendMsg, TContainerIndex_t nIndex)
{
	EGameRetCode retCode = addItem(recordType, pItem, checkLayItem, sendMsg, nIndex);
	retIndex = getLastAddItemIndex();
	return retCode;
}

EGameRetCode CItemContainer::addItem(EItemRecordType recordType, CItem*& pRetItem, TDbBaseItem* pItem, bool checkLayItem, bool sendMsg /* = false */, TContainerIndex_t nIndex /* = INVALID_CONTAINER_INDEX */)
{
    DAutoCheck;
    FUNC_BEGIN(ITEM_MOD);

    TContainerIndex_t retIndex = INVALID_CONTAINER_INDEX;
	EGameRetCode retCode = addItem(recordType, retIndex, pItem, checkLayItem, sendMsg, nIndex);
	if(retIndex != INVALID_CONTAINER_INDEX)
	{
		pRetItem = &(_itemContainer[retIndex]);
	}

	return retCode;
    
    FUNC_END(RC_PACK_DESTOPERATOR_FULL);
}

bool CItemContainer::isEmpty(TContainerIndex_t index)  //使用这个函数要非常的注意
{
    DAutoCheck;
    if (index >= _containerSize || index < 0)
    {
        return false;
    }
    CItem* temp = &_itemContainer[index];

    if (temp->empty())
    {
        return true;
    }
    return false;
}

//
bool CItemContainer::pushList(TContainerIndex_t index)
{
    if (index >= this->_containerSize || index < 0)
    {
        return false;
    }
    gxAssert(_emptyIndexSet.find(index) == _emptyIndexSet.end());
    _emptyIndexSet.insert(index);
    checkContainerItems();
    return true;
}
//
bool CItemContainer::popList(TContainerIndex_t index)
{
    checkContainerItems();
    if (index >= this->_containerSize || index < 0)
    {
        return false;
    }
    _emptyIndexSet.erase(index);
    checkContainerItems();
    return true;
}
//
bool CItemContainer::pushHash(TObjUID_t objUID,TContainerIndex_t index)
{
    checkContainerItems();
    if (index >= this->_containerSize || index < 0)
    {
        return false;
    }
    gxAssert(_itemHash.find(objUID) == _itemHash.end());
    _itemHash.insert(TContainerHash::value_type(objUID,index));		//要保证objUID唯一性
    checkContainerItems();
    return true;
}
//
bool CItemContainer::popHash(TObjUID_t objUID)
{
    TContainerHash::size_type result = _itemHash.erase(objUID);
    if (result == 0)
    {
        return false;
    }
    checkContainerItems();
    return true;
}

TItemContainerSize_t CItemContainer::getContainerSize()
{
    DAutoCheck;
    return _containerSize;
}

TItemContainerSize_t CItemContainer::getRoleContainerSize()
{
    DAutoCheck;
    return _roleContainerSize;
}

bool CItemContainer::canLaying(TItemTypeID_t itemType, TItemNum_t num, uint8 bind)
{
    FUNC_BEGIN(ITEM_MOD);
    DAutoCheck;

    TContainerIndex_t index = 0;
    return autoCanLaying(itemType, num, bind, index);

    FUNC_END(false);
}

bool CItemContainer::autoCanLaying( TItemTypeID_t itemTypeID, TItemNum_t num, uint8 bind, TContainerIndex_t& outIndex )
{
    DAutoCheck;
    FUNC_BEGIN(ITEM_MOD);

    CItemConfigTbl* pItemConfig = DItemTblMgr.find(itemTypeID);
    if(NULL  == pItemConfig)
    {
		gxError("Can't find item config!ItemID={0}", itemTypeID);
        return false;
    }

    if(pItemConfig->maxCount <= num)
    {
        outIndex = getEmptyIndex();
        return outIndex != INVALID_CONTAINER_INDEX;
    }

    if(outIndex >= _containerSize || outIndex < 0)
    {
        outIndex = 0;
    }

    // 可以在指定位置叠加
    if(_itemContainer[outIndex].empty() || _itemContainer[outIndex].canLay(itemTypeID, num, bind))
    {
        return true;
    }

    // 有空位
    if (_emptyIndexSet.size() != 0)
    {
        outIndex = 0;
        return true;
    }

    // 遍历查找叠加空位
    uint32 containerCount =  0;
    for(TContainerHash::iterator iter = _itemHash.begin(); iter != _itemHash.end(); ++iter)
    {
        CItem* pItem = &_itemContainer[iter->second];
        if(!pItem->canLay(itemTypeID, 1, bind))
        {
            continue;
        }

        if(pItem->getRemainLayNum() >= num)
        {
            // 找到第一个可以完全叠加的物品
            outIndex = iter->second;
            return true;
        }

        containerCount += pItem->getRemainLayNum() ;
    }

    if (containerCount >= (uint32)num)
    {
        return true;
    }

    return false;

    FUNC_END(false);
}

bool CItemContainer::layItemInDiffCont(CItem* item, bool laying)
{
    DAutoCheck;

    if (!laying)
    {
        TContainerIndex_t index = 0;
        bool result = CItemContainer::autoCanLaying(item->getTypeID(), item->getNum(), item->getBind(), index);
        if (!result)
        {
            return false;
        }
    }

    TContainerIndex_t retIndex = INVALID_CONTAINER_INDEX;
    _layItems(item->getItemValue(), true, true, retIndex);

    MCAddItems updateItems;
	updateItems.bagType = _bagType;
	PushPackItem(&updateItems, item);
    _pOwner->sendPacket(updateItems);

    return true;
}

bool CItemContainer::createItem(CItem* item, TContainerIndex_t index)
{
    DAutoCheck;
    if (index >= _containerSize || index < 0)
    {
        return false;
    }
    if (item == NULL)
    {
        return false;
    }

    if ( _itemContainer[index].setItemValue(item->getItemValue()) )
	{
		pushHash(_itemContainer[index].getObjUID(), index);
		popList(index);
		return true;
    }
	return false;
}

void CItemContainer::checkOutDayItem(std::vector<TContainerIndex_t>& items)
{
    FUNC_BEGIN(ITEM_MOD);
    DAutoCheck;
    
    items.clear();
    for (TContainerIndex_t i = 0 ; i < _roleContainerSize ; ++ i)
    {
        CItem* item = &_itemContainer[i];
        if (item->empty())
        {
            continue;
        }
        if(item->isOutDay())
        {
			gxWarning("Item out day, erase item!ItemTypeID={0},ItemObjUID={1}", item->getTypeID(), item->getObjUID());
            items.push_back(i);
        }
    }

    FUNC_END(DRET_NULL);
}

EGameRetCode CItemContainer::layItems( CItem* pSrcItem, CItem* pDestItem, TItemNum_t num, bool sendMsg )
{
    DAutoCheck;
    if(pSrcItem == NULL || pDestItem == NULL || num == 0)
    {
        return RC_FAILED;
    }

    if (pSrcItem->empty())
    {
        return RC_PACK_SOUROPERATOR_EMPTY;
    }
    if (pSrcItem->isLock())
    {
        return RC_PACK_SOUROPERATOR_LOCK;
    }
    if (pDestItem->empty())
    {
        return RC_SUCCESS;
    }
    if (pDestItem->isLock())
    {
        return RC_PACK_DESTOPERATOR_LOCK;
    }

    if(pSrcItem->getNum() < num)
    {
        return RC_FAILED;
    }

    if((pDestItem->getNum()+num) > pDestItem->getMaxLayNum())
    {
        return RC_PACK_DESTOPERATOR_FULL;
    }

    pDestItem->addNum(num);
    pSrcItem->decNum(num);

    if (pSrcItem->isBind())
    {
        pDestItem->setBind();
    }

    if(sendMsg)
    {
        MCAddItems updateItems;
		updateItems.bagType = _bagType;
		PushPackItem(&updateItems, pSrcItem);
		PushPackItem(&updateItems, pDestItem);
        _pOwner->sendPacket(updateItems);
    }

    return RC_SUCCESS;
}

EPackType CItemContainer::getContainerType()
{
    DAutoCheck;
    return _bagType;
}

CRole* CItemContainer::getOwner()
{
    DAutoCheck;
    return _pOwner;
}
bool CItemContainer::lock(TContainerIndex_t index)
{
    DAutoCheck;
    if (index >= _containerSize || index < 0)
    {
        return false;
    }
    CItem* item = &_itemContainer[index];
    if (item == NULL)
    {
        return false;
    }
    if (item->empty())
    {
        return false;
    }

    item->lock();
    return true;
}
bool CItemContainer::unLock(TContainerIndex_t index)
{
    DAutoCheck;
    if (index >= _containerSize || index < 0)
    {
        return false;
    }
    CItem* item = &_itemContainer[index];
    if (item == NULL)
    {
        return false;
    }
    if (item->empty())
    {
        return false;
    }
    item->unLock();
    return true;
}

bool CItemContainer::_descItem(MCDelItems* deleteItems, MCAddItems* addItems, TItemNum_t& num, CItem* item)
{ 
    DAutoCheck;
    if (num > item->getNum())
    {
        num -= item->getNum();
		PushPackItem(deleteItems, item);
        _eraseItem(item->getPos().index, false);
        return false;
    }
	else if (num == item->getNum())
	{
		num -= item->getNum();
		PushPackItem(deleteItems, item);
		_eraseItem(item->getPos().index, false);
		return true;
	}
    else if (num < item->getNum())
    {
        item->setNum(item->getNum() - num);
        num = 0 ;
		PushPackItem(addItems, item);
        return true;
    }

    return false;
}

bool CItemContainer::_descItem(MCDelItems* del, MCAddItems* add, EItemType type, uint8 subType, TItemNum_t& num, EItemAttrBindType bindType)
{
	for (TContainerIndex_t i = 0 ; i < _roleContainerSize ; ++i)
	{
		CItem* pItem = &_itemContainer[i];
		if ( pItem == NULL )
		{
			continue ;
		}
		if ( pItem->empty() )
		{
			continue ;
		}
		if ( pItem->isLock() )
		{
			continue ;
		}
		if ( pItem->getType() != type )
		{
			continue ;
		}
		if ( pItem->getSubType() != subType )
		{
			continue ;
		}
		if( bindType != pItem->getBind() )
		{
			continue ;
		}
		if ( _descItem(del,add,num,pItem) )
		{
			return true;
		}
	}
	
	return false;
}

bool CItemContainer::_descItem(MCDelItems* del, MCAddItems* add, TItemTypeID_t itemTypeID, TItemNum_t& num, EItemAttrBindType bindType)
{
	for (TContainerIndex_t i = 0 ; i < _roleContainerSize ; ++i)
	{
		CItem* pItem = &_itemContainer[i];
		if ( pItem == NULL )
		{
			continue ;
		}
		if ( pItem->empty() )
		{
			continue;
		}
		if ( pItem->isLock() )
		{
			continue;
		}
		if( itemTypeID != pItem->getTypeID() )
		{
			continue;
		}
		if( bindType != pItem->getBind() )
		{
			continue ;
		}
		if ( _descItem(del,add,num,pItem) )
		{
			return true;
		}
	}
	return false;
}

EGameRetCode CItemContainer::delItemByIndex(const TContainerIndex_t index, bool sendMsg)
{	
    FUNC_BEGIN(ITEM_MOD);
    DAutoCheck;

    return _eraseItem(index, sendMsg);

    FUNC_END(RC_PACK_SOUROPERATOR_EMPTY);
}

EGameRetCode CItemContainer::delItemByIndex(EItemRecordType recordType, const TContainerIndex_t index, bool sendMsg)
{
	CItem* pItem = getItemByIndex(index);
	if (NULL == pItem)
	{
		return RC_PACK_SOUROPERATOR_EMPTY;
	}
	if (pItem->empty())
	{
		return RC_PACK_SOUROPERATOR_EMPTY;
	}

	TItemQuality_t quality = pItem->getQuality();
	TItemTypeID_t itemTypeID = pItem->getTypeID();
	TItemNum_t itemNum = pItem->getNum();

	EGameRetCode retCode = delItemByIndex(index, sendMsg);
	if (IsSuccess(retCode))
	{
		_pOwner->onDeleteItem(recordType, _bagType, itemTypeID, itemNum, quality);
	}

	return retCode;
}

bool CItemContainer::descItem(EItemRecordType recordType, TSimpleItem& item, EItemAttrBindType bindType)
{
    FUNC_BEGIN(ITEM_MOD);

    std::vector<TSimpleItem> descs;
    descs.push_back(item);
    return descItems(recordType, descs, bindType);

    FUNC_END(false);
}

bool CItemContainer::descItemByTypeID(EItemRecordType recordType, TItemTypeID_t itemTypeID, TItemNum_t num, EItemAttrBindType bindType)
{
    FUNC_BEGIN(ITEM_MOD);

    TSimpleItem simpleItem;
    simpleItem.id = itemTypeID;
    simpleItem.itemNum = num;
	return descItem(recordType, simpleItem, bindType);

    FUNC_END(false);
}

bool CItemContainer::_descItems(EItemType type, uint8 subType, TItemNum_t num, EItemAttrBindType bindType)
{
    DAutoCheck;

    FUNC_BEGIN(ITEM_MOD);

    MCAddItems addItems;
	addItems.bagType = _bagType;
    MCDelItems  deleteItems;
	deleteItems.bagType = _bagType;
	if ( bindType == ITEM_ATTR_TYPE_BIND_ALL )
	{
		if (!_descItem(&deleteItems, &addItems, type, subType, num, ITEM_ATTR_TYPE_BIND))
		{
			_descItem(&deleteItems, &addItems, type, subType, num, ITEM_ATTR_TYPE_UNBIND);
		}
	}
	else
	{
		_descItem(&deleteItems, &addItems, type, subType, num, bindType);
	}

	if ( !deleteItems.items.empty() )
	{
		_pOwner->sendPacket(deleteItems);
	}
	if ( !addItems.items.empty() )
	{
		_pOwner->sendPacket(addItems);
	}
    return true;

    FUNC_END(false);
}

bool CItemContainer::_descItems( TItemTypeID_t itemTypeID, TItemNum_t num, EItemAttrBindType bindType )
{
    DAutoCheck;
    FUNC_BEGIN(ITEM_MOD);
    
    MCAddItems addItems;
	addItems.bagType = _bagType;
    MCDelItems  deleteItems;
	deleteItems.bagType = _bagType;
	if ( bindType == ITEM_ATTR_TYPE_BIND_ALL )
	{
		if (!_descItem(&deleteItems, &addItems, itemTypeID, num, ITEM_ATTR_TYPE_BIND))
		{
			_descItem(&deleteItems, &addItems, itemTypeID, num, ITEM_ATTR_TYPE_UNBIND);
		}
	}
	else
	{
		_descItem(&deleteItems, &addItems, itemTypeID, num, bindType);
	}

	if ( !deleteItems.items.empty() )
	{
		_pOwner->sendPacket(deleteItems);
	}
	if ( !addItems.items.empty() )
	{
		_pOwner->sendPacket(addItems);
	}

    return true;

    FUNC_END(false);
}

bool CItemContainer::descItems(EItemRecordType recordType, std::vector<TSimpleItem>& items)
{
    FUNC_BEGIN(ITEM_MOD);
    DAutoCheck;

	return descItems(recordType, items, ITEM_ATTR_TYPE_BIND_ALL);

    FUNC_END(false);
}

bool CItemContainer::descItems(EItemRecordType recordType, std::vector<TSimpleItem>& items, EItemAttrBindType bindType)
{
    FUNC_BEGIN(ITEM_MOD);
    DAutoCheck;

    for(uint32 i = 0; i < items.size(); ++i)
    {
        if(_descItems(items[i].id, items[i].itemNum, bindType))
		{
			_pOwner->onDescItem(recordType, _bagType, items[i].id, items[i].itemNum, INVALID_ITEM_QUALITY);
		}
    }

    return true;

    FUNC_END(false);
}

bool CItemContainer::delAllItems(EItemRecordType recordType, std::vector<TItemTypeID_t>& items, EItemAttrBindType bindType)
{
    FUNC_BEGIN(ITEM_MOD);

    for(uint32 i = 0; i < items.size(); ++i)
    {
		delAllItem(recordType, items[i], bindType);
    }

    return true;

    FUNC_END(false);
}

bool CItemContainer::delAllItem(EItemRecordType recordType, TItemTypeID_t itemTypeID, EItemAttrBindType bindType)
{
    FUNC_BEGIN(ITEM_MOD);

    MCDelItems  deleteItems;
	deleteItems.bagType = _bagType;
    for (TContainerIndex_t i = 0 ; i < _roleContainerSize ; ++i)
    {
        CItem* item = &_itemContainer[i];
        if (item->empty())
        {
            continue;
        }
        if (item->isLock())
        {
            continue;
        }
        if(item->getTypeID() != itemTypeID)
        {
            continue;
        }
        if(bindType == ITEM_ATTR_TYPE_BIND_ALL || bindType == item->getBind())
        {
			CItemContainer::PushPackItem(&deleteItems, item);
			delItemByIndex(recordType, item->getPos().index, false);
        }
    }

    _pOwner->sendPacket(deleteItems);

    return true;

    FUNC_END(false);
}

bool CItemContainer::descItemByType(EItemRecordType recordType, EItemType type, uint8 subType, TItemNum_t num, EItemAttrBindType binType)
{
    FUNC_BEGIN(ITEM_MOD);

    CItemConfigTbl* pItemConfig = DItemTblMgr.getConfig(type, (uint8)subType);
    if(NULL == pItemConfig)
    {
        return false;
    }

    if(_descItems(type, subType, num, binType))
    {
		_pOwner->onDescItem(recordType, _bagType, pItemConfig->id, num, pItemConfig->quality); // @TODO 道具品质必须获取到实际的道具品质
        return true;
    }

    return false;

    FUNC_END(false);
}

bool CItemContainer::descItemByIndex(EItemRecordType recordType, const TContainerIndex_t index, TItemNum_t num, bool sendMsg)
{
    FUNC_BEGIN(ITEM_MOD);

    DAutoCheck;
    CItem* pItem = getItemByIndex(index);
    if(NULL == pItem)
    {
        return false;
    }
    if(pItem->empty())
    {
        return false;
    }

	TItemQuality_t quality = pItem->getQuality();
    TItemTypeID_t itemTypeID = pItem->getTypeID();

	MCDelItems delItems;
	delItems.bagType = _bagType;
	MCAddItems addItems;
	addItems.bagType = _bagType;
	if (_descItem(&delItems, &addItems, num, pItem))
	{
		_pOwner->onDescItem(recordType, _bagType, itemTypeID, num, quality);
		return true;
	}
	if (!delItems.items.empty())
	{
		_pOwner->sendPacket(delItems);
	}
	if (!addItems.items.empty())
	{
		_pOwner->sendPacket(addItems);
	}

    return false;

    FUNC_END(false);
}

bool CItemContainer::descItemByUID(EItemRecordType recordType, TObjUID_t itemObjUID, TItemNum_t num, bool sendMsg)
{
    FUNC_BEGIN(ITEM_MOD);

    CItem* pItem = getItemByObjUID(itemObjUID);
    if(NULL == pItem)
    {
        return false;
    }
    if(pItem->empty())
    {
        return false;
    }

	return descItemByIndex(recordType, pItem->getPos().index, num, sendMsg);

    FUNC_END(false);
}

bool CItemContainer::sendUpdateItem(const TContainerIndex_t index)
{
    DAutoCheck;
    if (index >= _containerSize || index < 0)
    {
        gxAssert(false);
        return false;
    }
    CItem* item = &_itemContainer[index];
    if (item->empty())
    {
        gxAssert(false);
        return false;
    }

	MCAddItems updateItems;
	updateItems.bagType = _bagType;
	PushPackItem(&updateItems, item);
	_pOwner->sendPacket(updateItems);

    return true;
}

void CItemContainer::sendDelItem( const TContainerIndex_t index )
{
    DAutoCheck;
    FUNC_BEGIN(ITEM_MOD);
    if (index >= _containerSize || index < 0)
    {
        gxAssert(false);
        return;
    }
    CItem* item = &_itemContainer[index];
    if (item->empty())
    {
        gxAssert(false);
        return;
    }
    if (item->isLock())
    {
        gxAssert(false);
        return;
    }

	MCDelItems deleteItems;
	deleteItems.bagType = _bagType;
	CItemContainer::PushPackItem(&deleteItems, item);
	_pOwner->sendPacket(deleteItems);

    FUNC_END(DRET_NULL);
}

void CItemContainer::checkContainerSize()
{
    gxAssert((_emptyIndexSet.size() + _itemHash.size()) == _roleContainerSize);
}

void CItemContainer::checkContainerItems()
{
#ifdef SERVER_DEBUG
    for (TContainerHash::iterator itr = _itemHash.begin();itr != _itemHash.end(); ++itr)
    {
        gxAssert(_itemContainer[itr->second].getObjUID()==itr->first);
    }
#endif
}

TItemContainerSize_t CItemContainer::getEmptyCount()
{
    return _emptyIndexSet.size();
}

void CItemContainer::checkMemError()
{
#ifdef SERVER_DEBUG
    if(_emptyIndexSet.size() == 0)
    {
    }

    if(_itemHash.size() == 0)
    {
    }
#endif
}

uint32 CItemContainer::getItemNum()
{
    DAutoCheck;
    return _itemHash.size();
}

void CItemContainer::getAllItemObjUID( TObjUIDList& objUIDlIST )
{
	objUIDlIST.clear();
	for (TContainerHash::iterator itr = _itemHash.begin();itr != _itemHash.end(); ++itr)
	{
		objUIDlIST.push_back(itr->first);
	}
}

void CItemContainer::delAllItem(EItemRecordType recordType, bool sendMsg)
{
	TObjUIDList objUIDList;
	getAllItemObjUID(objUIDList);
	MCDelItems deleteItems;
	deleteItems.bagType = _bagType;
	for(TObjUIDList::iterator iter = objUIDList.begin(); iter != objUIDList.end(); ++iter)
	{
		CItem* pItem = getItemByObjUID(*iter);
		if(NULL == pItem)
		{
			continue;;
		}
		if(pItem->empty())
		{
			continue;
		}
		delItemByIndex(recordType, pItem->getPos().index, false);
		CItemContainer::PushPackItem(&deleteItems, pItem);
	}
	if(sendMsg)
	{
		_pOwner->sendPacket(deleteItems);
	}
}

void CItemContainer::packUp()
{
	_upPackTime.reset();
}

bool CItemContainer::canPackUp()
{
	if (!_upPackTime.isPassed())
	{
		return false;
	}

	return true;
}

void CItemContainer::PushPackItem(MCAddItems* items, CItem* pItem)
{
	TPackItem& packItem = items->items.addSize();

	packItem.objUID = pItem->getObjUID();
	packItem.itemTypeID = pItem->getTypeID();
	packItem.index = pItem->getPos().index;
	packItem.count = pItem->getItemValue()->count;
	packItem.quality = pItem->getItemValue()->quality;
	packItem.bind = pItem->getItemValue()->bind;
	packItem.remainTime = pItem->getItemValue()->getRemainTime();
	packItem.stre = pItem->getItemValue()->stre;

	for (sint32 i = 0; i < pItem->getItemValue()->appendAttr.data.size() && !packItem.appendAttrAry.isMax(); ++i)
	{
		packItem.appendAttrAry.pushBack(pItem->getItemValue()->appendAttr.data[i]);
	}

	for (sint32 i = 0; i < MAX_ITEM_CURR_HOLE_NUM && !packItem.holeGemAry.isMax(); ++i)
	{
		if (pItem->getItemValue()->holeItems.data[i] != INVALID_ITEM_TYPE_ID)
		{
			THoleGemInfo info;
			info.id = pItem->getItemValue()->holeItems.data[i];
			info.pos = i;
			packItem.holeGemAry.pushBack(info);
		}
	}
}

void CItemContainer::PushPackItem(MCUpdateItems* items, CItem* pItem)
{
	TUpdateItem& item = items->items.addSize();
	item.objUID = pItem->getObjUID();
	item.index = pItem->getPos().index;
	item.itemNum = pItem->getNum();
}

void CItemContainer::PushPackItem(MCDelItems* items, CItem* pItem)
{
	items->items.pushBack(pItem->getObjUID());
}

TContainerIndex_t CItemContainer::getLastAddItemIndex() const
{
	return _lastAddItemIndex;
}

CItem* CItemContainer::getLastAddItem()
{
	return getItemByIndex(_lastAddItemIndex);
}
