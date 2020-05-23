#ifndef _ITEM_BUILD_H_
#define _ITEM_BUILD_H_

#include "core/singleton.h"
#include "../map_db_item.h"

class CItemData;

class CItemBuild : public GXMISC::CManualSingleton<CItemBuild>
{
public:
	CItemBuild();
	virtual ~CItemBuild();

public:
	// 创建背包物品
	bool createItem(const TItemInfo * itemdata, CItemData * pItemData, EBagType type);
	// 创建道具
	bool createItem(TItemTypeID_t itemTypeID, TItemNum_t itemNum, CItemData * pItemData, EBagType type);

private:
	//更新道具所在背包类下的静态数据
	void updateTables(CItemData * itemobj, EBagType type);
	
};

#define GItemBuild CItemBuild::GetInstance()

///辅助类///用于对道具与代币的区分获取
class CItemAndTokenHelper
{
public:
	CItemAndTokenHelper(){}
	~CItemAndTokenHelper(){}

public:
	///获取道具列表
	TItemInfoVec getTItemInfoVec();
	///获取代币列表
	TItemRewardVec getTokenInfoVec();
	///获取所有
	TItemRewardVec & getAllTItemInfoVecEX(){return _ItemInfoVecEX;}
private:
	TItemRewardVec	_ItemInfoVecEX;
};

#endif //_ITEM_BUILD_H_
