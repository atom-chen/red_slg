// @BEGNODOC
#ifndef _GAME_ERRNO_H_
#define _GAME_ERRNO_H_
// @ENDDOC

#include "core/string_common.h"

/// @brief 游戏中的返回码
enum EGameRetCode
{
	// 成功失败	// @NODOC
	RC_SUCCESS								= 0,		///< 操作成功
	RC_FAILED								= 1,		///< 操作失败, 请重试

	// 登陆模块(200-299)
	RC_ENTER_GAME_FAILED					= 200,		///< 进入游戏失败
	RC_LOGIN_FAILED							= 201,		///< 登录失败
	RC_LOGIN_MAX_ROLE_NUM					= 202,		///< 创建角色失败, 达到角色数上限
	RC_LOGIN_NOENOUGH_OBJ_UID				= 203,		///< 创建角色失败
	RC_LOGIN_NO_MAP_SERVER					= 204,		///< 无法找到地图服务器
	RC_LOGIN_NO_ROLE						= 205,		///< 无法找到角色
	RC_LOGIN_MIN_ROLE_NUM					= 206,		///< 无法删除角色, 至少需要保留一名角色
	RC_LOGIN_ROLE_NAME_INVALID				= 207,		///< 角色名含有非法字符，请重新取名
	RC_LOGIN_NO_MAP							= 208,		///< 无法找到对应的地图
	RC_LOGIN_HAS_SELECT_ROLE				= 209,		///< 已经选择角色登陆, 请等待服务器加载数据
	RC_LOGIN_NAME_REPEAT					= 210,		///< 名字重复
	RC_LOGIN_CREATE_ROLE_FAILED				= 211,		///< 创建角色失败, 请重试
	RC_LOGIN_DELETE_ROLE_FAILED				= 212,		///< 删除角色失败, 请重试
	RC_LOGIN_REQUEST_WAIT					= 213,		///< 正在处理其他请求, 请稍候
	RC_LOGIN_REQUEST_FAILED					= 214,		///< 请求失败, 请重试
	RC_LOGIN_OLD_ROLE_EXIST					= 215,		///< 登陆失败, 请重试
	RC_LOGIN_LIMIT							= 216,		///< 角色已被封
	RC_LOGIN_SERVER_CLOSE					= 217,		///< 服务器正在维护
	RC_LOGIN_NO_ACCOUNT						= 218,		///< 账号或密码错误
	RC_LOGIN_RENAME_FAILED					= 219,		///< 无法修改名字
	RC_LOGIN_RENAME_REPEAT					= 220,		///< 角色名已被占用，请重试
	RC_LOGIN_ACCOUNT_HAS_EXIST				= 221,		///< 账号已经被注册
	RC_LOGIN_ACCOUNT_REG_FAILED				= 222,		///< 账号注册失败，请重试
	RC_LOGIN_CANT_CHANGE_PASSWD				= 223,		///< 无法修改密码
	RC_LOGIN_ACCOUNT_PWD_INVALID			= 224,		///< 账号或密码错误

	// 角色模块(300-399)	// @NODOC
	RC_ROLE_DIE								= 300,		///< 角色已经死亡
	RC_ROLE_OFFLINE							= 301,		///< 角色不在线，请尝试重新登录
	RC_ROLE_NOT_EXIST						= 302,		///< 角色不存在，请尝试重新登录
	RC_LIMIT_MOVE							= 303,		///< 角色无法移动，请尝试重新登录
	RC_DIE									= 304,		///< 目标已经死亡
	RC_LACKGOLD								= 305,		///< 金币不足
	RC_LACKRMB								= 306,		///< 元宝不足，请充值

	// 背包模块(400-499)
	RC_PACK_FAILD							= 400,		///< 操作物品失败
	RC_PACK_DESTOPERATOR_HASITEM			= 401,		///< 背包的目标位置已经有物品了
	RC_PACK_SOUROPERATOR_LOCK				= 402,		///< 物品已锁定
	RC_PACK_DESTOPERATOR_LOCK				= 403,		///< 物品已锁定
	RC_PACK_DESTOPERATOR_FULL				= 404,		///< 背包空间不足
	RC_PACK_SOUROPERATOR_EMPTY				= 405,		///< 物品不存在
	RC_PACK_SPLIT_NUM_ERR					= 407,		///< 拆分数目不正确
	RC_PACK_EQUIP_TYPE_INVALID				= 410,		///< 无法装备此物品
	RC_PACK_ITEM_SEX_LIMIT					= 411,		///< 性别不符
	RC_PACK_ITEM_LEVEL_LIMIT				= 412,		///< 等级不足
	RC_PACK_ITEM_JOB_LIMIT					= 413,		///< 职业不符
	RC_PACK_ITEM_MAP_LIMIT					= 414,		///< 当前地图不能使用该物品
	RC_PACK_ITEM_TIME_OUT					= 415,		///< 该物品已过期
	RC_PACK_NO_ENOUGH_EMPTY_POS				= 416,		///< 背包空间不足
	RC_PACK_MAX_SIZE						= 417,		///< 背包格子数已达到最大
	RC_PACK_ITEM_DIE_LIMIT					= 418,		///< 死亡状态不能使用该物品
	RC_PACK_ITEM_COMBAT_LIMIT				= 419,		///< 战斗状态不能使用该物品
	RC_PACK_ITEM_STATUS_LIMIT				= 420,		///< 当前状态不能使用该物品
	RC_PACK_CONT_COOL_DOWN					= 421,		///< 背包整理时间未到

