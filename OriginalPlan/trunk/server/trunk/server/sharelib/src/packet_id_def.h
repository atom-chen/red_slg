// @BEGNODOC
#ifndef _PACKET_ID_DEF_H_
#define _PACKET_ID_DEF_H_

/**
* 协议以十六进制显示, 共四个字符,
* 例:0001
*    |0000    |
*    |协议序号|
*
* 协议序号: 按照排列的协议依次递增, 并且按模块划分序号范围
*
* 模块协议划分:
* 1. 系统使用				1-1000
* 2. 登陆模块				1001-1100
* 3. 基础模块				1100-3000
*/ // @ENDDOC
/** @brief 消息ID定义枚举
* 
* 消息ID值描述格式：PACKET_XX_YYYYYY
* XX可以描述为：MC、CM、MW、WM、CW、WC、MR、WR、PS、SP
* M游戏服务器端、C客户端、W世界服务器端、R为记录服务器、MG表示管理服务器
* YYYYYY表示消息内容
* 例如：PACKET_CM_ATTACK 表示客户端发给游戏服务器端关于攻击的消息
*/

/// 消息ID定义枚举
enum EPacketIDDef
{
	// 客户端-服务器协议 1000-30000

	// 测试模块 C<---->W 1-99
	PACKET_WC_TEST						= 1,					///< 测试协议
	PACKET_CW_TEST_REQ					= 2,					///< 测试协议
	PACKET_CM_LOCAL_LOGIN_ACCOUNT		= 32,					///< 通过账号本地登陆
	PACKET_MC_LOCAL_LOGIN_ACCOUNT_RET	= 321,					///< 通过账号本地登陆返回
	PACKET_CM_REGISTER					= 15,					///< 注册
	PACKET_MC_REGISTER_RET				= 151,					///< 注册返回

	// 测试模块 C<---->M 100-199
	PACKET_CM_VARIED_TEST				= 100,					///< 测试协议
	PACKET_MC_VARIED_TEST_RET			= 101,					///< 测试协议
	PACKET_CM_GM_COMMAND				= 102,					///< GM命令

	PACKET_CM_WORLDMSG = 87,
	PACKET_CM_ROOMMSG = 88,
	PACKET_MC_WORLDCHATMSG_RET = 853,
	PACKET_MC_ROOMCHATMSG_RET = 854,
	PACKET_MC_SCREENANNOUNCE_RET = 491,

	// 登陆模块
	// C<--->W 1000-1100
	PACKET_CL_VERIFY_ACCOUNT			= 1001,					///< 请求验证玩家账号
	PACKET_LC_VERIFY_ACCOUNT_RET		= 1002,					///< 验证玩家账号返回
	PACKET_CW_LOGIN_GAME				= 1003,					///< 请求登陆游戏
	PACKET_WC_LOGIN_GAME_RET			= 1004,					///< 登陆游戏返回
	PACKET_CW_LOGIN_QUIT				= 1005,					///< 请求退出登陆
	PACKET_WC_LOGIN_QUIT_RET			= 1006,					///< 退出登陆返回
	PACKET_CW_CREATE_ROLE				= 1008,					///< 创建角色
	PACKET_WC_CREATE_ROLE_RET			= 1009,					///< 创建角色返回
	PACKET_CL_ZONE_LIST_REQ				= 1010,					///< 请求区列表
	PACKET_LC_ZONE_LIST_RET				= 1011,					///< 区列表返回
	PACKET_CW_VERIFY_CONNECT			= 1012,					///< 请求验证客户端连接
	PACKET_WC_VERIFY_CONNECT_RET		= 1013,					///< 验证客户端连接返回
	PACKET_CW_RAND_ROLE_NAME			= 1014,					///< 请求随机角色名字
	PACKET_WC_RAND_ROLE_NAME_RET		= 1015,					///< 随机角色名字返回
	PACKET_CL_HAS_ROLE_ZONE_LIST		= 1016,					///< 请求有创建角色的区列表
	PACKET_LC_HAS_ROLE_ZONE_LIST_RET	= 1017,					///< 有创建角色的区列表返回

