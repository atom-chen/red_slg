#ifndef _COOL_DOWN_H_
#define _COOL_DOWN_H_

#pragma pack(push, 1)

#include "time_util.h"
#include "db_struct_base.h"

class CCooldown
{
public:
	CCooldown() : _cooldownLastTime(0), _cooldownElapsed(0){};
	CCooldown(CCooldown const& rhs)
	{
		_coolDownID = rhs.getCoolDownID();
		_cooldownLastTime = rhs.getCooldownTime();
		_cooldownElapsed = rhs.getCooldownElapsed();
	}

	~CCooldown(){}

	CCooldown& operator=(CCooldown const& rhs)
	{
		_coolDownID = rhs.getCoolDownID();
		_cooldownLastTime = rhs.getCooldownTime();
		_cooldownElapsed = rhs.getCooldownElapsed();

		return *this;
	};

	void heartBeat(GXMISC::TDiffTime_t nDeltaTime)
	{
		if(_cooldownLastTime<=_cooldownElapsed)
		{
			return;
		}

		_cooldownElapsed +=nDeltaTime;
		if(_cooldownLastTime<_cooldownElapsed)
		{
			_cooldownElapsed=_cooldownLastTime;
		}
	}

	bool isCooldowned(void) const
	{
		return _cooldownLastTime<=_cooldownElapsed;
	}

	GXMISC::TDiffTime_t getRemainTime() const
	{
		return _cooldownLastTime - _cooldownElapsed;
	}

	void reset()
	{
		_coolDownID = INVALID_COOL_DOWN_ID;
		_cooldownLastTime = 0;
		_cooldownElapsed = 0;
	}

	void setCoolDownID(TCooldownID_t id)        { _coolDownID = id; }
	TCooldownID_t getCoolDownID() const         { return _coolDownID; }
	GXMISC::TDiffTime_t getCooldownTime() const			{ return _cooldownLastTime;}
	void setCooldownTime(GXMISC::TDiffTime_t nTime)		{_cooldownLastTime = nTime;}
	GXMISC::TDiffTime_t getCooldownElapsed() const		{ return _cooldownElapsed;}
	void setCooldownElapsed(GXMISC::TDiffTime_t nTime)	{_cooldownElapsed = nTime;}
	bool isInvalid() const { return _coolDownID == INVALID_COOL_DOWN_ID; }

protected:
	TCooldownID_t	_coolDownID;
	GXMISC::TDiffTime_t	    _cooldownLastTime;
	GXMISC::TDiffTime_t	    _cooldownElapsed;
};

template<typename T>
class CCooldownList
{
public:
	typedef typename T::value_type TCoolDownType;

public:
	CCooldownList() : _dirtyFlag(false){}
	~CCooldownList(){}

public:
	void cleanUp() 
	{
		reset();
	}

	void reset()
	{
		for(uint32 nIdx=0; _coolDownAry.maxSize()>nIdx; ++nIdx)
		{
			_coolDownAry[nIdx].reset();
		}
	}

	T const& getCooldownInfoByIndex(sint32 nIdx) const
	{
		return _coolDownAry[nIdx];
	}

	GXMISC::TDiffTime_t getRemainTimeByID(TCooldownID_t nCooldown) const
	{
		return _coolDownAry[nCooldown].getRemainTime();
	}

	sint32 maxSize() const
	{
		return _coolDownAry.maxSize();
	}

	void heartBeat(GXMISC::TDiffTime_t nDeltaTime)
	{
		if(!_dirtyFlag)
		{
			return;
		}

		_dirtyFlag = false;
		for(uint32 nIdx=0; nIdx < _coolDownAry.maxSize(); ++nIdx)
		{
			_coolDownAry[nIdx].heartBeat(nDeltaTime);
			if(!_coolDownAry[nIdx].isCooldowned())
			{
				_dirtyFlag = true;
			}
		}
	}

	bool isCooldowned(TCooldownID_t coolDownID) const
	{
		if(0 > coolDownID)
		{
			return true;
		}
		for(uint32 nIdx=0;_coolDownAry.maxSize()>nIdx;++nIdx)
		{
			if(_coolDownAry[nIdx].getCoolDownID() == coolDownID)
			{
				return _coolDownAry[nIdx].isCooldowned();
			}
		}
		return true;
	}

	void registerCooldown(TCooldownID_t id, uint32 seconds)
	{
		_dirtyFlag = true;
		sint8 nEmptySlot = -1;
		if(INVALID_COOL_DOWN_ID == id)
		{
			return;
		}

		for(uint32 nIdx=0;_coolDownAry.maxSize()>nIdx;++nIdx)
		{
			if(-1==nEmptySlot)
			{
				if(_coolDownAry[nIdx].isInvalid())
				{
					nEmptySlot = nIdx;
				}
				else if(_coolDownAry[nIdx].isCooldowned())
				{
					nEmptySlot = nIdx;
				}
			}
			if(_coolDownAry[nIdx].getCoolDownID() == id)
			{
				nEmptySlot = nIdx;
				break;
			}
		}
		if(-1 != nEmptySlot)
		{
			_coolDownAry[nEmptySlot].reset();
			_coolDownAry[nEmptySlot].setCoolDownID(id);
			_coolDownAry[nEmptySlot].setCooldownTime(seconds);
			return;
		}
	}

	T& getCoolDownAry()
	{
		return _coolDownAry;
	}

private:
	T       _coolDownAry;
	bool    _dirtyFlag;
};

typedef GXMISC::CFixArray<CCooldown, MAX_SKILL_COOL_DOWN_NUM> TSkillCoolDownAry;
typedef GXMISC::CFixArray<CCooldown, MAX_ITEM_COOL_DOWN_NUM> TItemCoolDownAry;
typedef GXMISC::CFixArray<CCooldown, MAX_SKILL_COMM_COOL_DOWN_NUM> TSkillCommCoolDownAry;
typedef GXMISC::CFixArray<CCooldown, MAX_ITEM_COMM_COOL_DOWN_NUM> TItemCommCoolDownAry;
typedef CCooldownList<TSkillCoolDownAry> TSkillCoolDown;
typedef CCooldownList<TItemCoolDownAry> TItemCoolDown;
typedef CCooldownList<TSkillCommCoolDownAry> TSkillCommCoolDown;
typedef CCooldownList<TItemCommCoolDownAry> TItemCommCoolDown;

typedef struct DBSkillCoolDown : public GXMISC::TDBStructBase
{
	TSkillCoolDownAry data;
}TDBSkillCoolDown;

typedef struct DBItemCoolDown : public GXMISC::TDBStructBase
{
	TItemCoolDownAry data;
}TDBItemCoolDown;

#pragma pack(pop)

#endif