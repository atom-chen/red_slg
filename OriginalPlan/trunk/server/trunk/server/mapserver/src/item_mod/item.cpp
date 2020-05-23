#include "item.h"
#include "string_common.h"
#include "item_manager.h"
#include "game_exception.h"

#include "../role.h"

// 装备放置位置(戒指有两个)
// 客户端位置[2,8,3,9,4,10,5,10,6,11,7,12,1,13];
uint8 EQuipPoint[EQUIP_TYPE_NUMBER] = {0,13,1,3,5,7,9,11,2,4,6,10,12,14};

CItem::CItem()
{
	_item = NULL;
	cleanUp();
}

CItem::~CItem()
{
	_item = NULL;
	cleanUp();
}

void CItem::cleanUp()
{
	if(_item != NULL)
	{
		_item->cleanUp();
	}

	_lock = false;
	_configTbl.cleanUp();
	_objUID = INVALID_OBJ_UID;
}


const TDbItem* CItem::getItemValue() const
{
	return _item;
}

bool CItem::setItemValue( const TDbBaseItem* dbItem )
{
	if (!newItem(dbItem->itemTypeID, dbItem->count, dbItem->quality, dbItem->bind, dbItem->createTime, dbItem->remainTime, dbItem->stre))
	{
		return false;
	}
	_item->appendAttr = dbItem->appendAttr;
	_item->holeItems = dbItem->holeItems;

	return true;
}

bool CItem::setDbItem( TDbItem* dbItem )
{
	_item = dbItem;
	updatePos();
	_updateAttr();
	return true;
}

TItemTypeID_t CItem::getTypeID() const
{
	return _item->itemTypeID;
}

bool CItem::init( const CItemInit* pInit )
{
	if(pInit == NULL)
	{
		gxAssert(false);
		return false;
	}

	_item = const_cast<TDbItem*>(pInit->item);
	_lock = false;
	_pos = pInit->pos;
	
	if(!pInit->item->isNull())
	{
		gxAssert(_item->pos == _pos);
		_objUID = DItemMgr.genObjUID();
		if(_objUID == INVALID_OBJ_UID)
		{
			gxError("Can't gen item obj uid!ItemTypeID={0}", _item->itemTypeID);
			gxAssert(false);
			return false;
		}
		if ( !updateConfigTbl() )
		{
			gxError("Update item config failed!!! ItemTypeID = {0}", pInit->item->itemTypeID);
			gxAssert(false);
			return false;
		}
		updatePos();
		_updateAttr();
	}

	return true;
}

bool CItem::empty() const
{
	if(_item == NULL)
	{
		gxAssert(false);
		return false;
	}

	return _item->isNull();
}

TObjUID_t CItem::getObjUID() const
{
	return _objUID;
}

TItemNum_t CItem::getNum() const
{
	return _item->count;
}

const TItemPosition& CItem::getPos() const
{
	gxAssert(0 == memcmp(&_item->pos, &_pos, sizeof(_item->pos)));
	return _pos;
}

GXMISC::TGameTime_t CItem::getRemainTime() const
{
    if(_item->remainTime == GXMISC::MAX_GAME_TIME)
    {
		return GXMISC::MAX_GAME_TIME;
    }

	GXMISC::TGameTime_t curTime = DTimeManager.nowSysTime();
    if(curTime < _item->createTime)
    {
        return 0;
    }

    if((curTime-_item->createTime) > _item->remainTime)
    {
        return 0;
    }
    
	return _item->remainTime+_item->createTime-curTime;
}

uint8 CItem::getQuality() const
{
	return _item->quality;
}

uint8 CItem::getBind() const
{
	return _item->bind;
}

void CItem::setNum(TItemNum_t num)
{
	gxAssert(_item != NULL && !_item->isNull());
	_item->count = num;
}

bool CItem::addNum(TItemNum_t num)
{
	gxAssert(_item != NULL && !_item->isNull());
	_item->count += num;
	gxAssert(_item->count <= _configTbl.itemTbl->maxCount);
	return true;
}

bool CItem::decNum(TItemNum_t num)
{
	gxAssert(_item != NULL && !_item->isNull());
	_item->count -= num;
	gxAssert(_item->count >= 0);
	CGameMisc::RefixValue(_item->count, 0, getMaxLayNum());

	return true;
}

void CItem::setBind(TItemBind_t bind)
{
	gxAssert(_item != NULL && !_item->isNull());
	_item->bind = bind;
}

