#include "core/game_exception.h"
#include "core/db_single_conn_manager.h"
#include "core/db_filed_parse.h"

#include "module_def.h"
#include "map_db_task.h"
#include "map_db_player_handler.h"
#include "packet_mw_base.h"
#include "role_manager.h"
#include "map_world_handler.h"
#include "db_table_def.h"
#include "map_server_data.h"
#include "role.h"
#include "map_server_util.h"
#include "map_player_handler.h"
#include "core/path.h"
#include "file_system_util.h"

CLoadRoleDataTask::CLoadRoleDataTask() : GXMISC::CDbWrapTask()
{
	isLocalServerLogin = false;
	loadData.cleanUp();
	changeLineTempData.cleanUp();
	requestSocketIndex = GXMISC::INVALID_SOCKET_INDEX;
	worldPlayerSockIndex = GXMISC::INVALID_SOCKET_INDEX;
	setName("CMapLoadRoleDataTask");
}

void CLoadRoleDataTask::doWork(mysqlpp::Connection * conn)
{
	CLoadRoleDataRetTask* retTask = getDbConn()->newTask<CLoadRoleDataRetTask>();
	if(NULL == retTask)
	{
		gxError("Can't new CMapLoadRoleDataRetTask! {0}", toString());
		return;
	}
	retTask->setSuccess(RC_FAILED);

	DB_BEGIN(ROLE_DB_MOD);

	gxInfo("Db load role! {0}", toString());
	retTask->loadData = loadData;
	retTask->changeLineTempData = changeLineTempData;
	retTask->setDbUserIndex(getDbUserIndex());
	retTask->humanDB.init(loadData.roleUID, &(retTask->humanDB));
	retTask->humanDB.initLoad();
	retTask->worldPlayerSockIndex =  worldPlayerSockIndex;
	retTask->requestSocketIndex = requestSocketIndex;
	retTask->isLocalServerLogin = isLocalServerLogin;
	retTask->humanDB.getBaseData()->mapID = loadData.mapID;
	retTask->humanDB.getBaseData()->mapPos = loadData.pos;

	if (!retTask->humanDB.roleIsExist(loadData.roleUID))
	{
		// 新角色
		CHumanBaseData* pBaseData = retTask->humanDB.getBaseData();
		pBaseData->roleUID = loadData.roleUID;
		pBaseData->accountID = loadData.accountID;
		pBaseData->objUID = loadData.objUID;
		pBaseData->sceneID = loadData.sceneID;
		pBaseData->mapPos = loadData.pos;
		pBaseData->mapID = loadData.mapID;
		pBaseData->protypeID = 1;
		pBaseData->createTime = GXMISC::CTimeManager::LocalNowTime();
		pBaseData->logoutTime = pBaseData->createTime;
	}
	else
	{
		if(!retTask->humanDB.loadFromDb(conn))
		{
			retTask->setSuccess(RC_FAILED);
			goto Exit0;
		}

		CHumanBaseData* pBaseData = retTask->humanDB.getBaseData();
		pBaseData->roleUID = loadData.roleUID;
		pBaseData->accountID = loadData.accountID;
		pBaseData->objUID = loadData.objUID;
		pBaseData->sceneID = loadData.sceneID;
		pBaseData->mapPos = loadData.pos;
		pBaseData->mapID = loadData.mapID;
		pBaseData->protypeID = 1;
		pBaseData->logoutTime = GXMISC::CTimeManager::LocalNowTime();
		pBaseData->createTime = pBaseData->logoutTime.getGameTime()-1000;
	}

	/*
	if ( !loadRoleGMPower(conn, retTask) )
	{
		goto Exit0;
	}

	if ( !loadRoleLimitInfo(conn, retTask) )
	{
		goto Exit0;
	}
	*/

	retTask->setSuccess(RC_SUCCESS);

	DB_END();

Exit0:
	pushTask(retTask);
}

