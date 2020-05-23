// @BEGNODOC
#ifndef _GAME_STRUCT_H_
#define _GAME_STRUCT_H_

#include "core/stream_traits.h"
#include "core/carray.h"

#include "game_util.h"
#include "game_define.h"
#include "packet_struct.h"
#include "base_packet_def.h"
#include "attributes.h"
#include "streamable_util.h"
#include "game_time.h"

#pragma pack(push, 1)
// @ENDDOC
typedef struct ServerPwdInfo
{
	TPasswordStr_t	userName;
	TPasswordStr_t	userPwd;
	TPasswordStr_t	parsePwd;

	ServerPwdInfo()
	{
		cleanUp();
	}

	void cleanUp()
	{
		userName = INVALID_PASSWORD_STR;
		userPwd = INVALID_PASSWORD_STR;
		parsePwd = INVALID_PASSWORD_STR;
	}
}TServerPwdInfo;

// 场景注册
typedef struct SceneData
{
	TServerID_t mapServerID;		// 服务器ID
	TSceneID_t sceneID;				// 场景ID
	ESceneType sceneType;           // 场景类型
	sint32 maxRoleNum;				// 最大角色数
	uint32 curRoleNum;				// 当前角色数
	GXMISC::TGameTime_t openTime;   // 开启时间
	GXMISC::TDiffTime_t lastTime;   // 持续时间(s)
	TObjUID_t objUID;				// 所有者

	SceneData()
	{
		cleanUp();
	}

	void cleanUp()
	{
		mapServerID = INVALID_SERVER_ID;
		sceneID = INVALID_SCENE_ID;
		sceneType = SCENE_TYPE_INVALID;
		maxRoleNum = 0;
		curRoleNum = 0;
		openTime = GXMISC::INVALID_GAME_TIME;
		lastTime = 0;
		objUID = INVALID_OBJ_UID;
	}

	std::string toString()
	{
		return GXMISC::gxToString("MapServerID=%u,SceneID=%" I64_FMT "u,SceneType=%u,MaxRoleNum=%u,CurRoleNum=%u,LastTime=%u,OwnerObjUID=%u"
			, mapServerID,sceneID,sceneType,maxRoleNum,curRoleNum,lastTime,objUID);
	}
}TSceneData;
typedef GXMISC::CArray<TSceneData, MAX_SCENE_NUM> TSceneAry;

