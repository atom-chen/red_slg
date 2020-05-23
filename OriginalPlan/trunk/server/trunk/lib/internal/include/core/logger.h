#ifndef _LOGGER_H_
#define _LOGGER_H_

#include <list>
#include <string>

#include "msg_queue.h"
#include "types_def.h"
#include "string_common.h"
#include "mutex.h"
#include "base_util.h"
#include "lib_init.h"

namespace GXMISC
{
    class IDisplayer;

    /**
    * When display() is called, the logger builds a string and sends it to its attached displayers.
    * The positive filters, if any, are applied first, then the negative filters.
    * See the gxDebug/gxInfo... macros in debug.h.
    */
    class CLogger
    {
        typedef std::list<IDisplayer *> TDisplayers;

    public:
        typedef enum { LOG_NO=0, LOG_ERROR, LOG_WARNING, LOG_INFO, LOG_DEBUG, LOG_STAT, LOG_ASSERT, LOG_GM, LOG_UNKNOWN } ELogType;

        // 加锁
    protected:
        virtual void enter(){}
        virtual void leave(){}

    public:
        struct TDisplayInfo
        {
            TDisplayInfo() : _date(0), _logType(LOG_NO), _threadId(0), _fileName(NULL), _line(-1), _funcName(NULL), _moduleName(NULL), _sync(false) {}
            
            time_t				_date;          // @todo time_buff 提高日志效率
            ELogType			_logType;
            std::string			_processName;
            TThreadID_t         _threadId;
            const char			*_fileName;
            sint32				_line;
            const char			*_funcName;
			const char			*_moduleName;
            bool                _sync;
			
            std::string			_callstackAndLog;	// contains the callstack and a log with not filter of N last line (only in error/assert log type)

            bool isSync() const
            {
                return _sync;
            }

            bool isLogType() const
            {
                return _logType != CLogger::LOG_NO;
            }

            bool isThread() const
            {
                return _threadId != 0;
            }
        };

        CLogger ();
        virtual ~CLogger();

        // 同步写入
    public:
        void synLog(const std::string& str);
        void update(uint32 diff);
        sint32 calcLogNum();
        void flush();

    public:
        /// Add a new displayer in the log. You have to create the displayer, remove it and delete it when you have finish with it.
        /// For example, in a 3dDisplayer, you can add the displayer when you want, and the displayer displays the string if the 3d
        /// screen is available and do nothing otherwise. In this case, if you want, you could leave the displayer all the time.
        void addDisplayer (IDisplayer *displayer, bool bypassFilter = true);

        /// Return the first displayer selected by his name
        IDisplayer *getDisplayer (const char *displayerName);

        /// Remove a displayer. If the displayer doesn't work in a specific time, you could remove it.
        void removeDisplayer (IDisplayer *displayer);

        /// Remove a displayer using his name
        void removeDisplayer (const char *displayerName);

        /// Returns true if the specified displayer is attached to the log object
        bool attached (IDisplayer *displayer) const;

        /// Returns true if no displayer is attached
        bool noDisplayer () const { return _displayers.empty() && _bypassFilterDisplayers.empty(); }

        /// If !noDisplayer(), sets line and file parameters, and enters the mutex. If !noDisplayer(), don't forget to call display...() after, to release the mutex.
        void setPosition (ELogType logType, bool unrepeat, sint32 line, const char *fileName, const char *funcName = NULL, const char* module = NULL, bool isSync = false);

#ifdef OS_WINDOWS

        /// Display a string in decorated and final new line form to all attached displayers. Call setPosition() before. Releases the mutex.
        void _displayGX (const char *format, ...);
        CHECK_TYPES(void displayGX, _displayGX);

        /// Display a string in decorated form to all attached displayers. Call setPosition() before. Releases the mutex.
        void _display (const char *format, ...);
        CHECK_TYPES(void display, _display);

