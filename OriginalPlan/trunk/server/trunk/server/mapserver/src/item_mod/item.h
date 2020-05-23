#ifndef _ITEM_H_
#define _ITEM_H_

#include "game_util.h"
#include "item_define.h"
#include "game_define.h"
#include "item_struct.h"

#include "../game_db_struct.h"
#include "../bagitem_tbl.h"

class CEquipAttrConfigTbl;
class CDrugTbl;
class CPetEggConfigTbl;

class CItemInit
{
public:
	CItemInit(const TDbItem* pItem, EPackType type, TContainerIndex_t index) : pos()
    {
        item = pItem ;
        pos.type = type;
        pos.index = index;
    }

    const TDbItem* item;		// 物品详细数据
    TItemPosition pos;			// 位置
};

class CItemTbls
{
public:
    CItemTbls()
    {
       cleanUp();
    }
public:
    bool isNull() const
    {
        return !_loaded;
    }
    void setLoaded()
    {
        _loaded = true;
    }
    uint8 getType() const
    {
        gxAssert(itemTbl);
        return itemTbl->type;
    }
    uint8 getSubType() const
    {
        gxAssert(itemTbl);
        return itemTbl->subType;
    }
    bool isMission() const
    {
        return itemTbl->type == ITEM_TYPE_CONSUME && itemTbl->subType == CONSUME_SUB_CLASS_TASK;
    }
    bool isFashion() const
    {
        return itemTbl->type == ITEM_TYPE_EQUIP && itemTbl->subType == EQUIP_TYPE_FASHION;
    }

public:
	void cleanUp()
	{
		itemTbl = NULL;
// 		equipAttrTbl = NULL;
// 		drugTbl = NULL;
		_loaded = false;
	}

public:
    CItemConfigTbl*			itemTbl;
//     CEquipAttrConfigTbl*	equipAttrTbl;
//     CDrugTbl*				drugTbl;

private:
    bool _loaded;
};

class CTempItem;
class CItem
{
	friend class CItemContainer;
	friend class CItemManager;
	friend class CItemOperator;

public:
	CItem();
	~CItem();

	// 普通属性
public:
	TObjUID_t		getObjUID()		const;					///< 对象UID
	TItemTypeID_t	getTypeID()		const;					///< 类型ID
	TItemNum_t		getNum()		const;					///< 当前数目
	const TItemPosition& getPos()	const;					///< 当前位置
	TContainerIndex_t getIndex()	const;					///< 获取索引
	GXMISC::TGameTime_t getCreateTime() const;				///< 获取创建时间
	GXMISC::TGameTime_t	getRemainTime() const;				///< 剩余时间
	uint8			getQuality()	const;					///< 物品品质
	uint8			getBind()		const;					///< 获取绑定
	TItemStre_t		getStre()		const;					///< 装备强化等级

	void setItemTypeID(TItemTypeID_t typeID);						///< 设置道具类型ID
	void setItemPos(EPackType packType, TContainerIndex_t index);	///< 道具位置
	void setNum(TItemNum_t num);									///< 设置物品数目
	void setQuality(TItemQuality_t num);										///< 设置品质
	void setBind(TItemBind_t bind = BIND_TYPE_BIND);				///< 设置BIND
	void setCreateTime(GXMISC::TGameTime_t createTime);				///< 设置创建时间
	void setRemainTime(GXMISC::TGameTime_t remainTime);							///< 设置剩余时间
	void setStre( TItemStre_t num );								///< 设置强化等级
	void addAppendAttr(TAttrType_t attrType, TValueType_t valueType, TAttrVal_t attrValue);		///< 添加附加属性
	void setGemItem(TItemTypeID_t itemTypeID, uint8 index);						///< 孔镶嵌的物品
	bool newItem(TItemTypeID_t typeID, TItemNum_t num, TItemQuality_t quality, TItemBind_t bind,
		GXMISC::TGameTime_t createTime, uint32 remainTime, TItemStre_t stre);	///< 设置道具所有数据(除附加属性及宝石外)
public:
	void updatePos();										///< 更新物品位置
	bool addNum(TItemNum_t num);							///< 添加物品数目
	bool decNum(TItemNum_t num);							///< 减少物品数目

