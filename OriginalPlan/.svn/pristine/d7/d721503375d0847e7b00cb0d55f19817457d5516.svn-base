// #include "core/game_exception.h"
// #include "core/db_single_conn_manager.h"
// 
// #include "map_db_item.h"
// #include "module_def.h"
// #include "db_table_def.h"
// 
// bool CHunmanDBBagItemLoad::load( mysqlpp::Connection * conn )
// {
// 	DB_BEGIN(ITEM_MOD);
// 
// 	GXMISC::CSimpleSqlQuery simpleQuery(conn);
// //	simpleQuery.setLog(true);
// 
// 	std::string rolestr		= GXMISC::gxToString("role_uid='%"I64_FMT"u'", getRoleUID());
// 	std::string bagtypestr	= GXMISC::gxToString("bag_type='%u'", BAGCONTAINTER_TYPE);
// 
// 	sint32 count = simpleQuery.getCount("ItemTbl", rolestr.c_str(), bagtypestr.c_str());
// 	if(count == 0)
// 	{
// 		return true;
// 	}
// 
// 	_data->itemDataAry.resize(count);
// 	GXMISC::TDbColAryVec dbCols;
// 	dbCols.resize(count);
// 	for(TDBItemInfoAry::size_type i =0; i < count; ++i)
// 	{
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("bag_type", _data->itemDataAry[i].itemIndex));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("item_index", _data->itemDataAry[i].itemIndex));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("item_guid", _data->itemDataAry[i].itemGUID));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("item_mark", _data->itemDataAry[i].itemTypeID));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("item_num", _data->itemDataAry[i].itemNum));
// 		dbCols[i].pushBack(_DBCOL_OBJ_FUNC_("dyn_attry", _data->itemDataAry[i].addItemAttr, 0));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("datetime", _data->itemDataAry[i].updateTime));
// 	}
// 
// 	// Select符合条件的行数
// 	return simpleQuery.selectEx("ItemTbl", dbCols, rolestr.c_str(), bagtypestr.c_str()) >= 0;
// 
// 	DB_END_RET(false);
// }
// 
// bool CHunmanDBBagItemLoad::save( mysqlpp::Connection * conn, bool offlineFlag )
// {
// 	DB_BEGIN(ITEM_MOD);
// 
// 	GXMISC::CSimpleSqlQuery simpleQuery(conn);
// //	simpleQuery.setLog(true);
// 
// 	std::string rolestr		= GXMISC::gxToString("role_uid='%"I64_FMT"u'", getRoleUID());
// 	std::string bagtypestr	= GXMISC::gxToString("bag_type='%u'", BAGCONTAINTER_TYPE);
// 	uint8 bagtype = static_cast<uint8>(BAGCONTAINTER_TYPE);
// 
// 	// 删除符合条件的行数
// 	if(simpleQuery.deleteEx("ItemTbl", rolestr.c_str(), bagtypestr.c_str()) < 0){
// 		gxError("Can't delete ItemTbl row!RoleUID={0}, bagtype={1}", getRoleUID(), static_cast<uint16>(BAGCONTAINTER_TYPE));
// 		return false;
// 	}
// 
// 	GXMISC::TDBVersion_t dbVersion = 0;
// 	GXMISC::TDbColAryVec dbCols;
// 	dbCols.resize(_data->itemDataAry.size());
// 
// 	for (TDBItemInfoAry::size_type i = 0; i < _data->itemDataAry.size(); ++i)
// 	{
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("role_uid", _roleUID));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("bag_type", bagtype));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("item_guid", _data->itemDataAry[i].itemGUID));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("item_index", _data->itemDataAry[i].itemIndex));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("item_mark", _data->itemDataAry[i].itemTypeID));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("item_num", _data->itemDataAry[i].itemNum));
// 		dbCols[i].pushBack(_DBCOL_OBJ_FUNC_("dyn_attry", _data->itemDataAry[i].addItemAttr, 0));
// 		dbCols[i].pushBack(_DBCOL_TYPE_OBJ_("datetime", _data->itemDataAry[i].updateTime));
// 	}
// 
// 	// 插入需要保存的列表
// 	return simpleQuery.insertEx("ItemTbl", dbCols) >= 0;
// 
// 	DB_END_RET(false);
// }
// 
// void CHunmanDBBagItemLoad::setBagtype(EBagType bagtype)
// {
// 	_bagtype = bagtype;
// }
// 
// void CHunmanDBBagItemLoad::initData(CHumanBagItemData * data)
// {
// 	_data = data;
// }
// 
// void CHunmanDBBagItemLoad::cleanUp()
// {
// 	_data = NULL;
// }
// 
// CHumanBagItemData::CHumanBagItemData()
// {
// 	clean();
// }
// 
// void CHumanBagItemData::clean()
// {
// 	itemDataAry.clear();
// }
// 
// void ItemData::clean()
// {
// 	itemGUID = INVALID_ITEM_UID;
// 	itemTypeID = INVALID_ITEM_TYPE_ID;
// 	itemIndex = INVALID_ITEM_INDEX;
// 	itemNum = 0;
// 	addItemAttr.clear();
// 	updateTime = 0;
// 	isBind = 0;
// }
// 
// ItemData::ItemData()
// {
// 	clean();
// }
