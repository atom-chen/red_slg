// @BEGNODOC
#ifndef _PACKET_STRUCT_H_
#define _PACKET_STRUCT_H_

#include "core/base_util.h"

#include "game_util.h"
#include "server_define.h"
#include "streamable_util.h"
#include "game_time.h"

#pragma pack(push, 1)
// @ENDDOC

/// Buffer效果
typedef struct _PackBuffer
{
	TObjUID_t objUID;						///< 对象UID
	TBufferTypeID_t bufferTypeID;			///< Buffer类型ID
	TLevel_t level;							///< Buff等级
	uint32 timeElapsed;						///< 已经持续的时间
	uint32 param;							///< 参数(血/蓝球表示当前总容量)
}TPackBuffer;
typedef struct _PackSimpleBuff
{
	TObjUID_t objUID;						///< 对象UID
	TBufferTypeID_t bufferTypeID;			///< Buffer类型ID
}TPackSimpleBuff;
typedef CArray1<TPackSimpleBuff, MAX_SEND_BUFFER_NUM> TPackBufferAry;

/// 角色列表结构
typedef struct PackLoginRole
{
	// @member
public:
	TRoleName_t name;
	TRoleUID_t uid;
	TSex_t sex;
	TJob_t job;
	TLevel_t level;
	GXMISC::TGameTime_t createTime;
	GXMISC::TGameTime_t logoutTime;

public:
	PackLoginRole()
	{
		memset(this, 0, sizeof(*this));
		uid = INVALID_ROLE_UID;
		sex = INVALID_SEX_TYPE;
		job = INVALID_JOB_TYPE;
		level = INVALID_LEVEL;
		createTime = GXMISC::INVALID_GAME_TIME;
		logoutTime = GXMISC::INVALID_GAME_TIME;
	}

	void setParam(const char* name, TRoleUID_t uid, uint8 sex, uint8 job, TLevel_t level,
		GXMISC::TGameTime_t createTime, GXMISC::TGameTime_t logoutTime)
	{
		this->name = name;
		this->uid = uid;
		this->sex = sex;
		this->job = job;
		this->level = level;
		this->createTime = createTime;
		this->logoutTime = logoutTime;
	}

	const std::string toString()
	{
		return GXMISC::gxToString("name = %s, uid = %" I64_FMT "u, sex = %u, job = %u, level = %u, create_time = %u", 
			name.toString().c_str(), uid, sex, job, level, createTime);
	}

}TPackLoginRole;
typedef CArray1<TPackLoginRole, MAX_ROLE_NUM> TPackLoginRoleArray;
typedef std::vector<TPackLoginRole> TPackLoginRoleVector;
//typedef CArray1<TPackLoginRole, MAX_ROLE_NUM> TPackLoginRoleList;

/// 角色外观数据
typedef struct PackRoleShape : public GXMISC::IStreamableAll
{
public:
	enum
	{
		ObjectType = OBJ_TYPE_ROLE,
	};

	// @member
public:
	TObjUID_t			objUID;                 ///< 对象UID
	TRoleProtypeID_t	protypeID;				///< 原型ID
	TRoleName_t			name;					///< 姓名
	TLevel_t			level;                  ///< 等级
	TAxisPos_t			xPos;					///< X位置
	TAxisPos_t			yPos;					///< Y位置
	TDir_t				dir;                    ///< 方向
	TMoveSpeed_t		moveSpeed;              ///< 移动速度
	TPetTypeID_t		petShapeID;				///< 宠物外观ID

public:
	DSTREAMABLE_IMPL1(name);

}TPackRoleShape;

// 怪物外观
typedef struct PackMonsterShape
{
	enum
	{
		ObjectType = OBJ_TYPE_MONSTER,
	};

	TObjUID_t	        objUID;             // 对象UID
	TMonsterTypeID_t	typeID;             // 怪物类型ID
	THp_t	            curHp;              // 当前血量
	TMp_t	            curMp;              // 当前能量
	TAxisPos_t	        xPos;               // X位置
	TAxisPos_t	        yPos;               // Y位置
	TDir_t	            dir;                // 方向
	TObjActionBan_t	    actionBan;          // 行为禁止状态(@ref EActionBan)
	TMoveSpeed_t        moveSpeed;          // 移动速度
	//	TObjUID_t           owner;              // 拥有者ID
	//	TCampID_t			campID;				// 阵营ID

	sint32 getShapeLen()
	{
		return sizeof(*this);
	}
}TPackMonsterShape;

