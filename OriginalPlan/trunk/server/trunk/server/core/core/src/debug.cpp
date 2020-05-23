#include "debug.h"
#include "logger.h"
#include "displayer.h"
#include "path.h"

#ifdef OS_WINDOWS
#	define _WIN32_WINDOWS	0x0410
#	define WINVER			0x0400
#	include <direct.h>
#	include <tchar.h>
#	include <imagehlp.h>
#   include <excpt.h>
#	pragma comment(lib, "imagehlp.lib")
#	define getcwd(_a, _b) (_getcwd(_a,_b))
#	ifdef OS_WIN64
#		define DWORD_TYPE DWORD64
#	else
#		define DWORD_TYPE DWORD
#	endif // OS_WIN64
#elif defined OS_UNIX
#	include <unistd.h>
#	define IsDebuggerPresent() false
#	include <execinfo.h>
#	include <errno.h>
#   include "google/coredumper.h"
#endif

using namespace std;

namespace GXMISC
{
    static bool DumpFlag = false;

#ifdef LIB_DEBUG
    void gxLogAssertEx(bool exp, CLogger* lg, const char* module, const char* file, uint32 line, const char* func, const char* str, ...)
    {
        {
            do {
                bool _expResult = !(exp) ? true : false;
                if(_expResult)
                {
                    DConvertVargs(msg, str, GXMISC::MAX_CSTRING_SIZE);
                    GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_ASSERT, __LINE__, __FILE__, __FUNCTION__, module, msg); 
                    GXMISC_BREAKPOINT;
                } 
            } while(0);
        }
    }

    void gxLogAssertExOnce(bool exp, CLogger* lg, const char* module, const char* file, uint32 line, const char* func, const char* str, ...) 
    {
        do 
        {
            bool _expResult = !(exp) ? true : false;
            if(_expResult) 
            {  
                DConvertVargs(msg, str, GXMISC::MAX_CSTRING_SIZE); 
                GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_ASSERT, __LINE__, __FILE__, __FUNCTION__, module, msg);
                GXMISC_BREAKPOINT;
            }  
        } while(0);
    }

	void _gxLogAssertEx(bool exp, CLogger* lg, const char* module, const char* file, uint32 line, const char* func, const char* str)
    {
        {
            do {
                bool _expResult = !(exp) ? true : false;
                if(_expResult)
                {
                    GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_ASSERT, line, file, func, module, str); 
                    GXMISC_BREAKPOINT;
                } 
            } while(0);
        }
    }

    void _gxLogAssertExOnce(bool exp, CLogger* lg, const char* module, const char* file, uint32 line, const char* func, const char* str) 
    {
        do 
        {
            bool _expResult = !(exp) ? true : false;
            if(_expResult) 
            {  
                GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_ASSERT, line, file, func, module, str);
                GXMISC_BREAKPOINT;
            }  
        } while(0);
    }
#endif

#ifdef LIB_DEBUG
    void _gxLogDebug(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ...)
    {
        do 
        {
            DConvertVargs(msg, fmt, GXMISC::MAX_CSTRING_SIZE);
            GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_DEBUG, line, file, func, module, msg);
        } while (false);
    }
    void _gxLogDbgWarning(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ...)
    {
        do 
        {
            DConvertVargs(msg, fmt, GXMISC::MAX_CSTRING_SIZE);
            GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_WARNING, line, file, func, module, msg);
        } while (false);
    }
