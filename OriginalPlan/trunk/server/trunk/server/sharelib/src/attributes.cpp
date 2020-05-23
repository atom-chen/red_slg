#include "attributes.h"
#include "game_util.h"

void CSkillAttr::setFixCritHurt( TValueType_t valueType, TAttrVal_t val )
{
	switch(valueType)
	{
	case NUMERICAL_TYPE_ODDS:
	case NUMERICAL_TYPE_VALUE:
		{
			_critHurt.attrs[valueType-1] = val;
		}
	default:
		{
			gxAssert(false);
		}
	}
}

TAttrVal_t CSkillAttr::getFixCritHurt(TValueType_t valueType) const
{
	switch(valueType)
	{
	case NUMERICAL_TYPE_ODDS:
	case NUMERICAL_TYPE_VALUE:
		{
			return _critHurt.attrs[valueType-1];
		}
	default:
		{
			gxAssert(false);
		}
	}

	return 0;
}

TAttrVal_t CSkillAttr::addFixCritHurt( TValueType_t valueType, TAttrVal_t val )
{
	switch(valueType)
	{
	case NUMERICAL_TYPE_ODDS:
	case NUMERICAL_TYPE_VALUE:
		{
			_critHurt.attrs[valueType-1] += val;
			return _critHurt.attrs[valueType-1];
		}
	default:
		{
			gxAssert(false);
		}
	}

	return 0;
}

bool CSkillAttr::isFixCritHurt() const
{
	return !_critHurt.isEmpty();
}

const TSkillAttr* CSkillAttr::getFixCritHurt() const
{
	return &_critHurt;
}

void CSkillAttr::setAppendCritRate( TAttrVal_t val )
{
	_appendCritHurtRate = val;
}

TAttrVal_t CSkillAttr::getAppendCritRate()
{
	return _appendCritHurtRate;
}