// @BEGNODOC
#ifndef _GAME_DEFINE_H_
#define _GAME_DEFINE_H_

#include "core/string_common.h"
#include "item_define.h"
#include "constant_define.h"

/**
服务器启动流程
1. 连接管理服务器拿到启动相关的Key, 管理服务器检测是否有相同的服务启动了
2. 连接数据库加载基本数据
3. 启动成功注册到管理服务器, 失败则管理服务器通知退出
*/
// @ENDDOC
// @BEGNODOC
/// 服务器类型
enum EServerType
{
	INVALID_SERVER_TYPE = 0,				///< 无效
	SERVER_TYPE_WORLD = 1,					///< 世界服务器
	SERVER_TYPE_MAP_NORMAL = 2,				///< 普通场景服务器
	SERVER_TYPE_MAP_DYNAMIC = 3,			///< 动态场景服务器(副本或战场)
	SERVER_TYPE_MANAGER = 4,				///< 管理服务器
	SERVER_TYPE_RECORD = 5,					///< 记录服务器
	SERVER_TYPE_RESOURCE = 6,				///< 资源服务器
	SERVER_TYPE_CHARGE = 7,					///< 充值服务器
	SERVER_TYPE_LOGIN = 8,					///< 服务器类型
	SERVER_TYPE_NUM = 9,					///< 服务器类型数目
};

/// 服务器状态
enum EServerStatus
{
	INVALID_SERVER_STATUS = 0,			///< 无效的状态
	NORMAL_SERVER_STATUS,				///< 正常状态
	READY_CLOSE_SERVER_STATUS,			///< 准备关服（已发送关服命令）
	URGENT_CLOSE_SERVER_STATUS,			///< 紧急关服
	KICK_ROLE_SERVER_SATATUS,			///< 踢掉所有在线玩家并开始保存数据
	REAL_CLOSE_SERVER_STATUS,			///< 真正开始结束服务器运行
};

/// 场景类型
enum ESceneType
{
	SCENE_TYPE_INVALID = 0,				///< 无效
	SCENE_TYPE_NORMAL = 1,				///< 普通场景
	SCENE_TYPE_PK_RISK = 2,				///< 单人PK副本
	SCENE_TYPE_RISK = 3,				///< 副本场景

	SCENE_TYPE_NUMBER,					///< 场景类型总数
};
DToStringDef(ESceneType);

/// 加载角色数据类型
enum ELoadRoleType
{
	LOAD_ROLE_TYPE_INVALID,				///< 无效类型
	LOAD_ROLE_TYPE_LOGIN,				///< 登陆
	LOAD_ROLE_TYPE_CHANGE_LINE,			///< 切线
	LOAD_ROLE_TYPE_CHANGE_MAP,			///< 切场景
	LOAD_ROLE_TYPE_TELE,				///< 传送
};
DToStringDef(ELoadRoleType);

/// 释放角色数据类型
enum EUnloadRoleType
{
	UNLOAD_ROLE_TYPE_INVALID,			///< 无效类型
	UNLOAD_ROLE_TYPE_ERROR,             ///< 严重出错
	UNLOAD_ROLE_TYPE_QUIT,				///< 退出
	UNLOAD_ROLE_TYPE_KICK_BY_OTHER,		///< 被其他玩家挤下线
	UNLOAD_ROLE_TYPE_CHANGE_LINE,		///< 切线
	UNLOAD_ROLE_TYPE_SYS_CHECK,         ///< 系统通知下线
	UNLOAD_ROLE_TYPE_GM,				///< 系统封号
};
DToStringDef(EUnloadRoleType);

/// 角色状态
enum ERoleStatus
{
	ROLE_STATUS_INVALID,				///< 无效状态
	ROLE_STATUS_LOAD,					///< 数据加载成功状态
	ROLE_STATUS_ENTER,					///< 进入游戏状态
	ROLE_STATUS_ENTER_SCENE,			///< 进入场景状态
	ROLE_STATUS_CHANGE_MAP,				///< 切换场景状态
	ROLE_STATUS_SAVE,					///< 保存数据状态
	ROEL_STATUS_KICK_BY_OTHER,			///< 被其他挤下线
	ROLE_STATUS_QUIT_REQ,				///< 退出游戏请求状态
	ROLE_STATUS_QUTI,					///< 退出状态
};
DToStringDef(ERoleStatus);

