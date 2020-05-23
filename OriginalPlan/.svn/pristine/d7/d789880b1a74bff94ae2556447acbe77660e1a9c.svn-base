#include "core/game_exception.h"

#include "role.h"
#include "module_def.h"
#include "new_role_tbl.h"
#include "role_manager.h"
#include "packet_mw_base.h"
#include "map_world_handler_base.h"
#include "map_scene.h"
#include "map_db_player_handler.h"
#include "map_player_handler.h"
#include "map_data_tbl.h"
#include "map_world_handler.h"
#include "packet_cm_base.h"
#include "scene_manager.h"
#include "game_config.h"

void CRole::handleAddMoneyPort(EAttributes attr, TAttrVal_t moneyvar, EMoneyRecordTouchType changeway/* = MONEYRECORDDEFINE*/)
{
	switch (attr)
	{
	case ATTR_RMB:
	{
					 //加元宝	
					 addBindRmb(moneyvar);
					 break;
	}
	case ATTR_MONEY:
	{
					   //加游戏币	
					   addGameMoney(moneyvar);
					   break;
	}
	default:
		break;
	}
}


EGameRetCode CRole::handleDescMoneyPort(EAttributes attr, TAttrVal_t moneyvar, EMoneyRecordTouchType changeway/* = MONEYRECORDDEFINE*/)
{
	EGameRetCode retcode = isEnoughWaste(attr, moneyvar);
	if (retcode != RC_SUCCESS)
		return retcode;

	switch (attr)
	{
	case ATTR_RMB:
	{
					 //扣元宝	
					 descAllRmb(moneyvar);
					 break;
	}
	case ATTR_MONEY:
	{
					   //扣游戏币	
					   addGameMoney(-moneyvar);
					   break;
	}
	default:
		break;
	}

	return RC_SUCCESS;
}

void CRole::handleRoleAttr(EAttributes attr, TAttrVal_t attrvar)
{
	switch (attr)
	{
	case ATTR_RMB:
	{
					 //加元宝	
					 addBindRmb(attrvar);
					 break;
	}
	case ATTR_MONEY:
	{
					   //加游戏币	
					   addGameMoney(attrvar);
					   break;
	}
	default:
		break;
	}
}

TAttrVal_t CRole::handleGetRoleAttr(EAttributes attr) const
{
	switch (attr)
	{
	case ATTR_RMB:
	{
					 //扣元宝	
					 return getAllRmb();
					 break;
	}
	case ATTR_MONEY:
	{
					   //扣游戏币	
					   return getGameMoney();
					   break;
	}
	default:
		break;
	}

	return 0;
}

EGameRetCode CRole::isEnoughWaste(EAttributes attr, sint32 moneyvar)
{
	switch (attr)
	{
	case ATTR_RMB:
	{
					 //判断元宝	
					 if (moneyvar > getAllRmb())
					 {
						 //提示：金钱不足
						 //MSGRETCODE_CALLBACK(RC_LACKRMB, this);
						 return RC_LACKRMB;
					 }
					 break;
	}
	case ATTR_MONEY:
	{
					   //判断游戏币	
					   if (moneyvar > getGameMoney())
					   {
						   //提示：金钱不足
						   //MSGRETCODE_CALLBACK(RC_LACKGOLD, this);
						   return RC_LACKGOLD;
					   }
					   break;
	}
	default:
		break;
	}

	return RC_SUCCESS;
}

EGameRetCode CRole::handleAddTokenOrItem(const TItemReward * iteminfo, sint32 changeway/* = 0*/)
{
//	gxAssert(false);
// 	CBagItemTbl * pbagtbl = DBagitemTblMgr.find(iteminfo->itemMarkNum);
// 	if (!pbagtbl)
// 	{
// 		gxError("handkeAddTokenOrItem pbag is null");
// 		return RC_BAG_HAVENOT_TARGETITEM;
// 	}
// 
// 	EGameRetCode retcode = RC_SUCCESS;
// 	EAttributes temattr = static_cast<EAttributes>(pbagtbl->bagiteminfo.itemSubType);
// 
// 	//区分代币与道具
// 	if (pbagtbl->bagiteminfo.itemType == static_cast<uint16>(TOKENITEM_TYPE))
// 	{
// 		handleRoleAttr(temattr, static_cast<TAttrVal_t>(iteminfo->itemNum));
// 
// 		if (temattr == ATTR_RMB ||
// 			temattr == ATTR_MONEY)
// 		{
// 		}
// 	}
// 	else
// 	{
// 		TItemInfo tempinfo;
// 		tempinfo.itemMarkNum = iteminfo->itemMarkNum;
// 		tempinfo.itemNum = static_cast<TItemNumEX_t>(iteminfo->itemNum);
// 		retcode = getBagMod()->addItem(&tempinfo, BAGCONTAINTER_TYPE, static_cast<EItemRecordType>(changeway));
// 	}
// 
// 	return retcode;

	return RC_FAILED;
}

EGameRetCode CRole::handleDeleteTokenOrItem(const TItemReward * iteminfo, sint32 changeway /*= 0*/)
{
	return RC_FAILED;
}

EGameRetCode CRole::handleGetTokenOrItem(TItemTypeID_t itemMarkNum)
{
	return RC_SUCCESS;
}


TRmb_t CRole::chargeRmb(TRmb_t val, bool logFlag)
{
	gxInfo("Charge rmb!{0},RmbVal={1}", toString(), val);

	TRmb_t oldRmb = getRmb();
	TRmb_t rmb = _scriptObject.call<TRmb_t>("doChargeRmb", val, 0);
	if (rmb > 0)
	{
		onChargeRmb(oldRmb, rmb, val);
	}
	else
	{
		gxError("Can't charge rmb!!!Rmb={0}", val);
	}

	return rmb;
}

void CRole::onChargeRmb(TRmb_t oldRmb, TRmb_t newRmb, TRmb_t addRmb)
{
	_scriptObject.vCall("onChargeRmb", oldRmb, newRmb, addRmb);

	TRmb_t totalAddRmb = getHumanBaseData()->getTotalChargeRmb();
}


void CRole::_addLevelAward(TLevel_t level)
{
	FUNC_BEGIN(ROLE_MOD);

	gxAssert(false);
// 	CLevelUpTbl* pLevelUpRow = DLevelUpTblMgr.find(level);
// 	if (pLevelUpRow == NULL)
// 	{
// 		return;
// 	}
// 
// 	addStrength(pLevelUpRow->strength);
// 	handleAddMoneyPort(ATTR_RMB, pLevelUpRow->bindRmb, LEVELRAWARD);
// 	TItemInfoVec items;
// 	items.push_back(TItemInfo(pLevelUpRow->item, pLevelUpRow->num));
// 	if (!items.empty())
// 	{
// 		getBagMod()->addItemVec(items, BAGCONTAINTER_TYPE);
// 	}

	FUNC_END(DRET_NULL);
}

void CRole::onAddItem(EItemRecordType recordType, EPackType packType, TItemTypeID_t itemTypeID, TItemNum_t num, TItemQuality_t quality)
{
	
}

void CRole::onDescItem(EItemRecordType recordType, EPackType packType, TItemTypeID_t itemTypeID, TItemNum_t num, TItemQuality_t quality)
{

}

void CRole::onDeleteItem(EItemRecordType recordType, EPackType packType, TItemTypeID_t itemTypeID, TItemNum_t num, TItemQuality_t quality)
{

}
