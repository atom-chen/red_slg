#include "time_manager.h"
#include "sstring.h"
#include "debug.h"
#include "types_def.h"

GXMISC::CTimeManager g_TimeMgr;

namespace GXMISC
{
    CTimeManager::CTimeManager( )
    {
        _currentTime = 0 ;
        _startTime = 0;
        init();
    }

    CTimeManager::~CTimeManager( )
    {
    }

    void CTimeManager::init( )
    {
#if defined(OS_WINDOWS)
        _startTime =    SystemCall::GetTickCount() ;
        _currentTime =  SystemCall::GetTickCount() ;
#elif defined(OS_UNIX)
        _startTime		= 0;
        _currentTime	= 0;
        SystemCall::gettimeofday(&_TStart, &_TZ);
#endif

        localTime( ) ;

        memset(_timeBuffer, 0, 100);
    }

    TGameTime_t CTimeManager::nowSysTime( )
    {
        return (TGameTime_t)_setTime;
    }

    TGameTime_t CTimeManager::SysNowTime()
    {
        return CTimeManager::AnsiToGxTime(time( NULL ));
    }

    uint32 CTimeManager::currentDate()
    {
        localTime( ) ;
        uint32 Date;
        ConvertTU(&_tm, Date);

        return Date;
    }

	struct tm *	CTimeManager::LocalTime(const TTime *timep)
	{
		return (tm*)localtime((TTime*)timep);
	}

    void CTimeManager::localTime( )
    {
		time((TTime*)&_setTime);
		tm tempTm;
		tm* ptm = CTimeManager::LocalTime((TTime*)&_setTime, &tempTm);
        _tm = *ptm ;
    }

    // 得到标准时间
    TGameTime_t CTimeManager::getANSITime( )
    {
        localTime();
        return (TGameTime_t)_setTime;
    }

    uint32 CTimeManager::time2Number( )
    {
        localTime( ) ;

        uint32 uRet=0 ;

        uRet += getYear( ) ;
        uRet -= 2000 ;
        uRet =uRet*100 ;

        uRet += getMonth( )+1 ;
        uRet =uRet*100 ;

        uRet += getDay( ) ;
        uRet =uRet*100 ;

        uRet += getHour( ) ;
        uRet =uRet*100 ;

        uRet += getMinute( ) ;

        return uRet ;
    }

    uint32 CTimeManager::DiffTime( uint32 date1, uint32 date2 )
    {
		tm S_D1, S_D2 ;
		ConvertUT( date1, &S_D1 ) ;
		ConvertUT( date2, &S_D2 ) ;
		TTime t1, t2;
		t1 = mktime(&S_D1) ;
        t2 = mktime(&S_D2) ;
        uint32 dif = (uint32)(difftime(t2,t1)*1000) ;
        return dif ;
    }

    void CTimeManager::ConvertUT( uint32 Date, tm* TM )
    {
        gxAssert(TM) ;
        memset( TM, 0, sizeof(tm) ) ;
        TM->tm_year = (Date>>26)&0xf ;
        TM->tm_mon  = (Date>>22)&0xf ;
        TM->tm_mday = (Date>>17)&0x1f ;
        TM->tm_hour = (Date>>12)&0x1f ;
        TM->tm_min  = (Date>>6) &0x3f ;
        TM->tm_sec  = (Date)&0x3f ;
    }

    void CTimeManager::ConvertTU( tm* TM, uint32& Date )
    {
        gxAssert( TM ) ;
        Date = 0 ;
        Date += (TM->tm_yday%10) & 0xf ;
        Date = (Date<<4) ;
        Date += TM->tm_mon & 0xf ;
        Date = (Date<<4) ;
        Date += TM->tm_mday & 0x1f ;
        Date = (Date<<5) ;
        Date += TM->tm_hour & 0x1f ;
        Date = (Date<<5) ;
        Date += TM->tm_min & 0x3f ;
        Date = (Date<<6) ;
        Date += TM->tm_sec & 0x3f ;
    }

    uint32 CTimeManager::getDayTime( )
    {
        tm tempTm;
		tm* ptm = CTimeManager::LocalTime((TTime*)&_setTime, &tempTm);

        uint32 uRet=0 ;

        uRet  = (ptm->tm_year-100)*1000 ;
        uRet += ptm->tm_yday ;

        return uRet ;
    }

    uint32 CTimeManager::getTodayTime()
    {
        tm tempTm;
		tm* ptm = CTimeManager::LocalTime((TTime*)&_setTime, &tempTm);
        uint32 uRet=0 ;
        uRet  = ptm->tm_hour*100 ;
        uRet += ptm->tm_min ;

        return uRet ;
    }

    bool CTimeManager::FormatTodayTime(uint32& nTime)
    {
        bool ret = false;

        uint32 uHour = nTime / 100;
        uint32 uMin = nTime % 100;
        uint32 uAddHour = 0;
        if( uMin > 59 )
        {
            uAddHour = uMin / 60;
            uMin = uMin % 60;
        }
        uHour += uAddHour;
        if( uHour > 23 )
        {
            ret = true;
            uHour = uHour % 60;
        }

        return ret;
    }