/// 保存角色数据类型
enum ESaveRoleType
{
	SAVE_ROLE_TYPE_DIFF,				///< 差异更新
	SAVE_ROLE_TYPE_TIMER,				///< 定时保存
	SAVE_ROEL_TYPE_OFFLINE,				///< 下线
	SAVE_ROLE_TYPE_RECHARGE,			///< 充值
	SAVE_ROLE_TYPE_SEND_RMB,			///< 返还元宝
};
DToStringDef(ESaveRoleType);

/**
* 账号状态分类:
*           1. 空状态                  0,1
*           2. 请求状态                3,4,5,8,9,11
*           3. 登陆状态                0,1,2
*           4. 角色数据需要释放状态    6,7,10
*           5. 角色数据已经释放状态    0,1,2,12
*           6. 请求释放角色数据状态    8,11
*           7. 请求加载角色数据状态    5,9
*           8. 切线状态                8,9,10
*/
enum EPlayerStatus
{
	PS_INVALID = 0,				///< 无效状态
	PS_IDLE,					///< 空状态

	// 登陆模块
	PS_VERIFY_PASS,				///< 验证通过状态
	PS_CREATE_ROLE_REQ,			///< 创建角色请求状态
	PS_DELETE_ROLE_REQ,			///< 删除角色请求状态

	// 选择角色登陆
	PS_LOGIN_GAME_REQ,			///< 登陆游戏请求状态, WorldServer请求MapServer加载数据
	PS_LOGIN_GAME,				///< 登陆游戏成功状态(MapServer已经将角色数据发送过来)

	// 游戏模块(角色登陆成功, 正式进入游戏状态)
	PS_PLAYING_GAME,			///< 游戏状态(Client通知WorldServer退出登陆或者切线成功)
	PS_CHANGE_LINE_UNLOAD_REQ,	///< 切线释放数据状态(MapServer请求换线, WorldServer判断可以换线, WorldServer请求MapServer将数据释放)
	PS_CHANGE_LINE_LOAD_REQ,	///< 切线加载数据状态(源MapServer数据已经释放, World请求目标MapServer加载角色数据, 数据加载成功后会转入切线等待状态)
	PS_CHANGE_LINE_WAIT,		///< 切线等待状态(目标服务器数据已经加载成功, 并且返回给客户端切线成功, 等待客户端登陆目标服务器并且等目标服务器返回切换成功响应)

	// 退出游戏
	PS_QUIT_REQ,				///< 请求退出状态(WorldServer请求MapServer将数据释放)
	PS_QUIT,					///< 退出状态(数据已经释放)
};
DToStringDef(EPlayerStatus);

/// 玩家在世界服务器的操作 
enum EWPlayerActionType
{
	PA_VERIFY,					///< 验证账号请求		C-W
	PA_DELETE_ROEL_REQ,			///< 删除角色请求		C-W
	PA_CREATE_ROLE_REQ,			///< 创建角色请求		C-W
	PA_LOGIN_GAME_REQ,			///< 进入游戏请求		C-W
	PA_LOGIN_QUIT_REQ,			///< 退出游戏登陆请求	C-W
	PA_UNLOAD_ROLE_REQ,			///< 释放角色数据请求	W-M
	PA_CHANGE_LINE_REQ,			///< 换线请求			M-W
	PA_QUIT_GAME_REQ,			///< 退出游戏请求		M-W

	// 响应
	PA_CREATE_ROLE_RES,			///< 创建角色响应		W-C
	PA_DELETE_ROLE_RES,			///< 删除角色响应		W-C
	PA_LOAD_ROLE_RES,			///< 加载角色数据响应	M-W
	PA_UNLOAD_ROLE_RES,			///< 释放角色数据响应	M-W
};
DToStringDef(EWPlayerActionType);

// @todo 将类型处理好, 当前大部分用TELEPORT_TYPE_SYS临时代替

