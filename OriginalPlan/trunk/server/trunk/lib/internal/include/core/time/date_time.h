#ifndef _DATE_TIME_H_
#define _DATE_TIME_H_

#include "types_def.h"
#include "timespan.h"
#include "time_gx.h"

// #if defined(OS_UNIX)
// #include "sys/time.h"
// #endif

namespace GXMISC
{
	/**
	* @brief 日期时间类
	*        表示某个时间 year/month/day hour:min:sec
	*/
	class CDateTime
	{
	public:
		/// 月份 (1 to 12).
		enum EMonths
		{
			JANUARY = 1,
			FEBRUARY,
			MARCH,
			APRIL,
			MAY,
			JUNE,
			JULY,
			AUGUST,
			SEPTEMBER,
			OCTOBER,
			NOVEMBER,
			DECEMBER
		};

		/// 星期 (1 to 7).
		enum EDaysOfWeek
		{
			MONDAY = 1,
			TUESDAY,
			WEDNESDAY,
			THURSDAY,
			FRIDAY,
			SATURDAY,
			SUNDAY
		};

		/**
		* @brief 创建日期时间类
		* @param isInitTime true表示用当前系统时间初始化
		*/
		CDateTime(bool isInitTime = false);
		/**
		* @brief 设置时间
		* @param year 0-9999
		*        month 1-12
		*        day 1-31
		*        hour 0-23
		*        minute 0-59
		*        second 0-59
		*/
		CDateTime(sint32 year, sint32 month, sint32 day, sint32 hour = 0, sint32 minute = 0, sint32 second = 0);
		CDateTime(TTime utcTime);
		CDateTime(const CDateTime& dateTime);
		~CDateTime();

		CDateTime& operator = (const CDateTime& dateTime);
		CDateTime& operator = (TTime utcTime);

	private:
		// 更新时间
		void updateByUTC();
		void updateByTM();

	public:
		/**
		* @brief 更新为系统当前时间
		*/
		void update();

		/**
		* @brief 设置时间
		* @param year 0-9999
		*        month 1-12
		*        day 1-31
		*        hour 0-23
		*        minute 0-59
		*        second 0-59
		*/
		CDateTime& assign(sint32 year, sint32 month, sint32 day, sint32 hour = 0, sint32 minute = 0, sint32 second = 0);

		/// 当前时间与另外时间互换
		void swap(CDateTime& dateTime);

		/// 返回当前时间的年
		sint32 year() const;

		/**
		* @brief 返回月份
		* @return 1-12
		*/
		EMonths month() const;

		/**
		* @brief 返回当前时间是当年的第几周
		* @param firstDayOfWeek 必须为SUNDAY(0) 或 MONDAY(1)  
		* @return 返回值为0-53. 根据ISO 8601, 第一个星期是指包含1.4号的星期
		*
		* @notice 以下示例假设firstDayOfWeek为MONDAY. 对于2005年, 第一天为星期六, 所以第一周从1.3号开始
		*         1.1, 1.2号为第0周(或者为上一年的周数)
		*         对于2007年, 1.1为星期1, 所以2007年没有第0周
		*/
		sint32 week(sint32 firstDayOfWeek = MONDAY) const;

		/**
		* @brief 返回当前天在月分中的天数
		* @return 1-31
		*/
		sint32 day() const;

		/** 
		* @brief 返回当前天在周的天数
		* @return 1-7(星期一~星期天)
		*/
		CDateTime::EDaysOfWeek dayOfWeek() const;

		/**
		* @brief 返回当前天在一年中的天数
		*/
		sint32 dayOfYear() const;

		/**
		* @brief 返回当前时间的时(24小时制)
		* @return 0-23
		*/
		sint32 hour() const;

		/**
		* @brief 获取当前时间的时(12小时制), 如果当前时间为上午, 则表示上午xxx时
		* @return 0-12
		*/
		sint32 hourAMPM() const;

		/// 判断是否为上午
		bool isAM() const;

		/// 判断是否为下午
		bool isPM() const;

		/**
		* @brief 返回当前时间的分钟
		* @return 0-59
		*/
		sint32 minute() const;

		/**
		* @brief 返回当前时间的秒数
		* @return 0-59
		*/
		sint32 second() const;

