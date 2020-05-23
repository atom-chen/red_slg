#include "core/game_exception.h"
#include "core/db_single_conn_manager.h"
#include "core/file_system_util.h"
#include "core/path.h"
#include "core/memory_util.h"

#include "map_db_role_process.h"
#include "module_def.h"
#include "db_table_def.h"


bool CHumanDBData::dumpToFile(FILE* pf)
{
	fwrite(this, sizeof(*this), 1, pf);
	return true;
}

bool CHumanDBData::dumpFromFile(FILE* pf)
{
	fread(this, sizeof(*this), 1, pf);
	return true;
}

void CHumanDBData::getUserData(CWorldUserData* data)
{
	data->level = baseData.level;
	data->accountID = baseData.accountID;
	data->roleUID = baseData.roleUID;
	data->roleName = baseData.roleName;
	data->logoutTime = baseData.logoutTime;
	data->newUser = baseData.isNewRole();
}

bool CDBLoadBase::loadFromDb( mysqlpp::Connection * conn )
{
	DB_BEGIN(ROLE_MOD);

	try
	{
		return load(conn);
	}
	catch (const mysqlpp::BadQuery& er)
	{
		gxError("Query error: {0},{1}", er.what(), _humanDB->toString());
	}
	catch (const mysqlpp::BadConversion& er)
	{
		gxError("Conversion error: {0}, \tretrieved data size: {1}, actual size: {2}, {3}", er.what(), er.retrieved, er.actual_size, _humanDB->toString());
	}
	catch (const mysqlpp::Exception& er) 
	{
		gxError("DB Exception: {0},{1}", er.what(), _humanDB->toString());
	}
	catch( ... )
	{
		gxError("DB Exception: {0}", _humanDB->toString());
	}

	return false;

	DB_END_RET(false);
}

bool CDBLoadBase::saveToDb( mysqlpp::Connection * conn, bool offlineFlag )
{
	DB_BEGIN(ROLE_MOD);
	
	return save(conn, offlineFlag);

	DB_END_RET(false);
}

void CDBLoadBase::cleanUp()
{
	_roleUID = INVALID_ROLE_UID;
	_humanDB = NULL;
	setLock(false);
}

std::string CHumanDB::GenDBFileName(TRoleUID_t roleUID)
{
	return "db/roles/" + GXMISC::gxToString(roleUID)+".db";
}

bool CHumanDB::roleIsExist(TRoleUID_t roleUID)
{
	return GXMISC::CFile::IsExists(GenDBFileName(roleUID));
}

bool CHumanDB::dumpToFile(std::string path)
{
//	GXMISC::MyWriteStringFile(path, (const char*)_dbData, sizeof(*_dbData));
	GXMISC::MyWriteStringFile(path, _buffer.c_str(), _buffer.length());

	return true;
}

bool CHumanDB::dumpFromFile( std::string path )
{
	if (GXMISC::CFile::IsExists(path))
	{
		/*
		FILE* pf = NULL;

		pf = fopen(path.c_str(), "rb");
		if (NULL == pf)
		{
			gxError("Can't open file!FileName={0}", path);
			fclose(pf);
			return false;
		}
		
		if (fread((_dbData), 1, sizeof(*_dbData), pf) != sizeof(*_dbData))
		{
			gxError("Can't read file!FileName={0}", path);
			fclose(pf);
			return false;
		}
		
		size_t pos = ftell(pf);
		fseek(pf, 0, SEEK_END);
		size_t endpos = ftell(pf);
		size_t len = endpos - pos;
		char* buff = new char[len];
		fseek(pf, pos, SEEK_SET);
		if (fread(buff, 1, len, pf) != len)
		{
			gxError("Can't read file!FileName={0}", path);
			fclose(pf);
			return false;
		}
		
		_buffer.assign(buff, len);

		DSafeDeleteArray(buff);
		fclose(pf);
		*/
		return GXMISC::MyReadStringFile(path, _buffer);
	}

	return false;
}

