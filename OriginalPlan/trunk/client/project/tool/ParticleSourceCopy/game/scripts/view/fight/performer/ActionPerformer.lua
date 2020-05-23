--
-- Author: wdx
-- Date: 2014-04-16 15:02:55
--
--[[--
Action 为一个动作      ActionPerformer 为一个 Action 的 播放类
Action 为整个战斗系统  可以是  使用一个技能  、一个buff作用、一个属性变化 等

一个action可以包含 多个子的action  有个children列表

]]

local ActionPerformer = class("ActionPerformer")

ActionPerformer.ACTION_END = "action_end"


function ActionPerformer:ctor()
	EventProtocol.extend(self)
end


function ActionPerformer:perform(action)
	self.action = action

	self._beforeActionCount = 0
	self._simulActionCount = 0
	self._insertActionCount = 0
	self._afterActionCount = 0

	if self:_beforActionPerform() == false then
		self:_simulActionPerform()
	end
end

--预先播放哪些 子aciton
function ActionPerformer:_beforActionPerform()
	local beforeActions = self.action:getActionList(Action.BEFORE)
	if #beforeActions > 0 then
		self._beforeActionCount = #beforeActions
		local callback = handler(self,self._onBeforActionEnd)
		self:_performActions(beforeActions,callback)
		return true
	else
		return false
	end
end

--预先播放都完成了
function ActionPerformer:_onBeforActionEnd()
	self._beforeActionCount = self._beforeActionCount -1
	if self._beforeActionCount == 0 then
		self:_simulActionPerform()
	end
end

--同时播放的 子aciton
function ActionPerformer:_simulActionPerform()
	local simulActions = self.action:getActionList(Action.SIMUL)
	if #simulActions > 0 then
		self._simulActionCount = #simulActions
		local callback = handler(self,self._onSimulActionEnd)
		self:_performActions(beforeActions,callback) 
	end
	self:_cruActionPerform()
end

--播放self
function ActionPerformer:_cruActionPerform()
	self._simulActionCount = self._simulActionCount + 1

	local skill = FightEngine:creatureSkill(self.action.id,self.action.skillId,self.action.target)

	skill:addKeyframeListener(Skill.ATTACK_KEY_FRAME,handler(self,self._insertActionPerform))
	skill:addKeyframeListener(SKill.END_KEY_FRAME,handler(self,self._afterActionPerform))
	
	FightEngine:addSkill(skill)
end

--同时播放的完成了 
function ActionPerformer:_onSimulActionEnd()
	self._simulActionCount = self._simulActionCount -1
	if self._simulActionCount == 0 then
		self:_afterActionPerform()
	end
end

--从中间插入播放的action
function ActionPerformer:_insertActionPerform()
	local insertActions = self.action:getActionList(Action.INSERT)
	if #insertActions > 0 then
		self._insertActionCount = #insertActions
		local callback = handler(self,self._onInsertActionEnd)
		self:_performActions(insertActions,callback)
	end
end

--从中间插入播放的action 完成了
function ActionPerformer:_onInsertActionEnd()
	self._insertActionCount = self._insertActionCount -1
	if self._insertActionCount == 0 then
		self:_checkAllPerformerEnd()
	end
end


--最后播放的 子aciton
function ActionPerformer:_afterActionPerform()
	local afterActions = self.action:getActionList(Action.AFTER)
	if #afterActions > 0 then
		self._afterActionCount = #afterActions
		local callback = handler(self,self._onAfterActionEnd)
		self:_performActions(afterActions,callback)
	end
end

--最后播放的也都完成了
function ActionPerformer:_onAfterActionEnd()
	self._afterActionCount = self._afterActionCount -1
	if self._afterActionCount == 0 then
		self:_checkAllPerformerEnd()
	end
end

--是否所有都播放完了
function ActionPerformer:_checkAllPerformerEnd()
	if self._simulActionCount == 0 and self._insertActionCount == 0 and self._afterActionCount == 0 then
		self:dispatchEvent({name=ActionPerformer.ACTION_END,actionPerformer=self})
	end
end


--执行一些子 aciton 
function ActionPerformer:_performActions(actions,callback)
	for i,action in ipairs(actions) do
		local aPerformer = ActionPerformer.new()
		aPerformer:addEventListener(ActionPerformer.ACTION_END,callback)
		aPerformer:perform(action)
	end
end