	//登陆 C<--->M 1100-1199
	PACKET_CM_LOCAL_LOGIN				= 1101,					///< 本地登陆
	PACKET_MC_LOCAL_LOGIN_RET			= 1102,					///< 本地登陆返回
	PACKET_CM_ENTER_GAME				= 1103,					///< 请求进入游戏
	PACKET_MC_ENTER_GAME_RET			= 1104,					///< 进入游戏返回

	// 基础模块 C<--->M 1200-1299
	PACKET_MC_ENTER_VIEW				= 1200,					///< 进入视野
	PACKET_MC_LEAVE_VIEW				= 1201,					///< 离开视野
	PACKET_MC_SCENE_DATA				= 1202,					///< 场景数据(NPC, 传送点)
	PACKET_CM_MOVE						= 1203,					///< 请求移动
	PACKET_MC_MOVE_RET					= 1204,					///< 移动返回
	PACKET_MC_MOVE_BROAD				= 1205,					///< 移动广播
	PACKET_CM_ENTER_SCENE				= 1206,					///< 进入场景
	PACKET_CM_CHAT						= 1207,					///< 聊天请求
	PACKET_MC_CHAT_BROAD				= 1208,					///< 聊天广播 
	PACKET_CM_TRANSMITE					= 1209,					///< 传送点传送
	PACKET_MC_TRANSMITE_RET				= 1210,					///< 传送返回
	PACKET_MC_SYNC_ROLE_DATA			= 1211,					///< 同步角色数据
	PACKET_MC_ENTER_SCENE_RET			= 1212,					///< 进入场景返回
	PACKET_CM_RENAME_ROLE_NAME			= 1213,					///< 角色修改名字
	PACKET_MC_RENAME_ROLE_NAME_RET		= 1214,					///< 角色修改名字返回
	PACKET_CM_RAND_ROLE_NAME			= 1215,					///< 角色随机名字
	PACKET_MC_RAND_ROLE_NAME_RET		= 1216,					///< 角色随机名字返回
	PACKET_CM_KICK_ROLE					= 1217,					///< 踢掉玩家
	PACKET_MC_KICK_ROLE_RET				= 1218,					///< 踢掉玩家返回
	PACKET_MC_ANNOUNCEMENT				= 1219,					///< 公告及提示
	PACKET_CM_JUMP						= 1220,					///< 跳跃
	PACKET_MC_JUMP_RET					= 1221,					///< 跳跃返回
	PACKET_CM_DROP						= 1222,					///< 降落
	PACKET_MC_DROP_RET					= 1223,					///< 降落返回
	PACKET_CM_LAND						= 1224,					///< 着陆
	PACKET_MC_LAND_RET					= 1225,					///< 着陆返回
	PACKET_MC_RESET_POS					= 1226,					///< 瞬移
	PACKET_MC_PLAYER_HEART				= 1227,					///< 角色心跳
	PACKET_CM_PLAYER_HEART_RET			= 1228,					///< 角色心跳返回
	PACKET_MC_ENTER_SCENE				= 1229,					///< 通知角色已经可以进入场景
	PACKET_CM_OPEN_DYNAMIC_MAP			= 1230,					///< 开启动态场景
	PACKET_MC_OPEN_DYNAMIC_MAP_RET		= 1231,					///< 开启动态场景返回
	PACKET_CM_CHANGE_MAP				= 1232,					///< 切换地图
	PACKET_MC_CHANGE_MAP_RET			= 1233,					///< 切换地图返回
	PACKET_CM_DYNAMIC_MAP_LIST			= 1234,					///< 动态地图列表
	PACKET_MC_DYNAMIC_MAP_LIST_RET		= 1235,					///< 动态地图列表返回

