local GameConst = {}

GameConst.MHT_DISTANCE = 20

--游戏中默认的字体以及大小
GameConst.DEFAULT_FONT      = ""  --空串，默认用系统字
GameConst.DEFAULT_FONT_SIZE_LEAST = 14
GameConst.DEFAULT_FONT_SIZE_MINI = 16
GameConst.DEFAULT_FONT_SIZE = 18
GameConst.DEFAULT_FONT_SIZE_PLUS = 20
GameConst.DEFAULT_FONT_SIZE_MAX = 22
GameConst.DEFAULT_FONT_COLOR = ccc3(255, 255, 255)

--音效、音乐的常量定义
--[[--音效：点击
	 * 播放游戏音效
	 * 1:按钮
	 * 2：开宝箱
	 * 3：装备强化
	 * 4:星宿、灵石升级、神将突飞、重生
	 * 5：获得星宿
	 * 6：放逐神将、魂魄合成、召唤神将、点将、借宝  分解物品
	 * 7：获得铜币：招财符、卖出道具、领取炼宝、祝福宝箱铜币奖励
	 * 8：战斗胜利
	 * 9：战斗失败
	 * 10：斗法方块消失
	]]
GameConst.EFFECT_CLICK = 1
GameConst.EFFECT_BOX = 2
GameConst.EFFECT_FORGE = 3
GameConst.EFFECT_LEVELUP = 4
GameConst.EFFECT_HUNT = 5
GameConst.EFFECT_PARTNER = 6
GameConst.EFFECT_GCY = 7
GameConst.EFFECT_WIN = 8
GameConst.EFFECT_FAIL = 9
GameConst.EFFECT_DOUFA = 10

--背景音乐:主城、副本、天界、战斗
GameConst.BGM_HOME = 1
GameConst.BGM_DUNGEON = 2
GameConst.BGM_HEAVEN = 101
GameConst.BGM_FIGHT = 1001

--颜色配置
GameConst.COLOR_PLACEHOLDER = ccc4(0, 190, 255, 100)
GameConst.COLOR_MASK = ccc4(0, 0, 0, 200)
GameConst.COLOR4_WHITE = ccc4(255, 255, 255,0)
GameConst.COLOR_WHITE = ccc3(255, 255, 255)
GameConst.COLOR_BLACK = ccc3(0, 0, 0)
GameConst.COLOR_YELLOW = ccc3(223, 202, 123)
GameConst.COLOR_GREEN = ccc3(0, 255, 0)
GameConst.COLOR_ORANGE = ccc3(253, 110, 15)
GameConst.COLOR_BROWN = ccc3(63, 41, 8)
GameConst.COLOR_RED = ccc3(255,0,0)
GameConst.COLOR_GRAY = ccc3(128,128,128)
GameConst.COLOR_CADMIUM_YELLOW = ccc3(255, 246, 0) -- 卡片等级描边

--聊天频道
GameConst.CHANNEL_WORLD = 0 --聊天频道：世界       HudChatPanel
GameConst.CHANNEL_PRIVATE = 1 --聊天频道：私聊  HudChatPanel
GameConst.CHANNEL_SYSTEM = 2 --聊天频道：系统   sysNotice
GameConst.CHANNEL_POST = 3 --聊天频道：公告    sysNotice
GameConst.CHANNEL_FRIEND = 4 --聊天频道：好友   chatPrivatePanel

GameConst.CHANNEL_PRIVATE_UNREAD = 21 --聊天频道：离线私聊  HudChatPanel
GameConst.CHANNEL_FRIEND_UNREAD = 24 --聊天频道：离线好友消息   chatPrivatePanel

GameConst.CHANNEL_GAME_NOTICE = 7 --系统更新公告  popNotice
GameConst.CHANNEL_GUIDE = 8 --系统提示

--颜色 字符串 描述
GameConst.COLORS_STRING = {
	white = "rgb(255,255,255)"
	,red = "rgb(255,0,0)"
	,black = "rgb(0,0,0)"
	,yellow = "rgb(223,202,123)"
	,green = "rgb(0,255,0)"
	,orange = "rgb(253,110,15)"
}

--品质  颜色字符串描述
GameConst.Q_COLORS_STRING = {
	"rgb(255,255,255)"
	,"rgb(0,255,0)"
	,"rgb(0,0,255)"
	,"rgb(160,32,240)"
	,"rgb(255,97,0)"
	,"rgb(255,0,0)"
}

--不同品质对应的颜色值
GameConst.Q_COLORS={
		ccc3(255, 255, 255),
		ccc3(0, 255, 0),
		ccc3(0, 0, 255),
		ccc3(160, 32, 240),
		ccc3(255, 97, 0),
		ccc3(255, 0, 0)
	}

