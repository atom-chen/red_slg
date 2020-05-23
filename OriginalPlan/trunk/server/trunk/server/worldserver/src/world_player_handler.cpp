#include "core/string_common.h"
#include "core/game_exception.h"

#include "world_player_handler.h"
#include "world_server.h"
#include "game_errno.h"
#include "module_def.h"
#include "world_db_handler.h"
#include "world_player.h"
#include "world_player_mgr.h"
#include "world_login_role_list.h"
#include "world_login_player_mgr.h"
#include "db_name_define.h"
#include "packet_cw_login.h"
#include "rand_name.h"
#include "new_role_tbl.h"
#include "script_engine_common.h"
#include "world_script_engine.h"

#define PacketCheckAndRet(pack, retp)   \
	gxAssert(pack->totalLen <= sizeof(*pack));   \
	if(pack->totalLen < sizeof(*pack))  \
	{   \
	gxError("Packet is less!");  \
	}   \
	CWorldPlayer* player = getWorldPlayer();    \
	if(NULL == player)  \
	{   \
	gxError("Can't find player!");   \
	if(!isInvalid())    \
		{   \
		retp ret;   \
		ret.setRetCode(RC_FAILED);   \
		sendPacket(ret);    \
		}   \
		return GXMISC::HANDLE_RET_OK;   \
	}   \
	gxAssert(player->getSocketIndex() == getSocketIndex());


void CWorldPlayerHandler::Setup() {
	

	RegisteHandler(PACKET_CW_LOGIN_GAME, (TPacketHandler) &CWorldPlayerHandler::handleLoginGame);
	RegisteHandler(PACKET_CW_LOGIN_QUIT, (TPacketHandler) &CWorldPlayerHandler::handleLoginQuit);
	RegisteHandler(PACKET_CW_CREATE_ROLE, (TPacketHandler)&CWorldPlayerHandler::handleCreateRole);
	RegisteHandler(PACKET_CW_RAND_ROLE_NAME, (TPacketHandler)&CWorldPlayerHandler::handleRandRoleName);
	RegisteHandler(PACKET_CW_VERIFY_CONNECT, (TPacketHandler) &CWorldPlayerHandler::handleVerifyConnect);
}

void CWorldPlayerHandler::Unsetup() {
}

bool CWorldPlayerHandler::start() {
	setIgnore();

	CWorldDbHandler* dbHandler = g_WorldDbMgr->addUser<CWorldDbHandler>(DB_GAME);
	if (NULL == dbHandler) {
		gxError("Can't add db handler!SocketIndex={0}", getSocketIndex());
		return false;
	}
//	gxDebug("DbHandle num ={0}", g_WorldDbMgr->getUserNum());

	dbHandler->setSocketMgr(DWorldNetMgr);
	dbHandler->setSocketIndex(getSocketIndex());
	setDbIndex(dbHandler->getUniqueIndex());
	
	return true;
}

CWorldDbHandler* CWorldPlayerHandler::getDbHandler() {
	return dynamic_cast<CWorldDbHandler*>(DWorldDbMgr->getUser(_dbUniqueIndex));
}

void CWorldPlayerHandler::close()
{
	gxWarning("CWorldPlayerHandler close!{0}", toString());

	if(closePlayer())
	{
		return;
	}

	if(closeLoginPlayer())
	{
		return;
	}

	closeDbHandler();
	clean();
}

const char* CWorldPlayerHandler::toString() {
	return _strName.c_str();
}

GXMISC::TUniqueIndex_t CWorldPlayerHandler::getDbIndex() {
	return _dbUniqueIndex;
}

TAccountID_t CWorldPlayerHandler::getAccountID() {
	return _accountID;
}

void CWorldPlayerHandler::setDbIndex(GXMISC::TUniqueIndex_t index) {
	_dbUniqueIndex = index;
	_strName =
		GXMISC::gxToString(
		"SocketIndex = %"I64_FMT"u, DbUnqiueIndex = %"I64_FMT"u, AccountID = %"I64_FMT"u",
		getSocketIndex(), getDbIndex(), getAccountID());
}

