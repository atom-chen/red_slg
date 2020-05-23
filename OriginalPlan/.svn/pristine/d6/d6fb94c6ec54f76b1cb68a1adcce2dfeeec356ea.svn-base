#include "game_time.h"

namespace GXMISC
{
	CGameTime::CGameTime()
	{
		_gameTime = 0;
	}
	CGameTime::CGameTime( const CGameTime& other )
	{
		setGameTime(other.getGameTime());
	}
	CGameTime::CGameTime( const TGameTime_t& other )
	{
		setGameTime(other);
	}
	CGameTime::~CGameTime()
	{
		_gameTime = 0;
	}
	CGameTime::operator TGameTime_t() const{
		return _gameTime;
	}
	CGameTime::operator std::string() const{
		return GameTimeToString(_gameTime);
	}
	CGameTime::operator bool() const{
		return !(_gameTime == INVALID_GAME_TIME || _gameTime == MAX_GAME_TIME);
	}
	CGameTime& CGameTime::operator=(const TGameTime_t& times)
	{
		setGameTime(times);
		return *this;
	}
	bool CGameTime::operator == (const CGameTime& times)  const{
		return times.getGameTime() == _gameTime;
	}

	std::string CGameTime::toString()
	{
		return *this;
	}

}