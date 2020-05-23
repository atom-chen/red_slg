#include "core/debug.h"
#include "core/string_common.h"
#include "core/db_util.h"
#include "core/ucstring.h"
#include "core/db_single_conn_manager.h"
#include "core/game_exception.h"

#include "world_db_task.h"
#include "world_db_handler.h"
#include "world_player.h"
#include "world_player_mgr.h"
#include "world_server_util.h"
#include "world_player_handler.h"
#include "game_util.h"
#include "world_user.h"
#include "game_misc.h"
#include "world_login_player_mgr.h"
#include "world_server.h"
#include "module_def.h"
#include "db_sql_define.h"
#include "db_table_def.h"
#include "world_user_mgr.h"
#include "constant_tbl.h"
#include "constant_define.h"
#include "server_struct.h"
#include "packet_cl_login.h"
#include "game_time.h"
#include "world_db_server_handler.h"
#include "world_login_server_mgr.h"
#include "world_server_data.h"
#include "world_sql_manager.h"
#include "db_filed_parse.h"

void CWorldDbGameInitTask::doWork(mysqlpp::Connection * conn) 
{
	CWorldDbGameInitRetTask* retTask = newTask<CWorldDbGameInitRetTask>();
	if (retTask == NULL) {
		gxError("Can't alloc CWorldDbGameInitRetTask! DbUniqueIndex = {0}", getDbUserIndex());
		return;
	}
	retTask->retCode = RC_FAILED;

	DB_BEGIN(LOGIN_MOD);

	mysqlpp::Query query = conn->query(GXMISC::gxToString(DSelectMaxRoleUID, DB_ROLE_TBL));
	mysqlpp::StoreQueryResult res = query.store();
	if ( res ) 
	{
		TRoleUID_t initRoleUID = CGameMisc::GenRoleUID(GEN_INIT_ROLE_UID, g_WorldServer->getWorldServerID());
		retTask->maxRoleUID = initRoleUID;
		retTask->maxObjUID = TEMP_ROLE_INIT_UID;
		mysqlpp::StoreQueryResult::const_iterator it;
		for (it = res.begin(); it != res.end(); ++it) {
			mysqlpp::Row row = *it;
			GXMISC::conv(retTask->maxRoleUID, row[0], initRoleUID);
			GXMISC::conv(retTask->maxObjUID, row[1], TEMP_ROLE_INIT_UID);
			break;
		}

		GXMISC::CSimpleSqlQuery simpleQuery(conn);
		retTask->maxNameID = 0;

		if(simpleQuery.getCount(DB_ROLE_TBL, "`name` LIKE 'GMR%' GROUP BY `name` DESC LIMIT 1") > 0)
		{
			GXMISC::CSimpleQueryResult<TRoleName_t> nameRes = simpleQuery.execute<TRoleName_t>(DB_ROLE_TBL, "name", conn,
				"`name` LIKE 'GMR%' GROUP BY SUBSTRING(`name`, 4)+0 DESC LIMIT 1;");
			if(nameRes.succFlag)
			{
				retTask->retCode = RC_SUCCESS;
				std::string nameIDString;
				nameIDString.assign(nameRes.value1.begin()+3, nameRes.value1.end());
				uint32 nameID = 0;
				GXMISC::gxFromString(nameIDString, nameID);
				retTask->maxNameID = nameID+1;
			}
			else
			{
				retTask->maxNameID = 10000000;
			}
		}
		else
		{
			retTask->retCode = RC_SUCCESS;
		}
	}
	else
	{
		retTask->retCode = RC_FAILED;
		gxError("Sql error: {0}, {1}", query.errnum(), query.error());
	}

	DB_END();

	pushTask(retTask);
}

void CWorldDbGameInitRetTask::doRun() 
{
	if (retCode == RC_FAILED) {
		gxError("Can't init game data!");
		DWorldServer->setStop();
		return;
	}

	DWorldPlayerMgr.setGenRoleUID(maxRoleUID, maxObjUID, maxNameID);
}