	// 背包模块(500-599)
	RC_BAG_IS_FULL							= 500,		///< 背包已满
	RC_BAG_HAVENOT_BAGTYPE					= 501,		///< 背包类型错误，请尝试重新登录
	RC_BAG_HAVENOT_TARGETITEM				= 502,		///< 背包内不存在该道具
	RC_BAG_USEITEM_FAILED					= 503,		///< 此类型的道具无法使用
	RC_BAG_DELETEITEM_FAILED				= 504,		///< 删除目标道具失败
	RC_BAG_DEDUCTITEM_FAILED				= 505,		///< 扣除目标道具失败
	RC_BAG_SELLTITEM_FAILED					= 506,		///< 出售目标道具失败
	RC_BAG_HAVENOT_BUYGGRID					= 507,		///< 背包空格已达到最大
	RC_BAG_ITEM_CDTIME						= 508,		///< 道具冷却中，请稍后重试
	RC_BAG_ADDITEM_FAILED					= 509,		///< 添加道具失败，请稍后重试
	RC_BAG_BUYGRID_FAILED					= 510,		///< 扩充格子失败，请稍后重试
	RC_BAG_CANNOTADDTOKEN					= 511,		///< 添加失败，请稍后重试
	RC_BAG_HAVENOT_ENM_OPENGIRD				= 512,		///< 元宝不足
	RC_BAG_CANNOT_ADDITEM_BYNULL			= 512,		///< 添加失败，请稍后重试

	// 通用模块(600-699)	// @NODOC
	RC_NO_ENOUGH_LEVEL						= 600,		///< 等级不够
	RC_NO_ENOUGH_ITEM						= 601,		///< 道具数目不足

	// GM命令(900-999)
	RC_GM_FAILD								= 900,		///< GM失败
	RC_GM_CMD_FORMAT_ERROR					= 901,		///< GM命令格式不对
	RC_GM_CMD_NO_GM_KEY_NAME				= 902,		///< 没有输入GM关键名字
	RC_GM_CMD_NOT_FIND_GM_NAME				= 903,		///< 没有找到该GM命令
	RC_GM_CMD_PARAM_ERROR					= 904,		///< GM命令参数不对
	RC_GM_CMD_NO_ENOUGH_POWER				= 905,		///< 没有对应的GM权限

	// Buffer(1000-1099)
	RC_BUFFER_FAILED						= 1000,		///< 添加Buff失败
	RC_BUFFER_EXIST_SAME					= 1001,		///< Buff不能共存
	RC_BUFFER_NO_EXIST						= 1002,		///< 不存在此Buff
	RC_BUFFER_EXIST_HIGHER					= 1003,		///< 已经存在高等级Buffer

	// 战斗模块(1100-1199)
	RC_FIGHT_HAS_START						= 1100,		///< 正在战斗中
	RC_SKILL_NO_USE							= 1200,		///< 技能无法使用
	RC_SKILL_NO_USE_SKILL					= 1201,		///< 当前状态无法使用技能
	RC_SKILL_NO_JOB							= 1202,		///< 职业不符合
	RC_SKILL_NO_DISTANCE					= 1203,		///< 距离不够
	RC_SKILL_NO_ENOUGH_MP					= 1204,		///< 内力不够
	RC_SKILL_NO_ATTACK_AND_TARGET_TYPE		= 1205,		///< 无法使用该技能(策划填写错误)
	RC_SKILL_DEST_OBJ_IS_DIE				= 1206,		///< 目标已经死亡
	RC_SKILL_NO_DEST_OBJ					= 1207,		///< 目标不存在
	RC_SKILL_NO_SKILL_TYPE					= 1208,		///< 无法使用该技能(策划填写错误)
	RC_SKILL_OWN_ISDIE						= 1209,		///< 您处于死亡状态, 无法释放技能
	RC_SKILL_NO_BE_ATTACK					= 1215,		///< 不能攻击该目标
	RC_SKILL_CAN_NOT_ATTACK_IN_FACTION		= 1216,		///< 无法攻击同阵营玩家
	RC_SKILL_NO_EMPTY_POS					= 1217,		///< 技能被阻碍, 无法释放
	RC_SKILL_NO_CD							= 1220,		///< 技能正在冷却中
	RC_SKILL_NO_USE_ON_OBJ					= 1221,		///< 无法对对方使用此技能(判断不够, 导致释放了错误的技能)
	RC_SKILL_IN_SAFE_ZONE					= 1222,		///< 对方正在安全区内
	RC_SKILL_CAN_NOT_LOW_LEVEL_ROLE			= 1223,		///< 对方处于新手保护期
	RC_SKILL_CAN_NOT_DIFF_LEVEL_ROLE		= 1224,		///< 新手期不同等级不能PK
	RC_SKILL_CAN_NOT_ATTACK_IN_PEACE		= 1225,		///< 和平模式不能攻击其他玩家
	RC_SKILL_CAN_NOT_ATTACK_IN_GUILD		= 1226,		///< 帮派模式不能攻击同帮派的玩家

