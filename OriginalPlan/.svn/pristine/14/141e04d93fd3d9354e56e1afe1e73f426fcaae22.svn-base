#include "win_service.h"

#ifdef OS_WIN

#include "resources.h"

#include <commctrl.h>

#ifdef _GLOBAL_GAMESVR_
#pragma message("跨服竞技场服务器")
#else
#pragma message("游戏服务器服务器")
#endif

#pragma warning(disable:4239)
//////////////////////////////////////////////////////////////////////////
#define _GATEWAY_CONN_				0

#define _LOGIN_SVR_CONNETER_		0
#define _DB_SVR_CONNETER_			1
#define _SUPERGAME_SVR_CONNETER_	2
#define _CHECKNAME_SVR_CONNETER_	3
#define _LOG_SVR_CONNETER_			4

wchar_t* timetostr(time_t time1, wchar_t *szTime, int nLen, const wchar_t* sformat = L"%4.4d-%2.2d-%2.2d %2.2d:%2.2d:%2.2d")
{
	struct tm tm1;
	memset(&tm1, 0, sizeof(tm1));
	const sint32 ntlslen = 1024;
	static wchar_t ptlsbuf[ntlslen];

	localtime_s(&tm1, &time1);
	swprintf_s(ptlsbuf, ntlslen - 1, sformat, tm1.tm_year + 1900, tm1.tm_mon + 1, tm1.tm_mday, tm1.tm_hour, tm1.tm_min, tm1.tm_sec);
	ptlsbuf[ntlslen-1] = 0;

	if(szTime)
	{
		wcscpy_s(szTime, nLen, ptlsbuf);
	}

	return ptlsbuf;
}

/*************************************************************
* 说明 :
*************************************************************/
GameService::GameService( GXMISC::CGxServiceConfig* config, const std::string& serverName /*= "GxService"*/ )
	: CWndBase(config, serverName, WND_WIDTH, WND_HEIGHT*2, L"GameServiceWnd")
{
	size_t converted = 0;
	mbstowcs_s(&converted, m_szSvrName, serverName.size()+1, serverName.c_str(), _TRUNCATE);

	m_boAutoStart = false;
	m_timeshutdown = 0;
	m_forceclose = false;
	m_boStartService = false;
	m_boshutdown = false;
	m_svridx = 0;
	static wchar_t SvrMapsBuf[1024 * 56];
	LoadLocalConfig();
	wchar_t szTemp[MAX_PATH];
	wchar_t szruntime[20];
	timetostr(time(NULL), szruntime, 20);
#ifdef _GLOBAL_GAMESVR_
	swprintf_s(szTemp, MAX_PATH, L"GGS[%s : GlobalGameSvr](BuildTime: %s)-(RunTime: %s)", m_szSvrName, szruntime, szruntime);
#else
	swprintf_s(szTemp, MAX_PATH, L"GS[%s : GameSvr](BuildTime: %s)-(RunTime: %s)", m_szSvrName, szruntime, szruntime);
#endif
	SetTitle(szTemp);
}

HMODULE g_AutoCompleteh = 0;
GameService::~GameService()
{
	if(g_AutoCompleteh)
	{
		FreeLibrary(g_AutoCompleteh);
		g_AutoCompleteh = 0;
	}
}

unsigned int _random(unsigned int nMax, unsigned int nMin)
{
	static bool static_bosrand = false;
	if(!static_bosrand)
	{
		srand(GetTickCount());
		static_bosrand = true;
	}

	if(nMax > nMin)
	{
		int nr1 = ((rand() << 16) | rand());
		int nr2 = ((rand() << 16) | rand());
		unsigned int nmod = (nMax - nMin + 1);
		unsigned int nr = (abs(nr1 - nr2));
		return nmod == 0 ? nr : ((nr % nmod) + nMin);
	}
	else
	{
		return nMin;
	}
}
bool GameService::m_boStartService = false;

void GameService::StartService()
{

	if(m_boStartService)
	{
		return;
	}

	if(m_boStartService)
	{
	}
	else
	{
	}
}

void GameService::RefSvrRunInfo()
{
}

void GameService::ShutDown()
{
	if(m_boshutdown)
	{
		return;
	}

	if(!m_boStartService)
	{
		return;
	}

	m_boshutdown = true;
	StopService();
	SaveServerParam(0, 0);
	this->Processmsg();
	Sleep(2000);
}

void GameService::StopService()
{
	m_boStartService = false;
	SetLog(0, L"停止服务成功...");
}

bool GameService::LoadLocalConfig()
{
	return true;
}

