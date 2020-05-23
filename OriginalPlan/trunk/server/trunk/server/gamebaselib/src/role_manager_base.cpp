#include "core/game_exception.h"

#include "role_manager_base.h"
#include "module_def.h"
#include "server_define.h"
#include "map_server_instance_base.h"

// 每秒不能超过10个保存的角色
// 100/10s|200/30s|500/70s|600/90s|700/120s|800/150s|900/180s|1000/200s|1100/250s|1200/300s|1300/400s|1400/500s|1500/600s|
struct _Int3
{
	uint32 value1;	// 当前人数
	uint32 value2;	// 总共多少秒
	uint32 value3;	// 每秒不能超过的人数
};

static _Int3 RoleNumSaveAry[MAX_ROLE_NUM_SAVE_NUM] =
{
	{100,20,10},
	{200,70,7},
	{500,80,8},
	{600,90,8},
	{700,160,5},
	{800,180,5},
	{900,200,5},
	{1000,220,5},
	{1100,250,5},
	{1200,325,4},
	{1300,400,4},
	{1400,550,3},
	{1500,MAX_ROLE_SAVE_SEC,4}
};

typedef std::list<TRoleUID_t> TDeleteRoleList;
static void PushRole(CRoleBase* &role, void* arg)
{
	TDeleteRoleList* delList = (TDeleteRoleList*)arg;
	if ( delList == NULL || role == NULL )
	{
		return ;
	}
	delList->push_back(role->getRoleUID());
}
static void UpdateRole(CRoleBase*& role, void* arg)
{
	GXMISC::TDiffTime_t diff = *((GXMISC::TDiffTime_t*)arg);
	if(NULL != role)
	{
		role->update(diff);
	}
}
static void UpdateLogoutRole(CRoleBase*& role, void* arg)
{
	TDeleteRoleList* delList = (TDeleteRoleList*)arg;
	if(role->isTimeOutForLogout())
	{
		delList->push_back(role->getRoleUID());
	}
}
static void UpdateReadyRole(CRoleBase*& role, void* arg)
{
	TDeleteRoleList* delList = (TDeleteRoleList*)arg;
	if(role->isTimeOutForReady())
	{
		delList->push_back(role->getRoleUID());
	}
}
void CRoleManagerBase::update(uint32 diff)
{
	FUNC_BEGIN(ROLE_MOD);

	doProfile();
	traverseReady(&UpdateRole, &diff);
	traverseEnter(&UpdateRole, &diff);
	traverseLogout(&UpdateRole, &diff);

	if(_lastUpdateTimeoutRoleTime != DTimeManager.nowSysTime())
	{
		// 每秒执行一次
		TDeleteRoleList delList;
		traverseReady(&UpdateReadyRole, &delList);
		for(TDeleteRoleList::iterator iter = delList.begin(); iter != delList.end(); ++iter)
		{
			CRoleBase* pRole = DRoleMgrBase->findInReady(*iter);
			if(NULL == pRole)
			{
				continue;
			}
			gxError("Ready time to delete role!{0}", pRole->toString());
			pRole->onLoginTimeout();
			//delRole(*iter);
			pRole->addRoleToLogout(0);
		}

		delList.clear();
		traverseLogout(&UpdateLogoutRole, &delList);
		for(TDeleteRoleList::iterator iter = delList.begin(); iter != delList.end(); ++iter)
		{
			CRoleBase* pRole = DRoleMgrBase->findInLogout(*iter);
			if(NULL == pRole)
			{
				continue;
			}
			gxInfo("Logout time to delete role!{0}", pRole->toString());
			pRole->onLogoutTimeout();
			delRole(*iter);
		}
		_lastUpdateTimeoutRoleTime = DTimeManager.nowSysTime();
	}

	rebuildSaveIndex(false);
	FUNC_END(DRET_NULL);
}

static void UpdateTimer(CRoleBase*& role, void* arg)
{
	uint32* timerID = (uint32*)(arg);
	if(NULL != role)
	{
		role->onHourTimer(*timerID);
	}
}