/// 服务器内部切换线信息
typedef struct ChangeLineWait
{
	TObjUID_t objUID;							///< 对象UID

	bool openDynaMapFlag;						///< 是否正在开启场景
	TMapID_t openMapID;							///< 开启的地图
	GXMISC::TGameTime_t openMapStartTime;       ///< 开启地图的开始时间
	uint32 openWaitTime;						///< 开启地图的等待时间

	// 源服务器所用的数据
	bool changeLineFlag;						///< 是否正在切线
	TServerID_t srcMapServerID;					///< 切线的源服务器
	TSceneID_t srcSceneID;						///< 切线的源场景
	TAxisPos srcPos;							///< 切线的源位置
	TServerID_t destMapServerID;				///< 切线的目标服务器
	TSceneID_t destSceneID;						///< 切线的目标场景     
	TAxisPos destPos;							///< 切线的目标位置
	GXMISC::TGameTime_t changeLineStartTime;    ///< 切线的开始时间
	uint32 changeLineWaitTime;					///< 切线的等待时间

	// 目标服务器所用的数据
	TAxisPos beforeChangePos;					///< 切线前的位置
	TMapID_t beforeChangeMapID;					///< 切线前的地图ID

	ChangeLineWait()
	{
		objUID = INVALID_OBJ_UID;
		changeLineWaitTime = 0;
		openWaitTime = 0;
		cleanUp();
		cleanUpBeforeChange();
	}

	void init(uint32 openWaitTime, uint32 changeLineWaitTime)
	{
		this->openWaitTime = openWaitTime;
		this->changeLineWaitTime = changeLineWaitTime;
	}

	std::string toChangeLineString()
	{
		if(changeLineFlag)
		{
			return GXMISC::gxToString("SrcMapServerID=%u,SrcSceneID=%" I64_FMT "u,SrcPos=%s,DestMapServerID=%u,"
				"DestSceneID=%" I64_FMT "u,DestPos=%s,StartTime=%u,WaitTime=%u", srcMapServerID, srcSceneID,
				srcPos.toString().c_str(), destMapServerID, destSceneID, destPos.toString().c_str(), changeLineStartTime, changeLineWaitTime);
		}

		return "";
	}

	std::string toOpenMapString()
	{
		if(openDynaMapFlag)
		{
			return GXMISC::gxToString("MapID=%u,StartTime=%u,WaitTime=%u", openMapID, openMapStartTime, openWaitTime);
		}

		return "";
	}

	void update()
	{
		if(openDynaMapFlag && (DTimeManager.nowSysTime()-openMapStartTime>openWaitTime))
		{
			cleanUpOpenMap();
		}

		if(changeLineFlag && (DTimeManager.nowSysTime()-changeLineStartTime>changeLineWaitTime))
		{
			cleanUpChangeLine();
		}
	}

	void cleanUp()
	{
		cleanUpOpenMap();
		cleanUpChangeLine();
	}

	void cleanUpOpenMap()
	{
		openDynaMapFlag = false;
		openMapID = INVALID_MAP_ID;
		openMapStartTime = GXMISC::MAX_GAME_TIME;
	}

	void cleanUpChangeLine()
	{
		changeLineFlag = false;
		destMapServerID = INVALID_SERVER_ID;
		destSceneID = INVALID_SCENE_ID;
		destPos.cleanUp();
		changeLineStartTime = GXMISC::MAX_GAME_TIME;
	}

	void cleanUpBeforeChange()
	{
		beforeChangePos = INVALID_AXIS_POS_T;
		beforeChangeMapID = INVALID_MAP_ID;
	}

	void startOpenMap(TMapID_t mapID)
	{
		openDynaMapFlag = true;
		openMapID = mapID;
		openMapStartTime = DTimeManager.nowSysTime();
	}

	void startChangeLine(TServerID_t srcMapServerID, TMapID_t srcMapID, TSceneID_t srcSceneID, const TAxisPos& srcPos,
		TServerID_t destMapServerID, TSceneID_t destSceneID, const TAxisPos& destPos )
	{
		this->srcMapServerID = srcMapServerID;
		this->srcSceneID = srcSceneID;
		this->srcPos = srcPos;
		this->destMapServerID = destMapServerID;
		this->destSceneID = destSceneID;
		this->destPos = destPos;
		changeLineFlag = true;
		changeLineStartTime = DTimeManager.nowSysTime();

		cleanUpBeforeChange();
		beforeChangePos = srcPos;
		beforeChangeMapID = srcMapID;
	}
}TChangeLineWait;

/// 切线及登陆时的加载等待数据
typedef struct LoadWaitEnter
{
	ELoadRoleType loadType;				///< 加载角色数据类型
	TSceneID_t destSceneID;				///< 目标场景
	TAxisPos pos;						///< 目标位置
	bool needSendAll;					///< 是否需要发送所有数据

	void setLoadType(ELoadRoleType type)
	{
		loadType = type;
	}
	void setDestSceneID(TSceneID_t sceneID)
	{
		destSceneID = sceneID;
	}

	void setPos(TAxisPos* pos)
	{
		this->pos = *pos;
	}

	void setNeedSendAll(bool flag)
	{
		needSendAll = flag;
	}

	LoadWaitEnter()
	{
		cleanUp();
	}

	void cleanUp()
	{
		loadType = LOAD_ROLE_TYPE_INVALID;
		destSceneID = INVALID_SCENE_ID;
		pos.cleanUp();
		needSendAll = false;
	}

	bool isFirstLogin()
	{
		return loadType == LOAD_ROLE_TYPE_LOGIN;
	}

	bool isChangeLine()
	{
		return loadType == LOAD_ROLE_TYPE_CHANGE_LINE;
	}

	bool isChangeMap()
	{
		return loadType == LOAD_ROLE_TYPE_CHANGE_MAP;
	}

	bool isTeleport()
	{
		return loadType == LOAD_ROLE_TYPE_TELE;
	}

	bool canTransmit()
	{
		return loadType == LOAD_ROLE_TYPE_INVALID;
	}
}TLoadWaitEnter;