class CWndLog : public GXMISC::CStdDisplayer
{
public:
	CWndLog (bool needDeleteByLog = false, const char *displayerName = "", bool raw = false) 
		: GXMISC::CStdDisplayer(needDeleteByLog, displayerName, raw){}

	CWndLog (bool needDeleteByLog) : GXMISC::CStdDisplayer(needDeleteByLog){}
	~CWndLog (){}

public:
	virtual void doDisplay( const GXMISC::CLogger::TDisplayInfo& args, const char *message )
	{
		size_t converted = 0;
		wchar_t msg[1024];
		memset(msg, 0, sizeof(msg));
		mbstowcs_s(&converted, msg, strlen(message), message, _TRUNCATE);
		m_pGameService->SetLog(0, msg);
	}

 	void setGameService(GameService* pGameService)
 	{
 		m_pGameService = pGameService;
 	}

protected:
	GameService* m_pGameService;
};

bool GameService::OnInit()
{
	LoadLocalConfig();

	CWndLog* dis = new CWndLog();
	dis->setGameService(this);
	addLogger(dis);

	if(m_boAutoStart)
	{
		if(!OnStartService())
		{
			return false;
		}
	}

	return true;
}

void GameService::OnIdle()
{
	if(m_boStartService)
	{
		loop(0);
	}
}

void GameService::OnQueryClose(bool& boClose)
{
	if(m_boStartService)
	{
		boClose = false;
	}
	else
	{
		return;
	}

	if(m_boshutdown)
	{
		return;
	}

	this->OnStopService();
}

void GameService::OnUninit()
{
}

bool GameService::OnStartService()
{
	StartService();

	/*
	if (false == load(GetServerName())) {
		SetLog(0, L"加载配置失败!");
		return true;
	}
	SetLog(0, L"加载配置成功!");

	if (false == init()) {
		SetLog(0, L"初始化服务器失败!");
		return true;
	}
	SetLog(0, L"初始化服务器成功!");

	if (false == start()) {
		SetLog(0, L"开启服务失败!");
		return true;
	}
	SetLog(0, L"开启服务成功!");
	*/

	m_boStartService = true;
	if(m_boStartService)
	{
		EnableCtrl(false);
	}

	return true;
}

void GameService::OnStopService()
{
	if(m_forceclose || (MessageBox(0, L"你确定要关闭 游戏服务器 么?", L"警告", MB_OKCANCEL | MB_DEFBUTTON2) == IDOK))
	{
		if(!m_forceclose)
		{
		//	g_logger.forceLog(zLogger::zINFO, "服务器执行手动关闭任务");
		}

		ShutDown();

		if(!m_boStartService)
		{
			EnableCtrl(true);
		}

		this->Close();
	}
}

void GameService::OnConfiguration()
{
	SetLog(0, L"重新加载配置文件...");
}

long GameService::OnTimer(int nTimerID)
{
	return 0;
}

bool GameService::OnCommand(char* szCmd)
{
	size_t converted = 0;
	wchar_t msg[1024];
	memset(msg, 0, sizeof(msg));
	mbstowcs_s(&converted, msg, strlen(szCmd)+1, szCmd, _TRUNCATE);

	SetLog(0, L"服务器管理员执行GM命令:%s", msg);

	return true;
}

long GameService::OnCommand(int nCmdID)
{
	switch(nCmdID)
	{
	case IDM_STARTSERVICE:
		OnStartService();
		break;
	case IDM_STOPSERVICE:
		OnStopService();
		break;
	case IDM_CONFIGURATION:
		OnConfiguration();
		break;
	case IDM_CLEARLOG:
		OnClearLog();
		break;
	case IDM_DEBUGINFO:
		RefSvrRunInfo();
		break;
	case IDM_EXIT:
		OnExit();
		break;
	}

	return 0;
}

bool InitToolbar(HWND hWndParent, HINSTANCE hInstance, int& btnCount, HWND& wndToolbar)
{
	TBBUTTON tbBtns[] =
	{
		{0, IDM_STARTSERVICE, TBSTATE_ENABLED, TBSTYLE_BUTTON},
		{1, IDM_STOPSERVICE,  TBSTATE_ENABLED, TBSTYLE_BUTTON},
	};
	int nBtnCnt = sizeof(tbBtns) / sizeof(tbBtns[0]);

	wndToolbar = CreateToolbarEx(hWndParent, WS_CHILD | WS_VISIBLE | WS_BORDER,
		IDC_TOOLBAR, nBtnCnt, hInstance, IDB_TOOLBAR,
		(LPCTBBUTTON) &tbBtns, nBtnCnt, 16, 16, 16, 16, sizeof(TBBUTTON));
	btnCount = nBtnCnt;

	return wndToolbar ? true : false;
}