void CWorldDbServerInitTask::doWork(mysqlpp::Connection * conn) {
	CWorldDbServerInitRetTask* retTask = newTask<CWorldDbServerInitRetTask>();
	if (retTask == NULL) {
		gxError("Can't alloc CWorldDbServerInitRetTask! DbUniqueIndex = {0}", getDbUserIndex());
		return;
	}
	retTask->retCode = RC_FAILED;

	DB_BEGIN(LOGIN_MOD);

	GXMISC::CSimpleSqlQuery sqlQuery(conn);
	GXMISC::TDbCol serverInfoColDef[] =
	{
		_DBCOL_TYPE_ADDR_("client_listen_ip", TCharArray2, retTask->clientListenIP),						///< 客户端IP
		_DBCOL_TYPE_ADDR_("client_listen_port", GXMISC::TPort_t, retTask->clientListenPort),				///< 客户端端口
		_DBCOL_TYPE_ADDR_("server_first_start_time", GXMISC::CGameTime, retTask->serverFirstStartTime),		///< 第一次启动时间
		_DBCOL_TYPE_ADDR_("server_open_time", GXMISC::CGameTime, retTask->serverOpenTime),					///< 开服时间
		_DBC_NULL_
	};

	if(sqlQuery.selectEx(serverInfoColDef, DCountOf(serverInfoColDef), DB_ZONE_SERVER_TBL, DDbEQ("server_id", serverID)) > 0){
		if(!retTask->serverFirstStartTime){
			retTask->serverFirstStartTime = (GXMISC::TGameTime_t)std::time(NULL);
			if(sqlQuery.updateEx(DB_ZONE_SERVER_TBL, serverInfoColDef, DCountOf(serverInfoColDef), DDbEQ("server_id", serverID)) < 0){
				gxError("Can't update server info!ServerID={0},ServerFirstStartTime={1}", serverID, std::string(retTask->serverFirstStartTime));
				goto end;
			}
		}

		GXMISC::CGameTime curTime = (GXMISC::TGameTime_t)std::time(NULL);
		GXMISC::TDbCol serverLastStartTimeColDef[] =
		{
			_DBCOL_TYPE_ADDR_("server_last_start_time", GXMISC::CGameTime, curTime),					///< 上次启动时间
			_DBC_NULL_
		};
		if(sqlQuery.updateEx(DB_ZONE_SERVER_TBL, serverLastStartTimeColDef, DCountOf(serverLastStartTimeColDef), DDbEQ("server_id", serverID)) < 0){
			gxError("Can't update server info!ServerID={0},ServerLastStartTime={1}", serverID, std::string(curTime));
			goto end;
		}

		retTask->retCode = RC_SUCCESS;
	}else{
		gxError("Can't select server info!ServerID={0}", serverID);
	}

	DB_END();

end:
	pushTask(retTask);
}

void CWorldDbServerInitRetTask::doRun() 
{
	if (!IsSuccess(retCode)) {
		gxError("Can't init server data!");
		DWorldServer->setStop();
		return;
	}

	DWorldServer->getServerInfo()->setFirstStartTime(serverFirstStartTime);
	DWorldServer->getServerInfo()->setOpenTime(serverOpenTime);
	DWorldMapPlayerMgr.updateServerInfo();
}

void CWorldDbResponseTask::doRun()
{
	CWorldDbHandler* handler =
		dynamic_cast<CWorldDbHandler*>(getDbConnWrap()->findUser(getDbUserIndex()));
	if (NULL != handler) {
		CWorldPlayer* player = DWorldPlayerMgr.findInEnterByAccountID(
			accountID);
		if (NULL != player) {
			doWork(player);
		} else {
			gxError("Can't find world player! AccountID = {0}", handler->getAccountID());
		}
	} else {
		gxError("Can't find db handler! DbUniqueIndex = {0}", getDbUserIndex());
	}
}

