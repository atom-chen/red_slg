
local pairs = pairs
local ipairs = ipairs
local table = table
local MoveMagicHandle = game_require("view.fight.handle.MoveMagicHandle")
local Move = game_require("view.fight.ai.Move")
local Action = game_require("view.fight.ai.Action")
local Stand = game_require("view.fight.ai.Stand")

--[[--
  角色 ai 控制
]]
local AI = class("AI")
TEST_HEROID_ID = -1
local SEARCH_TIME = 500
function AI:ctor(id,creature)
	self.id = id
	self.creature = creature
	self.creature:retain()
	self:_initAI(creature)
	self._waitTime = 0
	if creature.cInfo.moveMagic or creature.cInfo.standMagic then
		self.moveMagicHandle = MoveMagicHandle.new()
	end
	self.searchTime = 600
end

function AI:_initAI( creature )
	self.moveAI = Move.new()
	self.standAI = Stand.new()
	self.actionAI = self:_newAction(creature)
	self.moveAI:init(creature)
	self.actionAI:init(creature)
	self.standAI:init(creature)
	self:setActRange()
end

function AI:setActRange()
	local atkRange,tbl = self:getAtkRange()
	self.creature:setAtkRange(tbl)
end
function AI:_newAction(creature)
	return Action.new()
end

function AI:start()
	self._noFindPathTarget = {} --找不到路的目标
	self:updateBuildTarget()
	self._waitTime = 0
end

function AI:updateBuildTarget()
	local target
	if self.creature.cInfo.team == FightCommon.mate then
		target = FightDirector:getScene():getHQ(FightCommon.enemy)
	end
	self:setBuildTarget(target)
end

function AI:setBuildTarget(target)
	if target and not target:isDie() and target:canBeSearch(self.creature) then
		self.targetBuild = target
	else
		self.targetBuild = nil
	end
end

--改变移动目的地
function AI:setMoveTile( mx,my )
	self.moveAI:setMoveTile(mx,my)
end

--改变移动的目标点
function AI:setMoveToTargetPos( pos )
	self.moveAI:setMoveToTargetPos(pos)
end

function AI:setWaitTime(time)
	self._waitTime = time
end

function AI:runCongeal( dt )
	self:run(dt)
end

function AI:run(dt)
	self.searchTime = self.searchTime + dt
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AI:run(dt)  tttt00000000000000000",self.creature.id,self.searchTime)
	end
	if self.creature:isDie() then  --已经死了
		self:showMoveMagic(false)
		return
	end
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AI:run(dt)  tttt1111111111111111111")
	end
	self.actionAI:run(dt)
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AI:run(dt)  tttt22222222222222")
	end
	if self.creature:getSkillCount() > 0 then   --当前在播放技能  直接返回
		self:showMoveMagic(false)
		return
	end
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AI:run(dt)  tttt222222222222221111")
	end
	if self._waitTime > 0 then
		self._waitTime = self._waitTime - dt
		if self._waitTime > 0 then
			self.standAI:run(dt)
			return
		end
	end
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AI:run(dt)  tttt3333333333333")
	end
	local isDoAction = false
	repeat
		if not self.moveAI:isInTileCenter() then  --还没走到走到格子中间了
			if self.creature.cInfo.id== TEST_HEROID_ID then
				print("AI:run(dt)  ttttrrrrrrrrrrr")
			end
			break
		end
		if FightDirector.status ~= FightCommon.start then
			break
		end

		if self.creature.isWin then  --胜利了
			break
		end
		if self.creature.cInfo.id== TEST_HEROID_ID then
			print("AI:run(dt)  tttt444444444444")
		end
        isDoAction = self:doAction(dt)  --使用技能 做反应 等
	until true

	if self.creature:getSkillCount() > 0 then   --当前在播放技能  直接返回
		self:showMoveMagic(false)
		return
	end

	if isDoAction then
		self._noFindPathTarget = {}
		return
	end

	if self.moveAI:run(dt) then  --移动
		self:showMoveMagic(true)
	else
		self:showMoveMagic(false)
		self.standAI:run(dt)   --待机站立
	end
end

function AI:showMoveMagic(flag)
	if self.moveMagicHandle then
		if flag then
			self.moveMagicHandle:showMoveMagic(self.creature)
		else
			self.moveMagicHandle:removeMoveMagic(self.creature)
		end
	end