#endif  // LIB_DEBUG
   
    void _gxLogInfo(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ...)
    {
        do 
        {
            DConvertVargs(msg, fmt, GXMISC::MAX_CSTRING_SIZE);
            GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_INFO, line, file, func, module, msg);
        } while (false);
    }

    void _gxLogWarning(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ...)
    {
        do 
        {
            DConvertVargs(msg, fmt, GXMISC::MAX_CSTRING_SIZE);
            GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_WARNING, line, file, func, module, msg);
        } while (false);
    }

    // @todo 加上堆栈
    void _gxLogError(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ...)
    {
        do 
        {
            DConvertVargs(msg, fmt, GXMISC::MAX_CSTRING_SIZE);
            GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_ERROR, line, file, func, module, msg);
        } while (false);
    }
    void _gxLogErrorEx(CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ...)
    {
        do 
        {
            DConvertVargs(msg, fmt, GXMISC::MAX_CSTRING_SIZE);
            GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_ERROR, line, file, func, module, msg);
            gxExit(EXIT_CODE_LOG_ERREX);
        } while (false);
    }

    void _gxLogStat( CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ... )
    {
        do 
        {
            DConvertVargs(msg, fmt, GXMISC::MAX_CSTRING_SIZE);
            GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_STAT, line, file, func, module, msg);
        } while (false);
    }

	void _gxLogGm( CLogger* lg, const char* file, uint32 line, const char* func, const char* module, const char* fmt, ... )
	{
		do 
		{
			DConvertVargs(msg, fmt, GXMISC::MAX_CSTRING_SIZE);
			GXMISC::gxLog(false, lg, GXMISC::CLogger::LOG_GM, line, file, func, module, msg);
		} while (false);
	}

    /// Return the last error code generated by a system call
	uint32 gxGetLastError()
    {
#ifdef OS_WINDOWS
        return GetLastError();
#else
        return errno;
#endif
    }

    /// Return a readable text according to the error code submited
    std::string gxFormatErrorMessage(int errorCode)
    {
#ifdef OS_WINDOWS
        LPVOID lpMsgBuf;
        FormatMessage(
            FORMAT_MESSAGE_ALLOCATE_BUFFER |
            FORMAT_MESSAGE_FROM_SYSTEM |
            FORMAT_MESSAGE_IGNORE_INSERTS,
            NULL,
            errorCode,
            MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
            (LPTSTR) &lpMsgBuf,
            0,
            NULL
            );

        string ret = (char*)lpMsgBuf;
        // Free the buffer.
        LocalFree( lpMsgBuf );

        return ret;
#else
        return strerror(errorCode);
#endif
    }

    /*
    * Display the bits (with 0 and 1) composing a byte (from right to left)
    */
    void gxDisplayByteBits( uint8 b, uint32 nbits, sint32 beginpos, bool displayBegin, GXMISC::CLogger *log )
    {
        string s1, s2;
        sint32 i;
        for ( i=nbits-1; i!=-1; --i )
        {
            s1 += ( (b >> i) & 1 ) ? '1' : '0';
        }
        log->displayRawGX( "%s", s1.c_str() );
        if ( displayBegin )
        {
            for ( i=nbits; i>beginpos+1; --i )
            {
                s2 += " ";
            }
            s2 += "^";
            log->displayRawGX( "%s beginpos=%u", s2.c_str(), beginpos );
        }
    }

    /*
    * Display the bits (with 0 and 1) composing a number (uint32) (from right to left)
    */
    void gxDisplayDwordBits( uint32 b, uint32 nbits, sint32 beginpos, bool displayBegin, GXMISC::CLogger *log )
    {
        string s1, s2;
        sint32 i;
        for ( i=nbits-1; i!=-1; --i )
        {
            s1 += ( (b >> i) & 1 ) ? '1' : '0';
        }
        log->displayRawGX( "%s", s1.c_str() );
        if ( displayBegin )
        {
            for ( i=nbits; i>beginpos+1; --i )
            {
                s2 += " ";
            }
            s2 += "^";
            log->displayRawGX( "%s beginpos=%u", s2.c_str(), beginpos );
        }
    }
	
	void gxLog(bool isOnce, CLogger* lg, CLogger::ELogType logType, sint32 line, const char *file, const char *funcName, const char* module, const char *msg)
	{
		if(gxIsFastLogThread())
        {
            // 快速记录日志的线程则直接写入, 一般为主线程
            lg->setPosition(logType, isOnce, line, file, funcName, module, false);
            lg->displayGX(msg);
        }
        else
        {
#ifndef LIB_DEBUG
            char buf[GXMISC::MAX_CSTRING_SIZE];
            memset(buf, 0, GXMISC::MAX_CSTRING_SIZE);
            sprintf(buf, "%s %s %s %s %s %d %s : %s", IDisplayer::DateToHumanString(), IDisplayer::LogTypeToString(logType), IDisplayer::IsSyncString(true), gxToString("%08x", gxGetThreadID()).c_str(), CFile::GetFilename(file).c_str(), line, funcName, module);
            std::string str = buf;
            str += msg;
            str += "\n";
            lg->synLog(str);
#else
            lg->setPosition(logType, isOnce, line, file, funcName, module, true);
            lg->displayGX(msg);
#endif
		}
	}

    // dump处理
