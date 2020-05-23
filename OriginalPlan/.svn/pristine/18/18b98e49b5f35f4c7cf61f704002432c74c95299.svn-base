#ifndef _ITEM_CONTAINER_H_
#define _ITEM_CONTAINER_H_

#include "hash_util.h"
#include "item_struct.h"
#include "interval_timer.h"
#include "record_define.h"
#include "item_define.h"
#include "../game_db_struct.h"

class CItem;
class CRole;
class MCAddItems;
class MCDelItems;
class MCUpdateItems;

typedef CHashMap<TObjUID_t, TContainerIndex_t> TContainerHash;
class CItemContainer
{
public:
    friend class CItemOperator;
    friend class CGmCmdFunc;

    typedef std::set<TContainerIndex_t> TEmptyIndexSet;

public:
    CItemContainer();
    ~CItemContainer();

public:
    /// 初始化容器，分配一段内存作为容器
	void init(const TItemContainerSize_t maxSize, TItemContainerSize_t enableSize, const EPackType bagType, CRole* role);
	/// 道具数据加载完毕后调用
    void initItems();
	/// 更新
    void update(GXMISC::TDiffTime_t diff, std::vector<TContainerIndex_t>& items);
	/// 检查过期物品
    void checkOutDayItem(std::vector<TContainerIndex_t>& items);