	// 战斗 C<--->M 1300-1399
	PACKET_MC_ATTACK_BROAD				= 1300,					///< 攻击广播
	PACKET_MC_ATTACK_IMPACT				= 1301,					///< 攻击效果
	PACKET_CM_BUFF_ARRAY				= 1302,					///< 请求Buff列表
	PACKET_MC_BUFF_ARRAY_RET			= 1303,					///< Buff列表返回
	PACKET_CM_VIEW_BUFF					= 1304,					///< 查看单个Buff
	PACKET_MC_VIEW_BUFF_RET				= 1305,					///< 查看单个Buff返回
	PACKET_MC_ADD_BUFFER				= 1306,					///< 添加BUFFER
	PACKET_MC_DEL_BUFFER				= 1307,					///< 删除BUFFER
	PACKET_MC_OBJ_ACTION_BAN			= 1308,					///< 行为禁止标记改变
	PACKET_CM_FIGHT_FINISH				= 1309,					///< 战斗完成
	PACKET_MC_FIGHT_FINISH_RET			= 1310,					///< 战斗完成返回
	PACKET_CM_FIGHT_OPEN_CHAPTER		= 1311,					///< 打开战斗关卡
	PACKET_MC_FIGHT_OPEN_CHAPTER_RET	= 1312,					///< 打开战斗关卡返回

	// 背包道具操作C<-->M 1400-1499
	PACKET_MC_ITEM_LIST					= 1400,					///< 背包物品列表
	PACKET_MC_ADD_ITEM					= 1401,					///< 主动添加物品操作
	PACKET_MC_DELETE_ITEM				= 1402,					///< 主动删除物品操作
	PACKET_MC_UPDATE_ITEM				= 1403,					///< 主动更新物品操作
	PACKET_MC_MOVE_ITEM					= 1404,					///< 移动道具
	PACKET_MC_EXCHANGE_ITEM				= 1405,					///< 交换道具
	PACKET_CM_BAG_BUY_GRID				= 1406,					///< 请求购买背包格子
	PACKET_MC_BAG_BUY_GRID_RET			= 1407,					///< 返回购买背包格子结果
	PACKET_MC_BAG_ADD_GRID				= 1408,					///< 背包增加格子
	PACKET_CM_BAG_OPERATOR				= 1409,					///< 请求使用、删除、出售、整理
	PACKET_MC_BAG_OPERATOR_RET			= 1410,					///< 返回背包操作结果使用、删除、出售

	// 登陆
	PACKET_CM_LOGIN_SERVER				= 2001,					///< 登陆服务器请求
	PACKET_MC_LOGIN_SERVER_RET			= 20011,				///< 登陆服务器返回
	PACKET_MC_SERVER_LIST_RET			= 20021,				///< 服务器列表返回

	// 任务 2900-2999
	PACKET_MC_MISSION_UPDATE			= 2900,					///< 更新任务列表
	PACKET_MC_MISSION_UPDATE_PARAMS		= 2901,					///< 更新条件参数(当前杀怪数,当前物品数)
	PACKET_MC_MISSIONRE_DEL				= 2902,					///< 删除一个任务
	PACKET_CM_MISSION_OPERATION			= 2903,					///< 任务操作(领取或提交)
	PACKET_MC_MISSION_OPERATION_RET		= 2904,					///< 任务操作返回(领取或提交)

	// 聊天 3000-3050
	PACKET_CM_CHAT_REQ                  = 3000,                 ///< 聊天请求
	PACKET_MC_CHAT_RET                  = 3001,                 ///< 聊天回复

	// 统一错误码码 3999
	PACKET_MC_CALLLBACKRETCODE			= 3999,					///< 返回错误码

	// 表格数据 4000-4199
	PACKET_MC_BUFFER_TBL_DATA			= 4000,					///< 表格数据
	PACKET_MC_CONSTANT_TBL_DATA			= 4001,					///< 常量表数据