#ifdef OS_WINDOWS
    /* can't include dbghelp.h */
	static LONG WINAPI DumpMiniDump(PEXCEPTION_POINTERS excpInfo)
	{
		if(DumpFlag)
		{
			return 0;
		}

		DumpFlag = true;

		HANDLE file = CreateFileA(gxGetDumpName().c_str(), GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL); // @TODO UNICODE
        if (file)
        {
            HMODULE hm = LoadLibraryA ("dbghelp.dll"); // @TODO UNICODE
            if (hm)
            {
				BOOL (WINAPI* MiniDumpWriteDump)(
					HANDLE hProcess,
					DWORD ProcessId,
					HANDLE hFile,
					MINIDUMP_TYPE DumpType,
					PMINIDUMP_EXCEPTION_INFORMATION ExceptionParam,
					PMINIDUMP_USER_STREAM_INFORMATION UserStreamParam,
					PMINIDUMP_CALLBACK_INFORMATION CallbackParam
					) = NULL;

				*(FARPROC*)&MiniDumpWriteDump = GetProcAddress(hm, "MiniDumpWriteDump");
				if (MiniDumpWriteDump)
				{
					MINIDUMP_EXCEPTION_INFORMATION eInfo;
					eInfo.ThreadId = GetCurrentThreadId();
					eInfo.ExceptionPointers = excpInfo;
					eInfo.ClientPointers = FALSE;

					MiniDumpWriteDump(
						GetCurrentProcess(),
						GetCurrentProcessId(),
						file,
						MiniDumpWithFullMemory,
						excpInfo != 0? &eInfo : NULL,
						NULL,
						NULL);
				}
                else
                {
                    gxWarning ("Can't get proc MiniDumpWriteDump in dbghelp.dll");
                }
            }
            else
            {
                gxWarning ("Can't load dbghelp.dll");
            }
            CloseHandle (file);
        }
        else
        {
            gxWarning ("Can't create mini dump file");
        }

		gxWarning ("Create dump file!");
		gxExit(EXIT_CODE_CRASH);

        return 0;
    }

    LONG CrashHandler( ULONG code /*= GetExceptionCode()*/, EXCEPTION_POINTERS *pException /*= GetExceptionInformation()*/ )
    {
        DumpMiniDump(pException);
		exit(0);

        //return 0;
    }

#elif defined(OS_UNIX)	// OS_WINDOWS
    /** 所有的信号列表及说明
    01) SIGHUP
    02) SIGINT
    03) SIGQUIT
    04) SIGILL
    05) SIGTRAP
    06) SIGABRT
    07) SIGBUS
    08) SIGFPE
    09) SIGKILL
    10) SIGUSR1
    11) SIGSEGV
    12) SIGUSR2
    13) SIGPIPE
    14) SIGALRM
    15) SIGTERM
    17) SIGCHLD
    18) SIGCONT
    19) SIGSTOP
    20) SIGTSTP
    21) SIGTTIN
    22) SIGTTOU
    23) SIGURG
    24) SIGXCPU
    25) SIGXFSZ
    26) SIGVTALRM
    27) SIGPROF
    28) SIGWINCH
    29) SIGIO
    30) SIGPWR
    31) SIGSYS
    34) SIGRTMIN
    35) SIGRTMIN+1
    36) SIGRTMIN+2
    37) SIGRTMIN+3
    38) SIGRTMIN+4
    39) SIGRTMIN+5
    40) SIGRTMIN+6
    41) SIGRTMIN+7
    42) SIGRTMIN+8
    43) SIGRTMIN+9
    44) SIGRTMIN+10
    45) SIGRTMIN+11
    46) SIGRTMIN+12 
    47) SIGRTMIN+13
    48) SIGRTMIN+14
    49) SIGRTMIN+15
    50) SIGRTMAX-14
    51) SIGRTMAX-13
    52) SIGRTMAX-12
    53) SIGRTMAX-11
    54) SIGRTMAX-10
    55) SIGRTMAX-9
    56) SIGRTMAX-8
    57) SIGRTMAX-7
    58) SIGRTMAX-6
    59) SIGRTMAX-5
    60) SIGRTMAX-4
    61) SIGRTMAX-3
    62) SIGRTMAX-2
    63) SIGRTMAX-1
    64) SIGRTMAX
    */
    // @todo 处理dump生成
    static void SigHandler(int signo)
    {
		if(DumpFlag)
        {
            return;
        }

        DumpFlag = true;
        if(0 == WriteCoreDump(gxGetDumpName().c_str()))
        {
            std::cerr<<"write dump success!"<<std::endl;
        }
        else
        {
            std::cerr<<"write dump failed!"<<std::endl;
        }

      //  gxExit(EXIT_CODE_CRASH);
		exit(-1);
    }
    static void SetSignalHandle()
    {
        SystemCall::signal(SIGSEGV, SigHandler);
        SystemCall::signal(SIGFPE,  SigHandler);
        SystemCall::signal(SIGINT,  SigHandler);  
        SystemCall::signal(SIGTERM, SigHandler); 
        SystemCall::signal(SIGABRT, SigHandler);
        SystemCall::signal(SIGXFSZ, SigHandler);
    }
