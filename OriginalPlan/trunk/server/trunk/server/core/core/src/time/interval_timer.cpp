#include "interval_timer.h"
#include "debug.h"
#include "base_util.h"

namespace GXMISC
{
	void CIntervalTimerMgr::update( TTime diff )
	{
		for(TIntervalTimerList::iterator iter = _timerList.begin(); iter != _timerList.end(); ++iter)
		{
			(*iter)->update(diff);
		}

		for(TIntervalTimerList::iterator  iter = _timerList.begin(); iter != _timerList.end(); ++iter)
		{
            CIntervalTimer* timer = *iter;
			if(!timer->isValid())
			{
				iter = _timerList.erase(iter);
                if(timer->isNeedFree())
                {
                    DSafeDelete(timer);
                }
			}
			else
			{
				++iter;
			}
		}
	}

	void CIntervalTimerMgr::addTimer( CIntervalTimer* timer, bool isNeedFree /* = true */ )
	{
        if(isNeedFree)
        {
            timer->setNeedFree();
        }
		_timerList.push_back(timer);
	}

	CIntervalTimerMgr::CIntervalTimerMgr()
	{
		_timerList.clear();
	}

	CIntervalTimerMgr::~CIntervalTimerMgr()
	{
		for(TIntervalTimerList::iterator iter = _timerList.begin(); iter != _timerList.end(); ++iter)
		{
			DSafeDelete(*iter);
		}
	}

    void CIntervalTimer::update( TTime diff )
    {
        gxAssert(_curInterval > 0);

        if(_curInterval > diff)
        {
            _curInterval -= diff;
        }
        else
        {
            doTimeout();
            _curInterval = _maxInterval;
        }
    }
	
	void CIntervalTimer::doTimeout()
	{
		gxAssert(isValid());
		if(isValid())
		{
			onTimeout();
			if(!isUnlimit())
			{
				--_num;
			}
		}
	}

	void CIntervalTimer::setMaxInterval( TTime maxInterval )
	{
		_maxInterval = maxInterval;
	}

	void CIntervalTimer::setMaxNum( uint32 num )
	{
		_maxNum = num;
	}

	bool CIntervalTimer::isPassed()
	{
		return _curInterval >= _maxInterval;
	}

	CIntervalTimer::CIntervalTimer( uint32 maxInterval, uint32 num /*= INVALID_INTERVAL_TIMER_COUNT*/)  
        : _maxNum(num),_num(num), _curInterval(0), _maxInterval(maxInterval)
	{
		gxAssert(num > 0);
		gxAssert(maxInterval > 0);
        _isNeedFree = false;
	}

	CIntervalTimer::CIntervalTimer()
	{
		_maxNum = 0;
		_num = 0;
		_curInterval = MAX_TIME;
		_maxInterval = MAX_TIME;
		_isNeedFree = false;
	}

	bool CIntervalTimer::isUnlimit()
	{
		return _num == INVALID_INTERVAL_TIMER_COUNT;
	}

	bool CIntervalTimer::isValid()
	{
		return (!isUnlimit() && _num > 0) || isUnlimit();
	}

	void CIntervalTimer::reset(bool force)
	{
		if(force)
		{
			_curInterval = 0;
			_num = _maxNum;
		}
		else
		{
			_curInterval = _curInterval > _maxInterval ? _curInterval-_maxInterval : 0;
			_num = _maxNum;
		}
	}

	void CIntervalTimer::init( uint32 maxInterval, uint32 num /*= INVALID_INTERVAL_TIMER_COUNT*/ )
	{
		gxAssert(num > 0);
		gxAssert(maxInterval > 0);
		_maxInterval = maxInterval;
		_maxNum = num;
		_curInterval = maxInterval;
		_num = num;
	}

    CIntervalTimer::~CIntervalTimer()
    {

    }

    bool CIntervalTimer::isNeedFree()
    {
        return _isNeedFree;
    }

    void CIntervalTimer::setNeedFree()
    {
        _isNeedFree = true;
    }

	GXMISC::TTime CIntervalTimer::getCurInterval()
	{
		return _curInterval;
	}

	GXMISC::TTime CIntervalTimer::getRemainInterval()
	{
		return _maxInterval > _curInterval ? _maxInterval-_curInterval : 0;
	}

	sint32 CIntervalTimer::getRemainSecs()
	{
		return (sint32)getRemainInterval() / GXMISC::MILL_SECOND_IN_SECOND;
	}

	sint32 CIntervalTimer::getMaxSecs()
	{
		return (sint32)(_maxInterval/GXMISC::MILL_SECOND_IN_SECOND);
	}

	CManualIntervalTimer::CManualIntervalTimer()
	{
		_maxInterval = 0;
		_curInterval = 0;
	}

	CManualIntervalTimer::CManualIntervalTimer( uint32 maxInterval )
	{
		_maxInterval = maxInterval;
		_curInterval = 0;
	}

	CManualIntervalTimer::~CManualIntervalTimer()
	{
		_maxInterval = 0;
		_curInterval = 0;
	}

	void CManualIntervalTimer::setMaxInterval( TTime maxInterval )
	{
		_maxInterval = maxInterval;
		reset();
	}

	void CManualIntervalTimer::init( uint32 maxInterval )
	{
		_maxInterval = maxInterval;
		_curInterval = 0;
	}

	bool CManualIntervalTimer::update( TTime diff )
	{
		_curInterval += diff;

		return isPassed();
	}

	bool CManualIntervalTimer::isPassed()
	{
		return _curInterval >= _maxInterval;
	}

	void CManualIntervalTimer::reset(bool force)
	{
		if(force)
		{
			_curInterval = 0;
		}
		else
		{
			_curInterval = _curInterval > _maxInterval ? _curInterval-_maxInterval : 0;
		}	
	}

	GXMISC::TTime CManualIntervalTimer::getCurInterval()
	{
		return _curInterval;
	}

	GXMISC::TTime CManualIntervalTimer::getRemainInterval()
	{
		return _maxInterval > _curInterval ? _maxInterval-_curInterval : 0;
	}

	sint32 CManualIntervalTimer::getRemainSecs()
	{
		return (sint32)getRemainInterval() / GXMISC::MILL_SECOND_IN_SECOND;
	}

	sint32 CManualIntervalTimer::getMaxSecs()
	{
		return (sint32)(_maxInterval/GXMISC::MILL_SECOND_IN_SECOND);
	}
}