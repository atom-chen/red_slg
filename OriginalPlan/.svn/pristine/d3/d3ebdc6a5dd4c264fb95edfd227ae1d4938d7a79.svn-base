#include "stop_timer.h"

CStopTimer::CStopTimer()
{
	initData();
}

CStopTimer::~CStopTimer()
{
}

void CStopTimer::initData()
{
	_scriptEngine = NULL;
	_service = NULL;
	_stopStartTime = GXMISC::MAX_GAME_TIME;
	_stopLastTime = 0;
	_stopSaveTime = 0;
}

void CStopTimer::update( GXMISC::TDiffTime_t diff )
{
	doStopSave();
	doStop();
}

bool CStopTimer::isStopTime()
{
	if(getStopLastTime() <= 0)
	{
		return false;
	}

	return GXMISC::TDiffTime_t(DTimeManager.nowSysTime()-getStopStartTime()) > getStopLastTime();
}

bool CStopTimer::isSaveTime()
{
	if(getStopSaveTime() <= 0)
	{
		return false;
	}

	return GXMISC::TDiffTime_t(DTimeManager.nowSysTime()-getStopStartTime()) > getStopSaveTime();
}

void CStopTimer::doStopSave()
{
	if(isSaveTime())
	{
		_scriptEngine->vCall("StopServiceSave");
		setStopSaveTime(0);
	}
}

void CStopTimer::doStop()
{
	if(isStopTime())
	{
		gxInfo("Service time to stop!");
		_service->setStop();
		setStopLastTime(0);
	}
}

bool CStopTimer::isStop()
{
	return getStopLastTime() > 0;
}

void CStopTimer::onStop( GXMISC::TDiffTime_t lastStopTime, GXMISC::TDiffTime_t saveTime )
{
	setStopStartTime(DTimeManager.nowSysTime());
	setStopLastTime(lastStopTime);
	setStopSaveTime(saveTime);
}