void CWorldDbConnectVerifyRetTask::doRun()
{
	FUNC_BEGIN(LOGIN_MOD);

	WCVerifyConnectRet verifyAccountRet;
	verifyAccountRet.setRetCode(retCode);
	verifyAccountRet.roleUID = INVALID_ROLE_UID;

	gxInfo( "CWorldDbConnectVerifyRetTask! ReturnCode = {0}, SocketIndex = {1}, LoginKey = {2}, DbIndex = {3}",
		retCode, socketIndex, loginKey, getDbUserIndex());

	CWorldPlayerHandler* socketHandler = dynamic_cast<CWorldPlayerHandler*>(DWorldNetMgr->getSocketHandler(socketIndex));
	if (NULL == socketHandler) {
		verifyAccountRet.setRetCode(RC_FAILED);
		gxError("Can't find CWorldPlayerHandler! SocketIndex = {0},LoginKey={1}", socketIndex, loginKey);
		return;
	}

	CWorldDbHandler* dbHandler = socketHandler->getDbHandler();
	if (NULL == dbHandler) {
		verifyAccountRet.setRetCode(RC_FAILED);
		gxError("Can't find CWorldPlayerHandler! SocketIndex = {0}", socketIndex);
		goto Exit0;
	}

	// 账号验证成功
	if (verifyAccountRet.getRetCode() == RC_SUCCESS) 
	{
		CWorldPlayer* oldPlayer = DWorldPlayerMgr.findByAccountID(accountID);
		if (NULL != oldPlayer)
		{
			CLoginPlayer* oldLoginPlayer = DLoginPlayerMgr.findByAccountID(accountID);
			if (NULL != oldLoginPlayer)
			{
				gxWarning("Exist old login player!{0}", oldLoginPlayer->toString());
				oldLoginPlayer->kickByOtherPlayer();
			}

			CLoginPlayer* loginPlayer = DLoginPlayerMgr.addPlayer(socketIndex, accountID, roleList, getDbUserIndex());
			if (NULL == loginPlayer) 
			{
				// 无法添加登陆等待玩家
				gxError("Cant add login player!AccountID={0},LoginKey={1},SocketIndex={2}", accountID, loginKey, socketIndex);
				verifyAccountRet.setRetCode(RC_FAILED);
				goto Exit0;
			}

			// 账号已经存在了, 将对方账号T下线
			if(oldPlayer->kickByOtherPlayer())
			{
				// 旧账号数据不需要释放, 直接T下线
				gxInfo("World db connect verify ret,direct kick player!AccountID={0},LoginKey={1},SocketIndex={2}",
					accountID, loginKey, socketIndex);
				oldPlayer->quit(true, "Kick by other!");
			}
			else
			{
				// 必须要等待旧账号数据, 加载成功才能登陆
				gxWarning("Old player role data is not unload, please wait!{0}, {1}", oldPlayer->toString(), loginPlayer->toString());
			}

			loginPlayer->setLoginQuick(false);
			loginPlayer->setSourceWay(sourceWay);
			loginPlayer->setChisourceWay(chiSourceWay);
			loginPlayer->setGmPower(gmPower);

			return;
		}
		else
		{
			CLoginPlayer* oldLoginPlayer = DLoginPlayerMgr.findByAccountID(accountID);
			if (NULL != oldLoginPlayer)
			{
				gxWarning("World db connect verify ret, exist old login player!{0}", oldLoginPlayer->toString());
				oldLoginPlayer->kickByOtherPlayer();
			}

			CLoginPlayer* loginPlayer = DLoginPlayerMgr.addPlayer(socketIndex, accountID, roleList, getDbUserIndex());
			if (NULL == loginPlayer) 
			{
				// 无法添加登陆等待玩家
				verifyAccountRet.setRetCode(RC_FAILED);
				goto Exit0;
			}

			gxInfo("World db connect verify ret,add to login player!AccountID={0},LoginKey={1},SocketIndex={2}",
				accountID, loginKey, socketIndex);

			loginPlayer->setLoginQuick(true);
			loginPlayer->setLoginKey(loginKey);
			loginPlayer->setSourceWay(sourceWay);
			loginPlayer->setChisourceWay(chiSourceWay);
			loginPlayer->setGmPower(gmPower);
		}
	}

Exit0:
	// 账号验证没有通过, 做玩家的清理工作
	if (verifyAccountRet.getRetCode() == RC_FAILED && socketHandler != NULL ) {
		// 分开发送数据包, 保证验证账号数据包在前面发送
		socketHandler->sendPacket(verifyAccountRet);
		gxError("Account verify failed! SocketIndex = {0}", socketIndex);
		doPlayerClean();
	}

	FUNC_END(DRET_NULL);
}

