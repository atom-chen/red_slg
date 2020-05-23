// @BEGNODOC
#ifndef _GAME_BASE_UTIL_H_
#define _GAME_BASE_UTIL_H_

#include "core/types_def.h"
#include "core/base_util.h"
#include "core/bit_set.h"
#include "core/time/interval_timer.h"

#include "server_define.h"
#include "game_define.h"
#include "base_packet_def.h"
// @ENDDOC

///////////////////////////////////////////////////////////////////////// 不允许随意修改 /////////////////////////////////////////////////////////////////////////
typedef TCharArray2 _TUnUseCharAry;

typedef uint32	TRecordeServerID_t;				///< 记录服务器(日志及统计信息)		// @NODOC
static const TRecordeServerID_t INVALID_RECORDE_SERVER_ID = 0;

typedef uint16  TServerID_t;                  ///< 地图服务器ID						// @NODOC
static const TServerID_t INVALID_SERVER_ID = 0;

typedef uint16 TWorldServerID_t;                ///< 世界服务器ID					
static const TWorldServerID_t INVALID_WORLD_SERVER_ID = GXMISC::INVALID_UINT16_NUM;

typedef uint8 TPlatformID_t;					///< 平台ID							// @NODOC
static const TPlatformID_t INVALID_PLATFORM_ID = GXMISC::INVALID_UINT8_NUM;

typedef GXMISC::CFixString<MAX_PLAYER_ACCOUNT_LEN> TPlayerAccountName_t;	///< 玩家账号	// @NODOC
static const TPlayerAccountName_t INVALID_PLAYER_ACCOUNT_NAME = "";

typedef GXMISC::CFixString<MAX_PLAYER_PASSWORD_LEN> TPlayerPassword_t;		///< 玩家密码	// @NODOC
static const TPlayerPassword_t INVALID_PLAYER_PASSWORD = "";

typedef GXMISC::CFixString<MAX_PASSWORD_LEN> TPasswordStr_t;				///< 密码		// @NODOC
static const TPasswordStr_t INVALID_PASSWORD_STR = "";

typedef TCharArray2 TAccountName_t;											///< 账号名
static const TAccountName_t INVALID_ACCOUNT_NAME = "";

typedef TCharArray2 TAccountPassword_t;										///< 账号密码
static const TAccountPassword_t INVALID_ACCOUNT_PASSWORD = "";

typedef GXMISC::CFixString<MAX_IP_LEN>				TLimitKeyStr_t;			// 限制信息（可能是roleUID,也可能是IP地址）
static const TLimitKeyStr_t INVALID_LIMIT_KEY_STRING = "";					// 无效限制信息

typedef uint64 TAccountID_t;												///< 账号ID
static const TAccountID_t INVALID_ACCOUNT_ID = UINT64_CONSTANT(0xffffffffffffffff);

typedef TCharArray1 TSourceWayID_t;											///< 渠道ID
static const TSourceWayID_t INVALID_SOURCE_WAY_ID = "Unkown";

typedef uint64 TLoginKey_t;													///< 登陆Key
static const TLoginKey_t INVALID_LOGIN_KEY = UINT64_CONSTANT(0);

static const std::string INVALID_STRING = "";								///< 无效的字符串

typedef sint32 TBlockID_t;													///< 块ID				// @NODOC
static const TBlockID_t INVALID_BLOCK_ID = GXMISC::MAX_SINT32_NUM;

typedef sint32 TAreaID_t;													///< 事件区ID			// @NODOC
static const TAreaID_t INVALID_AREA_ID = GXMISC::MAX_SINT32_NUM;

typedef sint32 TScriptID_t;													///< 脚本ID				// @NODOC
static const TScriptID_t INVALID_SCRIPT_ID = GXMISC::MAX_SINT32_NUM;

typedef uint16 TMapID_t;													///< 地图ID
static const TMapID_t INVALID_MAP_ID = 0;
typedef std::vector<TMapID_t> TMapIDList;									///< 地图ID列表			// @NODOC
typedef uint64 TUMapID_t;													///< 地图唯一位置,包括地图ID和坐标
static const TUMapID_t INVALID_UMAP_ID = GXMISC::INVALID_UINT64_NUM;

typedef uint64 TSceneID_t;													///< 场景ID
static const TSceneID_t INVALID_SCENE_ID = GXMISC::MAX_UINT64_NUM;
typedef uint32 TCopyID_t;													///< 副本ID				// @NODOC
static const TCopyID_t INVALID_COPY_ID = GXMISC::MAX_UINT32_NUM;

typedef uint64 TRoleUID_t;													///< 角色UID
static const TRoleUID_t INVALID_ROLE_UID = 0;
static const TRoleUID_t SYSTEM_ROLE_UID = 1;								///< 系统对象		// @NODOC
static const TRoleUID_t GEN_INIT_ROLE_UID = 1000;

typedef uint8 TRoleProtypeID_t;												///< 角色原型ID
static const TRoleProtypeID_t INVALID_ROLE_PROTYPE_ID = 0;

typedef uint64 TObjGUID_t;													///< 对象的唯一ID 在所有区都是唯一		// @NODOC
static const TObjGUID_t INVALID_OBJ_GUID = GXMISC::INVALID_UINT64_NUM;

