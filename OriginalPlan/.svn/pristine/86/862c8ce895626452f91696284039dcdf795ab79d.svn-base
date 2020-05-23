#include "world_map_player.h"
#include "world_server_util.h"
#include "packet_mw_trans.h"
#include "world_map_server_handler.h"
#include "world_player.h"
#include "scene_manager.h"

TServerID_t CWorldMapPlayer::getServerID() {
	return _serverID;
}

sint32 CWorldMapPlayer::getRoleNum() 
{
	return (sint32)_roleMap.size();
}

bool CWorldMapPlayer::isMaxNum()
{
	return getRoleNum() >= _data.maxRoleNum;
}

void CWorldMapPlayer::setServerID(TServerID_t serverID) {
	_serverID = serverID;
	genStrName();
}

CWorldMapPlayer::CWorldMapPlayer() 
{
	_serverID = INVALID_SERVER_ID;
	_socketIndex = GXMISC::INVALID_SOCKET_INDEX;
}

void CWorldMapPlayer::setSocketIndex(GXMISC::TSocketIndex_t socketIndex) {
	_socketIndex = socketIndex;
	genStrName();
}

GXMISC::TSocketIndex_t CWorldMapPlayer::getSocketIndex() {
	return _socketIndex;
}

bool CWorldMapPlayer::sendUnloadRoleData() {
	return true;
}

CWorldMapServerHandler* CWorldMapPlayer::getMapServerHandler() {
	CWorldMapServerHandler* player =
		dynamic_cast<CWorldMapServerHandler*>(DWorldNetMgr->getSocketHandler(
		getSocketIndex()));
	if (NULL == player) {
		gxError("Can't find CWorldMapServerHandler! {0}", toString());
		return NULL;
	}

	return player;
}

const char* CWorldMapPlayer::toString() 
{
	return _strName.c_str();
}

void CWorldMapPlayer::genStrName() 
{
	_strName = GXMISC::gxToString("SocketIndex=%"I64_FMT"u,ServerID=%u,RoleNum=%u,URoleNum=%u;",
		getSocketIndex(), getServerID(), _roleMap.size(), _data.roleNums);
}

void CWorldMapPlayer::setClientListenIP(const std::string& ip) {
	_clientListenIP = ip;
}

const char* CWorldMapPlayer::getClientListenIP() const {
	return _clientListenIP.c_str();
}

void CWorldMapPlayer::setClientListenPort(GXMISC::TPort_t port) {
	_clientListenPort = port;
}

GXMISC::TPort_t CWorldMapPlayer::getClientListenPort() {
	return _clientListenPort;
}

EServerType CWorldMapPlayer::getServerType()
{
	return _serverType;
}

void CWorldMapPlayer::setServerType( EServerType serverType )
{
	_serverType = serverType;
}

bool CWorldMapPlayer::enter( CScene* pScene, TSceneID_t sceneID, CWorldPlayer* player )
{
	// 发送进入场景
	if(NULL != pScene)
	{
		gxAssert(pScene->getMapServerID() == getServerID());
		if(pScene->getMapServerID() != getServerID())
		{
			gxError("Can't enter scene, map server id is not equal!{0}", player->toString());
			return false;
		}
	}
	gxInfo("Player enter scene!{0}", player->toString());
	player->onBeforeLogin(getServerID());
	gxAssert(_roleMap.find(player->getCurrentRoleUID()) == _roleMap.end());
	_roleMap[player->getCurrentRoleUID()] = sceneID;
	return true;
}

void CWorldMapPlayer::leave(  CWorldPlayer* player )
{
	if(_roleMap.find(player->getCurrentRoleUID()) == _roleMap.end())
	{
		gxError("Role leave map server, can't find role!{0},{1}", player->toString(), toString());
		gxAssert(false);
		return;
	}

	gxInfo("Player map server!{0},{1}", player->toString(), toString());
	player->onAfterLogin(INVALID_SERVER_ID);
	gxAssert(_roleMap.find(player->getCurrentRoleUID()) != _roleMap.end());
	_roleMap.erase(player->getCurrentRoleUID());
}

