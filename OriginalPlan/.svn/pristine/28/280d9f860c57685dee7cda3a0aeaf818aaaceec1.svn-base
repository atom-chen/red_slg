#include "obj_character.h"
#include "map_scene_base.h"
#include "game_config.h"

CCharacterObject::CCharacterObject()
{
	cleanUp();
	CCharMoveCore::setCharacter(this);
	CCharFightCore::setCharacter(this);
	CCharFightCore::setCharacter(this);
	CCharAICore::setCharacter(this);
	CCharAttributeCoreExt::setCharacter(this);
	CCharSkillCore::setCharacter(this);

	_msgHandle = new CCharMsgHandle();
	_msgHandle->_character = this;
}

CCharacterObject::~CCharacterObject()
{
	cleanUp();

	DSafeDelete(_msgHandle);
}

void CCharacterObject::cleanUp()
{
	TBaseType::cleanUp();
	TBaseTypeAttrCore::cleanUp();
	TBaseTypeMoveCore::cleanUp();

	_job = INVALID_JOB;
	_level = INVALID_LEVEL;
	_exp = 0;
	_lastUpdateTime = DTimeManager.nowSysTime();
}

bool CCharacterObject::init( const TCharacterInit* inits )
{
	TBaseType::init(inits);
	TBaseTypeAttrCore::init(inits);
	TBaseTypeMoveCore::init(inits);
	CCharFightCore::init(inits);

	setJob(inits->job);
	setLevel(inits->level);
	setExp(inits->exp);

	return true;
}

bool CCharacterObject::update( GXMISC::TDiffTime_t diff )
{
	TBaseType::update(diff);
	TBaseTypeAttrCore::update(diff);
	TBaseTypeMoveCore::update(diff);

	_diff = diff;
	_lastUpdateTime = DTimeManager.nowSysTime();
	return true;
}

bool CCharacterObject::updateOutBlock( GXMISC::TDiffTime_t diff )
{
	TBaseType::updateOutBlock(diff);
	TBaseTypeAttrCore::updateOutBlock(diff);
	TBaseTypeMoveCore::updateOutBlock(diff);

	return true;
}

void CCharacterObject::onMoveUpdate( TPackMovePosList* posList, TObjUID_t objUID, TObjType_t objType )
{
	_msgHandle->onMoveUpdate(posList, objUID);
}

void CCharacterObject::onRegisterToBlock()
{
	TBaseType::onRegisterToBlock();
}

void CCharacterObject::onEnterScene( CMapSceneBase* pScene )
{
	TBaseType::onEnterScene(pScene);
	clearMovePos();
}

void CCharacterObject::onLeaveScene( CMapSceneBase* pScene )
{
	TBaseType::onLeaveScene(pScene);
	clearMovePos();
}

void CCharacterObject::resetPos( const TAxisPos* pos, EResetPosType type, bool broadFlag, bool randFlag )
{
	if(NULL == getScene())
	{
		return;
	}

	clearMovePos();
	TAxisPos tarPos = *pos;
	if(randFlag)
	{
		if(!getScene()->findRandPos(&tarPos, 2))
		{
			return;
		}
	}
	_msgHandle->onResetPos(getObjUID(), tarPos.x, tarPos.y, type, broadFlag);

	setAxisPos(&tarPos);
	updateBlock();
}

bool CCharacterObject::isDie()
{
	return !getActionBan(ACTION_BAN_LIVE);
}

void CCharacterObject::setDie()
{
	setHp(0);
	onDie();
}

GXMISC::TDiffTime_t CCharacterObject::getLogicTime()
{
	return _diff;
}

bool CCharacterObject::isTimeToLeaveScene(GXMISC::TGameTime_t curTime)
{
	if (!isActive())
	{
		return true;
	}

	if (!isDie())
	{
		return false;
	}

	if (isMonster())
	{
		return ((curTime - _lastDieTime) >= g_GameConfig.monsterDieLeaveSceneTime);
	}

	return true;
}

CCharacterObject* CCharacterObject::getOwner()
{
	if (getScene() != NULL)
	{
		return getScene()->getCharacterByUID(getOwnerUID());
	}

	return NULL;
}

TObjUID_t CCharacterObject::getOwnerUID()
{
	return getObjUID();
}

void CCharacterObject::setOwnerUID(TObjUID_t objUID)
{
}

CRoleBase* CCharacterObject::getRoleBaseOwner()
{
	CCharacterObject* pCharcter = getOwner();
	return dynamic_cast<CRoleBase*>(pCharcter);
}

CRoleBase* CCharacterObject::toRoleBase()
{
	if (isRole())
	{
		return dynamic_cast<CRoleBase*>(this);
	}

	return NULL;
}