#include "world_sql_manager.h"
#include "db_sql_define.h"
#include "game_exception.h"
#include "module_def.h"
#include "world_login_role_list.h"
#include "db_table_def.h"
#include "world_all_user.h"

CSqlConnectionManagerBase::CSqlConnectionManagerBase()
{
}

CSqlConnectionManagerBase::~CSqlConnectionManagerBase()
{
}

bool CSqlConnectionManagerBase::addAwardBindRmb(TRmb_t rmb, TGold_t gameMoney)
{
	GXMISC::TDBSql sql;
	if (rmb > 0)
	{
		sql.parse(DAwardAllRoleBindRmb, rmb);
		if (!executeUnret(sql.data(), sql.size()))
		{
			gxError("Cant award bind rmb!");
			return false;
		}
	}

	if (gameMoney > 0)
	{
		sql.clear();
		sql.parse(DAwardAllRoleGameMoney, gameMoney);
		if (!executeUnret(sql.data(), sql.size()))
		{
			gxError("Cant award game money!");
			return false;
		}
	}

	return true;
}

bool CSqlConnectionManagerBase::addAwardItem(TRoleUID_t roleUID, TItemTypeID_t itemID, TItemNum_t num)
{
	return false;
}

bool CSqlConnectionManagerBase::addRoleAwardBindRmb(TRoleUID_t roleUID, TAccountID_t accountID, TRmb_t rmb, TGold_t gameMoney)
{
	GXMISC::TDBSql sql;
	if (rmb > 0)
	{
		sql.parse(DAwardRoleBindRmb, rmb, accountID);
		if (!executeUnret(sql.data(), sql.size()))
		{
			gxError("Cant award bind rmb!RoleUID={0}", roleUID);
			return false;
		}
	}

	if (gameMoney > 0)
	{
		sql.clear();
		sql.parse(DAwardRoleGameMoney, gameMoney, roleUID);
		if (!executeUnret(sql.data(), sql.size()))
		{
			gxError("Cant award game money!RoleUID={0}", roleUID);
			return false;
		}
	}

	return true;
}

TRoleUID_t CSqlConnectionManagerBase::getRoleUIDByAccountID(TAccountID_t accountID)
{
	GXMISC::CSimpleQueryResult<TRoleUID_t> res = execute<TRoleUID_t>(DB_ROLE_TBL, "role_uid", getConnection(), DDbEQ("account_id", accountID));
	return res.value1;
}

TRoleName_t CSqlConnectionManagerBase::getRoleNameByRoleId(TRoleUID_t roleUID)
{
	TRoleName_t roleName = "";
	GXMISC::TDbCol roleColDef[] =
	{
		_DBCOL_TYPE_ADDR_("name", TRoleName_t, roleName),
		_DBC_NULL_
	};

	if (selectEx(roleColDef, DCountOf(roleColDef), DB_ROLE_TBL, DDbEQ("role_uid", roleUID)) > 0)
	{
		return roleName;
	}

	return "";
}

TLevel_t CSqlConnectionManagerBase::getRoleLevelByRoleId(TRoleUID_t roleUID)
{
	TLevel_t lv;
	GXMISC::TDbCol roleColDef[] =
	{
		_DBCOL_TYPE_ADDR_("level", TLevel_t, lv),
		_DBC_NULL_
	};

	if (selectEx(roleColDef, DCountOf(roleColDef), DB_ROLE_TBL, DDbEQ("role_uid", roleUID)) > 0)
	{
		return lv;
	}

	return 0;
}

bool CSqlConnectionManagerBase::addAccountRmb(TAccountID_t accountID, TRmb_t rmb, TRmb_t bindRmb)
{
	// 更新玩家的账号元宝
	GXMISC::TDBSql sqlStr;
	sqlStr.parse(DAddAccountRmb, rmb, rmb, bindRmb, bindRmb, accountID);
	if (!executeUnret(sqlStr.data(), sqlStr.size()))
	{
		gxError("Update account charge data to database failed!!!AccountID={0},Rmb={1},BindRmb={0}", accountID, rmb, bindRmb);
		return false;
	}

	gxInfo("Update account charge data to database!!!AccountID={0},Rmb={1},BindRmb={0}", accountID, rmb, bindRmb);

	// @todo查询当前已经有的rmb和bindRmb,日记记录

	return true;
}