--不同品质对应的颜色文字
GameConst.Q_COLORS_TEXT={
		"白色",
		"绿色",
		"蓝色",
		"紫色",
		"橙色",
		"红色"
	}

GameConst.Q_COLORS_RICHTEXT={	--richText版品质颜色
		"<font color=rgb(255,255,255)>",
		"<font color=rgb(0,255,0)>",
		"<font color=rgb(0,0,255)>",
		"<font color=rgb(160,32,240)>",
		"<font color=rgb(255,97,0)>",
		"<font color=rgb(255,0,0)>"
	}

GameConst.EQUIP_TYPE = {
	"武器",
	"头盔",
	"铠甲",
	"护手",
	"裤子",
	"战靴"
}

GameConst.EQUIP_TYPE2 = {
	"武",
	"头",
	"铠",
	"手",
	"腿",
	"靴"
}

GameConst.ATTRIBUTE_NAME = {
	hp = "气血",
	phyAttack = "普通攻击",
	phyDefense = "普通防御",
	magAttack = "绝技攻击",
	magDefense = "绝技防御",
	critical = "暴击",
	speed = "速度",
	parry = "格挡",
	strikeBack = "反击",
	hit = "命中",
	dodge = "闪避",
	fury = "初始怒气",
	fightValue = "战力",
	wx = "灵根",
	quality = "品质",
	level = "等级",
	skill = "技能",
	tend = "类型"
}

GameConst.ATTRIBUTE_NAME2 = {
	hp = "气血",
	phyAttack = "普击",
	phyDefense = "普御",
	magAttack = "技击",
	magDefense = "技御",
	critical = "暴击",
	speed = "速度",
	parry = "格挡",
	strikeBack = "反击",
	hit = "命中",
	dodge = "闪避",
	fury = "怒气",
	fightValue = "战力",
	wx = "灵根",
	quality = "品质",
	level = "等级",
	skill = "技能",
	tend = "类型"
}

--资源  中文名   与 英文    与设定数值      对应关系     比如ccy = “元宝”  =  7
GameConst.RESOURCE_NAME_OBJ = {gcy = "铜币",ccy="元宝",vit="体力",score="积分",soul="魂魄",fame="声望",xian="仙缘",exp="经验",lilian="阅历",expBook="经验书",honor="荣誉",vipExp="VIP经验"};
GameConst.RESOURCE_NAME = {"铜币","经验","物品","声望","魂魄","体力","元宝","仙缘","积分","灵石","阅历","魂魄","经验书","荣誉","VIP经验"};
GameConst.RESOURCE_INDEX = {gcy=1,exp=2,fame=4,soul=5,vit=6,ccy=7,xian=8,score=9,gem=10,lilian=11,psoul=12,expBook=13,honor=14,vipExp=15,fate=16};
GameConst.TypeText = {"gcy","exp","item","fame","soul","vit","ccy","xian","score","gem","lilian","psoul","expBook","honor","vipExp","fate"};

-- GameConst.WX = {'无','金','木','水','火','土'};
GameConst.TEND = {"攻","攻","防","防","辅"};
GameConst.TEND_NAME = {"attack","attack","defense","defense","assist"};
GameConst.QualityStar = {"一星","二星","三星","四星","五星","六星"}
GameConst.NUMSTRING = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十"}

--资源类型，对应的图标、品质 "xian=56,gcy="1000",ccy="100",vit=100,expBook=100,exp=1000}
GameConst.RES = {
	ccy={quality=0,iconSrc="item/200044.png"},
	gcy={quality=0,iconSrc="item/200045.png"},
	vit={quality=0,iconSrc="item/200050.png"},
	exp={quality=0,iconSrc="item/200041.png"},
	expBook={quality=0,iconSrc="item/200041.png"},
	gifts={quality=0,iconSrc="item/180007.png"}
}


--性别
GameConst.GENDER_MALE = 1
GameConst.GENDER_FEMALE = 2

--种族
GameConst.RACE_DRAGON  = 1
GameConst.RACE_ELF     = 2
GameConst.RACE_BEAST   = 3
GameConst.RACE_DEVIL   = 4
GameConst.RACE_ROBOT   = 5
GameConst.RACE_MONSTER = 6

--物品分类：道具、装备、宝石
GameConst.ITEM_TYPE_PROP = 1
GameConst.ITEM_TYPE_EQUIP = 2
GameConst.ITEM_TYPE_GEM = 3

--体型
GameConst.SIZE_MICRO  = 1
GameConst.SIZE_SMALL  = 2
GameConst.SIZE_MIDDLE = 3
GameConst.SIZE_BIG    = 4
GameConst.SIZE_HUGE   = 5


return GameConst