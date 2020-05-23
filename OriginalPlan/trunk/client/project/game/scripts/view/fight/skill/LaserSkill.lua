local LaserSkill = class("LaserSkill",Skill)

function LaserSkill:ctor(gId)
	Skill.ctor(self,gId)
	self._noRotation = true
end

function LaserSkill:start()
	self.targetOffX,self.targetOffY = 0,0
	local target = self:getTarget()
	if target and target.posLength > 1 then
		local posLength = target.posLength
		self.targetOffX = math.random(-FightMap.HALF_TILE_W*(posLength*0.5),FightMap.HALF_TILE_W*(posLength*0.5))
		self.targetOffY = math.random(-FightMap.HALF_TILE_H*(posLength*0.5),FightMap.HALF_TILE_H*(posLength*0.5))
	end
	Skill.start(self)
end

function LaserSkill:run(dt)
	if self.curTime > 1000 then
		local target = self:getTarget()
		local creature = self:getCreature()
		if (not target) or target:isDie() or not creature.atkRange:isTargetIn(creature, target, true) then
			self:_skillEnd()
			return
		end
	end

	Skill.run(self,dt)
end

function LaserSkill:_createFrameMagic(creature,magicId,target)
	self.skillParams.targetOffX = self.targetOffX or 0
	self.skillParams.targetOffY = self.targetOffY or 0
	local magic = FightEngine:createMagic(creature,magicId,target,self.info,self.skillParams,self.gId) --播放一个魔法特效
	if magic then
		self.magicList[#self.magicList + 1] = magic.gId
		if target and target.posLength > 1 and FightCfg:getMagic(magicId).parent == 2 then
			local x,y = magic:getPosition()
			x = x + self.targetOffX
			y = y + self.targetOffY
			magic:setPosition(x,y)
		end
	end
	return magic
end

function LaserSkill:dispose()
	if self.info.fTime ~= 0 then
		for i,mId in ipairs(self.magicList) do
			local magic = FightEngine:getMagicById(mId)
			if magic then
				FightEngine:removeMagic(magic)
			end
		end
	end
	Skill.dispose(self)
end

return LaserSkill