/// 传送类型
enum ETeleportType
{
	TELEPORT_TYPE_INVALID = 0,			///< 无效类型

	TELEPORT_TYPE_TRANSMIT = 1,			///< 传送点
	TELEPORT_TYPE_SYS = 2,				///< 系统传送
	TELEPORT_TYPE_RISK_ENTER = 3,		///< 动态场景进入
	TELEPORT_TYPE_RISK_QUIT = 4,		///< 动态场景退出
	TELEPORT_TYPE_CHANGE_LINE = 5,		///< 切线
};
DToStringDef(ETeleportType);

/// 成年信息
enum EAdultFlag
{
	ADULT_FLAG_NONE = 0,			///< 未填写实名信息
	ADULT_FLAG_ADULT = 1,			///< 成年
	ADULT_FLAG_NO_ADULT = 2,		///< 未成年
};
DToStringDef(EAdultFlag);

// @ENDDOC

/// 职业
enum EJobType
{
	INVALID_JOB_TYPE = -1,			///< 无效职业
	JOB_TYPE_PHYSIC = 0,			///< 物理
	JOB_TYPE_MAGIC = 1,				///< 魔法
	JOB_TYPE_MONSTER = 4,			///< 怪物
	JOB_TYPE_PET = 5,				///< 宠物
	JOB_TYPE_NPC = 6,				///< NPC
};
DToStringDef(EJobType);				// @NODOC

/// @brief 性别
enum ESexType
{
	INVALID_SEX_TYPE = 0,           ///< 无效性别
	SEX_TYPE_MALE = 1,              ///< 男
	SEX_TYPE_FEMALE = 2,            ///< 女
};
DToStringDef(ESexType);				// @NODOC

/// 踢掉玩家
enum EKickType
{
	KICK_TYPE_ERR = 1,					///< 您的网络不佳，请重新登陆
	KICK_TYPE_BY_OTHER = 2,				///< 您的账号已经在其他地方登陆
	KICK_TYPE_BY_GM = 3,				///< 您已被系统禁止登陆，请联系客服
	KICK_TYPE_GAME_STOP = 4,			///< 服务器停机维护，请稍后重新登陆
};
DToStringDef(EKickType);

/// 聊天频道
enum EChatChannel
{
	CHANNEL_INVALID         = 0,  ///< 非法频道
	CHAT_CHANNEL_WORLD      = 1,  ///< 世界频道
	CHAT_CHANNEL_FACTION    = 2,  ///< 帮派频道
	CHAT_CHANNEL_PRIVATE    = 3,  ///< 私聊频道
	CHAT_CHANNEL_SYSTEM     = 4,  ///< 系统频道
	CHAT_CHANNEL_GM         = 5,  ///< GM频道

	CHAT_CHANNEL_NUMBER = 6     ,        ///< 最大的数目	// @NODOC
};
DToStringDef(EChatChannel);				// @NODOC

/// 方向
enum EDir
{
	DIR_INVALID = 0,	///< 无效的
	DIR_0 = 0,          ///< 北, 其余按顺时针递增
	DIR_1,				///< 东北
	DIR_2,				///< 东
	DIR_3,				///< 东南
	DIR_4,				///< 南
	DIR_5,				///< 西南
	DIR_6,				///< 西
	DIR_7				///< 西北
};
DToStringDef(EDir);				// @NODOC

/// @brief 方向
enum EDir2
{
	DIR2_INVALID = 0,		///< 无效值
	DIR2_LEFT = 1,			///< 左
	DIR2_RIGHT = 2,			///< 右
};

/// 对象类型
enum EObjType
{
	// 客户端服务器公用
	INVALID_OBJ_TYPE = 0,           ///< 无效类型
	OBJ_TYPE_ROLE = 1,              ///< 角色
	OBJ_TYPE_NPC = 2,				///< NPC
	OBJ_TYPE_MONSTER = 3,			///< 怪物

	// 服务器内部使用	 @NODOC
	OBJ_TYPE_PET = 22,				///< 宠物	@NODOC
	OBJ_TYPE_ITEM = 23,				///< 物品	@NODOC
	OBJ_TYPE_HORSE = 24,            ///< 坐骑	@NODOC
};
DToStringDef(EObjType);				// @NODOC

