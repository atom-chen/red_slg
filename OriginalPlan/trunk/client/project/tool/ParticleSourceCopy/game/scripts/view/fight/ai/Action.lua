--
-- Author: wdx
-- Date: 2014-05-13 16:23:26
--

--[[--
行为 ai   主要是 攻击   施法  等
]]
local Action = class("Action")

function Action:ctor()
	-- body
end

function Action:init( creature)
	self.creature = creature
	self.curTime = 0
	creature.cInfo.atkCD = 1000
	self.lastAttackTime = -creature.cInfo.atkCD
end

--攻击 敌人
function Action:attack(target)
	local creature = self.creature
	if self.curTime - self.lastAttackTime >= creature.cInfo.atkCD then  --间隔时间到了  直接攻击
		self.lastAttackTime = self.curTime
		--print("开始攻击：",self.creature.id,target.id)

		local direction = AIMgr:getDirection(self.creature,target:getPosition())
		self.creature:setDirection(direction)

		local skillId = Formula:getRandomSkill(creature)   --获取随机技能
		local skill = FightEngine:createSkill(self.creature,skillId,target)
		FightEngine:addSkill(skill)
	end
end

--防御 守护 一个队友
function Action:defend( target )
	-- body
end

--治疗 辅助
function Action:assist(target)
	self:attack(target)
end

function Action:run(dt)
	self.curTime = self.curTime + dt 
	
end


return Action