end

function AI:doAction(dt)
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AI:doAction(dt)  tttt000000000000")
	end
	if FightDirector:isNetFight() then
		return false
	end

	if not self.creature:canSearch() or (self.target and self.target:isDie()) then   --不能搜索目标    恐惧
		self:_setNewTarget(nil)
		return false
	end
	if self.target and self.creature.cInfo.career == 5 and self.target.cInfo.hp >= self.target.cInfo.maxHp then
		self:_setNewTarget(nil)
	end
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AI:doAction(dt)  tttt111111111111")
	end
	if not self.target or self.target == self.targetBuild then  --还没目标  寻找到一个目标
		if self.searchTime < SEARCH_TIME then
			if self.creature.cInfo.id== TEST_HEROID_ID then
				print("JJJJJJJJJJJJJJJJJJJJJJ",self.creature.id,self.searchTime,self.target)
			end
			return false
		end
		if self.creature.cInfo.id== TEST_HEROID_ID then
			print("AI:doAction(dt)  tttt222222222")
		end
		self.searchTime = 0
		local newTarget = self:getSearchTarget(self._noFindPathTarget)
		if newTarget then
			self:_setNewTarget(newTarget)
		elseif not self.target then
			self._noFindPathTarget = {}
			if self.creature.cInfo.id== TEST_HEROID_ID then
				print("AI:doAction(dt)  ooooooooooo")
			end
			return
		end
	end
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AI:doAction(dt)  tttt333333333333")
	end
	if self.target == nil then  --没有目标
		if self.creature.cInfo.scope ~= 1 then
			self:setWaitTime(500)
		end
		return
	end
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AI:doAction(dt)  tttt444444444")
	end
	local flag = self:_runAttackAI(dt)
	return flag
end

function AI:_runAttackAI( dt )

	local target = self.target
	local creature = self.creature
	if self:_checkTargetAIBuff(target) then
		local newTarget = self:getTargetByFightArea(self.creature)
		if newTarget then
			self:_setNewTarget(newTarget)  --设置攻击目标
			if self.creature.cInfo.id== TEST_HEROID_ID then
				print("AAAAAAAAAAAAAAAAAAFFFFF666666")
			end
			return
		end
	end
	local atkRange = self.creature.atkRange--self:getAtkRange()
	local canAtk = Formula:isScopeContain(atkRange.atkScope,target.cInfo.scope)
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("UUUUUUUUUUUUUUUUUUUU",atkRange.maxDis,self.creature.mx,self.creature.my,target.mx,target.my)
	end

	if atkRange:isTargetIn(creature,target,true) and  canAtk then   --是否在攻击范围内
		if self.creature.cInfo.id== TEST_HEROID_ID then
			print("UUUUUUUUUUUUUUUUUUUU111",atkRange.maxDis,self.creature.mx,self.creature.my,target.mx,target.my)
		end
		return self.actionAI:attack()
	else  --不在攻击范围内
		if self.creature.cInfo.id== TEST_HEROID_ID then
			print("UUUUUUUUUUUUUUUUUUUU222",atkRange.maxDis,self.creature.mx,self.creature.my,target.mx,target.my)
		end
		if creature:canMove() then
			self:move()  --那么要移动过去
			if self.creature.cInfo.id== TEST_HEROID_ID then
				print("AAAAAAAAAAAAAAAAAAFFFFF88888")
			end
		else
			self.standAI:run(dt)   --待机站立
			self:_setNewTarget(nil)
			if self.creature.cInfo.id== TEST_HEROID_ID then
				print("AAAAAAAAAAAAAAAAAAFFFFF99999")
			end
		end
	end
	return false
end

function AI:getAtkRange()
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("QQQQQQQQQQQQQQ00000000000")
	end
	local skillId = SkillCfg:calSkillId(self.creature.cInfo.skills,self.creature.cInfo.skillTurn,self.actionAI:getCurSkillIndex())
	local skillInfo = nil
	local tab = {0,0}
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("QQQQQQQQQQQQQQ11111111",skillId)
	end
	if skillId and skillId>0 then
		skillInfo = SkillCfg:getSkill(skillId)
		tab = skillInfo and skillInfo.range or {0}
		if self.creature.cInfo.id== TEST_HEROID_ID then
			print("QQQQQQQQQQQQQQ222222",skillId)
		end
	end
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("QQQQQQQQQQQQQQ33333",dump(tab))
	end
	local atkRange = Range.new(tab)
	atkRange.atkScope = self.creature.cInfo.atkScope[1]
	return atkRange,tab
