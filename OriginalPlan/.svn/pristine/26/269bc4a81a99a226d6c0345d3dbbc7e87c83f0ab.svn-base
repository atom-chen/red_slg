#ifndef _CHAR_RELATION_CORE_H_
#define _CHAR_RELATION_CORE_H_

#include "object_util.h"
#include "char_fight_core.h"

class CCharacterObject;

typedef struct _ChartCampData
{
	TCampID_t campID;

	_ChartCampData()
	{
		cleanUp();
	}

	void cleanUp()
	{
		campID = INVALID_CAMP_ID;
	}

	bool isInvalid()
	{
		return campID == INVALID_CAMP_ID;
	}

	bool operator==(const _ChartCampData& camp)
	{
		return camp.campID == campID;
	}
}TChartCampData;


// 对象之间的关系
class CCharRelationCore
{
public:
	void cleanUp();
	bool init( const TCharacterInit* inits );
	bool update( GXMISC::TDiffTime_t diff );
	bool updateOutBlock( GXMISC::TDiffTime_t diff );

public:
	void setCharacter(CCharacterObject* character);

	// 社会关系
public:
	virtual bool isSameCamp(CCharacterObject* obj);				// 是否为同阵营关系(包括:组队,好友,同一阵营)
	virtual bool isTeamMember(CCharacterObject* obj) const;		// 是否为队员

	// 阵营
public:
	TCampID_t getCampID();										// 获取阵营ID
	TChartCampData* getCampData();								// 阵营数据
	void setCampID(TCampID_t campID);							// 阵营ID

protected:
	TChartCampData _campData;									// 阵营数据

private:
	CCharacterObject* _character;
};

#endif	// _CHAR_RELATION_CORE_H_