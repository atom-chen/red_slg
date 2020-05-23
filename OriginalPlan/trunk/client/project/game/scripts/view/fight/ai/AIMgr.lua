--
-- Author: Your Name
-- Date: 2014-05-12 12:58:01
--
local pairs = pairs
local ipairs = ipairs
local table = table

AI = game_require("view.fight.ai.AI")
local FlyAI = game_require("view.fight.ai.FlyAI")
local BuildAI = game_require("view.fight.ai.BuildAI")
local BiontAI = game_require("view.fight.ai.BiontAI")

local AIMgr = class("AIMgr")

function AIMgr:ctor( )
	self.AI_CLASS = {}
	self._cAIList = {}
end

function AIMgr:start()

end

function AIMgr:initAI(creature)
	local id = creature.id
	local ai
	if creature.cInfo.scope == FightCfg.FLY then
		ai = FlyAI.new(id,creature)
	elseif creature.cInfo.heroType == 1 then
		ai = BuildAI.new(id,creature)
	elseif creature.cInfo.heroType == 2 then
		ai = BiontAI.new(id,creature)
	else
		ai = AI.new(id,creature)
	end

	self._cAIList[creature] = ai
	ai:start()
end

function AIMgr:getAI( creature )
	return self._cAIList[creature]
end

function AIMgr:removeAI( creature )
	local ai = self._cAIList[creature]
	if ai then
		self._cAIList[creature] = nil
		ai:dispose()
	end
end

function AIMgr:clear()
	for _,ai in pairs(self._cAIList) do
		ai:dispose()
	end
	self._cAIList = {}
end

function AIMgr:run(dt)
	for _,ai in pairs(self._cAIList) do
		ai:run(dt)
	end
end

function AIMgr:getAllAI()
	return self._cAIList
end


function AIMgr:getCreatureTarget(creature)
	local ai = self:getAI(creature)
	return ai.target
end