/// 属性枚举值定义
enum EAttributes
{
	// 用于策划填写的编号1-49
	ATTR_FIGHT_INVALID		= 0,					///< 无效
	ATTR_MAX_HP				= 1,					///< 最大生命	
	ATTR_CUR_HP				= 2,					///< 当前生命
	ATTR_MAX_ENERGY			= 3,					///< 最大能量
	ATTR_CUR_ENERGY			= 4,					///< 当前能量
	ATTR_POWER				= 5,					///< 力量
	ATTR_AGILITY			= 6,					///< 敏捷
	ATTR_WISDOM				= 7,					///< 智力
	ATTR_STRENGTH			= 9,					///< 体力

	ATTR_ATTACK				= 10,					///< 攻击力
	ATTR_SKILL_ATTACK		= 11,					///< 技能攻击力
	ATTR_DAMAGE				= 12,					///< 额外伤害
	ATTR_DEFENSE			= 13,					///< 防御力
	ATTR_DAMAGE_REDUCE		= 14,					///< 伤害减免
	ATTR_MOVE_SPEED			= 15,					///< 移动速度
	ATTR_CRIT				= 16,					///< 暴击值
	ATTR_DODGE				= 17,					///< 闪避

	ATTR_ATTACK_RANGE		= 20,					///< 攻击距离
	ATTR_ATTACK_SPEED		= 21,					///< 攻击速度

	ATTR_EXP				= 22,					///< 经验
	ATTR_MONEY				= 23,					///< 金钱
	ATTR_RMB				= 24,					///< 元宝

	ATTR_CHAR_CURR_MAX		= 49,					///< 策划可配置的最大属性

	// 50-MAX
	ATTR_LEVEL				= 50,					///< 等级
	ATTR_VIP_LEVEL          = 56,                   ///< vip等级
	ATTR_VIP_EXP            = 57,                   ///< vip经验	
	ATTR_MAX_EXP			= 62,					///< 经验最大值

	//以下是目前没用到的
//	ATTR_PHYSIC_ATTACK = 2,							///< 物理攻击
//	ATTR_PHYSIC_DEFENSE = 4,						///< 物理防御
//	ATTR_MAGIC_ATTACK = 19,							///< 魔法攻击
//	ATTR_MAGIC_DEFENSE = 20,						///< 魔法防御
//	ATTR_HP = 21,									///< 血量
};
DToStringDef(EAttributes);							// @NODOC

/// 行为禁止定义, 按位存储
enum EActionBan
{
	ACTION_BAN_LIVE = 0,						///< 是否还活着
	ACTION_BAN_MOVE,							///< 禁止移动
	ACTION_BAN_UNBE_ATTACK,						///< 禁止被攻击
	ACTION_BAN_ATTACK,							///< 禁止攻击
	ACTION_BAN_USE_ITEM,						///< 禁止使用物品

	ACTION_BAN_MAX,								///< 最大数目
};

/// 数值类型(统一使用)
enum ENumericalType
{
	NUMERICAL_TYPE_INVALID	= 0,				///< 无效值
	NUMERICAL_TYPE_VALUE	= 1,				///< 数值
	NUMERICAL_TYPE_ODDS		= 2,				///< 机率(百分比)
};

/// 技能类型
enum ESkillType
{
	SKILL_TYPE_INVALID,         ///< 无效
	SKILL_TYPE_ACTIVE,          ///< 主动
	SKILL_TYPE_PASSIVE,         ///< 被动
	SKILL_TYPE_ASSIST,          ///< 辅助
	SKILL_TYPE_MAX,
};

/// 技能攻击类型
enum ESkillAttackType
{
	SKILL_ATTACK_TYPE_INVALID,  ///< 无效
	SKILL_ATTACK_TYPE_SINGLE,   ///< 单体
	SKILL_ATTACK_TYPE_GROUP,    ///< 群体
	SKILL_ATTACK_TYPE_MAX,
};

