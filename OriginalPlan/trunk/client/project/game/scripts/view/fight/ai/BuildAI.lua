local BuildAI = class("BuildAI",AI)

local Action = game_require("view.fight.ai.Action")
local Stand = game_require("view.fight.ai.Stand")

function BuildAI:_initAI(creature)
	if creature:canUseSkill() then
		self.actionAI = self:_newAction(creature)
		self.actionAI:init(creature)
	else
		-- self.actionAI = {}
		-- local mt = {__index = function() print("buildAI has no actionAI ") return function() end end}
		-- setmetatable(self.actionAI, mt)
	end
	self.standAI = Stand.new()
	self.standAI:init(creature)
end

function BuildAI:start()
	if self.creature:canUseSkill() then
		AI.start(self)
	end
end

function BuildAI:moveForward()

end

--改变移动目的地
function BuildAI:setMoveTile( mx,my )
end

--改变移动的目标点
function BuildAI:setMoveToTargetPos( pos )
end


function BuildAI:run(dt)
	if self.creature:isDie() then  --已经死了
		return
	end
	self.searchTime = self.searchTime + dt
	local isDoAction
	if self.actionAI then
		self.actionAI:run(dt)

		if self.creature:getSkillCount() > 0 then   --当前在播放技能  直接返回
			return
		end
		if self.creature.cInfo.id ==TEST_HEROID_ID then
			print("KKKKKKKKKKKKKRRRRRRRRRRRR")
		end
		isDoAction = self:doAction(dt)  --使用技能 做反应 等
	end
	if not isDoAction then
		self.standAI:run(dt)   --待机站立
	end
end

function BuildAI:move()
end

function BuildAI:_setNewTarget( newTarget )
	if self.target ~= newTarget then
		self.target = newTarget
		if self.actionAI then
			self.actionAI:setTarget(newTarget)
		end
		return true
	end
	return true
end

function BuildAI:dispose( )
	-- self.creature:removeEventListener(Creature.BE_ATTACK,{self,self._beAttack})
	if self.actionAI then
		self.actionAI:dispose()
		self.actionAI = nil
	end
	self.standAI:dispose()
	self.standAI = nil
	self.creature:release()

	self.target = nil
end

return BuildAI