    std::string CTimeManager::getHumanRelativeTime( sint32 nbSeconds )
    {
        sint32 delta = nbSeconds;
        if (delta < 0)
            delta = -delta;

        const sint32 oneMinute = 60;
        const sint32 oneHour = oneMinute * 60;
        const sint32 oneDay = oneHour * 24;
        const sint32 oneWeek = oneDay * 7;
        const sint32 oneMonth = oneDay * 30;
        const sint32 oneYear = oneDay * 365;

        sint32 year, month, week, day, hour, minute;
        year = month = week = day = hour = minute = 0;

        year = delta / oneYear;
        delta %= oneYear;

        month = delta / oneMonth;
        delta %= oneMonth;

        week = delta / oneWeek;
        delta %= oneWeek;

        day = delta / oneDay;
        delta %= oneDay;

        hour = delta / oneHour;
        delta %= oneHour;

        minute = delta / oneMinute;
        delta %= oneMinute;

        CSString ret;
        if (year)
            ret << year << " years ";
        if (month)
            ret << month << " months ";
        if (week)
            ret << week << " weeks ";
        if (day)
            ret << day << " days ";
        if (hour)
            ret << hour << " hours ";
        if (minute)
            ret << minute << " minutes ";
        if (delta || ret.empty())
            ret << delta << " seconds ";

        return ret;
    }

    TAppTime_t CTimeManager::update()
    {
        getANSITime();
	
		strftime (_timeBuffer, 100, "%Y-%m-%d %H:%M:%S", &_tm);

#if defined(OS_WINDOWS)
        _currentTime = GetTickCount() ;
#elif defined(OS_UNIX)
        gettimeofday(&_TEnd, &_TZ);
        double t1, t2;
        t1 =  (double)_TStart.tv_sec*1000 + (double)_TStart.tv_usec/1000;
        t2 =  (double)_TEnd.tv_sec*1000 + (double)_TEnd.tv_usec/1000;
        _currentTime = (TAppTime_t)(t2-t1);
#endif

        return _currentTime ;
    }

	GXMISC::TAppTime_t CTimeManager::AppNowTime()
	{
#if defined(OS_WINDOWS)
		return GetTickCount() ; // @TODO 使用更高精度的64位函数
#elif defined(OS_UNIX)
		gettimeofday(&_TEnd,NULL);
		double t1, t2;
		t1 =  (double)_TStart.tv_sec*1000 + (double)_TStart.tv_usec/1000;
		t2 =  (double)_TEnd.tv_sec*1000 + (double)_TEnd.tv_usec/1000;
		return (TAppTime_t)(t2-t1);
#endif
	}

	GXMISC::TGameTime_t CTimeManager::AnsiToGxTime(TTime times)
    {
        return (TGameTime_t)times;
    }

	TTime CTimeManager::GxToAnsiTime(TGameTime_t times)
    {
        return times;
    }

	void CTimeManager::FormatSystemTime(TTime times, std::string& str)
    {
        static char cstime[100];
		TTime tt = CTimeManager::GxToAnsiTime((TGameTime_t)times);
		tm tempTm;
		tm* tms = CTimeManager::LocalTime((TTime*)&tt, &tempTm);
        if (tms)
        {
            strftime (cstime, 100, "%Y-%m-%d %H:%M:%S", tms);
        }
        else
        {
            sprintf(cstime, "bad date %d", (uint32)tt);
        }
        str = cstime;
    }

    const char* CTimeManager::toStandardTimeFormat( std::string& str )
    {
        str = _timeBuffer;
        return _timeBuffer;
    }

    const char* CTimeManager::toStandardTimeFormat()
    {
        return _timeBuffer;
    }

    sint32 CTimeManager::getYear()
    {
        return _tm.tm_year+1900 ;
    }

    sint32 CTimeManager::getMonth()
    {
	    return _tm.tm_mon ;
    }
	sint32 CTimeManager::getLocalMonth()
	{
		return getMonth()+1;
	}

    sint32 CTimeManager::getDay()
    {
        return _tm.tm_mday; 
    }

    sint32 CTimeManager::getHour()
    {
		return _tm.tm_hour; 
    }

    sint32 CTimeManager::getMinute()
    {
	    return _tm.tm_min;
    }

    sint32 CTimeManager::getSecond()
    {
	    return _tm.tm_sec;
    }

    sint32 CTimeManager::getWeek()
    {
	    return _tm.tm_wday;
    }

    sint32 CTimeManager::getLocalWeek()
    {
	    return CDateTime::ToWeak(_tm.tm_wday);
    }

	struct tm * CTimeManager::LocalTime(const TTime *timep, struct tm *result)
	{
#if defined(OS_WINDOWS)
		localtime_s(result, timep);
		return result;
#elif defined(OS_UNIX)
		return localtime_r(timep, result);
#endif
	}

	GXMISC::TGameTime_t CTimeManager::ToLocalTime(const TTime times)
	{
		return (GXMISC::TGameTime_t)times + GetTimeUTCDiff();
	}

	GXMISC::TGameTime_t CTimeManager::ToLocalTime()
	{
		return ToLocalTime(SysNowTime());
	}

	GXMISC::TGameTime_t CTimeManager::LocalNowTime()
	{
		return ToLocalTime();
	}

	TGameTime_t CTimeManager::GetTimeUTCDiff()
	{
#ifdef OS_WINDOWS
		long zone = 0;
		_get_timezone(&zone);
		return -zone;
#else
		//TTimeVal_t times;
		struct timezone zone;
		gettimeofday(NULL,&zone);
		return -(TGameTime_t)zone.tz_minuteswest*60;
#endif
	}
}			// GXMISC