function AIMgr:getTargetInRange(creature,list,range,scope)
	local targetList = {}
	for i,target in ipairs(list) do
		if self:_isTargetInRangeByScope(creature,target,range,scope) then
			targetList[#targetList + 1 ] = target
		end
	end
	return targetList
end

function AIMgr:getAliveTargetInRange(creature,list,range,without)
	local targetList = {}
	for i,target in ipairs(list) do
		if not target:isDie() and (not without or table.indexOf(without,target) == -1)
			and self:_isTargetInRangeByScope(creature,target,range) then
			targetList[#targetList + 1 ] = target
		end
	end
	return targetList
end

function AIMgr:_isTargetInRangeByScope(creature,target,range,scope,sourcePos)
	sourcePos = sourcePos or creature
	return target:canBeSearch(creature,scope) and range:isTargetIn(sourcePos,target)
end

function AIMgr:getMagicTargetInRange( creature,magicInfo,range,scope,sourcePos,targetType)
	local targetList = creature:getMagicTarget(magicInfo,targetType)

	if magicInfo then
		local list = {}
		table.merge(list,targetList)
		return list
	end
	return self:_getTargetInRangeByScope(creature,targetList,range,scope,sourcePos)
end

function AIMgr:_getTargetInRangeByScope(creature,list,range,scope,sourcePos)
	local targetList = {}
	sourcePos = sourcePos or creature
	for i,target in pairs(list) do
		-- print("targetList 1111111",self:_canSkillSearch(creature,target,scope),range:isTargetIn(sourcePos,target))
		if self:_canSkillSearch(creature,target,scope) and range:isTargetIn(sourcePos,target) then
			targetList[#targetList + 1 ] = target
		end
	end
	return targetList
end

function AIMgr:_canSkillSearch(creature,target,atkScope)
	if target:isDie() then
		return false
	elseif creature.isPlayer then
		return true
	end
	if not Formula:isScopeContain(atkScope,target.cInfo.scope)  then
		return false
	end
	return true
end

function AIMgr:getOptimalTarget(creature, list )
	local weightFun = Formula.getEnemyWeight
	local optimalTarget = nil
	local maxWeight = -1000
	for i,target in ipairs(list) do

			local weight = weightFun(Formula,creature,target)
			--print("权重",weight , maxWeight)
			if weight > maxWeight then
	--			if creature.cInfo.id== TEST_HEROID_ID then
	--				print("AAAAAAAAAAAAAAAAAAEEEEEEEEE333",weight,maxWeight,optimalTarget and optimalTarget:isCityWall(),target:isCityWall())
	--			end
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

function AIMgr:checkAttackFlyTarget( target )
	local curArea = FightDirector:getFightArea()
	local nextArea =FightCfg:getNextFightArea(curArea)
	local flyArea =FightCfg:getNextFightArea(nextArea)
	local curCityWallBoss = FightEngine:getCityWallBoss( curArea )
	local nextCityWallBoss = FightEngine:getCityWallBoss( nextArea )
	if target and target.cInfo.echelonType then
		if curCityWallBoss and not curCityWallBoss:isDie() then
			if target.cInfo.echelonType >= flyArea then
				return false
			else
				if target.cInfo.echelonType == nextArea then
					return false
				end
			end
		end
--		and curCityWallBoss and nextCityWallBoss
--		and math.floor(target.cInfo.echelonType/10) > math.floor(curCityWallBoss.cInfo.echelonType/10) then
--		return false
	end
	return true
end

function AIMgr:getAliveTargetNear(creature,list,without)
	local nearTarget
	local dis = 100000

	for i,target in ipairs(list) do
		if not target:isDie() and (not without or table.indexOf(without,target) == -1)
			and target:canBeSearch(creature) then
				local s = math.abs(creature.mx - target.mx) + math.abs(creature.my - target.my)
				if dis > s then
					dis = s
					nearTarget = target
				end
		end
	end
	return nearTarget
end

function AIMgr:getDirection( creature,tx,ty )
	local sx,sy = creature:getPosition()
	local dx,dy = tx-sx,ty-sy
	return self:getDirectionBySpeed(dx,dy)
end

function AIMgr:getDirectionEx( creature,tx,ty )
	local sx,sy = creature:getPosition()
	local dx,dy = tx-sx,ty-sy
	return self:getDirectionBySpeedEx(dx,dy)
end

function AIMgr:getDirectionBySpeed(dx,dy)
	return Formula:getDirectionBySpeed(dx,dy)
end

function AIMgr:getDirectionBySpeedEx(dx,dy)
	return Formula:getDirectionBySpeedEx(dx,dy)
end


function AIMgr:isEnemy( creature,target )
	return creature.cInfo.team ~= target.cInfo.team
end

function AIMgr:getTeamMx(team,without)
	local cList = FightDirector:getScene():getTeamList(team)
	local mx = 0
	local num = 0
	for i,c in ipairs(cList) do
		if without ~= c then
			mx = mx + c.mx
			num = num + 1
		end
	end
	if num > 0 then
		return math.ceil(mx/num)
	else
		if team == FightCommon.right then
			return FightMap.W
		else
			return 0
		end
	end
end

--获取当前走在最前面的单位的x位置
function AIMgr:getForwardMx(team,without)
	local cList = FightDirector:getScene():getTeamList(team)
	local maxMx = 0
	local num = 0
	local compareFun = nil
	if team == FightCommon.left then
		maxMx = 0
		compareFun = function(x1,x2)
			return x1 > x2
		end
	else
		maxMx = FightMap.W
		compareFun = function(x1,x2)
			return x1 < x2
		end
	end
	local isFind = false
	for i,c in ipairs(cList) do
		if without ~= c and not c.forbidMove and not c.isBuild  then
			isFind = true
			if compareFun(c.mx,maxMx) then
				maxMx = c.mx
			end
		end
	end
	if isFind then
		if team == FightCommon.left then
			return math.max(maxMx-2,0)
		else
			return math.min(maxMx+2,FightMap.W)
		end
	else
		if team == FightCommon.left then
			return FightMap.W
		else
			return 0
		end
	end
end

return AIMgr.new()