#endif  // OS_UNIX

    void gxSetDumpHandler()
    {
#ifdef OS_WINDOWS
        // 设置错误处理的安静模式
        // SetErrorMode(SEM_NOGPFAULTERRORBOX);
        SetUnhandledExceptionFilter(&DumpMiniDump);
#elif defined(OS_UNIX)
        SetSignalHandle();
#endif
    }

    std::string gxGetDumpName()
    {
        // 生成dump文件名
        static char cstime[25];
        time_t tt = time(NULL);
		tm tempTm;
		tm* tms = CTimeManager::LocalTime( (time_t*)&tt, &tempTm ) ;
        if (tms)
            strftime (cstime, 25, "%Y_%m_%d_%H_%M_%S", tms);
        else
            sprintf(cstime, "bad date %d", (uint32)tt);

        std::string fileName = DGxContext.getServerName()+"_" + cstime + ".dmp";
        return fileName;
    }

    class Exception : public std::exception
    {
    protected:
        std::string	_Reason;
    public:
        Exception();
        Exception(const std::string &reason);
        Exception(const char *format, ...);
        virtual ~Exception() throw() {}
        virtual const char	*what() const throw();
    };

    Exception::Exception() : _Reason("Unknown Exception")
    {
        //	gxInfo("Exception will be launched: {0}", _Reason);
    }

    Exception::Exception(const std::string &reason) : _Reason(reason)
    {
    }

    Exception::Exception(const char *format, ...)
    {
    }
    const char	*Exception::what() const throw()
    {
        return _Reason.c_str();
    }

    class ETrapDebug : public Exception
    {
    };