void CItem::updatePos()
{
	gxAssert(_item != NULL);
	_item->pos = _pos;
}

void CItem::setQuality(TItemQuality_t num)
{
	gxAssert(_item != NULL && !_item->isNull());
	_item->quality = num;
}

void CItem::setRemainTime(GXMISC::TGameTime_t remainTime)
{
	GXMISC::TGameTime_t curTime = DTimeManager.nowSysTime();
    if(curTime < _item->createTime)
    {
        _item->remainTime = 0;
        return;
    }

    _item->remainTime = curTime-_item->createTime+remainTime;
}

void CItem::setStre( TItemStre_t num )
{
	_item->stre = num;
}

void CItem::updateItemValue( const CItem* item )
{
	gxAssert(!item->empty());
	gxAssert(!empty());
	gxAssert(!isLock());

	_objUID = item->getObjUID();
	_lock = false;

	updateItemValue(item->getItemValue());
}

void CItem::updateItemValue( const TDbItem* item )
{
	gxAssert(!item->isNull());
	gxAssert(!empty());
	gxAssert(!isLock());

	*_item = *(item);
	updateConfigTbl();
	updatePos();
	_updateAttr();
}

void CItem::copyItemValue( const CItem* item )
{
	gxAssert(!item->empty());
	gxAssert(empty());

	_objUID = item->getObjUID();
	_lock = false;
	*_item = *item->getItemValue();
	updateConfigTbl();
	updatePos();
	_updateAttr();
}

bool CItem::isMaxNum() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _item->count >= _configTbl.itemTbl->maxCount;
}

bool CItem::isBind() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _item->bind == BIND_TYPE_BIND;
}

bool CItem::isLock() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _lock;
}

bool CItem::isOutDay() const
{
	gxAssert(_item != NULL && !_item->isNull());
	return getRemainTime() <= 0;
}

void CItem::lock()
{
	gxAssert(_item != NULL && !_item->isNull());

	_lock = true;
}

void CItem::unLock()
{
	gxAssert(_item != NULL && !_item->isNull());

	_lock = false;
}

TItemNum_t CItem::getRemainLayNum() const
{
	gxAssert(_item != NULL && !_item->isNull());

	if(getMaxLayNum() > getNum())
	{
		return getMaxLayNum()-getNum();
	}

	return 0;
}

bool CItem::canLay() const
{
//	gxAssert(_item != NULL && !_item->isNull());
    
    if(empty())
    {
        return false;
    }

	return _configTbl.itemTbl->maxCount > 1;
}

bool CItem::canLay( TItemTypeID_t itemTypeID, TItemNum_t num, uint8 bindType ) const
{
//	gxAssert(_item != NULL && !_item->isNull());
	
	if(empty())
	{
		return false;
	}

	if(isLock())
	{
		return false;
	}

	if(itemTypeID != _item->itemTypeID)
	{
		return false;
	}

	if(getRemainLayNum() < num)
	{
		return false;
	}

	if(bindType != getBind())
	{
		return false;
	}

	return true;
}

bool CItem::canDestroy() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _configTbl.itemTbl->dropType == DESTROY_TYPE_CAN;
}

bool CItem::canSell() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _configTbl.itemTbl->sellType == SELL_LIMIT_CAN && _item->remainTime == GXMISC::MAX_GAME_TIME;
}

bool CItem::canLevel( TLevel_t level ) const
{
	gxAssert(_item != NULL && !_item->isNull());

	return level >= _configTbl.itemTbl->levelLimit;
}

bool CItem::canBind() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _configTbl.itemTbl->bindType == BIND_TYPE_BIND;
}

bool CItem::canEquipBind() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _configTbl.itemTbl->bindType == BIND_TYPE_EQUIP;
}

bool CItem::canStre() const
{
	gxAssert(false);
// 	gxAssert(_item != NULL && !_item->isNull());
// 
// 	if(_item != NULL)
// 	{
// 		if ( _configTbl.equipAttrTbl == NULL )
// 		{
// 			return false;
// 		}
// 		if ( _item->stre == ITEM_MAX_STRE_LEVEL )
// 		{
// 			return false;
// 		}
// 		return _configTbl.equipAttrTbl->canRiseStar();
// 	}

	return false;
}

