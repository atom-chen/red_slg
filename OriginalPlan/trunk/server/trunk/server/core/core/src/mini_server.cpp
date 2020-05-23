#include "mini_server.h"

namespace GXMISC
{
	CMiniServer::CMiniServer( const std::string serverName /*= ""*/ ) : TBaseType(&_serverConfig, serverName)
	{
	}

	bool CMiniServer::onAfterInit()
	{
		if(!TBaseType::onAfterInit())
		{
			return false;
		}

		return true;
	}

	bool CMiniServer::onSystemEnvironment()
	{
		if(!TBaseType::onSystemEnvironment())
		{
			return false;
		}

		return true;
	}

	bool CMiniServer::onAfterLoad()
	{
		return true;
	}

	uint32 CMiniServer::_test = 0;

}