/// 目标类型
enum ESkillTargetType
{
	SKILL_TARGET_TYPE_INVALID,      ///< 无效
	SKILL_TARGET_TYPE_ENEMY,        ///< 敌人
	SKILL_TARGET_TYPE_OWN,          ///< 自身
	SKILL_TARGET_TYPE_TEAM,         ///< 队伍
	SKILL_TARGET_TYPE_MAX,
};

/// Buff事件
enum EBuffEventFlag
{
	BUFF_EVENT_FLAG_DIE = 1,					///< 死亡
	BUFF_EVENT_FLAG_HURT,						///< 受伤
	BUFF_EVENT_FLAG_MP_DES,						///< MP减少
	BUFF_EVENT_FLAG_FORCE_HATE,					///< 吸收仇恨
	BUFF_EVENT_FLAG_REFLECT,					///< 反弹
	BUFF_EVENT_FLAG_SLEEP,						///< 睡眠
	BUFF_EVENT_FLAG_STOP,						///< 定身
	BUFF_EVENT_FLAG_DIZZ,						///< 眩晕

	BUFF_EVENT_FLAG_NUM,						///< 最大数目
};
DToStringDef(EBuffEventFlag);

/// Buffer效果类型
enum EBuffEffectType
{
	BUFF_EFFECT_TYPE_INVALID,
	BUFF_EFFECT_TYPE_ADD_HPMP = 1,				///< 添加HP和MP的
	BUFF_EFFECT_TYPE_ADD_EXTRA_ATTR,			///< 添加其他属性
	BUFF_EFFECT_TYPE_ADD_EXP,					///< 经验卡

	MAX_BUFF_EFFECT_TYPE_NUM,					///< 最大数目
};

/// Buffer类型
enum EBuffType
{
	INVALID_BUFF_TYPE = 0,						///< 无效
	BUFF_TYPE_SKILL,							///< 技能
	BUFF_TYPE_ITEM,								///< 物品
	BUFF_TYPE_PASSIVE_SKILL,					///< 被动技能
};
DToStringDef(EBuffType);

/// Buffer共存关系
enum EBuffExistType
{
	BUFF_EXIST_TYPE_INVALID = 0,				///< 无效
	BUFF_EXIST_TYPE_EXIST = 1,					///< 共存
	BUFF_EXIST_TYPE_REPLACE = 2,				///< 覆盖
	BUFF_EXIST_TYPE_OVERLIING = 1,				///< 叠加
	BUFF_EXIST_TYPE_IGNORE = 3,					///< 不生效
};
DToStringDef(EBuffExistType);

/// Buffer持续类型
enum EBuffLastType
{
	BUFF_LAST_TYPE_INVALID = 0,					///< 无效
	BUFF_LAST_TYPE_ABSOLUTE = 1,				///< 绝对
	BUFF_LAST_TYPE_OPPOSITE = 2,				///< 相对
	BUFF_LAST_TYPE_PERMANENT = 3,				///< 永久
	BUFF_LAST_TYPE_COUNT = 4,					///< 计数
};
DToStringDef(EBuffLastType);

/// 攻击效果类型(共16种类型)
enum EAttackImpactType
{
	INVALID_ATTACK_IMPACT_TYPE = 0,             ///< 无效类型
	ATTACK_IMPACT_TYPE_NORMAL = 1,              ///< 正常攻击
	ATTACK_IMPACT_TYPE_CRIT = 2,                ///< 暴击
	ATTACK_IMPACT_TYPE_DODGE = 3,               ///< 闪避
	ATTACK_IMPACT_TYPE_HIT_DOUBLE = 4,          ///< 连击

	// 服务器内部使用
	ATTACK_IMPACT_TYPE_CONFUSION = 5,           ///< 混乱
	ATTACK_IMPACT_TYPE_RAND_ATTACK_ROLE = 6,    ///< 乱杀
};
DToStringDef(EAttackImpactType);

/// 任务事件类型
enum EMissionEvent
{
	MISSION_EVENT_INVALID = 0,					///< 无效
	MISSION_EVENT_DIALOG = 1,					///< 对话
	MISSION_EVENT_GUANQIA = 2,					///< 闯关
	MISSION_EVENT_KILL_MONSTER = 3,				///< 杀怪
	MISSION_EVENT_COLLECT_ITEM = 4,				///< 物品
};
DToStringDef(EMissionEvent);