void CHumanDB::initData( CHumanDBData* dbData )
{
	_dbData = dbData;
	_humanDB = this;
}

void CHumanDB::cleanUp()
{
	TBaseType::cleanUp();
	_dbData = NULL;
	_saveDataType = SAVE_ROEL_TYPE_OFFLINE;
}

CHumanDBData* CHumanDB::getHumanDbData() const
{
	return _dbData;
}

const std::string CHumanDB::toString()
{
	return "";
}

bool CHumanDB::load( mysqlpp::Connection * conn )
{
// 	if(!baseLoad.loadFromDb(conn))
// 	{
// 		gxError("Load dbHuman data failed!{0}", toString());
// 		return false;
// 	}
// 
// 	if(!bagitemLoad.loadFromDb(conn))
// 	{
// 		gxError("Load bagitem data failed!{0}", toString());
// 		return false;
// 	}
// 
// 	if(!missionLoad.loadFromDb(conn))
// 	{
// 		gxError("Load mission data failed!{0}", toString());
// 		return false;
// 	}

	return dumpFromFile(GenDBFileName(_roleUID));
}

bool CHumanDB::save( mysqlpp::Connection * conn, bool offlineFlag )
{
// 	mysqlpp::Transaction transcation(*conn);
// 
// 	if(!baseLoad.saveToDb(conn, offlineFlag))
// 	{
// 		gxError("Save dbHuman data failed!{0}", toString());
// 		return false;
// 	}
// 
// 	if(!bagitemLoad.saveToDb(conn, offlineFlag))
// 	{
// 		gxError("Save bagitem data failed!{0}", toString());
// 		return false;
// 	}
// 
// 	if(!missionLoad.saveToDb(conn, offlineFlag))
// 	{
// 		gxError("Save mission data failed!{0}", toString());
// 		return false;
// 	}
// 
// 	transcation.commit();

	return dumpToFile(GenDBFileName(_roleUID));
}

void CHumanDB::initLoad()
{
	baseLoad.init(getRoleUID(), this);
	baseLoad.initData(&_dbData->baseData);
//	missionLoad.init(getRoleUID(), this);
//	missionLoad.initData(&_dbData->missionData);
}

ESaveRoleType CHumanDB::getSaveDataType() const 
{
	return _saveDataType; 
}
void CHumanDB::setSaveDataType(ESaveRoleType val) 
{ 
	_saveDataType = val; 
}

void CHumanDB::initHumanDBBackup( CHumanDBBackup* dbData )
{
	memcpy(_dbData, dbData->getHumanDbData(), sizeof(*_dbData));
	_buffer = dbData->_buffer;
	init(dbData->getRoleUID(), this);
	initLoad();
}

CHumanBaseData* CHumanDB::getBaseData() const
{
	return &getHumanDbData()->baseData;
}

CHumanDB::CHumanDB()
{
	cleanUp();
}

CHumanDB::~CHumanDB()
{
	cleanUp();
}

void CHumanDB::initBufferData(const char* buffer, sint32 len)
{
	_buffer.assign(buffer, len);
}

const char* CHumanDB::getDataBuffer() const
{
	return _buffer.c_str();
}

void CHumanDB::setDataBuffer(const char* buff, sint32 len)
{
	_buffer.assign(buff, len);
}

bool CHumanDBBaseLoad::load( mysqlpp::Connection * conn )
{
	DB_BEGIN(ROLE_DB_MOD);

	GXMISC::CSimpleSqlQuery simpleQuery(conn);

//	simpleQuery.setLog(true);
	GXMISC::TDbColAryVec dbCols;
	dbCols.resize(1);
	GXMISC::TDBVersion_t dbVersion = 0;
	CHumanDBBaseLoad::GenDbColAry(dbCols[0], _data->roleUID, dbVersion, *_data, true);
	if(simpleQuery.selectEx(DB_ROLE_TBL, dbCols, DDbEQ("role_uid", getRoleUID())) <= 0)
	{
		gxError("Cant load role base data!RoleUID={0}", getRoleUID());
		return false;
	}

	dbCols[0].clear();
	CHumanDBBaseLoad::GenRmbDbColAry(dbCols[0], _data->roleUID, dbVersion, *_data);
	if(simpleQuery.selectEx(DB_ACCOUNT_TBL, dbCols, DDbEQ("account_id", _data->accountID)) <= 0)
	{
		gxError("Cant load role rmb data!RoleUID={0}", getRoleUID());
		return false;
	}

	return true;

	DB_END_RET(false);
}

