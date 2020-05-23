#ifndef _MONSTER_H_
#define _MONSTER_H_

#include <list>

#include "obj_character.h"
#include "game_util.h"
#include "multi_index.h"
#include "server_define.h"
#include "path_finder.h"
#include "ai_monster.h"
#include "attr_backup_struct.h"

class CMonster;
class CMapScene;
class CMonsterConfigTbl;
class CMonsterDistributeConfigTbl;

//�˺���¼
enum EDamageType
{
	DAMAGE_TYPE_INVALID,
	DAMAGE_TYPE_OBJ,
	DAMAGE_TYPE_TEAM,
};
typedef struct _DamageRecord
{
	uint8           type;				///< ����
	TObjUID_t		killer;				///< ɱ��
	TTeamIndex_t    teamID;				///< ���ID
	THp_t		    damage;				///< �˺�
	GXMISC::TGameTime_t	lastCheckTime;	///< �ϴμ��ʱ��

	_DamageRecord()
	{
		cleanUp();
	}
	void	cleanUp()
	{
		type = DAMAGE_TYPE_INVALID;
		killer = INVALID_OBJ_UID;
		teamID = INVALID_TEAM_ID;
		damage = 0;
		lastCheckTime = DTimeManager.nowSysTime();
	}
	bool isInvalid()
	{
		return type == DAMAGE_TYPE_INVALID;
	}

	_DamageRecord& operator=(const _DamageRecord& rhs)
	{
		type = rhs.type;
		killer = rhs.killer;
		teamID = rhs.teamID;
		damage = rhs.damage;
		lastCheckTime = rhs.lastCheckTime;
		return *this;
	}

}TDamageRecord;
//�˺�����
typedef std::map<TObjUID_t, TDamageRecord> TDamageMap;
class CDamageMemList
{
public:
	CDamageMemList()
	{
		cleanUp();
	}
	~CDamageMemList()
	{
		cleanUp();
	}

private:
	TDamageMap _damageRec;
	TDamageRecord _maxDamageRec;
	CMonster* _pMonster;
public:
	void	cleanUp()
	{
		_damageRec.clear();
		_maxDamageRec.cleanUp();
	}
	void init(CMonster* pMonster)
	{
		_pMonster = pMonster;
	}

	// ÿ��������һ���˺�
	void check();
	bool checkMaxRec();
	void checkAll(bool delFlag);

	TDamageRecord& getMaxDamageRec();
	TDamageRecord* update(TObjUID_t	killerID, TTeamIndex_t killerTeam, THp_t damage);
	TDamageRecord* addMember(TObjUID_t	killerID, TTeamIndex_t killerTeam, THp_t damage);
	TDamageRecord*	findMember(TObjUID_t killerID, TTeamIndex_t killerTeam);
	void delMember(TObjUID_t killerID, TTeamIndex_t killerTeam, bool reGetMaxFlag);
	sint32 size();
};

typedef struct _DropRole
{
	TRoleUID_t roleUID;
	bool dropItemFlag;
}TDropRole;
typedef std::vector<TDropRole> TDropRoleVec;

class CMonster : public CCharacterObject
{
	friend class CMonsterAI;

public:
	typedef CCharacterObject TBaseType;

public:
	CMonster();
	~CMonster();

public:
	virtual bool init(const TCharacterInit* inits);
	virtual bool update(uint32 diff);
	virtual void cleanUp();

	// �¼�����
public:

	// ��������
public:
	virtual void onEnterScene(CMapScene* pScene);
	virtual void onLeaveScene(CMapScene* pScene);

	// �������
public:
	bool isTimeFresh(GXMISC::TGameTime_t curTime);
	bool isTimeRandMove(GXMISC::TGameTime_t curTime);
	bool isNeedToAttack(CCharacterObject* pObj);
	void checkAttackorHate();
	const CMonsterAI* getMonsterAI()const;
	void updateDamageList(CCharacterObject* pCharacter, THp_t nDamage);
	virtual bool isSameCamp(CCharacterObject* obj);
	virtual void setOwnerUID(TObjUID_t objUID);
	virtual TObjUID_t getOwnerUID();
	virtual TSkillLevel_t getSkillLevel(TSkillTypeID_t skillID);