void CWorldPlayerHandler::setAccountID(TAccountID_t accountID) {
	_accountID = accountID;
	_strName =
		GXMISC::gxToString(
		"SocketIndex = %"I64_FMT"u, DbUnqiueIndex = %"I64_FMT"u, AccountID = %"I64_FMT"u",
		getSocketIndex(), getDbIndex(), getAccountID());
}

void CWorldPlayerHandler::quit() 
{
	clean();
	kick();
}

CWorldPlayer* CWorldPlayerHandler::getWorldPlayer() {
	CWorldPlayer* player = DWorldPlayerMgr.findInEnterBySocketIndex(getSocketIndex());
	if (NULL == player) {
		gxWarning("Cant't find player! {0}", toString());
		return NULL;
	}

	gxAssert(player->getAccountID() == getAccountID());
	if (player->getAccountID() != getAccountID()) {
		CWorldPlayer* accountPlayer = DWorldPlayerMgr.findByAccountID(getAccountID());
		if (NULL != accountPlayer) {
			gxError("Can't find player! SrcPlayer: {0}, DestPlayer: {1};", player->toString(), accountPlayer->toString());
		} else {
			gxError( "Can't find player! SrcPlayer: {0}, DestAccount={1}", player->toString(), getAccountID());
		}

		return NULL;
	}

	return player;
}

void CWorldPlayerHandler::clean() 
{
	CWorldDbHandler* pDbHandler = getDbHandler();
	if(NULL != pDbHandler)
	{
		pDbHandler->quit();
	}
}

bool CWorldPlayerHandler::closeDbHandler() {
	gxInfo("Close db handler!{0}", toString());
	CWorldDbHandler* dbHandler = getDbHandler();
	if (dbHandler != NULL) {
		dbHandler->quit();
		_dbUniqueIndex = GXMISC::INVALID_DB_INDEX;
		return true;
	}
	return false;
}

bool CWorldPlayerHandler::closeLoginPlayer()
{
	CLoginPlayer* loginPlayer = DLoginPlayerMgr.findBySocketIndex(getSocketIndex());
	if(NULL == loginPlayer)
	{
		gxWarning("Can't find login player!{0}", toString());
		return false;
	}

	loginPlayer->quit();
	return true;
}

bool CWorldPlayerHandler::closePlayer()
{
	CWorldPlayer* player = DWorldPlayerMgr.findInEnterByAccountID(getAccountID());
	if (!player) 
	{
		gxWarning("Can't find player!{0}", toString());
		return false;
	}

	// 清理
	player->quitBySocketClose();
	return true;
}

void CWorldPlayerHandler::breath( GXMISC::TDiffTime_t diff )
{
	CGameSocketHandler<CWorldPlayerHandler>::breath(diff);
}

bool CWorldPlayerHandler::onBeforeHandlePacket( CBasePacket* packet )
{
	if(!CGameExtendSocketHandler<CWorldPlayerHandler>::onBeforeHandlePacket(packet))
	{
		gxError("On before handle packet failed, quit game!{0}", toString());
		if(closePlayer())
		{
			return false;
		}

		if(closeLoginPlayer())
		{
			return false;
		}

		closeDbHandler();
		clean();

		return false;
	}

	return true;
}

