#ifndef _ITEM_PROPERTY_H_
#define _ITEM_PROPERTY_H_

#include "game_errno.h"
#include "singleton.h"

class CItemConfigTbl;
class CItemPropertyConfigTbl;
class CDrugTbl;
class CItem;
class CRole;
class CBuffItemConfigTbl;

// Ãÿ ‚ŒÔ∆∑
class CItemProperty : public GXMISC::CManualSingleton<CItemProperty>
{
	typedef			EGameRetCode (CItemProperty::*Func)(TObjUID_t, CRole*, CItem*, CItemPropertyConfigTbl*);
	typedef			std::map<uint16, Func>		ItemFuncMap;
	typedef			ItemFuncMap::iterator		ItemFuncItr;

public:
	DSingletonImpl();

public:
	CItemProperty();
	~CItemProperty();

public:
	EGameRetCode	onUseItem( CRole* pRole, CItem* pItem, TObjUID_t objUID );

private:
	// ITEM_TYPE_EQUIP
	EGameRetCode	proEquip( TObjUID_t objUID, CRole* pRole, CItem* pItem, CItemPropertyConfigTbl* propertyRow );
	
	// ITEM_TYPE_DRUG
	EGameRetCode	proDrugHP( TObjUID_t objUID, CRole* pRole, CItem* pItem, CItemPropertyConfigTbl* propertyRow );
	EGameRetCode	proDrugMP( TObjUID_t objUID, CRole* pRole, CItem* pItem, CItemPropertyConfigTbl* propertyRow );

public:
	void			init();
private:
	void			registerFunc( uint8 itemType, uint8 subType, Func pFunc );
	void			cleanUp();

private:
	ItemFuncMap		_func;
};

#define DItemProperty CItemProperty::GetInstance()

#endif