bool CSqlConnectionManagerBase::addTempRechargeRecord(TSerialStr_t serialNo, TAccountID_t accountID, TRmb_t rmb, TRmb_t bindRmb)
{
	GXMISC::TDBSql sqlStr;
	sqlStr.parse(DInsertTempRmbRecord, serialNo.c_str(), accountID, rmb, bindRmb, 0);
	return executeUnret(sqlStr.data(), sqlStr.size());
}


bool CSqlConnectionManagerBase::delTempRechargeRecord(TSerialStr_t serialNo)
{
	GXMISC::TDBSql sqlStr;
	sqlStr.parse(DDelTempRmbRecord, serialNo.c_str());
	return executeUnret(sqlStr.data(), sqlStr.size());
}

bool CSqlConnectionManagerBase::updateTempRechargeRecord(TSerialStr_t serialNo, sint8 status)
{
	GXMISC::TDBSql sqlStr;
	sqlStr.parse(DUpdateTempRmbRecordStatus, status, serialNo.c_str());
	return executeUnret(sqlStr.data(), sqlStr.size());
}

TRoleUID_t CSqlConnectionManagerBase::getLastLoginRoleUIDByAccountID(TAccountID_t accountID)
{
	TRoleUID_t roleUID = INVALID_ROLE_UID;
	GXMISC::TDBSql sqlStr;

	sqlStr.parse(DQueryLastTimeRoleUID, accountID);
	GXMISC::CSimpleQueryResult<TRoleUID_t> roleUIDRes = execute<TRoleUID_t>(sqlStr.data(), sqlStr.size());
	if (roleUIDRes.succFlag)
	{
		// 成功查询玩家的RoleUID
		roleUID = roleUIDRes.value1;
	}

	return roleUID;
}

bool CSqlConnectionManagerBase::accountRmbQuery(TAccountID_t accountID, TRmb_t& rmb, TRmb_t& bindRmb)
{
	GXMISC::TDBSql sqlStr;

	sqlStr.parse(DQueryAccountRmb, accountID);
	GXMISC::CSimpleQueryResult<TRmb_t, TRmb_t> queryRmb = execute<TRmb_t, TRmb_t>(sqlStr.data(), sqlStr.size());
	if (queryRmb.succFlag)
	{
		rmb = queryRmb.value1;
		bindRmb = queryRmb.value2;
		return true;
	}

	return false;
}

bool CSqlConnectionManagerBase::loadAllUser()
{
	FUNC_BEGIN(WORLD_USER_MOD);

	TLoginRoleVector roles;

	if (selectEx(DB_ROLE_TBL, roles) < 0){
		gxError("Can't load all user!");
		return false;
	}

	for (TLoginRoleVector::size_type i = 0; i < roles.size(); ++i){
		if (NULL == DWorldAllUserMgr.addUser(&roles[i], true)){
			gxError("Can't add user to all user manager!RoleUID={0},ObjUID={1},Name={2}", roles[i].roleUID, roles[i].objUID, roles[i].name.toString());
			return false;
		}
	}

	return true;

	FUNC_END(false);
}

bool CSqlConnectionManagerBase::loadAllUserRoleUID(std::vector<TRoleUID_t>& data)
{
	FUNC_BEGIN(WORLD_USER_MOD);

	return true;

	FUNC_END(false);
}

bool CSqlConnectionManagerBase::changeRoleObjUID(TRoleUID_t roleUID, TObjUID_t objUID)
{
	FUNC_BEGIN(WORLD_USER_MOD);

	return true;

	FUNC_END(false);
}

bool CSqlConnectionManagerBase::delRole(TRoleUID_t roleUID, const char* roleStr)
{
	FUNC_BEGIN(WORLD_USER_MOD);

	return true;

	FUNC_END(false);
}

bool CSqlConnectionManagerBase::loadUserData(TUserDbData* data)
{
	FUNC_BEGIN(WORLD_USER_MOD);

	FUNC_END(false);
}

bool CSqlConnectionManagerBase::addUserData(TUserDbData* data)
{
	FUNC_BEGIN(WORLD_USER_MOD);

	FUNC_END(false);
}

bool CSqlConnectionManagerBase::updateUserData(TRoleUID_t roleUID, TUserDbData* newData)
{
	FUNC_BEGIN(WORLD_USER_MOD);

	FUNC_END(false);
}

bool CSqlConnectionManagerBase::deleteUserData(TRoleUID_t roleUID)
{
	FUNC_BEGIN(WORLD_USER_MOD);

	FUNC_END(false);
}