void CWorldDbConnectVerifyRetTask::doPlayerClean() 
{
	DWorldNetMgr->closeSocket(socketIndex, CLOSE_SOCKET_WAIT_TIME);
	DWorldDbMgr->removeUser(getDbUserIndex());
}

void CWorldDbConnectVerifyTask::doWork(mysqlpp::Connection * conn)
{
	CWorldDbConnectVerifyRetTask* retTask = newTask<CWorldDbConnectVerifyRetTask>();
	if (retTask == NULL)
	{
		gxError("Can't alloc CWorldDbAccountVerifyTaskRet! DbUniqueIndex = {0}", getDbUserIndex());
		return;
	}
	retTask->retCode = RC_FAILED;
	retTask->socketIndex = socketIndex;
	retTask->gmPower = gmPower;

	DB_BEGIN(LOGIN_MOD);

	gxInfo("World db connect verify!LoginKey={0},SocketIndex={1},AccountID={2}", loginKey, socketIndex, accountID);

	GXMISC::CSimpleSqlQuery simpleQuery(conn);
	// 插入新的记录
	if (simpleQuery.getCount(DB_ACCOUNT_TBL, DDbEQ("account_id", loginKey)) <= 0)
	{
		GXMISC::TDbColAryVec dbCols;
		dbCols.resize(1);
		dbCols[0].pushBack(_DBCOL_TYPE_OBJ_("account_id", loginKey));
		simpleQuery.insertEx(DB_ACCOUNT_TBL, dbCols);
	}

	// @TODO 这里全部用loginKey, 本来应该用accountID的
	retTask->loginKey = loginKey;
	retTask->accountID = loginKey;
	retTask->sourceWay = sourceWay;
	retTask->chiSourceWay = chiSourceWay;

	if (getRoleList(conn, retTask->roleList, retTask->accountID))
	{
		retTask->retCode = RC_SUCCESS;
	}

	DB_END();

	getDbConn()->pushTask(retTask, getDbUserIndex());
}

// 废弃掉账号验证两个函数
void CWorldDbAccountVerifyRetTask::doRun()
{
	DB_BEGIN(LOGIN_MOD);

	LCVerifyAccountRet verifyAccountRet;
	verifyAccountRet.setRetCode(retCode);

	gxInfo( "CWorldDbAccountVerifyRetTask! ReturnCode = {0}, SocketIndex = {1}, LoginKey = {2}, DbIndex = {3}",
		retCode, socketIndex, loginKey, getDbUserIndex());

	CWorldPlayerHandler* socketHandler = dynamic_cast<CWorldPlayerHandler*>(DWorldNetMgr->getSocketHandler(socketIndex));
	if (NULL == socketHandler) {
		verifyAccountRet.setRetCode(RC_FAILED);
		gxError("Can't find CWorldPlayerHandler! SocketIndex = {0},LoginKey={1}", socketIndex, loginKey);
		return;
	}
	verifyAccountRet.serverIP = DWorldServer->getConfig()->getToClientIP();
	verifyAccountRet.port = DWorldServer->getConfig()->getToClientPort();
	verifyAccountRet.loginKey = loginKey;
	socketHandler->sendPacket(verifyAccountRet);

	DB_END();
}

void CWorldDbAccountVerifyTask::doWork( mysqlpp::Connection * conn )
{
	CWorldDbAccountVerifyRetTask* retTask = newTask<CWorldDbAccountVerifyRetTask>();
	if (retTask == NULL) 
	{
		gxError("Can't alloc CWorldDbAccountVerifyTaskRet! DbUniqueIndex = {0}", getDbUserIndex());
		return;
	}
	retTask->retCode = RC_LOGIN_NO_ACCOUNT;
	retTask->socketIndex = socketIndex;

	DB_BEGIN(LOGIN_MOD);

	GXMISC::TDBSql sql;
	sql.parse(DLoadAccount, DB_ACCOUNT_TBL, accountName.toString().c_str(), accountPass.toString().c_str());
	GXMISC::CSimpleSqlQuery simpleQuery(conn);
	GXMISC::CSimpleQueryResult<TLoginKey_t, TAccountID_t> res = simpleQuery.execute<TLoginKey_t, TAccountID_t>(sql.data(), sql.size());
	if (res.succFlag) 
	{
		retTask->loginKey = res.value1;
		retTask->accountID = res.value2;
		accountID = res.value2;
		retTask->retCode = RC_SUCCESS;
	}

	DB_END();

	getDbConn()->pushTask(retTask, getDbUserIndex());
}


