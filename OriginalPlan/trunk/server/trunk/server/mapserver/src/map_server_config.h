#ifndef _MAP_SERVER_CONFIG_H_
#define _MAP_SERVER_CONFIG_H_

#include <set>

#include "core/ini.h"
#include "core/service.h"

#include "game_util.h"
#include "game_struct.h"
#include "game_define.h"
#include "socket_attr.h"
#include "game_config.h"

class CMapServer;
class CMapServerConfig 
	: public GXMISC::CGxServiceConfig
{
public:
	CMapServerConfig(const std::string& moduleName);
	~CMapServerConfig();

public:
	virtual bool onLoadConfig(const GXMISC::CConfigMap* configs) override;
	virtual bool check();

	void onAfterLoad();

public:
	void setFrameNum(sint32 num);
	void setRecordeSize();

public:
	const std::string		getClientListenIP()				const; 
	uint16          		getClientListenPort()			const; 
	const std::string     	getWorldServerIP()				const; 
	GXMISC::TPort_t         getWorldServerPort()			const; 
	const std::string		getRecordeServerIP()			const; 
	GXMISC::TPort_t			getRecordeServerPort()			const; 
	const std::string		getManagerServerIP()			const; 
	GXMISC::TPort_t			getManagerServerPort()			const; 
	const std::string		getGmListenIP()					const; 
	GXMISC::TPort_t			getGmListenPort()				const; 
	const std::string		getToClientListenIP()			const; 
	GXMISC::TPort_t			getToClientListenPort()			const; 
	const std::string		getResourceServerIP()			const; 
	GXMISC::TPort_t			getResourceServerPort()			const; 
	const std::string		getHttpListenIP()				const; 
	GXMISC::TPort_t			getHttpListenPort()				const; 

	const TSockExtAttr*		getClientListenSocketAttr()		const; 
	const TSockExtAttr*		getGmListenSocketAttr()			const; 
	const TSockExtAttr*		getWorldSvrSocketAttr()			const; 
	const TSockExtAttr*		getRecordeSvrSocketAttr()		const; 
	const TSockExtAttr*		getManagerSvrSocketAttr()		const; 
	const TSockExtAttr*		getResourceSvrSocketAttr()		const; 

	bool					getOpenGmCheck()				const; 
	bool					getOpenGmLog()					const; 
	uint8					getOpenRecordeServer()			const; 
	TServerID_t  			getMapServerID()				const; 
	EServerType  			getMapServerType()				const; 
	const TMapIDList		getMapIDs()						const; 
	sint32          		getRolePoolNum()				const; 
	std::string     		getConfigTblPath()				const; 
	uint8           		getProfileFrame()				const; 
	const std::string		getMapDataPath()				const; 
	uint8           		getRiskSceneNum()				const; 
	uint32          		getScenePoolNum( sint32 serverType = SERVER_TYPE_MAP_NORMAL, sint32 pkType = 0 )	const;
	bool					isDynamicMapServer()			const; 
	bool					isConfigRemotePath()			const; 

	std::string             getCheckTextFileName()          const; 
	bool getHttpCheck() const { return _httpCheck; }		
	void setHttpCheck(bool val) { _httpCheck = val; }		
private:
	TSockExtAttr			_clientListenSock;		// �ͻ��˼���Socket
	TSockExtAttr			_worldSock;				// ����Socket
	TSockExtAttr			_recordeSock;			// ��־Socket
	TSockExtAttr			_svrMgrSock;			// ����Socket
	TSockExtAttr			_gmListenSock;			// GM�������
	TSockExtAttr			_resourceSock;			// ��Դ���������

	std::string				_httpListenIP;			// http����IP
	GXMISC::TPort_t			_httpListenPort;		// http�����˿�
	std::string				_toClientListenIP;		// ���⿪�ŵĿͻ��˼���IP
	GXMISC::TPort_t			_toClientListenPort;	// ���⿪�ŵĿͻ��˼����˿�

	uint8					_openRecordeServer;		// �Ƿ�����־������
	TServerID_t      		_serverID;				// ������ID
	sint32              	_serveType;             // ����������
	TMapIDList          	_mapIDs;				// �����ĵ�ͼ
	uint32              	_rolePoolNum;			// ����ɫ��
	std::string         	_configTblPath;			// ����Ŀ¼
	uint8               	_profileFrame;          // �Ƿ����֡��
	std::string				_mapDataPath;			// ��ͼ·��
	uint8               	_riskSceneNum;          // ���ɿ����ĸ�����
	uint8					_isGmCheck;				// ����GMȨ�޼��
	uint8					_isGmLog;				// ����GM��־
	uint8					_configRemotePath;		// �����ļ��Ƿ�Զ��·��
	bool					_httpCheck;				// Http������
	std::string             _filterFileName;	    // �������ļ�
};

#endif