EGameRetCode CWorldMapPlayer::registe( TSceneAry& scenes, TServerID_t serverID, EServerType serverType, 
	uint32 maxRoleNum, GXMISC::TIPString_t ip, GXMISC::TPort_t port )
{
	setServerID(serverID);
	setClientListenIP(ip.c_str());
	setClientListenPort(port);
	setServerType(serverType);

	_data.scenes = scenes;
	_data.serverID = serverID;
	_data.roleNums = 0;
	_data.maxRoleNum = maxRoleNum;

	// 检测场景是否重复了
	for(TSceneAry::iterator iter = scenes.begin(); iter != scenes.end(); ++iter)
	{
		TSceneData& sceneData = *iter;
		if(DSceneMgr.findScene(sceneData.sceneID))
		{
			gxError("Scene is repeat!SceneID={0}", GXMISC::gxToString(sceneData.sceneID).c_str());
			return RC_REGISTE_MAP_REPEAT;
		}
	}

	// 注册场景
	for(TSceneAry::iterator iter = scenes.begin(); iter != scenes.end(); ++iter)
	{
		TSceneData& sceneData = *iter;
		if(!DSceneMgr.addScene(&sceneData))
		{
			gxError("Scene can't add!SceneID={0}", GXMISC::gxToString(sceneData.sceneID).c_str());
			return RC_REGISTE_MAP_NOT_ADD;
		}
	}

	return RC_SUCCESS;
}

void CWorldMapPlayer::updateData( TMapServerUpdate* data )
{
	_data = *data;
	if(abs((sint32)(_roleMap.size()-_data.roleNums)) > MAX_WORLD_MAPSERVER_ROLE_DIFF_NUM)
	{
		gxWarning("Role is not equal!{0}", toString());
	}

	for(sint32 i = 0; i < _data.scenes.size(); ++i)
	{
		CScene* pScene = DSceneMgr.findScene(_data.scenes[i].sceneID);
		if(NULL != pScene)
		{
			pScene->init(&_data.scenes[i]);
		}
	}
}

void CWorldMapPlayer::getScenes( TSceneAry& scenes )
{
	scenes = _data.scenes;
}

bool CWorldMapPlayer::canEnter()
{
	sint32 curRoleNum = 0;
	if ( (sint32)_roleMap.size() > _data.roleNums )
	{
		curRoleNum = (sint32)_roleMap.size();
	}
	else
	{
		curRoleNum = _data.roleNums;
	}
	if(curRoleNum >= _data.maxRoleNum)
	{
		return false;
	}

	return true;
}

bool CWorldMapPlayer::isNormalServer()
{
	return _serverType == SERVER_TYPE_MAP_NORMAL;
}

bool CWorldMapPlayer::isDynamicServer()
{
	return _serverType == SERVER_TYPE_MAP_DYNAMIC;
}

void CWorldMapPlayer::setRoleSceneID( TRoleUID_t roleUID, TSceneID_t sceneID )
{
	TServerRoleMap::iterator iter = _roleMap.find(roleUID);
	gxAssert(iter != _roleMap.end());
	iter->second = sceneID;
}

TSceneID_t CWorldMapPlayer::getRoleSceneID( TRoleUID_t roleUID ) const
{
	TServerRoleMap::const_iterator itr = _roleMap.find(roleUID);
	if ( itr == _roleMap.end() )
	{
		gxError("Can't find role!!! roleUID = {0}", roleUID);
		gxAssert(false);
		return INVALID_SCENE_ID;
	}
	return itr->second;
}

bool CWorldMapPlayer::isHalfNum()
{
	return getRoleNum() > (_data.maxRoleNum/2);
}
