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


// ����֮��Ĺ�ϵ
class CCharRelationCore
{
public:
	void cleanUp();
	bool init( const TCharacterInit* inits );
	bool update( GXMISC::TDiffTime_t diff );
	bool updateOutBlock( GXMISC::TDiffTime_t diff );

public:
	void setCharacter(CCharacterObject* character);

	// ����ϵ
public:
	virtual bool isSameCamp(CCharacterObject* obj);				// �Ƿ�Ϊͬ��Ӫ��ϵ(����:���,����,ͬһ��Ӫ)
	virtual bool isTeamMember(CCharacterObject* obj) const;		// �Ƿ�Ϊ��Ա

	// ��Ӫ
public:
	TCampID_t getCampID();										// ��ȡ��ӪID
	TChartCampData* getCampData();								// ��Ӫ����
	void setCampID(TCampID_t campID);							// ��ӪID

protected:
	TChartCampData _campData;									// ��Ӫ����

private:
	CCharacterObject* _character;
};

#endif	// _CHAR_RELATION_CORE_H_