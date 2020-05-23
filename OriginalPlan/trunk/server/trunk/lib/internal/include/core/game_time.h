#ifndef _GAME_TIME_H_
#define _GAME_TIME_H_

#include "time_util.h"
#include "time_manager.h"

namespace GXMISC{

#pragma pack(push, 1)
	
	// @TODO 重新设计接口
	inline  void GameTimeToString( char* str,  const TGameTime_t& t)
	{
		TTime tempTime = (TTime)t;
		tm* curTime = GXMISC::CTimeManager::LocalTime( &tempTime ) ;
		if ( curTime == NULL )
		{
			return ;
		}
		sprintf(str, "%d-%d-%d %d:%d:%d", curTime->tm_year + 1900, curTime->tm_mon + 1, curTime->tm_mday, curTime->tm_hour, curTime->tm_min, curTime->tm_sec);
	}

	inline void GameTimeToString( std::string& str,  const TGameTime_t& t)
	{
		char buff[100];
		memset(buff, 0, sizeof(buff));
		GameTimeToString(buff, t);
		str = buff;
	}

	inline std::string GameTimeToString( const TGameTime_t& t )
	{
		std::string str;
		GameTimeToString(str, t);
		return str;
	}

	inline bool	ChangeTime( TGameTime_t& gameTime, const std::vector<sint32>& ary )
	{
		if ( ary.size() < 5 )
		{
			return false;
		}
		tm tt;
		tt.tm_year = ary[0] - 1900;
		tt.tm_mon = ary[1] - 1;
		tt.tm_mday = ary[2];
		tt.tm_hour = ary[3];
		tt.tm_min = ary[4];
		tt.tm_sec = 0;
		if ( ary.size() > 5)
		{
			tt.tm_sec = ary[5];
		}
		gameTime = (TGameTime_t)mktime(&tt);
		return true;
	}

	class CGameTime{
	public:
		CGameTime();
		CGameTime(const CGameTime& other);
		CGameTime(const TGameTime_t& other);
		~CGameTime();

	public:
		TGameTime_t getGameTime() const { return _gameTime; }
		void setGameTime(TGameTime_t val) { _gameTime = val; }
		std::string toString();

	public:
		operator TGameTime_t() const;
		operator std::string() const;
		operator bool() const;
		CGameTime& operator=(const TGameTime_t& times);
		bool operator == (const CGameTime& times) const;

	private:
		TGameTime_t _gameTime;
	};

#pragma pack(pop)

};

#endif	// _GAME_TIME_H_