		/**
		* @brief 返回标准时间
		*/
		TTime utcTime() const;

		// 返回当前时间总共有多少天
		uint32 totalDays();

		// 返回总共有多少时
		uint32 totalHours();

		// 返回总共有多少分
		uint32 totalMins();

		// 返回总共有多少秒
		uint32 totalSecs();

		/// 两个时间的比较
		bool operator == (const CDateTime& dateTime) const;	
		bool operator != (const CDateTime& dateTime) const;	
		bool operator <  (const CDateTime& dateTime) const;	
		bool operator <= (const CDateTime& dateTime) const;	
		bool operator >  (const CDateTime& dateTime) const;	
		bool operator >= (const CDateTime& dateTime) const;	

		/// { @group
		/// 在当前时间上加上或减去一段时间
		CDateTime	operator +  (const CTimespan& span) const;
		CDateTime	operator -  (const CTimespan& span) const;
		const CTimespan	operator -  (const CDateTime& dateTime) const;
		CDateTime&	operator += (const CTimespan& span);
		CDateTime&	operator -= (const CTimespan& span);
		//         const CDateTime& addYears(uint32 y);
		//         const CDateTime& addMonths(uint32 m);
		//         const CDateTime& addWeeks(uint32 w);
		/// @group }

	public:
		/// 返回是否为闰年(true为闰年)
		static bool IsLeapYear(sint32 year);

		/// 返回在给定年份,指定月的天数(如, 2011,9月共有30天
		static sint32 DaysOfMonth(sint32 year, sint32 month);

		/// 检测给予的日期是否合法
		static bool IsValid(sint32 year, sint32 month, sint32 day, sint32 hour = 0, sint32 minute = 0, sint32 second = 0);

		/**
		* @brief 获取星期
		* @param wday 0-6(星期天~星期六)
		* @return 1-7(星期一~星期天)
		*/
		static EDaysOfWeek ToWeak(sint32 wday);

	private:
		time_t _utcTime;	// UTC时间
		tm _TM;				// TM时间
	};

	inline TTime CDateTime::utcTime() const
	{
		return _utcTime;
	}

	inline sint32 CDateTime::year() const
	{
		return _TM.tm_year+1900;
	}

	inline CDateTime::EMonths CDateTime::month() const
	{
		return EMonths(_TM.tm_mon+1);
	}

	inline sint32 CDateTime::day() const
	{
		return _TM.tm_mday;
	}

	inline sint32 CDateTime::hour() const
	{
		return _TM.tm_hour;
	}

	inline sint32 CDateTime::hourAMPM() const
	{
		if (hour() < 1)
		{
			return 12;
		}
		else if (hour() > 12)
		{
			return hour() - 12;
		}
		else
		{
			return hour();
		}
	}

	inline bool CDateTime::isAM() const
	{
		return hour() < 12;
	}

	inline bool CDateTime::isPM() const
	{
		return hour() >= 12;
	}

	inline sint32 CDateTime::minute() const
	{
		return _TM.tm_min;
	}

	inline sint32 CDateTime::second() const
	{
		return _TM.tm_sec;
	}

	inline bool CDateTime::operator == (const CDateTime& dateTime) const
	{
		return _utcTime == dateTime._utcTime;
	}

	inline bool CDateTime::operator != (const CDateTime& dateTime) const	
	{
		return _utcTime != dateTime._utcTime;
	}

	inline bool CDateTime::operator <  (const CDateTime& dateTime) const	
	{
		return _utcTime < dateTime._utcTime;
	}

	inline bool CDateTime::operator <= (const CDateTime& dateTime) const
	{
		return _utcTime <= dateTime._utcTime;
	}

	inline bool CDateTime::operator >  (const CDateTime& dateTime) const
	{
		return _utcTime > dateTime._utcTime;
	}

	inline bool CDateTime::operator >= (const CDateTime& dateTime) const	
	{
		return _utcTime >= dateTime._utcTime;
	}

	inline bool CDateTime::IsLeapYear(sint32 year)
	{
		return (year % 4) == 0 && ((year % 100) != 0 || (year % 400) == 0);
	}

	inline void swap(CDateTime& d1, CDateTime& d2)
	{
		d1.swap(d2);
	}
}	// namespace GXMISC

#endif // 
