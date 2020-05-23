/********************************************************************
	created:	2013/08/31
	created:	31:8:2013   10:09
	file base:	comtools
	file ext:	h
	author:		Z_Y_R
	
	purpose:	公共工具类
*********************************************************************/
#ifndef _COMTOOLS_H_
#define _COMTOOLS_H_
//
//#include "game_util.h"
//#include "game_time.h"

//当前日期
static void convertTime(tm & info)
{
	time_t tt;
	::time(&tt);
	info = *localtime(&tt);
}

//目标日期
static void convertTargetTime(GXMISC::TGameTime_t timevar, tm & info)
{
	time_t tt = timevar;
	//::time(&tt);
	info = *localtime(&tt);
}

static void testtt(const GXMISC::CGameTime & timeeee)
{
	time_t tt;
	tt = timeeee.getGameTime();
	//::time(&tt);
	tm info;
	info = *localtime(&tt);

	//printf("%d %d %d\n", info.tm_mon+1, info.tm_mday, info.tm_hour);
}

static bool isOverTime(const GXMISC::CGameTime & opertime, uint8 hour, uint8 min, uint8 sec)
{
	if(opertime.getGameTime() == 0)
	{
		return true;
	}

	testtt(opertime);
	// 当前时间
	GXMISC::TGameTime_t nowtime = DTimeManager.nowSysTime();
	testtt(nowtime);
	//更新时间
	GXMISC::TGameTime_t updatetime = hour * 3600 + min * 60 + sec;
	//24小时时间
	GXMISC::TGameTime_t onedaysec = 24 * 3600;

	//当前24小时内的时间(从0时开始)
	GXMISC::TGameTime_t temptime = DTimeManager.getHour() * 3600 + DTimeManager.getMinute() * 60 + DTimeManager.getSecond();
	////更新时间下的24小时内具体时间

	//求出上一天的更新时间
	// 当天时间 - 当天24小时内的秒（当天已用时间） - ()
	GXMISC::TGameTime_t lastdaytime = nowtime - temptime - (onedaysec - updatetime);
	testtt(lastdaytime);
	//当天更新时间
	GXMISC::TGameTime_t curdaytime = lastdaytime + onedaysec;
	testtt(curdaytime);
	//下一天的更新时间
	GXMISC::TGameTime_t nexttime	= curdaytime + onedaysec;
	testtt(nexttime);

	//判断是否大于当前更新时间
	if(nowtime >= curdaytime)
	{
		if(opertime.getGameTime() < curdaytime)
		{
			return true;
		}
	}
	else
	{
		if(opertime.getGameTime() < lastdaytime)
		{
			return true;
		}
	}

	return false;
}

//时间戳转换到int 20140211
static GXMISC::TGameTime_t CovtertTimeToDay(GXMISC::TGameTime_t datetime)
{
	time_t tick;
	struct tm tt;
	char timestr[100];

	stringstream strt;

	tick = datetime;

	tt = *localtime(&tick);

	strftime(timestr, sizeof(timestr), "%Y%m%d", &tt);

	strt.str(timestr);

	GXMISC::TGameTime_t covtime = 0;
	strt>>covtime;
	return covtime;
}

#endif//_COMTOOLS_H_