--
-- Author: wdx
-- Date: 2014-04-17 14:13:19
--

--[[--
 Behavior 一个 宠物的 出手行动  BehaviorPerformer 为  Behavior 播放类
一个 Behavior 包含多个Action
]]

local BehaviorPerformer = class("BehaviorPerformer")

local ActionPerformer = require("view.fight.performer.ActionPerformer")

local ReformActions = require("view.fight.performer.ReformActions")

function BehaviorPerformer:ctor()
	
end

function BehaviorPerformer:perform(data)

	self.curActionIndex = 0

	local reformAction = ReformActions.new()

	self.actionList = reformAction:reform(data)  --把数据 reform 成适合 客户端的播放 格式

	self:_performNextAction()
end


function BehaviorPerformer:_performNextAction()
	self.curActionIndex = self.curActionIndex + 1
	if self.actionList[self.curActionIndex] then
		self:_performAction(self.actionList[self.curActionIndex])
	else  --所有动作action都播放完了    
		self.parent:performBehaviorEnd(self)
	end
end

--执行一个aciton
function BehaviorPerformer:_performAction(action)
	local aPerformer = ActionPerformer.new()
	aPerformer:addEventListener(ActionPerformer.ACTION_END,{self,self.performActionEnd})
	aPerformer:perform(action)
end


--一个action 结束
function BehaviorPerformer:performActionEnd()  
	self:_performNextAction()
end
