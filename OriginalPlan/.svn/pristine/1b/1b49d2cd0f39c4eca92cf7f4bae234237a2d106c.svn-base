#include "item_manager.h"
#include "item_struct.h"
#include "game_util.h"
#include "game_exception.h"
#include "game_exception.h"
#include "module_def.h"
#include "../bagitem_tbl.h"

CItemManager::CItemManager()
{
	_genObjUID = TEMP_ITEM_INIT_UID;
}

CItemManager::~CItemManager()
{

}

void CItemManager::init()
{
}

bool CItemManager::randItem( TDbItem& item, TItemTypeID_t id )
{	
	CItemConfigTbl* itemRow = DItemTblMgr.find(id);
	if(NULL == itemRow)
	{
		gxError("Can't find item row!ItemTypeID={0}", id);
		return false;
	}

	// 随机数目
	TItemNum_t count = 0;
	count = DRandGen.randUInt()%itemRow->maxCount+1;

	return createItem(item, id, count);
}

bool CItemManager::randItem( TDbItem& item )
{
	if(DItemTblMgr.size() <= 0)
	{
		gxWarning("Item table is empty!");
		return false;
	}

	uint32 index = DRandGen.randUInt()%DItemTblMgr.size()+1;
	CItemConfigTbl* itemRow = DItemTblMgr.get(index);
	if(NULL == itemRow)
	{
		gxError("Can't find item row!index={0}", index);
		return false;
	}
	
	return randItem(item, itemRow->id);
}

bool CItemManager::createItem(TDbItem& item, TItemTypeID_t id, TItemNum_t count/* =1 */, bool isWash /* = false */ )
{
    CItemConfigTbl* itemRow = DItemTblMgr.find(id);
    if(NULL == itemRow)
    {
        gxError("Can't find item row!ItemTypeID={0}", id);
        return false;
    }

    item.itemTypeID = id;
    item.count = count > itemRow->maxCount ? itemRow->maxCount : count;
    item.quality = itemRow->quality;
    item.bind = itemRow->bindType == BIND_TYPE_BIND ? BIND_TYPE_BIND : BIND_TYPE_UNBIND;
    item.createTime = DTimeManager.nowSysTime();
    if(!itemRow->isTimeUnlimit())
    {
        // 有过期时间
        item.remainTime = itemRow->lastTime;
    }

    switch(itemRow->type)
    {
    case ITEM_TYPE_EQUIP:
        {
            if(itemRow->subType == EQUIP_TYPE_FASHION)
            {
                return _createFashionAttr(item, id);
            }
            else
            {
                return _createEquipAttr(item, id, isWash);
            }
        }break;
    default:
        {
            return true;
        }
    }

    return false;
}

bool CItemManager::createItem(TDbItem& item, TExtItem& ext, bool isWash )
{
    FUNC_BEGIN(ITEM_MOD);

    bool ret = createItem(item, ext.item.id, ext.item.itemNum, isWash);
    if(ret)
    {
        item.stre = ext.streLevel;
        item.bind = ext.bind;
    }

    return ret;

    FUNC_END(false);
}

bool CItemManager::createItem( TDbItem& item, TItemTypeID_t id, TItemNum_t count, uint8 bind, sint32 remainTime, sint8 stre )
{
    FUNC_BEGIN(ITEM_MOD);

    bool ret = createItem(item, id, count, false);
    if(ret)
    {
        item.stre = stre;
        item.bind = bind;
		if ( remainTime != 0 )
		{
			item.remainTime = remainTime;
		}
    }

    return ret;

    FUNC_END(false);
}

bool CItemManager::_createEquipAttr(TDbItem& item, TItemTypeID_t id, bool isWash /* = false */ )
{	
// 	CEquipAttrConfigTbl* equipAttrTbl = DEquipAttrTblMgr.find(id);
// 	if(NULL == equipAttrTbl)
// 	{
// 		gxError("Can't find equip attr tbl!ItemID={0}", id);
// 		return false;
// 	}
// 
// 	item.stre = 0;
// 	equipAttrTbl->genAppendAttr(item.appendAttr.data, isWash);

	return true;
}

bool CItemManager::_createFashionAttr( TDbItem& item, TItemTypeID_t id )
{
    FUNC_BEGIN(ITEM_MOD);
    
//     CFashionAttrConfigTbl* fashionAttrTbl = DFashionAttrTblMgr.find(id);
//     if(NULL == fashionAttrTbl)
//     {
//         gxError("Can't find fashion attr tbl!ItemID={0}", id);
//         return false;
//     }
// 
//     item.stre = 0;
//     fashionAttrTbl->genAppendAttr(item.appendAttr.data);
    return true;

    FUNC_END(false);
}

TObjUID_t CItemManager::genObjUID()
{
	if(_genObjUID >= INVALID_OBJ_UID)
	{
		return INVALID_OBJ_UID;
	}

	return _genObjUID++;
}

bool CItemManager::createItem( TDbItem& item, TExtItem& ext, sint32 remainTime, TAppendAttrAry& appendAry, TItemIDVec& gems )
{
    FUNC_BEGIN(ITEM_MOD);
    
    if(!createItem(item, ext.item.id, ext.item.itemNum, false))
    {
        return false;
    }

    if(ext.bind != BIND_TYPE_INVALID)
    {
        item.bind = ext.bind;
    }
    if(ext.streLevel != 0)
    {
        item.stre = ext.streLevel;
    }
    if(remainTime != 0)
    {
        item.remainTime = remainTime;
    }
    if(!appendAry.empty())
    {
        item.appendAttr.data = appendAry;
    }
    if(!gems.empty())
    {
        item.holeItems.data.pushCont(gems);
    }
    
    return true;

    FUNC_END(false);
}
