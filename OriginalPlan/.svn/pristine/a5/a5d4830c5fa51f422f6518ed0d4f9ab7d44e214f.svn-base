local StatsUnitNumDelegate = class("StatsUnitNumDelegate")

function StatsUnitNumDelegate:ctor(panel)
	self.panel = panel
	self.curAttackPNum = 0
	self.curDefpNum = 0
	FightTrigger:addEventListener(FightTrigger.ADD_CREATURE, {self,self._onAddCreature})
end

function StatsUnitNumDelegate:start()
	FightTrigger:addEventListener(FightTrigger.CREATURE_DIE, {self,self._onCreatureDie},-1)
	self:updateText()
end

function StatsUnitNumDelegate:_onCreatureDie(e)
	local creature = e.creature
	if creature then
		if creature.cInfo.team == FightCommon.blue then
			self.curAttackPNum = self.curAttackPNum - 1
			self.panel.attack_num_text:setText(tostring(self.curAttackPNum))
		else
			if creature:isCityWall() then
				if creature:isCityWallBoss( math.floor(creature.cInfo.echelonType/10)*10) then
					self.curDefpNum = self.curDefpNum -1
				end
			else
				self.curDefpNum = self.curDefpNum -1
			end
			self.panel.defence_num_text:setText(tostring(self.curDefpNum))
		end
	end
end

function StatsUnitNumDelegate:_onAddCreature(e)
	local creature = e.creature
	if creature then
		if creature.cInfo.team == FightCommon.blue then
			self.curAttackPNum = self.curAttackPNum + 1
		else
			if creature:isCityWall() then
				if creature:isCityWallBoss( math.floor(creature.cInfo.echelonType/10)*10) then
					self.curDefpNum = self.curDefpNum +1
				end
			else
				self.curDefpNum = self.curDefpNum +1
			end
		end
		self:updateText()
	end
end

function StatsUnitNumDelegate:updateText()
	self.panel.defence_num_text:setText(tostring(self.curDefpNum))
	self.panel.attack_num_text:setText(tostring(self.curAttackPNum))
end

function StatsUnitNumDelegate:clear()
	FightTrigger:addEventListener(FightTrigger.CREATURE_DIE, {self,self._onCreatureDie},-1)
	self.curAttackPNum = 0
	self.curDefpNum = 0
end

return StatsUnitNumDelegate