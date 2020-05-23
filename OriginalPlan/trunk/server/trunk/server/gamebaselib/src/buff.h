#ifndef _BUFF_H_
#define _BUFF_H_

#include "game_util.h"
#include "hash_util.h"
#include "time_util.h"
#include "game_errno.h"
#include "attributes.h"
#include "module_def.h"
#include "packet_struct.h"
#include "game_struct.h"


#define MAX_BUFFER_EFFECT_NUM 500

class CSkillBuff
{
public:
	TObjUID_t		casterObjUID;			// 施加者的对象UID
	TObjGUID_t		casterObjGUID;			// 施加者的GUID
	EObjType		casterType;				// 施加者的类型
	TSkillTypeID_t	skillID;				// 技能类型ID
	uint8			level;					// 技能等级
	TBufferTypeID_t	buffTypeID;				// 技能BufferID
};

class CItemBuff
{
public:
	TObjUID_t		casterObjUID;		// 施加者的对象UID
	TObjGUID_t		casterObjGUID;		// 施加者的GUID
	EObjType		casterType;			// 施加者的类型
	TItemTypeID_t	itemID;				// 物品ID
	uint8			quality;			// 物品品质
	TBufferTypeID_t	buffTypeID;			// 物品BufferID
};

class CBufferImpactBase;

class CBufferConfigTbl;

class CBufferEffect
{
public:
	CBufferEffect();
	~CBufferEffect();

	// 保存到数据库
public:
	bool			active;				// 是否仍然有效
	TBufferTypeID_t	buffTypeID;			// BufferID
	EBuffType		buffType;			// BuffType
	TObjUID_t		casterObjUID;		// 施加者的对象UID
	TObjGUID_t		casterObjGUID;		// 施加者的GUID
	EObjType		casterType;			// 施加者的类型
	TItemTypeID_t	otherID;			// 物品或技能类型ID
	GXMISC::TGameTime_t startTime;      // 开始时间
	GXMISC::TTime	lastTime;			// 上一次执行时间
	GXMISC::TTime	timeElapsed;		// 已经持续的时间(微秒)
	uint8 times;						// 被触发的次数
	uint8 level;						// Buffer等级(高等级Buffer不能被低等级Buffer代替)
	GXMISC::TTime totalTime;			// 总的持续时间(微秒)
	TBuffParamAry params;               // 额外参数

	// 不保存到数据库
public:
	GXMISC::TDiffTime_t intervalTime;	// 间隔触发时间(微秒)
	TObjUID_t forceHateObjUID;          // 吸收仇恨前攻击ObjUID

public:
	bool isActive();
	bool isNeedSave();
	GXMISC::TDiffTime_t getRemainTime();
	void reload();
	void log();

public:
	CBufferEffect& operator=(const TOwnerBuffer& buff)
	{
		active = true;
		buffTypeID = buff.buffTypeID;
		buffType = buff.buffType;
		casterObjUID = buff.casterObjUID;
		casterObjGUID = buff.casterObjGUID;
		casterType = buff.casterType;
		otherID = buff.otherID;
		startTime = buff.startTime;
		lastTime = buff.lastTime;
		timeElapsed = buff.timeElapsed;
		times = buff.times;
		level = buff.level;
		totalTime = buff.totoalTime;
		params = buff.params;

		return *this;
	}

	void getOwnerBuff(TOwnerBuffer* buff);
	void getPackBuff(TPackBuffer* buff);

public:
	CBufferConfigTbl* buffRow;			// Buff表
	CBufferImpactBase* buffImpact;      // Buff效果处理对象

	DObjToString5Alias(CBufferEffect, TBufferTypeID_t, BuffTypeID, buffTypeID, EBuffType, BuffType, buffType,
		TObjUID_t, CastObjUID, casterObjUID, uint32, ElapsedTime, timeElapsed, uint32, TotalTime, totalTime);
};

class CCharacterObject;

typedef GXMISC::CFixBitSet<BUFF_EVENT_FLAG_NUM> TBuffEventFlagSet;

