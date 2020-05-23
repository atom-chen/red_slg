#ifndef _WORLD_CHARGING_SERVER_HANDLER_H_
#define _WORLD_CHARGING_SERVER_HANDLER_H_

#include "game_util.h"
#include "game_errno.h"
#include "game_extend_socket_handler.h"

class BWRecharge;

class CWorldChargingServerHandler : public CGameExtendSocketHandler<CWorldChargingServerHandler>
{
public:
	typedef CGameExtendSocketHandler<CWorldChargingServerHandler> TBaseType;

public:
	CWorldChargingServerHandler(){ WorldChargingServerHandler = NULL; };
	~CWorldChargingServerHandler(){}

protected:
	virtual bool    start();
	virtual void    close();
	virtual void    breath(GXMISC::TDiffTime_t diff);
	void			quit();

public:
	static void		Setup();
	static void		Unsetup(){}

public:
	void sendRegiste();
	void sendRechargeRet(BWRecharge* packet, EGameRetCode retCode);

protected:
	GXMISC::EHandleRet handleRecharge(BWRecharge* packet);
	
public:
	template<typename T>
	static bool SendPacket(T& packet)
	{
		if(NULL != WorldChargingServerHandler)
		{
			WorldChargingServerHandler->sendPacket(packet);
			return true;
		}

		return false;
	}

public:
	static CWorldChargingServerHandler* WorldChargingServerHandler;
};

template<typename T>
static bool SendToChargingServer(T& packet)
{
	return CWorldChargingServerHandler::SendPacket(packet);
}

static bool IsChargingServerActive()
{
	return CWorldChargingServerHandler::WorldChargingServerHandler != NULL;
}


#endif	// _WORLD_CHARGING_SERVER_HANDLER_H_