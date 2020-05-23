#ifndef _TIME_UTIL_H_
#define _TIME_UTIL_H_

#include "base_util.h"

namespace GXMISC
{
    typedef time_t TTime_t;                             // 系统时间
	static const TTime_t MAX_TIME = MAX_SINT32_NUM;
    typedef sint64 TAppTime_t;                          // 程序运行的毫秒数
    typedef sint32 TDiffTime_t;                         // 时间差值
    static const TDiffTime_t DEFAULT_DIFF_TIME = 0;     // 默认值
	typedef uint32 TGameTime_t;											// 游戏内的游戏时间, 主要用于数据库及发送给客户端
	static const TGameTime_t INVALID_GAME_TIME = 0;						// 游戏无效时间
	static const TGameTime_t MAX_GAME_TIME = GXMISC::MAX_UINT32_NUM;
	typedef uint32	TGameTimerID_t;										// 时间管理器ID
	
	static const TGameTimerID_t		INVALID_GAME_TIMER_ID = 0;
	typedef uint8		TGameTimerIndex_t;								// 有效时间的索引
	static const TGameTimerIndex_t	INVALID_GAME_TIMER_INDEX = GXMISC::MAX_UINT8_NUM;
	enum EServerConstValue
	{
		MILL_SECOND_IN_SECOND = 1000,					// 一秒的毫秒数	

		SECOND_IN_MINUTE = 60,							// 一分钟的秒数
		MILL_SECOND_IN_MINUTE = 60000,					// 一分钟的毫秒数

		MINUTE_IN_HOUR = 60,							// 一小时的分钟数
		SECOND_IN_HOUR = 3600,							// 一小时的秒数
		MILL_SECOND_IN_HOUR = 3600000,					// 一小时的毫秒数

		HOUR_IN_DAY = 24,								// 一天的小时数
		MINUTE_IN_DAY = 1440,							// 一天的分钟数
		SECOND_IN_DAY = 86400,							// 一天的秒数
		MILL_SECOND_IN_DAY = 86400000,					// 一天的毫秒数

		DAY_IN_WEEKDAY = 7,								// 一周的天数
		HOUR_IN_WEEKDAY = 168,							// 一周的小时数
		MINUTE_IN_WEEKDAY = 10080,						// 一周的分钟数
		SECOND_IN_WEEKDAY = 604800,						// 一周的秒数
		MILL_SECOND_IN_WEEKDAY = 604800000,				// 一周的毫秒数

		UTC_DIFF_TIME = 28800,							// 北京时间与UTC时间差(秒)
	};
}
#endif