/// 任务状态
enum EMissionStatus
{
	MISSION_STATUS_INVALID = 0,					///< 无效
	MISSION_STATUS_ACCEPTING = 1,				///< 待接取
	MISSION_STATUS_ACCEPTED = 2,				///< 可接取
	MISSION_STATUS_EXECUTED = 3,				///< 已接取
	MISSION_STATUS_FINISHED = 4,				///< 已完成
};
DToStringDef(EMissionStatus);

/// 任务操作
enum EMissionOperation
{
	MISSION_OPERATION_INVALID = 0,				///< 无效
	MISSION_OPERATION_ACCEPT = 1,				///< 接受任务
	MISSION_OPERATION_SUBMIT = 2,				///< 提交任务
};

/// 任务类型
enum EMissionType
{
	MISSION_TYPE_INVALID = 0,					///< 无效
	MISSION_TYPE_MAJOR = 1,						///< 主线
	MISSION_TYPE_CURR_MAX = 2,					///< 最大数目
};

/// 查找空坐标类型
enum EFindEmptyPosType
{
	FIND_EMPTY_POS_TYPE_LEFT,					///< 左
	FIND_EMPTY_POS_TYPE_MID,					///< 中(先搜中间再搜两边)
	FIND_EMPTY_POS_TYPE_MID_LEFT,				///< 中左
	FIND_EMPTY_POS_TYPE_MID_RIGHT,				///< 中右
	FIND_EMPTY_POS_TYPE_RIGHT,					///< 右
};
DToStringDef(EFindEmptyPosType);

/// 角色限号类型
enum ERoleLimitType
{
	ROLE_LIMIT_INVALID = 0,							///< 无效的封号操作
	ROLE_LIMIT_LOGIN = 1,							///< 禁止登陆
	ROLE_LIMIT_CHAT = 2,							///< 禁止聊天
	ROLE_LIMIT_DEL_LOGIN = 3,						///< 解除封号
	ROLE_LIMIT_DEL_CHAT = 4,						///< 解除禁言
};

/// 禁言封号数据库表操作
enum ERoleOptLimitType
{
	ROLE_LIMIT_OPT_INVALID = 0,						///< 无效的封号操作
	ROLE_LIMIT_OPT_UPDATE_LOGIN = 1,				///< 更新登陆
	ROLE_LIMIT_OPT_UPDATE_CHAT = 2,					///< 更新聊天
	ROLE_LIMIT_OPT_DEL = 3,							///< 删除
};

/// 战斗状态
enum ECombatStateType
{
	COMBAT_STATE_TYPE_START = 1,					///< 战斗开始
	COMBAT_STATE_TYPE_END,							///< 战斗结束
};
DToStringDef(ECombatStateType);

/// 瞬移类型
enum EResetPosType
{
	RESET_POS_TYPE_INVALID,						///< 无效值
	RESET_POS_TYPE_WINK,						///< 瞬移
	RESET_POS_TYPE_PULL_BACK,					///< 拉人
	RESET_POS_TYPE_HIT_BACK,					///< 击退
	RESET_POS_TYPE_SKILL_WINK,					///< 技能瞬移
	RESET_POS_TYPE_DIRECT,						///< 直接移动至坐标
};
DToStringDef(EResetPosType);

/// 角色(Character)状态
enum EObjState
{
	OBJ_STATE_TEAM = 0,							///< 是否为组队状态
	OBJ_STATE_LEADER = 1,						///< 是否为队长
};
DToStringDef(EObjState);

/// 对象逻辑
enum ECharacterLogic
{
	CHARACTER_LOGIC_INVALID	= 0,				///< 无效的
	CHARACTER_LOGIC_IDLE,						///< 空闲
	CHARACTER_LOGIC_MOVE,						///< 移动
	CHARACTER_LOGIC_DEAD,						///< 死亡

	CHARACTER_LOGIC_NUMBERS						///< 最大数目
};
DToStringDef(ECharacterLogic);

