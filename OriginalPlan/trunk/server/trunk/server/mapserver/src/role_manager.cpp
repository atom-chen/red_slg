#include "core/game_exception.h"

#include "role_manager.h"
#include "module_def.h"
#include "map_db_role_process.h"
#include "server_define.h"
#include "map_server_instance_base.h"
#include "script_engine.h"
#include "map_server_util.h"
#include "map_db_player_handler.h"
#include "db_name_define.h"

CRoleManager::THummanDBPool* CRoleManager::getRoleHummanDBPool()
{
	return &_hummanDBPool;
}

CRole* CRoleManager::newRole( TRoleUID_t roleUID, TObjUID_t objUID, TAccountID_t accountID, bool addToReadyFlag )
{
// @TODO 重新实现
// 	if(_hummanDBPool.empty())
// 	{
// 		return NULL;
// 	}

//	CHumanDBData* pHummanDB = _hummanDBPool.newObj(roleUID);
	CHumanDBData* pHummanDB = new CHumanDBData;
	CRole* pRole = addNewPlayer(roleUID, objUID, accountID, false);
	if(NULL != pRole)
	{
		pRole->setHummanDBData(pHummanDB);
	}
	if (!pRole->initScript(_newRoleScriptFunctionName))
	{
		delPlayer(roleUID);
		delete pHummanDB;
		return NULL;
	}
	if(addToReadyFlag)
	{
		if(false == addToReady(pRole))
		{
			gxError("Can't get new player object! Key1={0},Key2={1}", roleUID, objUID);
			delPlayer(roleUID);
			delete pHummanDB;
			return NULL;
		}

		gxDebug("Add player to ReadyQueue!");
	}

	return pRole;
}

void CRoleManager::delRole( TRoleUID_t roleUID )
{
	CRole* pRole = (CRole*)find(roleUID);
	if(NULL != pRole)
	{
		//_hummanDBPool.deleteObj(roleUID);
		CHumanDBData* pHumanDbData = pRole->getHumanDBData();
		DSafeDelete(pHumanDbData);
	}
	delPlayer(roleUID);
}

bool CRoleManager::initRolePool( sint32 num )
{
	init(num);
	//_hummanDBPool.init(num);
	return true;
}

CRoleManager::ValueType CRoleManager::addNewPlayer( CRole::KeyType key1, CRole::KeyType2 key2, CRole::KeyType3 key3, bool isAddToReady /* = false */ )
{
	CRoleManager::ValueType player = _objPool.newObj();
	gxAssert(player != NULL);
	if(player == NULL)
	{
		gxError("Can't get new player object! Key1={0},Key2={1}", key1, key2);
		return NULL;
	}

	player->setKey(key1);
	player->setKey2(key2);
	player->setKey3(key3);
	if(isAddToReady)
	{
		if(false == addToReady(player))
		{
			gxError("Can't get new player object! Key1={0},Key2={1}", key1, key2);
			_objPool.deleteObj(player);
			return NULL;
		}

		gxDebug("Add player to ReadyQueue!");
	}

	return player;
}

void CRoleManager::freeNewPlayer(CRoleManager::ValueType val)
{
	_objPool.deleteObj(val);
}


void CRoleManager::delPlayer( CRole::KeyType key1 )
{
	gxDebug("Delete player from player mgr! Key1={0}", key1);

	DCheckPlayer(key1);

	CRoleManager::ValueType player = (CRoleManager::ValueType)_readyQue.find(key1);
	if(NULL != player)
	{
		gxDebug("Delete player from ready queue! Key1={0}", key1);
		if(NULL == _readyQue.remove(key1))
		{
			gxAssert(false);
		}
	}

	if(NULL == player)
	{
		player = (CRoleManager::ValueType)_enterQue.find(key1);
		if(NULL != player)
		{
			gxDebug("Delete player from enter queue! Key1={0}", key1);
			if(NULL == _enterQue.remove(key1))
			{
				gxAssert(false);
			}
		}
	}

	if(NULL == player)
	{
		player = (CRoleManager::ValueType)_logoutQue.find(key1);
		if(NULL != player)
		{
			gxDebug("Delete player from logout queue! Key1={0}", key1);
			if(NULL == _logoutQue.remove(key1))
			{
				gxAssert(false);
			}
		}
	}

	if(player == NULL)
	{
		gxWarning("Can't delete player! Key1={0}", key1);
		return;
	}

	if(player)
	{
		_objPool.deleteObj(player);
	}
}

sint32 CRoleManager::getSize()
{
	return size();
}

bool CRoleManager::init( sint32 maxPlayerNum )
{
	sint32 seconds = DScriptEngine.call("GetRoleManagerUpdateTime", 0);
	_scriptUpdateTimer.init(seconds*GXMISC::MILL_SECOND_IN_SECOND);
	seconds = DScriptEngine.call("GetRoleManagerRoleHeartTime", 0);
	_roleHeartUpdateTimer.init(seconds*GXMISC::MILL_SECOND_IN_SECOND);

	return _objPool.init(maxPlayerNum);
}

CRoleManager::CRoleManager()
{
	g_RoleManagerBase = this;
}

CRoleManager::~CRoleManager()
{
	g_RoleManagerBase = NULL;
}

static void RoleHeartFunc(CRoleBase*& pRole, void* arg)
{
	MWRoleHeart* heart = (MWRoleHeart*)arg;
	heart->roles.pushBack(pRole->getHeartInfo());
}

