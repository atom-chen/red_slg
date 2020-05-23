#include "char_relation_core.h"
#include "obj_character.h"

void CCharRelationCore::cleanUp()
{
	_campData.cleanUp();
	_character = NULL;
}

bool CCharRelationCore::init( const TCharacterInit* inits )
{
	return true;
}

bool CCharRelationCore::update( GXMISC::TDiffTime_t diff )
{
	return true;
}

bool CCharRelationCore::updateOutBlock( GXMISC::TDiffTime_t diff )
{
	return true;
}

void CCharRelationCore::setCharacter(CCharacterObject* character)
{
	_character = character;
}

bool CCharRelationCore::isSameCamp(CCharacterObject* obj)
{
	if (getCampData()->isInvalid())
	{
		return false;
	}

	if (getCampData()->campID != obj->getCampData()->campID)
	{
		return false;
	}

	return true;
}

bool CCharRelationCore::isTeamMember(CCharacterObject* obj) const
{
	return false;
}

TChartCampData* CCharRelationCore::getCampData()
{
	return &_campData;
}

TCampID_t CCharRelationCore::getCampID()
{
	return _campData.campID;
}

void CCharRelationCore::setCampID(TCampID_t campID)
{
	_campData.campID = campID;
}

