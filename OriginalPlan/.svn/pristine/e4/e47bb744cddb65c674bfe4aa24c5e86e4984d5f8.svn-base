--娜塔莎 激光轰炸机

local Action = game_require("view.fight.ai.Action")

local PointBombAction = class("PointBombAction",Action)
local ArrowLine = game_require("view.fight.fightUI.ArrowLine")
local MultiAvatar = game_require("view.fight.creature.MultiAvatar")

local MAX_BOMB_TIEM = 3000
function PointBombAction:minorAttack(dt)
	local target = self:_getCurPointTarget()
	if target and not target:isDie() then
		if self._arrowTime < MAX_BOMB_TIEM and (self._arrowTime + dt) >= MAX_BOMB_TIEM  then
			self:_bombTarget(target)
		end
		self._arrowTime = self._arrowTime + dt
		if self._isBombEnd then
			self:_removeLine()
		else
			self:_lineTo(target)
		end
	else
		self:_removeLine()
		if self._curPointTargetId == nil then
			local target = self:_getNewPointTarget()
			if target then
				self._arrowTime = 0
				self._curPointTargetId = target.id
			end
		end
	end
	self:_planeFlyRun(dt)
	if self:_isPlaneFlyEnd() then  --飞机完全飞完了
		self:_removeLine()
		self:_removePlane()
		self._curPointTargetId = nil
		return true
	end
end

function PointBombAction:_getNewPointTarget()
	local atkRange = self.creature:getAtkRangeByWeapon(FightCfg.MINOR_ATTACK)  --副武器
	local enemyList = FightDirector:getScene():getEnemyList(self.creature)
	for i,enemy in ipairs(enemyList) do
		if not enemy:isDie() and enemy:canBeSearch(self.creature,atkRange.atkScope)
				and not self.creature:isInIgnore(enemy)
				and atkRange:isTargetIn(self.creature, enemy, true) then
			return enemy
		end
	end
end

function PointBombAction:_getCurPointTarget()
	if self._curPointTargetId then
		return FightDirector:getScene():getCreature(self._curPointTargetId)
	else
		return nil
	end
end

function PointBombAction:_lineTo(target)
	if not self._arrowLine then
		self._arrowLine = ArrowLine.new()
		self._arrowLine:retain()
		FightDirector:getScene().bottomLayrer:addChild(self._arrowLine)

		local skillInfo = SkillCfg:getSkill(self.creature.cInfo.skills_1[1])
		local magicId = skillInfo.keyMagic[1]
		local magicInfo = FightCfg:getMagic(magicId)
		local pId = magicInfo.pId[1]
		self._arrowLine:setParticle(pId)
	end
	self._arrowLine:arrowTo(self.creature,target)
end

function PointBombAction:_bombTarget(target)
	if not self._plane then
		local res = "hero/migFighter"
		self._plane = MultiAvatar.new()
		self._plane:retain()
		self._plane:initWithResName(res)
		FightCache:retainAnima(res)
		FightDirector:getScene().topLayer:addChild(self._plane)
	end

	local speed = Formula:transformSpeed(250)--

	local x,y = target:getTruePosition()

	self.srcPos = {}
	self.srcPos.x = (self.creature.cInfo.team == FightCommon.left and x - 500 ) or (x + 500)
	self.srcPos.y = display.height
	self.targetPos = {}
	self.targetPos.x = (self.creature.cInfo.team == FightCommon.left and x + 500 ) or (x - 500)
	self.targetPos.y = display.height

	self.middle = {x=x ,y=y}

	self.totalTime = (math.abs(self.targetPos.x-self.srcPos.x)+math.abs(self.targetPos.y-self.srcPos.y))/speed

	self.curTime = 0

	self._plane:setPosition(self.srcPos.x,self.srcPos.y)
	self._moveTime = 0

	-- if self.targetPos.x > self.srcPos.x then
	-- 	self._plane:setScaleX(1)
	-- else
	-- 	self._plane:setScaleX(-1)
	-- end

	self.speed = 1

	self:_planeFlyRun(10)
end

function PointBombAction:_getPlanePos(r)
	return self:bezier(self.srcPos,self.middle,self.targetPos,r)
end

function PointBombAction:bezier(a,b,c,t)
    local n = 1-t
    local np2 = n*n
    local nt = n*t
    local tp2 = t*t
    local x = np2*a.x+2*nt*b.x+tp2*c.x
    local y = np2*a.y+2*nt*b.y+tp2*c.y
    return x,y
end

function PointBombAction:_planeFlyRun(dt)
	if self._plane then
		if self._moveTime < self.totalTime then
			-- self.speed = self.speed + dt*(-0.0001)
			self.speed = math.max(0.5,self.speed)
			self._moveTime = self._moveTime + dt*self.speed
			if self._moveTime > self.totalTime then
				self._moveTime = self.totalTime
			end
			local lastX = self._plane:getPositionX()
			local nextX,nextY = self:_getPlanePos(self._moveTime/self.totalTime)
			local direction = AIMgr:getDirectionEx( self._plane,nextX,nextY)
			self._plane:setDirection(direction)

			self._plane:setPosition(nextX,nextY)

			self:_checkBomb(lastX,nextX)

			self._plane:showAnimateFrame(0,Creature.STAND_ACTION)

			-- local height = self.srcPos.y - self.middle.y
			-- local scale = 1.2*(nextY - self.middle.y)/height
			-- scale = math.max(0.8,scale)
			-- self._plane:setScale(scale)

		else
			self._isFlyEnd = true
		end
	end
end

function PointBombAction:_checkBomb(lastX,nextX)
	if (self.middle.x - lastX)*(self.middle.x - nextX) <= 0 then
		self._isBombEnd = true
		local target = self:_getCurPointTarget()
		if target then
			local NewHandle = game_require("view.fight.handle.NewHandle")
			local skillId = self.creature.cInfo.skills_1[2]
			local skillObj = self.creature.cInfo.skillObj[skillId]
			skillObj.weapon = FightCfg.MINOR_ATTACK
			skillObj.scope = self.creature:getAtkScope(FightCfg.MINOR_ATTACK)
			skillObj.x,skillObj.y = self._plane:getPosition()
			local skill = NewHandle:createSkill(self.creature,skillId,target,skillObj)
		end
	end
end

function PointBombAction:_isPlaneFlyEnd()
	return self._isFlyEnd
end

function PointBombAction:_removePlane()
	self._isFlyEnd = false
	self._isBombEnd = false
	if self._plane then
		self._plane:removeFromParent()
		self._plane:release()
		self._plane = nil
	end

end

function PointBombAction:_removeLine()
	if self._arrowLine then
		self._arrowLine:removeFromParent()
		self._arrowLine:release()
		self._arrowLine = nil
	end
end

function PointBombAction:dispose()
	self:_removeLine()
	self:_removePlane()
	Action.dispose(self)
end

return PointBombAction