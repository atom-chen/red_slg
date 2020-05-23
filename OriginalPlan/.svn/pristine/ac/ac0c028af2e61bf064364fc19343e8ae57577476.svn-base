#include "stdcore.h"
#include "types_def.h"
#include "debug.h"
#include "path.h"
#include "win_thread.h"
#include "common.h"
#include "lib_init.h"
#include "game_exception.h"

#ifdef OS_WINDOWS
#include <typeinfo>

namespace GXMISC
{
	__declspec(thread) static DWORD TLSThreadPointer = 0xffffffff;

	IThread *IThread::create (IRunnable *runnable, uint32 stackSize)
	{
		return new CWinThread (runnable, stackSize);
	}

	IThread *IThread::getCurrentThread ()
	{
		// TLS 分配必须已经完成
		gxAssert (TLSThreadPointer != 0xffffffff);
		IThread *thread = (IThread*)TlsGetValue (TLSThreadPointer);
		return thread;
	}

	static unsigned long __stdcall ProxyFunc (void *arg)
	{
		CWinThread *parent = (CWinThread *) arg;
		gxAssert(TLSThreadPointer == 0xffffffff);
		TLSThreadPointer = TlsAlloc();
		gxAssert (TLSThreadPointer != 0xffffffff);
		TlsSetValue (TLSThreadPointer, (void*)parent);
		parent->getRunnable()->run();

		return 0;
	}

	CWinThread::CWinThread (IRunnable *runnable, uint32 stackSize)
	{
		_stackSize = stackSize;
		this->_runnable = runnable;
		_threadHandle = NULL;
		_suspendCount = -1;
		_mainThread = false;
	}

	CWinThread::CWinThread (void* threadHandle, uint32 threadId)
 	{
		// 主线程
		_mainThread = true;
		this->_runnable = NULL;
		_threadHandle = threadHandle;
		_threadId = threadId;

		TLSThreadPointer = TlsAlloc ();
		gxAssert (TLSThreadPointer!=0xffffffff);
		TlsSetValue (TLSThreadPointer, (void*)this);
		if (::GetCurrentThreadId() == threadId)
		{
			_suspendCount = 0;
		}
		else
		{
			// 此处代码不应该发生的
			gxAssert(0);
			CRITICAL_SECTION cs;
			InitializeCriticalSection(&cs);
			EnterCriticalSection(&cs);
			SuspendThread(threadHandle);
			_suspendCount = ResumeThread(threadHandle);
			LeaveCriticalSection(&cs);
			DeleteCriticalSection(&cs);
		}
	}


	sint32 CWinThread::incSuspendCount()
	{
		gxAssert(_threadHandle); 
		int newSuspendCount = ::SuspendThread(_threadHandle) + 1;
		gxAssert(newSuspendCount != 0xffffffff);
		gxAssert(newSuspendCount == _suspendCount + 1);

		_suspendCount = newSuspendCount;
		return _suspendCount;
	}

	sint32 CWinThread::decSuspendCount()
	{
		gxAssert(_threadHandle);
		gxAssert(_suspendCount > 0);
		int newSuspendCount = ::ResumeThread(_threadHandle) - 1;
		gxAssert(newSuspendCount != 0xffffffff);
		gxAssert(newSuspendCount == _suspendCount - 1);

		_suspendCount = newSuspendCount;
		return _suspendCount;
	}
	
	sint32 CWinThread::getSuspendCount() const
	{
		return _suspendCount; 
	}

	void CWinThread::suspend()
	{
		if (getSuspendCount() == 0)
		{
			incSuspendCount();
		}
	}

	void CWinThread::resume()
	{
		while (getSuspendCount() != 0)
		{
			decSuspendCount();
		}
	}

	void CWinThread::setPriority(int priority)
	{
		gxAssert(_threadHandle);
		BOOL result = SetThreadPriority(_threadHandle, priority);
		gxAssert(result);
	}

	void CWinThread::enablePriorityBoost(bool enabled)
	{
		gxAssert(_threadHandle);
		SetThreadPriorityBoost(_threadHandle, enabled ? true : FALSE);
	}


	CWinThread::~CWinThread ()
	{
		if (_mainThread)
		{
			//gxAssert (TLSThreadPointer!=0xffffffff);
			if (TLSThreadPointer != 0xffffffff)
			{
				TlsFree(TLSThreadPointer);
			}
		}
		else
		{
			if (_threadHandle != NULL)
			{
				terminate();
			}
		}
	}

	bool CWinThread::start ()
	{
		THREAD_TRY ;
		_threadHandle = (void *) ::CreateThread (NULL, 0, ProxyFunc, this, 0, (DWORD *)&_threadId);
		if (_threadHandle == NULL)
		{
			return false;
		}
		SetThreadPriorityBoost (_threadHandle, true);
		_suspendCount = 0;
		return true;
		THREAD_CATCH ;
		_suspendCount = 0;
		return false;
	}

