local FlyAI = class("FlyAI",AI)

local FlyAction = game_require("view.fight.ai.FlyAction")

local FlyMove =  game_require("view.fight.ai.FlyMove")
local Stand = game_require("view.fight.ai.Stand")

function FlyAI:_initAI(creature)
	self.moveAI = FlyMove.new()

	self.actionAI = FlyAction.new()
	self.standAI = Stand.new()
	self.moveAI:init(creature)
	self.actionAI:init(creature)
	self.standAI:init(creature)
	self:setActRange()
end

--function FlyAI:moveForward()
--	local tempTarget = {posLength=1}
--	if self.creature.cInfo.team == FightCommon.left then
--		tempTarget.mx = FightMap.W-2
--		tempTarget.my = math.floor(FightMap.H/2)
--	else
--		tempTarget.mx = 2
--		tempTarget.my = math.floor(FightMap.H/2)
--	end
--	tempTarget = nil
--	self.moveAI:setTarget(tempTarget)
--end

return FlyAI