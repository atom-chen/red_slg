#ifndef _BUFF_MANAGER_H_
#define _BUFF_MANAGER_H_

#include "buff.h"
#include "module_def.h"
#include "packet_struct.h"
#include "user_struct.h"

class CRoleBase;

class CBufferManager
{
public:
	typedef CHashMap<TBufferTypeID_t, CBufferEffect> TEffectHashMap;

public:
	CBufferManager();
	~CBufferManager(){}

public:
	// 注册所有的Buff
	static bool InitImpacts();

public:
	virtual bool onLoad();
	virtual void onSave(bool offLineFlag);
	virtual void update(GXMISC::TDiffTime_t diff);
	virtual bool onBeforeChangeLine(TChangeLineTempData* tempData);
	virtual bool onAfterChangeLine(TChangeLineTempData* tempData);

private:
	bool _onLoad(TOwnerBuffAry* buffAry);
	void _onSave(TOwnerBuffAry* buffAry, bool offlineFlag);
	void _delEventBuff(EBuffEventFlag eventFlag);
	CBufferEffect* _getEventBuff(EBuffEventFlag eventFlag);

public:
	// 添加技能Buff
	EGameRetCode addEffect(CSkillBuff* buff, bool isNew = true);
	// 添加物品Buff
	EGameRetCode addEffect(CItemBuff* buff, bool isNew = true);
	// 添加被动动技能Buff
	EGameRetCode addPassiveEffect(CSkillBuff* buff, bool isNew = true);
	// 加载被动技能
	void loadPassiveEffect();
	// 通过BufferID获取Buffer
	CBufferEffect* getBuff(TBufferTypeID_t buffID);
	// 获取Buffer列表
	void getBuffAry(TPackBufferAry* buffAry);

public:
	// 添加被动技能效果
	void processPassivEffect();
	// 更新主动技能效果
	void processActiveEffect(GXMISC::TDiffTime_t diff);
	// 更新物品效果
	void processItemEffect(GXMISC::TDiffTime_t diff);
	// 清理主动技能效果
	void clearActiveEffect();
	// 清理物品效果
	void clearItemEffect();

public:
	// 计算主动技能属性
	void calcActiveAttr();
	// 计算被动技能属性
	void calcPassiveAttr();
	// 计算物品属性
	void calcItemAttr();
	// 重新计算行为禁止标记
	void rebuildActionFlags();
	// 重新计算事件标记
	void rebuildEventFlags();

	// 获取到Buff属性
	TBufferAttrs* getBuffAttrs();
	TBufferAttrs* getPassiveAttrs();
	TBufferAttrs* getItemAttrs();

	// 得到经验倍数
	TAttrVal_t getExpRate();

public:
	// 计算属性
	static void CalcPassiveAttr(TOwnSkillVec* skills, TBufferAttrs* buffAttrs);

private:
	void onAddEffect(CBufferEffect* buffer, bool reloadFlag, bool sendFlag);
	void onDelEffect(CBufferEffect* buffer, bool sendFlag = false);

public:
	void sendAddAllEffect(CRoleBase* pRole = NULL);
	void sendDelAllEffect();
	void sendAdd(CBufferEffect* buffer);
	void sendDel(CBufferEffect* buffer);

public:
	// 死亡
	void onDie();
	// 受到伤害
	void onHurt();
	// 命中
	void onHit();
	// 技能变化
	void onStudySkill(TSkillTypeID_t skillID, TSkillLevel_t level);
	// 受到技能攻击
	void onBeUseSkill(CCharacterObject* pAttacker);

public:
	bool isOnDieEvt();
	bool isOnDamageEvt();
	bool isForceHateEvt();
	bool isReflectEvt();
	bool isSleepEvt();
	bool isStopEvt();
	bool isDizzEvt();

public:
	bool isBuffIDExist(TBufferTypeID_t buffID);

public:
	void logAttr(uint32 num);

private:
	static CBufferImpactBase* BufferImpactList[MAX_BUFFER_EFFECT_NUM];

private:
	// 主动效果属性
	TBufferAttrs    _activeBuffAttr;
	// 被动效果属性
	TBufferAttrs    _passiveBuffAttr;
	// 物品效果属性
	TBufferAttrs    _itemBuffAttr;

private:
	// 主动技能效果
	TEffectHashMap _activeSkillEffect;
	// 永久被动技能效果
	TEffectHashMap _passivenessSkillEffect;
	// 主动物品效果
	TEffectHashMap _activeItemEffect;
	// 事件标记
	TBuffEventFlagSet _buffEventFlags;

private:
	CCharacterObject* _owner;
};

#endif