bool CHumanDBBaseLoad::save( mysqlpp::Connection * conn, bool offlineFlag )
{
	DB_BEGIN(ROLE_DB_MOD);

	GXMISC::CSimpleSqlQuery simpleQuery(conn);

//		simpleQuery.setLog(true);
	GXMISC::TDbColAryVec dbCols;
	dbCols.resize(1);
	TRoleUID_t roleUID = getRoleUID();
	GXMISC::TDBVersion_t dbVersion = 0;
	CHumanDBBaseLoad::GenDbColAry(dbCols[0], _data->roleUID, dbVersion, *_data, false);

	if(simpleQuery.updateEx(DB_ROLE_TBL, dbCols, DDbEQ("role_uid", getRoleUID())) <= 0)
	{
		gxError("Cant save role base data!RoleUID={0}", getRoleUID());
		return false;
	}

	dbCols[0].clear();
	CHumanDBBaseLoad::GenRmbDbColAry(dbCols[0], _data->roleUID, dbVersion, *_data);
	if(simpleQuery.updateEx(DB_ACCOUNT_TBL, dbCols, DDbEQ("account_id", _data->accountID)) <= 0)
	{
		gxError("Cant load role rmb data!RoleUID={0}", getRoleUID());
		return false;
	}

	return true;

	DB_END_RET(false);;
}

std::string CHumanDBBaseLoad::toString()
{
	if ( _data == NULL )
	{
		gxError("Not init role data!!!");
		gxAssert(false);
		return INVALID_STRING;
	}

	return GXMISC::gxToString("AccountID=%"I64_FMT"u,RoleUID=%"I64_FMT"u,ObjUID=%u", _data->accountID, _data->roleUID, _data->objUID);
}

void CHumanDBBaseLoad::GenDbColAry(GXMISC::TDbColAry& cols, TRoleUID_t& roleUID, GXMISC::TDBVersion_t& version, CHumanBaseData& data, bool loadFlag)
{
	DB_BEGIN(ROLE_DB_MOD);

	if(loadFlag)
	{
		cols.pushBack(_DBCOL_TYPE_OBJ_MKEY_("role_uid", roleUID));
		cols.pushBack(_DBCOL_TYPE_OBJ_("create_time", data.createTime));
		cols.pushBack(_DBCOL_TYPE_OBJ_("account_id", data.accountID));
		cols.pushBack(_DBCOL_TYPE_OBJ_("obj_uid", data.objUID));
	}

	if(!loadFlag)
	{
		cols.pushBack(_DBCOL_TYPE_OBJ_("sex", data.sex));
		GXMISC::TGameTime_t createTime = data.createTime.getGameTime();
		cols.pushBack(_DBCOL_TYPE_OBJ_("create_stamp", createTime));
	}

	cols.pushBack(_DBCOL_TYPE_OBJ_("db_version", version));
	cols.pushBack(_DBCOL_TYPE_OBJ_("level", data.level));
	cols.pushBack(_DBCOL_TYPE_OBJ_("name", data.roleName));
	cols.pushBack(_DBCOL_TYPE_OBJ_("scene_id", data.sceneID));
	cols.pushBack(_DBCOL_TYPE_OBJ_("last_scene_id", data.lastSceneID));
	cols.pushBack(_DBCOL_TYPE_OBJ_("last_map_id", data.lastMapID));
	cols.pushBack(_DBCOL_TYPE_OBJ_("last_pos_x", data.lastMapPos.x));
	cols.pushBack(_DBCOL_TYPE_OBJ_("last_pos_y", data.lastMapPos.y));
	cols.pushBack(_DBCOL_TYPE_OBJ_("map_id", data.mapID));
	cols.pushBack(_DBCOL_TYPE_OBJ_("x", data.mapPos.x));
	cols.pushBack(_DBCOL_TYPE_OBJ_("y", data.mapPos.y));
	cols.pushBack(_DBCOL_TYPE_OBJ_("logout_time", data.logoutTime));
	cols.pushBack(_DBCOL_TYPE_OBJ_("login_count_one_day", data.loginCountOneDay));
	cols.pushBack(_DBCOL_TYPE_OBJ_("game_money", data.gameMoney));
	cols.pushBack(_DBCOL_TYPE_OBJ_("exp", data.exp));
	cols.pushBack(_DBCOL_TYPE_OBJ_("protype_id", data.protypeID));
	cols.pushBack(_DBCOL_TYPE_OBJ_("vip_level", data.vipLevel));
	cols.pushBack(_DBCOL_TYPE_OBJ_("vip_exp", data.vipExp));
	cols.pushBack(_DBCOL_TYPE_OBJ_("bag_op_gridnum", data.bagOpenGridNum));
	cols.pushBack(_DBCOL_TYPE_OBJ_("source_way", data.source_way));
	cols.pushBack(_DBCOL_TYPE_OBJ_("chisource_way", data.chisource_way));

	DB_END();
}