typedef uint32 TObjUID_t;													///< 对象的UID, 在同一场景中所有的对象的UID都是不相同的
static const TObjUID_t INVALID_OBJ_UID = GXMISC::INVALID_UINT32_NUM;
static const TObjUID_t SYSTEM_OBJ_UID = 1;									///< 系统对象(1-999)
static const TObjUID_t TEMP_ROLE_INIT_UID = 1000u;							///< 角色初始化UID 1~1亿
static const TObjUID_t INVALID_TEMP_ROLE_UID = 100000000u;					///< 角色最大UID 
static const TObjUID_t TEMP_PET_INIT_UID = INVALID_TEMP_ROLE_UID + 1;													// 宠物UID
static const TObjUID_t INVALID_TEMP_PET_UID = 500000000u;																// 宠物最大UID

//////////////////////// 临时UID
static const TObjUID_t TEMP_NPC_INIT_UID = INVALID_TEMP_PET_UID + 1;													// NPC初始化UID
static const TObjUID_t INVALID_TEMP_NPC_UID = 600000000u;																// NPC初始化UID
// 所有场景共用的UID
// 增长量比较大的UID(每个10亿)
static const TObjUID_t TEMP_MOSTER_INIT_UID = (2000000001u);															// 怪物初始化UID 
static const TObjUID_t INVALID_TEMP_MONSTER_UID = (3000000000u);														// 怪物最大UID
// 不会在场景中出现的UID
static const TObjUID_t TEMP_ITEM_INIT_UID = 1;																			// 物品初始化UID
static const TObjUID_t INVALID_TEMP_ITEM_UID = GXMISC::MAX_UINT32_NUM;													// 物品最大UID
//////////////////////// 临时UID
///////////////////////////////////////////////////////////////////////// 不允许随意修改 /////////////////////////////////////////////////////////////////////////

typedef sint32 TSceneGroupID_t;												///< 场景内分组ID
static const TSceneGroupID_t INVALID_SCENE_GROUP_ID = GXMISC::INVALID_SINT32_NUM;

typedef uint8 TObjType_t;													///< 对象类型
static const TObjType_t INVALID_OBJ = (TObjType_t)INVALID_OBJ_TYPE;

typedef CCharArray1<50> TRoleName_t;										///< 角色名字	// @NODOC
static const TRoleName_t INVALID_ROLE_NAME;

typedef uint8 TLevel_t;														///< 游戏等级
static const TLevel_t INVALID_LEVEL = 0;

typedef uint8 TVipLevel_t;													///< VIP等级
static const TVipLevel_t INVALID_VIP_LEVEL = GXMISC::MAX_UINT8_NUM;

typedef uint8 TStar_t;														///< 星级
static const TStar_t INVALID_STAR = 0;

typedef uint8 TJob_t;														///< 职业类型
static const TJob_t INVALID_JOB = INVALID_JOB_TYPE;

typedef uint8 TSex_t;														///< 性别
static const TSex_t INVALID_SEX = INVALID_SEX_TYPE;

typedef sint16 TAxisPos_t;													///< 地图坐标轴
static const TAxisPos_t INVALID_AXIS_POS = GXMISC::INVALID_SINT16_NUM;

typedef GXMISC::CFixString<GUILD_NAME_LEN> TGuildName_t;					///< 帮派名字	// @NODOC
static const TGuildName_t INVALID_GUILD_NAME;

typedef uint16 TTeamIndex_t;												///< 队伍ID
static const TTeamIndex_t INVALID_TEAM_ID = GXMISC::INVALID_UINT16_NUM;

typedef uint8 TDir_t;														///< 方向
static const TDir_t INVALID_DIR = DIR_INVALID;

typedef uint16 TNPCTypeID_t;												///< NPC类型ID
static const TNPCTypeID_t INVALID_NPC_TYPE_ID = 0;

typedef uint16 TTransportTypeID_t;											///< 传送点类型ID
static const TTransportTypeID_t INVALID_TRANSPORT_TYPE_ID = 0;

typedef uint16 TMonsterTypeID_t;											///< 怪物类型ID
static const TMonsterTypeID_t INVALID_MONSTER_TYPE_ID = 0;

typedef uint16 TMonsterDistributeID_t;										///< 怪物分布点ID
static const TMonsterDistributeID_t INVALID_MONSTER_DISTRIBUTE_ID = 0;

typedef sint8 TAttrType_t;													///< 属性索引
static const TAttrType_t INVALID_ATTR_INDEX = GXMISC::MAX_SINT8_NUM;
typedef CArray1<TAttrType_t> TAttrTypeAry;
typedef sint32 TAttrVal_t;													///< 属性值
static const TAttrVal_t INVALID_ATTR_VAL = 0;
typedef uint8 TValueType_t;													///< 数值类型
static const TValueType_t INVALID_VALUE_TYPE = 0;
typedef GXMISC::CArray<TAttrVal_t, 1024> TAttrValAry;

typedef GXMISC::TBit16_t TObjState_t;										///< 角色身上状态标记位
static const TObjState_t INVALID_OBJ_STATE = 0;
typedef GXMISC::TBit16_t TObjActionBan_t;									///< 角色身上的行为禁止标记
static const TObjActionBan_t INVALID_OBJ_ACTION_BAN = 0;

typedef sint32 TCooldownID_t;												///< 冷却ID
static const TCooldownID_t INVALID_COOL_DOWN_ID = GXMISC::MAX_SINT32_NUM;

typedef sint32 THateValue_t;                                                ///< 仇恨值
static const THateValue_t INVALID_HATE_VALUE = -1;

typedef uint16 TBufferTypeID_t;												///< Buffer类型ID
static const TBufferTypeID_t INVALID_BUFFER_TYPE_ID = 0;

typedef std::list<TObjUID_t> TObjUIDList;									///< 对象UID列表

#endif	// @NODOC