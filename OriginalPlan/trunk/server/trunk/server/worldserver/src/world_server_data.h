#ifndef _WORLD_SERVER_DATA_H_
#define _WORLD_SERVER_DATA_H_

#include "core/parse_misc.h"

#include "game_util.h"
#include "singleton.h"
#include "server_struct.h"
#include "world_db_server_handler.h"

class CWorldDbServerHandler;

#define MAX_ADD_SERIAL 1000

class CWorldServerData // @sc
	: public GXMISC::CManualSingleton<CWorldServerData>
{
	DSingletonImpl();

public:
	CWorldServerData();
	~CWorldServerData();

public:
	// 更新
	void update(GXMISC::TDiffTime_t diff);

public:
	//获取内存数据
	TWorldServerData * getDataPtr(void){ return &_data; }


private:
	void _saveData();

public:
	CWorldDbServerHandler* getDbHandler(bool logFlag = true);	// @sf

private:
	TWorldServerData			_data;							///< 服务器数据	
};

#define DWorldServerData CWorldServerData::GetInstance()

#endif