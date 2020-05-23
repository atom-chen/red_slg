#include "world_login_player_mgr.h"
#include "world_server_util.h"
#include "world_player.h"
#include "world_player_mgr.h"
#include "world_player_handler.h"
#include "world_db_handler.h"
#include "game_config.h"

void CLoginPlayer::doLoginOutTime(GXMISC::TGameTime_t curTime) {
	if(isTimeOut(curTime))
	{
		gxWarning("Login player login outtime!{0}", toString());
		setDelete();
	}
}

void CLoginPlayer::setAccountID(TAccountID_t accoutID) {
	_accountID = accoutID;
	genStrName();
}

void CLoginPlayer::setSocketIndex(GXMISC::TSocketIndex_t index) {
	_socketIndex = index;
	genStrName();
}

void CLoginPlayer::waitLogin(GXMISC::TSocketIndex_t index, TAccountID_t accountID,
	TLoginRoleArray& roleList, GXMISC::TDbIndex_t dbIndex) {
		setSocketIndex(index);
		setAccountID(accountID);
		setLoginRoleList(roleList);
		setDbIndex(dbIndex);
		_loginTime = DTimeManager.nowSysTime();
}

void CLoginPlayer::setLoginRoleList(TLoginRoleArray& roleList) {
	_roleList = roleList;
}

CWorldPlayerHandler* CLoginPlayer::getWorldPlayerHandler() {
	CWorldPlayerHandler* player =
		dynamic_cast<CWorldPlayerHandler*>(DWorldNetMgr->getSocketHandler(
		getSocketIndex()));
	if (NULL == player) {
		gxWarning("Can't find socket handler!{0}", toString());
		return NULL;
	}

	return player;
}

CWorldDbHandler* CLoginPlayer::getWorldDbHandler() {
	CWorldDbHandler* dbHandler =
		dynamic_cast<CWorldDbHandler*>(DWorldDbMgr->getUser(getDbIndex()));
	if (NULL == dbHandler) {
		gxWarning("Can't find db handler!{0}", toString());
		return NULL;
	}

	return dbHandler;
}

void CLoginPlayer::kickByOtherPlayer() {
	gxInfo("Kick by other player!{0}", toString());
	quit();
}

void CLoginPlayer::otherPlayerOffline() {
	gxInfo("Other player off line, login player enter! {0}", toString());

	WCVerifyConnectRet verifyAccountRet;
	CWorldPlayer* player = NULL;
	CWorldPlayerHandler* socketHandler = NULL;
	CWorldDbHandler* dbHandler = NULL;

	dbHandler = getWorldDbHandler();
	if (NULL == dbHandler) {
		verifyAccountRet.setRetCode(RC_FAILED);
		goto Exit0;
	}
	socketHandler = getWorldPlayerHandler();
	if (NULL == socketHandler) {
		verifyAccountRet.setRetCode(RC_FAILED);
		goto Exit0;
	}

	player = DWorldPlayerMgr.addNewPlayer(_accountID, _socketIndex);
	if (NULL == player) {
		gxError("CLoginPlayer: Can't add new player! {0}", toString());
		verifyAccountRet.setRetCode(RC_FAILED);
		goto Exit0;
	}

	dbHandler->setAccountID(getAccountID());
	player->setDbIndex(getDbIndex());
	player->setAccountID(getAccountID());
	player->setSocketIndex(getSocketIndex());
	player->setLoginKey(_loginKey);
	player->setSourceWay(getSourceWay(), getChisourceWay());
	player->setGmPower(getGmPower());
	socketHandler->setAccountID(getAccountID());
	socketHandler->setDbIndex(getDbIndex());
	// 处理角色列表
	for (sint32 i = 0; i < _roleList.size(); ++i) {
		player->addRole(&_roleList[i]);
	}

	if (false == DWorldPlayerMgr.addToEnter(player)) {
		gxError("CLoginPlayer: Add player to enter queue faild! {0}", toString());
		DWorldPlayerMgr.freeNewPlayer(player);
		verifyAccountRet.setRetCode(RC_FAILED);
		goto Exit0;
	}

	player->loginSuccess();
	verifyAccountRet.setRetCode(RC_SUCCESS);

	gxInfo("Login player enter game success! {0}", toString());

Exit0:
	if (NULL != socketHandler && !IsSuccess(verifyAccountRet.getRetCode())) {
		socketHandler->sendPacket(verifyAccountRet);
	}

	if (!IsSuccess(verifyAccountRet.getRetCode())) {
		quit();
		return;
	}

	DLoginPlayerMgr.delPlayerByAccountID(getAccountID());
}

