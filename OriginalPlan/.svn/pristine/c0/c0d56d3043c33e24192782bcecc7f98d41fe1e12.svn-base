#ifndef _ITEM_MANAGER_H_
#define _ITEM_MANAGER_H_

#include "singleton.h"
#include "game_util.h"
#include "item_struct.h"
#include "item.h"

// 负责物品的生成
class CItemManager : public GXMISC::CManualSingleton<CItemManager>
{
	friend class CItem;

public:
	DSingletonImpl();

public:
	CItemManager();
	~CItemManager();

public:
	void init();

public:
	bool randItem(TDbItem& item);							///< 随机一件物品
	bool randItem(TDbItem& item, TItemTypeID_t id);			///< 随机生成一件物品
	bool createItem(TDbItem& item, TItemTypeID_t id, TItemNum_t count=1, bool isWash = false );	 ///< 生成物品
    bool createItem(TDbItem& item, TExtItem& ext, bool isWash = false); ///< 生成物品
    bool createItem(TDbItem& item, TExtItem& ext, sint32 remainTime, TAppendAttrAry& appendAry, TItemIDVec& gems);///< 生成物品
    bool createItem(TDbItem& item, TItemTypeID_t id, TItemNum_t count, uint8 bind, sint32 remainTime, sint8 stre);///< 生成物品

private:
	bool _createEquipAttr(TDbItem& item, TItemTypeID_t id, bool isWash = false );
    bool _createFashionAttr(TDbItem& item, TItemTypeID_t id);

public:
	TObjUID_t genObjUID();

private:
	TObjUID_t _genObjUID;
};

#define DItemMgr CItemManager::GetInstance()

#endif