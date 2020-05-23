#include "world_db_handler.h"
#include "world_db_task.h"
#include "world_player_mgr.h"
#include "new_role_tbl.h"
#include "world_sql_manager.h"

bool CWorldDbHandler::sendVerifyConnectTask( TLoginKey_t loginKey, TSourceWayID_t sourceWay, TSourceWayID_t chiSourceWay, TGmPower_t gmPower ) 
{
	genStrName();

	CWorldDbConnectVerifyTask* task = newWorldDbTask<CWorldDbConnectVerifyTask>();
	if (NULL == task) {
		gxWarning("Can't alloc task!{0}", toString());
		return false;
	}

	task->loginKey = loginKey;
	task->socketIndex = _socketIndex;
	task->sourceWay = sourceWay;
	task->chiSourceWay = chiSourceWay;
	task->gmPower = gmPower;

	gxInfo("Send verify connect task!{0}", toString());
	pushTask(task);

	return true;
}

bool CWorldDbHandler::sendVerifyAccountTask( TAccountName_t accountName, TAccountPassword_t pass )
{
	genStrName();

	CWorldDbAccountVerifyTask* task = newWorldDbTask<CWorldDbAccountVerifyTask>();
	if (NULL == task) {
		gxWarning("Can't alloc task!{0}", toString());
		return false;
	}

	task->accountName = accountName;
	task->accountPass = pass;
	task->socketIndex = _socketIndex;

	gxInfo("Send verify account task!{0}", toString());
	pushTask(task);

	return true;
}

bool CWorldDbHandler::sendCreateRoleTask(const char* name, TRoleProtypeID_t typeID, TSourceWayID_t sourceway, TSourceWayID_t chisourceway) 
{
	TRoleUID_t roleUID = DWorldPlayerMgr.genRoleUID();
	if (roleUID == INVALID_ROLE_UID) {
		gxError("Can't gen role uid!AccountID = {0}", getAccountID());
		return false;
	}
	TObjUID_t objUID = DWorldPlayerMgr.genTempRoleUID();
	if(objUID == INVALID_OBJ_UID)
	{
		gxError("Can't gen obj uid!AccountID = {0}", getAccountID());
		return false;
	}

	CNewRoleTbl* pNewRoleRow = DNewRoleTblMgr.find(typeID);
	if(NULL == pNewRoleRow)
	{
		gxError("Can't find CNewRoleConfigTbl!ProType={0}", (uint32)typeID);
		return false;
	}

	CWorldDbRoleCreateTask* task = newWorldDbTask<CWorldDbRoleCreateTask>();
	if (NULL == task) {
		return false;
	}

	task->name = name;
	task->roleUID = roleUID;
	task->objUID = objUID;
	task->typeID = typeID;
	task->accountID = getAccountID();
	task->sceneID = CGameMisc::GenSceneID(INVALID_SERVER_ID, SCENE_TYPE_NORMAL, pNewRoleRow->mapID, 0);
	task->x = pNewRoleRow->pos.x;
	task->y = pNewRoleRow->pos.y;
	task->rankNum = INVALID_RANK_NUM;
	task->sourceway = sourceway;
	task->chisourceway = chisourceway;


	gxInfo("Send create role task!{0}", toString());

	pushTask(task);

	return true;
}

void CWorldDbHandler::quit() {
	gxInfo("World db handler quit!{0}", toString());
	kick();
}