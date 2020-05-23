#ifndef _CHAR_AI_CORE_H_
#define _CHAR_AI_CORE_H_

#include "game_util.h"
#include "game_errno.h"
#include "object_util.h"
 
class CCharacterObject;
class CAICharacter;

// 追击对象
typedef struct _ApproachObject
{
	TObjUID_t objUID;
	TMapID_t mapID;
}TApproachObject;
typedef std::set<TObjUID_t> TApproachSet;
// 追击对象列表
typedef struct ApproachObjectList
{
	TApproachSet monsters;							// 追击的怪物
	GXMISC::TGameTime_t lastOptTime;				// 上次操作时间
	TObjUID_t lastObjUID;							// 上次添加的对象
	CCharacterObject* pChart;						// 所属者

	void addMon(TObjUID_t objUID);
	void delMon(TObjUID_t objUID);
	void cleanUp();
	bool needUpdate();
	void update();
	sint32 size();
}TApproachObjectList;

class CCharAICore
{
protected:
	CCharAICore();
public:
	virtual ~CCharAICore();

 public:
 	void	cleanUp();
 	bool	init( const TCharacterInit* inits );
 	bool	update( GXMISC::TDiffTime_t diff );
 	bool	updateOutBlock( GXMISC::TDiffTime_t diff );
 
public:
 	void setCharacterAI(CAICharacter* charAI);
 	CAICharacter* getCharacterAI() const;
 	void setCharacter(CCharacterObject* character);

	// 追击
public:
	// 添加追击者
	virtual void addApproachMon(TObjUID_t objUID, EAddApproachObjectType type);
	// 删除追击者
	virtual void delApproachMon(TObjUID_t objUID, EDelApproachObjectType type);
	// 获取追击者数目
	virtual sint32 getApproachMonSize();
	// 能否被追击
	virtual bool canBeApproach();
	// 是否需要放弃攻击
	virtual bool needDropApproach();
	// 清除所有追击者
	virtual void clearAllApproachMon(){}
	// 被追击者通知追击者放弃追击
	virtual void delApproachByEnemy(TObjUID_t objUID);
 
	// 事件
public:
	// 伤害
	virtual void onDamage(sint32 nDamage, TObjUID_t nAttackerID, bool bCritical=false, TSkillTypeID_t nSkillID=INVALID_SKILL_TYPE_ID){}
	// 伤害目标
	virtual void onDamageTarget(sint32 nDamage, CCharacterObject* rTar, TSkillTypeID_t nSkillID=INVALID_SKILL_TYPE_ID){}
	// 添加追击者事件
	virtual void onAddApproach(TObjUID_t objUID){}
	// 删除追击者
	virtual void onDelApproach(TObjUID_t objUID){}

// public:
// 	EGameRetCode moveTo(const TAxisPos *paTargetPos);	// 移动到目标
// 	EGameRetCode useSkill(); // 使用技能

protected:
 	CAICharacter* _characterAI;					// AI
	TApproachObjectList _approachList;			// 追击列表

private:
	CCharacterObject* _character;				// 对象
};
 
 #endif	// _CHAR_AI_CORE_H_