bool CItem::canWash() const
{
	gxAssert(false);

// 	gxAssert(_item != NULL && !_item->isNull());
// 
// 	if(_item != NULL)
// 	{
// 		if ( _configTbl.equipAttrTbl == NULL )
// 		{
// 			return false;
// 		}
// 		return _configTbl.equipAttrTbl->canWash();
// 	}

	return false;
}

bool CItem::isEquip() const
{
	gxAssert(_item != NULL && !_item->isNull());

	if(_item != NULL)
	{
		return _configTbl.itemTbl->type == ITEM_TYPE_EQUIP;
	}

	return false;
}

bool CItem::isDrug() const
{
	gxAssert(_item != NULL && !_item->isNull());

	if(_item != NULL)
	{
		return _configTbl.itemTbl->type == ITEM_TYPE_DRUG;
	}

	return false;
}

bool CItem::isConsume() const
{
	gxAssert(_item != NULL && !_item->isNull());

	if(_item != NULL)
	{
		return _configTbl.itemTbl->type == ITEM_TYPE_CONSUME;
	}

	return false;
}

bool CItem::isSkillBook() const
{
	gxAssert(_item != NULL && !_item->isNull());

	if(_item != NULL)
	{
		return _configTbl.itemTbl->type == ITEM_TYPE_SKILL_BOOK;
	}
	
	return false;
}

bool CItem::isGem() const
{
	gxAssert(_item != NULL && !_item->isNull());

	if(_item != NULL)
	{
		return _configTbl.itemTbl->type == ITEM_TYPE_GEM;
	}
	
	return false;
}

bool CItem::isBuffer() const
{
	gxAssert(_item != NULL && !_item->isNull());

	if(_item != NULL)
	{
		return _configTbl.itemTbl->type == ITEM_TYPE_BUFFER;
	}
	
	return false;
}

bool CItem::isScroll() const
{
	gxAssert(_item != NULL && !_item->isNull());

	if(_item != NULL)
	{
		return _configTbl.itemTbl->type == ITEM_TYPE_SCROLL;
	}

	return false;
}

EEquipQuality CItem::getEquipQuality() const
{
	gxAssert(_item != NULL && !_item->isNull());

	if(_item != NULL)
	{
		(EEquipQuality)(_item->quality);
	}
	
	return EQUIP_QUALITY_INVALID;
}

TItemStre_t CItem::getStre() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _item->stre;
}

uint8 CItem::getBaseAttrNum() const
{
	gxAssert(false);

//	gxAssert(_item != NULL && !_item->isNull());
//
// 	if(_configTbl.equipAttrTbl != NULL)
// 	{
// 		return _configTbl.equipAttrTbl->getBaseAttrNum();
// 	}

	return 0;
}

TAttr CItem::getBaseAttr( uint8 pos ) const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _item->baseAttr[pos];
}

void CItem::getBaseAttr( TBaseAttrAry& ary ) const
{
	gxAssert(_item != NULL && !_item->isNull());

	ary.pushCont(_item->baseAttr);
}

uint8 CItem::getAppendAttrNum() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _item->appendAttr.data.size();
}

uint8 CItem::getGemNum() const
{
	gxAssert(_item != NULL && !_item->isNull());

	uint8 count = 0;
	for(sint32 i = 0; i < MAX_ITEM_CURR_HOLE_NUM; ++i)
	{
		if(_item->holeItems.data[i] != INVALID_ITEM_TYPE_ID)
		{
			count++;
		}
	}

	return count;
}

uint8 CItem::getEmptyGemIndex() const
{
	gxAssert(_item != NULL && !_item->isNull());

	for(uint8 i = 0; i < MAX_ITEM_CURR_HOLE_NUM; ++i)
	{
		if(_item->holeItems.data[i] == INVALID_ITEM_TYPE_ID)
		{
			return i;
		}
	}

	return MAX_ITEM_CURR_HOLE_NUM;
}

void CItem::getHoleGem( THoleGemAry& ary ) const
{
	gxAssert(_item != NULL && !_item->isNull());

	for(sint32 i = 0; i < MAX_ITEM_CURR_HOLE_NUM && !ary.isMax(); ++i)
	{
		if(_item->holeItems.data[i] != INVALID_ITEM_TYPE_ID)
		{
			THoleGemInfo info(i, _item->holeItems.data[i]);
			ary.pushBack(info);
		}
	}
}