	// 其他临时需求协议(4600-4649)
	PACKET_CM_EXCHANGE_GIFT_REQ         = 4600,                 ///< 输入兑换号,兑换礼包
	PACKET_MC_EXCHANGE_GIFT_RET         = 4601,                 ///< 兑换礼包返回
	PACKET_MC_TILI_INFO                 = 4602,                 ///< 增加体力
	PACKET_MC_ACTIVE_ADD                = 4603,                 ///< 活动增加通知


	// @BEGNODOC
	// 服务器-服务器协议 30000-40000
	/*
	* 模块协议划分:
	* 1. 系统使用				30001-31000
	* 2. 登陆模块				31001-31100
	* 3. 基础模块				31101-32000
	*/
	// 注册及管理(31001-31100)
	PACKET_MW_REGISTE               	= 31001,				// 地图服务器向世界服务器注册
	PACKET_WM_REGISTE_RET           	= 31002,				// 地图服务器向世界服务器注册返回
	PACKET_WM_CLOSE_SERVER				= 31003,				// 世界服务通知所有地盘服务器关闭
	PACKET_WM_UPDATE_SERVER				= 31004,				// 更新服务器数据
	PACKET_MW_UPDATE_SERVER				= 31005,				// 更新服务器数据
	PACKET_MW_OPEN_SCENE            	= 31006,				// 开启场景
	PACKET_MW_CLOSE_SCENE           	= 31007,				// 关闭场景

	// 广播及转发(31101-31200)
	PACKET_MW_BROAD						= 31101,				// 地图服务器向世界服务器广播请求
	PACKET_MW_TRANS						= 31102,				// 地图服务器向世界服务器转发请求到其他服务器
	PACKET_WM_TRANS_ERROR				= 31103,				// 世界服务器向地图服务器发送转发错误
	PACKET_MW_TRANS_TO_WORLD			= 31104,				// 地图服务器向世界服务器转发请求
	PACKET_WM_BROAD						= 31105,				// 世界服务器地图服务器广播