/// 场景记录
typedef struct RoleSceneRecord
{
	uint8 enterSceneNum;			///< 进入场景的次数
	TSceneID_t lastSceneID;			///< 上次场景ID
	TMapID_t lastMapID;				///< 上次地图ID
	TAxisPos lastPos;				///< 上次坐标

	void cleanUp()
	{
		enterSceneNum = 0;
		lastMapID = INVALID_MAP_ID;
		lastSceneID = INVALID_SCENE_ID;
		lastPos = INVALID_AXIS_POS_T;
	}
}TRoleSceneRecord;

/// 加载角色数据
typedef struct LoadRoleData
{
	TRoleUID_t roleUID;				///< 角色UID
	TAccountID_t accountID;			///< 账号UID
	TObjUID_t objUID;				///< 对象UID
	ELoadRoleType loadType;				///< 加载类型
	TSceneID_t sceneID;				///< 场景ID
	TAxisPos pos;					///< 地图位置
	bool needOpenMap;				///< 是否需要开启地图
	TMapID_t mapID;					///< 地图ID

	LoadRoleData()
	{
		cleanUp();
	}

	void cleanUp()
	{
		roleUID = INVALID_ROLE_UID;
		objUID = INVALID_OBJ_UID;
		accountID = INVALID_ACCOUNT_ID;
		loadType = LOAD_ROLE_TYPE_LOGIN;
		sceneID = INVALID_SCENE_ID;
		pos.cleanUp();
		mapID = INVALID_MAP_ID;
		needOpenMap = false;
	}

	std::string toString() const
	{
		return GXMISC::gxToString("AccountID=%" I64_FMT "u,RoleUID=%" I64_FMT "u,ObjUID=%u,SceneID=%" I64_FMT "u,%s",
			accountID, roleUID, objUID,sceneID,pos.toString().c_str());
	}
}TLoadRoleData;

/// 地图服务器更新
typedef struct MapServerUpdate
{
	TServerID_t serverID;			///< 服务器ID
	sint32 maxRoleNum;                  ///< 最大角色数
	sint32 roleNums;					///< 角色数目
	TSceneAry scenes;					///< 场景列表
}TMapServerUpdate;
typedef GXMISC::CArray<TMapServerUpdate, MAX_MAP_SERVER> TMapServerAry;

/// Buffer效果
typedef struct BuffImpact
{
	BuffImpact()
	{
		cleanUp();
	}

	void cleanUp()
	{
		objUID = INVALID_OBJ_UID;
		destObjUID = INVALID_OBJ_UID;
		attr.cleanUp();
	}

public:
	TObjUID_t objUID;					///< 添加此Buff的对象ObjUID
	TObjUID_t destObjUID;				///< Buff所属者的ObjUID
	TAttr attr;							///< 变化的属性
}TBuffImpact;							///< Buffer效果
typedef std::vector<TBuffImpact> TBuffImpactAry;	///< Buffer效果列表

