
#include "game_exception.h"
#include "module_def.h"
#include "item_manager.h"
#include "item_property.h"
#include "item.h"

#include "../role_manager.h"

#define CALC_ITEM_KEY(itemType, subType)	(uint16)(itemType << 8) + subType
#define GET_ITEM_TYPE(itemKey)				(uint8)(itemKey >> 8)
#define GET_SUB_TYPE(itemKey)				(uint8)(itemKey & 0xFF)

#define GET_DEST_ROLE \
CRole* destRole = pRole; \
if ( pRole->getObjUID() != objUID ) \
{ \
	destRole = DRoleManager.findByObjUID(objUID); \
} \
if ( destRole == NULL ) \
{ \
	return RC_ROLE_OFFLINE; \
}

CItemProperty::CItemProperty()
{
	init();
}

CItemProperty::~CItemProperty()
{
	cleanUp();
}

EGameRetCode CItemProperty::onUseItem( CRole* pRole, CItem* pItem, TObjUID_t objUID )
{
	FUNC_BEGIN(ITEM_MOD);
	EGameRetCode retCode = RC_SUCCESS;

// 	TItemTypeID_t itemTypeID = pItem->getTypeID();
// 	CItemPropertyConfigTbl* itemPropertyRow = DItemPropertyTblMgr.find(itemTypeID);
// 	CItemConfigTbl* itemConfigTbl = pItem->getItemTbl();
// 	if ( itemConfigTbl == NULL )
// 	{
// 		gxError("Can't find item in item config table!!! itemTypeID = {0}, objUID = {1}, roleName = {2}",
// 			itemTypeID, pRole->getObjUID(), pRole->getRoleName().toString());
// 		gxAssert(false);
// 		return RC_FAILED;
// 	}
// 	TItemNum_t consumNum = itemConfigTbl->useConsume;

// 	uint8 itemType =  pItem->getType();
// 	uint8 subType = pItem->getSubType();
// 	uint16 itemKey = CALC_ITEM_KEY(itemType, subType);
// 	ItemFuncItr itr = _func.find(itemKey);
// 	if ( itr != _func.end() )
// 	{
// 		Func pFunc = itr->second;
// 		if ( pFunc == NULL )
// 		{
// 			gxError("Func ptr is null!!!");
// 			return RC_SUCCESS;
// 		}
// 		retCode = (this->*pFunc)(objUID, pRole, pItem, itemPropertyRow);
// 	}
// 	if ( IsSuccess(retCode) )
// 	{
// 		pRole->onAfterUseItem(pItem);
// 		if ( consumNum > 0 && itemType != ITEM_TYPE_EQUIP )
// 		{
// 			pRole->fillRecordeRoleItem(ITEM_DESC_BY_USE, pItem->getTypeID(), pItem->getNum());
// 			pRole->desItemByIndex(PACK_TYPE_BAG, pItem->getPos().index, consumNum);
// 		}
// 		gxDebug("Delete item!!! itemTypeID = {0}, roleName = {1}, objUID = {2}", itemTypeID, pRole->getRoleName().toString(), pRole->getObjUID());
// 	}
// 	TRecordeItemLogParam itemLog(itemTypeID, DEFAULT_ITEM_NUM, consumNum, pRole->getObjUID(), pRole->getRoleName(), pRole->getLevel());
// 	DRecordeFuncMgr.saveItemRecorde(itemLog);
	return retCode;
	FUNC_END(RC_FAILED);
}

EGameRetCode CItemProperty::proEquip( TObjUID_t objUID, CRole* pRole, CItem* pItem, CItemPropertyConfigTbl* propertyRow )
{
	FUNC_BEGIN(ITEM_MOD);
	EGameRetCode retCode = RC_SUCCESS;
// 	TContainerIndex_t equipIndex = pRole->getEquipPoint(pItem, INVALID_CONTAINER_INDEX);
// 	if(equipIndex == EQUIP_TYPE_INVALID)
// 	{
// 		return RC_PACK_EQUIP_TYPE_INVALID;
// 	}
//     CTempItem tempItem;
//     tempItem.setItem(pItem);
// 	retCode = pRole->wearEquips(pItem->getPos().index, equipIndex);
// 	if( IsSuccess(retCode) )
// 	{
// 		pRole->onEquipChange();
//         pRole->onWearEquipsEvent((CItem*)&tempItem);
// 	}
	return retCode;
	FUNC_END(RC_FAILED);
}

EGameRetCode CItemProperty::proDrugHP( TObjUID_t objUID, CRole* pRole, CItem* pItem, CItemPropertyConfigTbl* propertyRow )
{
	FUNC_BEGIN(ITEM_MOD);
	return RC_SUCCESS;
	FUNC_END(RC_FAILED);
}

EGameRetCode CItemProperty::proDrugMP( TObjUID_t objUID, CRole* pRole, CItem* pItem, CItemPropertyConfigTbl* propertyRow )
{
	FUNC_BEGIN(ITEM_MOD);
	return RC_SUCCESS;
	FUNC_END(RC_FAILED);
}

void CItemProperty::init()
{
	FUNC_BEGIN(ITEM_MOD);

	// ITEM_TYPE_EQUIP
	for ( uint8 i=EQUIP_TYPE_START; i<EQUIP_TYPE_NUMBER; ++i )
	{
		registerFunc(ITEM_TYPE_EQUIP, i, (Func)&CItemProperty::proEquip);
	}

	// ITEM_TYPE_DRUG
	registerFunc(ITEM_TYPE_DRUG, DRUG_SUB_CLASS_HP, (Func)&CItemProperty::proDrugHP);
	registerFunc(ITEM_TYPE_DRUG, DRUG_SUB_CLASS_MP, (Func)&CItemProperty::proDrugMP);

	FUNC_END(DRET_NULL);
}

void CItemProperty::registerFunc( uint8 itemType, uint8 subType, Func pFunc )
{
	FUNC_BEGIN(ITEM_MOD);
	uint16 itemKey = CALC_ITEM_KEY(itemType, subType);
	_func[itemKey] = pFunc;
	FUNC_END(DRET_NULL);
}

void CItemProperty::cleanUp()
{
	FUNC_BEGIN(ITEM_MOD);
	_func.clear();
	FUNC_END(DRET_NULL);
}