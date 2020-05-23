#include <algorithm>
#include <cmath>
#include <ctime>

#include "date_time.h"
#include "timespan.h"
#include "debug.h"

namespace GXMISC
{
	CDateTime::CDateTime(bool isInitTime)
	{
        memset(&_TM, 0, sizeof(_TM));
        _utcTime = 0;
		if(isInitTime)
		{
			update();
		}
	}

	CDateTime::CDateTime(sint32 year, sint32 month, sint32 day, sint32 hour, sint32 minute, sint32 second)
	{
        memset(&_TM, 0, sizeof(_TM));
        _utcTime = 0;

		gxAssert (year >= 0 && year <= 9999);
		gxAssert (month >= 1 && month <= 12);
		gxAssert (day >= 1 && day <= DaysOfMonth(year, month));
		gxAssert (hour >= 0 && hour <= 23);
		gxAssert (minute >= 0 && minute <= 59);
		gxAssert (second >= 0 && second <= 59);

		_TM.tm_year = year-1900;
		_TM.tm_mon = month-1;
		_TM.tm_mday = day;
		_TM.tm_hour = hour;
		_TM.tm_min = minute;
		_TM.tm_sec = second;

		updateByTM();
	}


	CDateTime::CDateTime(TTime utcTime) :
	_utcTime(utcTime)
	{
        memset(&_TM, 0, sizeof(_TM));
		updateByUTC();
	}

	CDateTime::CDateTime(const CDateTime& dateTime):
	_utcTime(dateTime._utcTime),
		_TM(dateTime._TM)
	{
	}


	CDateTime::~CDateTime()
	{
	}


	CDateTime& CDateTime::operator = (const CDateTime& dateTime)
	{
		if (&dateTime != this)
		{
			_utcTime     = dateTime._utcTime;
			_TM			 = dateTime._TM;
		}
		return *this;
	}


	CDateTime& CDateTime::operator = (TTime times)
	{
		_utcTime = times;
		updateByUTC();
		return *this;
	}

	void CDateTime::updateByUTC()
	{
		CTimeManager::LocalTime(&_utcTime, &_TM);
	}

	void CDateTime::updateByTM()
	{
		_utcTime = mktime(&_TM);
	}

	void CDateTime::update()
	{
		_utcTime = time(NULL);
		updateByUTC();
	}

	CDateTime& CDateTime::assign(sint32 year, sint32 month, sint32 day, sint32 hour, sint32 minute, sint32 second)
	{
		gxAssert (year >= 0 && year <= 9999);
		gxAssert (month >= 1 && month <= 12);
		gxAssert (day >= 1 && day <= DaysOfMonth(year, month));
		gxAssert (hour >= 0 && hour <= 23);
		gxAssert (minute >= 0 && minute <= 59);
		gxAssert (second >= 0 && second <= 59);

		_TM.tm_year = year-1900;
		_TM.tm_mon = month-1;
		_TM.tm_mday = day;
		_TM.tm_hour = hour;
		_TM.tm_min = minute;
		_TM.tm_sec = second;

		updateByTM();

		return *this;
	}


	void CDateTime::swap(CDateTime& dateTime)
	{
		std::swap(_utcTime, dateTime._utcTime);
		std::swap(_TM, dateTime._TM);
	}


	CDateTime::EDaysOfWeek CDateTime::dayOfWeek() const
	{
		return CDateTime::ToWeak(_TM.tm_wday);
	}

	sint32 CDateTime::dayOfYear() const
	{
		return _TM.tm_yday;
	}

	sint32 CDateTime::DaysOfMonth(sint32 year, sint32 month)
	{
		gxAssert (month >= 1 && month <= 12);

		static sint32 daysOfMonthTable[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

		if (month == 2 && IsLeapYear(year))
		{
			return 29;
		}
		else
		{
			return daysOfMonthTable[month];
		}
	}


	bool CDateTime::IsValid(sint32 year, sint32 month, sint32 day, sint32 hour, sint32 minute, sint32 second)
	{
		return
			(year >= 0 && year <= 9999) &&
			(month >= 1 && month <= 12) &&
			(day >= 1 && day <= DaysOfMonth(year, month)) &&
			(hour >= 0 && hour <= 23) &&
			(minute >= 0 && minute <= 59) &&
			(second >= 0 && second <= 59);
	}


	CDateTime::EDaysOfWeek CDateTime::ToWeak( sint32 wday )
	{
		if(wday == 0)
		{
			return SUNDAY;
		}
		else
		{
			return (EDaysOfWeek)wday;
		}
	}

	sint32 CDateTime::week(sint32 firstDayOfWeek) const
	{
		gxAssert (firstDayOfWeek >= 0 && firstDayOfWeek <= 6);

		/// 查找第一个 firstDayOfWeek.
		sint32 baseDay = 1;
		while (CDateTime(year(), 1, baseDay).dayOfWeek() != firstDayOfWeek) ++baseDay;

		sint32 doy  = dayOfYear();
		sint32 offs = baseDay <= 4 ? 0 : 1; 
		if (doy < baseDay)
		{
			return offs;
		}
		else
		{
			return (doy - baseDay)/7 + 1 + offs;
		}
	}

	CDateTime CDateTime::operator + (const CTimespan& span) const
	{
		return CDateTime(_utcTime+span.totalSeconds());
	}

	CDateTime CDateTime::operator - (const CTimespan& span) const
	{
		return CDateTime(_utcTime-span.totalSeconds());
	}

	const CTimespan CDateTime::operator - (const CDateTime& dateTime) const
	{
        TTimeDiff_t diff = _utcTime - dateTime._utcTime;
        CTimespan a(diff);
        return a;
	}

	CDateTime& CDateTime::operator += (const CTimespan& span)
	{
		_utcTime += span.totalSeconds();
		updateByUTC();
		return *this;
	}

	CDateTime& CDateTime::operator -= (const CTimespan& span)
	{
		_utcTime -= span.totalSeconds();
		updateByUTC();
		return *this;
	}

	uint32 CDateTime::totalDays()
	{
		return (uint32)_utcTime/(24*3600);
	}

	uint32 CDateTime::totalMins()
	{
		return (uint32)_utcTime/60;
	}

	uint32 CDateTime::totalHours()
	{
		return (uint32)_utcTime/3600;
	}

	uint32 CDateTime::totalSecs()
	{
		return (uint32)_utcTime;
	}

//     const CDateTime& CDateTime::addYears( uint32 y )
//     {
//         boost::date_time::date d(year(), month(), day());
//         d += boost::gregorian::years(y);
//         _TM.tm_year = d.year()-1900;
//         _TM.tm_mon = d.month()-1;
//         _TM.
//     }
//
//     const CDateTime& CDateTime::addMonths( uint32 m )
//     {
// 
//     }
// 
//     const CDateTime& CDateTime::addWeeks( uint32 w )
//     {
//     }
}	// namespace GXMISC