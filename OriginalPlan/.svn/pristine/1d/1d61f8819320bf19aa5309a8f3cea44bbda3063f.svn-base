--[[
	class:		MonsterCfg
	desc:		怪物系统配置管理器
	author:		郑智敏
]]

local MonsterCfg = class("Monster")

----------MonsterCfg 常量定义----------------
MonsterCfg.BOSS_TYPE = 2
MonsterCfg.NORMAIL_TYPE = 1

----------常量定义 end----------------------

function MonsterCfg:ctor()
end

function MonsterCfg:init()
	self._monsterCfg = ConfigMgr:requestConfig("monster")
	self._monsterBaseCfg = ConfigMgr:requestConfig("monster_base")
end

function MonsterCfg:getMonster( id )
	local cfg =  self._monsterCfg[id]
	print("MonsterCfg:getMonster( id )",id)
	local baseCfg = self._monsterBaseCfg[cfg.s]

	if not cfg._baseInfoOk then
		for k,v in pairs(baseCfg) do
			cfg[k] = v
		end
		cfg._baseInfoOk = true
		cfg.id = id
		self:changeKey(cfg,"p","populace")
		self:changeKey(cfg,"a","main_atk")
		self:changeKey(cfg,"b","minor_atk")
		self:changeKey(cfg,"d","def")
		self:changeKey(cfg,"h","hp")
		self:changeKey(cfg,"l","level")
		self:changeKey(cfg,"k","isElite")
	end
	return cfg
end

function MonsterCfg:changeKey(cfg,src,des)
	cfg[des] = cfg[src]
	cfg[src] = nil
end

function MonsterCfg:getMonsterBase( baseId )
	-- body
	return self._monsterBaseCfg[baseId]
end

function MonsterCfg:hasMonster(id)
	return self._monsterCfg[id] ~= nil
end

--怪物等级 int
function MonsterCfg:getMonsterLevel(id)
	local cfg = self:getMonster( id )
	return cfg.level
end

--怪物头像 id
function MonsterCfg:getMonsterHead(id)
	local cfg = self:getMonster( id )
	return cfg.head
end

function MonsterCfg:getHeadRes(id)
	local monsterInfo = self:getMonster( id )
	return ResCfg:getRes(monsterInfo.head, ".pvr.ccz")
end

--怪物名字 string
function MonsterCfg:getMonsterName(id)
	local cfg = self:getMonster( id )
	return cfg.name
end

--怪物类型 int
function MonsterCfg:getMonsterType(id)
	local cfg = self:getMonster( id )
	return cfg.mType
end

--怪物星级 int
function MonsterCfg:getMonsterStar(id)
	local cfg = self:getMonster( id )
	return cfg.star
end

--怪物种族 int
function MonsterCfg:getMonsterRace(id)
	local cfg = self:getMonster( id )
	return cfg.race
end

--怪物品质 int
function MonsterCfg:getMonsterQuality(id)
	local cfg = self:getMonster( id )
	return cfg.quality
end

--怪物克制关系 int
function MonsterCfg:getMonsterOppose(id)
	local cfg = self:getMonster( id )
	return cfg.oppose
end

--怪物职业 int
function MonsterCfg:getMonsterCareer(id)
	local cfg = self:getMonster( id )
	return cfg.career
end

--怪物描述 string
function MonsterCfg:getMonsterDesc(id)
	local cfg = self:getMonster( id )
	return cfg.desc
end

--怪物描述 string
function MonsterCfg:getMonsterHp(id)
	local cfg = self:getMonster( id )
	return cfg.hp
end

return MonsterCfg.new()