uint8 CItem::getEquipPoint() const
{
	gxAssert(false);

// 	gxAssert(_item != NULL && !_item->isNull());
// 	
// 	if(_configTbl.itemTbl->subType < 0 || _configTbl.itemTbl->subType >= EQUIP_TYPE_NUMBER)
// 	{
// 		return EQUIP_TYPE_INVALID;
// 	}
// 
 	return EQuipPoint[_configTbl.itemTbl->subType];
}

uint8 CItem::GetEquipPoint( EEquipType equip )
{
	gxAssert(false);
	gxAssert(equip >= EQUIP_TYPE_START && equip < EQUIP_TYPE_NUMBER);
	return EQuipPoint[equip];
}

EEquipType CItem::getEquipType() const
{
	return (EEquipType)_configTbl.itemTbl->subType;
}

void CItem::addGem( TItemTypeID_t id, uint8 index )
{
	gxAssert(_item != NULL && !_item->isNull());

	_item->holeItems.data[index] = id;
	_updateAttr();
}

void CItem::delGem( uint8 index )
{
	gxAssert(_item != NULL && !_item->isNull());

	_item->holeItems.data[index] = INVALID_ITEM_TYPE_ID;
	_updateAttr();
}

TItemTypeID_t CItem::getGemTypeID(uint8 index) const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _item->holeItems.data[index];
}

bool CItem::isHoleEnchased(uint8 index) const
{
	gxAssert(_item != NULL && !_item->isNull());

	if(_item == NULL)
	{
		return true;
	}

	if(index > MAX_ITEM_CURR_HOLE_NUM)
	{
		return true;
	}

	return _item->holeItems.data[index] != INVALID_ITEM_TYPE_ID;
}

void CItem::addStre(sint8 val /* = 1 */)
{
	gxAssert(_item != NULL && !_item->isNull());

	if(!isEquip())
	{
		return;
	}

	if ( _item->stre + val > ITEM_MAX_STRE_LEVEL )
	{
		val = ITEM_MAX_STRE_LEVEL - _item->stre;
	}

	_item->stre += val;

	_updateAttr();
}
// 
// void CItem::getEquipAttrs( TEquipAttrs& baseAttrs, TEquipAttrs& appAttrs ) const
// {
// 	gxAssert(!empty());
// 
// 	if(empty())
// 	{
// 		return;
// 	}
// 
// 	if(getType() != ITEM_TYPE_EQUIP)
// 	{
// 		return;
// 	}
// 	
// 	if(_item == NULL)
// 	{
// 		gxAssert(false);
// 		return;
// 	}
// 
// 	// 添加基础属性
// 	TBaseAttrAry& baseAttr = _item->baseAttr;
// 	for(sint32 i = 0; i < baseAttr.size(); ++i)
// 	{
// 		gxAssert(baseAttr[i].attrType > ATTR_FIGHT_INVALID && baseAttr[i].attrType < ATTR_CHAR_CURR_MAX);
// 		gxAssert(baseAttr[i].attrValue > 0);
// 		baseAttrs.addValue(baseAttr[i].attrType, NUMERICAL_TYPE_VALUE, baseAttr[i].attrValue);
// 	}
// 
// 	// 添加附加属性
// 	TAppendAttrAry& appendAttr = _item->appendAttr.data;
// 	for(sint32 i = 0; i < appendAttr.size(); ++i)
// 	{
// 		gxAssert(appendAttr[i].attrType > ATTR_FIGHT_INVALID && appendAttr[i].attrType < ATTR_CHAR_CURR_MAX);
// 		gxAssert(appendAttr[i].attrValue > 0);
// 		appAttrs.addValue(appendAttr[i].attrType, appendAttr[i].valueType, appendAttr[i].attrValue);
// 	}
// 
// }
// 
// void CItem::getEquipAttrs( TEquipAttrs& baseAttrs )
// {
//     FUNC_BEGIN(ITEM_MOD);
// 
//     gxAssert(!empty());
// 
//     if(empty())
//     {
//         return;
//     }
// 
//     if(getType() != ITEM_TYPE_EQUIP)
//     {
//         return;
//     }
// 
//     if(_item == NULL)
//     {
//         gxAssert(false);
//         return;
//     }
// 
//     // 添加基础属性
//     TBaseAttrAry& baseAttr = _item->baseAttr;
//     for(sint32 i = 0; i < baseAttr.size(); ++i)
//     {
//         gxAssert(baseAttr[i].attrType > ATTR_FIGHT_INVALID && baseAttr[i].attrType < ATTR_CHAR_CURR_MAX);
//         gxAssert(baseAttr[i].attrValue > 0);
//         baseAttrs.addValue(baseAttr[i].attrType, NUMERICAL_TYPE_VALUE, baseAttr[i].attrValue);
//     }
// 
//     // 添加附加属性
//     TAppendAttrAry& appendAttr = _item->appendAttr.data;
//     for(sint32 i = 0; i < appendAttr.size(); ++i)
//     {
//         gxAssert(appendAttr[i].attrType > ATTR_FIGHT_INVALID && appendAttr[i].attrType < ATTR_CHAR_CURR_MAX);
//         gxAssert(appendAttr[i].attrValue > 0);
//         baseAttrs.addValue(appendAttr[i].attrType, appendAttr[i].valueType, appendAttr[i].attrValue);
//     }
// 
//     FUNC_END(DRET_NULL);
// }
// 
// void CItem::getGemAttrs( TGemAttrs& attrs ) const
// {
//     FUNC_BEGIN(ITEM_MOD);
// 
//     // 添加宝石附带属性
//     for(sint32 i = 0; i < MAX_ITEM_CURR_HOLE_NUM; ++i)
//     {
//         if(_item->holeItems.data[i] == INVALID_ITEM_TYPE_ID)
//         {
//             continue;
//         }
// 
//         CGemConfigTbl* pGemConfig = DGemTblMgr.find(_item->holeItems.data[i]);
//         if(NULL == pGemConfig)
//         {
//             continue;
//         }
// 
//         attrs.addValue(pGemConfig->attrs);
//     }
// 
//     FUNC_END(DRET_NULL);
// }