// Buffer基类
class CBufferImpactBase
{
public:
	CBufferImpactBase(TBufferTypeID_t buffID);
	virtual ~CBufferImpactBase(){}

public:
	void update(CBufferEffect* buff, GXMISC::TDiffTime_t diff);					// 定时更新
	void updateBuff(CBufferEffect* buff);										// 更新Buff数据

public:
	virtual bool isDurationTime();                                              // 持续时间
	virtual bool isCountTime();                                                 // 间隔触发

public:
	// 加载Buffer对应的表格数据, 判断此Buffer能否加到角色身上(包括表格数据的检测)
	virtual bool initFromData(CBufferEffect* buff, CCharacterObject* rMe, bool loadDbFlag);
	virtual bool loadFromDb(CBufferEffect*, CCharacterObject* rMe);				// 从数据库加载进来
	virtual bool isTimeout(CBufferEffect* buff);								// 是否超时
	virtual bool isIntervaled(CBufferEffect* buff);								// 是否被触发
	virtual void reload(CBufferEffect* buff, CCharacterObject* rMe);			// 重新加载
	CBufferConfigTbl* getBufferConfig();                                        // 获取配置表

public:
	virtual sint8 getRange(TSkillLevel_t level);                                // 获取施放范围
	virtual bool isRangeBuff();                                                 // 是否为范围buff

public:
	virtual void onAdd(CBufferEffect* buff, CCharacterObject* rMe);             // 添加
	virtual sint32 onActive(CBufferEffect* buff, CCharacterObject* rMe);		// 被触发(默认实现, 添加属性到角色身上去, 返回值:触发了效果则返回具体效果值)
	virtual void onFadeout(CBufferEffect* buff, CCharacterObject* rMe);			// Buff消失
	virtual void onDamage(CBufferEffect* buff, CCharacterObject* rMe){}			// 受到攻击
	virtual void onDie(CBufferEffect* buff, CCharacterObject* rMe){}			// 死亡
	virtual void onHit(CBufferEffect* buff, CCharacterObject* rMe){}			// 攻击别人
	virtual void onEffectAtStart(CBufferEffect* buff, CCharacterObject* rMe);	// 在添加时触发
	virtual void onReload(CBufferEffect* buff, CCharacterObject* rMe);          // 重新加载
	virtual void enterView(CBufferEffect* buff, CCharacterObject* rMe, CCharacterObject* other){}    // 进入视野

public:
	// 获取所有属性
	virtual void getAttrs(CBufferEffect* buff, CCharacterObject* rMe, TBufferAttrs* buffAttrs);
	// 置脏所有关联的属性
	virtual void markModifiedAttrDirty(CBufferEffect* buff, CCharacterObject* rMe);
	// 获取Buffer禁止的行为
	void getActionBan(CBufferEffect* buff, CCharacterObject* rMe, CActionBan* bans);
	// 是否有行为禁止标记
	virtual bool isActionBan();
	// 获取事件标记
	void getBuffEvent(CBufferEffect* buff, CCharacterObject* rMe, TBuffEventFlagSet* buffEvents);
	// 是否有事件
	virtual bool isEvent();
	// 是否有事件
	bool isEvent(EBuffEventFlag flag);
	// 是否需要刷新属性
	virtual bool isRefreshAttr();
	// 获取事件效果类型
	EBuffEffectType getEffectType();

protected:
	virtual sint32 addAttr(CBufferEffect* buff, CCharacterObject* rMe);
	virtual sint32 addAttr(CBufferEffect* buff, CCharacterObject* rMe, TBuffAttrAry* buffAttr);
	virtual TAttrVal_t addFilterAttr(CBufferEffect* buff, CCharacterObject* rMe, TExtendAttr* attr, TBuffImpactAry* impactAry);
	virtual bool isAddFilterAttr(TAttrType_t type);
	TAttrVal_t addFilterAttr(CCharacterObject* rMe, CCharacterObject* rOther, TExtendAttr* attr, TBuffImpactAry* impactAry);
	TAttrVal_t getMaxAttr(CCharacterObject* rMe, TExtendAttr* attr);

public:
	void logBuffer(CBufferEffect* buff);

protected:
	void logAttr(TSkillLevel_t level);
	void logActionBan();

protected:
	CBufferConfigTbl* _buffRow;
	TBuffEventFlagSet _buffEventFlags;
	CActionBan _buffBan;
	EBuffEffectType _buffEffectType;
};

#endif