#ifndef _WORLD_SERVER_CONFIG_H_
#define _WORLD_SERVER_CONFIG_H_

#include "core/ini.h"
#include "core/service.h"

#include "socket_attr.h"
#include "game_util.h"

enum ESocketTag
{
	SOCKET_TAG_WML,		// ��ͼ����������
	SOCKET_TAG_WCL,		// �ͻ��˼���
	SOCKET_TAG_WMC,		// ����������������
	SOCKET_TAG_WGML,	// GM����
	SOCKET_TAG_WRL,		// ��־����������
	SOCKET_TAG_WBC,		// ��ֵ����������
	SOCKET_TAG_WDC,		// ��Դ����������
	SOCKET_TAG_WLC,		// ��½������
	SOCKET_TAG_WHL,		// HTTP����
};

typedef GXMISC::TPort_t TPort_t;
class CWorldServerConfig // @sc
	: public GXMISC::CGxServiceConfig
{
public:
	CWorldServerConfig(const std::string& moduleName);
	~CWorldServerConfig();

public:
	virtual bool onLoadConfig(const GXMISC::CConfigMap* configs) override;

private:
	void cleanUp();

public:
	const TSockExtAttr* getClientSocketAttr() const;
	const TSockExtAttr* getMapServerSocketAttr() const;
	const TSockExtAttr* getSvrMgrSocketAttr() const;
	const TSockExtAttr* getGmSocketAttr() const;
	const TSockExtAttr* getRecordeSocketAttr() const;
	const TSockExtAttr* getBillSocketAttr() const;
	const TSockExtAttr*	getPwdSocketAttr() const;

public:
	const std::string& getToClientIP() const; // @sf
	const TPort_t getToClientPort() const; // @sf
	const char* getClientListenIP() const; // @sf
	TPort_t getClientListenPort() const; // @sf
	const char* getLoginServerIP() const; // @sf
	TPort_t getLoginServerPort() const; // @sf
	const char* getMapListenIP() const; // @sf
	TPort_t getMapListenPort() const; // @sf
	const char* getRecordeServerIP() const; // @sf
	TPort_t getRecordeServerPort() const; // @sf
	const char* getGmListenIP() const; // @sf
	TPort_t getGmListenPort() const; // @sf
	const char* getManagerServerIP() const; // @sf
	TPort_t getManagerServerPort() const; // @sf
	const std::string getBillListenIP() const; // @sf
	TPort_t getBillListenPort() const; // @sf
	const char* getPwdIP() const; // @sf
	TPort_t	getPwdPort() const; // @sf
	TWorldServerID_t getWorldServerID() const; // @sf
	uint32 getClientNum() const; // @sf
	uint32 getLoginPlayerNum() const; // @sf
	uint32 getMapServerNum() const; // @sf
	std::string getCheckTextFileName() const; // @sf
	const char* getDbHostIP() const; // @sf
	TPort_t	getDbPort() const; // @sf
	const char* getDbName() const; // @sf
	const char* getDbUser() const; // @sf
	const char* getDbPwd() const; // @sf
	std::string getConfigTblPath() const; // @sf
	bool isConfigRemotePath() const; // @sf
	std::string getHttpListenIP() const { return _httpListenIP; } // @sf
	void setHttpListenIP(std::string val) { _httpListenIP = val; } // @sf
	GXMISC::TPort_t getHttpListenPort() const { return _httpListenPort; } // @sf
	void setHttpListenPort(GXMISC::TPort_t val) { _httpListenPort = val; } // @sf
	bool getGmCheck() const { return _gmCheck; } // @sf
	void setGmCheck(bool val) { _gmCheck = val; } // @sf
	bool getHttpCheck() const { return _httpCheck; } // @sf
	void setHttpCheck(bool val) { _httpCheck = val; } // @sf

private:
	TSockExtAttr _clientListenSocket;		// �ͻ��˼����˿�
	TSockExtAttr _svrMgrListenSocket;		// ��������������˿�
	TSockExtAttr _billListenSocket;			// ��ֵ�����������˿�
	TSockExtAttr _recordeListenSocket;		// ��־�������˿�
	TSockExtAttr _gmListenSocket;			// GM�����������˿�
	TSockExtAttr _mapServerListenSocket;	// ���������������˿�
	TSockExtAttr _resourceSocket;			// ��Դ�������˿�
	TSockExtAttr _loginSocket;				// ��½�������˿�
	std::string _toClientIP;				// �Կͻ��˿��ŵ�IP
	GXMISC::TPort_t _toClientPort;			// �Կͻ��˿��ŵĶ˿�
	std::string		_httpListenIP;			// http����IP
	GXMISC::TPort_t	_httpListenPort;		// http�����˿�
	std::string _filterFileName;			// �������ļ�
	TWorldServerID_t _serverID;				// ������ID
	uint32 _clientNum;						// �����Ŀ
	uint32 _loginPlayerNum;					// �Ŷ������Ŀ
	uint32 _mapServerNum;					// ��������������
	std::string	_dbHostIP;					// ���ݿ�IP
	GXMISC::TPort_t	_dbPort;				// ���ݿ�˿�
	std::string	_dbName;					// ���ݿ�����
	std::string	_dbUser;					// ���ݿ��û�
	std::string	_dbPwd;						// ���ݿ�����
	std::string _configTblPath;				// ����Ŀ¼
	uint32 _configRemotePath;				// �����Ƿ�Զ�̵�ַ
	bool _gmCheck;							// GM������
	bool _httpCheck;						// Http������
};

class CWorldServerInfo{
public:
	CWorldServerInfo(){
		_firstStartTime = 0;
		_openTime = 0;
	}
	~CWorldServerInfo(){

	}
public:
	GXMISC::TGameTime_t getFirstStartTime() const { return _firstStartTime; }
	void setFirstStartTime(GXMISC::TGameTime_t val) { _firstStartTime = val; }
	GXMISC::TGameTime_t getOpenTime() const { return _openTime; }
	void setOpenTime(GXMISC::TGameTime_t val) { _openTime = val; }

private:
	GXMISC::TGameTime_t _firstStartTime;
	GXMISC::TGameTime_t _openTime;
};
static const sint32 FlashPolicydPort=843;

#endif
