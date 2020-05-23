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
    /// ��ʼ������������һ���ڴ���Ϊ����
	void init(const TItemContainerSize_t maxSize, TItemContainerSize_t enableSize, const EPackType bagType, CRole* role);
	/// �������ݼ�����Ϻ����
    void initItems();
	/// ����
    void update(GXMISC::TDiffTime_t diff, std::vector<TContainerIndex_t>& items);
	/// ��������Ʒ
    void checkOutDayItem(std::vector<TContainerIndex_t>& items);

    // �ر���Ҫ ������
public:
    /**
     * ��������Ʒ������, ֻ����Ʒ�����ɵ�ʱ��ŵ����������  ��������Ҫ
     * @param checkLayItem false��ʾ�ڲ���Ҫ����Ƿ���Ե���
     * @param sendMsg rue��ᷢ�͸�����Ϣ
     * @param index ��ʾ��Ҫ�������������ĸ�λ��, ����޷�ȷ����ʹ��Ĭ�ϲ���
     */
	EGameRetCode addItem(EItemRecordType recordType, CItem*& pRetItem, TDbBaseItem* pItem, bool checkLayItem, bool sendMsg = false, TContainerIndex_t nIndex = 0);
	EGameRetCode addItem(EItemRecordType recordType, TContainerIndex_t& retIndex, TDbBaseItem* pItem, bool checkLayItem, bool sendMsg = false, TContainerIndex_t nIndex = 0);
	EGameRetCode addItem(EItemRecordType recordType, TDbBaseItem* pItem, bool checkLayItem, bool sendMsg = false, TContainerIndex_t nIndex = 0);
	/// ͳ����Ʒ��Ŀ
    bool		countItems(std::vector<TSimpleItem>& items);
	bool		countItems(std::vector<TSimpleItem>& items, EItemAttrBindType bindType);
	sint32      countItems(const TItemTypeID_t itemTypeID, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	sint32      countItems(EItemType type, uint8 subType, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL, bool isLock = true);
	/// ��ȡ�����ܹ����ӵ�ʣ����Ŀ
	sint32		countCanLay(const TItemTypeID_t itemTypeID, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	/// �ۼ���Ʒ
	bool		descItems(EItemRecordType recordType, std::vector<TSimpleItem>& items);
	bool		descItems(EItemRecordType recordType, std::vector<TSimpleItem>& items, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	bool        descItem(EItemRecordType recordType, TSimpleItem& item, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	bool        descItemByTypeID(EItemRecordType recordType, TItemTypeID_t itemTypeID, TItemNum_t num, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	bool        descItemByType(EItemRecordType recordType, EItemType type, uint8 subType, TItemNum_t num, EItemAttrBindType itemArrType = ITEM_ATTR_TYPE_BIND_ALL);
	bool        descItemByIndex(EItemRecordType recordType, const TContainerIndex_t index, TItemNum_t num, bool sendMsg);
	bool        descItemByUID(EItemRecordType recordType, TObjUID_t itemObjUID, TItemNum_t num, bool sendMsg);
	/// ɾ������
	EGameRetCode delItemByIndex(EItemRecordType recordType, const TContainerIndex_t index, bool sendMsg);
	bool        delAllItems(EItemRecordType recordType, std::vector<TItemTypeID_t>& items, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
	bool        delAllItem(EItemRecordType recordType, TItemTypeID_t itemTypeID, EItemAttrBindType bindType = ITEM_ATTR_TYPE_BIND_ALL);
protected:
	/// ɾ����Ʒ
	EGameRetCode delItemByIndex(const TContainerIndex_t index, bool sendMsg);
	void		delAllItem(EItemRecordType recordType, bool sendMsg);

public:
	/// ��չ����
	bool extendContainer(TItemContainerSize_t extendSzie, TItemContainerSize_t srcSzie);
	/// �õ�����������С
	TItemContainerSize_t getContainerSize();
	/// �õ���ҵ�ǰ����ʹ�õĴ�С
	TItemContainerSize_t getRoleContainerSize();
	/// �õ�����ʣ��Ŀ�λ
    TItemContainerSize_t  getEmptyCount();
	/// �õ��������ж�����Ʒ
    uint32  getItemNum();
	/// �õ����������е���Ʒ
	void getAllItemObjUID(TObjUIDList& objUIDlIST);

public:
	/// ��ȡ��������
    CRole* getOwner();
	/// ��ȡ��������
    EPackType getContainerType();

    // ��������Ƿ�����  
public:
    void checkMemError();
    void checkContainerSize();
    void checkContainerItems();

protected:
	/// �ֶ�������Ʒ, ���Ŀ����Ʒ��, ��Ŀ����Ʒ����Ϊ��, ���sendMsg���ó�true��ᷢ�͸�����Ϣ
    EGameRetCode layItems(CItem* pSrcItem, CItem* pDestItem, TItemNum_t num, bool sendMsg);
	/// ��ָ������Ʒ�ŵ�������index��, ���ָ��λ�ò�Ϊ����ʧ��, ���ᷢ����Ϣ
    EGameRetCode setItem(CItem* item, TContainerIndex_t index);
	/// ��ָ��λ�ô���һ���µ���Ʒ
    bool createItem(CItem* item, TContainerIndex_t index);

private:
	/// �Ƴ���Ʒ
    EGameRetCode _eraseItem(const TContainerIndex_t index, bool sendMsg = false);
	/// ��������, û��һ����λ��ֱ�ӵ��Ӵ���Ʒ
    EGameRetCode _layItems(const TDbBaseItem* pItem, bool sendMsg, uint8 bind, TContainerIndex_t& retIndex);
	/// ����ָ����Ʒ��Ŀ�������У���ʹ���������֮ǰ��һ��Ҫ��֤��Ŀ�����ģ�����
    bool        _descItems(EItemType type, uint8 subType, TItemNum_t num, EItemAttrBindType bindType);
    bool        _descItems(TItemTypeID_t itemTypeID, TItemNum_t num, EItemAttrBindType bindType);
	bool        _descItem(MCDelItems* del, MCAddItems* add, TItemNum_t& num, CItem* item);
	bool		_descItem(MCDelItems* del, MCAddItems* add, EItemType type, uint8 subType, TItemNum_t& num, EItemAttrBindType bindType);
	bool		_descItem(MCDelItems* del, MCAddItems* add, TItemTypeID_t itemTypeID, TItemNum_t& num, EItemAttrBindType bindType );

    /* ����������λ�ò��� */
public:
	/// ȡ����λ������Ʒ
    TContainerIndex_t getEmptyIndex();
	/// ȡ��ָ��λ�õ�����
    TDbItem* getDbItem(TContainerIndex_t index);
	/// �ж������Ƿ��Ѿ���
    bool isFull() const;
	/// ͨ��λ�õõ���Ʒ��Ψһ���
    TObjUID_t getObjUIDByIndex(const TContainerIndex_t index);
	/// �ҵ�ָ��λ�õ���Ʒ����ID
    TItemTypeID_t getItemTypeByIndex(TContainerIndex_t index);
	/// ȡ�������е�һ��ָ��������
    CItem* getItemByTypeID(const TItemTypeID_t itemTypeID);
	/// ͨ�������������õ���Ʒ
    CItem* getItemByIndex(const TContainerIndex_t index);
	/// ͨ����Ʒ��Ψһ��ŵõ���Ʒ
    CItem* getItemByObjUID(TObjUID_t objUID);
	/// ������ָ��λ�ô�����Ʒ����
    bool unLock(TContainerIndex_t index);
	/// ������ָ��λ�ô�����Ʒ����
    bool lock(TContainerIndex_t index);
	/// �ж�ָ��λ�õ���Ʒ�Ƿ񱻰�
    bool isBind(TContainerIndex_t index);
	/// ������Ʒ�İ�����   
    bool setBind(TContainerIndex_t index,TItemBind_t bind);
	/// �ж�ָ��λ���Ƿ�Ϊ��
    bool isEmpty(TContainerIndex_t index);
	/// ��ȡ�ϴ���ӵĵ�������
	TContainerIndex_t getLastAddItemIndex() const;
	/// ��ȡ�ϴ���ӵ���
	CItem* getLastAddItem();

    // �������ݵ��ͻ���
public:
	/// ���µ�������
    bool sendUpdateItem(const TContainerIndex_t index);
	/// ɾ������
    void sendDelItem(const TContainerIndex_t index);

public:
	/// ��Э�������һ����������
	static void PushPackItem(MCAddItems* items, CItem* pItem);
	/// ��Э�������һ����������
	static void PushPackItem(MCUpdateItems* items, CItem* pItem);
	/// ��Э�������һ����������
	static void PushPackItem(MCDelItems* items, CItem* pItem);

    /*���������λ�ò���*/
public:
	/// ���ָ������Ʒ�����ܲ��ܱ��ŵ�������, ����bind�����������Ƿ�Ҫ����Ʒ
    bool canLaying(TItemTypeID_t itemType, TItemNum_t num, uint8 bind);
	/// �Զ����Ӽ���Ƿ��ܹ���ȫ����, �Զ�����ʱ�����������Ӱ󶨺ͷǰ���Ʒ
    bool autoCanLaying(TItemTypeID_t itemType, TItemNum_t num,uint8 bind, TContainerIndex_t& outIndex);
	/// ��ͬ����ͬ����Ʒ����, �ܹ���ȫ����
    bool layItemInDiffCont(CItem* item, bool laying);
	/// �Ƿ���������
	bool canPackUp();
	/// ����
	void packUp();

protected:
	/// ������������һ����λ
    bool pushList(TContainerIndex_t index);
	/// �������е���һ����λ
    bool popList(TContainerIndex_t index);
	/// �ڹ�ϣ�������һ����Ʒ
    bool pushHash(TObjUID_t objUID,TContainerIndex_t index);
	/// �ڹ�ϣ����һ��λ��
    bool popHash(TObjUID_t objUID);
	/// �õ������Ĺ�ϣ��
    TContainerHash* getItemHash();

private:
    // �����Ĵ�С
    uint32 _containerSize;
    // ��ҿ���ʹ�õĴ�С
    uint32 _roleContainerSize;
    // ��Ʒ�б�
    CItem* _itemContainer;
	// ��Ʒ�ڴ�����
	TDbItem* _dbItems;
    // û�д����Ʒ��λ��
    TEmptyIndexSet _emptyIndexSet;
    // �����Ʒ��λ��
    TContainerHash _itemHash;
    // ��������
    EPackType _bagType;
    // ������
    CRole* _pOwner;
	// �����Ʒ����
    GXMISC::CManualIntervalTimer _updateTimer;
	// ��������ʱ��
	GXMISC::CManualIntervalTimer _upPackTime;
	// �ϴ����ӵĵ�������
	TContainerIndex_t _lastAddItemIndex;
};

#endif