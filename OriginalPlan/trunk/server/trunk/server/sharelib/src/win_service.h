#ifndef _WIN_SERVICE_H_
#define _WIN_SERVICE_H_

#include "win_base.h"

#ifdef OS_WIN

#define		_MAX_IP_LEN_				24		//最大IP长度
#define		_GAMESVR_TYPE				300		//游戏管理服务器(加载个子游戏模块,为子游戏模块提供通信服务)
#define		_GLOBAL_GAMESVR_TYPE		600		//竞技场游戏服务器(跨区)
#define		_MAX_NAME_LEN_				48		//最大名字长度

class GameService : public CWndBase
{
public:
	GameService(GXMISC::CGxServiceConfig* config, const std::string& serverName = "GxService");
	~GameService();

public:
	void EnableCtrl(bool bEnableStart);
	bool CreateToolbar();

	virtual bool OnStartService();
	virtual void OnStopService();
	virtual void OnConfiguration();

	virtual void OnQueryClose(bool& boClose);
	virtual bool OnInit();
	virtual void OnUninit();
	virtual long OnTimer(int nTimerID);
	virtual long OnCommand(int nCmdID);
	virtual bool OnCommand(char* szCmd);
	virtual bool Init(HINSTANCE hInstance);
	virtual void OnClearLog();
	virtual void OnIdle();

public:
	void SetAutoStart(bool flag = true);

public:
	void	StartService();
	void	RefSvrRunInfo();
	void	ShutDown();
	void	StopService();
	bool	LoadLocalConfig();
	bool	LoadServerParam();
	bool	SaveServerParam(int naddtime, int nadditemid);

protected:
	static bool			m_boStartService;						//是否开始服务

#ifdef _GLOBAL_GAMESVR_
	static const uint32	m_svrtype = _GLOBAL_GAMESVR_TYPE;		//游戏服务器类型
#else
	static const uint32	m_svrtype = _GAMESVR_TYPE;				//游戏服务器类型
#endif // _GLOBAL_GAMESVR_

	uint16				m_svridx;								//服务器ID
	bool				m_boshutdown;							//判断是否已经关闭
	std::time_t			m_timeshutdown;							//关闭时间
	bool				m_forceclose;							//是否被强制关闭
	wchar_t				m_szSvrName[MAX_PATH];					//服务器名字
	bool				m_boAutoStart;							//是否自动开始
};

#endif

#endif	// _WIN_SERVICE_H_