local GameConst = {}

--游戏中默认的字体以及大小
GameConst.DEFAULT_FONT = ui.DEFAULT_TTF_FONT -- --空串，默认用系统字

--颜色 字符串 描述
GameConst.COLORS_STRING = {
	white = "rgb(255,255,255)"
	,red = "rgb(255,0,0)"
	,black = "rgb(0,0,0)"
	,yellow = "rgb(223,202,123)"
	,green = "rgb(0,255,0)"
	,orange = "rgb(253,110,15)"
	,blue = "rgb(15,210,254)"
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

--物品分类：道具、装备、宝石
GameConst.ITEM_TYPE_PROP = 1
GameConst.ITEM_TYPE_EQUIP = 2
GameConst.ITEM_TYPE_GEM = 3

GameConst.CONFIG_ENUM_COIN = 1
GameConst.CONFIG_ENUM_YUANBAO = 2
GameConst.CONFIG_ENUM_ENERGY = 3
GameConst.CONFIG_ENUM_TASK_SCORE = 5
GameConst.CONFIG_ENUM_VIGOUR = 9

GameConst.COIN_NAME = "金币"
GameConst.YUANBAO_NAME = "元宝"
GameConst.ENERGY_NAME = "体力"
GameConst.TASK_SCORE_NAME = "积分"
GameConst.VIGOUR_NAME = "精力"
GameConst.RES_ICON = {
	vip = "#com_nu_v.png",
	gold = "#img_bs.png",
	exp = "#com_exp.png",
	coin = "#img_jq.png",
	crystal = "#yw_icon_sj.png",
	iron ="#yw_icon_t.png",
	uranium ="#yw_icon_y.png",
	vigour = "#com_img_5.png",
	energy = "#com_img_3.png",
}

GameConst.CONFIG_ENUM_NAMES = {
	[GameConst.CONFIG_ENUM_COIN] = GameConst.COIN_NAME,
	[GameConst.CONFIG_ENUM_YUANBAO] = GameConst.YUANBAO_NAME,
	[GameConst.CONFIG_ENUM_ENERGY] = GameConst.ENERGY_NAME,
	[GameConst.CONFIG_ENUM_TASK_SCORE] = GameConst.TASK_SCORE_NAME,
	[GameConst.CONFIG_ENUM_VIGOUR] = GameConst.VIGOUR_NAME
}
GameConst.CONFIG_ENUM_RES = {
	[GameConst.CONFIG_ENUM_COIN] = GameConst.RES_ICON.coin,
	[GameConst.CONFIG_ENUM_YUANBAO] = GameConst.RES_ICON.gold,
	[GameConst.CONFIG_ENUM_ENERGY] =  GameConst.RES_ICON.energy,
	[GameConst.CONFIG_ENUM_VIGOUR] = GameConst.RES_ICON.vigour,
	[GameConst.CONFIG_ENUM_TASK_SCORE] = nil,
}
GameConst.STAND_ACTION = "stand"
GameConst.ATTACK_ACTION = "atk"
GameConst.MOVE_ACTION = "move"
GameConst.HURT_ACTION = "hurt"
GameConst.DIE_ACTION = "die"
GameConst.MAGIC_ACTION = "magic"
GameConst.WIN_ACTION = "win"

GameConst.LEFT_DIRECTION = "1"
GameConst.RIGHT_DIRECTION = "2"

GameConst.UP = 11
GameConst.RIGHT_UP = 12
GameConst.RIGHT = 13
GameConst.RIGHT_DOWN = 14
GameConst.DOWN = 15
GameConst.RIGHT_UP_1 = 16
GameConst.RIGHT_UP_2 = 17
GameConst.RIGHT_DOWN_1 = 18
GameConst.RIGHT_DOWN_2 = 19

GameConst.LEFT_UP = 22
GameConst.LEFT = 23
GameConst.LEFT_DOWN = 24

GameConst.LEFT_UP_1 = 26
GameConst.LEFT_UP_2 = 27
GameConst.LEFT_DOWN_1 = 28
GameConst.LEFT_DOWN_2 = 29


--物品分类：道具、装备、宝石
GameConst.ITEM_TYPE_PROP = 1
GameConst.ITEM_TYPE_EQUIP = 2
GameConst.ITEM_TYPE_GEM = 3

GameConst.IS_GM = false
return GameConst