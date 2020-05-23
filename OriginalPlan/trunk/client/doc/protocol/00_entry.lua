-- 所有的结构体定义
local entryCfg = {
    platformInfo = {
        {"serverId", "int32"}
        ,{"serverName", "string"}
        ,{"status", "int8"} -- 服务器状态 0-停服维护 1-火爆 2-顺畅 3-只有GM可以进去
    },

	loginLog = {    -- 账号登陆日志
        {"serverId", "int16"}
        ,{"last_visit_time", "int32"}
    },

    role={
        {"roleId","int64"}      -- 战队ID
        ,{"name","string"}      -- 战队名字
        ,{"lev", "int16"}       -- 战队等级
        ,{"exp", "int16"}       -- 战队经验
        ,{"gold", "int32"}      -- 钻石
        ,{"coin", "int32"}      -- 金币
        ,{"energy", "int16"}    -- 体力
        ,{"instPoint", "int8"} -- 技能点
        ,{"faceID", "int16"}    -- 头像ID
        ,{"vipLev", "int8"}     -- vip等级
        ,{"totalChargeGold", "int32"}    -- 总充值元宝数
		,{"guildId","int16"} --- 工会ID
		,{"guildPost","int8"} ---工会职务 ，1：会长 2：长老，3：会员
        ,{"arenaCoin", "int32"} -- 竞技场币
		,{"guildName","string"} --公会名字
		,{"guildCoin","int32"} --公会币
        ,{"stoneEnergy", "int32"}   -- 符石能量
        ,{"role_skill_point", "int32"}              --战队技能点
        ,{'bombPoint','int32'}
        ,{'urge', "int32"}      -- 勇气值
        ,{'camp','int8'}    --阵营值
		,{"live","int16"} -- 活跃度
        ,{"prestige", "int32"}  --功勋
		,{"renown", "int32"}--声望
		,{"crystal","int32"}	-- 水晶
		,{"iron","int32"}	-- 铁
		,{"uranium", "int32"}  -- 铀
        ,{"guildSupportNum", "int16"}   -- 昨日被膜拜次数
		,{"supportTimes","uint8"}           --今日膜拜别人多少次了
        ,{"max_power", "int32"}             -- 历史最高战力
        ,{"power_vip", "int8"}              -- 军阶
		,{"vigour","uint16"}   --精力
        ,{"feats", "uint32"}    -- 战功
        ,{"realServerID", "int16"}  -- 真实的服务器ID
    },

    otherRoleInfo = {
        {"roleId", "int64"},
        {"name", "string"},
        {"lev", "int16"},
        {"faceId", "int16"},
        {"vipLev", "int16"},
        {"guildID", "int64"},
        {"guildName", "string"},
        {"guildPost", "int8"},
        {"pos", "wildernessPos"},
        {"fightValue", "int32"},
        {"max_power", "int32"},
        {"power_vip", "int8"},
		{"relation","uint8"}  -- 0 --没任何关系  1 好友   2 陌生人  3 在自己的黑名单   4 在对方的黑名单
    },

    itemInfo={
        {"itemID", "uint16"}
        ,{"itemNum", "int32"}
    },
	
	rechgePrivgeInfo = {
		{"day","uint8"}, 					--第几天
		{"condition_desc","string"}, 		--条件描述
		{"item", "array", "type_item"},  	--奖励的物品
		{"isDraw","uint8"} 					-- 1是已经充值为领取; 2是已经充值已经领取; 3是未充值； 4已过期； 5还未到时间
	},
	
	seven_coin_info = {
		{"day","uint8"},				-- 第几天
		{"status","uint8"},				-- 1.可签到 2.已经签到 3.未到期 4.未签到
		{"num","uint8"}					-- 数量
	},
	
	daily_charge = {
		{"index", "uint8"},				-- 索引
		{"index_titile", "string"},
		{"reward","array","type_item"},
		{"status", "uint8"},			-- 2.已邮件发送 3.未可领取
		{"finishCount","uint32"},		-- 完成次数
		{"needCount","uint32"}			-- 需要次数
	},
	
	collect_item = {
		{"index","int8"},
		{"cost_items", "array", "type_item"},
		{"reward_items","array","type_item"},
		{"max_num","int16"},	-- 最大次数
		{"use_num","int16"}		-- 已买次数
	},
	
	fortune_gold = {
		{"index","int8"},		-- 最大次数
		{"cost_gold","int32"},	-- 消耗元宝
		{"max_gold","int32"},	-- 最大元宝
		{"vip_lev","int8"},		-- Vip限制
	},
	
	fun_act_record = {
		{"name", "string"},
		{"reward", "type_item"}
	},
	
	type_item = {		-- 不同类型物品
		{"type", "int8"}, 	-- 1 物品 3 金币 4 钻石
		{"itemID", "int32"}, -- type 为1时 才有效
		{"itemCount","int32"}
	},
	
    roleItem = {
        {"uid", "int32"},
        {"itemID", "uint16"},
        {"itemNum", "int32"},
		{"new", "int8"}, --1表示是新获得物品, 0表示旧物品
		{"star", "int8"},--装备当前星级
		{"slev", "int8"},--装备强化等级
		{"sexp", "int32"}--装备强化经验
    },

	eqmInfo = {
		{"itemID", "int32"},
		{"star", "int8"},--装备当前星级
		{"slev", "int8"},--装备强化等级
	},

    dropInfo={
        {"drop_id", "uint16"}                -- 掉落ID, 0-基础掉落, 其他-特殊掉落
        ,{"items", "array", "itemInfo"}
    },

    bossDropInfo = {
        {"monsterID", "uint32"}
        ,{"items", "array", "itemInfo"}
    },

    dropItemInfo = {
        {"itemID", "uint16"}
        ,{"itemNum", "int32"}
        ,{"itemCount", "uint16"}    --表示这是背包中的第几个物品,比如扫荡前有5个该物品,现在扫到了1个,则itemCount为6,若扫到了2个，则itemCount为7
        ,{'isLucky', 'int8'}  --是否幸运物品,0表示否,1表示是
    },

    quickFinishDropInfo = {
        {"times", "uint8"}
        ,{"dropInfo", "array", "dropItemInfo"}
    },

    fightPlayer={
        {"id","uint32"} --id
        ,{"name","string"}
    },

---------------------------------------------------------------副本相关-------------------------------------
    -- 副本信息
    dungeonInfo={
        {"dungeonId", "uint32"}
        ,{"star", "int8"}
        ,{"times", "int8"}          -- 今日已挑战次数-1 表示没有次数限制
		,{"cleanCDTimes","uint8"}   --今日已清除副本CD次数
        ,{"buyNum", "uint8"}        -- 今日重置副本次数 
        ,{"myMinTime", "uint8"}
        ,{"min_power_role_name", "string"}
        ,{"min_power", "int32"}
        ,{"min_power_message", "string"}
        ,{"min_time_role_name", "string"}
        ,{"min_time", "int32"}
        ,{"min_time_role_power", "int32"}
        ,{"min_time_message", "string"}
    },

	--cd信息
	dungeonCDInfo ={
		{"id","uint16"}
		,{"time","uint32"}   --下次cd结束的服务器时间   0表示无cd,
	},
	--服务器 怪物
	serverMonster={
		{"uId","uint16"},
		{"monsterId","uint32"}
	},
--------------------------------------------------------------------------------------------------------

    eqm = {
        {"pos", "int8"}                 -- 装备位置
        ,{"uid", "int32"}               -- 装备(物品)唯一ID
    },

    skill = {                           -- 英雄技能
        {"id", "uint16"}
        ,{"lev", "uint8"}
    },

    soulExChangeItem = {
        {'soulId','int32'}, --打开该宝箱所需要的灵魂石id
        {'count','int16'}, --需要的灵魂石数
        {'type','uint8'}, --宝箱类型,用1，2，3分别表示小中大宝箱
        {'beOpened','uint8'}, --该宝箱是否已经开启,1表示是,0表示否
    },
	leaderAttr = {
        {"index", "int8"}
		,{"type","int8"}
		,{"value","int16"}
	},
	leader={
		{"id", "uint16"},
		{"lev", "int16"},
		{"exp", "int32"},
		{"star", "int8"},
		{"attrs", "array", "leaderAttr"} --副属性列表
	},
    hero_inst = {
        {"id", "uint8"},
        {"lev", "uint8"}
    },

    adjunct = {
        {"adjunctID", "uint16"},                 -- 配件ID
        {"adjunct_add_list", "array", "uint16"}  -- 增强物品ID列表
    },

    hero = {
        {"heroID", "uint16"}                    -- 英雄ID
        ,{"lev", "int16"}                       -- 英雄等级
        ,{"exp", "int16"}                       -- 英雄经验
        ,{"quality", "int8"}                    -- 英雄品级
		,{"equality", "int8"}					-- 英雄精英品级
        ,{"eqmList", "array", "int32"}          -- 装备列表
        ,{"inst_list", "array", "hero_inst"}    -- 研究院数据
        ,{"num", "int8"}                        -- 生产的数量
        ,{"max_num", "int8"}                    -- 编制
        ,{"adjunct_list", "array", "adjunct"}   -- 配件列表
        ,{"star", "int8"}                       -- 星级
        ,{"starExp", "uint16"}                    -- 星级经验
    },

	fightHero={  --战斗的英雄信息
        {"heroID", "uint16"}             -- 英雄ID
        ,{"lev", "int16"}               -- 英雄等级
        ,{"quality", "int8"}            -- 英雄品级
		,{"equality","int8"}     --精英进阶
		,{"attrList", "array", "attrInfo"}    -- 属性列表
        ,{"num", "int8"}                -- 英雄数量
	},

	attrInfo = {
		{"type", "int8"}
		,{"value", "int32"}
	},

    taskProcess = {     -- 任务进度信息
        {"finish_count", "int32"}
        ,{"need_count", "int32"}
    },

    taskInfo = {        -- 任务信息
        {"taskID", "int16"}
        ,{"taskProcess", "array", "taskProcess"}
    },
	tipInfo = {
		{"id","uint32"}
		,{"status","int8"}   --状态  1未完成  2已完成  3已领取   
		,{"num","uint8"}  --进度						
	},

    actInfo = {
        {"actID", "int16"}
        ,{"finishCount", "int32"}  --针对月卡特殊处理(最大天数×10000+已经领取天数)
        ,{"isDraw", "int8"}     -- 2-已经领取了 1-未领取
    },
	
	limit_shop = {
		{"index", "int16"},			-- 索引
		{"item_id","int32"},		-- 物品ID
		{"item_num","int16"},		-- 物品数量
		{"limit_num","int16"},		-- 限制数量
		{"price", "int16"},			-- 现价
		{"reprice","int16"},		-- 原价
		{"has_buy_num", "int16"}, 	-- 已买数量
		{"vip","int8"},
		{"titile", "string"}
	},

	live_draw_num = {
		{"num", "int8"}	-- 已领取第几个活跃度奖励
	},
    roleAttr = { -- 角色单个属性
        -- Key:
        -- 1-铜钱
        -- 2-元宝
        -- 3-体力
        -- 4-战队等级
        -- 5-战队经验
        -- 6-技能点
        -- 7-vip等级
        -- 8-总充值元宝数
		-- 9-工会ID
		--10-工会职务
        --11-竞技场币
        --12-工会币
        --13-符石能量
        --14-目前好友数
        --15-目前已接受赠礼次数
        --16-玩家自己的最近三日活跃度
        --17-战队技能点
        --18-炮弹值
        --19-公会点数
        --20-勇气值
        --21-功勋值
		--23-活跃度
        --24-研究院点数
        --25-声望
        --26-军团贡献值
        --27-水晶
        --28-铁
        --29-铀
        --30-军阶
        --31-历史最高战力
		--32-精力
        --33-野外功勋
        {"key", "int8"}
        ,{"value", "int32"}
    },

    gold2coinLog = {    -- 点金石日志
        {"gold", "uint8"}    -- 消耗元宝
        ,{"coin", "int32"}  -- 获得铜钱
        ,{"multiply", "int8"}   -- 倍率
    },

    -- -- 邮件信息
    -- mailInfo = {
    --     {"mailID", "int32"}                                -- 邮件ID
    --     ,{"sendRoleId", "int64"}                           -- 发件人ID
    --     ,{"sendRoleName", "string"}                        -- 发件人名字
    --     ,{"sendTime", "int32"}                             -- 发送时间
    --     ,{"receiveRoleId", "int64"}                        -- 接收人ID
    --     ,{"receiveRoleName", "string"}                     -- 接收人名字
    --     ,{"title", "string"}                               -- 邮件标题
    --     ,{"content", "string"}                             -- 邮件内容
    --     ,{"affixInfo", "affix_info"}                       -- 附件信息
    -- },
    mailHeader = {
    {"mailID", "int64"}                                -- 邮件ID
    ,{"sendRoleId", "int64"}                           -- 发件人ID
    ,{"sendRoleName", "string"}                        -- 发件人名字
    ,{"sendTime", "int32"}                             -- 发送时间
    ,{"receiveRoleId", "int64"}                        -- 接收人ID
    ,{"receiveRoleName", "string"}                     -- 接收人名字
    ,{"title", "string"}                               -- 邮件标题
    ,{"etype", "uint8"}                                -- 邮件类型
    ,{"hasRead", "int8"}                                -- 邮件是否已读, 1表示已读， 0表示未读
    ,{"hasAffix", "int8"}                              -- 是否有附件。  1表示有附件， 0表示无附件
    ,{"hasGetAffix", "int8"}                           -- 是否已领取附件, 1 已领取，0 未领取
    },
    mailContent = {
        {"mailID", "int64"}                                -- 邮件ID
        ,{"content", "string"}                             -- 邮件内容
        ,{"affixInfo", "affix_info"}     -- 附件信息
		,{"heroID", "int16"}
    },
    --邮件附件信息
    affix_info = {
        {"goldCount", "int32"}                             -- 金币数量
        ,{"diamondCount", "int32"}                         -- 钻石数量
        ,{"arenaCoin", "int32"}							   -- 竞技场币
        ,{"unionCoin", "int32"}                            -- 工会币
        ,{"prestige", "int32"}                             -- 功勋值
        ,{"affixItem", "array" ,"affix_item_list"}         -- 物品信息
    },
    affix_item_list = {
        {"goodsID", "uint16"}                              -- 物品ID
        ,{"goodsCount", "int16"}                           -- 物品数量
    },

    -- 宝箱抽取物品
    itemsInfo = {
            {"itemId", "int32"} --type为1表示物品id，2表示英雄id，3,4表示无意义
            ,{"count", "int32"}
            ,{"type", "int8"}   -- 1 物品 2 英雄 3 金币 4 钻石
			,{"soulId","int32"} -- 如果是英雄且玩家已有改英雄，则soulid的改英雄的灵魂石的物品id值，否则soulid为-1
			,{"soulCount","int16"} --灵魂石数量，没有为-1
    },

	chatInfo={
		{"roleId", "int64"} --发送者的 
        ,{"name", "string"}  -- 发送者的
		,{"receiveId", "int64"}
        ,{"receiverName", "string"}
        ,{"content", "string"}
		,{"time", "uint32"}  --- 
		,{"faceId", "int16"}  --发送者的
		,{"level", "int8"}   --发送者的
        ,{"ipAddr", "string"} -- IP地址
        ,{"vip", "int8"}    -- vip等级
        ,{"power_vip", "int8"}   -- 军阶

	},
	
	charge_award_info = {
		{"day", "uint8"},
		{"status","uint8"}, -- 1.可领取 2.已经领取 3.未可领取 4.已充值但未到时间
		{"reward","array","type_item"}
	},
	
	messageInfo = {
		{"roleId", "int64"} --发送者的 
        ,{"name", "string"}  -- 发送者的
        ,{"content", "string"}
		,{"time", "uint32"}  --- 
		,{"faceId", "int16"}  --发送者的
		,{"level", "int8"}   --发送者的
        ,{"ipAddr", "string"} -- IP地址
        ,{"vip", "int8"}    -- vip等级
        ,{"power_vip", "int8"}   -- 军阶
	},

    heroAttr = {
        -- 1-50 英雄属性(预留50个够了吧)
        -- 51 - 英雄等级
        -- 52 - 英雄经验
        -- 53 - 英雄星级
        -- 54 - 英雄品阶
        {"attrType", "int8"}
        ,{"attrVal", "int32"}
    },

    arenaRole = {
        {"roleID", "int64"}
        ,{"roleName", "string"}
        ,{"rank", "int32"}
        ,{"faceID", "int16"}
        ,{"lev", "uint8"}
        ,{"power", "int32"}
		,{"guildName","string"} --公会名字 没有工会时值为""空字符串
        ,{"winCount", "int16"}
    },

    arenaRecord = {
         {"roleID", "int64"}
        ,{"name", "string"}
        ,{"faceID","int16"}
		,{"fight","int8"}---战斗类型，1是挑战，2是失败
        ,{"win", "int8"}---胜利的标志，1是胜利，0是失败
        ,{"rank", "int16"} --胜负落差，都是正式，根据胜负标志来判断升了还是降了
        ,{"level","int8"}
        ,{"time","int32"} --当时挑战的时间戳
    },

    heroBaseInfo ={
       {"heroID","uint16"}
       ,{"lev", "int8"}
	   ,{"quality","int8"} --英雄的品级
    },

	matrixHero ={  --英雄站位
		{"heroId","uint16"} --英雄id
		,{"num","uint8"} -- 数量
	},

	tacticHero={
		 -- 系统类型
		 --1、普通副本站位   2.竞技场防守站位  3.竞技场进攻站位
		 --4  军团副本 超时空  5- 世界boss  6--抵御入侵  7 --金库副本 
         --8 军团训练
		{"fightType", "uint8"}
        ,{"heroList", "array", "matrixHero"}
	},

    arenaRank = {
        {"roleID", "int64"}
        ,{"roleName", "string"}
        ,{"faceID", "int16"}
        ,{"rank", "int8"}
        ,{"lev", "int8"}
        ,{"power","int32"}
        ,{"win", "int16"}
        ,{"unionName","string"}
    },

    shopRequest = {
        {"type", "int8"},
        {"value", "int32"}
    },

    itemslist = {
        {"pos", "int8"}
        ,{"itemID", "int32"}
        ,{"count", "int32"}
        ,{"price", "int32"}
        ,{"priceType", "int8"} --货币类型，1表示金币，2代表钻石，后面有需求再加
        ,{"maxBuyTimes", "int8"}    -- 当天最大购买次数
        ,{"buyTimes", "int8"}       -- 当前购买次数
        ,{"requestList", "array", "shopRequest"}
        ,{"maxAccBuyTimes", "int32"}    -- 累计最大购买次数
        ,{"accBuyTimes", "int32"}       -- 累计购买次数
    },

    randShopItem = {
        {"pos", "int8"}
        ,{"itemID", "int32"}
        ,{"count", "int32"}
        ,{"price", "int32"}
        ,{"priceType", "int8"}      --货币类型，1表示金币，2代表钻石，后面有需求再加
        ,{"maxBuyTimes", "int8"}    -- 当天最大购买次数
        ,{"buyTimes", "int8"}       -- 当前购买次数
        ,{"requestList", "array", "shopRequest"}
        ,{"maxAccBuyTimes", "int32"}    -- 累计最大购买次数
        ,{"accBuyTimes", "int32"}       -- 累计购买次数
        ,{"isBuy", "uint8"}         -- 是否已经购买了
    },

    matrix = {
        {"pos", "int8"}
        ,{"heroID", "uint16"}
    },
	guildInfo = {
	    {"guildID","int64"}
		,{"iconID","int16"}
		,{"name","string"}
		,{"roleCount","int16"}
		,{"max_member","int16"}
		,{"exp","int32"}		--公会经验
		,{"needLevel","int8"}  	--加入需要的等级
		,{"needApprove","int8"} --是否需要批准才可以加入
		,{"is_apply","int8"}	-- 是否申请 0:还未申请 1:已经申请过了
	},
	
	myguildInfo = {
	    {"guildID","int64"}
		,{"iconID","int16"}
		,{"name","string"}
		,{"roleCount","int16"}
		,{"max_member","int16"}
		,{"rank","int16"}		--公会排名
		,{"exp","int32"}		--公会经验
		,{"member_exp","int32"}	--成员贡献值
		,{"notice","string"} 	---工会宣言
		,{"needLevel","int8"}  	--加入需要的等级
		,{"needApprove","int8"} --是否需要批准才可以加入
		,{"get_reward","int8"}  --是否可以领俸禄， 0 否 1 是
	},

	
    guildRank = {
		{"rank","int16"},
        {"guildID", "int64"},
        {"iconID", "int16"},
        {"name", "string"},
        {"exp", "int32"},
		{"roleCount","int16"},			--公会成员数
		{"max_member","int16"},			-- 最大成员数
        {"leaderID", "int64"},
        {"leaderName", "string"}
    },
	
	union_tech = {
		{"tech_id","int32"},	--  科技ID
		{"tech_exp","int32"},	--  科技积分
		{"tech_lev", "int32"}   --  科技等级
	},
	
	union_build ={
		{"role_id","int64"},
		{"faceID","int16"},
		{"role_level","int16"},
		{"role_name","string"},
		{"buildID","int8"},
		{"build_lev","int16"},  -- 建筑等级
		{"help_num","int16"},  	-- 已经帮助次数
	},
	
	train_info = {
		{"train_id", "int16"},
		{"dungeonID", "uint32"},	-- 为0时候为全通奖励
		{"status", "int8"},	-- 0 未完成 1 可领取 2 已领取 
		{"bad_populace", "int16"} 	-- 损坏的统率率
	},
	
	train_hero = {
		{"id", "int32"},
		{"num","uint8"}
	},
	
	train_reward_record = {
		{"role_name", "string"},
		{"reward_list", "array", "type_item"}
	},

	train_pass_record = {
		{"role_name", "string"},
		{"dungeonID", "uint32"},
		{"time", "int32"}
	},
	
	train_hurt_record = {
		{"role_name", "string"},
		{"faceID", "int16"},
		{"level", "int8"},
		{"fight_times", "uint8"},
		{"hurt", "uint32"},
		{"rank","int16"}
	},
	
	aggressRank = {
		{"roleId","int64"},
		{"rank", "int16"},		-- 排名
		{"faceID", "int8"},	 	-- 头像
		{"level", "int8"},		-- 等级
		{"name","string"},		-- 名字
		{"score", "int32"}, 	-- 积分
		{"unionName","string"}  -- 军团名字
	},

	guildMember = {
		{"roleID","int64"}
		,{"faceId","int16"}
		,{"name","string"}
		,{"level","int8"}
		,{"fight","int32"}			--战斗力
		,{"position","int8"}        --职位
		,{"contribution","int32"}	--最近三日贡献
        ,{"supportNum", "int16"}    --被膜拜次数
	},

    guildRankMember = {
        {"guildMember", "guildMember", true},
        {"fightValue", "int32"},
    },

	--公会需要会长审批才能加入的玩家信息
	guildApprovalInfo =
	{
		{"roleID","int64"},
		{"headID","int16"},
		{"level","uint8"},
		{"fight","int16"},			--战斗力
		{"name","string"}
	},

	heroNumInfo = {   --英雄库存
        {"heroID", "uint32"}    -- 英雄
        ,{"num", "uint8"}          -- 数量
    },
	monsterNumInfo = {
		{"id","int32"},
		{"num","int16"}
	},

    maxUnionDungeonInfo = {         -- 帮会副本中最大进度信息
        {"dungeonID", "uint32"}     -- 副本ID
        ,{"roleID", "int64"}        -- 角色ID
        ,{"roleName", "string"}     -- 角色名字
		,{"level","uint8"}  --等级
    },

    boxInfo = {
        {"boxID", "uint8"}
        ,{"status", "int8"} -- 0-没有开启 1-开启普通 2-开启vip
    },

    stoneDisc = {   -- 符石圆盘
        {"pos", "int8"}         -- 位置
        ,{"itemID", "uint16"}   -- 物品ID
        ,{"is_have", "int8"}    -- 是否已经有了 1-有 0-没有
    },

    stoneRect = {   -- 符石竖型
        {"pos", "int8"}         -- 位置
        ,{"itemID", "uint16"}    -- 物品ID
        ,{"is_used", "int8"}    -- 是否已经使用了 1-是 0-否
    },

    stoneInfo = {   -- 符石信息
        {"pos", "int8"}
        ,{"itemID", "uint16"}
        ,{"exp", "int16"}
        ,{"lev", "int8"}
    },

    --世界BOSS相关
    --英雄列表
    heroInfo = {
        {"heroID", "int32"}
        ,{"lev", "int16"}                               --等级
        ,{"star", "int8"}                               --星级
		,{"quality", "int8"}                               --品阶
        },


    --排名信息
    rank_list = {
        {"roleId", "int64"}                            --角色ID
        ,{"name", "string"}                             --名字
        ,{"lev", "int16"}                               --等级
        ,{"faceID", "int16"}                            --头像ID
		,{"fight", "int32"}                             --战斗力
        ,{"rank", "int16"}                              -- 排名
        ,{"hurt", "int32"}                              -- 伤害
        ,{"union_name", "string"}                       --公会名字
    },
	
    w_guild_rank_list = {
        {"role_id", "int64"}                            --角色ID
        ,{"name", "string"}                             --名字
        ,{"lev", "int16"}                               --等级
        ,{"faceID", "int16"}                            --头像ID
        ,{"hurt", "int32"}                              --伤害
		,{"fight", "int32"}                              --战斗力
    },
	
	w_guild_rank = {
        {"rank", "int16"}                              -- 排名
        ,{"name", "string"}                             --公会名字
        ,{"lev", "int16"}                               --等级
        ,{"leader", "string"}                             --团长 
        ,{"memberNum", "int16"}                 --成员数 
        ,{"hurt", "int32"}                          --总伤害 
	},
	
	
	powerRank = {
		{"roleId","int64"}
		,{"rank","int16"}
		,{"name","string"}
		,{"faceID","int16"}
		,{"power","int64"}
		,{"union_name","string"}	
		,{"level","int16"}
	},
	

    sign_7 = {
        {"day", "int8"},        -- 签到天数
        {"is_sign", "int8"}     -- 1-已经签到 2-可签但没签 3-过期了 4-时间还没有到
    },

    sign = {
        {"day", "int8"},
        {"gold", "int32"},
        {"coin", "int32"},
        {"itemList", "array", "itemInfo"},
		{"vipLevel", "int32"}		--vip等级，0为没有双倍，大于等于vip等级双倍
    },

    starProc = {{"chapter", "uint8"},        -- 副本章节
        {"dungeonType", "uint8"},    -- 副本类型
        {"drawed", "array", "uint8"} -- 已经领取的章节
    },

    stoneAttack = { -- 抢夺列表
        {"roleId", "int64"},
        {"roleName", "string"},
		{"guild", "string"},
        {"headId", "int16"},
        {"lev", "int16"},
    },

    stoneLossRecord = { -- 被抢记录
        {"id", "uint8"},
        {"roleId", "int64"},
        {"roleName", "string"},
        {"headId", "int16"},
        {"lev", "int16"},
        {"unionName", "string"},
        {"unixTime", "int32"},
        {"lossItemID", "uint16"},
        {"isDraw", "int8"},
    },

    chargeShop = {
        {"gold", "int16"}               -- 元宝
        ,{"type", "int8"}               -- 0-普通 1-月卡
        ,{"name", "string"}             -- 名称
        ,{"icon", "int32"}              -- 图标
        ,{"money", "string"}            -- 价格
        ,{"is_bought", "int8"}          -- 是否已经购买过
        ,{"first_extra_gold", "int32"}  -- 首次购买赠送
        ,{"extra_gold", "int32"}        -- 每次购买赠送
        ,{"sustain_days", "int32"}          -- 持续天数
		,{"CNY", "uint32"}				-- 充值rmb元数目
        ,{"hot", "uint8"}               -- 是否热卖 1-是 0-否
    },

    fun_act_header = {
        {"id", "int32"}             -- 活动唯一ID
		,{'name','string'}			-- 活动名称
        ,{"type", "int8"}       	-- 活动类型:
        ,{"begin_time", "int32"}    -- 开始时间
        ,{"end_time", "int32"}      -- 结束时间
		,{'icon', 'int32'}
        --,{"status", "int8"}         -- 状态 0-正常 1-暂停 2-停止 1,2为非正常状态,是后台手动关闭的,不发奖励
    },
	fun_act_content = {
		{"summary", "string"},
		{"list", "array", "fun_act_item"},
	},
	reward_item = {--{coin=50002, gold=50001,exp=50003,arena=50004,guild=50005,live=50006,reputation=50007}
		{"type", "int32"}, --类型. -1钻石 ,-2金币,-3经验,-4竞技场币,-5工会币,-6体力,-7功勋值, 功勋值, 大于0为物品id
		{"num", "int32"},
	}
	,
	fun_act_item = {
		{"index", "int8"},--索引
		{"title", "string"},		--奖励描述
		{"reward", "array", "reward_item"},--奖励内容
		{"type", "int8"},--奖励领取的类型: 1=按钮可领取;2=按钮已领取;3=未领取;4=邮件发送
		{"finish_count","int32"},-- 完成次数
		{"need_count","int32"}	-- 总次数
	},
	
	act_notice = {
		{"id", "int32"},
		{"notice_list","array","act_index_notice"}
	},
	
	act_index_notice = {
		{"index","int8"},	  -- 
		{"has_draw","int8"}	  -- 是否有奖励 0 无 1 有
	},
	
	shop_discount = {
		{'shop_id','int16'}
		,{'discount', 'int8'}
		,{'item_type_list', 'array','int8'}
	},

	treasureRank = {
		{"rank", "int16"}
		,{"name", "string"}
		,{"times", "uint16"}
	},
	
	treasure_rank_reward = {
		{"rank","int8"},
		{"type_item", "array", "type_item"}
	},
	
	act_seven_day = {		-- 七日特训单个内容
		{"index", "int8"},
		{"title", "string"},
		{"item_list","array","type_item"},
		{"status", "int8"},	 -- 1=按钮可领取;2=按钮已领取;3=未领取;4=邮件发送
		{"finishCount","int32"},
		{"needCount", "int32"},
		{"panel","string"}
	},
	
	seven_day_info = {		-- 七日特训天数
		{"day","int8"},
		{"titile","string"},
		{"is_open","int8"},		-- 是否开启	1开启 0关闭
		{"shop_open","int8"}	-- 商店是否开启	1开启 0关闭
	},
    -- 好友系统
    -- 好友列表
    friendInfo = {
        {"roleId", "int64"}                            --角色ID
        ,{"name", "string"}                             --名字
        ,{"level", "int16"}                               --等级
        ,{"faceId", "int16"}                            --头像ID
    },

    vipGift = {         -- vip礼包信息
        {"id", "int16"}
        ,{"name", "string"}
        ,{"icon", "int32"}
        ,{"costGold", "int16"}
        ,{"needVip", "int8"}
        ,{"maxNum", "int8"}
        ,{"usedNum", "int16"}       
        ,{"gold", "int16"}          -- 礼包价值
        ,{"itemList", "array", "reward_item"}
        ,{"desc", "string"}
    },

	adContentParam = {
		{"type","int8"} --0表示字符串，1：表示英雄ID 2:物品ID
		,{"parameter","string"} --参数value
	},

    funHeroStar = {
        {"star", "uint8"},          -- 星级
        {"canDrawNum", "uint8"},    -- 总共可以领取的次数, 包括已领取的次数
        {"maxDrawNum", "uint8"},    -- 最大可以领取的次数
        {"drawedNum", "uint8"},     -- 已经领取的次数
        {"itemList", "array", "itemInfo"},
    },

    funHeroNum = {
        {"heroNum", "uint8"},
        {"isDraw", "uint8"},    -- 1-未领取 2-已领取 3-不可以领取
        {"itemList", "array", "itemInfo"},
        {"gold", "int32"},
        {"coin", "int32"},
    },

    funPower = {                -- 战力
        {"name", "string"},
        {"lev", "uint8"},
        {"power", "int32"},
        {"rank", "uint8"},
        {"faceID", "int16"},
        {"coin", "int32"},
        {"gold", "int32"},
        {"itemList", "array", "itemInfo"}
    },

    treeProc = {
        {"heroID", "uint16"},
        {"isForbid", "uint8"}, -- 1-禁止 2-没有禁止 默认没有禁止
        {"hp", "uint16"}       -- 血量
    },

    urgeInfo = {
        {"dungeonId", "uint32"},    -- 副本ID
        {"num", "uint8"}            -- 使用鼓舞次数
    },

    urgeLog = {
        {"time", "int32"},
        {"roleID", "int64"},
        {"roleName", "string"},
        {"nthUrge", "int32"},
		{"type", "int8"} -- 1:发起请求 2:别人响应 3:响应别人
    },

	forbidInfo = {
		{"heroID", "uint16"},
		{"forbid", "int8"}
	},

    heroPoetry = {
        {'heroId','uint16'},
        {'heroPoetryCommonList','array','heroPoetryCommon'},
    },

    heroPoetryCommon = {
        {'activityId','int32'}, --活动唯一id
        {'type','uint8'}, --活动类型,14:副本通关 15:副本防守 16:副本保护 17:答题
        {'startTime','int32'}, --开启时间
        {'endTime','int32'}, --结束时间
        {'isFinish','int8'}, --是否完成,0表示未完成,1表示完成,2表示已领取奖励
        {'name','string'},--活动名称
        {'dungeonName','string'}, --关卡名称
    },

    checkInReward = {
       {'type', 'int8'},            --1表示物品，2表示金币，3表示钻石
       {'id','int32'},              --当type为1时表示物品id，其他情况无意义
       {'count','int32'},           --数量
    },

	heroBasic = {
		{"heroID", 'uint16'},
		{"show", 'int8'},
	},

    rankPower5Hero = {
        {"roleName", "string"},
		{"icon", "int32"},
		{"lev", "int16"},
        {"power", "int32"},
        {"rank", "int8"},
		{"heroList", "array", "heroInfo"}
    },

    rankPowerAllHero = {
        {"roleName", "string"},
		{"icon", "int32"},
		{"lev", "int16"},
        {"power", "int32"},
        {"rank", "int8"},
    },

    rankLiveness = {
        {"unionName", "string"},
		{"icon", "int32"},
        {"liveness", "int32"},
        {"rank", "int8"},
    },

    --------国王杯赛--------------------

    guildEntryInfo = {
        {'guildName','string'}, --公会名
        {'guildId','int16'},    --公会id
        {'guildHead','int16'},  --公会头像
        {'guildAvtive','int32'}, --三天内公会活跃度
        {'isSelfGuild','int8'}, --是否玩家所在公会,是其值为1,否其值为0
    },

    guildFlight = {
        {'guildList','array','guildEntryInfo'}, --一个公会对战信息里的两个对战公会
    },

    garrionHero = {
        {'heroId','uint16'},    --驻守英雄头像id
        {'quality','int8'},     --驻守英雄品阶
        {'lev','int16'},        --驻守英雄等级
        {'star','int8'},        --驻守英雄星级
        {'hp','int16'},         --该英雄剩余血量万分比
    },

    garrion = {
        {'place','int8'},       --位置，赋值1,2,3
        {'roleName','string'},  --驻守的玩家名
        {'roleId','int64'},     --驻守的玩家roleId
        {'headId','int16'},     --驻守玩家的头像id
        {'heroList','array','garrionHero'},     --驻守英雄列表
        {'flightPoint','int32'},       --驻守英雄总战斗力
    },

    battleHeroPos = {               -- 英雄位置
        {"x", "int8"},
        {"y", "int8"}
    },

    battleHero = {
        {"uId", "int16"},           -- 唯一ID
        {"monsterId", "int32"},     -- 英雄ID/怪物ID
        {"team", "int8"},           -- 阵营
        {"pos", "battleHeroPos"},   -- 英雄位置
		{"max_hp", "int32"}			-- 最大血量
    },

    battleHeroMove = {              -- 战场英雄移动到的位置
        {"uId", "int16"},
        {"pos", "battleHeroPos"},
    },

    battleHeroFight = {             -- 发起攻击
        {"uId", "int16"},           -- 攻击者ID
        {"targetId", "int16"},         -- 被攻击者ID
        {"skillId", "int16"},       -- 技能ID
    },

    battleHeroHurt = {              -- 攻击伤害
        {"uId", "int16"},
        {"hp", "int16"},			-- 当前血量
    },

	battleDps = {
		{"id","uint32"},
		{"dps","uint32"},
	},

    cooperationMember = {
        {"roleID", "int64"},
        {"isLeader", "int8"},   -- 1-leader 0-not
        {"faceID", "int16"},    -- 头像ID
        {'level','int16'},      -- 等级
        {'isReady','int8'},            -- 是否准备好，1是，0否，房主永久为1
        {'name','string'},
    },

    cooperationInfo = {
        {"roomId", "int32"},        -- 组队ID
        {"dungeonId", "uint32"},    -- 副本id
        {'stat','int8'},            -- 房间状态，1表示私人房间，2表示公开房间
        {"roomMemberList", "array", "cooperationMember"},  -- 成员列表
    },

    arenaReward = {
        {"index", "int16"},
        {"type", "int8"},           -- 1-节点奖励 2-排名奖励 3-膜拜奖励 4-最大排名奖励
        {"time", "int32"},          -- 奖励发送时间
        {"value", "int32"},         -- type == 1 -> 节点ID; type == 2 -> 排名; type == 3 -> 膜拜次
    },

    -----need deleted ---------------------------------------------
    countryInfo = {
        {'countryId', 'int8'},         --城市的id
        {'countryStat', 'int8'},       --城市状态,0和平,1战争,2铁幕（大本营永远为和平）
        {'controledCamp', 'int8'},  --该城市当前被哪个阵营所控制，与角色信息中的camp阵营值相同
        {'isfighting', 'int8'},     --该城市是否处于战斗状态，是为1，否为0
    },

    countryBattleInfo = {              --战斗简报
        {'infoType', 'int8'},       --战斗简报类型，1表示战斗信息，2表示派驻部队信息
        {'countryBattleElemList', 'array', 'countryBattleElemInfo'},  --infoType为1时，countryBattleElemList中有两个成员，表示1号成员表示的玩家战胜了2号成员
                                                                --infoType为2时，countryBattleElemList中有一个成员，表示该玩 家派驻了幻影
    },
    countryBattleElemInfo = {
        {'camp', 'int8'},
        {'level', 'int8'},
        {'name', 'string'},
        {'isGhost', 'int8'},      --0表示不是幻影，1表示是幻影
    },
    countryEvent = {
        {'time', 'int32'},          --事件产生时间
        {'countryId', 'int8'},         --城市id
        {'flag','int8'},            --0表示城市失守，1表示夺取了该城市
    },
    bfQuestEvent = {
        {'time', 'int32'},                          --事件产生时间
        {'questTime',  'timeInterval'},            --哪个时间段的任务
        {'flag','int8'},                            --战斗相关 1 表示该任务成功，0表示该任务失败
    },
    timeInterval = {
        {'beginTime', 'array', 'int8'},         --三个时间成员，分别表示时分秒
        {'endTime', 'array', 'int8'},           --三个时间成员，分别表示时分秒
    },
    bfQuestInfo = {
        {'questType', 'int8'},                     --任务类型 与配表中的任务类型对应
        {'winCamp', 'array', 'int8'},              --任务胜利阵营列表
        {'questStat', 'int8'},                     --0表示任务已过时，1表示任务进行中
        {'questTime',  'timeInterval'},            --任务的时间段
        {'nextQuestTime',  'timeInterval'},        --下个任务的时间段
        {'addition','array','int8'},               --任务附加值（占领城市任务中，该数组为占领城市的id，其余情况为空）
        {'hasReward','int8'},                      --0表示无奖励，1表示有奖励可领（如果玩家已经领奖，则此处改为1）
    },
    bfReward = {
        {'coin','int32'},       --奖励金币数
        {'gold', 'int32'},      --奖励钻石数
        {'rewardItemList','array','itemInfo'},      --奖励物品列表
    },
    bfSelfInfo = {
        {'bfMoraleInfo','bfMoraleInfo'},
        {'bfTransferInfo','bfTransferInfo'},
        {'bfActionInfo','bfActionInfo'},
        {'spyTimes','int16'},
    },
    bfMoraleInfo = {
        {'moraleCount', 'int16'},           --当前士气值
        {'nextRecoverTime', 'int32'},       --下次复活所需要的时间，只有在士气为0时有用，士气不为0时该值可为-1
        {'moraleTimes','int32'},            --今天已复活次数
    },
    bfTransferInfo = {
        {'hasTranser','int8'},              --是否进行了超时空传送，是为1，否为0
        {'transerEndTime', 'int32'},        --超时空传送结束时间，已经用了超市空传送时该值有用
    },
    bfCountryFightInfo = {
        {'countryId','int32'},             --城市id
        {'forcesNum', 'int32'},         --部队数
        {'fightingCapcaity', 'int32'},  --部队平均战斗力
    },
    bfRank = {
        {"level", "int8"},		--等级
        {"name","string"},		--名字
        {"camp","int8"},		--阵营
        {"faceId","int16"},          --头像id
        {"rank", "int8"},		--排名
        {"score", "int16"},		--积分
        {"fight", "int32"},		--战斗力
    },
    bfActionInfo = {
        {'actionCount', 'int16'},       --行动力计数
        {'nextRecoverTime','int32'},    --下一个行动力恢复时间(行动力小于10时有效)
        {'buyActionTimes','int32'},     --已购买行动力次数
    },
    -----need deleted end---------------------------------------------

    building = {        -- 建筑信息
        {"buildID", "int8"},
        {"finishTime", "int32"},
        {"lev", "int8"},
    },

    ------new battlefront-----------------------------------------
    nbfCountryInfo = {
        {'countryId','int8'},
        {'actualControlCamp','int8'}, --该城市的实际占有阵营(0表示无人占领，1表示盟军，2表示苏联)
    },
   
    nbfCountryArmyCount = {
        {'countryId','int8'},
        {'armyCount','int32'},      --部队数
    },
    nbfSelfInfo = {
        {'nbfMoraleInfo','nbfMoraleInfo'},
        {'nbfActionInfo','nbfActionInfo'},
        {'currentCountryId','int8'},           --当前该玩家所在城市id
        {'useSpyTimes','int16'},            --已使用的侦查次数
        {'reputation','int32'},    --已获得功勋值
        {'realm', 'int8'},         --自己所在阵营 

    },
    nbfMoraleInfo = {
        {'moraleCount', 'int16'},           --当前士气值
        {'nextRecoverTime', 'int32'},       --下次复活的时间(不是需要多少时间，而是在什么时候复活)，只有在士气为0时有用，士气不为0时该值可为-1
        {'moraleTimes','int32'},            --今天已复活次数
    },
    nbfActionInfo = {
        {'actionCount','int8'},             --当前行动值，只有1(可以行动)和0(CD)两种值
        {'nextRecoverTime','int32'},        --下次行动值恢复的时间
    },
    nbfFightInfo = {
        {'nbfEnemyInfo','nbfEnemyInfo'},    --敌方玩家信息
        {'moraleList','array','int16'},             --损耗的士气值列表，{'自己损耗的值'，'敌方损耗的值'}
        {'moraleZeroFlagList','array','int8'},      --士气值是否损耗为0，0表示否，1表示是{'自己的士气是否为0'，'敌方的士气是否为0'},
        {'reputation','int32'},             --本次战斗自己获得的功勋值
        {'nextRecoverTime', 'int32'},       --下次复活的时间(不是需要多少时间，而是在什么时候复活)，只有在士气为0时有用，士气不为0时该值可为-1
        {'moraleCount','int16'},            --自身士气值
        {'isWin','int8'},                   --是否胜利(0失败，1胜利)
        {'winCount','int16'},               --连胜计数
        {'miningGold','int32'},             --击败矿车获得的钻石数，没有为0
    },

    nbfEnemyInfo = {
        {'countryId','int8'},                  --该场战斗发生时该敌人所在城市
        {'roleId','int64'},
		{'level','int16'},
        {'name','string'},
        {'headId','int16'},
    },
    nbfRank = {
        {"level", "int8"},      --等级
        {"name","string"},      --名字
        {"camp","int8"},        --阵营
        {"faceId","int16"},          --头像id
        {"rank", "int8"},       --排名
        {"score", "int32"},     --积分（就是获得的功勋值）
        {"fight", "int32"},     --战斗力
    },
    nbfResult = {
        {'attackTimes','int32'},    --进攻次数
        {'defeatTimes','int32'},    --防守次数
        {'killEnemys','int32'},     --击杀敌人数
        {'controlCountry','int32'},    --占领城市数，指该玩家刚好占领的无人城市或者因击杀最后一个敌方部队而占据了城市的数目
        {'reputation','int32'},    --已获得功勋值
        {'rank','int32'},       --功勋排行，没有排行者该值为-1
        {'gold','int32'},       --获得宝石
        {'winCount','int16'},   --最高连胜数
        {'flagList','array','int8'} --标记位数组，每个元素1表示是，0表示否 {'是否获得尤里岛宝箱'}
    },
    nbfMonster = {
        {'type','int8'},        --0表示矿车，1表示部队
        {'camp','int8'},        --NPC所属阵营
        {'id','int32'},         --表示该NPC的唯一ID
        {'countryId','int32'},     --该NPC当前在哪个城市
    },
    nbfPlayerInfo = {
        {'name','string'},
        {'camp','int8'}
    },
    nbfCountryAddGold = {
        {'countryId','int32'},
        {'goldAdd','int32'},
    },
    --------------------------------------------------------------
    ArmInfo = {
        {"armID", "uint16"},
        {"eqmList", "array", "int32"}          -- 装备列表
    },

    monthCard = {
        {"gold", "int32"},
        {"isDraw", "int8"},
        {"leftDays", "int16"},
		{"title","string"},
		{"titleBg","string"},
		{"baoshi","int32"},
		{"dialy_gold", "int32"},
		{"sustain_days", "int32"},          -- 持续天数
    },
	
		---------------------野外-----------------------------------
	myBaseInfo = {   --自己主基地信息
		{"wildernessPos", "wildernessPos"},
		{"free_transfer","int8"},	-- 用过免费迁城 1用过 0未用过
		{'protect_time','int32'},	-- 防护罩结束时间
		{'transfer_cd','int32'}		-- 迁城结束时间
	},
	
	wildernessPos = {
		{"x","int16"},
		{"y","int16"},
	},
	
	armyHero = {
		{"heroId","uint32"},
		{"bad_num","uint8"},
		{"max_num", "uint8"},
	},
	
	armyInfo = {  --野外的部队信息
		{"id", "int8"},  -- 部队ID
		{"heroList","array","armyHero"},
		{"status","int8"}, -- 状态 1.待机(在家里)； 2.维修中; 3.撤回中; 4.出征中; 5.采矿中; 6.基地维修中
		{"wildernessPos","wildernessPos"},
		{"max_populace","int16"},	-- 总部队统率力
		{'miningInfoList', 'array', 'wildernessMiningInfo'},    --开采列表
		{"res_time","uint32"},  -- 维修,撤回,采矿 (s)
		{"max_time","uint32"},  -- 总时间 (s)
	},
	
    wildernessMine = {  --野外矿车信息
        {'type',  'int8'},        --矿的类型	1水晶 2 铁 3铀
        {'level', 'int8'},      --矿的等级
        {'stock', 'int32'},     --当前存量
        {'wildernessPos', 'wildernessPos'},  --位置
		{'name_list','array','string'}
    },
	
    wildernessPlayerInfo = {
        {'roleId','int64'},
        {'name', 'string'},
		{'role_level',"int16"},
		{'union_name',"string"},
        {'relationShip','int8'},    --与玩家的关系，1 玩家自己 2 玩家的盟友 3 敌人
    },
	
    wildernessMiningInfo = {    --挖矿信息
        {'wildernessPos', 'wildernessPos'},     --位置
		{'mine_type','int8'},			--矿的类型
        {'speed', 'int16'},             --开采速率
        {'amount',  'int32'},           --开采结束时该部队的开采量
		{'beginTime',"int32"},			--开采开始时间	 
        {'endTime', 'int32'},           --开采结束时间	
		{'has_mine_num', 'int32'}		--已经开采的量
    },
	
    wildernessArmy = {  	--野外部队信息
		{"index","int16"}, 	-- 部队index
		{"now_populace","int16"},	-- 当前统率力
		{"max_populace","int16"},	-- 总部队统率力
        {'wildernessPlayerInfo', 'wildernessPlayerInfo' }, 	--部队所属的玩家信息
        {'wildernessPos', 'wildernessPos'},     			--位置
        {'miningInfoList', 'array', 'wildernessMiningInfo'},--开采列表
        {'returnTime', 'int32'},        					--返回时间
		{'power',"int32"}									-- 战斗力
    },
	
    wildernessBase = {  --野外基地信息
        {'wildernessPlayerInfo', 'wildernessPlayerInfo'},   --基地所属的玩家信息
        {'wildernessPos', 'wildernessPos'},     --位置
		{'protect_time','int32'},	-- 防护罩结束时间
		{'power',"int32"},	-- 战斗力
		{"now_populace","int16"},	-- 当前统率力
		{"now_blood","int32"},	-- 当前城防值
		{"max_blood","int32"},	-- 最大城防值
		{"mine_list","array","resources"}
    },
	
	wildernessMonster = {	--野外野怪信息
		{'monsterID','int32'},
		{'wildernessPos', 'wildernessPos'},     --位置
		{'first_kill','uint8'},		-- 0否 1是
		{'lev','int16'},
		{'power','int32'},
        {'is_boss', 'int8'},        -- 0否 1是
		{'now_populace', 'int16'},
		{'max_populace', 'int16'}
	},
	
    wildernessPosInfo = {
        {'roleId','int64'},		-- 角色ID或者怪物ID
        {'wildernessPos','wildernessPos'},
    },
	
	resources_counter = {
		{"rosources_id","int8"},
		{"counter","int16"},
		{"time","int32"}
	},
	
	resources = {
		{"resources_id", "int8"},	--矿的类型	1水晶 2 铁 3铀
		{"num", "int32"}
	},

    chestHelpInfo = {
		{"count", "int8"}      -- 已经收集到的帮助
		,{"roleId", "int64"}
        ,{"name", "string"}
        ,{"content", "string"}
		,{"time", "int32"}  --- 
		,{"faceId", "int16"}
		,{"level", "int8"}
        ,{"ipAddr", "string"}
        ,{"vip", "int8"}
    },
	
	wildernessGuildPos = {
        {'roleId','int64'},		-- 角色ID
		{"post","int8"},  --公会的职位
        {'pos','wildernessPos',true},
    },
	
	monsterNumInfo = {
		{"id","int32"},
		{"num","int16"}
	},
	
	wildBattleLog = {	-- 战斗事件
		{"index","int64"},
		{"type","int16"},	-- 事件类型	1.部队被攻击 2.基地被攻击 3.攻击敌人部队 4.攻击敌人基地
		{"status","int8"},	-- 状态类型 4.驻军 5.采矿
		{"unionName","string"},
		{"unionTitile","int16"},
		{"roleName","string"},
		{"is_win","int8"},	-- -1失败 1成功
		{"wildernessPos","wildernessPos"},
		{"is_read","int8"},
		{"time","int32"}
	},
	
	BattleLogDetails = {	-- 战斗事件详情
		{"log_id","int8"}, -- 页签ID
		{"index","int64"},
		{"wildernessPos","wildernessPos"},
		{"mine_list","array","resources"},
		{"union_exp","int32"},
		{"atk_name","string"},
		{"def_name","string"},
		{"atk_union_name","string"},
		{"def_union_name","string"},
		{"atk_titile","int8"},
		{"def_titile","int8"},
		{"atk_roleID","int64"},
		{"def_roleID","int64"},
		{"atk_faceID","int16"},
		{"def_faceID","int16"},
		{"del_blood","int32"},
		{"atk_hero_list","array","armyHero"},
		{"def_hero_list","array","armyHero"}
	},

	BattleLogDetailsM = {
		{"roleId","int64"},
		{"index","int64"},
		{"type","int16"},	-- 事件类型	1.部队被攻击 2.基地被攻击 3.攻击敌人部队 4.攻击敌人基地
		{"status","int8"},	-- 状态类型
		{"unionName","string"},
		{"unionTitile","int16"},
		{"name","string"},
		{"role_level", "int8"},
		{"faceId","int16"},
		{"is_win","int8"},	-- -1失败 1成功
		{"time","int32"},
		{"wildernessPos","wildernessPos"},
		{"mine_list","array","resources"},
		{"union_exp","int32"},
		{"atk_name","string"},
		{"def_name","string"},
		{"atk_union_name","string"},
		{"def_union_name","string"},
		{"atk_titile","int8"},
		{"def_titile","int8"},
		{"atk_roleID","int64"},
		{"def_roleID","int64"},
		{"atk_faceID","int16"},
		{"def_faceID","int16"},
		{"atk_vipLev","int8"},
		{"def_vipLev","int8"},
		{"del_blood","int32"},
		{"atk_hero_list","array","armyHero"},
		{"def_hero_list","array","armyHero"}
	},
	
	wildMineLog = {	-- 采矿事件
		{"index","int64"},
		{"type","int16"},	-- 事件类型 1采矿,2怪物
		{"troops_id","int8"}, -- 部队ID
		{"time","int32"},
		{"wildernessPos","wildernessPos"},
		{"mine_list","array","resources"},
		{"is_win","int8"}, -- -1失败 1胜利
		{"monsterID","int32"},
		{"monsterLev","int16"}
	},
	
	MineLogDetails = {	-- 采矿事件详情
		{"index","int64"},
		{"wildernessPos","wildernessPos"},
		{"atk_hero_list","array","armyHero"},
		{"def_hero_list","array","armyHero"}
	},
	
	wildArmyLog = {
		{"index", "int64"},
		{"name","string"},
		{"level", "int16"},
		{"is_read","int8"},  --0 没读  1 已读
		{"time","int32"}
	},
	
	ArmyDetails = {
		{"index","int64"},
		{"wildernessPos","wildernessPos"},	
		{"roleId","int64"},
		{"name","string"},
		{"level","int16"},
		{"faceId","int16"},
		{"time","int32"},
		{"union_name","string"},
		{"army_type","int8"},	-- 1基地 2部队
		{"res_blood","int32"},
		{"max_blood","int32"},
		{"resources","array","resources"},
		{"hero_list","array","army_hero"}
	},
	
	army_hero = {
		{"heroID","int16"},
		{"res_num","int8"},
		{"max_num","int8"},
		{"elite_quality","int16"}
	},
	
	wildUnionLog = {	-- 军团事件
		{"index","int64"},
		{"type","int16"},	-- 事件类型	1.玩家进攻 2.玩家被攻击 3.玩家求援坐标 4.玩家求援敌人 5.玩家求援采矿 6.玩家求援迁城
		{"wildernessPos","wildernessPos"},
		{"is_win","int8"},
		{"atk_titile","int8"},
		{"def_titile","int8"},
		{"atk_name","string"},
		{"def_name","string"},
		{"atk_union_name","string"},
		{"def_union_name","string"},
		{"time","int32"}
	},
	
	UnionLogDetails = {	 -- 军团事件详情
		{"index","int64"},
		{"union_exp","int16"},
		{"atk_faceID","int16"},
		{"def_faceID","int16"},
		{"atk_roleID","int64"},
		{"def_roleID","int64"},
		{"atk_hero_list","array","armyHero"},
		{"def_hero_list","array","armyHero"}
	},
	
	wild_record = {		-- 战绩
		{"type","int16"},	
		{"num","int32"},
	},

    rank_power_vip = {
        {"roleId", "int64"}                            --角色ID
        ,{"name", "string"}                             --名字
        ,{"lev", "int16"}                               --等级
        ,{"faceID", "int16"}                            --头像ID
		,{"fight", "int32"}                             --战斗力
        ,{"rank", "int16"}                              -- 排名
        ,{"power_vip", "int8"}                          -- 军阶
        ,{"union_name", "string"}                       --公会名字
    },

    chestInfo = {
        {"cType", "int8"}        -- 宝箱类型
        ,{"count", "int8"}      -- 连抽次数
        ,{"gold", "int16"}      -- 元宝花费
        ,{"free", "int8"}    -- 是否有免费 1-是 0-否
        ,{"freeTime", "int32"}        -- 下次免费时间
    },

    chestCrit = {               -- 抽宝箱暴击
        {"cType", "int8"},
        {"crit", "int8"}
    },

    eqmPaper = {
        {"index", "int8"},
        {"pos", "int8"},
        {"itemID", "int16"},    -- 空的为0
        {"beginTime", "int32"},
        {"endTime", "int32"}
    },
    kingBoss = {
        {"dungeonID", "uint32"},
        {"isDrawFirstPassReward", "int8"},
    },
}

return entryCfg
