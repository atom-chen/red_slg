#include "stdcore.h"


#ifdef OS_WINDOWS
#	include <io.h>
#	include <fcntl.h>
#	include <sys/types.h>
#	include <sys/stat.h>
#else
#	include <cerrno>
#endif // OS_WINDOWS

#include "types_def.h"
#include "path.h"
#include "mutex.h"
#include "debug.h"


#ifdef OS_WINDOWS
// these defines is for IsDebuggerPresent(). it'll not compile on windows 95
// just comment this and the IsDebuggerPresent to compile on windows 95
#	define _WIN32_WINDOWS	0x0410
#	define WINVER			0x0400
#else
#	define IsDebuggerPresent() false
#endif

#include "displayer.h"
#include "ucstring.h"
#include "string_common.h"
#include "logger.h"
#include "time_manager.h"

using namespace std;

namespace GXMISC
{
    static const char *_LogTypeToString[][CLogger::LOG_UNKNOWN+1] =
	{
        { "", "ERR", "WRN", "INF", "DBG", "STT", "AST", "GM", "UKN" },
        { "", "Error", "Warning", "Information", "Debug", "Statistic", "Assert", "Gm", "Unknown" },
        { "", "A fatal error occurs. The program must quit", "", "", "", "", "A failed assertion occurs", "", "" },
    };

    const char *IDisplayer::LogTypeToString (CLogger::ELogType logType, bool longFormat)
    {
        if (logType < CLogger::LOG_NO || logType > CLogger::LOG_UNKNOWN)
		{
            return "<NotDefined>";
		}

        return _LogTypeToString[longFormat?1:0][logType];
    }

    const char *IDisplayer::DateToHumanString ()
    {
        return DateToHumanString(time(NULL));
    }

	const char *IDisplayer::DateToHumanString(TTime date)
    {
        static char cstime[25];
		tm tempTm;
		tm* tms = CTimeManager::LocalTime( (time_t*)&date, &tempTm ) ;
        if (tms)
            strftime (cstime, 25, "%Y/%m/%d %H:%M:%S", tms);
        else
            sprintf(cstime, "bad date %d", (uint32)date);
        return cstime;
    }

	const char *IDisplayer::DateToComputerString(TTime date)
    {
        static char cstime[25];
        gxSprintf (cstime, 25, "%ld", &date);
        return cstime;
    }

    const char *IDisplayer::HeaderString ()
    {
        static char header[1024];
        gxSprintf(header, 1024, "\nLog Starting [%s]\n", DateToHumanString());
        return header;
    }


    IDisplayer::IDisplayer(bool isRaw, bool isDeleteByLog, const char *displayerName)
    {
        _displayerName = displayerName;
        _isNeedDeleteByLog = isDeleteByLog;
		_raw = isRaw;
    }

    IDisplayer::~IDisplayer()
    {
    }

    /*
    * Display the string where it does.
    */
    void IDisplayer::display ( const CLogger::TDisplayInfo& args, const char *message )
    {
        enter();
        doDisplay( args, message );
        leave();
    }

    const std::string& IDisplayer::getName()
    {
        return _displayerName;
    }

    bool IDisplayer::isNeedDeleteByLog()
    {
        return _isNeedDeleteByLog;
    }

    const char* IDisplayer::IsSyncString( bool sync )
    {
        if(sync)
        {
            return "SYNC";
        }
        else
        {
            return "";
        }
    }

	void IDisplayer::genMessageHeader( std::string& str, const CLogger::TDisplayInfo& args )
	{
		bool needSpace = false;

		if (args._date != 0 && !_raw)
		{
			str += DateToHumanString(args._date);
			needSpace = true;
		}

		if (args._logType != CLogger::LOG_NO && !_raw)
		{
			if (needSpace) { str += " "; needSpace = false; }
			str += LogTypeToString(args._logType);
			needSpace = true;
		}

		if(args.isSync())
		{
			if (needSpace) { str += " "; needSpace = false; }
			str += IsSyncString(args._sync);
			needSpace = true;
		}

		// Write thread identifier
		if ( args._threadId != 0 && !_raw)
		{
			if (needSpace) { str += " ";        needSpace = false; }
			str += GXMISC::gxToString("%08x",   args._threadId);
			needSpace = true;
		}

		if (!args._processName.empty() && !_raw)
		{
			if (needSpace) { str += " "; needSpace = false; }
			str += args._processName;
			needSpace = true;
		}

		if (args._fileName != NULL && !_raw)
		{
			if (needSpace) { str += " "; needSpace = false; }
			str += CFile::GetFilename(args._fileName);
			needSpace = true;
		}

		if (args._line != -1 && !_raw)
		{
			if (needSpace) { str += " "; needSpace = false; }
			str += GXMISC::gxToString(args._line);
			needSpace = true;
		}

		str += " : ";

		if(args._moduleName != NULL)
		{
			str += args._moduleName;
		}
	}

