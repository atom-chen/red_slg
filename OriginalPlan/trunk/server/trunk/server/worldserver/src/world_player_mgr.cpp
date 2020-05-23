#include "world_player_mgr.h"

CWorldPlayerMgr::CWorldPlayerMgr() {
	_genRoleUID = GEN_INIT_ROLE_UID;
	_genTempRoleUID = TEMP_ROLE_INIT_UID;
	_lastProfileTime = 0;
	_genNameID = 0;
}

CWorldPlayerMgr::~CWorldPlayerMgr() {}

void CWorldPlayerMgr::setGenRoleUID(TRoleUID_t roleUID, TObjUID_t objUID, uint32 maxNameID) 
{
	gxAssert(roleUID != INVALID_ROLE_UID);
	_genRoleUID = roleUID;
	_genTempRoleUID = objUID;
	_genNameID = maxNameID;
}

TRoleUID_t CWorldPlayerMgr::genRoleUID() {
	if (_genRoleUID != INVALID_ROLE_UID) {
		return ++_genRoleUID;
	}

	return INVALID_ROLE_UID;
}

TObjUID_t CWorldPlayerMgr::genTempRoleUID() {
	if (_genTempRoleUID != INVALID_TEMP_ROLE_UID)
	{
		return ++_genTempRoleUID;;
	}

	return INVALID_OBJ_UID;
}

void CWorldPlayerMgr::closeByMapServer(TServerID_t mapServerID)
{
	std::vector<CWorldPlayer*> delPlayers;

	for (TBaseType::TBaseType::Iterator iter = _enterQue.begin(); iter != _enterQue.end(); ++iter)
	{
		CWorldPlayer* player = iter->second;
		if (NULL == player) {
			continue;
		}

		if (player->getMapServerID() == mapServerID)
		{
			delPlayers.push_back(player);
		}
	}

	for (uint32 i = 0; i < delPlayers.size(); ++i) 
	{
		delPlayers[i]->quitByMapServerClose();
	}
}

void CWorldPlayerMgr::update(GXMISC::TDiffTime_t diff)
{
	GXMISC::TGameTime_t curTime = DTimeManager.nowSysTime();
	if (curTime - _lastProfileTime > WORLD_PLAYER_MANGER_PROFILE_TIME)
	{
		_lastProfileTime = curTime;
		gxInfo("============Player num:{0}===========", size());
	}

	std::vector<CWorldPlayer*> delPlayers;
	for (TBaseType::TBaseType::Iterator iter = _enterQue.begin(); iter != _enterQue.end(); ++iter)
	{
		CWorldPlayer* player = iter->second;
		if (NULL == player)
		{
			continue;
		}
		player->update(diff);

		if (player->heartOutTime())
		{
			delPlayers.push_back(player);
		}
		
	}

	for (uint32 i = 0; i < delPlayers.size(); ++i) 
	{
		delPlayers[i]->setPlayerStatus(PS_QUIT);
		delPlayers[i]->quit(true, "Heart time out!");
	}
}

TObjUID_t CWorldPlayerMgr::getTempRoleUID()
{
	return _genTempRoleUID;
}

void CWorldPlayerMgr::kickPlayerByAccountID( TAccountID_t accountID )
{
	CWorldPlayer* pWorldPlayer = findByAccountID(accountID);
	if(NULL != pWorldPlayer){
		pWorldPlayer->unloadRoleDataReq(UNLOAD_ROLE_TYPE_GM);
	}
}

TRoleName_t CWorldPlayerMgr::genRoleName()
{
	uint32 nameID = _genNameID;
	_genNameID++;
	return GXMISC::gxToString("GMR%u", nameID);
}
