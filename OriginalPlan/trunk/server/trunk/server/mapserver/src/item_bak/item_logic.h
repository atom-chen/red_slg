#ifndef _ITEM_LOGIC_H_
#define _ITEM_LOGIC_H_

#include "core/singleton.h"
#include "game_util.h"
#include "../bagitem_tbl.h"
#include <map>

class CRole;
class CItemData;

class CItemLogic : public GXMISC::CManualSingleton<CItemLogic>
{
	typedef EGameRetCode(CItemLogic::*Func)(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	
	//key Ϊ����������Ľ�ϼ�ֵ
	typedef std::map<uint16, Func> RegisterFunMap;

public:
	CItemLogic();
	virtual ~CItemLogic();

public:
	//ʹ�õ���
	virtual EGameRetCode onUseItem(CRole * pRole, CItemData * pItem, TObjUID_t objUID, TItemNum_t itemNum);

private:
	// Buffer����(BUFF��)
	EGameRetCode handleBuff(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// ������
	EGameRetCode handleFunc(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// ����ʹ���߼�
	EGameRetCode handleLogic(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// �����¼���
	EGameRetCode handleTouch(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// �����¼��ࣨ�����佫\�ϳ��佫���ߣ�
	EGameRetCode handleTouchComEvent(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// ҩƷ����(���Ըı���)
	EGameRetCode handleDrugAttr(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
//	EGameRetCode handleDrugMP(CRole * pRole, CItemData * pItem, TObjUID_t objid, TItemLogic & itemlogic);
	// ���
	EGameRetCode handleGiftBag(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// �������

private:
	// ע�����ʹ�ú���
	void _registerFun(uint8 itemtype, uint8 itemsubtype, Func pfuc);
	// ע�����е���ʹ�ú���
	void _inititemlogic();
	//�ж���ֵ���͡��Ƿ�ٷֱȻ�����ֵ
	void _handleValueType(const TExtendAttr & arrt, CRole * pRole);
	//����ٷֱȼӳ�
	void _handlePint(const TExtendAttr & arrt, CRole * pRole);
	//������ֵ�ӳ�
	void _handleVar(const TExtendAttr & arrt, CRole * pRole);

private:
	RegisterFunMap			_registerFunMap;		//ע���б�
};
#define  GItemLogic CItemLogic::GetInstance()

#endif //_ITEM_LOGIC_H_
