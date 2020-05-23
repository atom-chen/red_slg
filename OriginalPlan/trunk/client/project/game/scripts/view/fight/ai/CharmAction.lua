local Action = game_require("view.fight.ai.Action")
local Charm = game_require("view.fight.ai.Charm")

local CharmAction = class("CharmAction",Action)

function CharmAction:init( creature)
	Action.init(self,creature)
	self.charmList = {}
end

--攻击 敌人
function CharmAction:attack(force)
	if self.creature:canMainSkill() then
		Action.attack(self,force)
	end
end

function CharmAction:setCharmTraget(target)
	for i,charm in ipairs(self.charmList) do
		local curTarget = charm:getCharmTarget()
		if curTarget == nil or curTarget:isDie() then
			charm:setCharm(target)
			break
		end
	end
end

function CharmAction:removeCharmTraget(target)
	for i,charm in ipairs(self.charmList) do
		if charm:getCharmTarget() == target then
			charm:removeCharm()
			break
		end
	end
end

function CharmAction:run(dt)
	Action.run(self,dt)
	-- print("心灵控制啊。。。。",#self.charmList,self.creature.cInfo.charmNum)
	for i,charm in ipairs(self.charmList) do
		charm:run(dt)
	end
end

function CharmAction:dispose()
	Action.dispose(self)
	for i,charm in ipairs(self.charmList) do
		charm:dispose()
	end
	self.charmList = nil
end

return CharmAction