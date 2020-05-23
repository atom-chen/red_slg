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
	TObjUID_t		casterObjUID;			// ʩ���ߵĶ���UID
	TObjGUID_t		casterObjGUID;			// ʩ���ߵ�GUID
	EObjType		casterType;				// ʩ���ߵ�����
	TSkillTypeID_t	skillID;				// ��������ID
	uint8			level;					// ���ܵȼ�
	TBufferTypeID_t	buffTypeID;				// ����BufferID
};

class CItemBuff
{
public:
	TObjUID_t		casterObjUID;		// ʩ���ߵĶ���UID
	TObjGUID_t		casterObjGUID;		// ʩ���ߵ�GUID
	EObjType		casterType;			// ʩ���ߵ�����
	TItemTypeID_t	itemID;				// ��ƷID
	uint8			quality;			// ��ƷƷ��
	TBufferTypeID_t	buffTypeID;			// ��ƷBufferID
};

class CBufferImpactBase;

class CBufferConfigTbl;

class CBufferEffect
{
public:
	CBufferEffect();
	~CBufferEffect();

	// ���浽���ݿ�
public:
	bool			active;				// �Ƿ���Ȼ��Ч
	TBufferTypeID_t	buffTypeID;			// BufferID
	EBuffType		buffType;			// BuffType
	TObjUID_t		casterObjUID;		// ʩ���ߵĶ���UID
	TObjGUID_t		casterObjGUID;		// ʩ���ߵ�GUID
	EObjType		casterType;			// ʩ���ߵ�����
	TItemTypeID_t	otherID;			// ��Ʒ��������ID
	GXMISC::TGameTime_t startTime;      // ��ʼʱ��
	GXMISC::TTime	lastTime;			// ��һ��ִ��ʱ��
	GXMISC::TTime	timeElapsed;		// �Ѿ�������ʱ��(΢��)
	uint8 times;						// �������Ĵ���
	uint8 level;						// Buffer�ȼ�(�ߵȼ�Buffer���ܱ��͵ȼ�Buffer����)
	GXMISC::TTime totalTime;			// �ܵĳ���ʱ��(΢��)
	TBuffParamAry params;               // �������

	// �����浽���ݿ�
public:
	GXMISC::TDiffTime_t intervalTime;	// �������ʱ��(΢��)
	TObjUID_t forceHateObjUID;          // ���ճ��ǰ����ObjUID

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
	CBufferConfigTbl* buffRow;			// Buff��
	CBufferImpactBase* buffImpact;      // BuffЧ���������

	DObjToString5Alias(CBufferEffect, TBufferTypeID_t, BuffTypeID, buffTypeID, EBuffType, BuffType, buffType,
		TObjUID_t, CastObjUID, casterObjUID, uint32, ElapsedTime, timeElapsed, uint32, TotalTime, totalTime);
};

class CCharacterObject;

typedef GXMISC::CFixBitSet<BUFF_EVENT_FLAG_NUM> TBuffEventFlagSet;

// Buffer����
class CBufferImpactBase
{
public:
	CBufferImpactBase(TBufferTypeID_t buffID);
	virtual ~CBufferImpactBase(){}

public:
	void update(CBufferEffect* buff, GXMISC::TDiffTime_t diff);					// ��ʱ����
	void updateBuff(CBufferEffect* buff);										// ����Buff����

public:
	virtual bool isDurationTime();                                              // ����ʱ��
	virtual bool isCountTime();                                                 // �������

public:
	// ����Buffer��Ӧ�ı������, �жϴ�Buffer�ܷ�ӵ���ɫ����(����������ݵļ��)
	virtual bool initFromData(CBufferEffect* buff, CCharacterObject* rMe, bool loadDbFlag);
	virtual bool loadFromDb(CBufferEffect*, CCharacterObject* rMe);				// �����ݿ���ؽ���
	virtual bool isTimeout(CBufferEffect* buff);								// �Ƿ�ʱ
	virtual bool isIntervaled(CBufferEffect* buff);								// �Ƿ񱻴���
	virtual void reload(CBufferEffect* buff, CCharacterObject* rMe);			// ���¼���
	CBufferConfigTbl* getBufferConfig();                                        // ��ȡ���ñ�

public:
	virtual sint8 getRange(TSkillLevel_t level);                                // ��ȡʩ�ŷ�Χ
	virtual bool isRangeBuff();                                                 // �Ƿ�Ϊ��Χbuff

public:
	virtual void onAdd(CBufferEffect* buff, CCharacterObject* rMe);             // ���
	virtual sint32 onActive(CBufferEffect* buff, CCharacterObject* rMe);		// ������(Ĭ��ʵ��, ������Ե���ɫ����ȥ, ����ֵ:������Ч���򷵻ؾ���Ч��ֵ)
	virtual void onFadeout(CBufferEffect* buff, CCharacterObject* rMe);			// Buff��ʧ
	virtual void onDamage(CBufferEffect* buff, CCharacterObject* rMe){}			// �ܵ�����
	virtual void onDie(CBufferEffect* buff, CCharacterObject* rMe){}			// ����
	virtual void onHit(CBufferEffect* buff, CCharacterObject* rMe){}			// ��������
	virtual void onEffectAtStart(CBufferEffect* buff, CCharacterObject* rMe);	// �����ʱ����
	virtual void onReload(CBufferEffect* buff, CCharacterObject* rMe);          // ���¼���
	virtual void enterView(CBufferEffect* buff, CCharacterObject* rMe, CCharacterObject* other){}    // ������Ұ

public:
	// ��ȡ��������
	virtual void getAttrs(CBufferEffect* buff, CCharacterObject* rMe, TBufferAttrs* buffAttrs);
	// �������й���������
	virtual void markModifiedAttrDirty(CBufferEffect* buff, CCharacterObject* rMe);
	// ��ȡBuffer��ֹ����Ϊ
	void getActionBan(CBufferEffect* buff, CCharacterObject* rMe, CActionBan* bans);
	// �Ƿ�����Ϊ��ֹ���
	virtual bool isActionBan();
	// ��ȡ�¼����
	void getBuffEvent(CBufferEffect* buff, CCharacterObject* rMe, TBuffEventFlagSet* buffEvents);
	// �Ƿ����¼�
	virtual bool isEvent();
	// �Ƿ����¼�
	bool isEvent(EBuffEventFlag flag);
	// �Ƿ���Ҫˢ������
	virtual bool isRefreshAttr();
	// ��ȡ�¼�Ч������
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