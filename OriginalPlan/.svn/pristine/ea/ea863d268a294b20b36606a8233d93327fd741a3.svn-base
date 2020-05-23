#ifndef _ANNOUNCEMENT_SYS_H_
#define _ANNOUNCEMENT_SYS_H_

#include "core/singleton.h"
#include "core/obj_mem_fix_pool.h"

#include "announcement_timer.h"
#include "game_util.h"

typedef std::map<TAnnouncementID_t, std::string> TAnnouncementMsg;
typedef std::vector<TBroadInfo> TBroadInfoVec;

class CAnnouncementSysManager
{
	typedef std::map<uint32, CBroadTimer*>		BroadTimerContainer;
	typedef BroadTimerContainer::iterator		BroadTimerItr;
	typedef BroadTimerContainer::const_iterator	BroadTimerCItr;

public:
	CAnnouncementSysManager()
	{
		cleanUp();
		_broadPool.init(100);
	}
	~CAnnouncementSysManager()
	{
		cleanUp();
	}

public:
	void addAnnouncement( const TBroadInfoVec* data )
	{
		std::vector<TBroadInfo>::const_iterator itr = data->begin();
		for ( ; itr!=data->end(); ++itr )
		{
			addBroad(&*itr);
		}
	}

public:
	void update( GXMISC::TDiffTime_t diff, TAnnouncementMsg& msgs )
	{
		if ( _broadInfo.empty() )
		{
			return ;
		}
		std::vector<uint32>	delBroad;
		BroadTimerItr itr = _broadInfo.begin();
		for ( ; itr!=_broadInfo.end(); ++itr )
		{
			CBroadTimer* broadInfo = itr->second;
			if ( broadInfo == NULL )
			{
				delBroad.push_back(itr->first);
				continue;
			}
			if(broadInfo->update(diff))
			{
				// 需要发送
				msgs.insert(TAnnouncementMsg::value_type(broadInfo->getID(), broadInfo->getMsg()));
			}
			if ( broadInfo->isNeedDel() )
			{
				delBroad.push_back(itr->first);
			}
		}

		std::vector<uint32>::iterator delItr = delBroad.begin();
		for ( ; delItr!=delBroad.end(); ++delItr )
		{
			BroadTimerItr it = _broadInfo.find(*delItr);
			if ( it != _broadInfo.end() )
			{
				_broadPool.deleteObj(it->second);
				_broadInfo.erase(it);
			}
		}
	}

public:
	void delBroad()
	{
		_broadInfo.clear();
	}
	bool addBroad( const TBroadInfo* data )
	{
		return addBroad(genBroadTimerID(), data);
	}
	bool addBroad(TAnnouncementID_t id, const TBroadInfo* data)
	{
		CBroadTimer* broadTimer = _broadPool.newObj();
		if ( broadTimer == NULL )
		{
			gxError("Can't new CBroadTimer!");
			gxAssert(false);
			return false;
		}
		if ( !broadTimer->init(id, data) )
		{
			return false;
		}
		_broadInfo[id] = broadTimer;
		return true;
	}

	static bool IsSystemID(TAnnouncementID_t id)
	{
		return id < SYSTEM_ANNOUNCEMENT_ID;
	}

private:
	uint32 genBroadTimerID()
	{
		if ( _broadTimerID >= INVALID_OBJ_UID )
		{
			_broadTimerID = 0;
		}
		++_broadTimerID;
		return _broadTimerID;
	}
	void cleanUp()
	{
		_broadTimerID = SYSTEM_ANNOUNCEMENT_ID;
		_broadInfo.clear();
	}

private:
	uint32					_broadTimerID;		///< 当前公告ID
	BroadTimerContainer		_broadInfo;			///< 公告表
	GXMISC::CFixObjPool<CBroadTimer, true>	_broadPool;	///< 公告定时器

public:
	static const TAnnouncementID_t SYSTEM_ANNOUNCEMENT_ID = 60000;
};

#endif	// _ANNOUNCEMENT_SYS_H_