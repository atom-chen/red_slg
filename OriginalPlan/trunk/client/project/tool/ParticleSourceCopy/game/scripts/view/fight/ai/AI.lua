--
-- Author: wdx
-- Date: 2014-05-05 15:26:29
--
local Move = require("view.fight.ai.Move")
local Action = require("view.fight.ai.Action")


--[[--
  角色 ai 控制
]]
local AI = class("AI")

AI.ATTACK = 0
AI.DEFEND = 1
AI.ASSIST = 2


function AI:ctor(id,creature)
	self.id = id
	self.creature = creature
	self.searchTime = 0
	self.aiType = AI.ATTACK

	self.moveAI = Move.new()
	self.actionAI = Action.new()

	self.moveAI:init(creature)
	self.actionAI:init(creature)

	self.type = creature.ai
end

function AI:init( ... )

	--self.type = AI.ATTACK
	-- body
end

function AI:start()

	-- body
end

function AI:run(dt)

	if self.creature:isDie() then  --已经死了
		return
	end

	--local newTarget = self:getWarnTarget()
	--print("ai run")
	self.actionAI:run(dt)

	if self.creature:getSkillCount() > 0 then   --当前在播放技能  直接返回
		return 
	end

	self.moveAI:run(dt)
	if not self.moveAI:isInTileCenter() then  --还没走到走到格子中间了
		return
	end

	if self.creature.isWin then
		return 
	end

	if self.target == nil or self.target:isDie() then  --还没目标  寻找到一个目标
		self.target = self:getSearchTarget()

		if self.target then
			print(self.creature.id .."  的目标 :" , self.target.id)
		end
	end
	if self.target == nil then
		self.moveAI:setTarget(nil)
		print("没有找到目标？")
		return 
	else
		--local direction = AIMgr:getDirection(self.creature,self.target:getPosition())
		--self.creature:setDirection(direction)
	end

	local creature = self.creature
	local target = self.target

	--print("攻击范围：")
	if self.type == AI.ATTACK then
		local direction = AIMgr:getDirection(self.creature,self.target:getPosition())
		if creature.atkRange:isTargetIn(creature,target,true,direction) then   --是否在攻击范围内
			self.actionAI:attack(target)
		else  --不在攻击范围内   那么要移动过去
			self.moveAI:setTarget(target)
		end
	elseif self.type == AI.DEFEND then   --防御
		if creature.warnRange:isTargetIn(creature,target,true) then   --是否在警戒范围内
			self.actionAI:defend(target)
		else  --不在攻击范围内   那么要移动过去
			self.moveAI:setTarget(target)
		end
	elseif self.type == AI.ASSIST then  --辅助治疗
		target = self:getSearchTarget()  --每次都重新搜索是否附近有更 需要治疗的
		if creature.atkRange:isTargetIn(creature,target,true) then   --是否在攻击范围内
			self.actionAI:assist(target)
		else  --不在攻击范围内   那么要移动过去
			self.moveAI:setTarget(target)
		end
	end
end



function AI:getWarnTarget()
	return AIMgr:getEnemyTarget(self.creature,self.creature.warnRange)
end

function AI:getSearchTarget()
	
	local target = nil
	local range = self.creature.searchRange
	local count = 0
	repeat
		if self.type == AI.ATTACK then
			target = AIMgr:getEnemyTarget(self.creature,range)
		else
			target = AIMgr:getMateTarget(self.creature,range)
		end
		if target then
			break
		else
			count = count + 1
			range = range:getExtendRange(2)  --没找到目标  扩大搜索范围
			--print("dddrange",range.w,range.h)
		end
	until count > 5;
	return target
end


function AI:dispose( )
	-- body
end

return AI