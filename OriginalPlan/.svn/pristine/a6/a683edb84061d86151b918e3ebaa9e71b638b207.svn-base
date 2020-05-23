#include "map_db_server_handler.h"
#include "map_db_task.h"
#include "map_server_instance.h"
#include "map_server_data.h"
#include "map_server.h"

bool CMapDbServerHandler::start()
{
	if(!sendServerInitTask())
	{
		DMapServer->setStop();
		return false;
	}

	return true;
}

GXMISC::EHandleRet CMapDbServerHandler::handle( char* msg, uint32 len )
{
    return GXMISC::HANDLE_RET_OK; 
}

bool CMapDbServerHandler::sendServerInitTask()
{
//     CServerInitTask* task = newDatabaseTask<CServerInitTask>();
//     if(NULL == task)
//     {
//         gxError("Can't new CMapDbServerInitTask!");
//         return false;
//     }
// 	task->serverID = DMapServerData.getMapServerID();
//     pushTask(task);
    return true;
}

void CMapDbServerHandler::sendSaveMapServerDataTask()
{
// 	CServerSaveDataTask* task = newDatabaseTask<CServerSaveDataTask>();
// 	if(NULL == task)
// 	{
// 		gxError("Can't new CMapDbServerInitTask!");
// 		return;
// 	}
// 	
// 	task->serverID = DMapServerData.getMapServerID();
// 	task->itemSerialID = DMapServerData.getItemSerialID();
// 	task->petSerialID = DMapServerData.getPetSerialID();
// 	task->minPetObjUID = DMapServerData.getPetObjUID();
// 	task->minCropObjUID = DMapServerData.getCropObjUID();
// 
// 	pushTask(task);
}

void CMapDbServerHandler::sendPlayerRegiste(std::string account, std::string passwd, GXMISC::TSocketIndex_t socketIndex)
{
	CPlayerRegisteTask* task = newDatabaseTask<CPlayerRegisteTask>();
	if(NULL == task)
	{
		gxError("Can't new CPlayerRegisteTask!AccountName={0},SocketIndex={1}", account, socketIndex);
		return;
	}
	task->account = account;
	task->passwd = passwd;
	task->socketIndex = socketIndex;
	pushTask(task);
}