GXMISC::EHandleRet CWorldPlayerHandler::handleLoginGame( CWLoginGame* packet )
{
	FUNC_BEGIN(WORLD_PALYER_HANDLER_MOD);

	gxInfo("Handle login game!{0}", toString());

	PacketCheckAndRet(packet, WCLoginGameRet);

	TRoleUID_t roleUID = player->getFirstRoleUID();
	if(roleUID != INVALID_ROLE_UID)
	{
		player->loginGameReq(roleUID, false);
	}else{
		player->quit(true, GXMISC::gxToString("Request login invalid role!RoleUID={0}", roleUID).c_str());
	}

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldPlayerHandler::handleLoginQuit( CWLoginQuit* packet )
{
	FUNC_BEGIN(WORLD_PALYER_HANDLER_MOD);

	gxInfo("Handle login quit!{0}", toString());

	PacketCheckAndRet(packet, WCLoginQuitRet);

	player->loginQuitReq();

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldPlayerHandler::handleVerifyConnect( CWVerifyConnect* packet )
{
	FUNC_BEGIN(LOGIN_MOD);

	gxInfo("Verify player connect!LoginKey={0},SocketIndex={1},PrevMsg={2}", packet->loginKey, getSocketIndex(), packet->prevMsg.toString());
	EServerStatus serverStatus = g_WorldServer->getServerStatus();
	TScriptStrMap params = DWorldScriptEngine.call("ParsePlayerData", TScriptStrMap(), packet->prevMsg.toString());

	if ( serverStatus == URGENT_CLOSE_SERVER_STATUS || serverStatus == KICK_ROLE_SERVER_SATATUS || serverStatus == REAL_CLOSE_SERVER_STATUS )
	{
		gxInfo("Server is close status, can't verify connect!LoginKey={0}", packet->loginKey);
		WCVerifyConnectRet ret;
		ret.setRetCode(RC_LOGIN_SERVER_CLOSE);
		ret.roleUID = INVALID_ROLE_UID;
		sendPacket(ret);
		return GXMISC::HANDLE_RET_OK;
	}
	CWorldPlayer* player = DWorldPlayerMgr.findInEnterBySocketIndex(getSocketIndex());
	if (NULL != player) {
		if (player->isVerifyPass()) {
			gxInfo("Player is verify pass, direct login verify!!LoginKey={0},SocketIndex={1}", packet->loginKey, getSocketIndex());
			player->doLoginVerify();
		} else {
			gxWarning("Player has send verify!!LoginKey={0},SocketIndex={1}", packet->loginKey, getSocketIndex());
			WCVerifyConnectRet ret;
			ret.setRetCode(RC_FAILED);
			ret.roleUID = INVALID_ROLE_UID;
			sendPacket(ret);
		}
	} else {
		WCVerifyConnectRet ret;
		ret.setRetCode(RC_FAILED);
		ret.roleUID = INVALID_ROLE_UID;
		CWorldDbHandler* dbHandler = getDbHandler();
		if (dbHandler) {
			TGmPower_t gmPower = 0;
			GXMISC::gxFromString(params["GMPower"], gmPower);
			if (false == dbHandler->sendVerifyConnectTask(packet->loginKey, params["sourceWay"], params["chiSourceWay"], gmPower)) {
				sendPacket(ret);
			}
		} else {
			gxWarning("Can't find db handler!!LoginKey={0},SocketIndex={1}", packet->loginKey, getSocketIndex());
			sendPacket(ret);
		}
	}

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldPlayerHandler::handleRandRoleName( CWRandGenName* packet )
{
	FUNC_BEGIN(LOGIN_MOD);

	gxInfo("Random role name!{0}", toString());

	PacketCheckAndRet(packet, WCRandGenNameRet);

	WCRandGenNameRet randName;
	randName.setRetCode(RC_SUCCESS);
	randName.name = DRandRoleMgr.randRoleName(packet->sex);
	sendPacket(randName);

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldPlayerHandler::handleCreateRole( CWCreateRole* packet )
{
	FUNC_BEGIN(LOGIN_MOD);

	gxInfo("Handle create role!{0}", toString());

	PacketCheckAndRet(packet, WCCreateRoleRet);
	WCCreateRoleRet ret;
	ret.setRetCode(RC_FAILED);

	if (!packet->isValid()) {
		gxWarning("Packet is invalid!{0}", toString());
		sendPacket(ret);
		return GXMISC::HANDLE_RET_OK;
	}

	CNewRoleTbl* pNewRole = DNewRoleTblMgr.find(packet->rolePrototypeID);
	if(NULL == pNewRole)
	{
		sendPacket(ret);
		return GXMISC::HANDLE_RET_OK;
	}
	player->createRoleReq(packet->roleName, packet->rolePrototypeID);

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

