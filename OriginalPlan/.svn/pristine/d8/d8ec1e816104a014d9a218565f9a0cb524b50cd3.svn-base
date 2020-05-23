#ifndef _MOD_BAG_H_
#define _MOD_BAG_H_

#include "game_struct.h"
#include "game_module.h"
#include "map_db_item.h"
#include "msg_bag.h"
#include "item_mod/item_container.h"

class CModBag : public CGameRoleModule
{
public:
	CModBag();
	~CModBag();

	//基本操作
public:
	virtual bool onLoad();
	virtual void onSendData();
	virtual void onSave(bool offLineFlag);

public:
	// 是否已满包(包括不能再叠加)
	bool isFullBag(TItemTypeID_t itemTypeID, TItemNum_t itemNum);
	// 是否已满包(只判断格数)
	bool isFullBagGuird();
	// 获取背包剩余多少空格
	TItemContainerSize_t getEmptyGirdNum();
	// 查找要操作的背包类型
	CItemContainer* findBagtype(EPackType bagtype);
	// 获取背包
	CItemContainer* getBag();
private:
	CItemContainer		_bagContainer;		///< 背包容器
};

#endif //_MOD_BAG_H_