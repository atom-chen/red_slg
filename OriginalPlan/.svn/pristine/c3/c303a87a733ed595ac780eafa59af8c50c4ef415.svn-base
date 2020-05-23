// @BEGNODOC
#ifndef _SERVER_DEFINE_H_
#define _SERVER_DEFINE_H_
// @ENDDOC

/// 常量枚举定义
enum EServerDefine
{
	// @BEGSDOC
	// 程序和策划商定的极值, 需要保存到数据库的值
	MAX_SKILL_COOL_DOWN_NUM = 20,           		///< 技能冷却的最大数目
	MAX_ITEM_COOL_DOWN_NUM = 20,            		///< 物品冷却的最大数目
	MAX_SKILL_COMM_COOL_DOWN_NUM = 20,				///< 技能公共冷却种数
	MAX_ITEM_COMM_COOL_DOWN_NUM = 20,       		///< 物品公共冷却种数
	MAX_BUFF_PARAM_NUM = 10,                		///< Buff额外参数
	MAX_BUFF_DB_NUM = 30,                   		///< 数据库最多能存的Buff数
	ITEM_APPEDN_ATTR_NUM = 5,               		///< 附加属性数目
	ITEM_MAX_HOLE_TOTAL_NUM = 10,					///< 总的装备最大孔数
	MAX_ITEM_CURR_HOLE_NUM = 6,						///< 当前装备最大孔数
	ITEM_MAX_EXTRA_ATTR_NUM = 20,           		///< 最大可抽取的额外属性
	ITEM_BASE_ATTR_NUM = 9,							///< 基础属性数量
	ITEM_MAX_STRE_LEVEL = 12,						///< 装备最大的强化等级

	// 不能扩展
	ROLE_NAME_LEN = 32,								///< 名字长度

	// 系统极值
	MAX_BASE_RATE = 10000,							///< 基础小数比例
	MAX_PASSWORD_LEN = 50,							///< 密码的最大长度
	MAX_SCENE_NUM = 20,								///< 一个地图服务器最大场景数
	MAX_MAP_SERVER = 10,							///< 一个区最多能开多少个地图服务器
	MAX_TRANS_SIZE = 1024*64-1,						///< 地图服务器向世界服务器请求转发的数据的最大长度
	MAX_SCENE_DATA_UPDATE_TIME = 3,					///< 场景数据更新到世界服务器的时间(S)
	GUILD_NAME_LEN = 22,							///< 帮派名字长度
	MAX_AREA_IN_BLOCK = 10,							///< 一个Block里面可以加入的最大Area数量
	MAX_RAND_POS_NUM = 32,							///< 随机找地图位置的时候随机的次数
	MAX_SKILL_LEVEL = 100,							///< 技能最大等级
	MAX_LEVEL = 80,									///< 最大等级
	MIN_LEVEL = 1,									///< 最小等级
	MAX_ROLE_NUM_SAVE_NUM = 13,             		///< 最大角色保存人数表项
	MAX_ROLE_SAVE_SEC = 600,                		///< 保存角色的最大时间(600秒)
	MAX_GM_CMD_LENGTH = 500,						///< gm命令指令最大的长度
	GUAN_QIA_FAULT_LIMIT_NUM = 10000,               ///< 关卡默认日次数限制
	MAX_MISSION_EVENT_NUM = 256,					///< 任务事件个数
	MIN_RECORDE_BUFF_SEND_SIZE = 50000,				///< 最小的发送字节（5万字节）
	MAX_RECORDE_BUFF_SIZE = 60000,					///< 最大存储字节（6万字节）
	DEFAULT_RECORDE_UPDATE_TIME = 10000,			///< 记录定时更新时间
	DEFAULT_RECORDE_MAX_TIMES = 30,					///< 更新最大次数
	MAX_REOCRDE_SQL_LEN = 4096,						///< SQL语句的长度
	MAX_RECORDE_SECTION_SIZE = 8192,				///< 每段记录的大小
	MAX_RECORDE_SECTION_NUM = 8,					///< 记录的总段数