/// 查找所的新注册(新角色)渠道
typedef struct PacketSourceWay
{
	//GXMISC::CGameTime		datetime;			///< 创建时间
	TSourceWayID_t					source_way;			///< 登录渠道
	TSourceWayID_t					chisource_way;		///< 子登录渠道

	PacketSourceWay()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}

}TPacketSourceWay;
//typedef CArray2<_PacketSourceWay, 150> TPacketSourceWayAry;	/// 渠道列表(用于角色记录)
typedef std::vector<TPacketSourceWay> TPacketSourceWayVec;

/// 注册(新角色数量)
typedef struct PacketNewRegister
{
	uint32							registernum;		///< 注册数量(目前帐号只可以有一个角色)
	uint32							newrolenum;			///< 新角色数量
	TSourceWayID_t						pf;					///< 登录渠道
	TSourceWayID_t						pd;					///< 子登录渠道

	PacketNewRegister()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}

}TPacketNewRegister;
typedef CArray2<PacketNewRegister, 5000> TPacketNewRegisterAry;	/// 新帐号注册列表(角色)

/// 登录次数
typedef struct PacketLoginTime
{
	uint32							onlinenum;			///< 在线人数
	TSourceWayID_t					pf;					///< 登录渠道
	TSourceWayID_t					pd;					///< 子登录渠道

	PacketLoginTime()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}

}TPacketLoginTime;
typedef std::vector<PacketLoginTime> TPacketLoginTimeVec;	/// 登录渠道记录列表(角色)

/// 单服游戏概况
typedef struct PacketSingletonInfo
{
	uint32							loginplayernum;		///< 今日登录次数(不同玩家)
	uint32							registernum;		///< 注册数量(目前帐号只可以有一个角色)
	uint32							newrolenum;			///< 新角色数量
	uint32							male_num_lvl1;		///< 1级男角色数量
	uint32							feminie_num_lvl1;	///< 1级女角色数量
	uint32							male_num_lvl30;		///< 30级角色数量
	uint32							feminie_num_lvl30;	///< 30级女角色数量

	PacketSingletonInfo()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}
}TPacketSingletonInfo;

/// 游戏数据汇总
typedef struct PacketGameCollectInfo
{
	uint32							daytime;			///< 时间Ymd
	uint32							datetime;			///< 时间戳
	uint32							allacount_num;		///< 总帐号数
	uint32							allrole_num;		///< 总角色数
	uint32							newaccount_num;		///< 新帐号数
	uint32							newrole_num;		///< 新角色数
	uint32							login_num;			///< 登录数
	uint32							paytotal;			///< 总充值数
	uint32							consume;			///< 当天充值
	uint32							totalwaste;			///< 总消耗（钻石）
	uint32							curallwasteyb;		///< 当天消耗（钻石）
	uint32							allstockyb;			///< 钻石总库存
	uint32							curstockyb;			///< 当天库存钻石
	TServerID_t						serverid;			///< 服务器ID
	TSourceWayID_t					source_way;			///< 登录渠道
	TSourceWayID_t					chisource_way;		///< 子登录渠道

	PacketGameCollectInfo()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}
}TPacketGameCollectInfo;
typedef CArray2<PacketGameCollectInfo, 250> TPacketGameCollectInfoAry;	/// 游戏数据汇总列表
typedef std::vector<PacketGameCollectInfo> TPacketGameCollectInfoVec;


// 玩家创建角色前的记录
typedef struct PacketCreateBrforeInfo
{
	GXMISC::CGameTime	datetime;		///< 操作时间
	TAccountID_t		accountid;		///< 账号ID
	TCharArray2			clientmac;		///< 客户端mac地址

}TPacketCreateBrforeInfo;
typedef CArray2<PacketCreateBrforeInfo, 5000> TPacketCreateBrfroeInfoAry;	/// 玩家创建角色前的记录列表

// @BEGNODOC
#pragma pack(pop)

#endif	// _PACKET_STRUCT_H_
// @ENDDOC