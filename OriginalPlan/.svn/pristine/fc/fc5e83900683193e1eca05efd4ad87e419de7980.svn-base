#ifndef __WND_BASE_H__
#define __WND_BASE_H__

#include "core/types_def.h"
#include "core/base_util.h"
#include "core/service.h"

#ifdef OS_WIN

#pragma comment( lib, "comctl32.lib" )

#include <commctrl.h>
#include <winuser.h>
#include <stdio.h>

#define UM_SETLOG	WM_USER + 1250
#define UM_SETSTATUS	WM_USER + 1251

#define WND_WIDTH	320*2
#define WND_HEIGHT	240
#define MAX_LISTITEMCOUMT	500

struct LISTDATA
{
	long crFont;
};

struct SETLOGPARAM
{
	int		 nFontColor;
	wchar_t	 szDate[32];
	wchar_t	 szText[1024];
};

template < class _Ty, class _Ax = std::allocator<_Ty> >
class CSyncVector : public std::vector< _Ty, _Ax >
{
public:
	typedef std::vector< _Ty, _Ax > tbase;
};

class CWndBase : public GXMISC::GxService
{
public:
	CWndBase(GXMISC::CGxServiceConfig* config, const std::string& serverName = "GxService", int width = WND_WIDTH, int height = WND_HEIGHT, const wchar_t* wndClassName = L"CLD_WNDBASE", bool ismainwindow = true);
	virtual ~CWndBase();

public:
	virtual bool CreateWnd();
	virtual bool CreateList();
	virtual bool CreateStatus();
	void ListDrawItem(DRAWITEMSTRUCT *pDIS, LISTDATA *pData, int nSubItem);
	virtual bool onBeforeInstance(std::vector<std::string>& args);
public:
	static LRESULT CALLBACK WinProc(HWND hWnd, UINT nMsg, WPARAM wParam, LPARAM lParam);
	static LRESULT CALLBACK CbEditProc(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);

	virtual bool Init(HINSTANCE hInstance) = 0;
	int Run();
	void Processmsg();
	void Uninit();
	void Close();
	virtual void SetLog(int nFontColor, const wchar_t *pMsg, ...);
	virtual void SetErr(int nErrCode);
	void __cdecl SetStatus(int nStatindex , const wchar_t *pMsg, ...);
	UINT_PTR CreateTimer(int nTimerID, int nTime);
	bool FreeTimer(int nTimerID);
	void ListClearAll();
	LISTDATA * ListGetItemData(int nItem);

public:
	virtual long OnCreate();
	virtual long OnSize(int nWidth, int nHeight);
	virtual long OnDrawItem(WPARAM nCtlID, DRAWITEMSTRUCT *pDIS);
	virtual long OnCommand(int nCmdID) = 0;
	virtual bool OnCommand(char* szCmd){ return true; }
	virtual long OnTimer(WPARAM nTimerID);
	virtual void OnQueryClose(bool& boClose) {};
	virtual long OnDestroy();
	virtual long OnSetLog(SETLOGPARAM *pParam);
	virtual long OnSetStatus(WPARAM nIdx, const char* pMsg);
	virtual void OnIdle() {};
	virtual bool OnInit(){ return true;}
	virtual void OnUninit()			{}
	virtual bool OnStartService()	{ return true; }
	virtual void OnStopService()	{}
	virtual void OnConfiguration()	{}
	virtual void OnClearLog(){ ListClearAll(); }
	virtual void OnExit(){ PostMessage(m_hWnd, WM_CLOSE, 0, 0); }
	virtual const char* GetServerName(){ return "DefaultServer"; }

public:
	void SetTitle(const wchar_t* szTitle);
	wchar_t* GetTitle();

protected:
	CSyncVector< SETLOGPARAM > m_logparamarray;
	CSyncVector< LISTDATA >	m_listdataary;
	int						m_currlogparamidx;
	wchar_t					m_szStatus[32][32*3];
	int						m_currlistdataidx;
	const int				m_nwidth;
	const int				m_nheight;
	const wchar_t*				m_wndClassName;
	WNDPROC					m_ListViewMsgProc;
	WNDPROC					m_EditMsgProc;
	wchar_t 				m_pTitle[32*6];
	MSG						m_msg;
	bool					m_ismainwindow;

	HINSTANCE	m_hInstance;
	HWND		m_hWnd;
	HWND		m_hWndToolbar, m_hCmdEdit, m_hWndList, m_hWndStatus;
};

void		OnCreateInstance(CWndBase *&pWnd);
int			OnDestroyInstance(CWndBase *pWnd);

#define NOT_USEWNDBASE		int __mymain(HMODULE hModule,const char* pcommon);	\
	void OnCreateInstance (CWndBase *&pWnd){ pWnd=NULL;}	\
	int	OnDestroyInstance( CWndBase *pWnd ){return __mymain(::GetModuleHandle(NULL),::GetCommandLine());}

#endif

#endif // __WND_BASE_H__