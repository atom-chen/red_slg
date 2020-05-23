#include "map_server_base.h"
#include "map_server_event_base.h"

#include "game_rand.h"
#include "error_log.h"
#include "gm_log.h"
#include "stat_log.h"
#include "tbl_loader.h"
#include "game_config.h"
#include "game_extend_socket_handler.h"
#include "game_socket_packet_handler.h"
#include "game_server_socket_packet_handler.h"

CMapServerBase              *g_MapServerBase	= NULL;
GXMISC::CDatabaseConnMgr    *g_MapDbMgr			= NULL;
GXMISC::CNetModule			*g_MapNetMgr		= NULL;

CMapServerBase::CMapServerBase(const std::string& serverName, GXMISC::CGxServiceConfig* config) 
//	: GameService(config, serverName)
	: GxService(config, serverName)
{
	g_MapServerBase = this;
	g_MapDbMgr = getDbMgr();
	g_MapNetMgr = getNetMgr();
}

CMapServerBase::~CMapServerBase()
{
}

void CMapServerBase::_initFromDb()
{
}

void CMapServerBase::onBreath( GXMISC::TDiffTime_t diff )
{
	TBaseType::onBreath(diff);
}

bool CMapServerBase::init()
{
	if(!TBaseType::init())
	{
		return false;
	}

	addLogger(new CErrorFileLog(false, (getModuleName()+"Err").c_str()));
	addLogger(new CStatFileLog(false, (getModuleName()+"Stat").c_str()));
	addLogger(new CGmFileLog(false, (getModuleName()+"GM").c_str()));

	DGxContext.setDumpHandler(new CMapServerEvent());
	DRandGen.reset((CRandGen::TSeedType)time(NULL));


	return true;
}


void CMapServerBase::updateToWorld()
{
}

bool CMapServerBase::_initServerConfig( const TServerPwdInfo& pwdInfo )
{
	CCconfigLoaderParam configLoaderParam;
	configLoaderParam.remotePath = false;
	configLoaderParam.encrypt = false;
	if(isConfigRemotePath())
	{
		configLoaderParam.remotePath = true;
		configLoaderParam.encrypt = true;
	}
	else
	{
		g_GameConfig.urlPath = "";
	}

	configLoaderParam.loginName = pwdInfo.userName.c_str();
	configLoaderParam.loginPwd = pwdInfo.userPwd.c_str();
	configLoaderParam.encryptKey = pwdInfo.parsePwd.c_str();

	return onLoadTblConfig(configLoaderParam);
}

bool CMapServerBase::onLoad( GXMISC::CIni* iniFile, const std::string& fileName )
{
	// 解密ini文件
	if(!g_GameConfig.iniFileUncrypt)
	{
		std::string fileData;
// 		byte aesKey[CryptoPP::AES::DEFAULT_KEYLENGTH];  //密钥
// 		memset(aesKey, 0, sizeof(aesKey));
// 		strcpy((char*)aesKey, "axjhgameconfig");
// 		if(false == AESDecryptFile(aesKey, CryptoPP::AES::DEFAULT_KEYLENGTH, fileName, fileData))
// 		{
// 			return false;
// 		}

		return iniFile->open(fileData.c_str(), (sint32)fileData.size());
	}
	else
	{
		std::string tempFileName = fileName + ".tmp";
		return iniFile->open(tempFileName.c_str());
	}

	return false;
}

bool CMapServerBase::initServer( const TServerPwdInfo& pwdInfo )
{
	onBeforeInitServer();

	if(!_initServerConfig(pwdInfo))
	{
		return false;
	}

	if(!onInitServerData())
	{
		return false;
	}

	if(!onInitSocket())
	{
		return false;
	}

	if(!onInitServerDbData())
	{
		return false;
	}

	onAfterInitServer();

	return true;
}

bool CMapServerBase::onInitServerDbData()
{
	_initFromDb();

	return true;
}

bool CMapServerBase::onAfterStart()
{
	if(!TBaseType::onAfterStart())
	{
		return false;
	}

	initTimer(DTimeManager.nowSysTime());

	// @TODO 添加远程加载配置的功能
	// 	if(isConfigRemotePath())
	// 	{
	// 		if ( false == openServerConnector<CMapPwdHandler, CGameServerSocketPacketHandler, SOCKET_TAG_MDL>(_config.getPwdIP(), _config.getPwdPort(), 5000) )
	// 		{
	// 			gxError("Can't open connector! PwdIP = {0}, PwdPort = {1}", _config.getPwdIP(), _config.getPwdPort());
	// 			return false;
	// 		}
	// 	}
	// 	else
	{
		TServerPwdInfo info;
		return initServer(info);
	}
}

bool CMapServerBase::onLoadTblConfig( CCconfigLoaderParam& configLoaderParam )
{
	return true;
}

void CMapServerBase::onRegisteToWorld( TServerID_t serverID )
{

}

void CMapServerBase::onWorldServerInfo( WMServerInfo* packet )
{

}