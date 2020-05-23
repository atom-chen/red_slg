#ifndef _SERVER_STRUCT_H_
#define _SERVER_STRUCT_H_

#include "core/db_util.h"
#include "core/time_util.h"
#include "core/carray.h"
#include "core/game_time.h"

#include "game_util.h"


/// 服务器数据
typedef struct ServerData
{
public:
	TWorldServerID_t	_worldServerID;				///< 世界服务器ID
	TPlatformID_t		_platformID;				///< 平台ID
	TAppendCDKeyString	_cdKeyString;				///< 激活码后面的字符串
	TServerID_t		_mapServerID;					///< 地图服务器ID
	GXMISC::TDbIndex_t			_dbIndex;			///< 数据库ID
	GXMISC::TGameTime_t			_serverTime;		///< 上一次服务器记录的时间
	GXMISC::CGameTime openTime;						///< 开服时间
	GXMISC::CGameTime firstStartTime;				///< 第一次启动时间

public:
	ServerData()
	{
		cleanUp();
	}

	void cleanUp()
	{
		_worldServerID = INVALID_WORLD_SERVER_ID;
		_platformID = INVALID_PLATFORM_ID;
		_cdKeyString = INVALID_APPEN_KEY_STRING;
		_mapServerID = INVALID_SERVER_ID;
		_dbIndex = GXMISC::INVALID_DB_INDEX;
		_serverTime = GXMISC::INVALID_GAME_TIME;
	}

}TServerData;

/// 登陆服务器数据
typedef struct LoginServerData
{
public:
	TServerID_t serverID;				///< 服务器ID
	TCharArray1 serverIP;				///< 服务器IP @TODO 废弃掉不用
	GXMISC::TPort_t serverPort;			///< 服务器端口 @TODO 废弃掉不用

public:
	LoginServerData()
	{
		serverID = INVALID_SERVER_ID;
		serverPort = 0;
		serverIP = "";
	}
}TLoginServerData;

/// 世界服务器
typedef struct WorldServerName : public GXMISC::IArrayEnable<WorldServerName>
{
public:
	TWorldServerID_t serverID;					///< 区ID
	TCharArray2 serverName;						///< 区名字
	TCharArray2 serverIP;						///< 角色服务器IP
	uint32 serverPort;							///< 角色服务器端口

public:
	WorldServerName()
	{
		DZeroSelf;
		DArrayKey(serverID);
	}
}TWorldServerName;
typedef CArray1<TWorldServerName> TWorldServerNameAry;

typedef struct WorldServerData
{
public:
	WorldServerData()
	{
		
	}

}TWorldServerData;

typedef struct RoleHeart
{
public:
	TRoleUID_t roleUID;         // 角色UID
	TAccountID_t accountID;     // 账号UID
	sint8 onlineFlag;			// 是否在线
}TRoleHeart;

#endif