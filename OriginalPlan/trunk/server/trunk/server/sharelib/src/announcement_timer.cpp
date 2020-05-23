#include "announcement_timer.h"


CBroadTimer::CBroadTimer()
{
	cleanUp();
}

CBroadTimer::~CBroadTimer()
{
	cleanUp();
}

bool CBroadTimer::update( GXMISC::TDiffTime_t diff )
{
	if ( DTimeManager.nowSysTime() < _broadData._startTime )
	{
		return false;
	}
	_timer.update(diff);
	if ( _timer.isPassed() )
	{
		_timer.reset();
		return true;
	}

	return false;
}

bool CBroadTimer::init( TAnnouncementID_t id, const TBroadInfo* info )
{
	_broadData._startTime = info->_startTime;
	_broadData._endTime = info->_endTime;
	_broadData._interval = info->_interval;
	_broadData._chatStr = info->_chatStr;
	_timer.init(_broadData._interval * GXMISC::MILL_SECOND_IN_SECOND);
	_id = id;
	return true;
}

bool CBroadTimer::isNeedDel()
{
	return (DTimeManager.nowSysTime() >= _broadData._endTime);
}

void CBroadTimer::cleanUp()
{
	_broadData._startTime = GXMISC::INVALID_GAME_TIME;
	_broadData._endTime = GXMISC::INVALID_GAME_TIME;
	_broadData._interval = GXMISC::INVALID_GAME_TIME;
	_broadData._chatStr.clear();
	_id = INVALID_ANNOUNCEMENT_ID;
}
