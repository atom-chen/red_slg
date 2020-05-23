#include "core/perfor_stat.h"
#include "core/string_common.h"

#include "map_server.h"
#include "game_config.h"
#include "map_server_instance.h"

int main(int argc, char* argv[])
{
	CMapServer::InitStaticInstanace();

	CMapServer server;
	std::string serverName;
//	try
	{
		GXMISC::PerfStart("MapServer");

		serverName = "MapServer";
		if(argc > 1)
		{
			serverName = argv[1];
		}
 		g_GameConfig.iniFileUncrypt = true;
// 		if(argc > 1)
// 		{
// 			// 加密标识
// 			if(NULL != argv[1])
// 			{
// 				bool iniFileCryptFlag = true;
// 				GXMISC::gxFromString(argv[1], iniFileCryptFlag);
// 				g_GameConfig.iniFileUncrypt = iniFileCryptFlag;
// 			}
// 		}

		if (false == server.setSystemEnvironment())
		{
			std::cout << "cant set system environment!" << std::endl;
			return -1;
		}
		std::cout << "set system environment success!" << std::endl;

		if(false == server.load(serverName+".ini"))
		{
			std::cout<<"load config failed!"<<std::endl;
			return -1;
		}
		std::cout<<"load config success!"<<std::endl;

		if(false == server.init())
		{
			std::cout<< "init false!" <<std::endl;
			return -1;
		}
		std::cout<< "init service success!" <<std::endl;

		if(false == server.start())
		{
			std::cout<< "start false!" <<std::endl;
			return -1;
		}
		std::cout<<"service start!"<<std::endl;

		server.loop(-1);

		std::cout<<"service stop!"<<std::endl;
	}
//	catch (...)
//	{
//		gxAssert(false);
//	}

	return 0;
}

/*
int __stdcall myWinMain(HMODULE hModule, const char* param)
{
	try
	{
		CMapServer::InitStaticInstanace();

		CMapServer server;

		GXMISC::PerfStart("MapServer");

		std::string serverName = "MapServer";
 		g_GameConfig.iniFileUncrypt = true;
// 		if(argc > 1)
// 		{
// 			// 加密标识
// 			if(NULL != argv[1])
// 			{
// 				bool iniFileCryptFlag = true;
// 				GXMISC::gxFromString(argv[1], iniFileCryptFlag);
// 				g_GameConfig.iniFileUncrypt = iniFileCryptFlag;
// 			}
// 		}

		if (false == server.setSystemEnvironment())
		{
			std::cout << "cant set system environment!" << std::endl;
			return -1;
		}
		std::cout << "set system environment success!" << std::endl;

		if(false == server.load(serverName+".ini"))
		{
			std::cout<<"load config failed!"<<std::endl;
			return -1;
		}
		std::cout<<"load config success!"<<std::endl;

		if(false == server.init())
		{
			std::cout<< "init false!" <<std::endl;
			return -1;
		}
		std::cout<< "init service success!" <<std::endl;

		if(false == server.start())
		{
			std::cout<< "start false!" <<std::endl;
			return -1;
		}
		std::cout<<"service start!"<<std::endl;

		GameService *pWnd = &server;
		if(pWnd)
		{
			GXMISC::CStringParse<std::string> parser(" ");
			parser.parse(param);
			pWnd->onBeforeInstance(parser.getValueList());
			pWnd->SetAutoStart(true);
			if(!pWnd->Init(hModule))
			{
				MessageBox(NULL, L"Failed to initialize windows", pWnd->GetTitle(), MB_ICONERROR);
				OnDestroyInstance(pWnd);
				return -1;
			}

			while(true){
				server.loop(0);
				if(pWnd->Run() != -1){
					break;
				}
				GXMISC::gxSleep(10);
			}
			
			pWnd->Uninit();
		}

		return OnDestroyInstance(pWnd);
	}
	catch(...)
	{
	}

	return 0;
}

int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance,
	PSTR szCmdLine, int iCmdShow)
{
	int nRet = 0;
	nRet = myWinMain(hInstance, szCmdLine);
	return nRet;
}
*/