HWND InitCmdEdit(HWND hWndParent, HINSTANCE hInstance, int nBtnCnt, int width, CWndBase* pBase)
{
	HWND cmdEdit = CreateWindow(WC_EDIT, L"", WS_CHILD | WS_VISIBLE | ES_WANTRETURN,
		nBtnCnt * (16 + 8) + 16, 3, width - (nBtnCnt * (16 + 8)), 19, hWndParent, 0, hInstance, NULL);

	
//	HWND cmdEdit = CreateWindow(WC_COMBOBOX, L"DROPDOWNLIST",
//        WS_CHILD|WS_VISIBLE|WS_VSCROLL|CBS_DROPDOWN,
//        nBtnCnt * (16 + 8) + 16, 3, 300, 25, hWndParent, 0, hInstance, NULL);


	return cmdEdit;
}

bool GameService::CreateToolbar()
{
	int btnCount = 0;
	if(!InitToolbar(m_hWnd, m_hInstance, btnCount, m_hWndToolbar))
	{
		return false;
	}
	m_hCmdEdit = InitCmdEdit(m_hWndToolbar, m_hInstance, btnCount, m_nwidth, this);

	SetWindowLongPtr(m_hCmdEdit, GWLP_USERDATA, (LONG_PTR)this);
	m_EditMsgProc = (WNDPROC)SetWindowLongPtr(m_hCmdEdit, GWLP_WNDPROC, (LONG_PTR)WinProc);

	return m_hCmdEdit ? true : false;
}

bool GameService::Init(HINSTANCE hInstance)
{
	INITCOMMONCONTROLSEX InitCtrlEx;
	InitCommonControlsEx(&InitCtrlEx);

	m_hInstance = hInstance;

	if(!CreateWnd() || !CreateToolbar() || !CreateList() || !CreateStatus())
		return false;

	int   pos[   4   ] = {   300,   480,  620,  -1   };   //   100,   200,   300   为间隔
	::SendMessage(m_hWndStatus,   SB_SETPARTS, (WPARAM)4, (LPARAM)pos);
	EnableCtrl(true);
	ShowWindow(m_hWnd, SW_SHOWDEFAULT);

	if(!OnInit()){
		return false;
	}

	return true;
}

void GameService::OnClearLog()
{
	__super::OnClearLog();
}

void GameService::EnableCtrl(bool bEnableStart)
{
	HMENU hMenu = GetSubMenu(GetMenu(m_hWnd), 0);

	if(bEnableStart)
	{
		EnableMenuItem(hMenu, IDM_STARTSERVICE,	MF_ENABLED | MF_BYCOMMAND);
		EnableMenuItem(hMenu, IDM_STOPSERVICE,		MF_GRAYED  | MF_BYCOMMAND);
		EnableMenuItem(hMenu, IDM_CONFIGURATION,	MF_ENABLED | MF_BYCOMMAND);
		SendMessage(m_hWndToolbar, TB_SETSTATE, IDM_STARTSERVICE,
		            (LPARAM) MAKELONG(TBSTATE_ENABLED, 0));
		SendMessage(m_hWndToolbar, TB_SETSTATE, IDM_STOPSERVICE,
		            (LPARAM) MAKELONG(TBSTATE_INDETERMINATE, 0));
	}
	else
	{
		EnableMenuItem(hMenu, IDM_STARTSERVICE,	MF_GRAYED  | MF_BYCOMMAND);
		EnableMenuItem(hMenu, IDM_STOPSERVICE,		MF_ENABLED | MF_BYCOMMAND);
		EnableMenuItem(hMenu, IDM_CONFIGURATION,	MF_GRAYED  | MF_BYCOMMAND);
		SendMessage(m_hWndToolbar, TB_SETSTATE, IDM_STARTSERVICE,
		            (LPARAM) MAKELONG(TBSTATE_INDETERMINATE, 0));
		SendMessage(m_hWndToolbar, TB_SETSTATE, IDM_STOPSERVICE,
		            (LPARAM) MAKELONG(TBSTATE_ENABLED, 0));
	}
}

bool GameService::SaveServerParam( int naddtime, int nadditemid )
{
	return true;
}

void GameService::SetAutoStart( bool flag /*= true*/ )
{
	m_boAutoStart = flag;
}

//void OnCreateInstance(CWndBase *&pWnd)
//{
//	pWnd = GameService::GetPtrInstance();
//}

int OnDestroyInstance(CWndBase *pWnd)
{
	return 0;
}

#endif