	// 地图玩家与世界服务器基本协议(31201-31300)
	PACKET_WM_LOAD_ROLE_DATA			= 31201,				///< 请求加载角色数据
	PACKET_MW_LOAD_ROLE_DATA_RET		= 31202,				///< 加载数据返回
	PACKET_WM_UNLOAD_ROLE_DATA			= 31203,				///< 请求释放角色数据
	PACKET_MW_UNLOAD_ROLE_DATA_RET		= 31204,				///< 释放数据返回
	PACKET_MW_ROLE_QUIT					= 31205,				///< 角色请求退出游戏
	PACKET_MW_ROLE_KICK					= 31206,				///< 踢掉角色
	PACKET_MW_ROLE_HEART				= 31207,				///< 角色心跳
	PACKET_WM_ROLE_HEART_RET			= 31208,				///< 角色心跳返回
	PACKET_WM_USER_UPDATE           	= 31209,				///< 更新user数据到MapServer
	PACKET_MW_ROLE_UPDATE           	= 31210,				///< 更新role数据到WorldServer
	PACKET_MW_USER_LOGIN				= 31211,				///< 角色登陆
	PACKET_MW_CHANGE_LINE				= 31212,				///< 切线请求
	PACKET_WM_CHANGE_LINE_RET			= 31213,				///< 切线请求返回
	PACKET_WM_CHANGE_LINE				= 31214,				///< 通知切换场景
	PACKET_MW_RAND_ROLE_NAME			= 31215,				///< 随机角色名字
	PACKET_WM_RAND_ROLE_NAME_RET		= 31216,				///< 随机角色名字返回
	PACKET_MW_RENAME_ROLE_NAME			= 31217,				///< 随机角色名字
	PACKET_WM_RENAME_ROLE_NAME_RET		= 31218,				///< 随机角色名字返回
	PACKET_MW_GET_RAND_NAME_LIST		= 31219,				///< 得到随机名字列表
	PACKET_WM_GET_RAND_NAME_LIST_RET	= 31220,				///< 得到随机名字列表返回
	// 	PACKET_MW_REFRESH_RANK_NUM			= 31221,				///< 刷新英雄榜排名
	// 	PACKET_WM_REFRESH_RANK_NUM_RET		= 31222,				///< 刷新英雄榜排名返回
	// 	PACKET_WM_RELOAD_RANK_LIST			= 31223,				///< 重新加载英雄榜
	// 	PACKET_WM_REFRESH_RANK_NUM			= 31224,				///< 刷新自己的英雄榜排名
	// 	PACKET_WM_ENDLESS_RANK_LIST			= 31225,				///< 得到无尽长廊排行榜
	// 	PACKET_MW_REFRESH_YESTERDAY_RANK_NUM= 31226,                ///< 更新昨日排名记录
	// 	PACKET_MW_GET_YESTERDAY_AWARD_INFO_REQ= 31227,              ///< 获取昨日排名信息请求
	// 	PACKET_WM_GET_YESTERDAY_AWARD_INFO_RET= 31228,              ///< 获取昨日排名信息返回
	// 	PACKET_WM_REFRESH_YESTERDAY_RANK_NUM= 31229,                ///< 刷新昨日排名	
	// 	PACKET_MW_GET_RANK_LIST_REQ         = 31230,                ///< 通知世界服务，请求排名列表
	// 	PACKET_MW_GET_DIAMOD_AWARD_REQ      = 31231,                ///< 通知世界服务，获取奖励钻石碎片
	// 	PACKET_MW_EXCHANGE_DIAMOD_REQ       = 31232,                ///< 通知世界服务，兑换钻石碎片	
	// 	PACKET_WM_ADD_DIAMOD                = 31233,                ///< 兑换钻石后，通知地图服务增加的钻石
	// 	PACKET_MW_CHALLENGE_OTHER			= 31234,				///< 挑战其他玩家
	// 	PACKET_WM_CHALLENGE_OTHER_RET		= 31235,				///< 挑战其他玩家返回
	// 	PACKET_MW_CHALLENGE_FINISH          = 31236,                ///< 排行榜挑战结束	
	// 	PACKET_MW_LOGIN_TELL                = 31237,                ///< 玩家登陆，通知地图服务修正苦工列表数据
	PACKET_MW_EXCHANGE_GIFT_REQ         = 31238,                ///< 玩家兑换礼包请求
	PACKET_WM_EXCHANGE_GIFT_RET         = 31239,                ///< 玩家兑换礼包回复
	//	PACKET_MW_SEARCH_INFO_REQ           = 31240,                ///< 查询玩家苦工敌人信息
	PACKET_WM_LIMIT_ACCOUNT_INFO        = 31241,                ///< 封号信息
	PACKET_WM_LIMIT_CHAT_INFO           = 31242,                ///< 禁言信息
	PACKET_MW_LIMIT_INFO_REQ            = 31243,                ///< 通知世界服务，玩家已进入游戏，转发限号信息
	PACKET_WM_SERVER_INFO				= 31244,				///< 区服信息
	PACKET_WM_AWARD_BIND_RMB			= 31245,				///< 绑定元宝
	PACKET_MW_ANNOUNCEMENT				= 31246,				///< 服务器公告
	// 	PACKET_MW_REWARD_INFO_REQ           = 31247,                ///< 通知世界服务查看领奖信息
	// 	PACKET_MW_REWARD_ADD_INFO_REQ       = 31248,                ///< 通知世界服务增加一条领奖信息
	// 	PACKET_MW_REWARD_GET_REQ            = 31249,                ///< 通知世界服务领取奖励
	// 	PACKET_WM_REWARD_ADD_READY_REQ      = 31250,                ///< 世界服务通知mapserver准备增加
	// 	PACKET_MW_REWEAR_ADD_READY_RET      = 31251,                ///< 地图服务告诉世界服务，增加奖励情况
	PACKET_MM_CHANGE_SCENE				= 31252,				///< 通知其他玩家切换到目标场景

