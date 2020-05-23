#include "item_logic.h"
#include "constant_tbl.h"
#include "../bagitem_tbl.h"
#include "../mod_bag.h"
#include "../role.h"
#include "../randdropItemMgr.h"
#include "../role_manager.h"

#define CALC_ITEM_KEY(MAINTYPE, SUBTYPE)	(uint16)(MAINTYPE << 8) + SUBTYPE
#define GET_MAIN_TYPE(ITEMKEY)				(uint8)(ITEMKEY >> 8)
#define GET_SUB_TYPE(ITEMKEY)				(uint8)(ITEMKEY & 0XFF)

CItemLogic::CItemLogic()
{
	_registerFunMap.clear();
	_inititemlogic();
}

CItemLogic::~CItemLogic()
{
	_registerFunMap.clear();
}

EGameRetCode CItemLogic::onUseItem( CRole * pRole, CItemData * pItem, TObjUID_t objUID, TItemNum_t itemNum )
{
	if (!pItem)
	{
		gxError("Use item, item is null!!!");
		return RC_BAG_USEITEM_FAILED;
	}

	if (!pRole)
	{
		gxError("Use item, role is null!!!ItemTypeID={0},ItemGUID={1}", pItem->getItemTypeID(), pItem->getItemGUID());
		return RC_BAG_USEITEM_FAILED;
	}

	CItemTbl* pItemTbl = DItemTblMgr.find(pItem->getItemTypeID());
	if (!pItemTbl)
	{
		gxError("Can't find item config tbl!!!ItemTypeID={0},ItemGUID={1}", pItem->getItemTypeID(), pItem->getItemGUID());
		return RC_BAG_USEITEM_FAILED;
	}

	//不能使用的道具类型
	if (pItemTbl->itemType == STUFFITEM_TYPE ||
		pItemTbl->itemType == MISSION_TYPE)
	{
		return RC_ROLE_LEVEL_LOWER;
	}

	//判断使用等级
	if (pItemTbl->itemUseLvL > pRole->getLevel())
	{
		return RC_BAG_USEITEM_FAILED;
	}

	uint16 tempKey = CALC_ITEM_KEY(pItemTbl->itemType, pItemTbl->itemSubType);
	RegisterFunMap::iterator iter = _registerFunMap.find(tempKey);
	if(iter == _registerFunMap.end())
	{
		gxError("Can't find item use caller!!!ItemTypeID={0},ItemGUID={1},ItemRegKey={2}",
			pItem->getItemTypeID(), pItem->getItemGUID(), tempKey);
		return RC_BAG_USEITEM_FAILED;
	}

	// 使用时具体扣除道具数量
	if (pItem->_itemData.itemNum <= 0)
	{
		gxError("Can't use item num equal 0!!!ItemTypeID={0},ItemGUID={1},ItemRegKey={2}",
			pItem->getItemTypeID(), pItem->getItemGUID(), tempKey);
		return RC_BAG_USEITEM_FAILED;
	}

	// 道具数目不足
	if (pItem->_itemData.itemNum < itemNum)
	{
		return RC_ROLE_ITEM_NUM_ENOUGH;
	}

	return (this->*(iter->second))(pRole, pItem, objUID, pItemTbl);
}

void CItemLogic::_registerFun( uint8 itemtype, uint8 itemsubtype, Func pfuc )
{
	uint16 fucid = CALC_ITEM_KEY(itemtype, itemsubtype);

	RegisterFunMap::iterator iter = _registerFunMap.find(fucid);
	if(iter != _registerFunMap.end())
	{
		gxError("item _registerFun is exist with maintype {0}, subtimetype {1}", (uint32)itemtype, (uint32)itemsubtype);
		return;
	}

	_registerFunMap.insert(std::make_pair(fucid, pfuc));
}

void CItemLogic::_inititemlogic()
{
	//注册
	_registerFun(CHANGEATTRITEM_TYPE, DRUG_SUB_INVAL, (Func)&CItemLogic::handleDrugAttr);
	_registerFun(BUFFERITEM_TYPE, DRUG_SUB_INVAL, (Func)&CItemLogic::handleBuff);
	_registerFun(FUNCTIONITEM_TYPE, DRUG_SUB_INVAL, (Func)&CItemLogic::handleFunc);
	_registerFun(TOUCHEVENTITEM_TYPE, DRUG_SUB_INVAL, (Func)&CItemLogic::handleTouch);
	_registerFun(TOUCHEVENTITEM_TYPE, DRUG_SUB_CLASS_OPENCOM_EVENT, (Func)&CItemLogic::handleTouchComEvent);
}

EGameRetCode CItemLogic::handleDrugAttr(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl)
{
	if (!pRole || !pItem)
	{
		return RC_FAILED;
	}

	CRole* targetrole = DRoleManager.findByRoleUID(objUID);
	if(NULL == targetrole)
	{

	}

	TAddAttrAry addattrary;
	TAddAttr	addattr;

	for (TExtentAttrVec::iterator iter = pItemTbl->attrvExtentVec.begin(); iter != pItemTbl->attrvExtentVec.end(); ++iter)
	{
		_handleValueType(*iter, pRole);

		addattr.cleanUp();
		addattr.addType		= iter->attrType;
		addattr.attrValue	= iter->attrValue;
		addattrary.pushBack(addattr);
	}

	//广播人物属性变更
	pRole->refreshFast();

	return RC_SUCCESS;
}

