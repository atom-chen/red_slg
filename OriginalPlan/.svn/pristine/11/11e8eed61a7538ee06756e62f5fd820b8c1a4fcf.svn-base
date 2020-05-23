#ifndef _TBL_BUFFER_H_
#define _TBL_BUFFER_H_

#include "tbl_config.h"
#include "game_util.h"
#include "carray.h"
#include "tbl_loader.h"
#include "game_misc.h"
#include "singleton.h"
#include "tbl_define.h"
#include "game_struct.h"
#include "parse_misc.h"

// Buffer配置表
class CBufferConfigTbl : public CConfigTbl
{
	friend class CBufferConfigTblLoader;

public:
	TBufferTypeID_t getID()
	{
		return id;
	}
	bool isShow()
	{
		return show == 1;
	}
	bool isOfflineDisa()
	{
		return offlineDisa == 1;
	}
	bool isOfflineCountTime()
	{
		return offlineTime == 1;
	}
	bool isTimeOverlap()
	{
		return timeOverlap == 1;
	}
	bool isParamOverlap()
	{
		return paramOverlap == 1;
	}
	std::vector<uint32>* getTotalTime()
	{
		return &durationTime;
	}
	uint32 getTotalTime(TSkillLevel_t level)
	{
		if (level >= (TSkillLevel_t)durationTime.size())
		{
			return 1;
		}

		return durationTime[level];
	}
	std::vector<uint32>* getIntervalTime()
	{
		return &intervalTime;
	}
	uint32 getIntervalTime(TSkillLevel_t level)
	{
		if (level >= (TSkillLevel_t)intervalTime.size())
		{
			return 1;
		}

		return intervalTime[level];
	}
	uint32 getAttrArySize()
	{
		return attrAry.size();
	}
	TBuffAttrAry* getAttrAry(uint32 level)
	{
		gxAssert(level < getAttrArySize());
		return &attrAry[level];
	}
	uint32 getParamArySize()
	{
		return param.size();
	}
	TBuffParamVec* getParam(uint32 index)
	{
		return &this->param[index];
	}
	void getParamAry(uint32 level, TBuffParamVec* param)
	{
		if (level >= this->param.size())
		{
			return;
		}

		*param = this->param[level];
	}
	void getParamAry(uint32 level, TBuffParamAry* param)
	{
		if (level >= this->param.size())
		{
			return;
		}

		for (uint32 i = 0; i < this->param[level].size(); ++i)
		{
			if (!param->isMax())
			{
				param->pushBack(this->param[level][i]);
			}
		}
	}

	bool isPermanence()
	{
		return durationTime[0] == 0;
	}

	bool isInterval()
	{
		return intervalTime[0] != 0;
	}

private:
	TBufferTypeID_t id;         // ID
	uint8 show;                 // 是否显示
	uint8 offlineDisa;          // 离线消失
	uint8 offlineTime;          // 下线是否计时
	uint8 timeOverlap;          // 时间叠加
	uint8 paramOverlap;         // 参数叠加
	std::vector<uint32> durationTime;   // 持续时间
	std::vector<uint32> intervalTime;   // 触发时间
	std::vector<TBuffAttrAry> attrAry;  // Buff表
	std::vector<TBuffParamVec> param;      // 参数表

	DObjToStringAlias(CBufferConfigTbl, TBufferTypeID_t, BuffID, id);
	DMultiIndexImpl1(TBufferTypeID_t, id, INVALID_BUFFER_TYPE_ID);
};

class CBufferConfigTblLoader :
	public CConfigLoader<CBufferConfigTblLoader, CBufferConfigTbl>
{
private:
	typedef CConfigLoader<CBufferConfigTblLoader, CBufferConfigTbl> TBaseType;

public:
	virtual bool readRow(ConfigRow* row, sint32 count, CBufferConfigTbl* buffRow)
	{
// 		DReadConfigInt(id, val, buffRow);
// 		DReadConfigInt(show, val, buffRow);
// 		DReadConfigInt(offlineDisa, val, buffRow);
// 		DReadConfigInt(offlineTime, val, buffRow);
// 		DReadConfigInt(timeOverlap, val, buffRow);
// 		DReadConfigInt(paramOverlap, val, buffRow);
// 
// 		// 持续时间
// 		GXMISC::IntAry durationTimeAry;
// 		if (!durationTimeAry.parse(row->Attribute("durationTime"), "|"))
// 		{
// 			gxError("Can't parse durationTime!Line=%u, %s", count, buffRow->toString());
// 			return false;
// 		}
// 		durationTimeAry.getCont(buffRow->durationTime);
// 
// 		// 间隔时间
// 		GXMISC::IntAry intervalTimeAry;
// 		if (!intervalTimeAry.parse(row->Attribute("intervalTime"), "|"))
// 		{
// 			gxError("Can't parse intervalTime!Line=%u, %s", count, buffRow->toString());
// 			return false;
// 		}
// 		intervalTimeAry.getCont(buffRow->intervalTime);
// 
// 		GXMISC::Int3Ary3 effectAry;
// 		if (!effectAry.parse(row->Attribute("effects"), "|", ";", ":"))
// 		{
// 			gxError("Can't parse effect!Line=%u, %s", count, buffRow->toString());
// 			return false;
// 		}
// 		uint32 aryCount = 0;
// 		buffRow->attrAry.resize(effectAry.size());
// 		for (GXMISC::Int3Ary3::iterator iter = effectAry.begin(); iter != effectAry.end(); ++iter, ++aryCount)
// 		{
// 			for (GXMISC::Int3Ary3::ValueType::iterator iter1 = iter->begin(); iter1 != iter->end(); ++iter1)
// 			{
// 				TExtendAttr attr;
// 				attr.attrType = iter1->value1;
// 				attr.valueType = iter1->value2;
// 				attr.attrValue = iter1->value3;
// 				buffRow->attrAry[aryCount].push_back(attr);
// 			}
// 		}
// 		GXMISC::IntXAry2 paramAry;
// 		if (!paramAry.parse(row->Attribute("param"), "|", ":"))
// 		{
// 			gxError("Can't parse param!Line=%u, %s", count, buffRow->toString());
// 			return false;
// 		}
// 		buffRow->param.resize(paramAry.size());
// 		for (uint32 i = 0; i < paramAry.size(); ++i)
// 		{
// 			paramAry[i].getCont(buffRow->param[i]);
// 		}
// 
// 		if (false == add(buffRow))
// 		{
// 			gxError("Can't add buff row! Line={0}, {1}", count, buffRow->toString());
// 			return false;
// 		}

		return true;
	}
};

#define DBuffTblMgr CBufferConfigTblLoader::GetInstance()

#endif