	// 技能模块(1200-1299)
	RC_SKILL_MAX_LEVEL						= 1210,		///< 技能已经满级
	RC_SKILL_NO_ENOUGH_GOLD					= 1211,		///< 学习技能, 金钱不够
	RC_SKILL_NO_EXP							= 1212,		///< 学习技能, 经验不够
	RC_SKILL_NO_LEVEL						= 1213,		///< 学习技能, 等级不够
	RC_SKILL_MAX_NUM						= 1214,		///< 学习技能, 技能数达到最大
	RC_SKILL_NO_ENOUGH_SKILL_BOOK			= 1218,		///< 学习技能, 没有技能书
	RC_SKILL_NO_PRE_GRADE					= 1219,		///< 学习技能, 前置技能等级不满足

	// 聊天模块（1300-1399）
	RC_CHAT_SMALL_LEVEL_ERR                 = 1300,     ///< 角色等级不足
	RC_CHAT_GAP_TIME_TOO_SHORT_ERR          = 1301,     ///< 发言间隔时间太短，请稍后重试
	RC_CHAT_CONTENT_IS_EMPTY_ERR            = 1302,     ///< 没有任何聊天内容
	RC_CHAT_CONTENT_ALL_EMPTY_ERR           = 1303,     ///< 不可发送空格
	RC_CHAT_OTHER_FORBID_CONTENT_ERR        = 1304,     ///< 操作失败，请重试
	RC_CHAT_INVALID_GM_ERR                  = 1305,     ///< 非法的GM命令
	RC_CHAT_CONTENT_TOO_LONG_ERR            = 1306,     ///< 聊天内容不可超过100个字符
	RC_CHAT_FORBBID_ERR                     = 1307,     ///< 已被禁言

	// 任务(1400-1499)
	RC_MISSION_FAILD                 		= 1400,		///< 任务失败，请重试
	RC_MISSION_NO_EXIST		         		= 1401,		///< 不存在该任务，请重试
	RC_MISSION_NO_LEVEL              		= 1402,		///< 未达到任务领取等级
	RC_MISSION_NO_PRI_ID             		= 1403,		///< 未完成当前任务，请完成后重试
	RC_MISSION_BAG_NO_EMPTY          		= 1404,		///< 背包空间不足，请清理背包后重试
	RC_MISSION_HAS_ACCEPT               	= 1405,		///< 已经接取过此任务，请重试
	RC_MISSION_HAS_FINISH            		= 1406,		///< 该任务已经完成
	RC_MISSION_NO_COLLECT_ITEM       		= 1407,		///< 进入关卡所需道具不足
	RC_MISSION_NO_FINISHED           		= 1408,		///< 请完成任务后重试

	// 地图模块(1700-1799)
	RC_MAP_FAILD							= 1700,		///< 切换地图失败
	RC_MAP_NO_TRANSMIT_ID					= 1701,		///< 无法找到传送点，请重试
	RC_MAP_NO_IN_TRANSMIT					= 1702,		///< 不在传送点区域内，请移动至传送点重试
	RC_MAP_LEVEL_IS_LESS					= 1703,		///< 等级不足
	RC_MAP_NO_FIND_DEST_MAP					= 1704,		///< 地图无效，请重试
	RC_MAP_CHANGE_LINE_WAIT					= 1705,		///< 正在向目标地图移动，请稍候
	RC_MAP_CHANGE_LINE_FAILED				= 1706,		///< 切换至目标地图失败，请重试
	RC_MAP_OPENING_DYNAMAP					= 1707,		///< 正在开启副本, 请稍候
	RC_MAP_CHANGING_LINE					= 1708,		///< 正在切换地图, 请稍候
	RC_MAP_NO_TELPORT						= 1709,		///< 当前地图无法传送
	RC_MAP_NOT_EQUAL						= 1710,		///< 无法找到目标地图
	RC_MAP_DEST_POS_NOT_WALK				= 1711,		///< 目标地图位置不可行走
	RC_MAP_NOT_FIND							= 1712,		///< 目标地图无法找到
	RC_CANT_ENTER_RISK_MAP					= 1713,		///< 无法进入副本