void CLoginPlayer::quit() 
{
	gxInfo("Login player quit!{0}", toString());
	CWorldPlayerHandler* playerHandler =
		dynamic_cast<CWorldPlayerHandler*>(DWorldNetMgr->getSocketHandler(
		getSocketIndex()));
	if (NULL != playerHandler) {
		playerHandler->quit();
	}

	CWorldDbHandler* dbHandler =
		dynamic_cast<CWorldDbHandler*>(DWorldDbMgr->getUser(getDbIndex()));
	if (NULL != dbHandler) {
		dbHandler->quit();
	}

	DLoginPlayerMgr.delPlayerByAccountID(getAccountID());
}

void CLoginPlayer::setDbIndex(GXMISC::TDbIndex_t dbIndex) {
	_dbIndex = dbIndex;
	genStrName();
}

CLoginPlayer::CLoginPlayer()
{
	_isNeedDelete = false;
	_isNeedReLogin = false;
	_lastReloginTime = 0;
	_loginTime = 0;
	_quickLoginFlag = false;
	_sourceWay.clear();
	_chisourceWay.clear();
	_gmPower = 0;
}

CLoginPlayer::~CLoginPlayer()
{

}

void CLoginPlayer::setNeedReLogin(bool flag)
{
	_isNeedReLogin = flag;
	if(flag)
	{
		_lastReloginTime = DTimeManager.nowSysTime();
	}
	else
	{
		_lastReloginTime = GXMISC::MAX_GAME_TIME;
	}
}

void CLoginPlayer::doReLogin(GXMISC::TGameTime_t currTime)
{
	// 	if((currTime-_lastReloginTime)>MAX_LOGIN_PLAYER_WAIT_RELOGIN_SEC)
	// 	{
	// 		CWorldPlayer* player = getWorldPlayer();
	// 		if(NULL == player)
	// 		{
	// 			otherPlayerOffline();
	// 			setNeedReLogin(false);
	// 			return;
	// 		}
	// 
	// 		if(!player->isLoadRoleDataReq())
	// 		{
	// 			setNeedReLogin(false);
	// 			player->quit(false);
	// 			return;
	// 		}
	// 	}
}

CWorldPlayer* CLoginPlayer::getWorldPlayer(bool logFlag /*= true*/)
{
	CWorldPlayer* player = DWorldPlayerMgr.findByAccountID(getAccountID());
	if(NULL == player && logFlag)
	{
		gxWarning("Can't find player!{0}", toString());
		return NULL;
	}

	return player;
}

void CLoginPlayer::update( GXMISC::TDiffTime_t diff )
{
	doReLogin(DTimeManager.nowSysTime());
	doLoginOutTime(DTimeManager.nowSysTime());
}

bool CLoginPlayer::isTimeOut( GXMISC::TGameTime_t curTime )
{
	return (curTime-_loginTime) > MAX_LOGIN_PLAYER_WAIT_SEC*100 && !getLoginQuick();
}

bool CLoginPlayer::getLoginQuick()
{
	return _quickLoginFlag;
}

void CLoginPlayer::setLoginQuick( bool flag )
{
	_quickLoginFlag = flag;
}

void CLoginPlayer::setLoginKey( TLoginKey_t loginKey )
{
	_loginKey = loginKey;
}

void CLoginPlayer::setSourceWay( TSourceWayID_t sourceWay, TSourceWayID_t chisourceWay )
{
	this->_sourceWay = sourceWay;
	this->_chisourceWay = chisourceWay;
}

bool CLoginPlayerMgr::isExistBySocketIndex(GXMISC::TSocketIndex_t index) {
	return TBaseType::InvalidValue != findBySocketIndex(index);
}

bool CLoginPlayerMgr::isExistByAccountID(TAccountID_t id) {
	return TBaseType::InvalidValue != findByAccountID(id);
}

CLoginPlayerMgr::TBaseType::ValueType CLoginPlayerMgr::findBySocketIndex(
	GXMISC::TSocketIndex_t index) {
		return find(index);
}

