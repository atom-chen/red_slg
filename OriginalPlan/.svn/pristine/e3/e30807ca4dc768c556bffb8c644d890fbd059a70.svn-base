#include "core/mini_server.h"

#include <ctime>

GXMISC::CMiniServer *g_service = NULL;

#pragma pack(push, 1) // 结构对齐

typedef struct _Packet
{
	sint16 packLen;
	sint32 id;
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

typedef struct _MovesPacket : TPacket // 5 移动
{
	sint32 playerId;
	float x;
	float y;
}TMovesPacket;

#pragma pack(pop)


class CPlayerConnect : public GXMISC::CDefaultSocketHandler
{
public:
	CPlayerConnect()
	{
		_playerId = -1;
	}
	~CPlayerConnect(){}

public:
	virtual bool start()
	{
		gxInfo("New player online!");

		TLoginPacket login;
		login.packLen = sizeof(TLoginPacket);
		login.id = 1;
		login.x = 0;
		login.y = 0;
		send(&login, sizeof(login));

		TMovesPacket movePacket;
		movePacket.packLen = sizeof(movePacket);
		movePacket.playerId = 0;
		movePacket.id = 5;
		movePacket.x = 0;
		movePacket.y = 0;
		send(&movePacket, sizeof(movePacket));

		return true;
	}

	virtual void close()
	{
	}

	virtual GXMISC::EHandleRet handle(char* msg, uint32 len)
	{
		TPacket *packet = (TPacket*)msg;
		switch(packet->id)
		{
		case 2:
		{

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

	if(!miniServer.start())
	{
		printf("Cant start mini server!");
		return false;
	}

	if (!miniServer.openClientConnector<CPlayerConnect, GXMISC::CDefaultPacketHandler>("127.0.0.1", 3302, 50000, 1, false))
	{
		gxError("Can't open listen!IP={0}, Port={1}, ID={2}", "127.0.0.1", 3302, 1);
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