/// 攻击效果
typedef struct AttackorImpact
{
public:
	AttackorImpact()
	{
		cleanUp();
	}

	AttackorImpact(const TBuffImpact* impact)
	{
		cleanUp();
		*this = *impact;
	}

// 	AttackorImpact(const TBuffImpact* impact)
// 	{
// 		*this = *impact;
// 	}

	void cleanUp()
	{
		objUID = INVALID_OBJ_UID;
		attrType = INVALID_ATTR_INDEX;
		hp = 0;
		impactType = ATTACK_IMPACT_TYPE_NORMAL;
	}

	bool isInvalid()
	{
		return attrType == INVALID_ATTR_INDEX ;
	}

	const AttackorImpact& operator = (const TBuffImpact& impact)
	{
		objUID = impact.destObjUID;
		attrType = impact.attr.attrType;
		hp = impact.attr.attrValue;
		impactType = ATTACK_IMPACT_TYPE_NORMAL;
		return *this;
	}

public:
	TObjUID_t objUID;                       // 对象UID
	TAttrType_t attrType;                   // 属性类型
	TAttrVal_t  hp;							// 血量改变值
	TAttackImpactType_t impactType;         // 攻击效果类型

public:
	DPacketToString3Alias(TAttackorImpact,
		TObjUID_t, ObjUID, objUID,
		THp_t, HpChange, hp,
		TAttackImpactType_t, ImpactType, impactType);

}TAttackorImpact;
typedef std::vector<TAttackorImpact> TImpactAry;
typedef CArray1<TAttackorImpact, MAX_ATTACKOR_NUM> TPackAttackorList;

// 自身技能
typedef struct OwnSkill
{
	TSkillTypeID_t skillID;			//拥有的技能ID
	TSkillLevel_t level;

	OwnSkill() :
	skillID(INVALID_SKILL_TYPE_ID)
		,level(INVALID_SKILL_LEVEL)
	{

	}

	OwnSkill(TSkillTypeID_t skillTypeID, TSkillLevel_t skillLevel) :
	skillID(skillTypeID)
		,level(skillLevel)
	{

	}

	OwnSkill& operator = (const OwnSkill& ls)
	{
		skillID = ls.skillID;
		level = ls.level;
		return *this;
	}

	void cleanUp()
	{
		skillID = INVALID_SKILL_TYPE_ID;
		level = INVALID_SKILL_LEVEL;
	}

	bool operator != (const OwnSkill& ls) const
	{
		return (skillID != ls.skillID || level != ls.level);
	}

	bool operator == (const OwnSkill& ls) const
	{
		return (skillID == ls.skillID && level == ls.level);
	}

	void setSkillLevel(TSkillLevel_t nLevel)
	{
		gxAssert(nLevel<=MAX_SKILL_LEVEL);
		level = nLevel;
	}
	const TSkillLevel_t	getSkillLevel()
	{
		return level;
	}

}TOwnSkill;
typedef struct ExtUseSkill
{
	GXMISC::TAppTime_t startTime;	// 开始时间(毫秒)
	GXMISC::TDiffTime_t cdTime;		// 持续时间(毫秒)
	TOwnSkill skill;				// 技能

	ExtUseSkill() : startTime(0), cdTime(0)
	{
		skill.cleanUp();
	}

	bool operator == (const ExtUseSkill& ls) const
	{
		return (skill.skillID == ls.skill.skillID);
	}

	bool operator == ( TSkillTypeID_t skillID ) const
	{
		return (skill.skillID == skillID);
	}
}TExtUseSkill;
typedef GXMISC::CArray<TOwnSkill, MAX_SKILL_NUM> TOwnSkillAry;          // 自身技能列表
typedef std::vector<TOwnSkill> TOwnSkillVec;                            // 自身技能列表
typedef std::vector<TExtendAttr> TSkillEffectAttrVec;                   // 技能效果列表
typedef std::vector<sint32> TSkillParams;                               // 技能参数列表
typedef std::vector<TSkillParams> TSkillParamsVec;						// 技能参数列表
typedef std::list<TExtUseSkill> TExtUseSkillList;						// 使用技能列表
typedef std::vector<TSkillTypeID_t> TSkillIDVec;						// 技能列表