void CHumanDBBaseLoad::GenRmbDbColAry( GXMISC::TDbColAry& cols, TRoleUID_t& roleUID, GXMISC::TDBVersion_t& version, CHumanBaseData& data )
{
	DB_BEGIN(ROLE_DB_MOD);

	cols.pushBack(_DBCOL_TYPE_OBJ_("rmb", data.rmb));
	cols.pushBack(_DBCOL_TYPE_OBJ_("bind_rmb", data.bindRmb));
	cols.pushBack(_DBCOL_TYPE_OBJ_("total_charge_rmb", data.totalChargeRmb));

	DB_END();
}

void CHumanDBBackup::initHumanData( CHumanDB* data )
{
	memcpy(_dbData, data->getHumanDbData(), sizeof(*_dbData));
	_buffer = data->getDataBuffer();
	init(data->getRoleUID(), this);
	initLoad();
}

bool CHumanDBMissionLoad::load( mysqlpp::Connection * conn )
{
	FUNC_BEGIN(MISSION_MOD);

	GXMISC::TDbColAryVec dbCols;
	dbCols.resize(1);
	dbCols[0].pushBack(_DBCOL_OBJ_FUNC_("accept_mission", data->acceptMissions, 0));
	dbCols[0].pushBack(_DBCOL_OBJ_FUNC_("finish_mission", data->finishMissions, 0));
	dbCols[0].pushBack(_DBCOL_TYPE_OBJ_("last_finish_mission", data->lastFinishTypeID));

	GXMISC::CSimpleSqlQuery simpleQuery(conn);

	return simpleQuery.selectEx(DB_ROLE_TBL, dbCols, DDbEQ("role_uid", getRoleUID()));

	FUNC_END(false);
}

bool CHumanDBMissionLoad::save( mysqlpp::Connection * conn, bool offlineFlag )
{
	FUNC_BEGIN(MISSION_MOD);

	GXMISC::TDbColAryVec dbCols;
	dbCols.resize(1);
	dbCols[0].pushBack(_DBCOL_OBJ_FUNC_("accept_mission", data->acceptMissions, 0));
	dbCols[0].pushBack(_DBCOL_OBJ_FUNC_("finish_mission", data->finishMissions, 0));
	dbCols[0].pushBack(_DBCOL_TYPE_OBJ_("last_finish_mission", data->lastFinishTypeID));

	GXMISC::CSimpleSqlQuery simpleQuery(conn);
	return simpleQuery.updateEx(DB_ROLE_TBL, dbCols, DDbEQ("role_uid", getRoleUID()));

	FUNC_END(false);
}
