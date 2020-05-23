#ifndef _WORLD_MAP_PLAYER_H_
#define _WORLD_MAP_PLAYER_H_

#include <string>
#include <set>

#include "game_util.h"
#include "world_map_server_handler.h"
#include "scene.h"

#include "core/multi_index.h"

class CWorldPlayer;

typedef std::map<TRoleUID_t, TSceneID_t> TServerRoleMap;
class CWorldMapPlayer
{
public:
	CWorldMapPlayer();
	~CWorldMapPlayer(){}

public:
	sint32 getRoleNum();
	bool isMaxNum();
	bool isHalfNum();
	EGameRetCode registe(TSceneAry& scenes, TServerID_t serverID, EServerType serverType, uint32 maxRoleNum, 
		GXMISC::TIPString_t ip, GXMISC::TPort_t port);

public:
	void setServerID(TServerID_t serverID);
	TServerID_t getServerID();
	void setSocketIndex(GXMISC::TSocketIndex_t socketIndex);
	GXMISC::TSocketIndex_t getSocketIndex();
	void setClientListenIP(const std::string& ip);
	const char* getClientListenIP() const;
	void setClientListenPort(GXMISC::TPort_t port);
	GXMISC::TPort_t getClientListenPort();
	EServerType getServerType();
	void setServerType(EServerType serverType);
	bool isNormalServer();
	bool isDynamicServer();

public:
	bool enter(CScene* pScene, TSceneID_t sceneID, CWorldPlayer* player);
	void leave(CWorldPlayer* player);
	void updateData(TMapServerUpdate* data);
	void getScenes(TSceneAry& scenes);
	bool canEnter();
	void setRoleSceneID(TRoleUID_t roleUID, TSceneID_t sceneID);
	TSceneID_t getRoleSceneID( TRoleUID_t roleUID ) const;

public:
	CWorldMapServerHandler* getMapServerHandler();
	template<typename T>
	void sendPacket(T packet)
	{
		CWorldMapServerHandler* player = getMapServerHandler();
		if (player != NULL) 
		{
			player->sendPacket(packet);
		}
	}

	// !!!此函数禁止使用
	void send(const char* buf, uint32 len)
	{
		CWorldMapServerHandler* player = getMapServerHandler();
		if (player != NULL) 
		{
			player->send(buf, len);
		}
	}

public:
	bool sendUnloadRoleData();

private:
	TServerID_t _serverID;
	EServerType _serverType;
	GXMISC::TSocketIndex_t _socketIndex;
	std::string _clientListenIP;
	GXMISC::TPort_t _clientListenPort;
	TServerRoleMap _roleMap;

	TMapServerUpdate _data;
public:
	DMultiIndexImpl1(TServerID_t, _serverID, INVALID_SERVER_ID);

private:
	void genStrName();
	const char* toString();

private:
	std::string _strName;
};

#endif
