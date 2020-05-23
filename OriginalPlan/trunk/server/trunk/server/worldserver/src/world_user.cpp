#include "core/time_manager.h"
#include "core/game_exception.h"

#include "world_user.h"
#include "world_map_player_mgr.h"
#include "module_def.h"
#include "world_db_server_handler.h"
#include "world_server.h"
#include "world_player_mgr.h"
#include "world_sql_manager.h"
#include "world_all_user.h"


void CWorldUser::setRoleUID(TRoleUID_t roleUID) 
{
	_usrData.roleUID = roleUID;
}

TRoleUID_t CWorldUser::getRoleUID() const 
{
	return _usrData.roleUID;
}

void CWorldUser::setObjUID(TObjUID_t objUID) 
{
	_objUID = objUID;
}

TObjUID_t CWorldUser::getObjUID() const
{
	return _objUID;
}

void CWorldUser::setName(const std::string& name)
{
	_usrData.roleName = name.c_str();
}

const std::string CWorldUser::getName() const 
{
	return _usrData.roleName.toString();
}

void CWorldUser::setUserData(CWorldUserData* data) 
{
	_usrData = *data;
	genStrName();
}

void CWorldUser::setAccountID(TAccountID_t accountID)
{
	_usrData.accountID = accountID;
}

TAccountID_t CWorldUser::getAccountID() const 
{
	return _usrData.accountID;
}

void CWorldUser::setMapServerID(TServerID_t serverID) 
{
	_mapServerID = serverID;
}

TServerID_t CWorldUser::getMapServerID()
{
	return _mapServerID;
}

void CWorldUser::setLevel( const TLevel_t lev )
{
	_usrData.level = lev;
}

TLevel_t CWorldUser::getLevel()
{
	return _usrData.level;
}

void CWorldUser::setSex(const TSex_t sex)
{
	_usrData.sex = sex;
}

TSex_t CWorldUser::getSex()
{
	return _usrData.sex;
}

void CWorldUser::setJob( const TJob_t job )
{
	_usrData.job = job;
}

TJob_t CWorldUser::getJob()
{
	return _usrData.job;
}

void CWorldUser::offLine()
{
	gxInfo("Role offline!!! objUID = {0}, roleName = {1}", _objUID, getName());
	offlineUserData();
	CWorldUserSimpleData* pAllUser = DWorldAllUserMgr.findUser(_objUID);
	if(NULL != pAllUser)
	{
		pAllUser->update(_usrData.level);
	}

//	DCWRecordeManager.handleLogOutUpdateData(this);
}

void CWorldUser::onAfterChangeLine()
{
	// 将数据再重新发送一次到地图服务器(如: 好友关系)
	updateUserData(); // 更新玩家数据
}

void CWorldUser::updateAllUserData()
{
	TLoginRole loginRoleData;
	loginRoleData.level = _usrData.level;
	loginRoleData.roleUID = _usrData.roleUID;
	loginRoleData.objUID = _objUID;
	loginRoleData.name = _usrData.roleName;
	loginRoleData.sceneID = _usrData.sceneID;
	//loginRoleData.protypeID = ; @TODO
	//loginRoleData.pos = ; @TODO
	DWorldAllUserMgr.addUser(&loginRoleData);
}

void CWorldUser::online()
{
	gxInfo("World user online!{0}", toString());
	CWorldDbServerHandler* dbHandler  = GetWorldGameDbHandler();
	if ( dbHandler != NULL )
	{
		dbHandler->sendLoadUserData(getRoleUID());
	}
	CWorldPlayer* pPlayer = getWorldPlayer(true);
	if(NULL != pPlayer)
	{
		CWorldMapPlayer* pWorldMapPlayer = DWorldMapPlayerMgr.findMapPlayer(pPlayer->getMapServerID());
		if(NULL != pWorldMapPlayer)
		{
		}
	}

	updateUserData();

	gxDebug("Role online!!! objUID = {0}, roleName = {1}, isFirstOnline = {2}", _objUID, getName(), (uint32)_isFirstOnline);
}

CWorldMapPlayer* CWorldUser::getMapPlayer()
{
	return DWorldMapPlayerMgr.findMapPlayer(_mapServerID);
}

void CWorldUser::onlineUserData()
{
}

void CWorldUser::offlineUserData()
{
	DSqlConnectionMgr.updateUserData(getRoleUID(), &_dbUserData );
}

void CWorldUser::onUserPassDay()
{
	gxDebug("On user pass day, objUID = {0}", _objUID);
}

void CWorldUser::update( GXMISC::TDiffTime_t diff )
{
	/*
	// 更新时间
	_updateUserDataTimer.update(diff);
	// 处理
	if(_updateUserDataTimer.isPassed())
	{
		_updateUserDataTimer.reset(true);
		updateUserData();
	}
	*/
}

void CWorldUser::updateUserData()
{
	// @todo 更新玩家数据
 	WMUpdateUserData userData;
 	userData.objUID = getObjUID();
	CWorldPlayer* pWorldPlayer = getWorldPlayer(true);
	if(NULL != pWorldPlayer)
	{
 		userData.userData.gmPower = pWorldPlayer->getGmPower();
	}
	sendPacket(userData);
}

void CWorldUser::setRoleUpdateData( TM2WRoleDataUpdate* roleData )
{
	_roleData = *roleData;
	_usrData.level = _roleData.level;
	_mapServerID = _roleData.mapServerID;
}

void CWorldUser::onBeforeChangeLine(TChangeLineTempData* tempData, ESceneType sceneType, TMapID_t mapID )
{
}

void CWorldUser::loadDataFromDB( const TUserDbData* userData )
{
	if ( _isFirstOnline )
	{
		_dbUserData = *userData;
		updateAllUserData();
	}
	updateUserData();
	onlineUserData();
	// @TODO 服务器正在关闭
// 	if ( g_WorldServer != NULL && g_WorldServer->getServerStatus() == READY_CLOSE_SERVER_STATUS && _dbData.closeServerTime != g_WorldServer->getServerCloseTime() )
// 	{
// 		_dbData.closeServerTime = g_WorldServer->getServerCloseTime();
// 		sendCloseServerMail();
// 	}
	_isFirstOnline = false;
	if ( _usrData.offOverDay )
	{
		onUserPassDay();
		_usrData.offOverDay = false;
	}
	_isLoadingData = false;
	gxInfo("Load data from database!!! RoleUID = {0}", _dbUserData.roleUID);
}

CWorldPlayer* CWorldUser::getWorldPlayer(bool flag)
{
	CWorldPlayer* pPlayer = DWorldPlayerMgr.findByAccountID(getAccountID());
	if(NULL == pPlayer && flag)
	{
		gxError("Can't find world player!{0}", toString());
		return NULL;
	}

	return pPlayer;
}

std::tr1::hash<TRoleName_t> CWorldUser::roleNameDef;
