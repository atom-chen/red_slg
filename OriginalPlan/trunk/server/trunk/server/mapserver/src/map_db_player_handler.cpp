#include "core/game_exception.h"

#include "map_db_player_handler.h"
#include "module_def.h"
#include "map_db_task.h"

CMapDbPlayerHandler::CMapDbPlayerHandler(GXMISC::CDatabaseConnWrap* dbWrap, GXMISC::TDbIndex_t index) : TBaseType(dbWrap, index)
{
}

bool CMapDbPlayerHandler::sendLoadDataTask(TLoadRoleData* loadData, TChangeLineTempData* changeLineTempData, GXMISC::TSocketIndex_t worldPlayerSockIndex,
	GXMISC::TSocketIndex_t requestSocketIndex, bool isLocalServerLogin)
{
	CLoadRoleDataTask* task = newDatabaseTask<CLoadRoleDataTask>();
	if(NULL == task)
	{
		gxError("Can't new CLoadRoleDataTask! {0}", toString());
		return false;
	}

	task->isLocalServerLogin = isLocalServerLogin;
	task->loadData = *loadData;
	task->changeLineTempData = *changeLineTempData;
	task->worldPlayerSockIndex = worldPlayerSockIndex;
	task->requestSocketIndex = requestSocketIndex;
	task->isLocalServerLogin = isLocalServerLogin;
	task->setPriority(1);

	gxInfo("Send load data task! {0}", toString());
	task->pushToQueue();

	return true;
}

bool CMapDbPlayerHandler::sendSaveRoleData( CHumanDB* data, GXMISC::TSocketIndex_t worldPlayerSockIndex, bool needRet, ESaveRoleType saveType )
{
	data->baseLoad._data->setLogoutTime(DTimeManager.nowSysTime());
	CSaveRoleDataTask* task = newDatabaseTask<CSaveRoleDataTask>();
	if(NULL == task)
	{
		gxError("Can't new CSaveRoleDataTask! {1}", toString());
		return false;
	}

	task->humanDB.initHumanData(data);
	task->worldPlayerSockIndex = worldPlayerSockIndex;
	task->needRet = needRet;
	task->humanDB.setSaveDataType(saveType);
	task->setPriority(1);

	gxInfo("Send save role data task! {0}", toString());
	pushTask(task);

	return true;
}

void CMapDbPlayerHandler::sendUpdateRoleData( CHumanDB* data, ESaveRoleType saveType )
{
	FUNC_BEGIN(ROLE_DB_MOD);

	data->getBaseData()->setLogoutTime(DTimeManager.nowSysTime());
	CUpdateRoleDataTimerTask* task = newDatabaseTask<CUpdateRoleDataTimerTask>();
	if(NULL == task)
	{
		gxError("Can't new CUpdateRoleDataTask! {0}", toString());
		return;
	}

	task->humanDB.initHumanData(data);
	task->humanDB.setSaveDataType(saveType);
	pushTask(task);

	FUNC_END(DRET_NULL);
}