	// ��Ϊ��ֹ 
public:
	virtual bool canBeAttack();

public:
	virtual EGameRetCode canAttackMe(CCharacterObject* pCharacter);	// �ܷ񱻹���

	// ��������ӿ�
public:
	virtual uint16 getShapeData(char* data, uint32 maxSize);      // ���ڽ��������Ұ

public:
	bool onLoadFromTbl(CMonsterDistributeConfigTbl* distribute, TBlockID_t blockID, CMapScene* pScene);
	bool onLoadFromTbl(TMonsterTypeID_t monsterTypeID, TMapID_t mapID, const TAxisPos& pos, bool needRefresh, CMapScene* pScene, bool randPosFlag = true);
	CMonsterConfigTbl* getConfigTbl(){ return _configTbl; }
	CMonsterDistributeConfigTbl* getDistributeConfigTbl() { return _distributeTbl; }
	TMonsterTypeID_t getMonsterTypeID(){ return _monsterTypeID; }

	// AI
public:
	TScriptID_t getAIScriptID();
	float getHpRate();
	bool canFlee();
	bool canSummon();
	bool canApproach();
	bool canRandMove();
	void addSummonor(TObjUID_t objUID);
	void clearSummonMon();
	CDamageMemList& getDamageMemList();

private:
	void loadBaseAttr();

public:
	void doRandMove(GXMISC::TGameTime_t curTime);
	void setResetPosFlag(bool flag);
	bool canResetPos();

	// �¼�����
public:
	virtual void onDie();
	virtual void onBeKill(CCharacterObject* pDestObj);

public:
	void calcDropOwner();

	// ��������
public:
	void setBornPos(TAxisPos& bornPos);
	TAxisPos getBornPos();
	uint8 getBornRectIndex();
	TSceneID_t getBornSceneID();
	TAreaRect& getBornRect();
	bool isNeedFresh();
	sint32 getInitHateValue();
	virtual void refreshShape(bool sendFlag);

protected:
	void checkMem();

public:
	virtual const char* toString() const;

private:
	TMonsterTypeID_t	_monsterTypeID;		// ��������ID
	uint8				_stepRandRange;		// ·�������Χ
	TAxisPos			_bornPos;			// ����λ��
	TAreaRect			_bornRect;			// ������Χ
	uint8				_bornRectIndex;		// ��������������
	bool                _needRefresh;       // �Ƿ���Ҫˢ��
	TObjUID_t           _ownerUID;          // ������UID
	THateValue_t		_initHateVal;		// ��ʼ���ֵ

	// �ƶ�����
	GXMISC::TGameTime_t _nextRandPosTime;	// ��һ�����ʱ��
	bool _resetPosFlag;						// �ܷ�˲��

	// ˢ�´���
	GXMISC::TGameTime_t _lastFreshTime;
	TSceneID_t _bornSceneID;

	CMonsterAI	_ai;

	// ����
	CMonsterConfigTbl           *_configTbl;
	CMonsterDistributeConfigTbl *_distributeTbl;

	// �����˺�
	CDamageMemList _damageList;
	TDropRoleVec _dropRoles;
	GXMISC::TGameTime_t _lastDamageCheckTime;

	TMonsterAttrBackup _attrBackup;					// ��������
	GXMISC::CManualIntervalTimer _shapeUpdateTimer;	// ��۸��¶�ʱ��
	std::vector<TObjUID_t> _summonor;				// ���ٻ��Ĺ���

private:
	DMultiIndexImpl1(TObjUID_t, _objUID, INVALID_OBJ_UID);
};

#endif