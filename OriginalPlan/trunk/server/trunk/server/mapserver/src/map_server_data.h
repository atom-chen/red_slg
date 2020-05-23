#ifndef _MAP_SERVER_DATA_H_
#define _MAP_SERVER_DATA_H_

#include "core/parse_misc.h"

#include "game_util.h"
#include "singleton.h"
#include "server_struct.h"

class CMapDbServerHandler;

#define MAX_ADD_SERIAL 1000

class CMapServerData
	: public GXMISC::CManualSingleton<CMapServerData>
{
public:
	DSingletonImpl();

public:
	CMapServerData();
	~CMapServerData();

public:
	TWorldServerID_t getWorldServerID()	
	{
		return _data._worldServerID;
	}

	void setWorldServerID(TWorldServerID_t id)	
	{
		_data._worldServerID = id;
	}

	TPlatformID_t getPlatformID()	
	{
		return _data._platformID;
	}

	void setPlatformID( TPlatformID_t id )	
	{
		_dirtyFlag = true;
		_data._platformID = id;
	}

	const TAppendCDKeyString& getCDKeyStr()	
	{
		return _data._cdKeyString;
	}

	void setCDKeyStr( const TAppendCDKeyString& keyStr )	
	{
		_dirtyFlag = true;
		_data._cdKeyString = keyStr;
	}

	TServerID_t getMapServerID()	
	{
		return _data._mapServerID;
	}

	void setMapServerID(TServerID_t id)	
	{
		_dirtyFlag = true;
		_data._mapServerID = id;
	}

	void setMapDbHandlerID(GXMISC::TDbIndex_t index)	
	{
		_data._dbIndex = index;
	}

	void update(GXMISC::TDiffTime_t diff);	

	void initWorldServerInfo(GXMISC::CGameTime openTime, GXMISC::CGameTime firstStartTime); // 初始化世界服务器信息 
	sint32 getServerOpenDay();// 得到当前时间距离开服天数 

private:
	void _saveData();

public:
	CMapDbServerHandler* getDbHandler(bool logFlag = true);	

private:
	TServerData			_data;							///< 服务器数据
	bool				_dirtyFlag;						///< 脏标记
};

#define DMapServerData CMapServerData::GetInstance()

#endif