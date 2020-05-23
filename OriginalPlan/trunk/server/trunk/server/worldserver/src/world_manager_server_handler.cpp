#include "core/game_exception.h"

#include "world_manager_server_handler.h"
#include "world_script_engine.h"
#include "module_def.h"
#include "packet_mx_base.h"
#include "world_login_server_handler.h"
#include "game_server_socket_packet_handler.h"
#include "world_server_config.h"
#include "world_server_util.h"
#include "world_server.h"

void CWorldManagerServerHandler::sendRegiste()
{
	FUNC_BEGIN(LOGIN_SERVER_MOD);

	std::string registeString = DWorldScriptEngine.call("GetWorldRegisteMsg", "");

	XMServerRegiste serverRegiste;
	serverRegiste.msg = registeString;

	sendPacket(serverRegiste);

	FUNC_END(DRET_NULL);
}

CWorldManagerServerHandler::CWorldManagerServerHandler()
{
}

CWorldManagerServerHandler::~CWorldManagerServerHandler()
{
}

bool CWorldManagerServerHandler::start()
{
	return true;
}

void CWorldManagerServerHandler::close()
{
}

void CWorldManagerServerHandler::breath( GXMISC::TDiffTime_t diff )
{
	TBaseType::breath(diff);

}

void CWorldManagerServerHandler::Setup()
{
	RegisteHandler(PACKET_MX_REGISTE_RET, (TPacketHandler)&CWorldManagerServerHandler::handleServerRegiste);
}

void CWorldManagerServerHandler::UnSetup()
{
}

GXMISC::EHandleRet CWorldManagerServerHandler::handleServerRegiste( MXServerRegisteRet* packet )
{
	gxDebug("Registe message:", packet->msg.toString());

//	DWorldScriptEngine.vCall("OtherServerRegiste", this, packet->msg.toString());

	return GXMISC::HANDLE_RET_OK;
}

bool CWorldManagerServerHandler::connectToLoginServer( std::string ip, GXMISC::TPort_t port )
{
	return true;
}

void CWorldManagerServerHandler::onReconnect()
{
	if(!DWorldServer->openServerConnector<CWorldManagerServerHandler, CGameServerSocketPacketHandler>(
		DWorldServer->getConfig()->getManagerServerIP(), DWorldServer->getConfig()->getManagerServerPort(), 50000, SOCKET_TAG_WMC, false))
	{
		gxError("Can't connect to manager server!IP = {0}, Port = {1}", 
			DWorldServer->getConfig()->getManagerServerIP(), DWorldServer->getConfig()->getManagerServerPort());
		return;
	}
}