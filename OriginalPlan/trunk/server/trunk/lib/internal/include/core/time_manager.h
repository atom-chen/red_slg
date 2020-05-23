#ifndef _TIME_MANAAGER_H_
#define _TIME_MANAAGER_H_

#include "types_def.h"
#include "singleton.h"
#include "time_val.h"
#include "time_util.h"
#include "time_gx.h"

#include "time/date_time.h"

namespace GXMISC
{   
	/**
	* @brief @TODO 分成应用程序时间和系统标准时间 
	*/
	class CTimeManager
	{
	public :
		CTimeManager();
		~CTimeManager();

	private:
		/**
		* @brief 静态初始化起始时间
		*/
		void                init();

	public:
		/**
		* @brief 更新系统时间 
		*/
		TAppTime_t          update();

		/** @brief 系统当前时间, 不调用系统接口, 直接返回保存的系统时间 */
		TGameTime_t             nowSysTime( ) ;

		/**
		* @brief 返回自程序启动以来运行的时间
		*        返回的值为：千分之一秒时间
		*/
		TAppTime_t          nowAppTime() { return _currentTime ; }

		/** @brief 取得服务器启动后的运行时间（毫秒） */
		TAppTime_t          runTime() { return (_currentTime-_startTime); }

		// 将系统时间格式化成形如的时间2011-01-01 23:00:00
		const char*         toStandardTimeFormat(std::string& str);
		const char*         toStandardTimeFormat();


	public:
		sint32 getYear();   ///< @brief [1900,????]
		sint32 getMonth();  ///< @brief [0,11]
		sint32 getLocalMonth();	///< @brief [1,12]
		sint32 getDay();    ///< @brief [1,31]
		sint32 getHour();   ///< @brief [0,23]
		sint32 getMinute(); ///< @brief [0,59]
		sint32 getSecond(); ///< @brief [0,59]
		sint32 getWeek();   ///< @brief 取得当前是星期几；0表示：星期天，1～6表示：星期一～星期六
		sint32 getLocalWeek();///< @brief 取得当前是星期几；0表示：星期天，1～6表示：星期一～星期六

	public:
		/**
		* @brief 将当前的时间（年、月、日、小时、分）转换成一个time_t来表示
		*		  例如：0,507,211,233 表示 "2005.07.21 12:33"
		*/
		uint32			time2Number( ) ;
		/** @brief 取得当前的日期[4bit 0-9][4bit 0-11][5bit 0-30][5bit 0-23][6bit 0-59][6bit 0-59]*/
		uint32			currentDate( ) ;
		//取得已天为单位的时间值, 千位数代表年份，其他三位代表时间（天数）
		uint32	        getDayTime( ) ;
		//得到当前是今天的什么时间2310表示23点10分
		uint32	        getTodayTime();

	public:
		// 取得两个日期时间的时间差（单位：毫秒）, Ret = Date2-Data1
		static uint32	DiffTime( uint32 Date1, uint32 Date2 ) ;
		// 将一个UINT的日期转换成一个tm结构
		static void		ConvertUT( uint32 Date, tm* TM ) ;
		// 将一个tm结构转换成一个UINT的日期
		static void		ConvertTU( tm* TM, uint32& Date ) ;
		// 将getTodayTime获取到的时间格式化
		static bool		FormatTodayTime(uint32& nTime);
		// 将指定的秒数转换成时间字符串, 返回结果类似: 1 years 2 months 2 days 10 seconds 
		static std::string	getHumanRelativeTime(sint32 nbSeconds);
		// 将系统时间格式化成形如的时间2011-01-01 23:00:00
		static void FormatSystemTime(TTime times, std::string& str);

	public:
		// UTC线程安全的时间 
		static TGameTime_t      SysNowTime();
		// 线程安全的系统高精度时间
		static TAppTime_t		AppNowTime();
		// 本地线程安全时间
		static TGameTime_t		LocalNowTime();

	public:
		// 自定义的时间到标准时间的转换
		static TGameTime_t		AnsiToGxTime(TTime times);
		static TTime			GxToAnsiTime(TGameTime_t times);
		//格式化系统时间
		static struct tm * LocalTime(const TTime *timep);
		static struct tm * LocalTime(const TTime *timep, struct tm *result);

		// 将当前时间转换成本地时间(传入的参数时间必须是通过time()函数获得的)
		static TGameTime_t ToLocalTime(const TTime times);
		static TGameTime_t ToLocalTime();

		// 得到与UTC相差的时间
		static TGameTime_t GetTimeUTCDiff();

	public:
		/**
		* @brief 取得服务器端程序启动时的时间计数值
		*        返回的值为：毫秒单位的时间值
		*/
		TAppTime_t      startAppTime( ){ return _startTime ; }

		/**
		* @brief 将当前的系统时间格式化到时间管理器里
		*/
		void            localTime( ) ;

		/**
		* @brief 得到标准时间
		*        返回值为: 系统时间
		*/
		TGameTime_t         getANSITime();

	private:
		struct tm           _tm;					///< @brief 当前系统本地的时间结构
		TAppTime_t			_startTime ;			///< @brief 系统的起始时间(单位为毫秒)
		TAppTime_t			_currentTime ;			///< @brief 系统的当前时间(单位为毫秒)
		TTime_t			    _setTime ;				///< @brief 当前系统时间(单位为秒)
		char                _timeBuffer[100];       ///< @brief 标准化过的时间字符串 形如: 2011-01-01 23:00:00
#ifdef OS_UNIX
		TTimeVal_t  _TStart, _TEnd;			
		struct timezone _TZ;
#endif
	};

}		// namespace GXMISC

extern GXMISC::CTimeManager g_TimeMgr;
#define DTimeManager g_TimeMgr

#endif