// 物品结构
typedef struct ItemIDNum
{
	TItemTypeID_t id;
	TItemNum_t num;

	ItemIDNum(TItemTypeID_t id, TItemNum_t num)
	{
		this->id = id;
		this->num = num;
	}
}TItemIDNum;
typedef std::vector<TItemIDNum> TItemIDNumVec;

// 地图结构
typedef struct MapIDRangePos
{
	TMapID_t mapID;
	TAxisPos pos;
	uint8 range;
}TMapIDRangePos;
typedef struct MapRangePos
{
	TAxisPos pos;
	uint8 range;
}TMapRangePos;
typedef struct MapIDPos
{
	TMapID_t mapID;
	TAxisPos pos;
}TMapIDPos;

/// 物品附加属性
typedef CArray1<struct AddAttr> TAddAttrAry;

/// 区服结构
typedef struct ZoneServer : public GXMISC::IStreamableAll
{
public:
	TWorldServerID_t serverID;					///< 区ID
 	TCharArray2 serverName;						///< 区名字
	uint8 state;								///< 区状态 @ref EZoneServerState
	uint8 flag;									///< 区标记 @ref EZoneServerFlag
public:
	DSTREAMABLE_IMPL1(serverName);
}TZoneServer;

typedef GXMISC::CArray<sint32,MAX_BUFF_PARAM_NUM> TBuffParamAry;		///< Buff参数列表
typedef std::vector<TExtendAttr> TBuffAttrAry;							///< Buff扩展属性列表
typedef std::vector<sint32> TBuffParamVec;								///< Buff参数列表

// Buffer结构
typedef struct OwnerBuffer
{
	// @member
public:
	TBufferTypeID_t	buffTypeID;			// BufferID
	EBuffType		buffType;			// BuffType
	TObjUID_t		casterObjUID;		// 施加者的对象UID
	TObjGUID_t		casterObjGUID;		// 施加者的GUID
	EObjType		casterType;			// 施加者的类型
	TItemTypeID_t	otherID;			// 物品或技能类型ID
	GXMISC::TGameTime_t     startTime;  // 开始时间
	GXMISC::TTime	totoalTime;			// 总的持续时间(微秒)
	GXMISC::TTime	lastTime;			// 上一次执行时间
	GXMISC::TTime	timeElapsed;		// 已经持续的时间(微秒)
	uint8 times;						// 被触发的次数
	uint8 level;						// Buffer等级(高等级Buffer不能被低等级Buffer代替)
	TBuffParamAry params;				// Buff参数

	bool operator == (TBufferTypeID_t buffTypeID) const
	{
		return this->buffTypeID == buffTypeID;
	}
}TOwnerBuffer;
typedef GXMISC::CArray<TOwnerBuffer, MAX_BUFF_DB_NUM> TOwnerBuffAry;

/// 封号/禁言地图结构
typedef struct LimitServerIDInfo
{
	// @member
public:
	TServerID_t			worldServerID;			///< 世界服务器ID

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}

	LimitServerIDInfo()
	{
		clean();
	}
}TLimitServerIDInfo;

typedef GXMISC::CArray<TLimitServerIDInfo, 10> WorldServerIDAry;		///< 世界服务ID列表  @TODO 暂时写死10个

/// 限制封号逻辑结构(内存）
typedef struct LimitAccountInfo
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	uint8				islimitAll;				///< 是否全服
	WorldServerIDAry	worldserverAry;			///< 服务器列表
	GXMISC::CGameTime	begintime;				///< 开始时间
	GXMISC::CGameTime	endtime;				///< 结束时间
	TServerOperatorId_t uniqueId;               ///< 唯一id

