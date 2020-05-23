--
-- Author: Your Name
-- Date: 2014-05-12 12:58:01
--

AI = require("view.fight.ai.AI")

local AIMgr = class("AIMgr")


function AIMgr:ctor( )
	-- body
end

function AIMgr:start(creatureList)
	for i,creature in pairs(creatureList) do
		self:initAI(creature)
	end
end


function AIMgr:initAI(creature)
	local id = creature.id
	local ai = AI.new(id,creature)
	FightEngine:addAI(ai)


end

function AIMgr:getEnemyTarget(creature,range)
	local enemyList = FightDirector:getScene():getEnemyList(creature)

	local targetList = self:getTargetInRange(creature,enemyList,range)
	
	local optimalTarget = self:getOptimalTarget(creature,targetList,FightCommon.enemy)
	
	return optimalTarget
end

function AIMgr:getMateTarget(creature,range)
	local mateList = FightDirector:getScene():getMateList(creature)

	local targetList = self:getTargetInRange(creature,mateList,range)
	
	local optimalTarget = self:getOptimalTarget(creature,targetList,FightCommon.mate)
	return optimalTarget
end


function AIMgr:getTargetInRange(creature,list,range)
	local targetList = {}
	for i,enemy in ipairs(list) do
		if range:isTargetIn(creature,enemy) and not enemy:isDie() then
			targetList[#targetList + 1 ] = enemy
		end
	end
	return targetList
end

function AIMgr:getOptimalTarget(creature, list,type )
	local weightFun
	if type == FightCommon.enemy then
		weightFun = Formula.getEnemyWeight
	else
		weightFun = Formula.getMateWeight
	end

	local optimalTarget = nil
	local maxWeight = -1
	for i,target in ipairs(list) do
		local weight = weightFun(Formula,creature,target)
		--print("权重",weight , maxWeight)
		if weight > maxWeight then
			maxWeight = weight
			optimalTarget = target
		elseif weight == maxWeight and optimalTarget then
			local distance1 = FightDirector:getMap():getDistance(creature,optimalTarget)
			local distance2 = FightDirector:getMap():getDistance(creature,target)
			--print("更换目标",distance1,distance2)
			if distance1 > distance2 then
				optimalTarget = target
			end
		end
	end
	return optimalTarget
end

function AIMgr:getDirection( creature,targetX,targetY )
	local curPosX,curPosY = creature:getPosition()
	local direction = 1
	if targetX < curPosX then
		direction = 2
	elseif targetX > curPosX then
		direction = 1
	else
		direction = creature:getHorizontalDirection()
	end

	if targetY < curPosY then
		direction = 10 + direction
	elseif targetY > curPosY then
		direction = 20 + direction
	else
		direction = creature:getVerticalDirection()*10 + direction
	end
	return direction
end

return AIMgr.new()