end

function AI:_setNewTarget( newTarget )
	if self.target ~= newTarget then
		self.target = newTarget
		self.moveAI:setTarget(newTarget)
		self.actionAI:setTarget(newTarget)
		return true
	end
	return true
end

function AI:move()
	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AAAAAAAAAAAAAAAAAADDDDDDDD22222")
	end
	if not self.moveAI:move() then  --移动失败  把目标标记为寻不到路目标  下次再重新寻找目标
		if self.creature.cInfo.id== TEST_HEROID_ID then
			print("AI:move()yyyyyyyy")
		end
		self:setWaitTime(500)
		self._noFindPathTarget[#self._noFindPathTarget+1] = self.target
		--print("切换nil 目标  1",self.creature.cInfo.name)
		self:_setNewTarget(nil)

		--print("需要重新找目标")
	else
		self._noFindPathTarget = {}
		if self.creature.cInfo.id== TEST_HEROID_ID then
			print("AAAAAAAAAAAAAAAAAADDDDDDDD888888")
		end
	end
	-- body
end

function AI:getTargettList( isMate )
	local team = FightCommon.enemy
	if isMate then
		team = FightCommon.mate
	end

	local list = self.creature:getTeamList(team)
	list = self:FightAreaFilt(self.creature,list)
	return list
end

function AI:_checkTargetAIBuff(target)
	if self.target_ai_buff_id then
		local bList = target:getBuffList()
		for i,buff in ipairs(bList) do
			if buff.buffId == self.target_ai_buff_id then
				return true
			end
		end
	end
	return false
end

function AI:getTargetByFightArea(without,creature)
	local tList = self:getTargettList(creature.cInfo.career == 5)
	local warnRange = Range.new({1000,0})
	local atkList = AIMgr:getAliveTargetInRange(self.creature,tList,warnRange,without)
	local target
	if #atkList > 0 then
		target = AIMgr:getOptimalTarget(self.creature,atkList)
		if not target then
			target = AIMgr:getAliveTargetNear(creature,atkList,without)
		end
	end

	return target,atkList
end

function AI:FightAreaFilt(creature,list)
	local curArea = FightDirector:getFightArea()
	local nextArea =FightCfg:getNextFightArea(curArea)
	local flyArea =FightCfg:getNextFightArea(nextArea)

	local retlist= {}
	local skillId = SkillCfg:calSkillId(creature.cInfo.skills,creature.cInfo.skillTurn,self.actionAI:getCurSkillIndex())
	local skillInfo = nil
	if skillId and skillId>0 then
		skillInfo = SkillCfg:getSkill(skillId)
	else
		return retlist
	end

	local curCityWallBoss = FightEngine:getCityWallBoss( curArea )
	local nextCityWallBoss = FightEngine:getCityWallBoss( nextArea )
	local flyCityWallBoss = FightEngine:getCityWallBoss( flyArea )

	local addElemForList = function( list,elem )
				if self.creature.cInfo.career == 5 then
					if elem ~= creature and  elem.cInfo.hp<elem.cInfo.maxHp then
						table.insert(list,elem)
					end
				else
					table.insert(list,elem)
				end

			return list
		end

	local defendCheckAndAdd = function( elem)
		local cityBoss = {curCityWallBoss,nextCityWallBoss,flyCityWallBoss}
		local cityWallMX = {}
		for k,v in pairs(cityBoss) do
			if v then
				table.insert(cityWallMX,v.mx)
			end
		end
		local intervalIndex = 0
		local minMx = math.min(self.creature.mx,elem.mx)
		local maxMx = math.max(self.creature.mx,elem.mx)
		local dx = 0
		for k,v in ipairs(cityWallMX) do
			if v>minMx and v<maxMx then
				intervalIndex = intervalIndex +1
				dx = v
			end
		end
		if self.creature.cInfo.echelonType then
			if intervalIndex == 0 then
				retlist = addElemForList(retlist,elem)
			elseif intervalIndex == 1 then
				if self.creature.cInfo.scope == FightCfg.FLY then
					retlist = addElemForList(retlist,elem)
				else
					local dis = Formula:getCreatureDistance(self.creature,elem)
					if self.creature.cInfo.echelonType%10 == 2 then
						if self.creature.my~= elem.my then
							dis = math.abs(dis*( math.abs(dx-elem.mx)/math.abs(self.creature.mx-elem.mx)))
						else
							dis = math.abs(dx-elem.mx)
						end
						local atkRange = skillInfo and skillInfo.range and skillInfo.range[1]--攻击范围
						if dis+2 <= atkRange then
							retlist = addElemForList(retlist,elem)
						end
					elseif self.creature.cInfo.echelonType%10 == 3 or self.creature.cInfo.echelonType%10 == 1 then
						retlist = addElemForList(retlist,elem)
					end

				end
			end
		end
	end

	local attackCheckAndAdd = function( elem)
		local cityBoss = {curCityWallBoss,nextCityWallBoss,flyCityWallBoss}
		local cityWallMX = {}
		for k,v in pairs(cityBoss) do
			if v then
				table.insert(cityWallMX,v.mx)
			end
		end
		local intervalIndex = 0
		local minMx = math.min(self.creature.mx,elem.mx)
		local maxMx = math.max(self.creature.mx,elem.mx)
		for k,v in ipairs(cityWallMX) do
			if v>minMx and v<maxMx then
				intervalIndex = intervalIndex +1
			end
		end

		--if self.creature:canMove() then
			if intervalIndex == 0 then
				retlist = addElemForList(retlist,elem)
			elseif intervalIndex == 1 then
				if self.creature.cInfo.scope == FightCfg.FLY then
					if AIMgr:checkAttackFlyTarget(elem) then
						retlist = addElemForList(retlist,elem)
					end
				else
					retlist = addElemForList(retlist,elem)
				end
			end
		--end
	end

	for k,v in pairs( list ) do
		if creature.cInfo.team == FightCommon.left then
			attackCheckAndAdd(v)
		else
			--走到城墙后是否在攻击范围内,不在攻击范围内就不作为搜索目标
			defendCheckAndAdd(v)
		end
	end
	return retlist
end

function AI:getTargetByRange(without,range)
	local tList = self:getTargettList(self.creature.cInfo.career == 5)
	local atkList = AIMgr:getAliveTargetInRange(self.creature,tList,range,without)
	local target
	if #atkList > 0 then
		if self.target_ai_buff_id then
			for i=#atkList,1,-1 do
				if self:_checkTargetAIBuff(atkList[i]) then  --去掉有对应bf的目标
					table.remove(atkList,i)
				end
			end
		end
		target = AIMgr:getOptimalTarget(self.creature,atkList)
	end
	return target
end


function AI:getSearchTarget(without)
	local target,tList = self:getTargetByFightArea(without,self.creature)
	if not target and (not self.targetBuild or self.targetBuild:isDie() )  then
		local isAllIgnore = true
		for i,c in pairs(tList) do
			if not self.creature:isInIgnore(c) then
				isAllIgnore = false
				break
			end
		end
		if isAllIgnore then
			for i,c in pairs(tList) do
				if c:canBeSearchEx(self.creature) then
					return c
				end
			end
		end
--		if self.creature.cInfo.atkScope[2] then  --让副武器搜索敌人
--			for i,c in pairs(tList) do
--				if not c:isDie() and c:canBeSearchEx(self.creature,self.creature.cInfo.atkScope[2]) then
--					if not self.creature:isInIgnore(c) then
--						return c
--					else
--						target = c
--					end
--				end
--			end
--		end
	end

	if not target and self.creature.cInfo.career~=5 then
		if self.creature.cInfo.team == FightCommon.left then
			if self.creature.cInfo.id== TEST_HEROID_ID then
				print("JJJJJJJJJJJJJJJJJJJJJJppp",self.creature.id,target)
			end
			return self.targetBuild
		end
	end
	return target
end

function AI:dispose()
	if self.moveMagicHandle then
		self.moveMagicHandle:dispose()
		self.moveMagicHandle = nil
	end
	-- self.creature:removeEventListener(Creature.BE_ATTACK,{self,self._beAttack})
	self.moveAI:dispose()
	self.moveAI = nil
	self.actionAI:dispose()
	self.actionAI = nil
	self.standAI:dispose()
	self.standAI = nil
	self.creature:release()

	self.target = nil
end

return AI