EGemQuality CItem::getGemQuality() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return (EGemQuality)_configTbl.itemTbl->quality;
}

TBufferTypeID_t CItem::getBufferID() const
{
	gxAssert(false);

	gxAssert(_item != NULL && !_item->isNull());
	return INVALID_BUFFER_TYPE_ID;
}

std::string CItem::toString()
{
    return _item->toString();
}

CItemConfigTbl* CItem::getItemTbl() const
{
	gxAssert(_item != NULL && !_item->isNull());

	return _configTbl.itemTbl;
}
// 
// CEquipAttrConfigTbl* CItem::getEquipAttrTbl() const
// {
// 	gxAssert(_item != NULL && !_item->isNull());
// 
// 	gxAssert(_dataType == IDT_ITEM);
// 	return _configTbl.equipAttrTbl;
// }

const CItemTbls* CItem::getItemTbls() const
{
    gxAssert(_item != NULL && !_item->isNull());
    return &_configTbl;
}

void CItem::_updateAttr()
{
//	gxAssert(_item != NULL);

	// @TODO
// 	if(NULL != _configTbl.equipAttrTbl)
// 	{
// 		_item->baseAttr.clear();
// 		_configTbl.equipAttrTbl->getBaseAttr(_item->stre, _item->baseAttr);
// 	}
//     if(NULL != _configTbl.fashionTbl)
//     {
//         _item->baseAttr.clear();
//         _item->appendAttr.data.clear();
//         _configTbl.fashionTbl->getBaseAttr(_item->stre, _item->baseAttr);
//         _configTbl.fashionTbl->genAppendAttr(_item->appendAttr.data);
//     }
}

uint8 CItem::getSubType() const
{
	gxAssert(_item != NULL && !_item->isNull());
	return _configTbl.itemTbl->subType;
}

uint8 CItem::getType() const
{
	gxAssert(_item != NULL && !_item->isNull());
	return _configTbl.itemTbl->type;
}

TItemNum_t CItem::getMaxLayNum() const
{
	gxAssert(_item != NULL && !_item->isNull());
	return _configTbl.itemTbl->maxCount;
}

TItemNum_t CItem::getCanLayNum() const
{
	TItemNum_t num = _configTbl.itemTbl->maxCount - _item->count;
	return num >= 0 ? num : 0;
}

EGameRetCode CItem::check( bool bindFlag /*= true*/, bool lockFlag /*= true*/, bool outDayFlag /*= true*/, bool taskFlag /*= true*/, bool rentFlag /*= true*/ )
{
	if(bindFlag && isBind())
	{
		return RC_ITEM_IS_BINDED;
	}

	if(lockFlag && isLock())
	{
		return RC_ITEM_IS_LOCKED;
	}

	if(outDayFlag && isOutDay())
	{
		return RC_ITEM_IS_OUTDAY;
	}

	if(taskFlag && isTask())
	{
		return RC_ITEM_IS_TASK;
	}

	return RC_SUCCESS;
}