    // Log format : "<LogType> <ThreadNo> <FileName> <Line> <ProcessName> : <Msg>"
    void CStdDisplayer::doDisplay ( const CLogger::TDisplayInfo& args, const char *message )
    {
//        bool needSpace = false;
        string str;
        str.reserve(1024);
	
		genMessageHeader(str, args);

        str += message;
		
        static bool consoleMode = true;
	
#if defined(OS_WINDOWS)
        static bool consoleModeTest = false;
		static HANDLE handle = NULL;
        if (!consoleModeTest)
        {
            handle = CreateFileA ("CONOUT$", GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, 0); // @TODO UNICODE
            consoleMode = handle != INVALID_HANDLE_VALUE;
            if (consoleMode)
            {
                CloseHandle (handle);
            }
            consoleModeTest = true;
        }
#endif // OS_WINDOWS

        // Printf ?
        if (consoleMode)
        {

            // we don't use cout because sometimes, it crashs because cout isn't already init, printf doesn t crash.
#if defined(OS_WINDOWS)
			intptr_t handle= (intptr_t)GetStdHandle(STD_OUTPUT_HANDLE);
			switch (args._logType)
			{
			case CLogger::LOG_DEBUG:
				// 文字绿色
				 SetConsoleTextAttribute((HANDLE)handle, FOREGROUND_GREEN);
				break;
			case CLogger::LOG_INFO:
				// 文字青色
				SetConsoleTextAttribute((HANDLE)handle, FOREGROUND_GREEN | FOREGROUND_BLUE);
				break;
			case CLogger::LOG_WARNING:
				// 文字黄色
				SetConsoleTextAttribute((HANDLE)handle, FOREGROUND_RED | FOREGROUND_GREEN);
				break;
			case CLogger::LOG_ERROR:
				// 文字品红色
				SetConsoleTextAttribute((HANDLE)handle, FOREGROUND_RED | FOREGROUND_BLUE);
				break;
			case CLogger::LOG_ASSERT:
				// 文字品红色
				SetConsoleTextAttribute((HANDLE)handle, FOREGROUND_RED);
				break;
			case CLogger::LOG_STAT:
				// 文字蓝色
				SetConsoleTextAttribute((HANDLE)handle, FOREGROUND_BLUE);
				break;
			default:
				// 文字白色
				SetConsoleTextAttribute((HANDLE)handle, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE);
				break;
			}
#endif
            if (!str.empty())
            {
                printf ("%s", str.c_str());
            }

            if (!args._callstackAndLog.empty())
            {
                printf ("%s", args._callstackAndLog.c_str());
            }
		
            fflush(stdout);
        }

#ifdef OS_WINDOWS
//         // display the string in the debugger is the application is started with the debugger
//         if (IsDebuggerPresent ())
//         {
//             //stringstream ss2;
//             string str2;
//             needSpace = false;
// 
//             if (args._fileName != NULL) str2 += args._fileName;
// 
//             if (args._line != -1)
//             {
//                 str2 += "(" + GXMISC::gxToString(args._line) + ")";
//                 needSpace = true;
//             }
// 
//             if (needSpace) { str2 += " : "; needSpace = false; }
// 
//             if (args._funcName != NULL) str2 += string(args._funcName) + " ";
// 
//             if (args._logType != CLogger::LOG_NO)
//             {
//                 str2 += LogTypeToString(args._logType);
//                 needSpace = true;
//             }
// 
//             // Write thread identifier
//             if ( args._threadId != 0 )
//             {
//                 str2 += GXMISC::gxToString("%08x: ", args._threadId);
//             }
// 
//             str2 += message;
// 
//             const sint32 maxOutString = 2*1024;
// 
//             if(str2.size() < maxOutString)
//             {
//                 //////////////////////////////////////////////////////////////////
//                 // WARNING: READ THIS !!!!!!!!!!!!!!!! ///////////////////////////
//                 // If at the release time, it freezes here, it's a microsoft bug:
//                 // http://support.microsoft.com/support/kb/articles/q173/2/60.asp
//                 OutputDebugStringW((LPCWSTR)CUString::MakeFromUtf8(str2).c_str());
//             }
//             else
//             {
//                 sint32 count = 0;
//                 uint n = (uint)strlen(message);
//                 std::string s(&str2.c_str()[0], (str2.size() - n));
//                 OutputDebugStringW((LPCWSTR)CUString::MakeFromUtf8(s).c_str());
// 
//                 for(;;)
//                 {
// 
//                     if((n - count) < maxOutString )
//                     {
//                         s = std::string(&message[count], (n - count));
//                         OutputDebugStringW((LPCWSTR)CUString::MakeFromUtf8(s).c_str());
//                         OutputDebugStringW((LPCWSTR)CUString::MakeFromUtf8("\n").c_str());
//                         break;
//                     }
//                     else
//                     {
//                         s = std::string(&message[count] , count + maxOutString);
//                         OutputDebugStringW((LPCWSTR)CUString::MakeFromUtf8(s).c_str());
//                         OutputDebugStringW((LPCWSTR)CUString::MakeFromUtf8("\n\t\t\t").c_str());
//                         count += maxOutString;
//                     }
//                 }
//             }
// 
//             // OutputDebugString is a big shit, we can't display big string in one time, we need to split
//             uint32 pos = 0;
//             string splited;
//             for(;;)
//             {
//                 if (pos+1000 < args._callstackAndLog.size ())
//                 {
//                     splited = args._callstackAndLog.substr (pos, 1000);
//                     OutputDebugStringW((LPCWSTR)CUString::MakeFromUtf8(splited).c_str());
//                     pos += 1000;
//                 }
//                 else
//                 {
//                     splited = args._callstackAndLog.substr (pos);
//                     OutputDebugStringW((LPCWSTR)CUString::MakeFromUtf8(splited).c_str());
//                     break;
//                 }
//             }
//         }
#endif
    }

