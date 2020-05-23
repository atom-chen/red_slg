--
-- Author: wdx
-- Date: 2014-05-27 17:33:43
--

local RoleConst = {}

RoleConst.ID = "roleId" --ID
RoleConst.NAME = "name" --名字
RoleConst.LEVEL = "lev" --等级
RoleConst.EXP = "exp" --经验
RoleConst.GOLD = "gold" --宝石
RoleConst.COIN = "coin" --黄金
RoleConst.ENERGY = "energy" --原油
RoleConst.FACEID = "faceID" --头像ID
RoleConst.INIT_FACEID = "init_faceID"--初始头像(形象)
RoleConst.FACE_FRAME = "frameId"--头像框ID
RoleConst.VIPLEV = "vipLev"
RoleConst.CHARGEGOLD = "chargeGold" --充值元宝数
RoleConst.TASK_SCORE = "task_score" --日常任务的积分
RoleConst.VIGOUR = "vigour" --精力
RoleConst.CHARM = "charm"--魅力
RoleConst.DETER = "deter"--威慑
RoleConst.EQUIP_COIN = "equip_coin"--装备币
RoleConst.STAR_COIN = "star_coin" --升星币
RoleConst.SHOP_COIN = "shop_coin"--商店币
RoleConst.TITLE = "title" --称号
RoleConst.ARENA_COIN="arena_coin" --竞技场币
RoleConst.ARENA_SCORE="arena_score" --竞技场积分
RoleConst.BOX_SCORE = "box_score" -- 图鉴值
RoleConst.NECK_COIN = "neck_coin" --饰品币
RoleConst.SENTE = "sente" --先手值
RoleConst.ACHIEVE_SCORE ="ach_score" --成就积分
RoleConst.KeyTable = {
	[1] = RoleConst.COIN, --黄金
	[2] = RoleConst.GOLD, --宝石
	[3] = RoleConst.ENERGY, --原油
	[4] = RoleConst.LEVEL, --战队等级
	[5] = RoleConst.EXP, --战队经验
	[6] = RoleConst.VIPLEV,
	[7] = RoleConst.CHARGEGOLD,
	[8] = RoleConst.TASK_SCORE,
	[9] = RoleConst.VIGOUR,
	[10]= RoleConst.CHARM,
	[11]= RoleConst.DETER,
	[12]= RoleConst.EQUIP_COIN,
	[13]= RoleConst.STAR_COIN,
	[14]= RoleConst.SHOP_COIN,
	[15] = RoleConst.ARENA_SCORE,
	[16] = RoleConst.NECK_COIN,
	[17]= RoleConst.ARENA_COIN,
	[20] = RoleConst.BOX_SCORE,
	[21] = RoleConst.SENTE,
	[22] = RoleConst.ACHIEVE_SCORE,
}

-- RoleConst.DEFAULT_TABLE = {
	-- ["roleId"] = "000000000",       --战队ID
   	-- ["name"] =  '',    				--战队名字
    -- ["lev"]  = 1,       			--战队等级
    -- ["exp"] = 0,       				--战队经验
    -- ["gold"] = 0,       			--宝石
    -- ["coin"] = 0,      				--黄金
    -- ["energy"] = 0,       			--原油
    -- ["faceID"] = 0,       			--头像ID
   	-- ["vipLev"] = 0,       			--vip等级
    -- ["chargeGold"] = 0,       	--总充值元宝数
-- }

return RoleConst