bool CItem::isTask() const
{
	FUNC_BEGIN(ITEM_MOD);

	return _configTbl.itemTbl->isTask();

	FUNC_END(false);
}

bool CItem::hasGem() const
{
	gxAssert(_item != NULL && !_item->isNull());
	if ( _item == NULL || _item->isNull() )
	{
		return false;
	}
	for(sint32 i = 0; i < MAX_ITEM_CURR_HOLE_NUM; ++i)
	{
		if(_item->holeItems.data[i] != INVALID_ITEM_TYPE_ID)
		{
			return true;
		}
	}

	return false;
}

CItemTbls CItem::GetItemTbls( TItemTypeID_t itemTypeID )
{
    CItemTbls tbls;
    FUNC_BEGIN(ITEM_MOD);
    
    tbls.itemTbl = DItemTblMgr.find(itemTypeID);
    if(NULL == tbls.itemTbl)
    {
        return tbls;
    }

    switch(tbls.itemTbl->type)
    {
    case ITEM_TYPE_EQUIP:
        {
// 			if ( tbls.isFashion() )
// 			{
// 				tbls.fashionTbl = DFashionAttrTblMgr.find(itemTypeID);
// 				if ( tbls.fashionTbl == NULL )
// 				{
// 					gxError("Can't find itemTypeID in fashion config table!!! fashTypeID = {0}", itemTypeID);
// 					gxAssert(false);
// 					return tbls;
// 				}
// 			}
// 			else
// 			{
// 				tbls.equipAttrTbl = DEquipAttrTblMgr.find(itemTypeID);
// 				if ( tbls.equipAttrTbl == NULL )
// 				{
// 					gxError("Can't find itemTypeID in equip config table!!! equipTypeID = {0}", itemTypeID);
// 					gxAssert(false);
// 					return tbls;
// 				}
// 			}
        }break;
    case ITEM_TYPE_DRUG:
        {
        }break;
    case ITEM_TYPE_CONSUME:
        {
        }break;
    case ITEM_TYPE_SCROLL:
        {
        }break;
    case ITEM_TYPE_SKILL_BOOK:
        {
        }break;
    case ITEM_TYPE_GEM:
        {
        }break;
    case ITEM_TYPE_BUFFER:
        {
        }break;
    }

    tbls.setLoaded();
    return tbls;

    FUNC_END(tbls);
}

CItemTbls CItem::GetItemTbls( uint8 itemType, uint8 itemSubType )
{
    CItemTbls tbls;
    FUNC_BEGIN(ITEM_MOD);

    tbls.itemTbl = DItemTblMgr.getConfig((EItemType)itemType, itemSubType);
    if(NULL == tbls.itemTbl)
    {
        return tbls;
    }

	return GetItemTbls(tbls.itemTbl->id);

    FUNC_END(tbls);
}

void CTempItem::setItem( const CItem* item )
{
	setPos(item->getPos().type, item->getPos().index);
	copyItemValue(item);
}

void CTempItem::setPos( uint8 type, TContainerIndex_t index )
{
	_pos.type = type;
	_pos.index = index;
}

bool CItem::updateConfigTbl()
{
    if ( _item == NULL )
    {
        gxError("The item data is null!!!");
        gxAssert(false);
        return false;
    }
	_configTbl.cleanUp();
    TItemTypeID_t itemTypeID = _item->itemTypeID;
    _configTbl.itemTbl = DItemTblMgr.find(itemTypeID);
    if ( _configTbl.itemTbl == NULL )
    {
		gxError("Can't find itemTypeID in item config table!!! itemTypeID = {0}", itemTypeID);
        gxAssert(false);
        return false;
    }

//     switch ( _configTbl.getType() )
//     {
//     case ITEM_TYPE_EQUIP:
//         {
//             if(_configTbl.isFashion())
//             {
//                 return updateFashionTbl(itemTypeID);
//             }
//             else
//             {
//                 return updateEquipTbl(itemTypeID);
//             }
//         }break;
//     case ITEM_TYPE_DRUG:
//         {
//             return updateDrugTbl(itemTypeID);
//         }break;
//     case ITEM_TYPE_CONSUME:
//         {
//             return updateConsumeTbl(itemTypeID);
//         } break;
//     case ITEM_TYPE_SCROLL:
//         {
//             return updateScrollTbl(itemTypeID);
//         }break;
//     case ITEM_TYPE_SKILL_BOOK:
//         {
//             return updateSkillTbl(itemTypeID);
//         }break;
//     case ITEM_TYPE_GEM:
//         {
//             return updateGemTbl(itemTypeID);
//         }break;
//     case ITEM_TYPE_BUFFER:
//         {
//             return updateBufferTbl(itemTypeID);
//         }break;
//     default:
//         {
//             gxError("Unknow item type!!! type = {0}, itemTypeID = {1}", _configTbl.getType(), itemTypeID);
//             gxAssert(false);
//             return false;
//         }break;
//     }

    return true;
}