	CFileDisplayer::CFileDisplayer (bool needDeleteByLog, const std::string &displayerName, 
		const uint32 size, bool eraseLastLog, bool raw) :
    IDisplayer (raw, needDeleteByLog, displayerName.c_str()), _needHeader(true), _lastLogSizeChecked(0)
    {
        _filePointer = (FILE*)1;
        setParam (displayerName, size, eraseLastLog);
    }

    CFileDisplayer::CFileDisplayer (bool needDeleteByLog) :
    IDisplayer (false, needDeleteByLog, ""), _needHeader(true), _lastLogSizeChecked(0)
    {
        _filePointer = (FILE*)1;
    }

    CFileDisplayer::~CFileDisplayer ()
    {
        if (_filePointer > (FILE*)1)
        {
            fclose(_filePointer);
            _filePointer = NULL;
        }
    }

    void CFileDisplayer::setParam (const std::string &displayerName, const uint32 size, bool eraseLastLog)
    {
        _fileName = getFileName(displayerName);

        if (_fileName.empty())
        {
            // can't do gxwarning or infinite recurs
            printf ("CFileDisplayer::setParam(): Can't create file with empty filename\n");
            return;
        }

        if (eraseLastLog)
        {
            // Erase all the derived log files
            int i = 0;
            bool fileExist = true;
            while (fileExist)
            {
                string fileToDelete = CFile::GetPath (_fileName) + CFile::GetFilenameWithoutExtension (_fileName) +
                    gxToString ("%03d.", i) + CFile::GetExtension (_fileName);
                fileExist = CFile::IsExists (fileToDelete);
                if (fileExist)
                    CFile::Deletefile (fileToDelete);
                i++;
            }
        }

        if (_filePointer > (FILE*)1)
        {
            fclose (_filePointer);
            _filePointer = (FILE*)1;
        }

		_singleFileSize = size;
    }

    const std::string CFileDisplayer::getFileName(const std::string& _serverName)
    {
        return _serverName + ".log";
    }

    // Log format: "2000-01-15 12:05:30 <ProcessName> <LogType> <ThreadId> <FileName> <Line> : <Msg>"
    void CFileDisplayer::doDisplay ( const CLogger::TDisplayInfo& args, const char *message )
    {
        if (_fileName.empty()) return;
		string str;
		str.reserve(1024);

		genMessageHeader(str, args);

        str += message;

		checkFileSize();

        if (_filePointer == (FILE*)1)
        {
            _filePointer = fopen (_fileName.c_str(), "at");
            if (_filePointer == NULL)
                printf ("Can't open log file '%s': %s\n", _fileName.c_str(), strerror (errno));
        }

        if (_filePointer != 0)
        {
            if (_needHeader)
            {
                const char *hs = HeaderString();
                fwrite (hs, strlen (hs), 1, _filePointer);
                _needHeader = false;
            }

            if(!str.empty())
                fwrite (str.c_str(), str.size(), 1, _filePointer);

            if(!args._callstackAndLog.empty())
                fwrite (args._callstackAndLog.c_str(), args._callstackAndLog.size (), 1, _filePointer);

            fflush (_filePointer);
        }
    }

	void CFileDisplayer::checkFileSize()
	{
		if (_filePointer > (FILE*)1)
		{
			// if the file is too big (>5mb), rename it and create another one (check only after 20 lines to speed up)
			if (_lastLogSizeChecked++ > LOG_CACHE_NUM)
			{
				int res = ftell (_filePointer);
				if (res > _singleFileSize)
				{
					fclose (_filePointer);
					rename (_fileName.c_str(), CFile::FindNewFile (_fileName).c_str());
					_filePointer = (FILE*) 1;
					_lastLogSizeChecked = 0;
				}
			}
		}
	}
} // GXMISC