	// 对物品格子的操作-非常重要, 慎用！！！
public:
	// 修改物品数据-非常重要, 慎用！！！
	void updateItemValue(const CItem* item);				///< 更新物品数据, 会修改内部的ObjUID, 以及会修改具体的数据
	void updateItemValue(const TDbItem* item);				///< 更新物品数据, 不会修改内部的ObjUID, 只会修改具体的数据
	void copyItemValue(const CItem* item);					///< 拷贝目标物品到当前的物品结构中, 包括ObjUID和具体数据
	const TDbItem* getItemValue() const;					///< 获取物品数据
protected:
    bool setItemValue(const TDbBaseItem* dbItem);           ///< 设置物品数据, 当前会创建一个新的ObjUID, 相当于创建了一个新的物品
	bool setDbItem(TDbItem* dbItem);						///< 将TDbItem与CItem里的_item指针关联起来, 这样_item就指向了一块具体的数据空间

	// 公共操作
public:
	void cleanUp();											///< 清空物品
	bool init(const CItemInit* pInit);						///< 初始化物品
    void lock();											///< 锁定物品
    void unLock();											///< 解锁物品
	bool empty() const;										///< 物品是否为空
	TItemNum_t getRemainLayNum() const;						///< 获取当前物品还可以叠加多少个
    uint8 getType() const;                                  ///< 获取物品类型
    uint8 getSubType() const;                               ///< 获取物品子类
    TItemNum_t getMaxLayNum() const;					    ///< 获取当前物品最大可叠加数目
	TItemNum_t getCanLayNum() const;						///< 获取能够叠加的数目

	// 规则判定
public:
	bool canLay()					const;				    ///< 物品是否可以叠加
	bool canLay(TItemTypeID_t itemTypeID, TItemNum_t num, uint8 bindType) const;	///< 物品是否可以叠加
	bool canDestroy()				const;				    ///< 是否可以摧毁
	bool canSell()					const;				    ///< 是否可以出售
	bool canLevel(TLevel_t level)	const;				    ///< 当前等级是否可以使用
	bool canBind()					const;				    ///< 是否拾取绑定
	bool canEquipBind()				const;				    ///< 是否装备绑定
	bool canStre()					const;				    ///< 是否能强化
	bool canWash()					const;				    ///< 是否能洗练

	bool isEquip()		const;							    ///< 装备
	bool isDrug()		const;							    ///< 药品
	bool isConsume()	const;							    ///< 消耗品
	bool isSkillBook()	const;							    ///< 技能书
	bool isGem()		const;							    ///< 宝石
	bool isBuffer()		const;							    ///< Buffer
	bool isScroll()		const;							    ///< 卷轴

	bool isMaxNum()		const;							    ///< 是否已经达到最大堆叠数目
	bool isBind()		const;							    ///< 是否已经绑定
	bool isLock()		const;							    ///< 是否已经锁定
	bool isOutDay()		const;							    ///< 是否已经过期
	bool isTask()		const;							    ///< 是否为任务物品
	
	bool hasGem()		const;								///< 是否有镶嵌宝石

	EGameRetCode check(bool bindFlag = true, bool lockFlag = true, bool outDayFlag = true, bool taskFlag = true, bool rentFlag = true);

