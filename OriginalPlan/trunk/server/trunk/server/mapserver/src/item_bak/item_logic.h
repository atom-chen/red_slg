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
	
	//key 为主类与子类的结合键值
	typedef std::map<uint16, Func> RegisterFunMap;

public:
	CItemLogic();
	virtual ~CItemLogic();

public:
	//使用道具
	virtual EGameRetCode onUseItem(CRole * pRole, CItemData * pItem, TObjUID_t objUID, TItemNum_t itemNum);

private:
	// Buffer道具(BUFF类)
	EGameRetCode handleBuff(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// 功能类
	EGameRetCode handleFunc(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// 具体使用逻辑
	EGameRetCode handleLogic(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// 触发事件类
	EGameRetCode handleTouch(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// 触发事件类（开启武将\合成武将道具）
	EGameRetCode handleTouchComEvent(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// 药品道具(属性改变类)
	EGameRetCode handleDrugAttr(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
//	EGameRetCode handleDrugMP(CRole * pRole, CItemData * pItem, TObjUID_t objid, TItemLogic & itemlogic);
	// 礼包
	EGameRetCode handleGiftBag(CRole * pRole, CItemData * pItem, TObjUID_t objUID, CItemTbl* pItemTbl);
	// 卷轴道具

private:
	// 注册道具使用函数
	void _registerFun(uint8 itemtype, uint8 itemsubtype, Func pfuc);
	// 注册所有道具使用函数
	void _inititemlogic();
	//判断数值类型　是否百分比还是数值
	void _handleValueType(const TExtendAttr & arrt, CRole * pRole);
	//处理百分比加成
	void _handlePint(const TExtendAttr & arrt, CRole * pRole);
	//处理数值加成
	void _handleVar(const TExtendAttr & arrt, CRole * pRole);

private:
	RegisterFunMap			_registerFunMap;		//注册列表
};
#define  GItemLogic CItemLogic::GetInstance()

#endif //_ITEM_LOGIC_H_
