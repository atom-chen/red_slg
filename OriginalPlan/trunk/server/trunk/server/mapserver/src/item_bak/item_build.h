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
	// ����������Ʒ
	bool createItem(const TItemInfo * itemdata, CItemData * pItemData, EBagType type);
	// ��������
	bool createItem(TItemTypeID_t itemTypeID, TItemNum_t itemNum, CItemData * pItemData, EBagType type);

private:
	//���µ������ڱ������µľ�̬����
	void updateTables(CItemData * itemobj, EBagType type);
	
};

#define GItemBuild CItemBuild::GetInstance()

///������///���ڶԵ�������ҵ����ֻ�ȡ
class CItemAndTokenHelper
{
public:
	CItemAndTokenHelper(){}
	~CItemAndTokenHelper(){}

public:
	///��ȡ�����б�
	TItemInfoVec getTItemInfoVec();
	///��ȡ�����б�
	TItemRewardVec getTokenInfoVec();
	///��ȡ����
	TItemRewardVec & getAllTItemInfoVecEX(){return _ItemInfoVecEX;}
private:
	TItemRewardVec	_ItemInfoVecEX;
};

#endif //_ITEM_BUILD_H_
