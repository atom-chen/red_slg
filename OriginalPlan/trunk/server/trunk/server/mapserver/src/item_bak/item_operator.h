#ifndef _ITEM_OPERATOR_H_
#define _ITEM_OPERATOR_H_

#include "bag_struct.h"
#include <list>
#include <vector>

typedef struct ComperaStruct
{
	TItemUID_t			itemGUID;			// 唯一ID
	TItemIndexID_t		itemLastIndex;		// 上次位置
	TItemNum_t			itemNum;			// 道具数量
	TItemTypeID_t		itemTypeID;			// 道具编号
	TItemType_t			itemType;			// 道具类型
	TItemType_t			itemSubType;		// 道具子类类型
	TItemQuality_t		itemQuality;		// 道具品质

	ComperaStruct()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}

}TComperaStruct;

typedef std::list<TComperaStruct>		ComperaStructList;		// 合并道具列表
typedef std::vector<ComperaStructList>	SameItemTypeVec;		// 合并道具列表

class CItemContainer;

class CItemOperator
{
public:
	CItemOperator();
	virtual ~CItemOperator();

	//整理背包
	void neatenBagItem(TUpdateItemInfoAry & updateary, TDeleteItemInfoAry & deleteary);
	//不同背包类下位置更新
	void moveItemToNewBag(CItemContainer * srccontainter, TItemIndexID_t srcindex, CItemContainer * descontainter, TItemIndexID_t desindex);
	//同背包下的的位置更新
	void moveItemToSameBag(TItemIndexID_t desindex);
public:
	//设置背包对象
	void setBagContainter(CItemContainer * pcontainter){_pBagContainter = pcontainter;}
private:
	//同类现同品质不同子类型排序
	static bool _bagItemSubTypeSort(const TComperaStruct & obj1, const TComperaStruct & obj2);
	//合并
	inline void _mergeBagitem(ComperaStructList & comlsit, TUpdateItemInfoAry & updateary, TDeleteItemInfoAry & deleteary);
	//是否可以堆叠
	inline bool _isCanPile(TItemUID_t guid, TItemNum_t & pilenum);
	//重新添加数据
	inline void _againAddItemBaseData(TUpdateItemInfoAry & updateary, SameItemTypeVec & sameitemvec);

private:
	CItemContainer	* _pBagContainter;
};

#endif //_ITEM_OPERATOR_H_