        /// Display a string with a final new line to all attached displayers. Call setPosition() before. Releases the mutex.
        void _displayRawGX (const char *format, ...);
        CHECK_TYPES(void displayRawGX, _displayRawGX);

        /// Display a string (and nothing more) to all attached displayers. Call setPosition() before. Releases the mutex.
        void _displayRaw (const char *format, ...);
        CHECK_TYPES(void displayRaw, _displayRaw);

        /// Display a raw text to the normal displayer but without filtering
        /// It's used by the (little hack to work)
        void _forceDisplayRaw (const char *format, ...);
        CHECK_TYPES(void forceDisplayRaw, _forceDisplayRaw);

#else
        /// Display a string in decorated and final new line form to all attached displayers. Call setPosition() before. Releases the mutex.
        void displayGX (const char *format, ...);

        /// Display a string in decorated form to all attached displayers. Call setPosition() before. Releases the mutex.
        void display (const char *format, ...);

        /// Display a string with a final new line to all attached displayers. Call setPosition() before. Releases the mutex.
        void displayRawGX (const char *format, ...);

        /// Display a string (and nothing more) to all attached displayers. Call setPosition() before. Releases the mutex.
        void displayRaw (const char *format, ...);

        /// Display a raw text to the normal displayer but without filtering
        /// It's used by the Memdisplayer (little hack to work)
        void forceDisplayRaw (const char *format, ...);

#endif

        /// Adds a positive filter. Tells the logger to log only the lines that contain filterstr
        void addPositiveFilter( const char *filterstr );

        /// Adds a negative filter. Tells the logger to discard the lines that contain filterstr
        void addNegativeFilter( const char *filterstr );

        /// Reset both filters
        void resetFilters();

        /// Removes a filter by name (in both filters).
        void removeFilter( const char *filterstr = NULL);

        /// Displays the list of filter into a log
        void displayFilter( CLogger *log );

    public:
        /// Set the name of the process
        static void SetProcessName (const std::string &processName);
        /// Find the process name if nobody call setProcessName before
        static void SetDefaultProcessName ();
        /// Do not call this unless you know why you're doing it, it kills the debug/log system!
        static void ReleaseProcessName();

    protected:
        /// Symetric to setPosition(). Automatically called by display...(). Do not call if noDisplayer().
        void unsetPosition();

        /// Returns true if the string must be logged, according to the current filter
        bool passFilter( const char *filter );

        /// Display a string in decorated form to all attached displayers.
        void displayString (const char *str);

        /// Display a Raw string to all attached displayers.
        void displayRawString (const char *str);

        // 判断是否重复了
        bool isRepeat();

    protected:
        const char                         *_lastFileName;              // 上次文件名
        sint32                              _lastLine;                  // 上次行数
        const char                         *_lastFuncName;              // 上次函数名
		const char						   *_lastModuleName;			// 上次模块名

        bool                                _unrepeat;                  // 本次日志和上次日志不重复
        ELogType							_logType;                   // 日志类型
        const char							*_fileName;                 // 文件名
        sint32								 _line;                     // 行号
        const char							*_funcName;                 // 函数名
		const char							*_moduleName;				// 模块名
        TDisplayers							 _displayers;               // 需要过滤显示列表
        TDisplayers							 _bypassFilterDisplayers;	// 非过滤显示列表
        uint32								 _lockSet;                  // 加锁次数
        bool                                _sync;                      // 是否为异步日志

        std::list<std::string>				 _negativeFilter;           // 过滤字
        std::list<std::string>				 _positiveFilter;           // 非过滤字

        std::string							 _tempString;
        TDisplayInfo						 _tempArgs;

        typedef std::list<std::string>      TSynMsgList;
        CMsgQueue<std::string>              _synMsgQue;                 // 同步日志队列

    protected:
        static std::string					_processName;
    };

    class CSafeLog : public CLogger
    {
    protected:
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
}           // GXMISC

#endif