void CRoleManager::roleHeart(GXMISC::TDiffTime_t diff)
{
	if(_roleHeartUpdateTimer.update(diff))
	{
		_roleHeartUpdateTimer.reset(true);
		MWRoleHeart heartPacket;

		traverseEnter(&RoleHeartFunc, &heartPacket);
		traverseReady(&RoleHeartFunc, &heartPacket);
		traverseLogout(&RoleHeartFunc, &heartPacket);

		//SendToWorld(heartPacket);
	}
}
void CRoleManager::update( uint32 diff )
{
	TBaseType::update(diff);
	if(_scriptUpdateTimer.update(diff))
	{
		GXMISC::TGameTime_t seconds = (GXMISC::TGameTime_t)_scriptUpdateTimer.getMaxSecs();
		//DScriptEngine.vCall("RoleManagerUpdateTimer", seconds);
		seconds = DScriptEngine.call("GetRoleManagerUpdateTime", 0);
		_scriptUpdateTimer.init(seconds*GXMISC::MILL_SECOND_IN_SECOND);

		gxInfo("readySize={0} enterSize={1} logoutSize={2}", readySize(), enterSize(), logoutSize() );
	}

	roleHeart(diff);
}

EGameRetCode CRoleManager::loadRoleData(TLoadRoleData* loadData, GXMISC::TSocketIndex_t requestSocketIndex, 
	GXMISC::TSocketIndex_t playerSocketIndex, TChangeLineTempData* changeLineTempData, bool isLocalServerLogin)
{
	// 检测角色是否存在
	CRole* pRole = findByAccountID(loadData->accountID);
	if (NULL != pRole)
	{
		gxError("Role has exist!{0}", pRole->toString());
		// @todo 以后做成重登陆
		//         gxWarning("Old role exist! %s", pRole->toString());
		//         if(!pRole->reLogin())
		//         {
		//             gxAssert(false);
		//         }
		//        pRole->getHummanDB()->getUserData(retPacket.userData);
		if (pRole->isLogout() || pRole->isReady())
		{
			pRole->directKick(false, true, false);
		}
		else
		{
			pRole->directKick(true, false, false);
			return RC_LOGIN_OLD_ROLE_EXIST;
		}
	}

	CMapDbPlayerHandler* dbPlayer = DMapDbMgr->addUser<CMapDbPlayerHandler>(DB_GAME);
	if (NULL == dbPlayer)
	{
		gxError("Can't add CMapDbPlayerHandler! {0}", loadData->toString());
		return RC_LOGIN_OLD_ROLE_EXIST;
	}

	dbPlayer->setAccountID(loadData->accountID);
	dbPlayer->setRoleUID(loadData->roleUID);
	dbPlayer->setObjUID(loadData->objUID);
	dbPlayer->setRequestSocketIndex(requestSocketIndex);
	dbPlayer->setLoginPlayerSockIndex(playerSocketIndex);
	if (!dbPlayer->sendLoadDataTask(loadData, changeLineTempData, playerSocketIndex, requestSocketIndex, isLocalServerLogin))
	{
		return RC_LOGIN_OLD_ROLE_EXIST;
	}

	return RC_SUCCESS;
}

EGameRetCode CRoleManager::loadRoleDataRet(TLoadRoleData* loadData, GXMISC::TSocketIndex_t requestSocketIndex, GXMISC::TSocketIndex_t loginPlayerSockIndex,
	TChangeLineTempData* changeLineTempData, GXMISC::TDbIndex_t dbIndex, TRoleManageInfo* roleInfo, CHumanDBBackup* humanDB, bool isAdult, bool isLocalServerLogin, CRole*& pRole)
{
	pRole = NULL;

	// @todo 解决临时bug, 如果角色存在管理器中直接把角色删除了
	if (isExist3(loadData->accountID))
	{
		CRole* oldRole = findByAccountID(loadData->accountID);
		gxAssert(oldRole != NULL);
		// 已经存在角色, 登陆失败
		gxError("Load role data, old role exist!{0}", oldRole->toString());
		oldRole->directKick(true, false, false, KICK_TYPE_BY_OTHER);
		gxAssert(false);
		return RC_LOGIN_OLD_ROLE_EXIST;
	}

	CRole* role = newRole(loadData->roleUID, loadData->objUID, loadData->accountID, true);
	if (NULL == role)
	{
		gxError("Can't add new CRole! {0}", loadData->toString());
		return RC_LOGIN_FAILED;
	}

	role->setLocalServerLogin(isLocalServerLogin);
	role->setDbIndex(dbIndex);
	role->setLoginPlayerSocketIndex(loginPlayerSockIndex);
	if (!role->onLoad(roleInfo, humanDB, loadData, changeLineTempData, isAdult))
	{
		delRole(loadData->roleUID);
		return RC_LOGIN_FAILED;
	}

	pRole = role;

	return RC_SUCCESS;
}

EGameRetCode CRoleManager::unLoadRoleData(TRoleUID_t roleUID, GXMISC::TSocketIndex_t loginPlayerSocketIndex, bool needRet, EUnloadRoleType unloadType)
{
	CRole* role = findByRoleUID(roleUID);
	if (NULL == role)
	{
		if (unloadType != UNLOAD_ROLE_TYPE_SYS_CHECK && needRet)
		{
			gxError("Can't find role! RoleUID={0}, LoginPlayerSocketIndex = {1}, UnloadType={2}", roleUID, loginPlayerSocketIndex, (uint32)unloadType);
			return RC_FAILED;
		}

		return RC_SUCCESS;
	}

	if (role->getLoginPlayerSocketIndex() != loginPlayerSocketIndex && needRet)
	{
		gxError("World player socket index is invalid!{0},{1}", role->toString(), loginPlayerSocketIndex);
		gxAssert(false);
		return RC_FAILED;
	}

	role->onUnloadRole(unloadType, needRet);

	return RC_SUCCESS;
}

void CRoleManager::setNewRoleScriptFunctionName(std::string functionName)
{
	_newRoleScriptFunctionName = functionName;
}