#ifdef OS_WINDOWS
    class EDebug : public ETrapDebug
    {
    public:

        EDebug() { _Reason = "Nothing about EDebug"; }

        ~EDebug () { }

        EDebug(EXCEPTION_POINTERS * pexp) : m_pexp(pexp) { gxAssert(pexp != 0); createWhat(); }
        EDebug(const EDebug& se) : m_pexp(se.m_pexp) { createWhat(); }

        void createWhat ()
        {
            string shortExc, longExc, subject;
            string addr, ext;
            ULONG_PTR skipNFirst = 0;
            _Reason = "";

            if (m_pexp == NULL)
            {
                _Reason = "Unknown exception, don't have context.";
            }
            else
            {
                switch (m_pexp->ExceptionRecord->ExceptionCode)
                {
                case EXCEPTION_ACCESS_VIOLATION          :
                    {
                        shortExc="Access Violation";
                        longExc="The thread attempted to read from or write to a virtual address for which it does not have the appropriate access";
                        ext = ", thread attempts to ";
                        ext += m_pexp->ExceptionRecord->ExceptionInformation[0]?"write":"read";
                        if (m_pexp->ExceptionRecord->ExceptionInformation[1])
                            ext += gxToString(" at 0x%X", (uint64)(m_pexp->ExceptionRecord->ExceptionInformation[1]));
                        else
                            ext += " at <NULL>";
                    }
                    break;
                case EXCEPTION_DATATYPE_MISALIGNMENT     : shortExc="Datatype Misalignment"; longExc="The thread attempted to read or write data that is misaligned on hardware that does not provide alignment. For example, 16-bit values must be aligned on 2-byte boundaries, 32-bit values on 4-byte boundaries, and so on"; break;
                case EXCEPTION_BREAKPOINT                : shortExc="Breakpoint"; longExc="A breakpoint was encountered"; break;
                case EXCEPTION_SINGLE_STEP               : shortExc="Single Step"; longExc="A trace trap or other single-instruction mechanism signaled that one instruction has been executed"; break;
                case EXCEPTION_ARRAY_BOUNDS_EXCEEDED     : shortExc="Array Bounds Exceeded"; longExc="The thread attempted to access an array element that is out of bounds, and the underlying hardware supports bounds checking"; break;
                case EXCEPTION_FLT_DENORMAL_OPERAND      : shortExc="Float Denormal Operand"; longExc="One of the operands in a floating-point operation is denormal. A denormal value is one that is too small to represent as a standard floating-point value"; break;
                case EXCEPTION_FLT_DIVIDE_BY_ZERO        : shortExc="Float Divide By Zero"; longExc="The thread attempted to divide a floating-point value by a floating-point divisor of zero"; break;
                case EXCEPTION_FLT_INEXACT_RESULT        : shortExc="Float Inexact Result"; longExc="The result of a floating-point operation cannot be represented exactly as a decimal fraction"; break;
                case EXCEPTION_FLT_INVALID_OPERATION     : shortExc="Float Invalid Operation"; longExc="This exception represents any floating-point exception not included in this list"; break;
                case EXCEPTION_FLT_OVERFLOW              : shortExc="Float Overflow"; longExc="The exponent of a floating-point operation is greater than the magnitude allowed by the corresponding type"; break;
                case EXCEPTION_FLT_STACK_CHECK           : shortExc="Float Stack Check"; longExc="The stack overflowed or underflowed as the result of a floating-point operation"; break;
                case EXCEPTION_FLT_UNDERFLOW             : shortExc="Float Underflow"; longExc="The exponent of a floating-point operation is less than the magnitude allowed by the corresponding type"; break;
                case EXCEPTION_INT_DIVIDE_BY_ZERO        : shortExc="Integer Divide By Zero"; longExc="The thread attempted to divide an integer value by an integer divisor of zero"; break;
                case EXCEPTION_INT_OVERFLOW              : shortExc="Integer Overflow"; longExc="The result of an integer operation caused a carry out of the most significant bit of the result"; break;
                case EXCEPTION_PRIV_INSTRUCTION          : shortExc="Privileged Instruction"; longExc="The thread attempted to execute an instruction whose operation is not allowed in the current machine mode"; break;
                case EXCEPTION_IN_PAGE_ERROR             : shortExc="In Page Error"; longExc="The thread tried to access a page that was not present, and the system was unable to load the page. -ie. the program or memory mapped file couldn't be paged in because it isn't accessable any more. Device drivers can return this exception if something went wrong with the read (i.e hardware problems)"; break;
                case EXCEPTION_ILLEGAL_INSTRUCTION       : shortExc="Illegal Instruction"; longExc="The thread tried to execute an invalid instruction -such as MMX opcodes on a non MMX system. Branching to an invalid location can cause this -something stack corruption often causes"; break;
                case EXCEPTION_NONCONTINUABLE_EXCEPTION  : shortExc="Noncontinuable Exception"; longExc="The thread attempted to continue execution after a noncontinuable exception occurred"; break;
                case EXCEPTION_STACK_OVERFLOW            : shortExc="Stack Overflow"; longExc="Stack overflow. Can occur during errant recursion, or when a function creates a particularly large array on the stack"; break;
                case EXCEPTION_INVALID_DISPOSITION       : shortExc="Invalid Disposition"; longExc="Whatever number the exception filter returned, it wasn't a value the OS knows about"; break;
                case EXCEPTION_GUARD_PAGE                : shortExc="Guard Page"; longExc="Memory Allocated as PAGE_GUARD by VirtualAlloc() has been accessed"; break;
                case EXCEPTION_INVALID_HANDLE            : shortExc="Invalid Handle"; longExc=""; break;
                case CONTROL_C_EXIT                      : shortExc="Control-C"; longExc="Lets the debugger know the user hit Ctrl-C. Seemingly for console apps only"; break;
                case STATUS_NO_MEMORY                    : shortExc="No Memory"; longExc="Called by HeapAlloc() if you specify HEAP_GENERATE_EXCEPTIONS and there is no memory or heap corruption";
                    ext = ", unable to allocate ";
                    ext += gxToString ("%d bytes", (uint64)m_pexp->ExceptionRecord->ExceptionInformation [0]);
                    break;
                case STATUS_WAIT_0                       : shortExc="Wait 0"; longExc=""; break;
                case STATUS_ABANDONED_WAIT_0             : shortExc="Abandoned Wait 0"; longExc=""; break;
                case STATUS_USER_APC                     : shortExc="User APC"; longExc="A user APC was delivered to the current thread before the specified Timeout interval expired"; break;
                case STATUS_TIMEOUT                      : shortExc="Timeout"; longExc=""; break;
                case STATUS_PENDING                      : shortExc="Pending"; longExc=""; break;
                case STATUS_SEGMENT_NOTIFICATION         : shortExc="Segment Notification"; longExc=""; break;
                case STATUS_FLOAT_MULTIPLE_FAULTS        : shortExc="Float Multiple Faults"; longExc=""; break;
                case STATUS_FLOAT_MULTIPLE_TRAPS         : shortExc="Float Multiple Traps"; longExc=""; break;
                case 0xE06D7363                          : shortExc="Microsoft C++ Exception"; longExc="Microsoft C++ Exception"; break;	// cpp exception
                case 0xACE0ACE                           : shortExc=""; longExc="";
                    if (m_pexp->ExceptionRecord->NumberParameters == 1)
                        skipNFirst = m_pexp->ExceptionRecord->ExceptionInformation [0];
                    break;	// just want the stack
				default                                  : shortExc="Unknown Exception"; longExc="Unknown Exception "+gxToString("0x%X", (uint32)m_pexp->ExceptionRecord->ExceptionCode); break;
                };

                if(m_pexp->ExceptionRecord != NULL)
                {
                    if (m_pexp->ExceptionRecord->ExceptionAddress)
                        addr = gxToString(" at 0x%X", m_pexp->ExceptionRecord->ExceptionAddress);
                    else
                        addr = " at <NULL>";
                }

                string progname;
                if(!shortExc.empty() || !longExc.empty())
                {
                    char name[1024];
                    GetModuleFileNameA (NULL, name, 1023);
                    progname = CFile::GetFilename(name);
                    progname += " ";
                }

                subject = progname + shortExc + addr;

                if (_Reason.empty())
                {
                    if (!shortExc.empty()) _Reason += shortExc + " exception generated" + addr + ext + ".\n";
                    if (!longExc.empty()) _Reason += longExc + ".\n";
                }

                // display the stack
                addStackAndLogToReason (skipNFirst);
            }
        }

        // display the callstack
        void addStackAndLogToReason (ULONG_PTR /* skipNFirst */ = 0)
        {
#ifdef OS_WINDOWS
            // ace hack
            /*		skipNFirst = 0;

            DWORD symOptions = SymGetOptions();
            symOptions |= SYMOPT_LOAD_LINES;
            symOptions &= ~SYMOPT_UNDNAME;
            SymSetOptions (symOptions);

            gxverify (SymInitialize(getProcessHandle(), NULL, FALSE) == TRUE);

            STACKFRAME callStack;
            ::ZeroMemory (&callStack, sizeof(callStack));
            callStack.AddrPC.Mode      = AddrModeFlat;
            callStack.AddrPC.Offset    = m_pexp->ContextRecord->Eip;
            callStack.AddrStack.Mode   = AddrModeFlat;
            callStack.AddrStack.Offset = m_pexp->ContextRecord->Esp;
            callStack.AddrFrame.Mode   = AddrModeFlat;
            callStack.AddrFrame.Offset = m_pexp->ContextRecord->Ebp;

            _Reason += "\nCallstack:\n";
            _Reason += "-------------------------------\n";
            for (sint32 i = 0; ; i++)
            {
            SetLastError(0);
            BOOL res = StackWalk (IMAGE_FILE_MACHINE_I386, getProcessHandle(), GetCurrentThread(), &callStack,
            m_pexp->ContextRecord, NULL, FunctionTableAccess, GetModuleBase, NULL);

            if (res == FALSE || callStack.AddrFrame.Offset == 0)
            break;

            string symInfo, srcInfo;

            if (i >= skipNFirst)
            {
            srcInfo = getSourceInfo (callStack.AddrPC.Offset);
            symInfo = getFuncInfo (callStack.AddrPC.Offset, callStack.AddrFrame.Offset);
            _Reason += srcInfo + ": " + symInfo + "\n";
            }
            }
            SymCleanup(getProcessHandle());
            */
#elif defined(OS_UNIX)
            // Make place for stack frames and function names
            const uint32 MaxFrame=64;
            void *trace[MaxFrame];
            char **messages = (char **)NULL;
            int i, trace_size = 0;

            trace_size = backtrace(trace, MaxFrame);
            messages = backtrace_symbols(trace, trace_size);
            result += "Callstack:\n";
            _Reason += "-------------------------------\n";
            for (i=0; i<trace_size; ++i)
                _Reason += ToString("%u : %s\n", i, messages[i]);
            // free the messages
            free(messages);
#endif
        }

        string getSourceInfo (DWORD_TYPE addr)
        {
            string str;

            IMAGEHLP_LINE  line;
            ::ZeroMemory (&line, sizeof (line));
            line.SizeOfStruct = sizeof(line);

            // ACE: removed the next code because "SymGetLineFromAddr" is not available on windows 98
            bool ok = false;
            DWORD displacement = 0 ;
            DWORD resdisp = 0;

            //
            /*
            // "Debugging Applications" John Robbins
            // The problem is that the symbol engine finds only those source
            // line addresses (after the first lookup) that fall exactly on
            // a zero displacement. I'll walk backward 100 bytes to
            // find the line and return the proper displacement.
            bool ok = true;
            DWORD displacement = 0 ;
            DWORD resdisp;

            while (!SymGetLineFromAddr (getProcessHandle(), addr - displacement, (DWORD*)&resdisp, &line))
            {
            if (100 == ++displacement)
            {
            ok = false;
            break;
            }
            }
            */
            //

            // "Debugging Applications" John Robbins
            // I found the line, and the source line information is correct, so
            // change the displacement if I had to search backward to find the source line.
            if (displacement)
                resdisp = displacement;

            if (ok)
            {
                str = line.FileName;
                str += "(" + gxToString ((uint32)line.LineNumber) + ")";
                str += gxToString(": 0x%X", (uint64)addr);
            }
            else
            {
                IMAGEHLP_MODULE module;
                ::ZeroMemory (&module, sizeof(module));
                module.SizeOfStruct = sizeof(module);

                if (SymGetModuleInfo (getProcessHandle(), addr, &module))
                {
                    str = module.ModuleName;
                }
                else
                {
                    str = "<NoModule>";
                }
                str += gxToString("!0x%X", (uint64)addr);
            }

            //

            /*DWORD disp;
            if (SymGetLineFromAddr (getProcessHandle(), addr, &disp, &line))
            {
            str = line.FileName;
            str += "(" + ToString (line.LineNumber) + ")";
            }
            else
            {*/
            IMAGEHLP_MODULE module;
            ::ZeroMemory (&module, sizeof(module));
            module.SizeOfStruct = sizeof(module);

            if (SymGetModuleInfo (getProcessHandle(), addr, &module))
            {
                str = module.ModuleName;
            }
            else
            {
                str = "<NoModule>";
            }
            char tmp[32];
            sprintf (tmp, "!0x%X", addr);
            str += tmp;
            //}
            str +=" DEBUG:"+gxToString("0x%08X", (uint64)addr);

            //

            return str;
        }

        HANDLE getProcessHandle()
        {
            return (HANDLE)GetCurrentProcessId();
        }

        // return true if found
        bool findAndErase(string &str, const char *token, const char *replace = NULL)
        {
            string::size_type pos;
            if ((pos = str.find(token)) != string::npos)
            {
                str.erase (pos,strlen(token));
                if (replace != NULL)
                    str.insert (pos, replace);
                return true;
            }
            else
                return false;
        }

        // remove space and const stuffs
        // rawType contains the type without anything (to compare with known type)
        // displayType contains the type without std:: and stl ugly things
        void cleanType(string &rawType, string &displayType)
        {
            while (findAndErase(rawType, "std::")) ;
            while (findAndErase(displayType, "std::")) ;

            while (findAndErase(rawType, "_STL::")) ;
            while (findAndErase(displayType, "_STL::")) ;

            while (findAndErase(rawType, "const")) ;

            while (findAndErase(rawType, " ")) ;

            while (findAndErase(rawType, "&")) ;

            // rename ugly stl type

            while (findAndErase(rawType, "classbasic_string<char,classchar_traits<char>,classallocator<char>>", "string")) ;
            while (findAndErase(displayType, "class basic_string<char,class char_traits<char>,class allocator<char> >", "string")) ;
            while (findAndErase(rawType, "classvector<char,class char_traits<char>,class allocator<char> >", "string")) ;
        }

        string getFuncInfo (DWORD funcAddr, DWORD stackAddr)
        {
            string str ("NoSymbol");

            DWORD symSize = 10000;
            PIMAGEHLP_SYMBOL  sym = (PIMAGEHLP_SYMBOL) GlobalAlloc (GMEM_FIXED, symSize);
            ::ZeroMemory (sym, symSize);
            sym->SizeOfStruct = symSize;
            sym->MaxNameLength = symSize - sizeof(IMAGEHLP_SYMBOL);

            DWORD_TYPE disp = 0;
            if (SymGetSymFromAddr (getProcessHandle(), funcAddr, &disp, sym) == FALSE)
            {
                return str;
            }

            CHAR undecSymbol[1024];
            if (UnDecorateSymbolName (sym->Name, undecSymbol, 1024, UNDNAME_COMPLETE | UNDNAME_NO_THISTYPE | UNDNAME_NO_SPECIAL_SYMS | UNDNAME_NO_MEMBER_TYPE | UNDNAME_NO_MS_KEYWORDS | UNDNAME_NO_ACCESS_SPECIFIERS ) > 0)
            {
                str = undecSymbol;
            }
            else if (SymUnDName (sym, undecSymbol, 1024) == TRUE)
            {
                str = undecSymbol;
            }

            // replace param with the value of the stack for this param

            string parse = str;
            str = "";
            uint32 pos2 = 0;
            sint32 stop = 0;

            string type;

            string::size_type i = parse.find ("(");

            // copy the function name
            str = parse.substr(0, i);

            //		gxInfo ("not parsed {0}", parse);

            // if there s parameter, parse them
            if(i!=string::npos)
            {
                // copy the '('
                str += parse[i];
                for (i++; i < parse.size (); i++)
                {
                    if (parse[i] == '<')
                        stop++;
                    if (parse[i] == '>')
                        stop--;

                    if (stop==0 && (parse[i] == ',' || parse[i] == ')'))
                    {
                        ULONG *addr = (ULONG*)(stackAddr) + 2 + pos2++;

                        string displayType = type;
                        cleanType (type, displayType);

                        char tmp[1024];
                        if(type == "void")
                        {
                            tmp[0]='\0';
                        }
                        else if(type == "int")
                        {
                            if (!IsBadReadPtr(addr,sizeof(int)))
                                sprintf (tmp, "%d", *addr);
                        }
                        else if (type == "char")
                        {
                            if (!IsBadReadPtr(addr,sizeof(char)))
                                if (gxIsPrint(*addr))
                                {
                                    sprintf (tmp, "'%c'", *addr);
                                }
                                else
                                {
                                    sprintf (tmp, "%d", *addr);
                                }
                        }
                        else if (type == "char*")
                        {
                            if (!IsBadReadPtr(addr,sizeof(char*)) && *addr != NULL)
                            {
                                if (!IsBadStringPtrA((char*)*addr,32))
                                {
                                    uint32 pos = 0;
                                    tmp[pos++] = '\"';
                                    for (uint32 j = 0; j < 32; j++)
                                    {
                                        char c = ((char *)*addr)[j];
                                        if (c == '\0')
                                            break;
                                        else if (c == '\n')
                                        {
                                            tmp[pos++] = '\\';
                                            tmp[pos++] = 'n';
                                        }
                                        else if (c == '\r')
                                        {
                                            tmp[pos++] = '\\';
                                            tmp[pos++] = 'r';
                                        }
                                        else if (c == '\t')
                                        {
                                            tmp[pos++] = '\\';
                                            tmp[pos++] = 't';
                                        }
                                        else
                                            tmp[pos++] = c;
                                    }
                                    tmp[pos++] = '\"';
                                    tmp[pos++] = '\0';
                                }
                            }
                        }
                        else if (type == "string") // we assume a string is always passed by reference (i.e. addr is a string**)
                        {
                            if (!IsBadReadPtr(addr,sizeof(string*)))
                            {
                                if (*addr != NULL)
                                {
                                    if (!IsBadReadPtr((void*)*addr,sizeof(string)))
                                        sprintf (tmp, "\"%s\"", ((string*)*addr)->c_str());
                                }
                            }
                        }
                        else
                        {
                            if (!IsBadReadPtr(addr,sizeof(ULONG*)))
                            {
                                if(*addr == NULL)
                                    sprintf (tmp, "<NULL>");
                                else
                                    sprintf (tmp, "0x%X", *addr);
                            }
                        }

                        str += displayType;
                        if(tmp[0]!='\0')
                        {
                            str += "=";
                            str += tmp;
                        }
                        str += parse[i];
                        type = "";
                    }
                    else
                    {
                        type += parse[i];
                    }
                }
                GlobalFree (sym);
                if (disp != 0)
                {
                    str += " + ";
                    str += gxToString ((uint32)disp);
                    str += " bytes";
                }
            }

            return str;
        }

    private:
        EXCEPTION_POINTERS * m_pexp;
    };