bool CItem::updateEquipTbl( TItemTypeID_t itemTypeID )
{
// 	_configTbl.equipAttrTbl = DEquipAttrTblMgr.find(itemTypeID);
// 	if ( _configTbl.equipAttrTbl == NULL )
// 	{
// 		gxError("Can't find itemTypeID in equip config table!!! equipTypeID = {0}", itemTypeID);
// 		gxAssert(false);
// 		return false;
// 	}

	return true;
}

bool CItem::updateDrugTbl( TItemTypeID_t itemTypeID )
{
    return true;
}

bool CItem::updateConsumeTbl( TItemTypeID_t itemTypeID )
{
    return true;
}

bool CItem::updateScrollTbl( TItemTypeID_t itemTypeID )
{
    return true;
}

bool CItem::updateSkillTbl( TItemTypeID_t itemTypeID )
{
    return true;
}

bool CItem::updateGemTbl( TItemTypeID_t itemTypeID )
{
    return true;
}

bool CItem::updateBufferTbl( TItemTypeID_t itemTypeID )
{
    return true;
}

bool CItem::updateFashionTbl( TItemTypeID_t itemTypeID )
{
//     _configTbl.fashionTbl = DFashionAttrTblMgr.find(itemTypeID);
//     if ( _configTbl.fashionTbl == NULL )
//     {
//         gxError("Can't find itemTypeID in fashion config table!!! fashTypeID = {0}", itemTypeID);
//         gxAssert(false);
//         return false;
//     }

    return true;
}

TContainerIndex_t CItem::getIndex() const
{
	return _pos.index;
}

void CItem::setItemTypeID(TItemTypeID_t typeID)
{
	_item->itemTypeID = typeID;
	updateConfigTbl();
}

void CItem::setItemPos(EPackType packType, TContainerIndex_t index)
{
	_pos.type = packType;
	_pos.index = index;
	updatePos();
}

void CItem::setCreateTime(GXMISC::TGameTime_t createTime)
{
	_item->createTime = createTime;
}

void CItem::addAppendAttr(TAttrType_t attrType, TValueType_t valueType, TAttrVal_t attrValue)
{
	_item->appendAttr.data.pushBack(TExtendAttr(attrType, valueType, attrValue));
}

void CItem::setGemItem(TItemTypeID_t itemTypeID, uint8 index)
{
	_item->holeItems.data[index] = itemTypeID;
}

bool CItem::newItem(TItemTypeID_t typeID, TItemNum_t num, TItemQuality_t quality, TItemBind_t bind,
	GXMISC::TGameTime_t createTime, uint32 remainTime, TItemStre_t stre)
{
	if (!empty())
	{
		gxAssert(false);
		gxWarning("Item not empty!{0}", toString());
		return false;
	}

	_objUID = DItemMgr.genObjUID();
	if (_objUID == INVALID_OBJ_UID)
	{
		gxError("Can't gen item obj uid!");
		return false;
	}
	updatePos();
	setItemTypeID(typeID);
	setNum(num);
	setQuality(quality);
	setBind(bind);
	setCreateTime(createTime);
	setRemainTime(remainTime);
	setStre(stre);

	_lock = false;
	if (!updateConfigTbl())
	{
		gxError("Update item config failed!!! itemTypeID = {0}", _item->itemTypeID);
		gxAssert(false);
		return false;
	}
	_updateAttr();

	return true;
}

const TExtendAttr* CItem::getAppendAttr(uint8 index) const
{
	gxAssert(_item->appendAttr.data.size() > index);

	return &(_item->appendAttr.data[index]);
}

GXMISC::TGameTime_t CItem::getCreateTime() const
{
	return _item->createTime;
}
