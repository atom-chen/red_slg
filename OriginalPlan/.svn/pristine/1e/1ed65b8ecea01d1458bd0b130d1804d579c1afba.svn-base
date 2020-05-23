#include "core/mini_server.h"

#include <ctime>

GXMISC::CMiniServer *g_service = NULL;

#pragma pack(push, 1) // 结构对齐

typedef struct _Packet
{
	sint16 packLen;
	sint32 id;

	const sint16 getPackLen() const
	{
		return packLen;
	}
}TPacket;

typedef struct _LoginPacket : TPacket // 1 登陆
{
	float x;	// X位置
	float y;	// Y位置
}TLoginPacket;
typedef struct _LoginRet : TPacket // 2
{
	sint32 playerId;	// 玩家ID
	float x;			// X位置
	float y;			// Y位置
}TLoginRet;

typedef struct _OtherLogin : TPacket // 3 其他玩家登陆
{
	char name[100];		// 名字
	char resName[100];	// 显示外观资源名
	sint32 playerId;	// 玩家ID
	sint32 color;		// 颜色
	float x;			// X位置
	float y;			// Y位置
}TOtherLogin;

typedef struct _OtherOffline : TPacket // 4 其他玩家下线
{
	sint32 playerId; // 玩家ID
}TOtherOffline;

typedef struct _MovesPacket : TPacket // 5 移动
{
	sint32 playerId;
	float x;
	float y;
}TMovesPacket;


#pragma pack(pop)

class CPlayerHandler
{
public:
	CPlayerHandler(){
		_id = -1;
		_color = -1;
		_name = "";
		_socketIndex = GXMISC::INVALID_SOCKET_INDEX;
	}
	~CPlayerHandler();

public:
	void setId(sint32 id){ _id = id;}
	sint32 getId(){ return _id;}
	void setColor(sint32 color){_color = color;}
	sint32 getColor(){ return _color;}
	void setName(const char* name){_name = name;}
	const char* getName(){ return _name.c_str(); }
	void setSocketIndex(GXMISC::TSocketIndex_t socketIndex){ _socketIndex = socketIndex; }
	GXMISC::TSocketIndex_t getSocketIndex(){ return _socketIndex; }
	void setPosition(float x, float y){ _x = x; _y = y; }
	float getX(){ return _x; }
	float getY(){ return _y; }

public:
	template<typename T>
	void sendPacket(const T& packet)
	{
		GXMISC::CSocketHandler* pHandler = g_service->getNetMgr()->getSocketHandler(_socketIndex);
		if(NULL != pHandler)
		{
			pHandler->send(&packet, sizeof(packet));
		}
	}

protected:
	sint32 _id;			// ID
	sint32 _color;		// 颜色
	std::string _name;	// 玩家名字
	GXMISC::TSocketIndex_t _socketIndex;	// Socket唯一标识
	float _x;	// X位置
	float _y;	// Y位置
};

class CPlayerManager : public GXMISC::CManualSingleton<CPlayerManager>
{
public:
	typedef std::map<sint32, CPlayerHandler*> TPlayerMap;

public:
	CPlayerManager()
	{
		_playerId = 0;
	}
	~CPlayerManager(){}

public:
	CPlayerHandler* newPlayer(char* name)
	{
		CPlayerHandler* player = new CPlayerHandler();
		player->setId(_playerId);
		player->setColor(rand()%10000000+5000);
		player->setName(name);
		
		_players.insert(TPlayerMap::value_type(_playerId, player));
		_playerId++;
		return player;
	}
	
	void deletePlayer(sint32 id)
	{
		_players.erase(id);
	}

	CPlayerHandler* findPlayerById(sint32 id)
	{
		TPlayerMap::iterator iter = _players.find(id);
		if(iter != _players.end()){
			return iter->second;
		}

		return NULL;
	}

	const CPlayerManager::TPlayerMap& getPlayers(){ return _players; }

public:
	template<typename T>
	void broadPacket(const T& packet, sint32 id = -1)
	{
		for(TPlayerMap::iterator iter = _players.begin(); iter != _players.end(); ++iter)
		{
			if(id != -1 && iter->second->getId() == id)
			{
				// 排除指定ID的玩家
				continue;
			}
			iter->second->sendPacket(packet);
		}


	}

	void getSocketIndexs(GXMISC::TSockIndexAry& socks, sint32 id = -1)
	{
		for (TPlayerMap::iterator iter = _players.begin(); iter != _players.end(); ++iter)
		{
			if (id != -1 && iter->second->getId() == id)
			{
				// 排除指定ID的玩家
				continue;
			}
			socks.pushBack(iter->second->getSocketIndex());
		}
	}

protected:
	TPlayerMap _players;
	sint32 _playerId;
};

#define PlayerMgr CPlayerManager::GetInstance()