bool CLoadRoleDataTask::loadRoleGMPower(mysqlpp::Connection* conn, CLoadRoleDataRetTask* retTask)
{
	// @TODO
	// 	TDBSql dbSql;
	// 	dbSql.parse(DQueryRoleGmPower, GXMISC::gxToString(loadData.accountID).c_str());
	// 	mysqlpp::Query query = conn->query(dbSql.data());
	// 	mysqlpp::StoreQueryResult res = query.store();
	// 	if(res)
	// 	{
	// 		if( res.size() > 0 )
	// 		{
	// 			mysqlpp::StoreQueryResult::const_iterator iter = res.begin();
	// 			mysqlpp::Row row = *iter;
	// 			conv(retTask->roleInfo.gmPower, row[0], INVALID_GM_POWER);
	// 		}
	// 		return true;
	// 	}
	// 	gxError("Operate database failed! errmsg = %s", conn->error());
	// 	retTask->errorCode = RC_FAILED;
	return true;
}

bool CLoadRoleDataTask::loadRoleLimitInfo(mysqlpp::Connection* conn, CLoadRoleDataRetTask* retTask)
{
	// @TODO
	// 	TDBSql dbSql;
	// 	dbSql.parse(DLoadRoleLimitData, GXMISC::gxToString(loadData.roleUID).c_str());
	// 	mysqlpp::Query query = conn->query(dbSql.data());
	// 	mysqlpp::StoreQueryResult res = query.store();
	// 	if(res)
	// 	{
	// 		if(res.size() > 0)
	// 		{
	// 			mysqlpp::StoreQueryResult::const_iterator iter = res.begin();
	// 			mysqlpp::Row row = *iter;
	// 			conv(retTask->roleInfo.limitChat, row[2], (uint8)0);
	// 		}
	// 		return true;
	// 	}
	// 	gxError("Operate database failed! errmsg = %s", conn->error());
	// 	retTask->errorCode = RC_FAILED;
	return true;
}

CLoadRoleDataRetTask::CLoadRoleDataRetTask() : GXMISC::CDbConnTask()
{
	isLocalServerLogin = false;
	roleInfo.cleanUp();
	loadData.cleanUp();
	changeLineTempData.cleanUp();
	requestSocketIndex = GXMISC::INVALID_SOCKET_INDEX;
	worldPlayerSockIndex = GXMISC::INVALID_SOCKET_INDEX;
	isAdult = false;
	setName("CMapLoadRoleDataRetTask");
}

void CLoadRoleDataRetTask::doRun()
{
	DB_BEGIN(ROLE_DB_MOD);

	EGameRetCode retCode = (EGameRetCode)getErrorCode();
	CRole* pRole = NULL;

	gxInfo("Load role data ret! {0}", toString());

	CMapDbPlayerHandler* handler = dynamic_cast<CMapDbPlayerHandler*>(getDbConnWrap()->findUser(getDbUserIndex()));
	if (NULL != handler)
	{
		if (isSuccess())
		{
			retCode = DRoleManager.loadRoleDataRet(&loadData, requestSocketIndex, worldPlayerSockIndex, &changeLineTempData, getDbUserIndex(), &roleInfo, &humanDB, isAdult, isLocalServerLogin, pRole);
		}
		else
		{
			handler->quit();
		}
	}
	else
	{
		gxError("Can't find CMapDbPlayerHandler! {0}", toString());
		retCode = RC_LOGIN_FAILED;
	}

	if (!isLocalServerLogin)
	{
		// 通过WorldServer登陆
		MWLoadRoleDataRet retPacket;
		retPacket.setRetCode(retCode);
		retPacket.loadData = loadData;
		retPacket.socketIndex = worldPlayerSockIndex;
		if (pRole != NULL)
		{
			pRole->getRoleUserData(&retPacket.userData);
		}
		SendToWorld(retPacket);
	}
	else
	{
 		// 本进程直接登陆
		CRole* pRole = DRoleManager.findByRoleUID(loadData.roleUID);
		if(NULL != pRole)
		{
			GXMISC::TSocketIndex_t socketIndex = pRole->getSocketIndex();
			pRole->setSocketIndex(requestSocketIndex);
			pRole->loadDataOk(&loadData);
			pRole->setSocketIndex(socketIndex);
		}
	}

	DB_END();
}
void CPlayerRegisteTask::doWork(mysqlpp::Connection * conn)
{
	CPlayerRegisteRetTask* retTask = getDbConn()->newTask<CPlayerRegisteRetTask>();
	if(NULL == retTask)
	{
		gxError("Can't new CPlayerRegisteRetTask!SocketIndex={0},AccountID={1}", socketIndex, account.toString());
		return;
	}
	retTask->setSuccess(RC_FAILED);
	retTask->account = account;
	retTask->socketIndex = socketIndex;

	// 写入文件
	if (!GXMISC::CFile::IsExists(account.toString()))
	{
		GXMISC::MyWriteStringFile(account.toString(), passwd.toString().c_str(), passwd.size());
		retTask->setSuccess(RC_SUCCESS);
	}
	else
	{
		retTask->setSuccess(RC_LOGIN_RENAME_REPEAT);
	}
}