    // 特别重要 ！！！
public:
    /**
     * 增加新物品到容器, 只有物品新生成的时候才调用这个函数  ！！！重要
     * @param checkLayItem false表示内部需要检测是否可以叠加
     * @param sendMsg rue则会发送更新消息
     * @param index 表示需要放置在容器的哪个位置, 如果无法确定则使用默认参数
     */
	EGameRetCode addItem(EItemRecordType recordType, CItem*& pRetItem, TDbBaseItem* pItem, bool checkLayItem, bool sendMsg = false, TContainerIndex_t nIndex = 0);
	EGameRetCode addItem(EItemRecordType recordType, TContainerIndex_t& retIndex, TDbBaseItem* pItem, bool checkLayItem, bool sendMsg = false, TContainerIndex_t nIndex = 0);
	EGameRetCode addItem(EItemRecordType recordType, TDbBaseItem* pItem, bool checkLayItem, bool sendMsg = false, TContainerIndex_t nIndex = 0);
	/// 统计物品数目
    bool		countItems(std::vector<TSimpleItem>& items);
	bool		countItems(std::vector<TSimpleItem>& items, EItemAttrBindType bindType);
	sint32      countItems(const TItemTypeID_t itemTypeID, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	sint32      countItems(EItemType type, uint8 subType, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL, bool isLock = true);
	/// 获取道具能够叠加的剩余数目
	sint32		countCanLay(const TItemTypeID_t itemTypeID, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	/// 扣减物品
	bool		descItems(EItemRecordType recordType, std::vector<TSimpleItem>& items);
	bool		descItems(EItemRecordType recordType, std::vector<TSimpleItem>& items, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	bool        descItem(EItemRecordType recordType, TSimpleItem& item, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	bool        descItemByTypeID(EItemRecordType recordType, TItemTypeID_t itemTypeID, TItemNum_t num, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	bool        descItemByType(EItemRecordType recordType, EItemType type, uint8 subType, TItemNum_t num, EItemAttrBindType itemArrType = ITEM_ATTR_TYPE_BIND_ALL);
	bool        descItemByIndex(EItemRecordType recordType, const TContainerIndex_t index, TItemNum_t num, bool sendMsg);
	bool        descItemByUID(EItemRecordType recordType, TObjUID_t itemObjUID, TItemNum_t num, bool sendMsg);
	/// 删除道具
	EGameRetCode delItemByIndex(EItemRecordType recordType, const TContainerIndex_t index, bool sendMsg);
	bool        delAllItems(EItemRecordType recordType, std::vector<TItemTypeID_t>& items, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	bool        delAllItem(EItemRecordType recordType, TItemTypeID_t itemTypeID, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
protected:
	/// 删除物品
	EGameRetCode delItemByIndex(const TContainerIndex_t index, bool sendMsg);
	void		delAllItem(EItemRecordType recordType, bool sendMsg);

public:
	/// 拓展容器
	bool extendContainer(TItemContainerSize_t extendSzie, TItemContainerSize_t srcSzie);
	/// 得到容器的最大大小
	TItemContainerSize_t getContainerSize();
	/// 得到玩家当前可以使用的大小
	TItemContainerSize_t getRoleContainerSize();
	/// 得到背包剩余的空位
    TItemContainerSize_t  getEmptyCount();
	/// 得到背包中有多少物品
    uint32  getItemNum();
	/// 得到背包中所有的物品
	void getAllItemObjUID(TObjUIDList& objUIDlIST);

public:
	/// 获取容器类型
    CRole* getOwner();
	/// 获取容器类型
    EPackType getContainerType();

    // 检测容器是否正常  
public:
    void checkMemError();
    void checkContainerSize();
    void checkContainerItems();

protected:
	/// 手动叠加物品, 如果目标物品绑定, 则将目标物品设置为绑定, 如果sendMsg设置成true则会发送更新消息
    EGameRetCode layItems(CItem* pSrcItem, CItem* pDestItem, TItemNum_t num, bool sendMsg);
	/// 将指定的物品放到容器的index处, 如果指定位置不为空则失败, 不会发送消息
    EGameRetCode setItem(CItem* item, TContainerIndex_t index);
	/// 在指定位置创建一个新的物品
    bool createItem(CItem* item, TContainerIndex_t index);

private:
	/// 移除物品
    EGameRetCode _eraseItem(const TContainerIndex_t index, bool sendMsg = false);
	/// 遍历叠加, 没有一个空位能直接叠加此物品
    EGameRetCode _layItems(const TDbBaseItem* pItem, bool sendMsg, uint8 bind, TContainerIndex_t& retIndex);
	/// 减少指定物品数目在容器中，在使用这个函数之前，一定要保证数目够减的！！！
    bool        _descItems(EItemType type, uint8 subType, TItemNum_t num, EItemAttrBindType bindType);
    bool        _descItems(TItemTypeID_t itemTypeID, TItemNum_t num, EItemAttrBindType bindType);
	bool        _descItem(MCDelItems* del, MCAddItems* add, TItemNum_t& num, CItem* item);
	bool		_descItem(MCDelItems* del, MCAddItems* add, EItemType type, uint8 subType, TItemNum_t& num, EItemAttrBindType bindType);
	bool		_descItem(MCDelItems* del, MCAddItems* add, TItemTypeID_t itemTypeID, TItemNum_t& num, EItemAttrBindType bindType );

    /* 对容器单个位置操作 */
public:
	/// 取出空位放置物品
    TContainerIndex_t getEmptyIndex();
	/// 取得指定位置的数据
    TDbItem* getDbItem(TContainerIndex_t index);
	/// 判断容器是否已经满
    bool isFull() const;
	/// 通过位置得到物品的唯一编号
    TObjUID_t getObjUIDByIndex(const TContainerIndex_t index);
	/// 找到指定位置的物品类型ID
    TItemTypeID_t getItemTypeByIndex(TContainerIndex_t index);
	/// 取得容器中第一个指定的类型
    CItem* getItemByTypeID(const TItemTypeID_t itemTypeID);
	/// 通过容器的索引得到物品
    CItem* getItemByIndex(const TContainerIndex_t index);
	/// 通过物品的唯一编号得到物品
    CItem* getItemByObjUID(TObjUID_t objUID);
	/// 对容器指定位置处的物品解锁
    bool unLock(TContainerIndex_t index);
	/// 对容器指定位置处的物品加锁
    bool lock(TContainerIndex_t index);
	/// 判断指定位置的物品是否被绑定
    bool isBind(TContainerIndex_t index);
	/// 设置物品的绑定属性   
    bool setBind(TContainerIndex_t index,TItemBind_t bind);
	/// 判断指定位置是否为空
    bool isEmpty(TContainerIndex_t index);
	/// 获取上次添加的道具索引
	TContainerIndex_t getLastAddItemIndex() const;
	/// 获取上次添加道具
	CItem* getLastAddItem();

    // 更新数据到客户端
public:
	/// 更新道具数据
    bool sendUpdateItem(const TContainerIndex_t index);
	/// 删除道具
    void sendDelItem(const TContainerIndex_t index);

public:
	/// 向协议中填充一个道具数据
	static void PushPackItem(MCAddItems* items, CItem* pItem);
	/// 向协议中填充一个道具数据
	static void PushPackItem(MCUpdateItems* items, CItem* pItem);
	/// 向协议中填充一个道具数据
	static void PushPackItem(MCDelItems* items, CItem* pItem);

    /*对容器多个位置操作*/
public:
	/// 检测指定的物品类型能不能被放到容器中, 根据bind参数来决定是否要绑定物品
    bool canLaying(TItemTypeID_t itemType, TItemNum_t num, uint8 bind);
	/// 自动叠加检测是否能够完全叠加, 自动叠加时不会主动叠加绑定和非绑定物品
    bool autoCanLaying(TItemTypeID_t itemType, TItemNum_t num,uint8 bind, TContainerIndex_t& outIndex);
	/// 不同容器同种物品叠放, 能够完全叠加
    bool layItemInDiffCont(CItem* item, bool laying);
	/// 是否能整理背包
	bool canPackUp();
	/// 整理
	void packUp();

protected:
	/// 向链表中增加一个空位
    bool pushList(TContainerIndex_t index);
	/// 在链表中弹出一个空位
    bool popList(TContainerIndex_t index);
	/// 在哈希表中添加一个物品
    bool pushHash(TObjUID_t objUID,TContainerIndex_t index);
	/// 在哈希表弹出一个位置
    bool popHash(TObjUID_t objUID);
	/// 得到容器的哈希表
    TContainerHash* getItemHash();

private:
    // 容器的大小
    uint32 _containerSize;
    // 玩家可以使用的大小
    uint32 _roleContainerSize;
    // 物品列表
    CItem* _itemContainer;
	// 物品内存数据
	TDbItem* _dbItems;
    // 没有存放物品的位置
    TEmptyIndexSet _emptyIndexSet;
    // 存放物品的位置
    TContainerHash _itemHash;
    // 容器类型
    EPackType _bagType;
    // 所有者
    CRole* _pOwner;
	// 检测物品过期
    GXMISC::CManualIntervalTimer _updateTimer;
	// 背包整理时间
	GXMISC::CManualIntervalTimer _upPackTime;
	// 上次增加的道具索引
	TContainerIndex_t _lastAddItemIndex;
};

#endif