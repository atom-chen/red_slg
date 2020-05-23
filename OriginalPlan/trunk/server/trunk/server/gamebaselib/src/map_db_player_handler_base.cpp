#include "map_server_util.h"
#include "map_server_instance_base.h"
#include "map_db_player_handler_base.h"

CMapDbPlayerHandlerBase::CMapDbPlayerHandlerBase(GXMISC::CDatabaseConnWrap* dbWrap, GXMISC::TUniqueIndex_t index) : CGameDatabaseHandler(dbWrap, index)
{
	_accountID = INVALID_ACCOUNT_ID;
	_roleUID = INVALID_ROLE_UID;
	_objUID = INVALID_OBJ_UID;
	_requestSocketIndex = GXMISC::INVALID_SOCKET_INDEX;
	_loginPlayerSockIndex = GXMISC::INVALID_SOCKET_INDEX;
}

bool CMapDbPlayerHandlerBase::start()
{
	setSocketMgr(DMapNetMgr);
	return true;
}

void CMapDbPlayerHandlerBase::setAccountID( TAccountID_t accountID )
{
	_accountID = accountID;
	genStrName();
}

TAccountID_t CMapDbPlayerHandlerBase::getAccountID()
{
	return _accountID;
}

void CMapDbPlayerHandlerBase::setRoleUID( TRoleUID_t roleUID )
{
	_roleUID = roleUID;
	genStrName();
}

TRoleUID_t CMapDbPlayerHandlerBase::getRoleUID()
{
	return _roleUID;
}

void CMapDbPlayerHandlerBase::setObjUID( TObjUID_t objUID )
{
	_objUID = objUID;
	genStrName();
}

TObjUID_t CMapDbPlayerHandlerBase::getObjUID()
{
	return _objUID;
}

GXMISC::TSocketIndex_t CMapDbPlayerHandlerBase::getRequestSocketIndex()
{
	return _requestSocketIndex;
}

void CMapDbPlayerHandlerBase::setRequestSocketIndex(GXMISC::TSocketIndex_t index)
{
	_requestSocketIndex = index;
	genStrName();
}

void CMapDbPlayerHandlerBase::pushTask( CMapDbRequestTask* task )
{
	task->setRoleUID(getRoleUID());
	TBaseType::pushTask(task);
}

CMapWorldServerHandlerBase* CMapDbPlayerHandlerBase::getWorldServerHandlerBase(bool logFlag /* = true */)
{
	CMapWorldServerHandlerBase* handler = dynamic_cast<CMapWorldServerHandlerBase*>(DMapNetMgr->getSocketHandler(_requestSocketIndex));
	if(NULL == handler && logFlag)
	{
		gxError("Can't find CMapWorldServerHandlerBase! {0}", toString());
		return NULL;
	}

	return handler;
}

void CMapDbPlayerHandlerBase::quit()
{	
	gxInfo("map db handler quit!{0}", toString());
	kick();
}

void CMapDbPlayerHandlerBase::setLoginPlayerSockIndex(GXMISC::TSocketIndex_t index)
{
	_loginPlayerSockIndex = index;
}

GXMISC::TSocketIndex_t CMapDbPlayerHandlerBase::getLoginPlayerSockIndex()
{
	return _loginPlayerSockIndex;
}

CRoleBase* CMapDbPlayerHandlerBase::getRole( bool logFlag )
{
	CRoleBase* pRole = DRoleMgrBase->findByRoleUID(getRoleUID());
	if(NULL == pRole && logFlag)
	{
		gxError("Can't find role!RoleUID={0}", getRoleUID());
		return NULL;
	}

	return pRole;
}