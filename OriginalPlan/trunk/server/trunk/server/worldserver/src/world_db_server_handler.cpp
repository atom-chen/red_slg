#include "world_db_server_handler.h"
#include "world_db_task.h"
#include "world_server.h"
#include "constant_tbl.h"
#include "world_sql_manager.h"


bool CWorldDbServerHandler::start() 
{
	if (!sendServerInitTask())
	{
		DWorldServer->setStop();
		return false;
	}

	return true;
}

GXMISC::EHandleRet CWorldDbServerHandler::handle(char* msg, uint32 len)
{
	return GXMISC::HANDLE_RET_OK;
}

bool CWorldDbServerHandler::sendGameInitTask() 
{
	CWorldDbGameInitTask* task = newDatabaseTask<CWorldDbGameInitTask>();
	if (NULL == task) {
		gxError("Can't new CWorldDbGameInitTask!");
		return false;
	}
	pushTask(task);

	return true;
}

bool CWorldDbServerHandler::sendServerInitTask() 
{
	CWorldDbServerInitTask* task = newDatabaseTask<CWorldDbServerInitTask>();
	if (NULL == task) {
		gxError("Can't new CWorldDbGameInitTask!");
		return false;
	}
	task->serverID = DWorldServer->getWorldServerID();
	pushTask(task);

	return true;
}


bool CWorldDbServerHandler::sendLoadUserData( TRoleUID_t roleUID )
{
	CWorldLoadUserDataTask* task = newDatabaseTask<CWorldLoadUserDataTask>();
	if (NULL == task)
	{
		gxError("Can't new load user data task!!!");
		return false;
	}
	task->roleUID = roleUID;
	pushTask(task);
	return true;
}

// bool CWorldDbServerHandler::sendLoadLoginServers()
// {
// 	CWorldLoadLoginServerTask* task = newDatabaseTask<CWorldLoadLoginServerTask>();
// 	if (NULL == task)
// 	{
// 		gxError("Can't new load login server data task!!!");
// 		return false;
// 	}
// 	pushTask(task);
// 	return true;
// }

CWorldDbServerHandler* GetWorldLoginDbHandler()
{
	return DWorldServer->getLoginDbHandler();
}

CWorldDbServerHandler* GetWorldGameDbHandler()
{
	return DWorldServer->getGameDbHandler();
}

CWorldDbServerHandler* GetWorldServerListDbHandler()
{
	return DWorldServer->getServerListDbHandler();
}
