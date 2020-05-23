#ifndef _ITEM_MANAGER_H_
#define _ITEM_MANAGER_H_

#include "singleton.h"
#include "game_util.h"
#include "item_struct.h"
#include "item.h"

// ������Ʒ������
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
	bool randItem(TDbItem& item);							///< ���һ����Ʒ
	bool randItem(TDbItem& item, TItemTypeID_t id);			///< �������һ����Ʒ
	bool createItem(TDbItem& item, TItemTypeID_t id, TItemNum_t count=1, bool isWash = false );	 ///< ������Ʒ
    bool createItem(TDbItem& item, TExtItem& ext, bool isWash = false); ///< ������Ʒ
    bool createItem(TDbItem& item, TExtItem& ext, sint32 remainTime, TAppendAttrAry& appendAry, TItemIDVec& gems);///< ������Ʒ
    bool createItem(TDbItem& item, TItemTypeID_t id, TItemNum_t count, uint8 bind, sint32 remainTime, sint8 stre);///< ������Ʒ

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