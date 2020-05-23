#include "login_status.h"

CTimeWaiter::CTimeWaiter()
{
	cleanup();
	_startTime = DTimeManager.nowSysTime();
}

CTimeWaiter::~CTimeWaiter()
{
	cleanup();
}

void CTimeWaiter::update( GXMISC::TDiffTime_t diff )
{
}

bool CTimeWaiter::isTimeout()
{
	GXMISC::TGameTime_t curTime = DTimeManager.nowSysTime();
	if(curTime > (_startTime+_waitTime))
	{
		return true;
	}

	return false;
}

void CTimeWaiter::cleanup()
{
	_startTime = GXMISC::INVALID_GAME_TIME;
	_waitTime = GXMISC::MAX_GAME_TIME;
}


CLoginWaiter::CLoginWaiter()
{
	cleanup();
}

CLoginWaiter::~CLoginWaiter()
{
	cleanup();
}

void CLoginWaiter::cleanup()
{
//	CTimeWaiter::cleanup();

	_loadType = LOAD_ROLE_TYPE_INVALID;
	_socketIndex = GXMISC::INVALID_SOCKET_INDEX;
}

CLogoutWaiter::CLogoutWaiter()
{
	cleanup();
}

CLogoutWaiter::~CLogoutWaiter()
{
	cleanup();
}

void CLogoutWaiter::cleanup()
{
//	CTimeWaiter::cleanup();

	_unloadType = UNLOAD_ROLE_TYPE_INVALID;
	_needRet = false;
	_socketIndex = GXMISC::INVALID_SOCKET_INDEX;
}

void CLoginWaiterManager::push( ELoadRoleType loadType, GXMISC::TSocketIndex_t index )
{
	_loginWaiters.resize(_loginWaiters.size()+1);
	CLoginWaiter& loginWaiter = _loginWaiters.back();
	loginWaiter.setLoadType(loadType);
	loginWaiter.setSocketIndex(index);
}

void CLoginWaiterManager::push( EUnloadRoleType unLoadType, bool needRet, GXMISC::TSocketIndex_t index )
{
	_logoutWaiters.resize(_logoutWaiters.size()+1);
	CLogoutWaiter& logoutWaiter = _logoutWaiters.back();
	logoutWaiter.setUnloadType(unLoadType);
	logoutWaiter.setNeedRet(needRet);
	logoutWaiter.setSocketIndex(index);
}

bool CLoginWaiterManager::isLogin()
{
	return !_loginWaiters.empty();
}

bool CLoginWaiterManager::isLogout()
{
	return !_logoutWaiters.empty();
}

void CLoginWaiterManager::onLogin( ELoadRoleType loadType, GXMISC::TSocketIndex_t index )
{
	_loginWaiters.clear();
}

void CLoginWaiterManager::onLogout( EUnloadRoleType unLoadType, GXMISC::TSocketIndex_t index )
{
}