bool CWorldDbConnectVerifyTask::getRoleList(mysqlpp::Connection * conn, TLoginRoleArray& roleList, TAccountID_t accountID) 
{
	DB_BEGIN(LOGIN_MOD);

	std::vector<TLoginRole> res;
	GXMISC::CSimpleSqlQuery simpleQuery(conn);
	simpleQuery.setLog(true);
	if (simpleQuery.selectEx(DB_ROLE_TBL, res, GXMISC::gxToString("account_id=%"I64_FMT"d", accountID).c_str()) >= 0)
	{
		for (uint32 i = 0; i < res.size() && !roleList.isMax(); ++i)
		{
			roleList.pushBack(res[i]);
		}

		gxInfo("Get role list success!AccountID={0}", accountID);

		return true;
	}
	return true;

	gxError("Can't get role list!AccountID={0}", accountID);

	DB_END();

	return false;
}

void CWorldCreateRoleRetTask::doWork(CWorldPlayer* player) 
{
	gxInfo("CWorldCreateRoleRetTask! Retcode = {0}, Role = {1}", retCode, role.toString());
	if(!IsSuccess(player->onBeforeResponse(PA_CREATE_ROLE_RES)))
	{
		return;
	}
	player->createRoleSuccess(retCode, &role);

	// 重新加载排行榜
// 	if(rankNum <= GetConstant<TRankNum_t>(JJC_PM))
// 	{
// 		CWorldMapPlayer* pMapPlayer = DWorldMapPlayerMgr.getLeastNormalMapServer();
// 		if(NULL != pMapPlayer)
// 		{
// 			pMapPlayer->getMapServerHandler()->sendReloadRankList();
// 		}
// 	}
}

void CWorldDbRoleCreateTask::doWork(mysqlpp::Connection * conn) 
{
	CWorldCreateRoleRetTask* retTask = newResponseTask<CWorldCreateRoleRetTask>();
	if (retTask == NULL)
	{
		gxError("Can't alloc CWorldCreateRoleRetTask! DbUniqueIndex = {0}, RoleUID = {1}, Name = {2}, ProtypeID={3}",
			getDbUserIndex(), roleUID, name.toString(), (uint32)typeID);
		return;
	}
	retTask->retCode = RC_LOGIN_CREATE_ROLE_FAILED;

	DB_BEGIN(LOGIN_MOD);

	mysqlpp::Query query = conn->query();
	mysqlpp::StoreQueryResult res;
	// 检查名字是否存在
	GXMISC::TDBSql sql;
	retTask->accountID = accountID;
	sql.parse(DCheckNameRepeat, name.toString().c_str());
	query = conn->query(sql.data());
	res = query.store();
	if(!res)
	{
		gxError("Can't check repeat role name! DbUniqueIndex = {0}, RoleUID = {1}, Name = {2}, ProtypeID={3}",
			getDbUserIndex(), roleUID, name.toString(), (uint32)typeID);
		retTask->retCode = RC_LOGIN_CREATE_ROLE_FAILED;
	}
	else
	{
		if(res.size() > 0)
		{
			gxError("Role name is repeat! DbUniqueIndex = {0}, RoleUID = {1}, Name = {2}, ProtypeID={3}",
				getDbUserIndex(), roleUID, name.toString(), (uint32)typeID);
			retTask->retCode = RC_LOGIN_NAME_REPEAT;
		}
		else
		{
			GXMISC::CGameTime createTime = (GXMISC::TGameTime_t)std::time(NULL);
			GXMISC::CGameTime logoutTime = createTime;
			TLevel_t level = 0;
			mysqlpp::Transaction trans(*conn);
			const GXMISC::TDbCol createRole[] = {
				_DBCOL_TYPE_ADDR_("role_uid", TRoleUID_t, roleUID),
				_DBCOL_TYPE_ADDR_("obj_uid", TObjUID_t, objUID),
				_DBCOL_TYPE_ADDR_("protype_id", TRoleProtypeID_t, typeID),
				_DBCOL_TYPE_ADDR_("account_id", TAccountID_t, accountID),
				_DBCOL_TYPE_ADDR_("name", TRoleName_t, name),
				_DBCOL_TYPE_ADDR_("level", TLevel_t, level),
				_DBCOL_TYPE_ADDR_("scene_id", TSceneID_t, sceneID),
				_DBCOL_TYPE_ADDR_("create_time", GXMISC::CGameTime, createTime),
				_DBCOL_TYPE_ADDR_("logout_time", GXMISC::CGameTime, logoutTime),
				_DBCOL_TYPE_ADDR_("x", TAxisPos_t, x),
				_DBCOL_TYPE_ADDR_("y", TAxisPos_t, y),
				_DBCOL_TYPE_ADDR_("rank_num", TRankNum_t, rankNum),
				_DBCOL_TYPE_ADDR_("source_way", TSourceWayID_t, sourceway),
				_DBCOL_TYPE_ADDR_("chisource_way", TSourceWayID_t, chisourceway),
				_DBC_NULL_
			};
			GXMISC::CSimpleSqlQuery simpleQuery(conn);
			simpleQuery.setLog(true);
			if(simpleQuery.insertEx(DB_ROLE_TBL, createRole, DCountOf(createRole), false) > 0)
			{
				gxInfo("Create new role success! DbUniqueIndex = {0}, RoleUID = {1}, Name = {2}, ProtypeID={3}",
					getDbUserIndex(), roleUID, name.toString(), (uint32)typeID);
				retTask->retCode = RC_SUCCESS;
				retTask->role.protypeID = typeID;
				retTask->role.roleUID = roleUID;
				retTask->role.objUID = objUID;
				retTask->role.createTime = createTime;
				retTask->role.logoutTime = logoutTime;
				retTask->role.level = level;
				retTask->role.name = name;
				retTask->role.sceneID = sceneID;
				retTask->role.pos.x = x;
				retTask->role.pos.y = y;
				retTask->accountID = accountID;
				retTask->rankNum = rankNum;
				trans.commit();
			}else{
				retTask->retCode = RC_LOGIN_CREATE_ROLE_FAILED;
			}
		}
	}

	DB_END();

	getDbConn()->pushTask(retTask, getDbUserIndex());
}