	/// 物品(1800-1899)
	RC_ITEM_FAILD							= 1800,		///< 物品操作失败
	RC_ITEM_IS_BINDED						= 1801,		///< 物品已经绑定
	RC_ITEM_IS_LOCKED						= 1802,		///< 物品已经加锁
	RC_ITEM_IS_OUTDAY						= 1803,		///< 物品已经过期
	RC_ITEM_IS_TASK							= 1804,		///< 该物品为任务物品
	RC_ITEM_NO_EXIST						= 1805,		///< 物品不存在
	RC_CREATE_ITEM_FAILED					= 1807,		///< 创建物品失败
	RC_ITEM_NOT_FIND_IN_CONFIG				= 1808,		///< 物品操作失败(在物品配置表中没有找到该物品)
	RC_ITEM_USE_NO_OBJECT					= 1809,		///< 出战宠物才能使用
	RC_ITEM_IS_NO_DESTORY					= 1810,		///< 物品不能丢弃
	RC_ITEM_NO_CD							= 1811,		///< 物品冷却中

	/// 普通
	RC_INDIANA_BETS_ENOUGH					= 1900,		///< 夺宝下注数目已满，请等待揭奖
	RC_JEWEL_UNENOUGH						= 1901,		///< 夺宝卡不足
	RC_INDIANA_INVALID_COUNT				= 1902,		///< 夺宝下注数目不对
	RC_FREEGOLDS_NO_TIME_TO					= 1903,		///< 时间未到无法领取免费金币
	RC_FREE_ENOUGH							= 1904,		///< 少于2000金币才能领取免费金币
	RC_GOLDS_UNENOUGH						= 1905,		///< 金币不足
	RC_HAS_GOT_LUCKY_ITEM					= 1906,		///< 已经领取过奖励
	RC_REDEEM_HAS_GET						= 1907,		///< 您已经使用过此兑换码
	RC_REDEEM_INVALID						= 1908,		///< 非法的兑换码
	RC_REDEEM_NOT_INTIME					= 1909,		///< 未到使用时间
	RC_REDEEM_HAS_GET_TYPE					= 1910,		///< 您已经使用过相同类型的兑换码
	RC_REDEEM_HAS_USE						= 1911,		///< 此兑换码已经被使用
	RC_SEVEN_DAILY_AWARD_ERROR				= 1912,		///< 无法领取每日签到奖励

	// 公共错误(20000-21000)
	RC_TEXT_INVALID							= 20000,	///< 含有非法字符

	// 服务器和服务器之间的错误码
	// MapServer-WorldServer(40000-42000)
	RC_REGISTE_MAP_REPEAT					= 40000,	///< 地图重复
	RC_REGISTE_MAP_NOT_ADD					= 40001,	///< 地图无法添加
	RC_CHANGE_LINE_ROLE_FULL				= 40002,	///< 人数已经达到上限
	RC_REGISTE_SERVER_REPEAT				= 40003,	///< 服务器重复注册

	//================================充值状态码================================
	// 充值错误码(52000-52999)
	RC_RECHARGE_WORLD_SERVER_ERR			= 52000,	///< 世界服务器错误
	RC_RECHARGE_WORLD_SERVER_DB_ERR			= 52001,	///< 世界服务器操作数据库出错
	RC_RECHARGE_MAP_SERVER_UN_EXIST			= 52002,	///< 地图服务器无法找到
	RC_RECHARGE_TIME_OUT					= 52003,	///< 充值超时
	RC_RECHARGE_ROLE_UNEXIST				= 52004,	///< 角色不存在
	RC_RECHARGE_HAS_CHANGE_LINE				= 52005,	///< 正在切线
	RC_RECHARGE_HAS_REQUEST_STATUS			= 52006,	///< 正处于请求状态
	RC_RECHARGE_HAS_RECHARGE				= 52007,	///< 正在充值中
	RC_RECHARGE_USER_UN_EXIST				= 52008,	///< 用户对象不存在
	RC_RECHARGE_ROLE_NOT_ENTER				= 52009,	///< 角色未进入游戏
};
DToStringDef(EGameRetCode);

// @BEGNODOC
#define IsSuccess(code) \
	(code) == RC_SUCCESS

#endif	
// @ENDDOC