#endif // OS_WINDOWS
    
#ifdef OS_WINDOWS
    int myerror(int code , PEXCEPTION_POINTERS p, std::string& result)
    {
        EDebug e(p);
        e.createWhat();
        result += e.what();

        return 0;
    }
#endif

    void gxGetCallStack(std::string &result, sint32 skipNFirst)			// @todo
    {
#ifdef OS_WINDOWS
        __try
        {
//             DWORD_PTR array[1];
//             array[0] = skipNFirst;
//             RaiseException (0xACE0ACE, 0, 1, array);
        }
        __except(myerror(GetExceptionCode(), GetExceptionInformation(), result))
        {
        }
#elif defined(OS_UNIX)
        // Make place for stack frames and function names
        const uint32 MaxFrame=64;
        void *trace[MaxFrame];
        char **messages = (char **)NULL;
        int i, trace_size = 0;

        // on mac, require at least os 10.5
        trace_size = backtrace(trace, MaxFrame);
        messages = backtrace_symbols(trace, trace_size);
        result += "Dumping call stack :\n";
        for (i=0; i<trace_size; ++i)
            result += gxToString("%u : %s\n", i, messages[i]);
        // free the messages
        free(messages);

        // @todo
#endif
    }

    void gxExit( EExitCode code )
    {
		if(code == EXIT_CODE_CRASH)
		{
			DGxContext.callOnCrash(gxGetDumpName());
			exit(code);
		}
		else
		{
			DGxContext.exitCallback(EXIT_CODE_CRASH);
			char *temp = NULL;
			*temp = 1;
			exit(code);
		}
    }

    bool gxIsMainThread()
    {
        return (gxGetThreadID() == DGxContext.getMainThread());
    }

    bool gxIsFastLogThread()
    {
        return gxGetThreadID() == DGxContext.getFastLogThread();
    }

} // GXMISC