CLoginPlayerMgr::TBaseType::ValueType CLoginPlayerMgr::findByAccountID(
	TAccountID_t id) {
		return find2(id);
}

CLoginPlayerMgr::TBaseType::ValueType CLoginPlayerMgr::addPlayer(
	GXMISC::TSocketIndex_t index, TAccountID_t accountID, TLoginRoleArray& roleList,
	GXMISC::TDbIndex_t dbIndex) {
		gxAssert(index != GXMISC::INVALID_SOCKET_INDEX);
		gxAssert(accountID != INVALID_ACCOUNT_ID);

		if (GXMISC::INVALID_SOCKET_INDEX == index) {
			gxError("SocketIndex is invalid!SocketIndex = {0}", GXMISC::gxToString(index));
			return TBaseType::InvalidValue;
		}
		if (INVALID_ACCOUNT_ID == accountID) {
			gxError("AccountID is invalid!AccountID = {0}", GXMISC::gxToString(accountID));
			return TBaseType::InvalidValue;
		}

		gxInfo("Add login player! SocketIndex={0}, AccountID={1}", GXMISC::gxToString(index), GXMISC::gxToString(accountID));
		TBaseType::ValueType player = _objPool.newObj();
		if (NULL == player) {
			gxError( "Can't new CLoginPlayer! SocketIndex={0}, AccountID={1}", GXMISC::gxToString(index), GXMISC::gxToString(accountID));
			return TBaseType::InvalidValue;
		}

		player->waitLogin(index, accountID, roleList, dbIndex);
		if (false == add(player)) {
			gxError("Can't add CLoginPlayer! {0}", player->toString());
			freePlayer(player);
			return TBaseType::InvalidValue;
		}

		return player;
}

void CLoginPlayerMgr::freePlayer(TBaseType::ValueType val) {
	gxAssert(!isExist1(val->getKey()));
	_objPool.deleteObj(val);
}

void CLoginPlayerMgr::delPlayerBySocketIndex(GXMISC::TSocketIndex_t index) {
	gxAssert(isExist1(index));
	if (isExist1(index)) {
		TBaseType::ValueType val = remove(index);
		if (NULL == val) {
			gxError("Can't remove player! SocketIndex = {0}", index);
			return;
		}

		_objPool.deleteObj(val);
	}
}

void CLoginPlayerMgr::delPlayerByAccountID(TAccountID_t id) {
	gxAssert(isExist2(id));
	if (isExist2(id)) {
		TBaseType::ValueType val = remove2(id);
		if (NULL == val) {
			gxError("Can't remove player! AccountID = {0}", id);
			return;
		}

		_objPool.deleteObj(val);
	}
}

void CLoginPlayerMgr::update(GXMISC::TDiffTime_t diff)
{
	std::vector<CLoginPlayer*> delAry;
	std::vector<CLoginPlayer*> loginQuickAry;

	for (TBaseType::Iterator iter = begin(); iter != end(); ++iter)
	{
		CLoginPlayer* player = iter->second;
		gxAssert(NULL != player);
		if (NULL == player)
		{
			gxError("Player is NULL!");
			continue;
		}

		player->update(diff);

		if (player->isNeedDelete())
		{
			delAry.push_back(player);
			continue;
		}

		if((loginQuickAry.size() <= 0) && player->getLoginQuick() && (g_GameConfig.loginPlayerNum > (uint32)_loginPlayerNum))
		{
			loginQuickAry.push_back(player);
		}
	}

	for (uint32 i = 0; i < delAry.size(); ++i) 
	{
		CLoginPlayer* player = delAry[i];
		if (NULL != player) {
			player->quit();
		}
	}

	for(uint32 i = 0; i < loginQuickAry.size(); ++i)
	{	
		CLoginPlayer* player = loginQuickAry[i];
		if(NULL != player)
		{
			_loginPlayerNum++;
			player->otherPlayerOffline();
		}
	}

	if((DTimeManager.nowSysTime()-_lastHandleLoginPlayerTime)>g_GameConfig.loginPlayerInterval)
	{
		_lastHandleLoginPlayerTime = DTimeManager.nowSysTime();
		_loginPlayerNum = 0;
	}
}

bool CLoginPlayerMgr::init(uint32 num)
{
	return _objPool.init(num);
}