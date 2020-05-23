#ifndef _WORLD_MANAGER_SERVER_HANDLER_H_
#define _WORLD_MANAGER_SERVER_HANDLER_H_


#include "game_extend_socket_handler.h"
#include "packet_mx_base.h"

class CWorldManagerServerHandler // @sc
	: public CGameExtendSocketHandler<CWorldManagerServerHandler>
{
public:
	typedef CGameExtendSocketHandler<CWorldManagerServerHandler> TBaseType;
	typedef CWorldManagerServerHandler TMyType;

public:
	CWorldManagerServerHandler();
	virtual ~CWorldManagerServerHandler();

public:
	static void Setup();
	static void UnSetup();

protected:
	virtual bool start();
	virtual void close();
	virtual void breath(GXMISC::TDiffTime_t diff);
	virtual void onReconnect();

public:
	void sendRegiste();

protected:
	GXMISC::EHandleRet handleServerRegiste(MXServerRegisteRet* packet);

public:
	bool connectToLoginServer(std::string ip, GXMISC::TPort_t port); // @sf
};

#endif	// _WORLD_MANAGER_SERVER_HANDLER_H_