	bool CWinThread::isRunning()
	{
		if (_threadHandle == NULL)
			return false;

		DWORD exitCode;
		if (!GetExitCodeThread(_threadHandle, &exitCode))
			return false;

		return exitCode == STILL_ACTIVE;
	}


	void CWinThread::terminate ()
	{
		TerminateThread((HANDLE)_threadHandle, 0);
		CloseHandle((HANDLE)_threadHandle);
		_threadHandle = NULL;
		_suspendCount = -1;
	}

	void CWinThread::wait ()
	{
		// @TODO 加上解释
		if (_threadHandle == NULL) return;

		WaitForSingleObject(_threadHandle, INFINITE);
		CloseHandle(_threadHandle);
		_threadHandle = NULL;
		_suspendCount = -1;
	}

	bool CWinThread::setCPUMask(TBit64_t cpuMask)
	{
		if (_threadHandle == NULL)
		{
			return false;
		}

		return SetThreadAffinityMask ((HANDLE)_threadHandle, (DWORD_PTR)cpuMask) != 0;
	}

	TBit64_t CWinThread::getCPUMask()
	{
		if (_threadHandle == NULL)
		{
			return 1;
		}

		TBit64_t mask=IProcess::GetCurrentProcess ()->getCPUMask ();
		DWORD_PTR old = SetThreadAffinityMask ((HANDLE)_threadHandle, (DWORD_PTR)mask);
		gxAssert (old != 0);
		if (old == 0)
		{
			return 1;
		}
		SetThreadAffinityMask ((HANDLE)_threadHandle, old);
		return (TBit64_t)old;
	}

	std::string CWinThread::getUserName()
	{
		char userName[512];
		DWORD size = 512;
		GetUserNameA(userName, &size); // @TODO UNICODE
		return (const char*)userName;
	}

	IRunnable * CWinThread::getRunnable()
	{
		return _runnable;
	}

	CWinProcess CurrentProcess ((void*)GetCurrentProcess());
	IProcess *IProcess::GetCurrentProcess ()
	{
		return &CurrentProcess;
	}

	uint32 IProcess::GetCPUNum()
	{
		typedef void (WINAPI *PGNSI)(LPSYSTEM_INFO);
		SYSTEM_INFO si;
		PGNSI pfnGNSI = (PGNSI) GetProcAddress(GetModuleHandleA(("kernel32.dll")), "GetNativeSystemInfo"); // @TODO UNICODE
		if(pfnGNSI)
		{
			pfnGNSI(&si);
		}
		else
		{
			GetSystemInfo(&si);
		}
		return si.dwNumberOfProcessors;
	}

	CWinProcess::CWinProcess (void *handle)
	{
		_processHandle = handle;
	}

	TBit64_t CWinProcess::getCPUMask()
	{
		DWORD_PTR processAffinityMask;
		DWORD_PTR systemAffinityMask;
		if (GetProcessAffinityMask((HANDLE)_processHandle, &processAffinityMask, &systemAffinityMask))
		{
			return (TBit64_t)processAffinityMask;
		}
		else
		{
			return 1;
		}
	}

	bool CWinProcess::setCPUMask(TBit64_t mask)
	{
		DWORD_PTR processAffinityMask= (DWORD_PTR)mask;
		return SetProcessAffinityMask((HANDLE)_processHandle, processAffinityMask)!=0;
	}

    // 进程函数共享库
    class CPSAPILib
    {
    public:
        typedef BOOL  (WINAPI *EnumProcessesFunPtr)(DWORD *lpidProcess, DWORD cb, DWORD *cbNeeded);
        typedef DWORD (WINAPI *GetModuleFileNameExAFunPtr)(HANDLE hProcess, HMODULE hModule, LPTSTR lpFilename, DWORD nSize);
        typedef BOOL  (WINAPI *EnumProcessModulesFunPtr)(HANDLE hProcess, HMODULE *lphModule, DWORD cb, LPDWORD lpcbNeeded);
        EnumProcessesFunPtr			EnumProcesses;
        GetModuleFileNameExAFunPtr	GetModuleFileNameExA;
        EnumProcessModulesFunPtr	EnumProcessModules;
    public:
        CPSAPILib();
        ~CPSAPILib();
        bool init();
    private:
        HINSTANCE _PSAPILibHandle;
        bool	  _LoadFailed;
    };

	CPSAPILib::CPSAPILib()
	{
		_LoadFailed = false;
		_PSAPILibHandle     = NULL;
		EnumProcesses       = NULL;
		GetModuleFileNameExA = NULL;
		EnumProcessModules  = NULL;
	}

	CPSAPILib::~CPSAPILib()
	{
		if (_PSAPILibHandle)
		{
			FreeLibrary(_PSAPILibHandle);
		}
	}