public:
	LimitAccountInfo()
	{
		cleanUp();
	}

	void cleanUp()
	{
		limitAccountID = INVALID_ACCOUNT_ID;
		limitRoleID    = INVALID_ROLE_UID;
		islimitAll     = 0;
		worldserverAry.clear();
		begintime      = GXMISC::INVALID_GAME_TIME;
		endtime        = GXMISC::INVALID_GAME_TIME;		
		uniqueId       = INVALID_SERVER_OPERTOR_ID;
	}
}TLimitAccountInfo;	
typedef std::vector<TLimitAccountInfo> TLimitAccountInfoVec;

///< 限制禁言逻辑结构（内存）
typedef struct LimitChatInfo
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	uint8				islimitAll;				///< 是否全服
	WorldServerIDAry	worldserverAry;			///< 服务器列表
	GXMISC::CGameTime	begintime;				///< 开始时间
	GXMISC::CGameTime	endtime;				///< 结束时间
	TServerOperatorId_t uniqueId;               ///< 唯一id

public:
	LimitChatInfo()
	{
		cleanUp();
	}

	void cleanUp()
	{
		limitAccountID = INVALID_ACCOUNT_ID;
		limitRoleID    = INVALID_ROLE_UID;
		islimitAll     = 0;
		worldserverAry.clear();
		begintime      = GXMISC::INVALID_GAME_TIME;
		endtime        = GXMISC::INVALID_GAME_TIME;	
		uniqueId       = INVALID_SERVER_OPERTOR_ID;
	}
}TLimitChatInfo;
typedef std::vector<TLimitChatInfo> TLimitChatInfoVec;

/// 封号信息结构(协议）
typedef struct LimitAccount
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	uint8				islimitAll;				///< 是否全服封号
	WorldServerIDAry	worldserverAry;			///< 服务器列表
	GXMISC::CGameTime	begintime;				///< 开始时间
	GXMISC::CGameTime	endtime;				///< 结束时间
	uint8				limitoperator;			///< 具体操作 (启用0, 删除1，更新2)
	TServerOperatorId_t uniqueId;               ///< 唯一id

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}

	LimitAccount()
	{
		clean();
	}
}TLimitAccount;

/// 禁言信息结构(协议）
typedef struct LimitChat
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	uint8				islimitAll;				///< 是否全服封号
	WorldServerIDAry	worldserverAry;			///< 服务器列表
	GXMISC::CGameTime	begintime;				///< 开始时间
	GXMISC::CGameTime	endtime;				///< 结束时间
	uint8				limitoperator;			///< 具体操作 (启用0, 删除1，更新2)
	TServerOperatorId_t uniqueId;               ///< 唯一id

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}

	LimitChat()
	{
		clean();
	}
}TLimitChat;

/// 数据库
/// 封号玩家信息(db)
typedef struct LimitAccountDB
{	
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	uint8				islimitAll;				///< 是否全服封号
	WorldServerIDAry	worldserverAry;			///< 服务器列表
	GXMISC::CGameTime	begintime;				///< 开始时间
	GXMISC::CGameTime	endtime;				///< 结束时间
	TServerOperatorId_t uniqueId;               ///< 唯一id

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}

	LimitAccountDB()
	{
		clean();
	}

}TLimitAccountDB;

typedef GXMISC::CArray<TLimitAccountDB, MAX_ROLE_NUM> TLimitAccountDBAry;

/// 禁言玩家信息(db)
typedef struct LimitChatDB
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	uint8				islimitAll;				///< 是否全服封号
	WorldServerIDAry    worldserverAry;			///< 服务器列表
	GXMISC::CGameTime	begintime;				///< 开始时间
	GXMISC::CGameTime	endtime;				///< 结束时间
	TServerOperatorId_t uniqueId;               ///< 唯一id

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}

	LimitChatDB()
	{
		clean();
	}

}TLimitChatDB;

typedef GXMISC::CArray<TLimitChatDB, MAX_ROLE_NUM> TLimitChatDBAry;

// @BEGNODOC
#pragma pack(pop)

#endif
// @ENDDOC