/// 移动模式
enum EMoveMode
{
	MOVE_MODE_INVALID = 0,	///< 无效
	MOVE_MODE_HOBBLE,       ///< 跟随
	MOVE_MODE_WALK,			///< 走	
	MOVE_MODE_RUN,			///< 跑
	MOVE_MODE_SPRINT,		///< 疾跑
};
DToStringDef(EMoveMode);

/// 移动类型
enum EMoveType
{
	MOVE_TYPE_CHECK,		///< 检测
	MOVE_TYPE_NOCHECK,		///< 不检测
};
DToStringDef(EMoveType);

/// 移动类型
enum ERoleMoveType
{
	ROLE_MOVE_TYPE_MOVE = 0,	///< 移动
	ROLE_MOVE_TYPE_STOP = 1,	///< 停止
};
DToStringDef(ERoleMoveType);

/// 添加追击怪物的类型
enum EAddApproachObjectType
{
	ADD_APPROACH_MON_TYPE_DAMAGE,	///< 受到伤害
	ADD_APPROACH_MON_TYPE_SCAN,		///< 扫描
};
DToStringDef(EAddApproachObjectType);

/// 删除追击怪物的类型
enum EDelApproachObjectType
{
	DEL_APPROACH_MON_TYPE_DIE,		///< 追击者死亡
	DEL_APPROACH_MON_TYPE_MY_DIE,	///< 被追击者死亡
	DEL_APPROACH_MON_TYPE_DROP,		///< 放弃
};
DToStringDef(EDelApproachObjectType);

/// 复活类型
enum EReliveType
{
	RELIVE_TYPE_LOCAL = 1,				///< 原地
	RELIVE_TYPE_BACKTURN				///< 回城
};
DToStringDef(EReliveType);

/// 区服务状态
enum EZoneServerState
{
	ZONE_SERVER_STATE_INVALID = 0,	///< 无效的状态
	ZONE_SERVER_STATE_NORMAL = 1,	///< 正常
	ZONE_SERVER_STATE_BUSY = 2,		///< 繁忙
	ZONE_SERVER_STATE_CLOSE = 3,	///< 维护
};

/// 区服务标记
enum EZoneServerFlag
{
	ZONE_SERVER_FLAG_INVALID = 0,	///< 无效的状态
	ZONE_SERVER_FLAG_RECOMMEND = 1,	///< 推荐
	ZONE_SERVER_FLAG_NEW = 2,		///< 新区
};

/// 公告参数类型
enum EAnnouncement
{
	ANNOUNCEMENT_INVALID = 0,		///< 无效
	ANNOUNCEMENT_ROLE = 1,			///< 角色 名字
	ANNOUNCEMENT_ITEM = 2,			///< 物品 ID|名字Key
	ANNOUNCEMENT_NUMBER = 3,		///< 数值 值
};

/// 公告系统类型
enum EAnnouncementSystem
{
	ANNOUNCEMENT_SYS_INVALID = 0,				///< 无效
	ANNOUNCEMENT_SYS_MALL = 1,					///< 商城购买
};

/// 公告触发类型
enum EAnnouncementEvent
{
	AET_SYS_INVALID = 0,			///< 无效
	AET_SYS_STOP = 1,				///< 系统维护
	AET_GAME_NOTIY = 2,				///< 游戏提醒
	AET_ROLE_LEVEL_UP = 3,			///< 达到等级
	AET_ROLE_VIP_UP = 4,			///< 达到VIP等级 
	AET_ROLE_GET_ITEM = 5,			///< 获得道具
};
DToStringDef(EAnnouncement);

/// 掉落（概率权重类型）
enum EOddAndWeightType		
{
	ODDANDWEIGHTTYPE_INVALID = 0,				///< 无效类型
	DROPODD_TYPE = 1,							///< 概率
	DROPWEIGHT_TYPE = 2,						///< 权重
};

/// 战斗类型
enum EFightType // @sc
{
	FIGHT_TYPE_INVALID = 0,				///< 无效值
	FIGHT_TYPE_CHAPTER = 1,			///< 关卡
	FIGHT_TYPE_CHALLENGE_OTHER = 2,		///< 挑战其他玩家
};

// @BEGNODOC
#endif	// _GAME_DEFINE_H_
// @ENDDOC