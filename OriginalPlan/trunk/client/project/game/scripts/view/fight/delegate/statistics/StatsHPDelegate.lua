local StatsHPDelegate = class("StatsUnitNumDelegate")

function StatsHPDelegate:ctor(panel)
	self.panel = panel
	self.attack_creture_list = {}
	self.def_creture_list = {}

	FightTrigger:addEventListener(FightTrigger.ADD_CREATURE, {self,self._onAddCreature},-2)
end

function StatsHPDelegate:_onAddCreature(e)
	local creature = e.creature
	if creature then
		if creature.cInfo.team == FightCommon.left then
			table.insert(self.attack_creture_list,creature)
		elseif creature.cInfo.team == FightCommon.right then
			if creature:isCityWall() then
				if creature:isCityWallBoss( math.floor(creature.cInfo.echelonType/10)*10) then
					table.insert(self.def_creture_list,creature)
				end
			else
				table.insert(self.def_creture_list,creature)
			end
		end
	end
end

function StatsHPDelegate:_onHpChange( e )
	local creature = e.creature
	if creature and table.indexOf(self.attack_creture_list,creature)~=-1
		or table.indexOf(self.def_creture_list,creature)~=-1 then
		self._isChange = true
	end
end

function StatsHPDelegate:start()
	FightEngine:addRunner(self)
	self._curTime = 0
	self._isChange = 0
	FightTrigger:addEventListener(FightTrigger.CREATURE_CHANGE_HP, {self,self._onHpChange})
	self.maxAttackSumHp = self.curAttackSumHp
	self.maxDefSumHp = self.curDefSumHp
	self:updateText()

end

function StatsHPDelegate:run(dt)
	self._curTime = self._curTime +  dt
	if self._isChange and self._curTime > 500 then
		self:updateText()
		self._curTime = 0
		self._isChange = false
	end
end

function StatsHPDelegate:updateText()
	local  curAttackSumHp = 0
	local  maxAttackSumHp = 0
	for k,v in ipairs(self.attack_creture_list) do
		maxAttackSumHp = maxAttackSumHp + v.cInfo.maxHp
		curAttackSumHp = curAttackSumHp + v.cInfo.hp
	end

	local curDefSumHp = 0
	local maxDefSumHp = 0
	for k,v in ipairs(self.def_creture_list) do
		maxDefSumHp = maxDefSumHp + v.cInfo.maxHp
		curDefSumHp = curDefSumHp + v.cInfo.hp
	end

	self.panel.defence_blood:setCurProgress(curDefSumHp,maxDefSumHp)
	self.panel.attack_blood:setCurProgress(curAttackSumHp,maxAttackSumHp)
	self.panel.defence_blood:setText(string.format("%s/%s",curDefSumHp,maxDefSumHp))
	self.panel.attack_blood:setText(string.format("%s/%s",curAttackSumHp,maxAttackSumHp))
end

function StatsHPDelegate:clear()
	FightEngine:removeRunner(self)
	FightTrigger:removeEventListener(FightTrigger.CREATURE_CHANGE_HP, {self,self._onHpChange})
	self.attack_creture_list = {}
	self.def_creture_list = {}
end

function StatsHPDelegate:dispose()

end

return StatsHPDelegate