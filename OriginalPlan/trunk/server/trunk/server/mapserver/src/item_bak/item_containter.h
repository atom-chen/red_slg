#ifndef _ITEM_CONTAINTER_H_
#define _ITEM_CONTAINTER_H_

#include <map>
#include <vector>

#include "core/obj_mem_fix_pool.h"

#include "../map_db_item.h"

#include "item_base.h"
#include "item_operator.h"
#include "record_define.h"

class CItemData;
class CRole;

typedef std::vector<CItemData*> CItemDataVec;
typedef std::map<TItemUID_t, CItemData*> CItemDataMap;
typedef CItemDataMap::iterator ItemIterator;

class CItemContainer
{
public:
	CItemContainer();
	virtual ~CItemContainer();

public:
	// 初始化容量
	void initCapacity(TItemContainerSize_t size, TItemContainerSize_t maxSize, EBagType type);
	// 重置背包列表 
	void resetContainer();
	// 获取当前最大容量
	TItemContainerSize_t getCurCapacity(){ return _vecCapacity; }
	// 获取道具列表
	CItemDataVec & getItemDataVec(){ return _itemDataVec; }
	CItemDataMap & getItemDataMap(){ return _itemDataMap; }

public:
	// 初始化道具容器
	EGameRetCode initItemContainter(const TDBItemInfoAry & dbItemAry);
	// 查找道具(下标)
	CItemData * findItemByIndex(TItemIndexID_t index);
	// 查找道具(唯一)
	CItemData * findItemByGUID(TItemUID_t itemGUID);
	// 查找道具(编号)
	CItemData * findItemByTypeID(TItemTypeID_t itemTypeID);
	// 添加道具, 第三个参数是返回道具插入到哪个下标
	EGameRetCode addItem(const TItemInfo * itemInfo, EItemRecordType itemRecordType = ITEM_RECORD_DEFAULT, TItemIndexID_t * pIndex = NULL);
	// 添加道具通过index
	EGameRetCode addItemByIndex(const TItemInfo * itemInfo, TItemIndexID_t itemIndex, EItemRecordType itemRecordType = ITEM_RECORD_DEFAULT);
	// 更新道具位置
	EGameRetCode updateItemPosition(CItemData * pItem, TItemIndexID_t itemIndex);

public:
	// 获取容器操作对象
	CItemOperator * getItemOperator(){ return &_itemOperator; }
	// 获取当前占用大小
	TItemContainerSize_t getGridSize(){ return _vecSize; }
	// 添加格子大小
	EGameRetCode addGridSize(TItemContainerSize_t var);
	// 初始化GUDI
	void setItemGUID(TItemIndexID_t guid){_itemGUID = guid;}
	// 获取背包类型
	EBagType getBagType(){return _bagType;}
	//初始化使用者
	void setRole(CRole * prole){_pRole = prole;}
// 	//检查是否在CD时间内
// 	bool isCDTime(const CItemData * pitem);
// 	//剩余CD时间
// 	GXMISC::CGameTime surplusCDTime(const CItemData * pitem);

	//公共接口
public:
	// 新增道具
	// 参数TRecItemInfo：具体添加道具数据
	// 参数checkpile：是否要叠加检查
	// 参数sendmsg：是否要广播更新
	EGameRetCode addNewItem(TItemInfo* iteminfo, EItemRecordType itemRecordType = ITEM_RECORD_DEFAULT, bool sendMsg = true, bool checkPile = true);
	EGameRetCode addNewItem(TItemInfo* iteminfo, TItemIndexID_t desindex, EItemRecordType itemRecordType = ITEM_RECORD_DEFAULT, bool sendmsg = true);
	//注意TItemInfoVec & iteminfovec的容器，在执行方法后，数据内容会有变化不能直接使用
	EGameRetCode addNewItemVec(TItemInfoVec iteminfovec, TItemInfoVec & recodevec, EItemRecordType itemcirs = ITEM_RECORD_DEFAULT, bool sendmsg = true, bool checkpile = true);
	// 扣除道具，可能删除道具(当道具数目为0时)
	EGameRetCode deductItemByGUID(TItemUID_t guid, TItemNum_t itemnum);
	EGameRetCode deductItemByTypeID(TItemTypeID_t mark, TItemNum_t itemnum);
	EGameRetCode deductItemByIndex(TItemIndexID_t index, TItemNum_t itemnum);
	// 删除道具
	EGameRetCode deleteItemByGUID(TItemUID_t itemGUID);
	EGameRetCode deleteItemByIndex(TItemIndexID_t index);
	EGameRetCode deleteItem(const CItemData * pItemData);
	// 统计道具数目
	TItemNum_t countItemByType(TItemType_t type);
	TItemNum_t countItemByTypeID(TItemTypeID_t itemTypeID);
	// 道具数目是否足够
	bool isEnoughItemNum(TItemType_t type, TItemNum_t itemNum);
	bool isEnoughItemNum(TItemTypeID_t itemTypeID, TItemNum_t itemNum);
	// 出售道具
	EGameRetCode sellItem(TItemUID_t guid);
	EGameRetCode sellItem(TItemIndexID_t index);
	// 背包是否已满
	EGameRetCode isFullBagGuird();
	// 能否容纳下指定的道具
	bool canPileItems(TItemTypeID_t itemTypeID, TItemNum_t itemNum);

private:
	// 查找可添加下标
	inline bool _findEmptyIndex(TItemIndexID_t & itemindex);
	// 查找下标是否可以使用
	inline bool _isEmptyIndex(TItemIndexID_t  itemindex);
	// 生成新的GUID
	inline TItemUID_t _genItemGUID(){return ++_itemGUID;}
	// 刪除道具
//	inline void _deleteItemMap(TItemUID_t guid);
	// 通过道具ID查找相同的道具列表
	inline void _findSameTypeIDItemList(TItemTypeID_t type, CItemDataVec & objvec);
	// 主动更新(叠加)操作
	inline void _actUpdateItem(TItemInfo* iteminfo, TActUpdateItemAry & itemary,  CItemDataVec & objvec);
	// 记录辅助方法
	inline void _handleRecode(const TItemInfo* info, TItemInfoVec & tempvec);
	// 初始化容器
	inline void _initContainerInfo();
	// 添加道具(在Vector和Map同时操作)
	void _addItemVecMap(CItemData* pItem);
	// 删除道具(在Vector和Map同时操作)
	void _deleteItemVecMap(TItemIndexID_t index);
private:
	GXMISC::CFixObjPool<CItemData> _objPool;

private:
	CItemDataVec			_itemDataVec;		///< 道具列表
	CItemDataMap			_itemDataMap;		///< 道具map表
	TItemContainerSize_t	_vecCapacity;		///< 总容器容量
	TItemContainerSize_t	_vecSize;			///< 占用大小
	EBagType				_bagType;			///< 背包类型
	CItemOperator			_itemOperator;		///< 容器操作对象
	TItemUID_t				_itemGUID;			///< 自增GUID
	CRole*					_pRole;				///< 使用角色
};

#endif //_ITEM_CONTAINTER_H_