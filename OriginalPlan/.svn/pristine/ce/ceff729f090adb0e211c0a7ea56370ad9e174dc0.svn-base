#ifndef _ITEM_BASE_H_
#define _ITEM_BASE_H_

#include "../map_db_item.h"
#include "../bagitem_tbl.h"

// 单个物品，对应不同配置表下的静态数
class CItemTable
{
public:
	CItemTable(){}
	~CItemTable(){}

public:
	void clean()
	{
		_pItemTbl = NULL;
	}

public:
	CItemTbl* _pItemTbl;		///< 道具表
};

class CItemData
{
private:
	friend class CItemContainer;
	friend class CModBag;
	friend class CItemOperator;
	friend class CItemBuild;
	friend class CItemLogic;

public:
	CItemData();
	virtual ~CItemData();

public:
	TItemData* getItemData();
	CItemTable* getItemAllTbls();
	CItemTbl* getItemTbl();
	TItemTypeID_t getItemTypeID() const;
	TItemUID_t getItemGUID() const;
	TItemIndexID_t getItemIndex() const;

public:
	void updateTables(TItemTypeID_t itemTypeID);
	void clean();

private:
	CItemTable	_itemTbl;		// 表格数据
	TItemData	_itemData;		// 道具数据
};

#endif //_ITEM_BASE_H_
