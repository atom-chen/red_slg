#ifndef _WORLD_SERVER_H_
#define _WORLD_SERVER_H_

#include <vector>
#include <list>

#include "core/service.h"
#include "core/timer.h"

#include "world_server_config.h"
#include "world_db_server_handler.h"
#include "game_struct.h"
#include "tbl_define.h"
#include "tbl_loader.h"
#include "stop_timer.h"

class CWorldServer:
	public GXMISC::GxService,
	public GXMISC::CGamePassTimerBase,
	public GXMISC::CManualSingleton<CWorldServer>
{
	typedef GXMISC::GxService					TBaseType;
public:
	CWorldServer(const std::string& serverName = "WorldServer");
	~CWorldServer();

public:
	bool					initServer( const TServerPwdInfo* pwdInfo );
	bool					initFromDb();
	void					clear();

	// �ӿ�
public:
	CWorldServerConfig*		getConfig();

	// ����
public:
	virtual bool			onAcceptSocket(GXMISC::CSocket* socket, GXMISC::CSocketHandler* sockHandler, GXMISC::ISocketPacketHandler* packetHandler, sint32 tag) override;
	virtual bool			onConnectSocket(GXMISC::CSocket* socket, GXMISC::CSocketHandler* sockHandler, GXMISC::ISocketPacketHandler* packetHandler, sint32 tag) override;

	// ����
public:
	virtual void			onBreath(GXMISC::TDiffTime_t diff) override;									///< ����
	virtual bool			load(const std::string& serverName);											///< ��������
	virtual bool			init() override;																///< ��ʼ��
	virtual void			onStat() override;																///< ͳ���¼�
	virtual bool			onLoad(const std::string& inData, std::string& outData) override;				///< �����¼�
	virtual	bool			onAfterStart() override;														///< ����ʼ���¼�
	virtual void			onFirstLoop() override;															///< ��һ��ѭ���¼�
	virtual void			onPassHour() override;															///< ��Сʱ�¼�
	virtual void			onPassDay() override;															///< ����

public:
	EServerStatus			getServerStatus();												///< ������״̬
	TWorldServerID_t		getWorldServerID() const;										///< �õ�������ID
	GXMISC::TGameTime_t		getStartTime() const;											///< �õ�����ʱ��
	GXMISC::TGameTime_t		getFirstStartTime() const;										///< �õ���һ������ʱ��
	GXMISC::TGameTime_t		getOpenTime() const;											///< �õ�����ʱ��
	const CWorldServerInfo* getServerInfo() const;											///< �õ���������Ϣ
	CWorldServerInfo*		getServerInfo();												///< �õ���������Ϣ
	CWorldDbServerHandler*	getLoginDbHandler();											///< �õ���½���ݿ�����
	CWorldDbServerHandler*	getGameDbHandler();												///< �õ���Ϸ���ݿ�����
	CWorldDbServerHandler*	getServerListDbHandler();										///< �õ����������ݿ�����
	CStopTimer*				getStopTimer();													///< ͣ����ʱ��

private:
	bool _initServerMgrData();																///< ��ʼ����������������
	bool _initSockets();																	///< ��ʼ������Socket
	bool _initServerData();																	///< ��ʼ������������
	bool _initServerConfig( const TServerPwdInfo& pwdStr );									///< ��ʼ������������
	bool _ininServerLogicMod();																///< ��ʼ���߼�ģ��
	bool _newLoginDbHandler();																///< �´�����½���ݿ�����
	bool _newGameDbHandler();																///< �´�����Ϸ���ݿ�����
	bool _newServerListDbHandler();															///< �´������������ݿ�����
	bool checkTblConfig();																	///< �����ļ����

private:
	CWorldServerConfig				_config;												///< ����������
	bool							_initDataSuccess;										///< �Ƿ�ɹ���ʼ������
	CWorldServerInfo				_serverInfo;											///< ��������Ϣ
	GXMISC::TGameTime_t				_serverStartTime;										///< ����������ʱ��
	CWorldDbServerHandler*			_loginDbHandler;										///< ��½���ݿ�����
	CWorldDbServerHandler*			_gameDbHandler;											///< ��Ϸ���ݿ�����
	CWorldDbServerHandler*			_serverListDbHandler;									///< �������б�����
	TTblLoaderVec					_tblLoaders;											///< �����ļ�
	CStopTimer _stopTimer;																	///< ͣ����ʱ��
};

extern CWorldServer* g_WorldServer; 
#define	DCWorldServer g_WorldServer

#endif
