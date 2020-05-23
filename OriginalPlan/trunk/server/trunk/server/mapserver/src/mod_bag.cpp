#include "core/game_exception.h"

#include "mod_bag.h"
#include "module_def.h"
#include "role.h"
#include "constant_tbl.h"
#include "item_define.h"
#include "item_mod/item.h"

CModBag::CModBag()
{
}

CModBag::~CModBag()
{

}

bool CModBag::onLoad()
{
	CHumanDBData * pDbBaseData = _role->getHumanDBData();
	if (!pDbBaseData)
	{
		return false;
	}

	_bagContainer.init(GetConstInt(BAG_MAX_GRIDNUM), pDbBaseData->baseData.bagOpenGridNum, PACK_TYPE_BAG, _role);

	return true;
}

void CModBag::onSendData()
{
	FUNC_BEGIN(BAG_MOD);

	FUNC_END(DRET_NULL);
}

void CModBag::onSave( bool offLineFlag )
{
	FUNC_BEGIN(BAG_MOD);

	FUNC_END(DRET_NULL);
}

CItemContainer * CModBag::findBagtype(EPackType bagtype)
{
	if (bagtype == PACK_TYPE_BAG)
	{
		return &_bagContainer;
	}

	return NULL;
}

bool CModBag::isFullBag(TItemTypeID_t itemTypeID, TItemNum_t itemNum)
{
	CItemContainer* pBag = findBagtype(PACK_TYPE_BAG);
	if (!pBag)
	{
		gxError("IsFullBag findBag is null!BagType={0}", PACK_TYPE_BAG);
		return true;
	}

	CItemTbls itemTbls = CItem::GetItemTbls(itemTypeID);
	if (itemTbls.isNull())
	{
		gxError("IsFullBag get item tables is null!BagType={0}", PACK_TYPE_BAG);
		return true;
	}

	TItemContainerSize_t emptySize = pBag->getEmptyCount();
	if (emptySize*itemTbls.itemTbl->maxCount > itemNum)
	{
		return false;
	}

	sint32 canLayNum = pBag->countCanLay(itemTypeID);
	return (canLayNum + emptySize*itemTbls.itemTbl->maxCount) < itemNum;
}

TItemContainerSize_t CModBag::getEmptyGirdNum()
{
	CItemContainer * pBag = findBagtype(PACK_TYPE_BAG);
	if (!pBag)
	{
		gxError("GetEmptyGirdNum findBag is null!BagType={0}", PACK_TYPE_BAG);
		return 0;
	}
	
	return pBag->getEmptyCount();
}

CItemContainer* CModBag::getBag()
{
	return findBagtype(PACK_TYPE_BAG);
}

bool CModBag::isFullBagGuird()
{
	return getEmptyGirdNum() <= 0;
}
