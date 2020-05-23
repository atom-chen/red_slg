local Charm = class("Charm")

local CharmHandle = game_require("view.fight.handle.CharmHandle")

function Charm:ctor(creature)
	self._timeCount = 0
	self.arrowList = {}
	self.creature = creature
	self._charmCD = 0
end

function Charm:run(dt)
	self._charmCD = self._charmCD - dt
	if self._charmCD > 0 and not self.charmTargetId then
		return
	end
	if not self.charmTargetId then
		if FightDirector:isNetFight() then
			return
		end
		self._timeCount = self._timeCount + 1
		if self._timeCount%5 == 0 and self.creature.cStatus:canUseSkill() then
			local enemyList = FightDirector:getScene():getEnemyList(self.creature)
			-- self.creature.atkRange.maxDis = 10
			for i,enemy in ipairs(enemyList) do
				if CharmHandle:canBeCharm(enemy) and self.creature.atkRange:isTargetIn(self.creature,enemy,true) then
					self:setCharm(enemy)
					return
				end
			end
		end
	elseif self.charmTargetId then
		local target = FightDirector:getScene():getCreature(self.charmTargetId)
		if (not target) or (target:isDie()) or (not self.creature.cStatus:canUseSkill())  then
			-- print("--目标死了啊。。。。。")
			self:removeCharm()
			self._charmCD = self.creature.cInfo.main_atkCD
		else
			self:arrowTo(self.creature,target)
		end
	end
end

function Charm:getCharmTarget()
	if self.charmTargetId then
		return FightDirector:getScene():getCreature(self.charmTargetId)
	end
	return nil
end

function Charm:setCharm(target)
	self:removeCharm()
	self.charmTargetId = target.id

	CharmHandle:changeTeam(target,self.creature.cInfo.team,self.creature.id)  --被魅惑 改变队伍

	self.creature:addSkillCount()  --算是在使用技能

	FightTrigger:dispatchEvent({name=FightTrigger.CHARM_CREATURE,creature = target})
	FightTrigger:dispatchEvent({name=FightTrigger.CREATURE_DIE,creature = target,isCharm=true})
end

function Charm:removeCharm()
	if self.charmTargetId and FightDirector.status == FightCommon.start then
		local target = FightDirector:getScene():getCreature(self.charmTargetId)
		if target and not target:isDie() then
			CharmHandle:recoverTeam(target)  --变回原来队伍
		end
		self:removeAllArrow()
		self.charmTargetId = nil
		self.creature:removeSkillCount()  --使用技能结束
	end
end

function Charm:arrowTo(creature,target)
	local dis = Formula:getDistanceExact( creature,target )

	local lastX,lastY = self.creature:getPosition()
	lastY = lastY + 20
	local targetX,targetY = target:getPosition()
	targetY = targetY + 20
	local a,b,c = {x = lastX,y = lastY},{x=(lastX+targetX)/2,y=(lastY+targetY)/2+150},{x=targetX,y=targetY}
	local num = math.ceil(dis/25)
	if num >= 1 then
		for i=1,num do
			local arrow = self:getArrow(i)
			local x,y = self:bezier(a,b,c,i/num)
			arrow:setPosition(x,y)
			if not arrow:getParent() then
				FightDirector:getScene():addToTopLayer(arrow)
			end
			local r = math.atan2( y- lastY, x - lastX)
			r = -180*r/math.pi
			arrow:setRotation(r)
			lastX,lastY = x,y
		end
	end

	for i=num+1,#self.arrowList do
		self.arrowList[i]:removeFromParent()
	end
end

function Charm:bezier(a,b,c,t)
    -- /// t为0到1的小数。
    local n = 1-t
    local np2 = n*n
    local nt = n*t
    local tp2 = t*t
    local x = np2*a.x+2*nt*b.x+tp2*c.x
    local y = np2*a.y+2*nt*b.y+tp2*c.y
    return x,y
end

function Charm:removeAllArrow()
	for i,arrow in pairs(self.arrowList) do
		arrow:removeFromParent()
	end
end

function Charm:getArrow(index)
	if self.arrowList[index] then
		return self.arrowList[index]
	else
		-- local arrow = display.newXSprite("#fight_NUB_Yreduce.png")
		local arrow = display.newNode()
		local p = ParticleMgr:CreateParticleSystem(FightCfg.CHARM_PARTICLE)
		arrow:addChild(p)
		self.arrowList[index] = arrow
		arrow:retain()
		return arrow
	end
end

function Charm:dispose()
	self:removeCharm()
	for i,arrow in pairs(self.arrowList) do
		arrow:removeFromParent()
		arrow:release()
	end
	self.arrowList = nil
end

return Charm