	// 地图商城与世界商城服务器协议(31300-31350)
	// 	PACKET_WM_MALL_GOODLIST				= 31300,				///< 主动下发商城商品动态信息到map服务器
	// 	PACKET_WM_MALL_UPDATEGOODLIST		= 31301,				///< 主动下发商城商品更新动态信息到map服务器
	// 	PACKET_MW_ASK_BUYGOOD				= 31302,				///< 请求购买商城商品from map服务器
	// 	PACKET_WM_REC_BUYGOOD				= 31303,				///< 返回购买商城商品to map服务器

	/// 游戏服务器-日志服务器协议(31400-31499)
	PACKET_MR_RECORDE					= 31400,				///< 地图服务器到日志服务器
	PACKET_WR_RECORDE					= 31401,				///< 世界服务器到日志服务器
	PACKET_RR_RECORDE					= 31404,				///< 日志服务器到主日志服务器

	PACKET_PS_REQUEST					= 31402,				///< 管理服务器到日志服务器
	PACKET_SP_RESPONSE					= 31403,				///< 日志服务器到管理服务器
	PACKET_RW_SERVER_INFO				= 31405,				///< 请求服务器信息RecordeServer--WorldServer
	PACKET_WR_SERVER_INFO_RET			= 31406,				///< 请求服务器信息返回WorldServer--RecordeServer
	PACKET_GP_REQUEST					= 31407,				///< 资源服务器资源请求
	PACKET_PG_RESPONSE					= 31408,				///< 资源服务器资源响应
	PACKET_BR_RECORDE					= 31409,				///< 充值服务器日志

	/// 登陆服务器与世界服务器协议(31500-31599)
	PACKET_WL_REGIST					= 31500,				///< 世界服务器注册到登陆服务器
	PACKET_LW_REGIST_RET				= 31501,				///< 世界服务器注册到登陆服务器返回
	PACKET_WL_ROLE_LOGIN				= 31502,				///< 角色登陆
	PACKET_LW_ROLE_LOGIN_RET			= 31503,				///< 角色登陆返回
	PACKET_WL_ROLE_CREATE				= 31504,				///< 角色创建
	PACKET_LW_ROLE_CREATR_RET			= 31505,				///< 角色创建返回
	PACKET_WL_DATA_UPDATE				= 31506,				///< 数据更新
	PACKET_LW_LIMIT_INFO_UPDATE			= 31507,				///< 限号信息更新
	PACKET_LW_LIMIT_ACCOUNT_INFO        = 31508,                ///< 限号信息
	PACKET_LW_LIMIT_CHAT_INFO           = 31509,                ///< 限号信息
	PACKET_WL_LIMIT_INFO_REQ            = 31510,                ///< 发送限制请求


	/// 管理服务器与其他服务器协议(32000-33000)
	PACKET_XM_REGISTE					= 32000,				///< 服务器注册到管理服务器
	PACKET_MX_REGISTE_RET				= 32001,				///< 服务器注册到管理服务器返回

	// 充值服务器与其他服务器协议(32100-32200)
	PACKET_WB_REGISTE					= 32100,				///< 世界服务器注册
	PACKET_BW_REGISTE_RET				= 32101,				///< 世界服务器注册返回
	PACKET_BW_RECHARGE					= 32102,				///< 充值
	PACKET_WB_RECHARGE_RET				= 32103,				///< 充值返回
	PACKET_WM_RECHARGE					= 32104,				///< 充值
	PACKET_MW_RECHARGE_RET				= 32105,				///< 充值返回

	// @ENDDOC
};
// @NODOC
#endif	// _PACKET_ID_DEF_H_	// @NODOC