void CPlayerRegisteRetTask::doRun()
{
	// 写入文件
	/*
	MCGameRegisterRet registeRet;
	registeRet.accountName = account;
	registeRet.setRetCode(errorCode);

	CMapPlayerHandler* pSocketHandler = dynamic_cast<CMapPlayerHandler*>(DMapNetMgr->getSocketHandler(socketIndex));
	if(nullptr == pSocketHandler)
	{
		pSocketHandler->sendPacket(registeRet);
	}
	else
	{
		gxError("Player registe, cant find socekt!!!SocketIndex={0},AccountID={1}", socketIndex, account.toString());
	}
	*/
}

void CSaveRoleDataTask::doWork(mysqlpp::Connection * conn)
{
	CSaveRoleDataRetTask* saveDataRet = newResponseTask<CSaveRoleDataRetTask>();
	if(NULL == saveDataRet)
	{
		gxError("Can't new CSaveRoleDataRet! {0}", toString());
		return;
	}
	saveDataRet->worldPlayerSockIndex = worldPlayerSockIndex;
	saveDataRet->setRetCode(RC_FAILED);
	getDbConn()->pushDelUser(getDbUserIndex());
	DB_BEGIN(ROLE_DB_MOD);
	humanDB.init(roleUID, &humanDB);
	if (humanDB.saveToDb(conn, true))
	{
		saveDataRet->setRetCode(RC_SUCCESS);
	}
	DB_END();

	if(needRet)
	{
		pushTask(saveDataRet);
	}
}

void CSaveRoleDataRetTask::doWork(CRoleBase* roleBase)
{
	CRole* role = dynamic_cast<CRole*>(roleBase);
	if(NULL != role)
	{
		if(role->getLoginPlayerSocketIndex() == worldPlayerSockIndex)
		{
			role->saveRet();
		}
		else
		{
			gxError("Save role task ret, socket index not equal!{0},{1}", role->toString(), worldPlayerSockIndex);
		}
	}
}

void CUpdateRoleDataTimerTask::doWork( mysqlpp::Connection * conn )
{
	DB_BEGIN(ROLE_DB_MOD);
	if(getDbConn()->isDelUser(getDbUserIndex()))
	{
		// Unique Index 对应的连接已经失效
		gxWarning("Role index is invalid!RoleUID={0}", roleUID);
		return;
	}
	GXMISC::TGameTime_t curTime = (GXMISC::TGameTime_t)SystemCall::time(NULL);
	if((curTime - getStartTime()) > (GXMISC::DB_DEL_USER_EXIST_TIME+1))
	{
		// 任务过期
		return;
	}
	humanDB.init(roleUID, &humanDB);
	if (!humanDB.saveToDb(conn, false))
	{
		gxError("Can't update role data!RoleUID={0}", roleUID);
	}
	DB_END();
}
