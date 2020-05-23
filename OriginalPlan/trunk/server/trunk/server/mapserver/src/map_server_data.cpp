#include "map_server_data.h"
#include "map_db_server_handler.h"
#include "map_server_util.h"
#include "constant_tbl.h"
#include "game_misc.h"

void CMapServerData::_saveData()
{
	CMapDbServerHandler* handler = getDbHandler();
	if(NULL == handler)
	{
		return;
	}

	handler->sendSaveMapServerDataTask();
}

CMapDbServerHandler* CMapServerData::getDbHandler(bool logFlag /* = true */)
{
	CMapDbServerHandler* handler = dynamic_cast<CMapDbServerHandler*>(DMapDbMgr->getUser(_data._dbIndex));
	if(NULL == handler && logFlag)
	{
		gxWarning("Can't find handler!");
	}

	return handler;
}

CMapServerData::CMapServerData()
{
	_dirtyFlag = false;
	_data.cleanUp();
}

CMapServerData::~CMapServerData()
{

}

void CMapServerData::update(GXMISC::TDiffTime_t diff)
{
	if(_dirtyFlag)
	{
		_saveData();

		_dirtyFlag = false;
	}
}

void CMapServerData::initWorldServerInfo( GXMISC::CGameTime openTime, GXMISC::CGameTime firstStartTime )
{
	_data.openTime = openTime;
	_data.firstStartTime = firstStartTime;
}

sint32 CMapServerData::getServerOpenDay()
{
	sint32 openDay = CGameMisc::ToLocalDay(_data.openTime.getGameTime());
	sint32 curDay = CGameMisc::ToLocalDay(DTimeManager.nowSysTime());
	if(curDay >= openDay)
	{
		return curDay-openDay+1;
	}
	
	return 0;
}


