--[[
	class:		MonsterInfo
	desc:		怪物信息，通过怪物id初始化后，直接获取怪物id对应的怪物信息
	author:		郑智敏
]]

local MonsterInfo = class("MonsterInfo")

function MonsterInfo:ctor(monsterId)
	self.monsterId = monsterId
	self.head = MonsterCfg:getMonsterHead(monsterId) --头像
	self.name = MonsterCfg:getMonsterName(monsterId) --名字 string
	self.level = MonsterCfg:getMonsterLevel(monsterId) --等级 int
	self.type = MonsterCfg:getMonsterType(monsterId) --类型 int
	self.star = MonsterCfg:getMonsterStar(monsterId) --星级 int
	self.race = MonsterCfg:getMonsterRace(monsterId) --种族 int
	self.quality = MonsterCfg:getMonsterQuality(monsterId) --品阶 int
	self.oppose = MonsterCfg:getMonsterOppose(monsterId) --克制关系 int
	self.career = MonsterCfg:getMonsterCareer(monsterId) --职业 int
	self.desc = MonsterCfg:getMonsterDesc(monsterId) --怪物描述
	self.hp = MonsterCfg:getMonsterHp(monsterId)
	self.cfg = MonsterCfg:getMonster(monsterId)
end

return MonsterInfo