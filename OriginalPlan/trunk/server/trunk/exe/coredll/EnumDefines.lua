-------------------------------------------------------
-- @class enum
-- @name EServerDefine
-- @description 常量枚举定义
-- @usage 
EServerDefine = {
		MAX_SKILL_COOL_DOWN_NUM = 20,			----- 技能冷却的最大数目
		MAX_ITEM_COOL_DOWN_NUM = 20,			----- 物品冷却的最大数目
		MAX_SKILL_COMM_COOL_DOWN_NUM = 20,			----- 技能公共冷却种数
		MAX_ITEM_COMM_COOL_DOWN_NUM = 20,			----- 物品公共冷却种数
		MAX_BUFF_PARAM_NUM = 10,			----- Buff额外参数
		MAX_BUFF_DB_NUM = 30,			----- 数据库最多能存的Buff数
		ITEM_APPEDN_ATTR_NUM = 5,			----- 附加属性数目
		ITEM_MAX_HOLE_TOTAL_NUM = 10,			----- 总的装备最大孔数
		MAX_ITEM_CURR_HOLE_NUM = 6,			----- 当前装备最大孔数
		ITEM_MAX_EXTRA_ATTR_NUM = 20,			----- 最大可抽取的额外属性
		ITEM_BASE_ATTR_NUM = 9,			----- 基础属性数量
		ITEM_MAX_STRE_LEVEL = 12,			----- 装备最大的强化等级
		ROLE_NAME_LEN = 32,			----- 名字长度
		MAX_BASE_RATE = 10000,			----- 基础小数比例
		MAX_PASSWORD_LEN = 50,			----- 密码的最大长度
		MAX_SCENE_NUM = 20,			----- 一个地图服务器最大场景数
		MAX_MAP_SERVER = 10,			----- 一个区最多能开多少个地图服务器
		MAX_TRANS_SIZE = 65535,			----- 地图服务器向世界服务器请求转发的数据的最大长度
		MAX_SCENE_DATA_UPDATE_TIME = 3,			----- 场景数据更新到世界服务器的时间(S)
		GUILD_NAME_LEN = 22,			----- 帮派名字长度
		MAX_AREA_IN_BLOCK = 10,			----- 一个Block里面可以加入的最大Area数量
		MAX_RAND_POS_NUM = 32,			----- 随机找地图位置的时候随机的次数
		MAX_SKILL_LEVEL = 100,			----- 技能最大等级
		MAX_LEVEL = 80,			----- 最大等级
		MIN_LEVEL = 1,			----- 最小等级
		MAX_ROLE_NUM_SAVE_NUM = 13,			----- 最大角色保存人数表项
		MAX_ROLE_SAVE_SEC = 600,			----- 保存角色的最大时间(600秒)
		MAX_GM_CMD_LENGTH = 500,			----- gm命令指令最大的长度
		GUAN_QIA_FAULT_LIMIT_NUM = 10000,			----- 关卡默认日次数限制
		MAX_MISSION_EVENT_NUM = 256,			----- 任务事件个数
		MIN_RECORDE_BUFF_SEND_SIZE = 50000,			----- 最小的发送字节（5万字节）
		MAX_RECORDE_BUFF_SIZE = 60000,			----- 最大存储字节（6万字节）
		DEFAULT_RECORDE_UPDATE_TIME = 10000,			----- 记录定时更新时间
		DEFAULT_RECORDE_MAX_TIMES = 30,			----- 更新最大次数
		MAX_REOCRDE_SQL_LEN = 4096,			----- SQL语句的长度
		MAX_RECORDE_SECTION_SIZE = 8192,			----- 每段记录的大小
		MAX_RECORDE_SECTION_NUM = 8,			----- 记录的总段数
		MAX_COMPRESS_LEN = 65000,			----- 一次性可压缩的数据最大长度
		MAX_PLAYER_ACCOUNT_LEN = 15,			----- 玩家账号长度
		MAX_PLAYER_PASSWORD_LEN = 15,			----- 玩家密码长度
		MAX_ROLE_NUM = 50,			----- 每个账号最大角色个数	// @DOC
		MAX_ATTACKOR_NUM = 50,			----- 一次攻击最多被攻击的个数
		MAX_MOVE_STEP = 3,			----- 一次最多行走的步数
		MAX_ARRAY_NUM = 100,			----- 列表的最大个数
		MAX_ARRAY2_NUM = 100,			----- 高长度列表的最大长度
		MAX_CHAR_ARRAY1_NUM = 250,			----- 字符串长度
		MAX_CHAR_ARRAY2_NUM = 250,			----- 字符串长度
		MAX_SYNC_DATA_LEN = 1024,			----- 同步给客户端的最大数据长度
		MAX_SEND_BUFFER_NUM = 250,			----- 
		ATTR_CHAR_TOTAL_MAX = 30,			----- 角色战斗属性总的最大值
		MAX_SKILL_NUM = 50,			----- 技能最大数目
		MAX_MISSION_CURR_PARAM_NUM = 5,			----- 当前任务参数个数
		MAX_MISSION_TOTAL_PARAM_NUM = 10,			----- 任务参数总个数
		MAX_CHAR_EXIST_MISSION_NUM = 50,			----- 已接任务个数
		MAX_CHAR_FINISH_MISSION_NUM = 4000,			----- 最多可完成的任务个数
		MAX_CHART_UPDATE_MOVE_TIME = 200,			----- 角色更新移动的间隔时间
		MAX_SPEED_BASE_NUM = 560,			----- 速度基数比例
		MAX_MOVE_STEP_PER_HUNDRED_SEC = 350,			----- 每百秒能移动的步数
		MAX_MOVE_POS_NUM = 3,			----- 最大能同时移动的步数
		MAX_CHECK_MOVE_TIME = 3,			----- 检测是否在移动的最大时间(秒)
		ROLE_MANAGER_PROFILE_TIME = 10,			----- 打印所有玩家的数目时间间隔(秒)
		GUAN_QIA_GUA_JI_OVER_TIME = 3600,			----- 挂机过载时间临界值
		MAX_ROLE_USER_DATA_UPDATE_TIME = 10000,			----- 更新角色数据到世界服务器的时间(ms)
		MAX_ALL_USER_NUM = 15000,			----- 一个区所有角色数据(3万)			// @todo
		WORLD_PLAYER_MANGER_PROFILE_TIME = 10,			----- 世界服务器玩家统计时间间隔
		MAX_LOGIN_PLAYER_WAIT_SEC = 10,			----- 玩家登陆时等待的秒数
		CLOSE_SOCKET_WAIT_TIME = 2,			----- 关闭一个socket后最多等待多长(单位为秒)
		MAX_WORLD_MAPSERVER_ROLE_DIFF_NUM = 20,			----- 世界服务器及地图服务器相差人数
		MAX_RISK_SCENE_LAST_ENTER_TIME = 60,			----- 副本场景超过离关闭还剩余多久时能进入(s)
		DEFAULT_CHECK_ROLE_LIMIT_TIME = 10,			----- 定时检测角色限制表的时间
		MAX_ROLE_LOGOUT_TIME = 20,			----- 角色登出后等待的最大删除时间(s)
		MAX_BUFF_NEED_SAVE_TIME = 10,			----- Buff的剩余时间超过10秒才保存
		MAX_SYNC_SHAPE_TIME = 500,			----- 同步外观给客户端的时间间隔(毫秒)
		MAX_MONSTER_RAND_MOVE_TIME = 10,			----- 怪物随机移动时间(秒)
		MAX_SKILL_ID = 1000,			----- 技能的最大数目 
		SKILL_COMM_COOL_DOWN_ID = 0,			----- 技能公共CD冷却ID
};
-------------------------------------------------------
-- @class enum
-- @name EPackType
-- @description 背包类型
-- @usage 
EPackType = {
		PACK_TYPE_INVALID = 0,			----- 无效
		PACK_TYPE_BAG = 1,			----- 背包
		PACK_TYPE_EQUIP = 2,			----- 装备
		PACKET_TABLE_TYPE_NUMBER = 3,			----- 背包类型数目
};
-------------------------------------------------------
-- @class enum
-- @name EItemType
-- @description 大类
-- @usage 
EItemType = {
		ITEM_TYPE_INVALID = 0,			----- 无效类型
		ITEM_TYPE_EQUIP = 1,			----- 装备, 双击使用后会装备到角色身上
		ITEM_TYPE_DRUG = 2,			----- 药品, 双击后物品消失并增加药效
		ITEM_TYPE_CONSUME = 3,			----- 消耗, 不可双击使用
		ITEM_TYPE_SCROLL = 4,			----- 卷轴, 可双击使用, 并触发脚本
		ITEM_TYPE_SKILL_BOOK = 5,			----- 技能书, 可双击使用
		ITEM_TYPE_GEM = 6,			----- 宝石, 可双击使用
		ITEM_TYPE_BUFFER = 7,			----- Buffer, 可双击使用
		ITEM_TYPE_NUMBER = 8,			----- 物品的类别数量
};
-------------------------------------------------------
-- @class enum
-- @name EOptEquipType
-- @description 装备操作类型
-- @usage 
EOptEquipType = {
		OPT_EQUIP_INVALID = 0,			----- 
		OPT_EQUIP_CAN = 1,			----- 
		OPT_EQUIP_CAN_NOT = 2,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EDestroyType
-- @description 道具摧毁限制
-- @usage 
EDestroyType = {
		DESTROY_TYPE_CAN = 1,			----- 
		DESTROY_TYPE_CANT = 2,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name ESellLimit
-- @description 道具出售限制
-- @usage 
ESellLimit = {
		SELL_LIMIT_CAN = 1,			----- 
		SELL_LIMIT_CANT = 2,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EJobLimit
-- @description 职业限制
-- @usage 
EJobLimit = {
		JOB_LIMIT_NORMAL = 4,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name ESexLimit
-- @description 性别限制
-- @usage 
ESexLimit = {
		SEX_LIMIT_MALE = 1,			----- 
		SEX_LIMIT_FEMALE = 2,			----- 
		SEX_LIMIT_NORMAL = 3,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EEquipType
-- @description 装备子类型
-- @usage 
EEquipType = {
		EQUIP_TYPE_INVALID = 0,			----- 无效位置
		EQUIP_TYPE_START = 1,			----- 开始装备
		EQUIP_TYPE_ARM = 1,			----- 武器
		EQUIP_TYPE_ARMET = 2,			----- 头盔
		EQUIP_TYPE_SHOULDER = 3,			----- 护肩
		EQUIP_TYPE_ARMOR = 4,			----- 护甲
		EQUIP_TYPE_BELT = 5,			----- 腰带
		EQUIP_TYPE_LEG = 6,			----- 护腿
		EQUIP_TYPE_BOOTS = 7,			----- 靴子
		EQUIP_TYPE_NECKLACE = 8,			----- 项链
		EQUIP_TYPE_GALLUS = 9,			----- 吊坠
		EQUIP_TYPE_RING = 10,			----- 戒指
		EQUIP_TYPE_WRIST = 11,			----- 护腕
		EQUIP_TYPE_GLOVE = 12,			----- 手套
		EQUIP_TYPE_FASHION = 13,			----- 时装
		EQUIP_TYPE_NUMBER = 14,			----- 装备类型数目
		EQUIP_TYPE_POS_NUM = 15,			----- 装备位置总数
};
-------------------------------------------------------
-- @class enum
-- @name EDrugSubClass
-- @description 药品子类
-- @usage 
EDrugSubClass = {
		DRUG_SUB_CLASS_HP = 1,			----- 人物红
		DRUG_SUB_CLASS_MP = 2,			----- 人物蓝
		DRUG_SUB_CLASS_PET_HP = 3,			----- 宠物红
};
-------------------------------------------------------
-- @class enum
-- @name EConsumeSubClass
-- @description 消耗
-- @usage 
EConsumeSubClass = {
		CONSUME_SUB_CLASS_TASK = 1,			----- 任务道具
		CONSUME_SUB_CLASS_RELIVE = 2,			----- 复活令
		CONSUME_SUB_CLASS_HORN = 3,			----- 小喇叭
		CONSUME_SUB_CLASS_FLY_SHOES = 4,			----- 小飞鞋
		CONSUME_SUB_CLASS_TAN_HE_LING = 5,			----- 弹劾令
		CONSUME_SUB_CLASS_TONG_YA_LING = 6,			----- 通涯令
		CONSUME_SUB_CLASS_TRAVEL_CARD = 7,			----- 环游卡
		CONSUME_SUB_CLASS_CROP = 8,			----- 种子
		CONSUME_SUB_CLASS_SHOVEL = 9,			----- 铲子
};
-------------------------------------------------------
-- @class enum
-- @name ESkillBookSubClass
-- @description 技能书
-- @usage 
ESkillBookSubClass = {
		SKILL_BOOK_SUB_CLASS_ROLE = 0,			----- 人物技能书
		SKILL_BOOK_SUB_CLASS_PET = 1,			----- 宠物技能书
};
-------------------------------------------------------
-- @class enum
-- @name EGemSubClass
-- @description 宝石
-- @usage 
EGemSubClass = {
		GEM_SUB_CLASS_INVALID = 0,			----- 无效类型
		GEM_SUB_CLASS_INLAY = 1,			----- 镶嵌
		GEM_SUB_CLASS_WASH = 2,			----- 洗练
		GEM_SUB_CLASS_RISE_STAR = 3,			----- 升星石
		GEM_SUB_CLASS_ATTR = 4,			----- 属性石
		GEM_SUB_CLASS_GROW_UP = 5,			----- 成长石
		GEM_SUB_CLASS_LOCK_ATTR = 6,			----- 属性锁
};
-------------------------------------------------------
-- @class enum
-- @name EBufferSubClass
-- @description Buffer
-- @usage 
EBufferSubClass = {
		BUFF_SUB_INVALID = 0,			----- 无效类型
		BUFF_SUB_ITEM = 1,			----- buff丹
		BUFF_SUB_ROLE_HP = 2,			----- 人物红球
		BUFF_SUB_ROLE_MP = 3,			----- 人物蓝球
		BUFF_SUB_PET_HP = 4,			----- 宠物红球
		BUFF_SUB_ROLE_EXP = 5,			----- 人物加倍经验卡
		BUFF_SUB_ROLE_GOLD = 6,			----- 人物加倍银子卡
};
-------------------------------------------------------
-- @class enum
-- @name EScrollSubClass
-- @description 卷轴
-- @usage 
EScrollSubClass = {
		SCROLL_SUB_INVALID = 0,			----- 无效类型
};
-------------------------------------------------------
-- @class enum
-- @name EEquipQuality
-- @description 装备品质
-- @usage 
EEquipQuality = {
		EQUIP_QUALITY_INVALID = 0,			----- 无效类型
		EQUIP_QUALITY_WRITE = 1,			----- 白色装备
		EQUIP_QUALITY_GREEN = 2,			----- 绿色装备
		EQUIP_QUALITY_BLUE = 3,			----- 蓝色装备
		EQUIP_QUALITY_PURPLE = 4,			----- 紫色装备
		EQUIP_QUALITY_NUMBER = 5,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EGemQuality
-- @description 宝石品质
-- @usage 
EGemQuality = {
		GEM_QUALITY_ONE = 1,			----- 一级宝石
		GEM_QUALITY_TWO = 2,			----- 二级宝石
		GEM_QUALITY_THR = 3,			----- 三级宝石
		GEM_QUALITY_FOUR = 4,			----- 四级宝石
		GEM_QUALITY_FIVE = 5,			----- 五级宝石
		GEM_QUALITY_SIX = 6,			----- 六级宝石
		GEM_QUALITY_NUMBER = 7,			----- 品质总数
};
-------------------------------------------------------
-- @class enum
-- @name EItemExtremum
-- @description 物品扩展最大数
-- @usage 
EItemExtremum = {
		ITEM_EXTREMUM_MAX_STRE_LEVEL = 12,			-----  
		ITEM_EXTREMUM_MAX_APPEND_NUM = 9,			-----  
};
-------------------------------------------------------
-- @class enum
-- @name EBindType
-- @description 绑定类型
-- @usage 
EBindType = {
		BIND_TYPE_INVALID = 0,			----- 无效的绑定
		BIND_TYPE_UNBIND = 1,			----- 非绑定
		BIND_TYPE_BIND = 2,			----- 绑定
		BIND_TYPE_EQUIP = 3,			----- 装备绑定
};
-------------------------------------------------------
-- @class enum
-- @name EItemAttrBindType
-- @description 物品绑定类型, 不允许修改 ！！！
-- @usage 
EItemAttrBindType = {
		ITEM_ATTR_TYPE_INVALID = 0,			----- 无效绑定类型
		ITEM_ATTR_TYPE_UNBIND = 1,			----- 非绑定       
		ITEM_ATTR_TYPE_BIND = 2,			----- 绑定
		ITEM_ATTR_TYPE_BIND_ALL = 3,			----- 所有
};
-------------------------------------------------------
-- @class enum
-- @name EItemExtAttrType
-- @description 物品扩展属性
-- @usage 
EItemExtAttrType = {
		ITEM_ATTR_EXT_TYPE_BIND = 1,			----- 绑定规则
		ITEM_ATTR_EXT_TYPE_STRE = 2,			----- 强化规则
};
-------------------------------------------------------
-- @class enum
-- @name EAwardType
-- @description 奖励类型
-- @usage 
EAwardType = {
		AWARD_INVALID = 0,			----- 无效奖励类型
		AWARD_EXP = 1,			----- 经验
		AWARD_MONEY = 2,			----- 游戏币
		AWARD_RMB = 3,			----- 元宝
		AWARD_BIND_RMB = 4,			----- 绑定元宝
		AWARD_ITEM = 5,			----- 物品
};
-------------------------------------------------------
-- @class enum
-- @name EBagOperateType
-- @description 背包操作类型
-- @usage 
EBagOperateType = {
		BAG_OPERATE_TYPE_INVALID = 0,			----- 无效操作类型
		BAG_OPERATE_TYPE_DROP = 1,			----- 丢弃
		BAG_OPERATE_TYPE_USE = 2,			----- 使用
		BAG_OPERATE_TYPE_SELL = 3,			----- 出售
		BAG_OPERATE_TYPE_PACK_UP = 4,			----- 整理
		BAG_OPERATE_TYPE_REQ_ALL = 5,			----- 请求背包所有道具
};
-------------------------------------------------------
-- @class enum
-- @name tagConstant
-- @description 
-- @usage 
tagConstant = {
		INVALID_CONSTANTVAR = 0,			----- 
		TREASUREHUNT_ITEM_COMCD = 1,			----- 
		ROLE_MOVE_SPEED = 2,			----- 
		BUY_GRID_PRICE = 3,			----- 
		BAG_INIT_GRIDNUM = 4,			----- 
		BAG_MAX_GRIDNUM = 5,			----- 
		OT_SCENE_ROLE_NUM = 6,			----- 
		MAX_CONSTANTVAR = 7,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EServerType
-- @description 服务器类型
-- @usage 
EServerType = {
		INVALID_SERVER_TYPE = 0,			----- 无效
		SERVER_TYPE_WORLD = 1,			----- 世界服务器
		SERVER_TYPE_MAP_NORMAL = 2,			----- 普通场景服务器
		SERVER_TYPE_MAP_DYNAMIC = 3,			----- 动态场景服务器(副本或战场)
		SERVER_TYPE_MANAGER = 4,			----- 管理服务器
		SERVER_TYPE_RECORD = 5,			----- 记录服务器
		SERVER_TYPE_RESOURCE = 6,			----- 资源服务器
		SERVER_TYPE_CHARGE = 7,			----- 充值服务器
		SERVER_TYPE_LOGIN = 8,			----- 服务器类型
		SERVER_TYPE_NUM = 9,			----- 服务器类型数目
};
-------------------------------------------------------
-- @class enum
-- @name EServerStatus
-- @description 服务器状态
-- @usage 
EServerStatus = {
		INVALID_SERVER_STATUS = 0,			----- 无效的状态
		NORMAL_SERVER_STATUS = 1,			----- 正常状态
		READY_CLOSE_SERVER_STATUS = 2,			----- 准备关服（已发送关服命令）
		URGENT_CLOSE_SERVER_STATUS = 3,			----- 紧急关服
		KICK_ROLE_SERVER_SATATUS = 4,			----- 踢掉所有在线玩家并开始保存数据
		REAL_CLOSE_SERVER_STATUS = 5,			----- 真正开始结束服务器运行
};
-------------------------------------------------------
-- @class enum
-- @name ESceneType
-- @description 场景类型
-- @usage 
ESceneType = {
		SCENE_TYPE_INVALID = 0,			----- 无效
		SCENE_TYPE_NORMAL = 1,			----- 普通场景
		SCENE_TYPE_PK_RISK = 2,			----- 单人PK副本
		SCENE_TYPE_RISK = 3,			----- 副本场景
		SCENE_TYPE_NUMBER = 4,			----- 场景类型总数
};
-------------------------------------------------------
-- @class enum
-- @name ELoadRoleType
-- @description 加载角色数据类型
-- @usage 
ELoadRoleType = {
		LOAD_ROLE_TYPE_INVALID = 0,			----- 无效类型
		LOAD_ROLE_TYPE_LOGIN = 1,			----- 登陆
		LOAD_ROLE_TYPE_CHANGE_LINE = 2,			----- 切线
		LOAD_ROLE_TYPE_CHANGE_MAP = 3,			----- 切场景
		LOAD_ROLE_TYPE_TELE = 4,			----- 传送
};
-------------------------------------------------------
-- @class enum
-- @name EUnloadRoleType
-- @description 释放角色数据类型
-- @usage 
EUnloadRoleType = {
		UNLOAD_ROLE_TYPE_INVALID = 0,			----- 无效类型
		UNLOAD_ROLE_TYPE_ERROR = 1,			----- 严重出错
		UNLOAD_ROLE_TYPE_QUIT = 2,			----- 退出
		UNLOAD_ROLE_TYPE_KICK_BY_OTHER = 3,			----- 被其他玩家挤下线
		UNLOAD_ROLE_TYPE_CHANGE_LINE = 4,			----- 切线
		UNLOAD_ROLE_TYPE_SYS_CHECK = 5,			----- 系统通知下线
		UNLOAD_ROLE_TYPE_GM = 6,			----- 系统封号
};
-------------------------------------------------------
-- @class enum
-- @name ERoleStatus
-- @description 角色状态
-- @usage 
ERoleStatus = {
		ROLE_STATUS_INVALID = 0,			----- 无效状态
		ROLE_STATUS_LOAD = 1,			----- 数据加载成功状态
		ROLE_STATUS_ENTER = 2,			----- 进入游戏状态
		ROLE_STATUS_ENTER_SCENE = 3,			----- 进入场景状态
		ROLE_STATUS_CHANGE_MAP = 4,			----- 切换场景状态
		ROLE_STATUS_SAVE = 5,			----- 保存数据状态
		ROEL_STATUS_KICK_BY_OTHER = 6,			----- 被其他挤下线
		ROLE_STATUS_QUIT_REQ = 7,			----- 退出游戏请求状态
		ROLE_STATUS_QUTI = 8,			----- 退出状态
};
-------------------------------------------------------
-- @class enum
-- @name ESaveRoleType
-- @description 保存角色数据类型
-- @usage 
ESaveRoleType = {
		SAVE_ROLE_TYPE_DIFF = 0,			----- 差异更新
		SAVE_ROLE_TYPE_TIMER = 1,			----- 定时保存
		SAVE_ROEL_TYPE_OFFLINE = 2,			----- 下线
		SAVE_ROLE_TYPE_RECHARGE = 3,			----- 充值
		SAVE_ROLE_TYPE_SEND_RMB = 4,			----- 返还元宝
};
-------------------------------------------------------
-- @class enum
-- @name EPlayerStatus
-- @description 
-- @usage 
EPlayerStatus = {
		PS_INVALID = 0,			----- 无效状态
		PS_IDLE = 1,			----- 空状态
		PS_VERIFY_PASS = 2,			----- 验证通过状态
		PS_CREATE_ROLE_REQ = 3,			----- 创建角色请求状态
		PS_DELETE_ROLE_REQ = 4,			----- 删除角色请求状态
		PS_LOGIN_GAME_REQ = 5,			----- 登陆游戏请求状态, WorldServer请求MapServer加载数据
		PS_LOGIN_GAME = 6,			----- 登陆游戏成功状态(MapServer已经将角色数据发送过来)
		PS_PLAYING_GAME = 7,			----- 游戏状态(Client通知WorldServer退出登陆或者切线成功)
		PS_CHANGE_LINE_UNLOAD_REQ = 8,			----- 切线释放数据状态(MapServer请求换线, WorldServer判断可以换线, WorldServer请求MapServer将数据释放)
		PS_CHANGE_LINE_LOAD_REQ = 9,			----- 切线加载数据状态(源MapServer数据已经释放, World请求目标MapServer加载角色数据, 数据加载成功后会转入切线等待状态)
		PS_CHANGE_LINE_WAIT = 10,			----- 切线等待状态(目标服务器数据已经加载成功, 并且返回给客户端切线成功, 等待客户端登陆目标服务器并且等目标服务器返回切换成功响应)
		PS_QUIT_REQ = 11,			----- 请求退出状态(WorldServer请求MapServer将数据释放)
		PS_QUIT = 12,			----- 退出状态(数据已经释放)
};
-------------------------------------------------------
-- @class enum
-- @name EWPlayerActionType
-- @description 玩家在世界服务器的操作 
-- @usage 
EWPlayerActionType = {
		PA_VERIFY = 0,			----- 验证账号请求		C-W
		PA_DELETE_ROEL_REQ = 1,			----- 删除角色请求		C-W
		PA_CREATE_ROLE_REQ = 2,			----- 创建角色请求		C-W
		PA_LOGIN_GAME_REQ = 3,			----- 进入游戏请求		C-W
		PA_LOGIN_QUIT_REQ = 4,			----- 退出游戏登陆请求	C-W
		PA_UNLOAD_ROLE_REQ = 5,			----- 释放角色数据请求	W-M
		PA_CHANGE_LINE_REQ = 6,			----- 换线请求			M-W
		PA_QUIT_GAME_REQ = 7,			----- 退出游戏请求		M-W
		PA_CREATE_ROLE_RES = 8,			----- 创建角色响应		W-C
		PA_DELETE_ROLE_RES = 9,			----- 删除角色响应		W-C
		PA_LOAD_ROLE_RES = 10,			----- 加载角色数据响应	M-W
		PA_UNLOAD_ROLE_RES = 11,			----- 释放角色数据响应	M-W
};
-------------------------------------------------------
-- @class enum
-- @name ETeleportType
-- @description 传送类型
-- @usage 
ETeleportType = {
		TELEPORT_TYPE_INVALID = 0,			----- 无效类型
		TELEPORT_TYPE_TRANSMIT = 1,			----- 传送点
		TELEPORT_TYPE_SYS = 2,			----- 系统传送
		TELEPORT_TYPE_RISK_ENTER = 3,			----- 动态场景进入
		TELEPORT_TYPE_RISK_QUIT = 4,			----- 动态场景退出
		TELEPORT_TYPE_CHANGE_LINE = 5,			----- 切线
};
-------------------------------------------------------
-- @class enum
-- @name EAdultFlag
-- @description 成年信息
-- @usage 
EAdultFlag = {
		ADULT_FLAG_NONE = 0,			----- 未填写实名信息
		ADULT_FLAG_ADULT = 1,			----- 成年
		ADULT_FLAG_NO_ADULT = 2,			----- 未成年
};
-------------------------------------------------------
-- @class enum
-- @name EJobType
-- @description 职业
-- @usage 
EJobType = {
		INVALID_JOB_TYPE = -1,			----- 无效职业
		JOB_TYPE_PHYSIC = 0,			----- 物理
		JOB_TYPE_MAGIC = 1,			----- 魔法
		JOB_TYPE_MONSTER = 4,			----- 怪物
		JOB_TYPE_PET = 5,			----- 宠物
		JOB_TYPE_NPC = 6,			----- NPC
};
-------------------------------------------------------
-- @class enum
-- @name ESexType
-- @description 性别
-- @usage 
ESexType = {
		INVALID_SEX_TYPE = 0,			----- 无效性别
		SEX_TYPE_MALE = 1,			----- 男
		SEX_TYPE_FEMALE = 2,			----- 女
};
-------------------------------------------------------
-- @class enum
-- @name EKickType
-- @description 踢掉玩家
-- @usage 
EKickType = {
		KICK_TYPE_ERR = 1,			----- 您的网络不佳，请重新登陆
		KICK_TYPE_BY_OTHER = 2,			----- 您的账号已经在其他地方登陆
		KICK_TYPE_BY_GM = 3,			----- 您已被系统禁止登陆，请联系客服
		KICK_TYPE_GAME_STOP = 4,			----- 服务器停机维护，请稍后重新登陆
};
-------------------------------------------------------
-- @class enum
-- @name EChatChannel
-- @description 聊天频道
-- @usage 
EChatChannel = {
		CHANNEL_INVALID = 0,			----- 非法频道
		CHAT_CHANNEL_WORLD = 1,			----- 世界频道
		CHAT_CHANNEL_FACTION = 2,			----- 帮派频道
		CHAT_CHANNEL_PRIVATE = 3,			----- 私聊频道
		CHAT_CHANNEL_SYSTEM = 4,			----- 系统频道
		CHAT_CHANNEL_GM = 5,			----- GM频道
		CHAT_CHANNEL_NUMBER = 6,			----- 最大的数目	// @NODOC
};
-------------------------------------------------------
-- @class enum
-- @name EDir
-- @description 方向
-- @usage 
EDir = {
		DIR_INVALID = 0,			----- 无效的
		DIR_0 = 0,			----- 北, 其余按顺时针递增
		DIR_1 = 1,			----- 东北
		DIR_2 = 2,			----- 东
		DIR_3 = 3,			----- 东南
		DIR_4 = 4,			----- 南
		DIR_5 = 5,			----- 西南
		DIR_6 = 6,			----- 西
		DIR_7 = 7,			----- 西北
};
-------------------------------------------------------
-- @class enum
-- @name EDir2
-- @description 方向
-- @usage 
EDir2 = {
		DIR2_INVALID = 0,			----- 无效值
		DIR2_LEFT = 1,			----- 左
		DIR2_RIGHT = 2,			----- 右
};
-------------------------------------------------------
-- @class enum
-- @name EObjType
-- @description 对象类型
-- @usage 
EObjType = {
		INVALID_OBJ_TYPE = 0,			----- 无效类型
		OBJ_TYPE_ROLE = 1,			----- 角色
		OBJ_TYPE_NPC = 2,			----- NPC
		OBJ_TYPE_MONSTER = 3,			----- 怪物
		OBJ_TYPE_PET = 22,			----- 宠物	@NODOC
		OBJ_TYPE_ITEM = 23,			----- 物品	@NODOC
		OBJ_TYPE_HORSE = 24,			----- 坐骑	@NODOC
};
-------------------------------------------------------
-- @class enum
-- @name EAttributes
-- @description 属性枚举值定义
-- @usage 
EAttributes = {
		ATTR_FIGHT_INVALID = 0,			----- 无效
		ATTR_MAX_HP = 1,			----- 最大生命	
		ATTR_CUR_HP = 2,			----- 当前生命
		ATTR_MAX_ENERGY = 3,			----- 最大能量
		ATTR_CUR_ENERGY = 4,			----- 当前能量
		ATTR_POWER = 5,			----- 力量
		ATTR_AGILITY = 6,			----- 敏捷
		ATTR_WISDOM = 7,			----- 智力
		ATTR_STRENGTH = 9,			----- 体力
		ATTR_ATTACK = 10,			----- 攻击力
		ATTR_SKILL_ATTACK = 11,			----- 技能攻击力
		ATTR_DAMAGE = 12,			----- 额外伤害
		ATTR_DEFENSE = 13,			----- 防御力
		ATTR_DAMAGE_REDUCE = 14,			----- 伤害减免
		ATTR_MOVE_SPEED = 15,			----- 移动速度
		ATTR_CRIT = 16,			----- 暴击值
		ATTR_DODGE = 17,			----- 闪避
		ATTR_ATTACK_RANGE = 20,			----- 攻击距离
		ATTR_ATTACK_SPEED = 21,			----- 攻击速度
		ATTR_EXP = 22,			----- 经验
		ATTR_MONEY = 23,			----- 金钱
		ATTR_RMB = 24,			----- 元宝
		ATTR_CHAR_CURR_MAX = 49,			----- 策划可配置的最大属性
		ATTR_LEVEL = 50,			----- 等级
		ATTR_VIP_LEVEL = 56,			----- vip等级
		ATTR_VIP_EXP = 57,			----- vip经验	
		ATTR_MAX_EXP = 62,			----- 经验最大值
};
-------------------------------------------------------
-- @class enum
-- @name EActionBan
-- @description 行为禁止定义, 按位存储
-- @usage 
EActionBan = {
		ACTION_BAN_LIVE = 0,			----- 是否还活着
		ACTION_BAN_MOVE = 1,			----- 禁止移动
		ACTION_BAN_UNBE_ATTACK = 2,			----- 禁止被攻击
		ACTION_BAN_ATTACK = 3,			----- 禁止攻击
		ACTION_BAN_USE_ITEM = 4,			----- 禁止使用物品
		ACTION_BAN_MAX = 5,			----- 最大数目
};
-------------------------------------------------------
-- @class enum
-- @name ENumericalType
-- @description 数值类型(统一使用)
-- @usage 
ENumericalType = {
		NUMERICAL_TYPE_INVALID = 0,			----- 无效值
		NUMERICAL_TYPE_VALUE = 1,			----- 数值
		NUMERICAL_TYPE_ODDS = 2,			----- 机率(百分比)
};
-------------------------------------------------------
-- @class enum
-- @name ESkillType
-- @description 技能类型
-- @usage 
ESkillType = {
		SKILL_TYPE_INVALID = 0,			----- 无效
		SKILL_TYPE_ACTIVE = 1,			----- 主动
		SKILL_TYPE_PASSIVE = 2,			----- 被动
		SKILL_TYPE_ASSIST = 3,			----- 辅助
		SKILL_TYPE_MAX = 4,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name ESkillAttackType
-- @description 技能攻击类型
-- @usage 
ESkillAttackType = {
		SKILL_ATTACK_TYPE_INVALID = 0,			----- 无效
		SKILL_ATTACK_TYPE_SINGLE = 1,			----- 单体
		SKILL_ATTACK_TYPE_GROUP = 2,			----- 群体
		SKILL_ATTACK_TYPE_MAX = 3,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name ESkillTargetType
-- @description 目标类型
-- @usage 
ESkillTargetType = {
		SKILL_TARGET_TYPE_INVALID = 0,			----- 无效
		SKILL_TARGET_TYPE_ENEMY = 1,			----- 敌人
		SKILL_TARGET_TYPE_OWN = 2,			----- 自身
		SKILL_TARGET_TYPE_TEAM = 3,			----- 队伍
		SKILL_TARGET_TYPE_MAX = 4,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EBuffEventFlag
-- @description Buff事件
-- @usage 
EBuffEventFlag = {
		BUFF_EVENT_FLAG_DIE = 1,			----- 死亡
		BUFF_EVENT_FLAG_HURT = 2,			----- 受伤
		BUFF_EVENT_FLAG_MP_DES = 3,			----- MP减少
		BUFF_EVENT_FLAG_FORCE_HATE = 4,			----- 吸收仇恨
		BUFF_EVENT_FLAG_REFLECT = 5,			----- 反弹
		BUFF_EVENT_FLAG_SLEEP = 6,			----- 睡眠
		BUFF_EVENT_FLAG_STOP = 7,			----- 定身
		BUFF_EVENT_FLAG_DIZZ = 8,			----- 眩晕
		BUFF_EVENT_FLAG_NUM = 9,			----- 最大数目
};
-------------------------------------------------------
-- @class enum
-- @name EBuffEffectType
-- @description Buffer效果类型
-- @usage 
EBuffEffectType = {
		BUFF_EFFECT_TYPE_INVALID = 0,			----- 
		BUFF_EFFECT_TYPE_ADD_HPMP = 1,			----- 添加HP和MP的
		BUFF_EFFECT_TYPE_ADD_EXTRA_ATTR = 2,			----- 添加其他属性
		BUFF_EFFECT_TYPE_ADD_EXP = 3,			----- 经验卡
		MAX_BUFF_EFFECT_TYPE_NUM = 4,			----- 最大数目
};
-------------------------------------------------------
-- @class enum
-- @name EBuffType
-- @description Buffer类型
-- @usage 
EBuffType = {
		INVALID_BUFF_TYPE = 0,			----- 无效
		BUFF_TYPE_SKILL = 1,			----- 技能
		BUFF_TYPE_ITEM = 2,			----- 物品
		BUFF_TYPE_PASSIVE_SKILL = 3,			----- 被动技能
};
-------------------------------------------------------
-- @class enum
-- @name EBuffExistType
-- @description Buffer共存关系
-- @usage 
EBuffExistType = {
		BUFF_EXIST_TYPE_INVALID = 0,			----- 无效
		BUFF_EXIST_TYPE_EXIST = 1,			----- 共存
		BUFF_EXIST_TYPE_REPLACE = 2,			----- 覆盖
		BUFF_EXIST_TYPE_OVERLIING = 1,			----- 叠加
		BUFF_EXIST_TYPE_IGNORE = 3,			----- 不生效
};
-------------------------------------------------------
-- @class enum
-- @name EBuffLastType
-- @description Buffer持续类型
-- @usage 
EBuffLastType = {
		BUFF_LAST_TYPE_INVALID = 0,			----- 无效
		BUFF_LAST_TYPE_ABSOLUTE = 1,			----- 绝对
		BUFF_LAST_TYPE_OPPOSITE = 2,			----- 相对
		BUFF_LAST_TYPE_PERMANENT = 3,			----- 永久
		BUFF_LAST_TYPE_COUNT = 4,			----- 计数
};
-------------------------------------------------------
-- @class enum
-- @name EAttackImpactType
-- @description 攻击效果类型(共16种类型)
-- @usage 
EAttackImpactType = {
		INVALID_ATTACK_IMPACT_TYPE = 0,			----- 无效类型
		ATTACK_IMPACT_TYPE_NORMAL = 1,			----- 正常攻击
		ATTACK_IMPACT_TYPE_CRIT = 2,			----- 暴击
		ATTACK_IMPACT_TYPE_DODGE = 3,			----- 闪避
		ATTACK_IMPACT_TYPE_HIT_DOUBLE = 4,			----- 连击
		ATTACK_IMPACT_TYPE_CONFUSION = 5,			----- 混乱
		ATTACK_IMPACT_TYPE_RAND_ATTACK_ROLE = 6,			----- 乱杀
};
-------------------------------------------------------
-- @class enum
-- @name EMissionEvent
-- @description 任务事件类型
-- @usage 
EMissionEvent = {
		MISSION_EVENT_INVALID = 0,			----- 无效
		MISSION_EVENT_DIALOG = 1,			----- 对话
		MISSION_EVENT_GUANQIA = 2,			----- 闯关
		MISSION_EVENT_KILL_MONSTER = 3,			----- 杀怪
		MISSION_EVENT_COLLECT_ITEM = 4,			----- 物品
};
-------------------------------------------------------
-- @class enum
-- @name EMissionStatus
-- @description 任务状态
-- @usage 
EMissionStatus = {
		MISSION_STATUS_INVALID = 0,			----- 无效
		MISSION_STATUS_ACCEPTING = 1,			----- 待接取
		MISSION_STATUS_ACCEPTED = 2,			----- 可接取
		MISSION_STATUS_EXECUTED = 3,			----- 已接取
		MISSION_STATUS_FINISHED = 4,			----- 已完成
};
-------------------------------------------------------
-- @class enum
-- @name EMissionOperation
-- @description 任务操作
-- @usage 
EMissionOperation = {
		MISSION_OPERATION_INVALID = 0,			----- 无效
		MISSION_OPERATION_ACCEPT = 1,			----- 接受任务
		MISSION_OPERATION_SUBMIT = 2,			----- 提交任务
};
-------------------------------------------------------
-- @class enum
-- @name EMissionType
-- @description 任务类型
-- @usage 
EMissionType = {
		MISSION_TYPE_INVALID = 0,			----- 无效
		MISSION_TYPE_MAJOR = 1,			----- 主线
		MISSION_TYPE_CURR_MAX = 2,			----- 最大数目
};
-------------------------------------------------------
-- @class enum
-- @name EFindEmptyPosType
-- @description 查找空坐标类型
-- @usage 
EFindEmptyPosType = {
		FIND_EMPTY_POS_TYPE_LEFT = 0,			----- 左
		FIND_EMPTY_POS_TYPE_MID = 1,			----- 中(先搜中间再搜两边)
		FIND_EMPTY_POS_TYPE_MID_LEFT = 2,			----- 中左
		FIND_EMPTY_POS_TYPE_MID_RIGHT = 3,			----- 中右
		FIND_EMPTY_POS_TYPE_RIGHT = 4,			----- 右
};
-------------------------------------------------------
-- @class enum
-- @name ERoleLimitType
-- @description 角色限号类型
-- @usage 
ERoleLimitType = {
		ROLE_LIMIT_INVALID = 0,			----- 无效的封号操作
		ROLE_LIMIT_LOGIN = 1,			----- 禁止登陆
		ROLE_LIMIT_CHAT = 2,			----- 禁止聊天
		ROLE_LIMIT_DEL_LOGIN = 3,			----- 解除封号
		ROLE_LIMIT_DEL_CHAT = 4,			----- 解除禁言
};
-------------------------------------------------------
-- @class enum
-- @name ERoleOptLimitType
-- @description 禁言封号数据库表操作
-- @usage 
ERoleOptLimitType = {
		ROLE_LIMIT_OPT_INVALID = 0,			----- 无效的封号操作
		ROLE_LIMIT_OPT_UPDATE_LOGIN = 1,			----- 更新登陆
		ROLE_LIMIT_OPT_UPDATE_CHAT = 2,			----- 更新聊天
		ROLE_LIMIT_OPT_DEL = 3,			----- 删除
};
-------------------------------------------------------
-- @class enum
-- @name ECombatStateType
-- @description 战斗状态
-- @usage 
ECombatStateType = {
		COMBAT_STATE_TYPE_START = 1,			----- 战斗开始
		COMBAT_STATE_TYPE_END = 2,			----- 战斗结束
};
-------------------------------------------------------
-- @class enum
-- @name EResetPosType
-- @description 瞬移类型
-- @usage 
EResetPosType = {
		RESET_POS_TYPE_INVALID = 0,			----- 无效值
		RESET_POS_TYPE_WINK = 1,			----- 瞬移
		RESET_POS_TYPE_PULL_BACK = 2,			----- 拉人
		RESET_POS_TYPE_HIT_BACK = 3,			----- 击退
		RESET_POS_TYPE_SKILL_WINK = 4,			----- 技能瞬移
		RESET_POS_TYPE_DIRECT = 5,			----- 直接移动至坐标
};
-------------------------------------------------------
-- @class enum
-- @name EObjState
-- @description 角色(Character)状态
-- @usage 
EObjState = {
		OBJ_STATE_TEAM = 0,			----- 是否为组队状态
		OBJ_STATE_LEADER = 1,			----- 是否为队长
};
-------------------------------------------------------
-- @class enum
-- @name ECharacterLogic
-- @description 对象逻辑
-- @usage 
ECharacterLogic = {
		CHARACTER_LOGIC_INVALID = 0,			----- 无效的
		CHARACTER_LOGIC_IDLE = 1,			----- 空闲
		CHARACTER_LOGIC_MOVE = 2,			----- 移动
		CHARACTER_LOGIC_DEAD = 3,			----- 死亡
		CHARACTER_LOGIC_NUMBERS = 4,			----- 最大数目
};
-------------------------------------------------------
-- @class enum
-- @name EMoveMode
-- @description 移动模式
-- @usage 
EMoveMode = {
		MOVE_MODE_INVALID = 0,			----- 无效
		MOVE_MODE_HOBBLE = 1,			----- 跟随
		MOVE_MODE_WALK = 2,			----- 走	
		MOVE_MODE_RUN = 3,			----- 跑
		MOVE_MODE_SPRINT = 4,			----- 疾跑
};
-------------------------------------------------------
-- @class enum
-- @name EMoveType
-- @description 移动类型
-- @usage 
EMoveType = {
		MOVE_TYPE_CHECK = 0,			----- 检测
		MOVE_TYPE_NOCHECK = 1,			----- 不检测
};
-------------------------------------------------------
-- @class enum
-- @name ERoleMoveType
-- @description 移动类型
-- @usage 
ERoleMoveType = {
		ROLE_MOVE_TYPE_MOVE = 0,			----- 移动
		ROLE_MOVE_TYPE_STOP = 1,			----- 停止
};
-------------------------------------------------------
-- @class enum
-- @name EAddApproachObjectType
-- @description 添加追击怪物的类型
-- @usage 
EAddApproachObjectType = {
		ADD_APPROACH_MON_TYPE_DAMAGE = 0,			----- 受到伤害
		ADD_APPROACH_MON_TYPE_SCAN = 1,			----- 扫描
};
-------------------------------------------------------
-- @class enum
-- @name EDelApproachObjectType
-- @description 删除追击怪物的类型
-- @usage 
EDelApproachObjectType = {
		DEL_APPROACH_MON_TYPE_DIE = 0,			----- 追击者死亡
		DEL_APPROACH_MON_TYPE_MY_DIE = 1,			----- 被追击者死亡
		DEL_APPROACH_MON_TYPE_DROP = 2,			----- 放弃
};
-------------------------------------------------------
-- @class enum
-- @name EReliveType
-- @description 复活类型
-- @usage 
EReliveType = {
		RELIVE_TYPE_LOCAL = 1,			----- 原地
		RELIVE_TYPE_BACKTURN = 2,			----- 回城
};
-------------------------------------------------------
-- @class enum
-- @name EZoneServerState
-- @description 区服务状态
-- @usage 
EZoneServerState = {
		ZONE_SERVER_STATE_INVALID = 0,			----- 无效的状态
		ZONE_SERVER_STATE_NORMAL = 1,			----- 正常
		ZONE_SERVER_STATE_BUSY = 2,			----- 繁忙
		ZONE_SERVER_STATE_CLOSE = 3,			----- 维护
};
-------------------------------------------------------
-- @class enum
-- @name EZoneServerFlag
-- @description 区服务标记
-- @usage 
EZoneServerFlag = {
		ZONE_SERVER_FLAG_INVALID = 0,			----- 无效的状态
		ZONE_SERVER_FLAG_RECOMMEND = 1,			----- 推荐
		ZONE_SERVER_FLAG_NEW = 2,			----- 新区
};
-------------------------------------------------------
-- @class enum
-- @name EAnnouncement
-- @description 公告参数类型
-- @usage 
EAnnouncement = {
		ANNOUNCEMENT_INVALID = 0,			----- 无效
		ANNOUNCEMENT_ROLE = 1,			----- 角色 名字
		ANNOUNCEMENT_ITEM = 2,			----- 物品 ID|名字Key
		ANNOUNCEMENT_NUMBER = 3,			----- 数值 值
};
-------------------------------------------------------
-- @class enum
-- @name EAnnouncementSystem
-- @description 公告系统类型
-- @usage 
EAnnouncementSystem = {
		ANNOUNCEMENT_SYS_INVALID = 0,			----- 无效
		ANNOUNCEMENT_SYS_MALL = 1,			----- 商城购买
};
-------------------------------------------------------
-- @class enum
-- @name EAnnouncementEvent
-- @description 公告触发类型
-- @usage 
EAnnouncementEvent = {
		AET_SYS_INVALID = 0,			----- 无效
		AET_SYS_STOP = 1,			----- 系统维护
		AET_GAME_NOTIY = 2,			----- 游戏提醒
		AET_ROLE_LEVEL_UP = 3,			----- 达到等级
		AET_ROLE_VIP_UP = 4,			----- 达到VIP等级 
		AET_ROLE_GET_ITEM = 5,			----- 获得道具
};
-------------------------------------------------------
-- @class enum
-- @name EOddAndWeightType
-- @description 掉落（概率权重类型）
-- @usage 
EOddAndWeightType = {
		ODDANDWEIGHTTYPE_INVALID = 0,			----- 无效类型
		DROPODD_TYPE = 1,			----- 概率
		DROPWEIGHT_TYPE = 2,			----- 权重
};
-------------------------------------------------------
-- @class enum
-- @name EFightType
-- @description 战斗类型
-- @usage 
EFightType = {
		FIGHT_TYPE_INVALID = 0,			----- 无效值
		FIGHT_TYPE_CHAPTER = 1,			----- 关卡
		FIGHT_TYPE_CHALLENGE_OTHER = 2,			----- 挑战其他玩家
};
-------------------------------------------------------
-- @class enum
-- @name EGameRetCode
-- @description 游戏中的返回码
-- @usage 
EGameRetCode = {
		RC_SUCCESS = 0,			----- 操作成功
		RC_FAILED = 1,			----- 操作失败, 请重试
		RC_ENTER_GAME_FAILED = 200,			----- 进入游戏失败
		RC_LOGIN_FAILED = 201,			----- 登录失败
		RC_LOGIN_MAX_ROLE_NUM = 202,			----- 创建角色失败, 达到角色数上限
		RC_LOGIN_NOENOUGH_OBJ_UID = 203,			----- 创建角色失败
		RC_LOGIN_NO_MAP_SERVER = 204,			----- 无法找到地图服务器
		RC_LOGIN_NO_ROLE = 205,			----- 无法找到角色
		RC_LOGIN_MIN_ROLE_NUM = 206,			----- 无法删除角色, 至少需要保留一名角色
		RC_LOGIN_ROLE_NAME_INVALID = 207,			----- 角色名含有非法字符，请重新取名
		RC_LOGIN_NO_MAP = 208,			----- 无法找到对应的地图
		RC_LOGIN_HAS_SELECT_ROLE = 209,			----- 已经选择角色登陆, 请等待服务器加载数据
		RC_LOGIN_NAME_REPEAT = 210,			----- 名字重复
		RC_LOGIN_CREATE_ROLE_FAILED = 211,			----- 创建角色失败, 请重试
		RC_LOGIN_DELETE_ROLE_FAILED = 212,			----- 删除角色失败, 请重试
		RC_LOGIN_REQUEST_WAIT = 213,			----- 正在处理其他请求, 请稍候
		RC_LOGIN_REQUEST_FAILED = 214,			----- 请求失败, 请重试
		RC_LOGIN_OLD_ROLE_EXIST = 215,			----- 登陆失败, 请重试
		RC_LOGIN_LIMIT = 216,			----- 角色已被封
		RC_LOGIN_SERVER_CLOSE = 217,			----- 服务器正在维护
		RC_LOGIN_NO_ACCOUNT = 218,			----- 账号或密码错误
		RC_LOGIN_RENAME_FAILED = 219,			----- 无法修改名字
		RC_LOGIN_RENAME_REPEAT = 220,			----- 角色名已被占用，请重试
		RC_LOGIN_ACCOUNT_HAS_EXIST = 221,			----- 账号已经被注册
		RC_LOGIN_ACCOUNT_REG_FAILED = 222,			----- 账号注册失败，请重试
		RC_LOGIN_CANT_CHANGE_PASSWD = 223,			----- 无法修改密码
		RC_LOGIN_ACCOUNT_PWD_INVALID = 224,			----- 账号或密码错误
		RC_ROLE_DIE = 300,			----- 角色已经死亡
		RC_ROLE_OFFLINE = 301,			----- 角色不在线，请尝试重新登录
		RC_ROLE_NOT_EXIST = 302,			----- 角色不存在，请尝试重新登录
		RC_LIMIT_MOVE = 303,			----- 角色无法移动，请尝试重新登录
		RC_DIE = 304,			----- 目标已经死亡
		RC_LACKGOLD = 305,			----- 金币不足
		RC_LACKRMB = 306,			----- 元宝不足，请充值
		RC_PACK_FAILD = 400,			----- 操作物品失败
		RC_PACK_DESTOPERATOR_HASITEM = 401,			----- 背包的目标位置已经有物品了
		RC_PACK_SOUROPERATOR_LOCK = 402,			----- 物品已锁定
		RC_PACK_DESTOPERATOR_LOCK = 403,			----- 物品已锁定
		RC_PACK_DESTOPERATOR_FULL = 404,			----- 背包空间不足
		RC_PACK_SOUROPERATOR_EMPTY = 405,			----- 物品不存在
		RC_PACK_SPLIT_NUM_ERR = 407,			----- 拆分数目不正确
		RC_PACK_EQUIP_TYPE_INVALID = 410,			----- 无法装备此物品
		RC_PACK_ITEM_SEX_LIMIT = 411,			----- 性别不符
		RC_PACK_ITEM_LEVEL_LIMIT = 412,			----- 等级不足
		RC_PACK_ITEM_JOB_LIMIT = 413,			----- 职业不符
		RC_PACK_ITEM_MAP_LIMIT = 414,			----- 当前地图不能使用该物品
		RC_PACK_ITEM_TIME_OUT = 415,			----- 该物品已过期
		RC_PACK_NO_ENOUGH_EMPTY_POS = 416,			----- 背包空间不足
		RC_PACK_MAX_SIZE = 417,			----- 背包格子数已达到最大
		RC_PACK_ITEM_DIE_LIMIT = 418,			----- 死亡状态不能使用该物品
		RC_PACK_ITEM_COMBAT_LIMIT = 419,			----- 战斗状态不能使用该物品
		RC_PACK_ITEM_STATUS_LIMIT = 420,			----- 当前状态不能使用该物品
		RC_PACK_CONT_COOL_DOWN = 421,			----- 背包整理时间未到
		RC_BAG_IS_FULL = 500,			----- 背包已满
		RC_BAG_HAVENOT_BAGTYPE = 501,			----- 背包类型错误，请尝试重新登录
		RC_BAG_HAVENOT_TARGETITEM = 502,			----- 背包内不存在该道具
		RC_BAG_USEITEM_FAILED = 503,			----- 此类型的道具无法使用
		RC_BAG_DELETEITEM_FAILED = 504,			----- 删除目标道具失败
		RC_BAG_DEDUCTITEM_FAILED = 505,			----- 扣除目标道具失败
		RC_BAG_SELLTITEM_FAILED = 506,			----- 出售目标道具失败
		RC_BAG_HAVENOT_BUYGGRID = 507,			----- 背包空格已达到最大
		RC_BAG_ITEM_CDTIME = 508,			----- 道具冷却中，请稍后重试
		RC_BAG_ADDITEM_FAILED = 509,			----- 添加道具失败，请稍后重试
		RC_BAG_BUYGRID_FAILED = 510,			----- 扩充格子失败，请稍后重试
		RC_BAG_CANNOTADDTOKEN = 511,			----- 添加失败，请稍后重试
		RC_BAG_HAVENOT_ENM_OPENGIRD = 512,			----- 元宝不足
		RC_BAG_CANNOT_ADDITEM_BYNULL = 512,			----- 添加失败，请稍后重试
		RC_NO_ENOUGH_LEVEL = 600,			----- 等级不够
		RC_NO_ENOUGH_ITEM = 601,			----- 道具数目不足
		RC_GM_FAILD = 900,			----- GM失败
		RC_GM_CMD_FORMAT_ERROR = 901,			----- GM命令格式不对
		RC_GM_CMD_NO_GM_KEY_NAME = 902,			----- 没有输入GM关键名字
		RC_GM_CMD_NOT_FIND_GM_NAME = 903,			----- 没有找到该GM命令
		RC_GM_CMD_PARAM_ERROR = 904,			----- GM命令参数不对
		RC_GM_CMD_NO_ENOUGH_POWER = 905,			----- 没有对应的GM权限
		RC_BUFFER_FAILED = 1000,			----- 添加Buff失败
		RC_BUFFER_EXIST_SAME = 1001,			----- Buff不能共存
		RC_BUFFER_NO_EXIST = 1002,			----- 不存在此Buff
		RC_BUFFER_EXIST_HIGHER = 1003,			----- 已经存在高等级Buffer
		RC_FIGHT_HAS_START = 1100,			----- 正在战斗中
		RC_SKILL_NO_USE = 1200,			----- 技能无法使用
		RC_SKILL_NO_USE_SKILL = 1201,			----- 当前状态无法使用技能
		RC_SKILL_NO_JOB = 1202,			----- 职业不符合
		RC_SKILL_NO_DISTANCE = 1203,			----- 距离不够
		RC_SKILL_NO_ENOUGH_MP = 1204,			----- 内力不够
		RC_SKILL_NO_ATTACK_AND_TARGET_TYPE = 1205,			----- 无法使用该技能(策划填写错误)
		RC_SKILL_DEST_OBJ_IS_DIE = 1206,			----- 目标已经死亡
		RC_SKILL_NO_DEST_OBJ = 1207,			----- 目标不存在
		RC_SKILL_NO_SKILL_TYPE = 1208,			----- 无法使用该技能(策划填写错误)
		RC_SKILL_OWN_ISDIE = 1209,			----- 您处于死亡状态, 无法释放技能
		RC_SKILL_NO_BE_ATTACK = 1215,			----- 不能攻击该目标
		RC_SKILL_CAN_NOT_ATTACK_IN_FACTION = 1216,			----- 无法攻击同阵营玩家
		RC_SKILL_NO_EMPTY_POS = 1217,			----- 技能被阻碍, 无法释放
		RC_SKILL_NO_CD = 1220,			----- 技能正在冷却中
		RC_SKILL_NO_USE_ON_OBJ = 1221,			----- 无法对对方使用此技能(判断不够, 导致释放了错误的技能)
		RC_SKILL_IN_SAFE_ZONE = 1222,			----- 对方正在安全区内
		RC_SKILL_CAN_NOT_LOW_LEVEL_ROLE = 1223,			----- 对方处于新手保护期
		RC_SKILL_CAN_NOT_DIFF_LEVEL_ROLE = 1224,			----- 新手期不同等级不能PK
		RC_SKILL_CAN_NOT_ATTACK_IN_PEACE = 1225,			----- 和平模式不能攻击其他玩家
		RC_SKILL_CAN_NOT_ATTACK_IN_GUILD = 1226,			----- 帮派模式不能攻击同帮派的玩家
		RC_SKILL_MAX_LEVEL = 1210,			----- 技能已经满级
		RC_SKILL_NO_ENOUGH_GOLD = 1211,			----- 学习技能, 金钱不够
		RC_SKILL_NO_EXP = 1212,			----- 学习技能, 经验不够
		RC_SKILL_NO_LEVEL = 1213,			----- 学习技能, 等级不够
		RC_SKILL_MAX_NUM = 1214,			----- 学习技能, 技能数达到最大
		RC_SKILL_NO_ENOUGH_SKILL_BOOK = 1218,			----- 学习技能, 没有技能书
		RC_SKILL_NO_PRE_GRADE = 1219,			----- 学习技能, 前置技能等级不满足
		RC_CHAT_SMALL_LEVEL_ERR = 1300,			----- 角色等级不足
		RC_CHAT_GAP_TIME_TOO_SHORT_ERR = 1301,			----- 发言间隔时间太短，请稍后重试
		RC_CHAT_CONTENT_IS_EMPTY_ERR = 1302,			----- 没有任何聊天内容
		RC_CHAT_CONTENT_ALL_EMPTY_ERR = 1303,			----- 不可发送空格
		RC_CHAT_OTHER_FORBID_CONTENT_ERR = 1304,			----- 操作失败，请重试
		RC_CHAT_INVALID_GM_ERR = 1305,			----- 非法的GM命令
		RC_CHAT_CONTENT_TOO_LONG_ERR = 1306,			----- 聊天内容不可超过100个字符
		RC_CHAT_FORBBID_ERR = 1307,			----- 已被禁言
		RC_MISSION_FAILD = 1400,			----- 任务失败，请重试
		RC_MISSION_NO_EXIST = 1401,			----- 不存在该任务，请重试
		RC_MISSION_NO_LEVEL = 1402,			----- 未达到任务领取等级
		RC_MISSION_NO_PRI_ID = 1403,			----- 未完成当前任务，请完成后重试
		RC_MISSION_BAG_NO_EMPTY = 1404,			----- 背包空间不足，请清理背包后重试
		RC_MISSION_HAS_ACCEPT = 1405,			----- 已经接取过此任务，请重试
		RC_MISSION_HAS_FINISH = 1406,			----- 该任务已经完成
		RC_MISSION_NO_COLLECT_ITEM = 1407,			----- 进入关卡所需道具不足
		RC_MISSION_NO_FINISHED = 1408,			----- 请完成任务后重试
		RC_MAP_FAILD = 1700,			----- 切换地图失败
		RC_MAP_NO_TRANSMIT_ID = 1701,			----- 无法找到传送点，请重试
		RC_MAP_NO_IN_TRANSMIT = 1702,			----- 不在传送点区域内，请移动至传送点重试
		RC_MAP_LEVEL_IS_LESS = 1703,			----- 等级不足
		RC_MAP_NO_FIND_DEST_MAP = 1704,			----- 地图无效，请重试
		RC_MAP_CHANGE_LINE_WAIT = 1705,			----- 正在向目标地图移动，请稍候
		RC_MAP_CHANGE_LINE_FAILED = 1706,			----- 切换至目标地图失败，请重试
		RC_MAP_OPENING_DYNAMAP = 1707,			----- 正在开启副本, 请稍候
		RC_MAP_CHANGING_LINE = 1708,			----- 正在切换地图, 请稍候
		RC_MAP_NO_TELPORT = 1709,			----- 当前地图无法传送
		RC_MAP_NOT_EQUAL = 1710,			----- 无法找到目标地图
		RC_MAP_DEST_POS_NOT_WALK = 1711,			----- 目标地图位置不可行走
		RC_MAP_NOT_FIND = 1712,			----- 目标地图无法找到
		RC_CANT_ENTER_RISK_MAP = 1713,			----- 无法进入副本
		RC_ITEM_FAILD = 1800,			----- 物品操作失败
		RC_ITEM_IS_BINDED = 1801,			----- 物品已经绑定
		RC_ITEM_IS_LOCKED = 1802,			----- 物品已经加锁
		RC_ITEM_IS_OUTDAY = 1803,			----- 物品已经过期
		RC_ITEM_IS_TASK = 1804,			----- 该物品为任务物品
		RC_ITEM_NO_EXIST = 1805,			----- 物品不存在
		RC_CREATE_ITEM_FAILED = 1807,			----- 创建物品失败
		RC_ITEM_NOT_FIND_IN_CONFIG = 1808,			----- 物品操作失败(在物品配置表中没有找到该物品)
		RC_ITEM_USE_NO_OBJECT = 1809,			----- 出战宠物才能使用
		RC_ITEM_IS_NO_DESTORY = 1810,			----- 物品不能丢弃
		RC_ITEM_NO_CD = 1811,			----- 物品冷却中
		RC_INDIANA_BETS_ENOUGH = 1900,			----- 夺宝下注数目已满，请等待揭奖
		RC_JEWEL_UNENOUGH = 1901,			----- 夺宝卡不足
		RC_INDIANA_INVALID_COUNT = 1902,			----- 夺宝下注数目不对
		RC_FREEGOLDS_NO_TIME_TO = 1903,			----- 时间未到无法领取免费金币
		RC_FREE_ENOUGH = 1904,			----- 少于2000金币才能领取免费金币
		RC_GOLDS_UNENOUGH = 1905,			----- 金币不足
		RC_HAS_GOT_LUCKY_ITEM = 1906,			----- 已经领取过奖励
		RC_REDEEM_HAS_GET = 1907,			----- 您已经使用过此兑换码
		RC_REDEEM_INVALID = 1908,			----- 非法的兑换码
		RC_REDEEM_NOT_INTIME = 1909,			----- 未到使用时间
		RC_REDEEM_HAS_GET_TYPE = 1910,			----- 您已经使用过相同类型的兑换码
		RC_REDEEM_HAS_USE = 1911,			----- 此兑换码已经被使用
		RC_SEVEN_DAILY_AWARD_ERROR = 1912,			----- 无法领取每日签到奖励
		RC_TEXT_INVALID = 20000,			----- 含有非法字符
		RC_REGISTE_MAP_REPEAT = 40000,			----- 地图重复
		RC_REGISTE_MAP_NOT_ADD = 40001,			----- 地图无法添加
		RC_CHANGE_LINE_ROLE_FULL = 40002,			----- 人数已经达到上限
		RC_REGISTE_SERVER_REPEAT = 40003,			----- 服务器重复注册
		RC_RECHARGE_WORLD_SERVER_ERR = 52000,			----- 世界服务器错误
		RC_RECHARGE_WORLD_SERVER_DB_ERR = 52001,			----- 世界服务器操作数据库出错
		RC_RECHARGE_MAP_SERVER_UN_EXIST = 52002,			----- 地图服务器无法找到
		RC_RECHARGE_TIME_OUT = 52003,			----- 充值超时
		RC_RECHARGE_ROLE_UNEXIST = 52004,			----- 角色不存在
		RC_RECHARGE_HAS_CHANGE_LINE = 52005,			----- 正在切线
		RC_RECHARGE_HAS_REQUEST_STATUS = 52006,			----- 正处于请求状态
		RC_RECHARGE_HAS_RECHARGE = 52007,			----- 正在充值中
		RC_RECHARGE_USER_UN_EXIST = 52008,			----- 用户对象不存在
		RC_RECHARGE_ROLE_NOT_ENTER = 52009,			----- 角色未进入游戏
};
-------------------------------------------------------
-- @class enum
-- @name EPacketIDDef
-- @description 消息ID定义枚举
-- @usage 
EPacketIDDef = {
		PACKET_WC_TEST = 1,			----- 测试协议
		PACKET_CW_TEST_REQ = 2,			----- 测试协议
		PACKET_CM_LOCAL_LOGIN_ACCOUNT = 32,			----- 通过账号本地登陆
		PACKET_MC_LOCAL_LOGIN_ACCOUNT_RET = 321,			----- 通过账号本地登陆返回
		PACKET_CM_REGISTER = 15,			----- 注册
		PACKET_MC_REGISTER_RET = 151,			----- 注册返回
		PACKET_CM_USERCHANGEINFO = 28,			----- 
		PACKET_CM_VIEWGETPLAYERVIEW = 38,			----- 
		PACKET_CM_USERVERSION = 37,			----- 
		PACKET_CM_ROOMTICKETGOT = 56,			----- 
		PACKET_CM_TRADEPAGEINFO = 26,			----- 
		PACKET_CM_USERSIMPLEFISHCONTESTPAGE = 73,			----- 
		PACKET_CM_GUESSPAGEINFO = 61,			----- 
		PACKET_CM_RANKPAGEINFO = 18,			----- 
		PACKET_CM_USERSAVERECHARGEORDER = 81,			----- 
		PACKET_CM_PLATCHANGEACCOUNT = 11,			----- 
		PACKET_CM_MAILDELETE = 7,			----- 
		PACKET_CM_USEROPENCARD = 35,			----- 
		PACKET_CM_FRIENDMARKGIFTINFO = 2,			----- 
		PACKET_CM_USERONLINE = 34,			----- 
		PACKET_CM_USERGETCATAWARDVALUE = 68,			----- 
		PACKET_CM_FRIENDMARKREAD = 3,			----- 
		PACKET_CM_CHARMSPAGEINFO = 76,			----- 
		PACKET_CM_USERHEARTBEAT = 31,			----- 
		PACKET_CM_USERGETVIPINFO = 74,			----- 
		PACKET_CM_MAILMARKREAD = 10,			----- 
		PACKET_CM_USERGETLOGINAWARDBYTIMES = 58,			----- 
		PACKET_CM_FRIENDRESPONSE = 6,			----- 
		PACKET_CM_SHOPGETREADDITION = 78,			----- 
		PACKET_CM_FRIENDPAGEINFO = 4,			----- 
		PACKET_CM_FRIENDGIVEGIFT = 1,			----- 
		PACKET_CM_USERGETORDERINFOS = 80,			----- 
		PACKET_CM_USERGETLOGINAWARD = 30,			----- 
		PACKET_CM_ROOMREACHTARGET = 66,			----- 
		PACKET_CM_PLATTESTCONNECT = 16,			----- 
		PACKET_CM_USERLOGINAWARDINFO = 33,			----- 
		PACKET_CM_PLATSDKLOGIN = 71,			----- 
		PACKET_CM_ROOMALLSPECIAL = 19,			----- 
		PACKET_CM_PLATREGISTER = 15,			----- 
		PACKET_CM_USERFISHCONTESTPAGE = 69,			----- 
		PACKET_CM_USERECHO = 29,			----- 
		PACKET_CM_USERCHECKSOMETHING = 54,			----- 
		PACKET_CM_ROOMQUIT = 24,			----- 
		PACKET_CM_GUESSBET = 60,			----- 
		PACKET_CM_TRADETRADE = 27,			----- 
		PACKET_CM_CHARMSCHARMS = 75,			----- 
		PACKET_CM_MAILGETATTACH = 8,			----- 
		PACKET_CM_FRIENDSIMPLEPAGEINFO = 79,			----- 
		PACKET_CM_RANKPAGESIMPLEINFO = 72,			----- 
		PACKET_CM_SHOPPAGEINFO = 25,			----- 
		PACKET_CM_ROOMSENDEXPRESSION = 77,			----- 
		PACKET_CM_ROOMPERIODSYNC = 23,			----- 
		PACKET_CM_PLATCHANGEPASSWORD = 12,			----- 
		PACKET_CM_FRIENDDELETE = 0,			----- 
		PACKET_CM_FRIENDREQUEST = 5,			----- 
		PACKET_CM_USERGETSELFICONAWARD = 57,			----- 
		PACKET_CM_PLATVERSION = 17,			----- 
		PACKET_CM_MAILMAILS = 9,			----- 
		PACKET_CM_USERCLIENTLOG = 55,			----- 
		PACKET_CM_PLATLOGIN = 13,			----- 
		PACKET_CM_ROOMOWNCHANGE = 65,			----- 
		PACKET_CM_GUESSRECEIVEAWARD = 70,			----- 
		PACKET_CM_ROOMENTER = 21,			----- 
		PACKET_CM_USERLOGIN = 32,			----- 
		PACKET_CM_USERPLAYERINFO = 36,			----- 
		PACKET_CM_PLATQUICKREGISTER = 14,			----- 
		PACKET_CM_ROOMGIVEGIFT = 22,			----- 
		PACKET_CM_USERGETCATAWARD = 59,			----- 
		PACKET_CM_ROOMCHANGEPOS = 20,			----- 
		PACKET_CM_GETFRIENDCHATHISTROY = 85,			----- 
		PACKET_CM_FRIENDPRIVATECHAT = 86,			----- 
		PACKET_CM_WORLDMSG = 87,			----- 
		PACKET_CM_ROOMMSG = 88,			----- 
		PACKET_CM_INDIANA_HISTORYS = 90,			----- 
		PACKET_CM_MYINDIANA_HISTORYS = 91,			----- 
		PACKET_CM_ALLINDIANA = 92,			----- 
		PACKET_CM_INDIANA_JOIN = 93,			----- 
		PACKET_CM_MYINDIANA_NUMBERS = 94,			----- 
		PACKET_CM_GET_TRADE_RECORDS = 95,			----- 
		PACKET_CM_RECEIVE_FREE_GOLDS = 96,			----- 
		PACKET_CM_LOTTERY = 97,			----- 
		PACKET_CM_LUCKYAWARD = 98,			----- 
		PACKET_CM_GETSHOP_RECORDS = 40,			----- 
		PACKET_CM_INDIANA_RECENT = 41,			----- 
		PACKET_MC_USERCHANGEINFO_RET = 281,			----- 
		PACKET_MC_ROOMTICKETGOT_RET = 561,			----- 
		PACKET_MC_TRADEPAGEINFO_RET = 261,			----- 
		PACKET_MC_RANKPAGEINFO_RET = 181,			----- 
		PACKET_MC_MAILDELETE_RET = 179,			----- 
		PACKET_MC_USERECHO_RET = 291,			----- 
		PACKET_MC_TICKETMERMAIDGAINUPDATE_RET = 621,			----- 
		PACKET_MC_USERHEARTBEAT_RET = 311,			----- 
		PACKET_MC_FRIENDPAGEINFO_RET = 149,			----- 
		PACKET_MC_USERGETORDERINFOS_RET = 801,			----- 
		PACKET_MC_ROOMREACHTARGET_RET = 661,			----- 
		PACKET_MC_ROOMALLSPECIAL_RET = 191,			----- 
		PACKET_MC_ROOMQUIT_RET = 241,			----- 
		PACKET_MC_NEWMAIL_RET = 451,			----- 
		PACKET_MC_MAILGETATTACH_RET = 189,			----- 
		PACKET_MC_FRIENDDELETE_RET = 99,			----- 
		PACKET_MC_SEATPLAYERSUPDATE_RET = 501,			----- 
		PACKET_MC_ROOMCHANCE_RET = 671,			----- 
		PACKET_MC_SCREENANNOUNCE_RET = 491,			----- 
		PACKET_MC_USERGETSELFICONAWARD_RET = 571,			----- 
		PACKET_MC_PLATVERSION_RET = 171,			----- 
		PACKET_MC_FRIENDMARKREAD_RET = 139,			----- 
		PACKET_MC_ROOMOWNCHANGE_RET = 651,			----- 
		PACKET_MC_MAILMAILS_RET = 199,			----- 
		PACKET_MC_USERFISHCONTESTPAGE_RET = 691,			----- 
		PACKET_MC_USERONLINE_RET = 341,			----- 
		PACKET_MC_USERGETCATAWARD_RET = 591,			----- 
		PACKET_MC_TICKETGAINUPDATE_RET = 511,			----- 
		PACKET_MC_PLAYERINFOUPDATE_RET = 471,			----- 
		PACKET_MC_FRIENDAPPLYRESULT_RET = 421,			----- 
		PACKET_MC_FRIENDAPPLY_RET = 411,			----- 
		PACKET_MC_ROOMRECHARGEEVENT_RET = 531,			----- 
		PACKET_MC_FRIENDREQUEST_RET = 159,			----- 
		PACKET_MC_CHATMSGEVENT_RET = 401,			----- 
		PACKET_MC_FRIENDMARKGIFTINFO_RET = 129,			----- 
		PACKET_MC_USERGETVIPINFO_RET = 741,			----- 
		PACKET_MC_USERSAVERECHARGEORDER_RET = 811,			----- 
		PACKET_MC_FRIENDSIMPLEPAGEINFO_RET = 791,			----- 
		PACKET_MC_CHARMSPAGEINFO_RET = 761,			----- 
		PACKET_MC_ROOMSENDEXPRESSION_RET = 771,			----- 
		PACKET_MC_GIVEGIFTUPDATE_RET = 441,			----- 
		PACKET_MC_FRIENDRESPONSE_RET = 169,			----- 
		PACKET_MC_SHOPGETREADDITION_RET = 781,			----- 
		PACKET_MC_ALLSPECIALEVENT_RET = 391,			----- 
		PACKET_MC_FRIENDGIVEGIFT_RET = 119,			----- 
		PACKET_MC_CHARMSCHARMS_RET = 751,			----- 
		PACKET_MC_TESTPACKET_RET = 101,			----- 
		PACKET_MC_USERSIMPLEFISHCONTESTPAGE_RET = 731,			----- 
		PACKET_MC_PLATTESTCONNECT_RET = 161,			----- 
		PACKET_MC_USERLOGINAWARDINFO_RET = 331,			----- 
		PACKET_MC_PLATSDKLOGIN_RET = 711,			----- 
		PACKET_MC_RANKPAGESIMPLEINFO_RET = 721,			----- 
		PACKET_MC_GUESSRECEIVEAWARD_RET = 701,			----- 
		PACKET_MC_USERGETCATAWARDVALUE_RET = 681,			----- 
		PACKET_MC_GUESSPAGEINFO_RET = 611,			----- 
		PACKET_MC_USERCHECKSOMETHING_RET = 541,			----- 
		PACKET_MC_USERGETLOGINAWARD_RET = 301,			----- 
		PACKET_MC_ROOMCHANGEPOS_RET = 201,			----- 
		PACKET_MC_USERGETLOGINAWARDBYTIMES_RET = 581,			----- 
		PACKET_MC_PLATREGISTER_RET = 151,			----- 
		PACKET_MC_USERVERSION_RET = 371,			----- 
		PACKET_MC_PLATQUICKREGISTER_RET = 141,			----- 
		PACKET_MC_SHOPPAGEINFO_RET = 251,			----- 
		PACKET_MC_ROOMPERIODSYNC_RET = 231,			----- 
		PACKET_MC_RECHARGEGOLDSEVENT_RET = 521,			----- 
		PACKET_MC_ACTIVITYENDEVENT_RET = 631,			----- 
		PACKET_MC_FRIENDREMOVE_RET = 431,			----- 
		PACKET_MC_MAILMARKREAD_RET = 109,			----- 
		PACKET_MC_VIEWGETPLAYERVIEW_RET = 381,			----- 
		PACKET_MC_PLATCHANGEACCOUNT_RET = 111,			----- 
		PACKET_MC_PLAYERINROOM_RET = 461,			----- 
		PACKET_MC_TRADETRADE_RET = 271,			----- 
		PACKET_MC_USERCLIENTLOG_RET = 551,			----- 
		PACKET_MC_PLATLOGIN_RET = 131,			----- 
		PACKET_MC_GUESSBET_RET = 601,			----- 
		PACKET_MC_USEROPENCARD_RET = 351,			----- 
		PACKET_MC_ROOMENTER_RET = 211,			----- 
		PACKET_MC_USERLOGIN_RET = 321,			----- 
		PACKET_MC_USERPLAYERINFO_RET = 361,			----- 
		PACKET_MC_ROOMGIVEGIFTUPDATE_RET = 481,			----- 
		PACKET_MC_ROOMGIVEGIFT_RET = 221,			----- 
		PACKET_MC_ACTIVITYSTARTEVENT_RET = 641,			----- 
		PACKET_MC_PLATCHANGEPASSWORD_RET = 121,			----- 
		PACKET_MC_GETFRIENDCHATHISTROY_RET = 851,			----- 
		PACKET_MC_FRIENDPRIVATECHAT_RET = 852,			----- 
		PACKET_MC_WORLDCHATMSG_RET = 853,			----- 
		PACKET_MC_ROOMCHATMSG_RET = 854,			----- 
		PACKET_MC_MONEY_UPDATE = 855,			----- 
		PACKET_MC_INDIANA_HISTORYS_RET = 860,			----- 
		PACKET_MC_MYINDIANA_HISTORYS_RET = 861,			----- 
		PACKET_MC_ALLINDIANA_RET = 862,			----- 
		PACKET_MC_INDIANA_JOIN_RET = 863,			----- 
		PACKET_MC_INDIANA_RECENT_RET = 864,			----- 
		PACKET_MC_MYINDIANA_NUMBERS_RET = 865,			----- 
		PACKET_MC_GET_TRADE_RECORDS_RET = 866,			----- 
		PACKET_MC_RECEIVE_FREE_GOLDS_RET = 867,			----- 
		PACKET_MC_LOTTERY_RET = 868,			----- 
		PACKET_MC_LUCKY_AWARD_RET = 869,			----- 
		PACKET_MC_ADD_CANNON = 870,			----- 
		PACKET_MC_PLAYER_DATA_UPDATE = 871,			----- 
		PACKET_MC_SHOP_RECORDS_RET = 872,			----- 
		PACKET_MC_RECHARGEGOLDS_RET = 873,			----- 
		PACKET_CM_VARIED_TEST = 100,			----- 测试协议
		PACKET_MC_VARIED_TEST_RET = 101,			----- 测试协议
		PACKET_CM_GM_COMMAND = 102,			----- GM命令
		PACKET_CL_VERIFY_ACCOUNT = 1001,			----- 请求验证玩家账号
		PACKET_LC_VERIFY_ACCOUNT_RET = 1002,			----- 验证玩家账号返回
		PACKET_CW_LOGIN_GAME = 1003,			----- 请求登陆游戏
		PACKET_WC_LOGIN_GAME_RET = 1004,			----- 登陆游戏返回
		PACKET_CW_LOGIN_QUIT = 1005,			----- 请求退出登陆
		PACKET_WC_LOGIN_QUIT_RET = 1006,			----- 退出登陆返回
		PACKET_CW_CREATE_ROLE = 1008,			----- 创建角色
		PACKET_WC_CREATE_ROLE_RET = 1009,			----- 创建角色返回
		PACKET_CL_ZONE_LIST_REQ = 1010,			----- 请求区列表
		PACKET_LC_ZONE_LIST_RET = 1011,			----- 区列表返回
		PACKET_CW_VERIFY_CONNECT = 1012,			----- 请求验证客户端连接
		PACKET_WC_VERIFY_CONNECT_RET = 1013,			----- 验证客户端连接返回
		PACKET_CW_RAND_ROLE_NAME = 1014,			----- 请求随机角色名字
		PACKET_WC_RAND_ROLE_NAME_RET = 1015,			----- 随机角色名字返回
		PACKET_CL_HAS_ROLE_ZONE_LIST = 1016,			----- 请求有创建角色的区列表
		PACKET_LC_HAS_ROLE_ZONE_LIST_RET = 1017,			----- 有创建角色的区列表返回
		PACKET_CM_LOCAL_LOGIN = 1101,			----- 本地登陆
		PACKET_MC_LOCAL_LOGIN_RET = 1102,			----- 本地登陆返回
		PACKET_CM_ENTER_GAME = 1103,			----- 请求进入游戏
		PACKET_MC_ENTER_GAME_RET = 1104,			----- 进入游戏返回
		PACKET_MC_ENTER_VIEW = 1200,			----- 进入视野
		PACKET_MC_LEAVE_VIEW = 1201,			----- 离开视野
		PACKET_MC_SCENE_DATA = 1202,			----- 场景数据(NPC, 传送点)
		PACKET_CM_MOVE = 1203,			----- 请求移动
		PACKET_MC_MOVE_RET = 1204,			----- 移动返回
		PACKET_MC_MOVE_BROAD = 1205,			----- 移动广播
		PACKET_CM_ENTER_SCENE = 1206,			----- 进入场景
		PACKET_CM_CHAT = 1207,			----- 聊天请求
		PACKET_MC_CHAT_BROAD = 1208,			----- 聊天广播 
		PACKET_CM_TRANSMITE = 1209,			----- 传送点传送
		PACKET_MC_TRANSMITE_RET = 1210,			----- 传送返回
		PACKET_MC_SYNC_ROLE_DATA = 1211,			----- 同步角色数据
		PACKET_MC_ENTER_SCENE_RET = 1212,			----- 进入场景返回
		PACKET_CM_RENAME_ROLE_NAME = 1213,			----- 角色修改名字
		PACKET_MC_RENAME_ROLE_NAME_RET = 1214,			----- 角色修改名字返回
		PACKET_CM_RAND_ROLE_NAME = 1215,			----- 角色随机名字
		PACKET_MC_RAND_ROLE_NAME_RET = 1216,			----- 角色随机名字返回
		PACKET_CM_KICK_ROLE = 1217,			----- 踢掉玩家
		PACKET_MC_KICK_ROLE_RET = 1218,			----- 踢掉玩家返回
		PACKET_MC_ANNOUNCEMENT = 1219,			----- 公告及提示
		PACKET_CM_JUMP = 1220,			----- 跳跃
		PACKET_MC_JUMP_RET = 1221,			----- 跳跃返回
		PACKET_CM_DROP = 1222,			----- 降落
		PACKET_MC_DROP_RET = 1223,			----- 降落返回
		PACKET_CM_LAND = 1224,			----- 着陆
		PACKET_MC_LAND_RET = 1225,			----- 着陆返回
		PACKET_MC_RESET_POS = 1226,			----- 瞬移
		PACKET_MC_PLAYER_HEART = 1227,			----- 角色心跳
		PACKET_CM_PLAYER_HEART_RET = 1228,			----- 角色心跳返回
		PACKET_MC_ENTER_SCENE = 1229,			----- 通知角色已经可以进入场景
		PACKET_CM_OPEN_DYNAMIC_MAP = 1230,			----- 开启动态场景
		PACKET_MC_OPEN_DYNAMIC_MAP_RET = 1231,			----- 开启动态场景返回
		PACKET_CM_CHANGE_MAP = 1232,			----- 切换地图
		PACKET_MC_CHANGE_MAP_RET = 1233,			----- 切换地图返回
		PACKET_CM_DYNAMIC_MAP_LIST = 1234,			----- 动态地图列表
		PACKET_MC_DYNAMIC_MAP_LIST_RET = 1235,			----- 动态地图列表返回
		PACKET_MC_ATTACK_BROAD = 1300,			----- 攻击广播
		PACKET_MC_ATTACK_IMPACT = 1301,			----- 攻击效果
		PACKET_CM_BUFF_ARRAY = 1302,			----- 请求Buff列表
		PACKET_MC_BUFF_ARRAY_RET = 1303,			----- Buff列表返回
		PACKET_CM_VIEW_BUFF = 1304,			----- 查看单个Buff
		PACKET_MC_VIEW_BUFF_RET = 1305,			----- 查看单个Buff返回
		PACKET_MC_ADD_BUFFER = 1306,			----- 添加BUFFER
		PACKET_MC_DEL_BUFFER = 1307,			----- 删除BUFFER
		PACKET_MC_OBJ_ACTION_BAN = 1308,			----- 行为禁止标记改变
		PACKET_CM_FIGHT_FINISH = 1309,			----- 战斗完成
		PACKET_MC_FIGHT_FINISH_RET = 1310,			----- 战斗完成返回
		PACKET_CM_FIGHT_OPEN_CHAPTER = 1311,			----- 打开战斗关卡
		PACKET_MC_FIGHT_OPEN_CHAPTER_RET = 1312,			----- 打开战斗关卡返回
		PACKET_MC_ITEM_LIST = 1400,			----- 背包物品列表
		PACKET_MC_ADD_ITEM = 1401,			----- 主动添加物品操作
		PACKET_MC_DELETE_ITEM = 1402,			----- 主动删除物品操作
		PACKET_MC_UPDATE_ITEM = 1403,			----- 主动更新物品操作
		PACKET_MC_MOVE_ITEM = 1404,			----- 移动道具
		PACKET_MC_EXCHANGE_ITEM = 1405,			----- 交换道具
		PACKET_CM_BAG_BUY_GRID = 1406,			----- 请求购买背包格子
		PACKET_MC_BAG_BUY_GRID_RET = 1407,			----- 返回购买背包格子结果
		PACKET_MC_BAG_ADD_GRID = 1408,			----- 背包增加格子
		PACKET_CM_BAG_OPERATOR = 1409,			----- 请求使用、删除、出售、整理
		PACKET_MC_BAG_OPERATOR_RET = 1410,			----- 返回背包操作结果使用、删除、出售
		PACKET_MC_MISSION_UPDATE = 2900,			----- 更新任务列表
		PACKET_MC_MISSION_UPDATE_PARAMS = 2901,			----- 更新条件参数(当前杀怪数,当前物品数)
		PACKET_MC_MISSIONRE_DEL = 2902,			----- 删除一个任务
		PACKET_CM_MISSION_OPERATION = 2903,			----- 任务操作(领取或提交)
		PACKET_MC_MISSION_OPERATION_RET = 2904,			----- 任务操作返回(领取或提交)
		PACKET_CM_CHAT_REQ = 3000,			----- 聊天请求
		PACKET_MC_CHAT_RET = 3001,			----- 聊天回复
		PACKET_MC_CALLLBACKRETCODE = 3999,			----- 返回错误码
		PACKET_MC_BUFFER_TBL_DATA = 4000,			----- 表格数据
		PACKET_MC_CONSTANT_TBL_DATA = 4001,			----- 常量表数据
		PACKET_CM_EXCHANGE_GIFT_REQ = 4600,			----- 输入兑换号,兑换礼包
		PACKET_MC_EXCHANGE_GIFT_RET = 4601,			----- 兑换礼包返回
		PACKET_MC_TILI_INFO = 4602,			----- 增加体力
		PACKET_MC_ACTIVE_ADD = 4603,			----- 活动增加通知
		PACKET_MW_REGISTE = 31001,			----- 
		PACKET_WM_REGISTE_RET = 31002,			----- 
		PACKET_WM_CLOSE_SERVER = 31003,			----- 
		PACKET_WM_UPDATE_SERVER = 31004,			----- 
		PACKET_MW_UPDATE_SERVER = 31005,			----- 
		PACKET_MW_OPEN_SCENE = 31006,			----- 
		PACKET_MW_CLOSE_SCENE = 31007,			----- 
		PACKET_MW_BROAD = 31101,			----- 
		PACKET_MW_TRANS = 31102,			----- 
		PACKET_WM_TRANS_ERROR = 31103,			----- 
		PACKET_MW_TRANS_TO_WORLD = 31104,			----- 
		PACKET_WM_BROAD = 31105,			----- 
		PACKET_WM_LOAD_ROLE_DATA = 31201,			----- 请求加载角色数据
		PACKET_MW_LOAD_ROLE_DATA_RET = 31202,			----- 加载数据返回
		PACKET_WM_UNLOAD_ROLE_DATA = 31203,			----- 请求释放角色数据
		PACKET_MW_UNLOAD_ROLE_DATA_RET = 31204,			----- 释放数据返回
		PACKET_MW_ROLE_QUIT = 31205,			----- 角色请求退出游戏
		PACKET_MW_ROLE_KICK = 31206,			----- 踢掉角色
		PACKET_MW_ROLE_HEART = 31207,			----- 角色心跳
		PACKET_WM_ROLE_HEART_RET = 31208,			----- 角色心跳返回
		PACKET_WM_USER_UPDATE = 31209,			----- 更新user数据到MapServer
		PACKET_MW_ROLE_UPDATE = 31210,			----- 更新role数据到WorldServer
		PACKET_MW_USER_LOGIN = 31211,			----- 角色登陆
		PACKET_MW_CHANGE_LINE = 31212,			----- 切线请求
		PACKET_WM_CHANGE_LINE_RET = 31213,			----- 切线请求返回
		PACKET_WM_CHANGE_LINE = 31214,			----- 通知切换场景
		PACKET_MW_RAND_ROLE_NAME = 31215,			----- 随机角色名字
		PACKET_WM_RAND_ROLE_NAME_RET = 31216,			----- 随机角色名字返回
		PACKET_MW_RENAME_ROLE_NAME = 31217,			----- 随机角色名字
		PACKET_WM_RENAME_ROLE_NAME_RET = 31218,			----- 随机角色名字返回
		PACKET_MW_GET_RAND_NAME_LIST = 31219,			----- 得到随机名字列表
		PACKET_WM_GET_RAND_NAME_LIST_RET = 31220,			----- 得到随机名字列表返回
		PACKET_MW_EXCHANGE_GIFT_REQ = 31238,			----- 玩家兑换礼包请求
		PACKET_WM_EXCHANGE_GIFT_RET = 31239,			----- 玩家兑换礼包回复
		PACKET_WM_LIMIT_ACCOUNT_INFO = 31241,			----- 封号信息
		PACKET_WM_LIMIT_CHAT_INFO = 31242,			----- 禁言信息
		PACKET_MW_LIMIT_INFO_REQ = 31243,			----- 通知世界服务，玩家已进入游戏，转发限号信息
		PACKET_WM_SERVER_INFO = 31244,			----- 区服信息
		PACKET_WM_AWARD_BIND_RMB = 31245,			----- 绑定元宝
		PACKET_MW_ANNOUNCEMENT = 31246,			----- 服务器公告
		PACKET_MM_CHANGE_SCENE = 31252,			----- 通知其他玩家切换到目标场景
		PACKET_MR_RECORDE = 31400,			----- 地图服务器到日志服务器
		PACKET_WR_RECORDE = 31401,			----- 世界服务器到日志服务器
		PACKET_RR_RECORDE = 31404,			----- 日志服务器到主日志服务器
		PACKET_PS_REQUEST = 31402,			----- 管理服务器到日志服务器
		PACKET_SP_RESPONSE = 31403,			----- 日志服务器到管理服务器
		PACKET_RW_SERVER_INFO = 31405,			----- 请求服务器信息RecordeServer--WorldServer
		PACKET_WR_SERVER_INFO_RET = 31406,			----- 请求服务器信息返回WorldServer--RecordeServer
		PACKET_GP_REQUEST = 31407,			----- 资源服务器资源请求
		PACKET_PG_RESPONSE = 31408,			----- 资源服务器资源响应
		PACKET_BR_RECORDE = 31409,			----- 充值服务器日志
		PACKET_WL_REGIST = 31500,			----- 世界服务器注册到登陆服务器
		PACKET_LW_REGIST_RET = 31501,			----- 世界服务器注册到登陆服务器返回
		PACKET_WL_ROLE_LOGIN = 31502,			----- 角色登陆
		PACKET_LW_ROLE_LOGIN_RET = 31503,			----- 角色登陆返回
		PACKET_WL_ROLE_CREATE = 31504,			----- 角色创建
		PACKET_LW_ROLE_CREATR_RET = 31505,			----- 角色创建返回
		PACKET_WL_DATA_UPDATE = 31506,			----- 数据更新
		PACKET_LW_LIMIT_INFO_UPDATE = 31507,			----- 限号信息更新
		PACKET_LW_LIMIT_ACCOUNT_INFO = 31508,			----- 限号信息
		PACKET_LW_LIMIT_CHAT_INFO = 31509,			----- 限号信息
		PACKET_WL_LIMIT_INFO_REQ = 31510,			----- 发送限制请求
		PACKET_XM_REGISTE = 32000,			----- 服务器注册到管理服务器
		PACKET_MX_REGISTE_RET = 32001,			----- 服务器注册到管理服务器返回
		PACKET_WB_REGISTE = 32100,			----- 世界服务器注册
		PACKET_BW_REGISTE_RET = 32101,			----- 世界服务器注册返回
		PACKET_BW_RECHARGE = 32102,			----- 充值
		PACKET_WB_RECHARGE_RET = 32103,			----- 充值返回
		PACKET_WM_RECHARGE = 32104,			----- 充值
		PACKET_MW_RECHARGE_RET = 32105,			----- 充值返回
};
-------------------------------------------------------
-- @class enum
-- @name EGmPowerLevel
-- @description 
-- @usage 
EGmPowerLevel = {
		GM_POWER_INVALID = 0,			----- 
		GM_POWER_LEVEL_1 = 1,			----- 
		GM_POWER_LEVEL_2 = 2,			----- 
		GM_POWER_LEVEL_3 = 3,			----- 
		GM_POWER_LEVEL_4 = 4,			----- 
		GM_POWER_LEVEL_5 = 5,			----- 
		GM_POWER_DEBUG = 6,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EMoneyRecordTouchType
-- @description 
-- @usage 
EMoneyRecordTouchType = {
		MONEYRECORDDEFINE = 0,			----- 
		MALL_BUYITEM = 1,			----- 
		OPEN_BAGGUID = 2,			----- 
		LEVELRAWARD = 3,			----- 
		RECORD_SELL_ITEM = 4,			----- 
		RECORD_NEW_ROLE_AWARD = 5,			----- 
		RECORD_COMPENSATE_RMB = 6,			----- 
		RECORD_NEW_ROLE_RMB = 7,			----- 
		RECORD_MISSION_AWARD = 22,			----- 
		MONEY_GM = 250,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EItemRecordType
-- @description 
-- @usage 
EItemRecordType = {
		ITEM_RECORD_DEFAULT = 0,			----- 
		ITEM_RECORD_MALL_BUY = 1,			----- 
		ITEM_RECORD_USE_ITEM = 2,			----- 
		ITEM_RECORD_NEW_ROLE = 3,			----- 
		ITEM_RECORD_EXCHANGE_GIFT = 4,			----- 
		ITEM_RECORD_DROP = 5,			----- 
		ITEM_RECORD_ITEM_GM = 250,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EManagerQueType
-- @description 
-- @usage 
EManagerQueType = {
		MGR_QUE_TYPE_INVALID = 0,			----- 
		MGR_QUE_TYPE_READY = 1,			----- 
		MGR_QUE_TYPE_ENTER = 2,			----- 
		MGR_QUE_TYPE_LOGOUT = 3,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EUserFlag
-- @description 
-- @usage 
EUserFlag = {
		USER_FLAG_START_NUM = 0,			----- 
		USER_FLAG_MAX_NUMBER = 255,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EScanReturn
-- @description 
-- @usage 
EScanReturn = {
		SCAN_RETURN_CONTINUE = 0,			----- 
		SCAN_RETURN_BREAK = 1,			----- 
		SCAN_RETURN_RETURN = 2,			----- 
		SCAN_RETURN_NUMBER = 3,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EImpactType
-- @description 
-- @usage 
EImpactType = {
		IMPACT_TYPE_ME = 1,			----- 
		IMPACT_TYPE_OTHER = 2,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name ETransCode
-- @description 
-- @usage 
ETransCode = {
		TRANS_CODE_CONTINUE = 0,			----- 
		TRANS_CODE_STOP = 1,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EMapDataBlockFlag
-- @description 
-- @usage 
EMapDataBlockFlag = {
		BLOCK_FLAG_WALK = 1,			----- 
		BLOCK_FLAG_TRANSPARENT = 2,			----- 
		BLOCK_FLAG_SKILL = 4,			----- 
		BLOCK_FLAG_BATTLE = 8,			----- 
		BLOCK_FLAG_SAFE_ZONE = 16,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EDbgOption
-- @description 
-- @usage 
EDbgOption = {
		DBG_OPTION_ENTER_VIEW = 0,			----- 
};
-------------------------------------------------------
-- @class enum
-- @name EMapServerInitFlag
-- @description 
-- @usage 
EMapServerInitFlag = {
		MAP_SVR_INIT_FLAG_DB_INIT = 0,			----- 
		MAP_SVR_INIT_FLAG_WORLD_REGISTE = 1,			----- 
		MAP_SVR_INIT_FLAG_SERVICE_START = 2,			----- 
};
