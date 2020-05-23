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

// 对技能配置表的封装
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
	// 技能是否对自己
	bool isUseOwner();
	// 是否需要检测职业
	bool isNeedJobCheck();
	// 是否单体技能
	bool isSingle();
	// 是否群体技能
	bool isGroup();
	// 是否对自己人(无减益Buffer)
	bool isToSelf();
	// 是否对敌人
	bool isToEmeny();
	// 是否被动技能
	bool isPassiveSkill();
	// 是否主动技能
	bool isActive();


protected:
	enum EImpactType
	{
		IMPACT_TYPE_ME = 1,         // 效果对自身有效
		IMPACT_TYPE_OTHER = 2,      // 效果对敌人有效
	};

protected:
	TSkillTypeID_t id;              // 技能类型ID
	TSkillLevel_t _skillLevel;		// 技能等级
	TJob_t job;                     // 职业
	uint8 type;                     // 技能类型
	uint8 attackType;               // 攻击类型
	uint8 range;                    // 群攻效果范围,对大范围内的目标产生效果
	uint8 targetType;               // 目标类型
	TLevel_t maxLevel;				// 最大等级
	uint8 triggerDis;				// 施放距离
	uint32 cd;                      // 冷却时间
	uint32 commCd;					// 公用CD
	sint32 delayTime;               // 延迟时间
	std::vector<uint32> buffOdds;	// Buffer出现机率
	TBufferTypeID_t buffEffectID;	// buff效果
	uint32 effectType;              // 效果类型
	std::vector<TSkillEffectAttrVec> effects;	// 技能效果
	std::vector<TAddAttr> needMp;	// 使用消耗内力
	std::vector<TSkillParamsVec> parameter; // 技能参数
	uint8 _impactType;				// 攻击效果对自己还是对他人  @ref EImpactType
};

// 被攻击人搜索
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

// 技能数值计算(附加用'+'号计算, 并造成用*计算)
// 显示多次冒血效果
// 技能效果类型:

// 技能逻辑基类
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
	virtual EGameRetCode onBeforeUse(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);        // 使用前
	virtual EGameRetCode onAfterUse(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);         // 使用后
	virtual EGameRetCode check(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);              // 检测技能是否可以使用
	virtual EGameRetCode selectTarget(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);       // 选择目标

public:
	virtual void calcHurt(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);                   // 计算伤害
	virtual void showImpact(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);                 // 显示冒血效果
	virtual void doConsume(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);                  // 处理消耗

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
	virtual void onAfterSelectTarget(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);      // 在选择攻击目标后
	virtual void onBeforeCalcHurt(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);         // 伤害计算前
	virtual void onAfterCalcHurt(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);          // 伤害计算后
	virtual void onActivate(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget);               // 技能触发
	virtual bool onLoad(CCharacterObject* rMe, const CAttackPos* pos);														// 技能加载
protected:
	CSkillInfo _skillInfo;                          // 技能信息
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