--
-- Author: wdx
-- Date: 2014-04-16 14:31:57
--

--[[--
Round 为一个回合  RoundPerformer 为round 的  播放类

一个 Round 包含多个 Behavior
]]
local RoundPerformer = class("RoundPerformer")

local BehaviorPerformer = require("view.fight.performer.BehaviorPerformer")

function RoundPerformer:ctor(performer)
	self.parent = performer	
end

function RoundPerformer:perform(data)
	self.behaviorList = data
	self.curBehaviorIndex = 0
	self:_performNextBehavior()
end

--播放下个 行为
function RoundPerformer:_performNextBehavior()
	self.curBehaviorIndex = self.curBehaviorIndex + 1
	if self.behaviorList[self.curBehaviorIndex] then
		self:_performBehavior(self.behaviorList[self.curBehaviorIndex])
	else  --动作都播放完了    回合结束
		self.parent:performRoundEnd()
	end
end

--执行 行为播放
function RoundPerformer:_performBehavior(behavior)
	local bPerformer = BehaviorPerformer.new(self)
	bPerformer:perform(behavior)
end


--宠物出手 结束
function RoundPerformer:performBehaviorEnd()  
	self:_performNextBehavior()
end