EGameRetCode CItemLogic::handleGiftBag(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl)
{
	if (!pRole || !pItem)
	{
		return RC_BAG_USEITEM_FAILED;
	}

	CRole* targetrole = DRoleManager.findByRoleUID(objUID);
	if(NULL == targetrole)
	{

	}

	return RC_SUCCESS;
}

EGameRetCode CItemLogic::handleBuff(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl)
{

	CRole* targetrole = DRoleManager.findByRoleUID(objUID);
	if(NULL == targetrole)
	{

	}

	return RC_SUCCESS;
}

EGameRetCode CItemLogic::handleFunc(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl)
{
	if (!pRole || !pItem)
	{
		return RC_BAG_USEITEM_FAILED;
	}

	EGameRetCode retcode = RC_FAILED;

	//目前只处理开启技能
// 	switch (itemlogic.itemTouchEffID)
// 	{
// 	default:
// 		break;
// 	}

	return retcode;
}

EGameRetCode CItemLogic::handleLogic(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl)
{
	return RC_SUCCESS;
}

EGameRetCode CItemLogic::handleTouch(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl)
{
	if (!pRole || !pItem)
	{
		return RC_BAG_USEITEM_FAILED;
	}

	CItemContainer * ptempcontainter = pRole->getBagMod()->findBagtype(BAGCONTAINTER_TYPE);
	if(!ptempcontainter)
	{
		return RC_BAG_HAVENOT_BAGTYPE;
	}

	EGameRetCode retcode = RC_SUCCESS;

	//随机奖励道具
	switch (pItemTbl->itemTouchEffID)
	{
	case TOUCH_EVENT_OPEN_BAGGRID:
		{
			//开启背包
			TItemContainerSize_t gridnum = static_cast<TItemContainerSize_t>(pItemTbl->itemTouchEffCon);
			TItemContainerSize_t tempca = ptempcontainter->getCurCapacity() - ptempcontainter->getTSize();
			if(tempca < gridnum)
			{
				//提示：没有足够的空间
				return RC_BAG_HAVENOT_BUYGGRID;
			}

			//判断是否有足够的钱
			TRmb_t temprmb = GetConstant<TRmb_t>(BUY_GRID_PRICE) * gridnum;
			EGameRetCode retcode = pRole->isEnoughWaste(ATTR_RMB, temprmb);
			if(retcode != RC_SUCCESS)
				return RC_BAG_HAVENOT_ENM_OPENGIRD;

			if(ptempcontainter->updateTSise(gridnum) == RC_FAILED)
			{
				pRole->getBagMod()->getMsgBag()->sendItemBuyGrid(gridnum, BAGCONTAINTER_TYPE, RC_BAG_BUYGRID_FAILED);


				return RC_BAG_BUYGRID_FAILED;
			}
			pRole->getBagMod()->getMsgBag()->sendItemBuyGrid(gridnum, BAGCONTAINTER_TYPE, RC_SUCCESS);

			break;
		}
	default:
		break;
	}

	return retcode;
}

EGameRetCode CItemLogic::handleTouchComEvent(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl)
{
	if (!pRole || !pItem)
	{
		return RC_BAG_USEITEM_FAILED;
	}

	CItemContainer * ptempcontainter = pRole->getBagMod()->findBagtype(static_cast<uint8>(BAGCONTAINTER_TYPE));
	if(!ptempcontainter)
	{
		return RC_BAG_HAVENOT_BAGTYPE;
	}

	EGameRetCode retcode = RC_SUCCESS;

// 	switch (itemlogic.itemTouchEffID)
// 	{
// 	default:
// 		break;
// 	}

	return retcode;
}

void CItemLogic::_handleValueType(const TExtendAttr & arrt, CRole * pRole)
{
	if(arrt.valueType == static_cast<TValueType_t>(NUMERICAL_TYPE_VALUE))
	{
		_handleVar(arrt, pRole);
	}
	else if(arrt.valueType == static_cast<TValueType_t>(NUMERICAL_TYPE_ODDS))
	{
		_handlePint(arrt, pRole);
	}
}

void CItemLogic::_handlePint(const TExtendAttr & arrt, CRole * pRole)
{
	if (pRole == NULL)
	{
		gxError("role is null _handlePint");
		return;
	}
	TAttrVal_t attrvar = pRole->handleGetRoleAttr(static_cast<EAttributes>(arrt.attrType));

	//百分比处理
	attrvar = (arrt.attrValue + 1) * attrvar;

	pRole->handleRoleAttr(static_cast<EAttributes>(arrt.attrType), arrt.attrValue);
}

void CItemLogic::_handleVar(const TExtendAttr & arrt, CRole * pRole)
{
	if (pRole == NULL)
	{
		gxError("role is null _handlePint");
		return;
	}

	pRole->handleRoleAttr(static_cast<EAttributes>(arrt.attrType), arrt.attrValue);
};