	bool CPSAPILib::init()
	{
		if (_LoadFailed)
		{
			return false;
		}
		if (!_PSAPILibHandle)
		{
			_PSAPILibHandle = LoadLibraryA("psapi.dll"); // @TODO UNICODE
			if (!_PSAPILibHandle)
			{
				gxWarning("couldn't load psapi.dll, possibly not supported by os");
				_LoadFailed = true;
				return false;
			}
			EnumProcesses		= (EnumProcessesFunPtr)		  GetProcAddress(_PSAPILibHandle, "EnumProcesses");
			GetModuleFileNameExA = (GetModuleFileNameExAFunPtr) GetProcAddress(_PSAPILibHandle, "GetModuleFileNameExA");
			EnumProcessModules  = (EnumProcessModulesFunPtr)  GetProcAddress(_PSAPILibHandle, "EnumProcessModules");
			if (!EnumProcesses ||
				!GetModuleFileNameExA ||
				!EnumProcessModules
				)
			{
				gxWarning("Failed to import functions from psapi.dll!");
				_LoadFailed = true;
				return false;
			}
		}
		return true;
	}
    
    static CPSAPILib PSAPILib;

	bool CWinProcess::EnumProcessesId(std::vector<uint32> &processesId)
	{
		if (!PSAPILib.init())
		{
			return false;
		}
		std::vector<uint32> prcIds(16);
		for (;;)
		{
			DWORD cbNeeded;
			if (!PSAPILib.EnumProcesses((DWORD *) &prcIds[0], (DWORD)(prcIds.size() * sizeof(DWORD)), &cbNeeded))
			{
				gxWarning("Processes enumeration failed!");
				return false;
			}
			if (cbNeeded < prcIds.size() * sizeof(DWORD))
			{
				prcIds.resize(cbNeeded / sizeof(DWORD));
				break;
			}
			prcIds.resize(prcIds.size() * 2);
		}
		processesId.swap(prcIds);
		return true;
	}

	bool CWinProcess::EnumProcessModules(uint32 processId, std::vector<std::string> &moduleNames)
	{
		if (!PSAPILib.init()) return false;
		HANDLE hProcess = OpenProcess(PROCESS_QUERY_INFORMATION|PROCESS_VM_READ, FALSE, (DWORD) processId);
		if (!hProcess) return false;

		// 枚举模块
		std::vector<HMODULE> prcModules(2);
		for (;;)
		{
			DWORD cbNeeded;
			if (!PSAPILib.EnumProcessModules(hProcess, (HMODULE *) &prcModules[0], (DWORD)(prcModules.size() * sizeof(HMODULE)), &cbNeeded))
			{
				gxWarning("Processe modules enumeration failed!");
				return false;
			}
			if (cbNeeded < prcModules.size() * sizeof(HMODULE))
			{
				prcModules.resize(cbNeeded / sizeof(HMODULE));
				break;
			}
			prcModules.resize(prcModules.size() * 2);
		}
		moduleNames.clear();
		std::vector<std::string> resultModuleNames;
		//char moduleName[MAX_PATH + 1]; // @TODO UNICODE
		for (uint32 m = 0; m < prcModules.size(); ++m)
		{
// 			if (PSAPILib.GetModuleFileNameExA(hProcess, prcModules[m], moduleName, MAX_PATH)) // @TODO UNICODE, 这里代码暂时无法修改
// 			{
// 				moduleNames.push_back(moduleName);
// 			}
		}
		CloseHandle(hProcess);
		return true;
	}

	uint32 CWinProcess::GetProcessIdFromModuleFilename(const std::string &moduleFileName)
	{
		std::vector<uint32> processesId;
		if (!EnumProcessesId(processesId)) return false;
		std::vector<std::string> moduleNames;
		for (uint32 prc = 0; prc < processesId.size(); ++prc)
		{
			if (EnumProcessModules(processesId[prc], moduleNames))
			{
				for (uint32 m = 0; m < moduleNames.size(); ++m)
				{
					if (gxStricmp(CFile::GetFilename(moduleNames[m]), moduleFileName) == 0)
					{
						return processesId[prc];
					}
				}
			}
		}
		return 0;
	}

	bool CWinProcess::TerminateProcess(uint32 processId, uint32 exitCode)
	{
		if (!processId) return false;
		HANDLE hProcess = OpenProcess(PROCESS_TERMINATE, FALSE, (DWORD) processId);
		if (!hProcess) return false;
        BOOL ok = ::TerminateProcess(hProcess, (uint32) exitCode);
		CloseHandle(hProcess);
		return ok != FALSE;
	}

	bool CWinProcess::TerminateProcessFromModuleName(const std::string &moduleName, uint32 exitCode)
	{
		return TerminateProcess(GetProcessIdFromModuleFilename(moduleName), exitCode);
	}

}	// GXMISC

#endif // OS_WINDOWS