void CWorldLoadUserDataTask::doWork( mysqlpp::Connection * conn )
{
	CWorldLoadUserDataRetTask* retTask = newTask<CWorldLoadUserDataRetTask>();
	if ( retTask == NULL )
	{
		gxError("Worldserver load user data from db faild!RoleUID={0}", roleUID);
		return ;
	}
	retTask->roleUID = roleUID;
	retTask->retCode = RC_FAILED;

	DB_BEGIN(WORLD_USER_MOD);

	// 	mysqlpp::Query query = conn->query(GXMISC::gxToString(DLoadUserData, DB_USER_TBL, GXMISC::gxToString(roleUID).c_str()));
	// 	mysqlpp::StoreQueryResult res = query.store();
	// 	if ( res && res.size() > 0 )
	// 	{
	// 		retTask->retCode = RC_SUCCESS;
	// 		mysqlpp::StoreQueryResult::iterator itr = res.begin();
	// 		mysqlpp::Row row = *itr;
	// 		TUserDbData& tempData = retTask->userData;
	// 		GXMISC::convTime(tempData.closeServerTime, row[5], GXMISC::INVALID_GAME_TIME);
	// 		GXMISC::BStrToStruct(tempData.userFlag, row[6]);
	// 	}
	// 	else
	// 	{
	// 		retTask->retCode = RC_FAILED;
	// 		gxError("Load user info failed!RoleUID={0}, Sql error: {1}, {2}", roleUID, query.errnum(), query.error());
	// 	}

	DB_END();

	getDbConn()->pushTask(retTask, getDbUserIndex());
}

void CWorldLoadUserDataRetTask::doRun()
{
	if ( IsSuccess(retCode) )
	{
		CWorldUser* user = DWorldUserMgr.findUserByRoleUID(roleUID);
		if ( user == NULL )
		{
			gxError("Load user success but can't find user!!! roleUID = '{0}'", roleUID);
			return ;
		}
		user->loadDataFromDB(&userData);
	}
}