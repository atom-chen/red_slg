#ifndef _ITEM_BASE_H_
#define _ITEM_BASE_H_

#include "../map_db_item.h"
#include "../bagitem_tbl.h"

// ������Ʒ����Ӧ��ͬ���ñ��µľ�̬��
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
	CItemTbl* _pItemTbl;		///< ���߱�
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
	CItemTable	_itemTbl;		// �������
	TItemData	_itemData;		// ��������
};

#endif //_ITEM_BASE_H_
