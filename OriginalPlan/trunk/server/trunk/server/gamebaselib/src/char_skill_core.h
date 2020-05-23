#ifndef _CHAR_SKILL_CORE_H_
#define _CHAR_SKILL_CORE_H_

#include "packet_struct.h"
#include "scan.h"
#include "game_struct.h"
#include "game_util.h"
#include "string_common.h"
#include "game_errno.h"
#include "carray.h"
#include "attributes.h"
#include "module_def.h"
#include "skill_util.h"
#include "object_util.h"

class CSkillLogicBase;

/**
* ��ɫ����
* 1. �����б�
* 2. ��������
* 3. ս������
*/
class CCharSkillCore
{
public:
	CCharSkillCore();
	~CCharSkillCore(){}

public:
	void	cleanUp();
	bool	init(const TCharacterInit* inits);
	bool	update(GXMISC::TDiffTime_t diff);
	bool	updateOutBlock(GXMISC::TDiffTime_t diff);

public:
	// ���ö���
	void setCharacter(CCharacterObject* character);

	// ս������
public:
	// ʹ�ü���
	EGameRetCode use(TObjUID_t destObjUID, TSkillTypeID_t skillTypeID, TAxisPos_t x, TAxisPos_t y);
	// ��ȡ��������
	void getAttackors(TPackAttackorList* attackors);
	// ��ʹ�ü��ܺ��¼�
	void onAfterUse();
	// ��ȡ��ǰʹ�õļ���Ч����ѪID
	uint32	getSN();
	// ��ȡ��ǰʹ�õļ���ID
	TSkillTypeID_t getSkillID();
	// ��ȡ��ǰʹ�õļ��ܶ���
	CSkillLogicBase* getSkillLogicBase()const;
	// ��ȡ��ͨ����
	TOwnSkill* getCommonSkill() const;

	// ���ܺ��ķ�
public:
	// ��ȡ���ܵȼ�
	virtual TSkillLevel_t getSkillLevel(TSkillTypeID_t skillID);
	// �õ��������б�
	virtual void getSkillList(TOwnSkillVec* skills) {};
	// ������ͨ����
	void setCommSkillID(TSkillTypeID_t skillID, TSkillLevel_t level);
	// ��ȡ��ͨ����
	TSkillTypeID_t getCommSkillID();
	// ��ȡ��ͨ���ܹ�������
	TRange_t getCommSkillAttackDis();

protected:
	EGameRetCode	onBeforeUse();
	void            doImpact();
	void            doBroad();

protected:
	GXMISC::TDiffTime_t	getDelayTime();

private:
	void clean();

private:
	// ������
	CAttackPos          _attckMsg;
	// ��������
	CAttackTarget       _attackTarget;
	// �ӳ���ʾ����Ч��
	GXMISC::TDiffTime_t	_delayTime;
	// Ψһ��ʶ
	uint32				_SN;
	// �����߼�
	CSkillLogicBase*    _skillLogic;
	// ��ͨ����
	TOwnSkill			_commonSkill; 

private:
	CCharacterObject* _character;
};

#endif	// _CHAR_SKILL_CORE_H_