	// 装备
public:
	EEquipQuality getEquipQuality()		const;			    ///< 装备品质
	uint8 getEquipPoint()				const;			    ///< 装备位置
	EEquipType getEquipType()			const;			    ///< 装备类型
	uint8 getBaseAttrNum()				const;			    ///< 基本属性数目
	TAttr getBaseAttr(uint8 pos)	    const;              ///< 指定的基本属性
	void getBaseAttr(TBaseAttrAry& ary)	const;			    ///< 基本属性列表
	uint8 getAppendAttrNum()			const;			    ///< 附加属性数目
	const TExtendAttr* getAppendAttr(uint8 index) const;			///< 获取附加属性数据
	uint8 getGemNum()					const;			    ///< 宝石数目
	uint8 getEmptyGemIndex()			const;				///< 获取宝石空位
	void getHoleGem(THoleGemAry& ary)	const;			    ///< 镶嵌的宝石列表
	void addGem(TItemTypeID_t id, uint8 index);			    ///< 镶嵌一颗宝石
	void delGem(uint8 index);							    ///< 取消一颗宝石
	TItemTypeID_t getGemTypeID( uint8 index) const;		    ///< 获取宝石类型
	bool isHoleEnchased(uint8 index)	const;			    ///< 指定的孔已经是否已经镶嵌宝石
	void addStre(sint8 val = 1);						    ///< 强化装备
// 	void getEquipAttrs(TEquipAttrs& baseAttrs, TEquipAttrs& appAttrs) const; ///< 获取到附加属性
//     void getEquipAttrs(TEquipAttrs& baseAttrs);             ///< 获取到装备属性
//     void getGemAttrs(TGemAttrs& attrs) const;               ///< 获取装备上镶嵌宝石的附加属性
public:
	static uint8 GetEquipPoint(EEquipType equip);		    ///< 获取装备的装备位置

	// 宝石
public:
	EGemQuality getGemQuality()			const;			    ///< 宝石品质

	// 药品
public:
	TBufferTypeID_t getBufferID() const;                    ///< BufferID

private:                                                    ///< 更新属性
	void _updateAttr();		///< 更新属性

	// 相关的表
public:
    static CItemTbls		GetItemTbls(TItemTypeID_t itemTypeID);			///< 获取跟物品相关的表
    static CItemTbls		GetItemTbls(uint8 itemType, uint8 itemSubType);	///< 获取跟物品相关的表

public:
    CItemConfigTbl*			getItemTbl() const;								///< 获取物品表
//    CEquipAttrConfigTbl*	getEquipAttrTbl() const;						///< 装备附加属性表 
    const CItemTbls*		getItemTbls() const;                            ///< 物品的所有表格

private:
    bool					updateConfigTbl();							    ///< 更新物品相关的配置表
    bool					updateEquipTbl( TItemTypeID_t itemTypeID );     ///< 装备表
    bool					updateDrugTbl( TItemTypeID_t itemTypeID );      ///< 药品表
    bool					updateConsumeTbl( TItemTypeID_t itemTypeID );   ///< 消耗表
    bool					updateScrollTbl( TItemTypeID_t itemTypeID );    ///< 卷轴表
    bool					updateSkillTbl( TItemTypeID_t itemTypeID );     ///< 技能书表
    bool					updateGemTbl( TItemTypeID_t itemTypeID );       ///< 宝石表
    bool					updateBufferTbl( TItemTypeID_t itemTypeID );    ///< Buffer表
    bool					updateFashionTbl(TItemTypeID_t itemTypeID );    ///< 时装表

private:
	CItemTbls		_configTbl;		///< 相关的配置表

protected:
	TDbItem*		_item;			///< 物品
	bool			_lock;			///< 是否锁定
	TObjUID_t		_objUID;		///< 对象UID
	TItemPosition	_pos;			///< 物品位置
    
public:
	//void toString(ItemBinaryString& buffer, uint32 len);
    std::string toString();
};

/// 临时道具
class CTempItem : public CItem
{
public:
	CTempItem(){ _itemData.cleanUp(); setDbItem(&_itemData); }
	CTempItem(const CTempItem& rhs) { _itemData.cleanUp(); setDbItem(&_itemData); setItem(&rhs); }
	~CTempItem(){ _itemData.cleanUp(); }

public:
    CTempItem& operator = (const CTempItem& rhs)
    {
        _itemData.cleanUp();
        setDbItem(&_itemData);
        setItem(&rhs);
        return *this;
    }

public:
	void setItem(const CItem* item);					///< 生成一个与目标物品一模一样的临时物品, 不会生成新的物品及ObjUID
	void setPos(uint8 type, TContainerIndex_t index);	///< 设置道具位置
	
private:
	TDbItem _itemData;
};

#endif