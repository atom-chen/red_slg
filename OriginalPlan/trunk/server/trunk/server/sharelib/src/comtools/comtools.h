/********************************************************************
	created:	2013/08/31
	created:	31:8:2013   10:09
	file base:	comtools
	file ext:	h
	author:		Z_Y_R
	
	purpose:	����������
*********************************************************************/
#ifndef _COMTOOLS_H_
#define _COMTOOLS_H_
//
//#include "game_util.h"
//#include "game_time.h"

//��ǰ����
static void convertTime(tm & info)
{
	time_t tt;
	::time(&tt);
	info = *localtime(&tt);
}

//Ŀ������
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
	// ��ǰʱ��
	GXMISC::TGameTime_t nowtime = DTimeManager.nowSysTime();
	testtt(nowtime);
	//����ʱ��
	GXMISC::TGameTime_t updatetime = hour * 3600 + min * 60 + sec;
	//24Сʱʱ��
	GXMISC::TGameTime_t onedaysec = 24 * 3600;

	//��ǰ24Сʱ�ڵ�ʱ��(��0ʱ��ʼ)
	GXMISC::TGameTime_t temptime = DTimeManager.getHour() * 3600 + DTimeManager.getMinute() * 60 + DTimeManager.getSecond();
	////����ʱ���µ�24Сʱ�ھ���ʱ��

	//�����һ��ĸ���ʱ��
	// ����ʱ�� - ����24Сʱ�ڵ��루��������ʱ�䣩 - ()
	GXMISC::TGameTime_t lastdaytime = nowtime - temptime - (onedaysec - updatetime);
	testtt(lastdaytime);
	//�������ʱ��
	GXMISC::TGameTime_t curdaytime = lastdaytime + onedaysec;
	testtt(curdaytime);
	//��һ��ĸ���ʱ��
	GXMISC::TGameTime_t nexttime	= curdaytime + onedaysec;
	testtt(nexttime);

	//�ж��Ƿ���ڵ�ǰ����ʱ��
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

//ʱ���ת����int 20140211
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