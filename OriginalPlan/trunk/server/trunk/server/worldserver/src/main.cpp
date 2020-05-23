#include "core/string_common.h"
#include "core/perfor_stat.h"

#include "world_server.h"
#include "game_config.h"
#include "world_script_engine.h"
#include "world_server_data.h"

int main(int argc, char* argv[])
{
	/**
	 * 输入参数
	 * 0: 执行文件名
	 * 1: ini配置文件是否加密
	 */
	CWorldScriptEngine scriptEngine;
	CWorldServerData   worldServerData;
 	g_GameConfig.iniFileUncrypt = true;
// 	if(argc > 1)	@TODO
// 	{
// 		// 加密标识
// 		if(NULL != argv[1])
// 		{
// 			bool iniFileCryptFlag = true;
// 			GXMISC::gxFromString(argv[1], iniFileCryptFlag);
// 			g_GameConfig.iniFileUncrypt = iniFileCryptFlag;
// 		}
// 	}

	GXMISC::PerfStart("WorldServer");

	std::string serverName;
	serverName = "WorldServer";
	if(argc > 1)
	{
		serverName = argv[1];
	}

	CWorldServer server;
	server.setSystemEnvironment();

	if (false == server.load(serverName+".ini")) {
		std::cout << "load config failed!" << std::endl;
		return -1;
	}
	std::cout << "load config success!" << std::endl;

	if (false == server.init()) {
		std::cout<< "init false!" <<std::endl;
		return -1;
	}
	std::cout << "init service success!" << std::endl;

	if (false == server.start()) {
		std::cout<< "start false!" <<std::endl;
		return -1;
	}
	std::cout << "service start!" << std::endl;

	server.loop(-1);

	return 0;
}
