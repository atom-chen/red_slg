// #ifndef _MAP_DB_ITEM_H_
// #define _MAP_DB_ITEM_H_
// 
// #include "db_struct_base.h"
// #include "bag_struct.h"
// #include "map_db_common.h"
// 
// #pragma pack(push, 1)
// 
// /// 公用物品属性结构
// // typedef struct _commonItemAttr : public GXMISC::IStreamableAll
// // {
// // 	TAddAttrAry		additemAttrAry;
// // 
// // public:
// // 	DSTREAMABLE_IMPL1(additemAttrAry);
// // }TcommonItemAttr;
// 
// //道具动态数据（数据库保存）
// typedef struct DBItemData : public GXMISC::TDBStructBase
// {
// 	TItemUID_t			itemGUID;			///< 道具一ID
// 	TItemTypeID_t		itemTypeID;			///< 道具编号
// 	TItemIndexID_t		itemIndex;			///< 道具下标ID
// 	TItemNum_t			itemNum;			///< 道具数量
// 	TAddAttrAry			addItemAttr;		///< 动态属性
// 	GXMISC::CGameTime	updateTime;			///< 更新时间
// 	TItemBind_t			isBind;				///< 是否绑定
// }TDbBItemData;
// 
// typedef struct ItemData : public TDbBItemData
// {
// 	// 保存对应配置表下的静态数据
// 	//TAttrVec _attrVec;
// 
// public:
// 	ItemData();
// 
// public:
// 	void clean();
// }TItemData;
// 
// //以下是记录到DB的列表
// typedef CArray1<struct ItemData> TDBItemInfoAry;
// 
// /// 道具DB数据结构
// struct CHumanBagItemData : public GXMISC::TDBStructBase
// {
// 	TDBItemInfoAry itemDataAry;					/// 具体背包道具列表
// 
// public:
// 	CHumanBagItemData();
// 
// public:
// 	void clean();
// };
// 
// #pragma pack(pop)
// 
// // 背包数据库对象
// class CHunmanDBBagItemLoad : public CDBLoadBase
// {
// private:
// 	EBagType	_bagtype;
// 
// public:
// 	CHunmanDBBagItemLoad()
// 	{
// 		_bagtype = INVALIDBAG_TYPE;
// 	}
// 	virtual ~CHunmanDBBagItemLoad(){}
// 
// public:
// 	CHumanBagItemData* _data;
// 
// public:
// 	void initData(CHumanBagItemData * data);
// 	void cleanUp();
// 
// protected:
// 	virtual bool load(mysqlpp::Connection * conn);							// 加载数据
// 	virtual bool save(mysqlpp::Connection * conn, bool offlineFlag);		// 保存数据
// 
// public:
// 	//设置背包类型
// 	void setBagtype(EBagType bagtype);
// };
// 
// #endif //_MAP_DB_ITEM_H_