CRoleManagerBase::CRoleManagerBase() : TBaseType()
{
	_lastProfileTime = 0;
	_saveNumIndex = 0;
	for(uint32 i = 0; i < (MAX_ROLE_NUM_SAVE_NUM-1); ++i)
	{
		RoleNumSaveAry[i].value2 = RoleNumSaveAry[i+1].value1/RoleNumSaveAry[i].value3;
		if(RoleNumSaveAry[i+1].value1%RoleNumSaveAry[i].value3 > 0)
		{
			RoleNumSaveAry[i].value2++;
		}
	}

	rebuildSaveIndex(true);
	_lastUpdateTimeoutRoleTime = DTimeManager.nowSysTime();
}

CRoleManagerBase::~CRoleManagerBase()
{

}

void CRoleManagerBase::updateTimer(uint32 timerID)
{
	gxInfo("Update timer!TimeID={0}", timerID);
	traverseEnter(&UpdateTimer, &timerID);
}

void CRoleManagerBase::doProfile()
{
	if(size() <= 0)
	{
		return;
	}

	GXMISC::TGameTime_t curTime = DTimeManager.nowSysTime();
	if(curTime-_lastProfileTime < ROLE_MANAGER_PROFILE_TIME)
	{
		return;
	}

	_lastProfileTime = curTime;
	//gxStatistic("==================RoleMgr:RoleNum={0}, ReadyNum={1},EnterNum={2}==================", size(), readySize(), enterSize());
}

void CRoleManagerBase::rebuildSaveIndex(bool forceFlag)
{
	bool rebuildFlag = false;

	if(_saveNumIndex >= (MAX_ROLE_NUM_SAVE_NUM-1))
	{
		_saveNumIndex = MAX_ROLE_NUM_SAVE_NUM-1;
	}
	if(_saveNumIndex <= 0)
	{
		_saveNumIndex = 0;
	}

	if(forceFlag)
	{
		rebuildFlag = true;
	}
	else if(enterSize() <= 0 && _roleSaveIndexs.empty())
	{
		rebuildFlag = true;
	}
	else if(_saveNumIndex == (MAX_ROLE_NUM_SAVE_NUM-1) && (enterSize() < RoleNumSaveAry[_saveNumIndex].value1))
	{
		rebuildFlag = true;
	}
	else if(_saveNumIndex == 0 && (enterSize() >= RoleNumSaveAry[_saveNumIndex+1].value1))
	{
		rebuildFlag = true;
	}
	else if((_saveNumIndex > 0 && enterSize() < RoleNumSaveAry[_saveNumIndex-1].value1) || (enterSize() > RoleNumSaveAry[_saveNumIndex+1].value1))
	{
		rebuildFlag = true;
	}

	typedef TBaseType::Iterator TEnterIter;
	if(rebuildFlag)
	{
		// 重建索引
		_saveNumIndex = getSaveNumIndex();
		_roleSaveIndexs.clear();
		_roleSaveIndexs.assign(RoleNumSaveAry[_saveNumIndex].value2, 0);
		// 将所有玩家按数据库标记分类, 主要是减轻数据库压力
		typedef std::map<uint8, std::list<CRoleBase*>> TRoleIndexMap;
		std::map<uint8, std::list<CRoleBase*>> roles;
		for(TEnterIter iter = _enterQue.begin(); iter != _enterQue.end(); ++iter)
		{
			CRoleBase* pRole = iter->second;
			roles[pRole->getDbHandlerTag()].push_back(pRole);
		}

		uint32 roleNum = 0;
		typedef std::pair<std::list<CRoleBase*>::iterator, std::list<CRoleBase*>::iterator> TRoleIndexMapPair;
		std::vector<TRoleIndexMapPair> roleMapPair;
		for(std::map<uint8, std::list<CRoleBase*>>::iterator iter = roles.begin(); iter != roles.end(); ++iter)
		{
			roleNum += (uint32)iter->second.size();
			TRoleIndexMapPair mapPair;
			mapPair.first = iter->second.begin();
			mapPair.second = iter->second.end();
			roleMapPair.push_back(mapPair);
		}
		gxAssert(roleNum == _enterQue.size());
		if(roleMapPair.size() > 0)
		{
			TSaveIndex_t index = 0;
			uint32 allocaIndexNum = 0;
			for(uint32 i = 0; allocaIndexNum < roleNum;)
			{
				CRoleBase* pRole = NULL;
				if(roleMapPair[i].first != roleMapPair[i].second)
				{
					pRole = *(roleMapPair[i].first);
					roleMapPair[i].first++;
					pRole->setDbSaveIndex(index%_roleSaveIndexs.size());
					_roleSaveIndexs[index%_roleSaveIndexs.size()]++;
					index++;
					allocaIndexNum++;
					gxAssert(RoleNumSaveAry[_saveNumIndex].value3 >= _roleSaveIndexs[index%_roleSaveIndexs.size()]);
				}
				i = i+1;
				i = (i%roleMapPair.size());
			}
		}
	}
}

