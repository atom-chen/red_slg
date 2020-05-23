#ifndef _CHAR_AI_CORE_H_
#define _CHAR_AI_CORE_H_

#include "game_util.h"
#include "game_errno.h"
#include "object_util.h"
 
class CCharacterObject;
class CAICharacter;

// ׷������
typedef struct _ApproachObject
{
	TObjUID_t objUID;
	TMapID_t mapID;
}TApproachObject;
typedef std::set<TObjUID_t> TApproachSet;
// ׷�������б�
typedef struct ApproachObjectList
{
	TApproachSet monsters;							// ׷���Ĺ���
	GXMISC::TGameTime_t lastOptTime;				// �ϴβ���ʱ��
	TObjUID_t lastObjUID;							// �ϴ���ӵĶ���
	CCharacterObject* pChart;						// ������

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

	// ׷��
public:
	// ���׷����
	virtual void addApproachMon(TObjUID_t objUID, EAddApproachObjectType type);
	// ɾ��׷����
	virtual void delApproachMon(TObjUID_t objUID, EDelApproachObjectType type);
	// ��ȡ׷������Ŀ
	virtual sint32 getApproachMonSize();
	// �ܷ�׷��
	virtual bool canBeApproach();
	// �Ƿ���Ҫ��������
	virtual bool needDropApproach();
	// �������׷����
	virtual void clearAllApproachMon(){}
	// ��׷����֪ͨ׷���߷���׷��
	virtual void delApproachByEnemy(TObjUID_t objUID);
 
	// �¼�
public:
	// �˺�
	virtual void onDamage(sint32 nDamage, TObjUID_t nAttackerID, bool bCritical=false, TSkillTypeID_t nSkillID=INVALID_SKILL_TYPE_ID){}
	// �˺�Ŀ��
	virtual void onDamageTarget(sint32 nDamage, CCharacterObject* rTar, TSkillTypeID_t nSkillID=INVALID_SKILL_TYPE_ID){}
	// ���׷�����¼�
	virtual void onAddApproach(TObjUID_t objUID){}
	// ɾ��׷����
	virtual void onDelApproach(TObjUID_t objUID){}

// public:
// 	EGameRetCode moveTo(const TAxisPos *paTargetPos);	// �ƶ���Ŀ��
// 	EGameRetCode useSkill(); // ʹ�ü���

protected:
 	CAICharacter* _characterAI;					// AI
	TApproachObjectList _approachList;			// ׷���б�

private:
	CCharacterObject* _character;				// ����
};
 
 #endif	// _CHAR_AI_CORE_H_