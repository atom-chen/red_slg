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

//伤害纪录
enum EDamageType
{
	DAMAGE_TYPE_INVALID,
	DAMAGE_TYPE_OBJ,
	DAMAGE_TYPE_TEAM,
};
typedef struct _DamageRecord
{
	uint8           type;				///< 类型
	TObjUID_t		killer;				///< 杀人
	TTeamIndex_t    teamID;				///< 组队ID
	THp_t		    damage;				///< 伤害
	GXMISC::TGameTime_t	lastCheckTime;	///< 上次检测时间

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
//伤害队列
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

	// 每隔两秒检测一次伤害
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

	// 事件管理
public:

	// 场景管理
public:
	virtual void onEnterScene(CMapScene* pScene);
	virtual void onLeaveScene(CMapScene* pScene);

	// 对象管理
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

	// 行为禁止 
public:
	virtual bool canBeAttack();

public:
	virtual EGameRetCode canAttackMe(CCharacterObject* pCharacter);	// 能否被攻击

	// 基础对象接口
public:
	virtual uint16 getShapeData(char* data, uint32 maxSize);      // 用于进入进出视野

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

	// 事件管理
public:
	virtual void onDie();
	virtual void onBeKill(CCharacterObject* pDestObj);

public:
	void calcDropOwner();

	// 基础属性
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
	TMonsterTypeID_t	_monsterTypeID;		// 怪物类型ID
	uint8				_stepRandRange;		// 路径随机范围
	TAxisPos			_bornPos;			// 出生位置
	TAreaRect			_bornRect;			// 出生范围
	uint8				_bornRectIndex;		// 出生的区域索引
	bool                _needRefresh;       // 是否需要刷新
	TObjUID_t           _ownerUID;          // 所有者UID
	THateValue_t		_initHateVal;		// 初始仇恨值

	// 移动处理
	GXMISC::TGameTime_t _nextRandPosTime;	// 下一次随机时间
	bool _resetPosFlag;						// 能否瞬移

	// 刷新处理
	GXMISC::TGameTime_t _lastFreshTime;
	TSceneID_t _bornSceneID;

	CMonsterAI	_ai;

	// 配置
	CMonsterConfigTbl           *_configTbl;
	CMonsterDistributeConfigTbl *_distributeTbl;

	// 攻击伤害
	CDamageMemList _damageList;
	TDropRoleVec _dropRoles;
	GXMISC::TGameTime_t _lastDamageCheckTime;

	TMonsterAttrBackup _attrBackup;					// 备份数据
	GXMISC::CManualIntervalTimer _shapeUpdateTimer;	// 外观更新定时器
	std::vector<TObjUID_t> _summonor;				// 被召唤的怪物

private:
	DMultiIndexImpl1(TObjUID_t, _objUID, INVALID_OBJ_UID);
};

#endif