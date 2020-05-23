#ifndef _ANNOUNCEMENT_TIMER_H_
#define _ANNOUNCEMENT_TIMER_H_

#include "core/time_util.h"
#include "core/timer.h"
#include "core/game_time.h"
#include "core/time/interval_timer.h"

#include "base_packet_def.h"
#include "game_util.h"

typedef struct BroadInfo
{
public:
	GXMISC::TGameTime_t		_startTime;		// ��ʼʱ��
	GXMISC::TGameTime_t		_endTime;		// ����ʱ��
	GXMISC::TGameTime_t		_interval;		// ���ʱ��
	TCharArray2				_chatStr;		// ��������

public:
	TCharArray2 getChatStr() const { return _chatStr; }
	void setChatStr(TCharArray2 val) { _chatStr = val; }
public:
	BroadInfo()
	{
		cleanUp();
	}

	void cleanUp()
	{
		_startTime = GXMISC::INVALID_GAME_TIME;
		_endTime = GXMISC::INVALID_GAME_TIME;
		_interval = GXMISC::INVALID_GAME_TIME;
	}
}TBroadInfo;

// ��ʱ����
class CBroadTimer
{
public:
	CBroadTimer();
	~CBroadTimer();

public:
	bool			update( GXMISC::TDiffTime_t diff );
	bool			init( TAnnouncementID_t id, const TBroadInfo* info );

public:
	bool			isNeedDel();

public:
	TAnnouncementID_t getID() const { return _id; }
	void setID(TAnnouncementID_t val) { _id = val; }
	std::string getMsg(){ return _broadData.getChatStr().toString(); }

private:
	void			cleanUp();

private:
	GXMISC::GXManuaTimer _timer;
	TAnnouncementID_t _id;
	TBroadInfo		_broadData;
};

#endif	// _ANNOUNCEMENT_TIMER_H_