TSaveIndex_t CRoleManagerBase::randSaveIndex()
{
	TSaveIndex_t saveIndex = DRandGen.randUInt()%_roleSaveIndexs.size();
	saveIndex |= 0xff0000;
	return saveIndex;
}

void CRoleManagerBase::putSaveIndex( TSaveIndex_t index )
{
	if(index & 0xff0000)
	{
		return;
	}

	index &= 0xffff;
	if(index >= (MAX_ROLE_SAVE_SEC-1))
	{
		return;
	}

	_roleSaveIndexs[index]--;
}

TSaveIndex_t CRoleManagerBase::getSaveIndex()
{
	TSaveIndex_t saveIndex = INVALID_SAVE_INDEX;
	uint8 minNum = 100;
	for(uint32 i = 0; i < _roleSaveIndexs.size(); ++i)
	{
		if(_roleSaveIndexs[i] == 0)
		{
			_roleSaveIndexs[i]++;
			return i;
		}

		if(_roleSaveIndexs[i] < RoleNumSaveAry[_saveNumIndex].value3 && _roleSaveIndexs[i] < minNum )
		{
			saveIndex = i;
			minNum = _roleSaveIndexs[i];
		}
	}

	if(saveIndex != INVALID_SAVE_INDEX)
	{
		_roleSaveIndexs[saveIndex]++;
		return saveIndex;
	}

	return randSaveIndex();
}

uint8 CRoleManagerBase::getSaveNumIndex()
{
	if(enterSize() <= 0)
	{
		return 0;
	}

	uint8 index = 0;
	uint32 roleNum = enterSize();
	for(uint8 i = 0; i < MAX_ROLE_NUM_SAVE_NUM; ++i)
	{
		if(roleNum >= RoleNumSaveAry[i].value1)
		{
			index = i;
		}
	}

	return index;
}

TSaveIndex_t CRoleManagerBase::getSaveSec()
{
	return RoleNumSaveAry[_saveNumIndex].value2;
}

static void UpdateIdle(CRoleBase*& role, void* arg)
{
	role->onIdle();
}
void CRoleManagerBase::updateRoleIdle()
{
	traverseEnter(&UpdateIdle, NULL);
}

void CRoleManagerBase::kickAllRole()
{
	TDeleteRoleList delList;
	traverseReady(&PushRole, &delList);
	for(TDeleteRoleList::iterator iter = delList.begin(); iter != delList.end(); ++iter)
	{
		CRoleBase* pRole = findInReady(*iter);
		if(NULL == pRole)
		{
			continue;
		}
		pRole->directKick(false, true, false, KICK_TYPE_GAME_STOP);
	}

	delList.clear();
	traverseEnter(&PushRole, &delList);
	for(TDeleteRoleList::iterator iter = delList.begin(); iter != delList.end(); ++iter)
	{
		CRoleBase* pRole = findInEnter(*iter);
		if(NULL == pRole)
		{
			continue;
		}
		pRole->directKick(true, true, false, KICK_TYPE_GAME_STOP);
	}
}

bool CRoleManagerBase::renameRole( TRoleUID_t roleUID, const std::string& name )
{
	FUNC_BEGIN(ROLE_MOD);

	CRoleBase* pRole = findByRoleUID(roleUID);
	if(NULL == pRole)
	{
		gxError("Can't rename role name, role off line!RoleUID={0},Name={1}", roleUID, name);
		return false;
	}

	if(!pRole->isEnter()){
		gxError("Can't rename role name, role not in enter!{0},Name={1}", pRole->toString(), name);
		return false;
	}

	remove(roleUID);

	std::string oldName = pRole->getRoleNameStr();
	pRole->setRoleName(name);
	gxInfo("Rename role name!OldName={0},NewName={1},{2}", oldName, name, pRole->toString());
	return addToEnter(pRole);

	FUNC_END(false);
}