	// 协议极值
	MAX_COMPRESS_LEN = 65000,						///< 一次性可压缩的数据最大长度
	MAX_PLAYER_ACCOUNT_LEN = 15,					///< 玩家账号长度
	MAX_PLAYER_PASSWORD_LEN = 15,					///< 玩家密码长度
	MAX_ROLE_NUM = 50,								///< 每个账号最大角色个数	// @DOC
	MAX_ATTACKOR_NUM = 50,							///< 一次攻击最多被攻击的个数
	MAX_MOVE_STEP = 3,								///< 一次最多行走的步数
	MAX_ARRAY_NUM = 100,							///< 列表的最大个数
	MAX_ARRAY2_NUM = 100,							///< 高长度列表的最大长度
	MAX_CHAR_ARRAY1_NUM = 250,						///< 字符串长度
	MAX_CHAR_ARRAY2_NUM = 250,						///< 字符串长度
	MAX_SYNC_DATA_LEN = 1024,						///< 同步给客户端的最大数据长度
	MAX_SEND_BUFFER_NUM = 250,						// 一次性发给客户端的BUFFER数目

	// 当前可调整值
	ATTR_CHAR_TOTAL_MAX = 30,						///< 角色战斗属性总的最大值
	MAX_SKILL_NUM = 50,								///< 技能最大数目
	MAX_MISSION_CURR_PARAM_NUM = 5,					///< 当前任务参数个数
	MAX_MISSION_TOTAL_PARAM_NUM = 10,				///< 任务参数总个数
	MAX_CHAR_EXIST_MISSION_NUM = 50,				///< 已接任务个数
	MAX_CHAR_FINISH_MISSION_NUM = 4000,				///< 最多可完成的任务个数

	// 需要配置的值
	MAX_CHART_UPDATE_MOVE_TIME = 200,       		///< 角色更新移动的间隔时间
	MAX_SPEED_BASE_NUM = 560,               		///< 速度基数比例
	MAX_MOVE_STEP_PER_HUNDRED_SEC = 350,    		///< 每百秒能移动的步数
	MAX_MOVE_POS_NUM = 3,                           ///< 最大能同时移动的步数
	MAX_CHECK_MOVE_TIME = 3,						///< 检测是否在移动的最大时间(秒)
	ROLE_MANAGER_PROFILE_TIME = 10,					///< 打印所有玩家的数目时间间隔(秒)
    GUAN_QIA_GUA_JI_OVER_TIME = 3600,               ///< 挂机过载时间临界值
	MAX_ROLE_USER_DATA_UPDATE_TIME = 10000, 		///< 更新角色数据到世界服务器的时间(ms)
	MAX_ALL_USER_NUM = 15000,						///< 一个区所有角色数据(3万)			// @todo
	WORLD_PLAYER_MANGER_PROFILE_TIME = 10,			///< 世界服务器玩家统计时间间隔
	MAX_LOGIN_PLAYER_WAIT_SEC = 10,					///< 玩家登陆时等待的秒数
	CLOSE_SOCKET_WAIT_TIME = 2,						///< 关闭一个socket后最多等待多长(单位为秒)
	MAX_WORLD_MAPSERVER_ROLE_DIFF_NUM = 20,			///< 世界服务器及地图服务器相差人数
	MAX_RISK_SCENE_LAST_ENTER_TIME = 60,            ///< 副本场景超过离关闭还剩余多久时能进入(s)
	DEFAULT_CHECK_ROLE_LIMIT_TIME = 10,				///< 定时检测角色限制表的时间
	MAX_ROLE_LOGOUT_TIME = 20,						///< 角色登出后等待的最大删除时间(s)
	MAX_BUFF_NEED_SAVE_TIME = 10,           		///< Buff的剩余时间超过10秒才保存
	MAX_SYNC_SHAPE_TIME = 500,						///< 同步外观给客户端的时间间隔(毫秒)
	MAX_MONSTER_RAND_MOVE_TIME = 10,				///< 怪物随机移动时间(秒)
	MAX_SKILL_ID = 1000,                            ///< 技能的最大数目 
	SKILL_COMM_COOL_DOWN_ID = 0,            		///< 技能公共CD冷却ID
	// @ENDDOC
};

// @BEGNODOC
#endif
// @ENDDOC