class CPlayerConnect : public GXMISC::CDefaultSocketHandler
{
public:
	CPlayerConnect()
	{
		_playerId = -1;
	}
	~CPlayerConnect(){}

public:
	CPlayerHandler* getPlayer()
	{
		return PlayerMgr.findPlayerById(_playerId);
	}

public:
	template<typename T>
	void broadPacket(T& packet)
	{
		GXMISC::TSockIndexAry socks;
		PlayerMgr.getSocketIndexs(socks, _playerId);

		broadMsg(packet, socks);
	}

public:
	virtual bool start()
	{
		CPlayerHandler* player = PlayerMgr.newPlayer("test");
		if(NULL == player)
		{
			gxError("Cant new player!");
			return false;
		}

		_playerId = player->getId();
		player->setSocketIndex(getSocketIndex());
		gxInfo("New player online!");

		return true;
	}

	virtual void close()
	{
		if(_playerId != -1)
		{
			PlayerMgr.deletePlayer(_playerId);
			gxInfo("Player offline!");

			// 连接断开, 广播给其他玩家
			TOtherOffline offline;
			offline.packLen = sizeof(TOtherOffline);
			offline.id = 4;
			offline.playerId = _playerId;

			PlayerMgr.broadPacket(offline, _playerId);
		}
	}

	virtual GXMISC::EHandleRet handle(char* msg, uint32 len)
	{
		TPacket *packet = (TPacket*)msg;
		switch(packet->id)
		{
		case 1:
			{
				// 玩家登陆
				TLoginPacket* pLoginPacket = (TLoginPacket*)packet;
				CPlayerHandler* pPlayer = getPlayer();
				if(NULL != pPlayer)
				{
					// 登陆返回
					TLoginRet loginRet;
					memset(&loginRet, 0, sizeof(loginRet));
					loginRet.packLen = sizeof(loginRet);
					loginRet.id = 2;
					loginRet.playerId = pPlayer->getId();
					loginRet.x = pLoginPacket->x;
					loginRet.y = pLoginPacket->y;
					send(&loginRet, sizeof(loginRet));

					// 广播其他玩家, 有新玩家登陆
					TOtherLogin otherLogin;
					memset(&otherLogin, 0, sizeof(otherLogin));
					otherLogin.packLen = sizeof(TOtherLogin);
					otherLogin.id = 3;
					otherLogin.playerId = pPlayer->getId();
					strcpy(otherLogin.name,pPlayer->getName());
					strcpy(otherLogin.resName, "test.png");
					otherLogin.color =  pPlayer->getColor();
					otherLogin.x = pLoginPacket->x;
					otherLogin.y = pLoginPacket->y;

					PlayerMgr.broadPacket(otherLogin, _playerId);

					// 发送其他玩家给刚登陆的玩家
					CPlayerManager::TPlayerMap players = PlayerMgr.getPlayers();
					for(CPlayerManager::TPlayerMap::const_iterator iter = players.begin(); iter != players.end(); ++iter)
					{
						CPlayerHandler* pOtherPlayer = iter->second;
						if(pOtherPlayer->getId() == _playerId)
						{
							continue;
						}

						TOtherLogin otherLogin;
						memset(&otherLogin, 0, sizeof(otherLogin));
						otherLogin.packLen = sizeof(TOtherLogin);
						otherLogin.id = 3;
						otherLogin.playerId = pOtherPlayer->getId();
						strcpy(otherLogin.name,pOtherPlayer->getName());
						strcpy(otherLogin.resName, "test.png");
						otherLogin.color =  pOtherPlayer->getColor();
						otherLogin.x = pOtherPlayer->getX();
						otherLogin.y = pOtherPlayer->getY();
						pPlayer->sendPacket(otherLogin);
					}
				}
			}break;
		case 5:
			{
				// 自己移动，广播给其他玩家
				TMovesPacket *movePakcet = (TMovesPacket *)msg;
				broadPacket(*movePakcet);
				CPlayerHandler* pPlayer = getPlayer();
				if(NULL != pPlayer)
				{
					pPlayer->setPosition(movePakcet->x, movePakcet->y);
				}
			}break;
		default:
			{
				gxError("Unkown packet");
			}
		}

		return GXMISC::HANDLE_RET_OK;
	}

protected:
	sint32 _playerId;
};

int main(int argc, char* argv[])
{
	CPlayerManager playerMgr;
	srand(time(NULL)%100000000);
	GXMISC::CMiniServer miniServer("MiniServer");
	g_service = &miniServer;
	if(!miniServer.setSystemEnvironment())
	{
		printf("Cant set system environment!");
		return false;
	}

	if(!miniServer.load("MiniServer.ini"))
	{
		printf("Cant load mini server!");
		return false;
	}

	if(!miniServer.init())
	{
		printf("Cant init mini server!");
		return false;
	}

	if(!miniServer.openClientListener<CPlayerConnect, GXMISC::CDefaultPacketHandler>("127.0.0.1", 3302, 1))
	{
		gxError("Can't open listen!IP={0}, Port={1}, ID={2}", "127.0.0.1", 3302, 1);
		return false;
	}

	if(!miniServer.start())
	{
		printf("Cant start mini server!");
		return false;
	}

	// 设置是否单次循环, 循环由其他框架控制
	//miniServer.setLoopOnce(true);

	if(!miniServer.loop(-1))
	{
		printf("Cant loop mini server!");
		return false;
	}

	return 0;
}