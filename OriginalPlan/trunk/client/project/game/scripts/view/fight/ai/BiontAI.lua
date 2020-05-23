local BiontAI = class("BoinAI",AI)

function BiontAI:setMannedTarget(target)
	if target then
		self._mannedTargetId = target.id
	else
		self._mannedTargetId = nil
		if FightDirector:getMap():getTileContent(self.creature.mx, self.creature.my) ~= self.creature.id then
			local mx,my = self.creature.mx, self.creature.my
			if FightDirector:getMap():canOccupyRang(mx,my,self.creature.cInfo.posLength) then
				FightDirector:getMap():creatureMoveTo(self.creature,mx,my)
			else
				local tile = FightDirector:getMap():getNearGap(mx,my,self.creature)
				if tile then
					FightDirector:getMap():creatureMoveTo(self.creature,tile.mx,tile.my)
				end
			end
		end
	end
end

function BiontAI:getMannedTarget()
	if self._mannedTargetId then
		return FightDirector:getScene():getCreature(self._mannedTargetId)
	else
		return nil
	end
end

function BiontAI:run(dt)
	local mannedTarget = self:getMannedTarget()
	if mannedTarget then
		if not self._isMoveTo then
			self._isMoveTo = true
			FightEngine:stopCreatureSkill(self.creature)
		end

		if not self.isNoFindPath and self.moveAI:isInTileCenter() then
			local path = FightDirector:getMap():getPath(self.creature.mx,self.creature.my,mannedTarget.mx,mannedTarget.my,self.creature.posLength)
			if path and #path >= 4 then
				self.moveAI:setMoveTile(path[3],path[4])
			else
				self.isNoFindPath = true
			end
		end

		if self.isNoFindPath then
			local x,y = mannedTarget:getPosition()
			local pos = {x=x,y=y}
			self.moveAI:setMoveToTargetPos(pos)
			FightDirector:getMap():setTileContent(self.creature.mx, self.creature.my, FightMap.NONE)
			self.creature.mx,self.creature.my = FightDirector:getMap():getPreciseTilePos(self.creature)
		end
		self.moveAI:run(dt)
	else
		AI.run(self,dt)
	end
end

return BiontAI