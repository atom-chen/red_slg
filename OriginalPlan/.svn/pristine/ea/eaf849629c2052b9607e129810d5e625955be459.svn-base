#include "map_db_role_data.h"
#include "game_misc.h"
#include "time_manager.h"

sint32 CHumanBaseData::getOfflineOverunDays(sint8 hour, sint8 mins, sint8 seconds) const
{
	if(isNewRole())
	{
		return 0;
	}

	sint32 offlineDay = CGameMisc::ToLocalDay(getLogoutTime(), hour, mins, seconds);
	sint32 curDay = CGameMisc::ToLocalDay(DTimeManager.nowSysTime(), hour, mins, seconds);

	return (curDay-offlineDay);
}

bool CHumanBaseData::isNewRole() const
{
	return logoutTime == createTime;
}

TRmb_t CHumanBaseData::addChargeRmb(TRmb_t val)
{
	if(val > 0)
	{
		TRmb_t oldChargeRmb = totalChargeRmb;
		setTotalChargeRmb(oldChargeRmb+val);
	}
	return getTotalChargeRmb();
}

CHumanBaseData::CHumanBaseData()
{
	memset(this, 0, sizeof(*this));
}

CHumanBaseData::~CHumanBaseData()
{
}
