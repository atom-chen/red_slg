#ifndef _ANNOUNCEMENT_TBL_H_
#define _ANNOUNCEMENT_TBL_H_

#include <string>

#include "core/parse_misc.h"
#include "core/time_util.h"

#include "game_util.h"
#include "game_struct.h"
#include "tbl_config.h"
#include "tbl_loader.h"

/**
 * 公告表格行
 */
class CAnnouncementTbl : public CConfigTbl
{
public:
	TAnnouncementID_t id;			///< 公告ID
	sint32 type;					///< 类型
	sint32 eventType;				///< 触发事件类型
	sint32 systemType;				///< 系统来源
	GXMISC::IntX number;			///< 条件值
	sint32 showType;				///< 显示类型
	GXMISC::TGameTime_t startTime;	///< 开始时间
	GXMISC::TGameTime_t endTime;	///< 结束时间
	sint32 refreshTime;				///< 刷新时间
	std::string keyStr;				///< Key值

public:	
	DMultiIndexImpl1(TAnnouncementID_t, id, 0);
	DObjToString(CAnnouncementTbl, TAnnouncementID_t, id);

public:
	bool isPassCond(sint32 cond)
	{
		for(sint32 i = 0; i < (sint32)number.size(); ++i){
			if(cond == number[i]){
				return true;
			}
		}

		return false;
	}
};

class CAnnouncementTblLoader : 
	public CConfigLoader<CAnnouncementTblLoader, CAnnouncementTbl>
{
public:
	//typedef CConfigLoader<CAnnouncementTblLoader, CAnnouncementTbl> TBaseType;
	DSingletonImpl();
	DConfigFind();
public:
	virtual bool readRow(ConfigRow* row, sint32 count, TBaseType::ValueProType* destRow)
	{
		DReadConfigInt( id, id, destRow);
		DReadConfigInt( type, public_type, destRow);
		DReadConfigInt( eventType, trigger_event, destRow);
		DReadConfigInt( systemType, type_tujing, destRow);
		GXMISC::IntX intx;
		DReadConfigIntX( intx, number, destRow);
		destRow->number = intx;
		DReadConfigInt( showType, show_type, destRow);
		if(strlen(row->Attribute("show_time")) > 0)
		{
			DReadDateTime( startTime, show_time, destRow);
		}
		if(strlen(row->Attribute("end_time")) > 0)
		{
			DReadDateTime( endTime, end_time, destRow);
		}
		DReadConfigInt( refreshTime, refresh, destRow);
		DReadConfigTxt( keyStr, event_text, destRow );

		DAddToLoader(destRow);

		return true;
	}

public:
	TAnnouncementID_t getPassCondID(sint32 type, sint32 cond, sint8 systype)
	{
		for(Iterator iter = this->begin(); iter != this->end(); ++iter){
			CAnnouncementTbl* pRow = iter->second;
			if(NULL != pRow)
			{
				if(pRow->eventType == type && pRow->isPassCond(cond) && pRow->systemType == systype){
					return pRow->id;
				}
			}
		}

		return INVALID_ANNOUNCEMENT_ID;
	}
};

#define DAnnouncementTblMgr CAnnouncementTblLoader::GetInstance()

#endif	// _ANNOUNCEMENT_TBL_H_