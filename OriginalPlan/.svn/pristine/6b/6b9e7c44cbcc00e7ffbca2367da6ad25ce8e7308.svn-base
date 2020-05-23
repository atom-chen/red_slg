#include "map_db_task_base.h"
#include "map_server_instance_base.h"
#include "role_base.h"

CMapDbResponseTask::CMapDbResponseTask() : GXMISC::CDbConnTask()
{
	roleUID = INVALID_ROLE_UID;
	retCode = RC_FAILED;
	needErrLog = true;
}

void CMapDbResponseTask::doRun()
{
	CRoleBase* role = getRole();
	if(NULL != role)
	{
		doWork(role);
	}
}

void CMapDbResponseTask::setRoleUID( TRoleUID_t roleUID )
{
	this->roleUID = roleUID;
}
TRoleUID_t CMapDbResponseTask::getRoleUID()
{
	return roleUID;
}

CRoleBase* CMapDbResponseTask::getRole()
{
	CRoleBase* role = DRoleMgrBase->findByRoleUID(roleUID);
	if(NULL == role && needErrLog)
	{
		gxError("Cant' find role! {0}", toString());
		return NULL;
	}

	return role;
}

void CMapDbResponseTask::setRetCode( TRetCode_t ret )
{
	retCode = ret;
}

void CMapDbResponseTask::setErrLogFlag( bool errLogFag )
{
	needErrLog = errLogFag;
}

void CMapDbRequestTask::setRoleUID( TRoleUID_t roleUID )
{
	this->roleUID = roleUID;
}

TRoleUID_t CMapDbRequestTask::getRoleUID()
{
	return roleUID;
}

void CMapDbRequestTask::setErrLogFlag( bool errLogFlag )
{
	needErrLog = errLogFlag;
}
