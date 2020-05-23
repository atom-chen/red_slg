#ifndef _DISPLAYER_H_
#define _DISPLAYER_H_

#include <string>

#include "string_common.h"

#include "types_def.h"
#include "logger.h"
#include "mutex.h"
#include "time_gx.h"

namespace GXMISC
{
    class IDisplayer
    {
    public:
        virtual void enter(){}
        virtual void leave(){}

	protected:
        IDisplayer(bool isRaw = false, bool isDeleteByLog = false, const char *displayerName = "");
	public:
        virtual ~IDisplayer();

	public:
        void display( const CLogger::TDisplayInfo& args, const char *message );
        const std::string& getName();
        bool isNeedDeleteByLog();

    private:
        std::string _displayerName;		// 对象名
        bool _isNeedDeleteByLog;		// 是否要删除
		bool _raw;						// 不带日志头

    protected:
        /// Method to implement in the derived class
        virtual void doDisplay( const CLogger::TDisplayInfo& args, const char *message) = 0;

        // Return the header string with date (for the first line of the log)
        static const char *HeaderString ();
	
		// 生成日志头
		virtual void genMessageHeader(std::string& str, const CLogger::TDisplayInfo& args);

    public:
        /// Convert log type to string
        static const char *LogTypeToString (CLogger::ELogType logType, bool longFormat = false);
    
        /// Convert the current date to human string
        static const char *DateToHumanString ();

        /// Convert date to "2000/01/14 10:05:17" string
		static const char *DateToHumanString(TTime date);

        /// Convert date to "784551148" string (time in second from 1975)
        static const char *DateToComputerString (TTime date);

        /// 
        static const char* IsSyncString(bool sync);
    };

    /**
    * Std displayer. Put string to stdout.
    */
    class CStdDisplayer : public IDisplayer
    {
    public:
        CStdDisplayer (bool needDeleteByLog = false, const char *displayerName = "", bool raw = false) 
			: IDisplayer (raw, needDeleteByLog, displayerName) {}

    protected:

        /// Display the string to stdout and OutputDebugString on Windows
        virtual void doDisplay ( const CLogger::TDisplayInfo& args, const char *message );
    };

    class CSafeStdDisplayer : public CStdDisplayer
    {
    public:
        CSafeStdDisplayer(bool needDeleteByLog = false, const char *displayerName = "", bool raw = false) 
			: CStdDisplayer(needDeleteByLog, displayerName, raw){}

    public:
        virtual void enter()
        {
            _mutex.enter();
        }
        virtual void leave()
        {
            _mutex.leave();
        }

    private:
        CMutex _mutex;
    };

    /**
    * File displayer. Put string into a file.
    */
    class CFileDisplayer : public IDisplayer
    {
    public:
        /// Constructor
        CFileDisplayer (bool needDeleteByLog, const std::string &displayerName, const uint32 size = LOG_SINGLE_FILE_SIZE,
			bool eraseLastLog = false, bool raw = false);

        CFileDisplayer (bool needDeleteByLog);
        ~CFileDisplayer ();

        /// Set Parameter of the displayer if not set at the ctor time
        void setParam (const std::string &displayerName, const uint32 size = LOG_SINGLE_FILE_SIZE, bool eraseLastLog = false);

    protected:
        /// Put the string into the file.
        virtual void doDisplay ( const CLogger::TDisplayInfo& args, const char *message );
        // @todo 修改生成规则
        const std::string getFileName(const std::string& serverName);

	private:
		void checkFileSize();
		
    private:
		std::string		_fileName;
        FILE			*_filePointer;				// 文件指针
        bool			_needHeader;				// 是否带日志头
        uint32			_lastLogSizeChecked;		// 上次日志缓冲数
		sint32			_singleFileSize;			// 单个日志大小
    };

    class CSafeFileDispalyer : public CFileDisplayer
    {
    public:
        CSafeFileDispalyer (bool needDeleteByLog, const std::string &displayerName, const uint32 size = LOG_SINGLE_FILE_SIZE, 
			bool eraseLastLog = false, bool raw = false)
            : CFileDisplayer(needDeleteByLog, displayerName, size, eraseLastLog, raw){}

    public:
        virtual void enter()
        {
            _mutex.enter();
        }
        virtual void leave()
        {
            _mutex.leave();
        }

    private:
        CMutex _mutex;
    };
}

#endif