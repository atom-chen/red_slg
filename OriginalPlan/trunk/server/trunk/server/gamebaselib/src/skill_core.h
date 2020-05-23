#ifndef _SKILL_CORE_H_
#define _SKILL_CORE_H_

#include "game_util.h"
#include "game_errno.h"
#include "carray.h"
#include "attributes.h"
#include "singleton.h"
#include "packet_struct.h"
#include "scan.h"
#include "game_struct.h"
#include "skill_util.h"

class CCharacterObject;

// �Լ������ñ�ķ�װ
class CSkillInfo
{
	friend class CSkillLogicBase;
	friend class CCharFightCore;

public:
	CSkillInfo();
	~CSkillInfo();

public:
	void cleanUp();
	EGameRetCode load(TSkillTypeID_t skillIDType, CCharacterObject* pObj);
	void doEffect(CCharacterObject* rObj, bool des);
	TSkillLevel_t getLevel(){ return _skillLevel; }

public:
	TSkillTypeID_t getSkillTypeID();
	TJob_t getJob();
	uint8 getType();
	uint8 getAttackType();
	uint8 getTargetType();
	uint32 getOdds();
	uint8 getDistance();
	uint32 getCD();
	uint32 getCommCD();
	TMp_t getNeedEnery();
	uint32 getParamSize();
	TSkillParamsVec* getParamVec();
	uint32 getDelayTime();
	sint32 getEffectSize();

public:
	// �����Ƿ���Լ�
	bool isUseOwner();
	// �Ƿ���Ҫ���ְҵ
	bool isNeedJobCheck();
	// �Ƿ��弼��
	bool isSingle();
	// �Ƿ�Ⱥ�弼��
	bool isGroup();
	// �Ƿ���Լ���(�޼���Buffer)
	bool isToSelf();
	// �Ƿ�Ե���
	bool isToEmeny();
	// �Ƿ񱻶�����
	bool isPassiveSkill();
	// �Ƿ���������
	bool isActive();


protected:
	enum EImpactType
	{
		IMPACT_TYPE_ME = 1,         // Ч����������Ч
		IMPACT_TYPE_OTHER = 2,      // Ч���Ե�����Ч
	};

protected:
	TSkillTypeID_t id;              // ��������ID
	TSkillLevel_t _skillLevel;		// ���ܵȼ�
	TJob_t job;                     // ְҵ
	uint8 type;                     // ��������
	uint8 attackType;               // ��������
	uint8 range;                    // Ⱥ��Ч����Χ,�Դ�Χ�ڵ�Ŀ�����Ч��
	uint8 targetType;               // Ŀ������
	TLevel_t maxLevel;				// ���ȼ�
	uint8 triggerDis;				// ʩ�ž���
	uint32 cd;                      // ��ȴʱ��
	uint32 commCd;					// ����CD
	sint32 delayTime;               // �ӳ�ʱ��
	std::vector<uint32> buffOdds;	// Buffer���ֻ���
	TBufferTypeID_t buffEffectID;	// buffЧ��
	uint32 effectType;              // Ч������
	std::vector<TSkillEffectAttrVec> effects;	// ����Ч��
	std::vector<TAddAttr> needMp;	// ʹ����������
	std::vector<TSkillParamsVec> parameter; // ���ܲ���
	uint8 _impactType;				// ����Ч�����Լ����Ƕ�����  @ref EImpactType
};

// ������������
class CSkillTargetScanInit : public TScanOperatorInit
{
public:
	CSkillTargetScanInit(CAttackorList* atts, CSkillInfo* sinfo) : TScanOperatorInit(), skillRanage(1), pos(), targets(*atts), skillInfo(*sinfo){}
	~CSkillTargetScanInit(){}

public:
	uint8 skillRanage;
	uint8 attackNum;
	TAxisPos pos;
	CAttackorList& targets;
	CSkillInfo& skillInfo;
	CCharacterObject* pChartMe;
};
class CSkillTargetScan : public CScanOperator
{
public:
	typedef CScanOperator TBaseType;
public:
	CSkillTargetScan(CCharacterObject* attacker);
	~CSkillTargetScan();

public:
	virtual EScanReturn onFindObject(CGameObject* pObj);
private:
	CCharacterObject* _attacker;
};

// ������ֵ����(������'+'�ż���, �������*����)
// ��ʾ���ðѪЧ��
// ����Ч������:

// �����߼�����
class CSkillLogicBase
{
public:
	CSkillLogicBase(TSkillTypeID_t skillTypeID);
	~CSkillLogicBase();

public:
	void init();
	void cleanUp();
	CSkillInfo* getSkillInfo();

public:
	EGameRetCode load(CCharacterObject* rMe, const CAttackPos* pos);

public:
	virtual bool checkLevel(){ return true; }
	virtual uint8 getMaxAttackNum();
	virtual bool needCalcHurt();

public:
	virtual EGameRetCode onBeforeUse(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);        // ʹ��ǰ
	virtual EGameRetCode onAfterUse(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);         // ʹ�ú�
	virtual EGameRetCode check(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);              // ��⼼���Ƿ����ʹ��
	virtual EGameRetCode selectTarget(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);       // ѡ��Ŀ��

public:
	virtual void calcHurt(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);                   // �����˺�
	virtual void showImpact(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);                 // ��ʾðѪЧ��
	virtual void doConsume(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);                  // ��������

protected:
	EGameRetCode checkDistance(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);
	EGameRetCode checkTarget(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);
	EGameRetCode checkType(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);
	EGameRetCode checkObj(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);
	EGameRetCode checkJob(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);
	EGameRetCode checkOwer(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);

protected:
	TAxisPos getAttackPos(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);
	void loadEffect(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget, CCharacterObject* rObj, bool des);
	bool isDirectAddAttr(TAttrType_t attrType);
	virtual TAttrVal_t addDirectAttr(CCharacterObject* rMe, const CAttackPos* attackPos,
		CAttackTarget* attackTarget, CCharacterObject* rObj, TExtendAttr* attr);

public:
	virtual void onAfterSelectTarget(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);      // ��ѡ�񹥻�Ŀ���
	virtual void onBeforeCalcHurt(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);         // �˺�����ǰ
	virtual void onAfterCalcHurt(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);          // �˺������
	virtual void onActivate(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);               // ���ܴ���
	virtual bool onLoad(CCharacterObject* rMe, const CAttackPos* pos);														// ���ܼ���
protected:
	CSkillInfo _skillInfo;                          // ������Ϣ
};

class CSkillLogicManager : public GXMISC::CManualSingleton<CSkillLogicManager>
{
public:
	typedef GXMISC::CFixArray<CSkillLogicBase*, MAX_SKILL_ID + 1> TSkillFixAry;
	DSingletonImpl();

public:
	void initSkills();
	CSkillLogicBase* getSkillLogic(TSkillTypeID_t skillID);

private:
	TSkillFixAry _skillLogics;
};

#define DSkillLogicManager CSkillLogicManager::GetInstance()

#endif