--
-- Author: 死亡处理
-- Date: 2014-09-24 09:49:03
--

local DieHandle = class("DieHandle")

function DieHandle:ctor(creature,killer,dType)
	self.creature = creature
	self.killer = killer
	self.dieType = dType
end

function DieHandle:start(noShowMagic,time)
	self.assignTime = time
	local creature = self.creature
	if creature._isDie then
		return
	end
	creature._isDie = true
	print("--死亡：",creature.cInfo.name)
	if creature:isCityWallBoss() then
		self:cityWallbossDieHandler()
	end
	FightEngine:removeCreatureBuff(creature)

	local mList = creature:getMagicList()
	if #mList > 0 then
		for i=#mList,1 -1 do
			local m = mList[i]
			if m.info.live == 2 or m.info.type == 5 then
				FightEngine:removeMagic(magic)
			end
		end
	end

	FightEngine:removeCreatureMagic(creature)

	if creature:isFly() then
		FightDirector:getAir():removeTileContent(creature)
	else
		FightDirector:getMap():removeTileContent(creature)
	end

	if creature.cInfo.occupy then
		local mx,my = creature.mx,creature.my
		for i,point in ipairs(creature.cInfo.occupy) do
			-- if FightDirector:getMap():getTileContent(mx+point[1],my+point[2]) == creature.id then
				FightDirector:getMap():setTileContent(mx+point[1],my+point[2],FightMap.NONE)
			-- end
		end
	end
	-- if creature._oldTeam then
	-- 	FightDirector:reducePopulace(creature._oldTeam,creature.cInfo)
	-- else
		FightDirector:reducePopulace(creature.cInfo.team,creature.cInfo)
	-- end

	FightEngine:stopCreatureSkill(creature)

	self._dieMagicTime = 100
	if self.assignTime then
		self._dieMagicTime = self.assignTime
	end
	if not noShowMagic then
		self:playDieMagic()
		self:playCorpseMagic()
	end

	-- self.creature:dispatchEvent({name=Creature.DIE_EVENT,creature=self.creature,killer = self.killer})


	FightTrigger:dispatchEvent({name=FightTrigger.CREATURE_DIE,creature = self.creature
								,killer = self.killer})
	FightEngine:addRunner(self)

	AIMgr:removeAI(creature)
	FightDirector:getScene():removeCreatureReference(creature)

--	if creature:isHasBlock() then
--		local map = FightDirector:getMap()
--		map:removeBlock(creature.mx,creature.my)
--	end
end

function DieHandle:playCorpseMagic()
	if self.creature.cInfo.corpseMagic and FightEngine:isSmooth() then
		FightEngine:createMagic(self.creature, self.creature.cInfo.corpseMagic)
	end
end

function DieHandle:playDieMagic()
	local creature = self.creature

	FightDirector:getScene():removeTopLayer(creature,true)

	if creature.cInfo.dieMagic then
		local mId
		if #creature.cInfo.dieMagic > 1 then
			if creature.cInfo.team == FightCommon.blue then
				mId = creature.cInfo.dieMagic[1]
			else
				mId = creature.cInfo.dieMagic[2]
			end
		else
			mId = creature.cInfo.dieMagic[1]
		end
		local skillObj = {}
		skillObj._noScaleOffsetX = true
		print("--死亡。。。",creature.cInfo.name,mId)
		local magic = FightEngine:createMagic(creature, mId,nil,{},skillObj)
		if magic and not self.assignTime then
			if magic.totalTime > self._dieMagicTime then
				self._dieMagicTime = magic.totalTime
			end

			-- local s = Formula:getDirectionScaleX(creature:getDirection())
			-- magic:setScaleX(s)
		end
	end

	if creature.cInfo.dieSkill then
		local sId
		if #creature.cInfo.dieSkill > 1 then
			if creature.cInfo.team == FightCommon.blue then
				sId = creature.cInfo.dieSkill[1]
			else
				sId = creature.cInfo.dieSkill[2]
			end
		else
			sId = creature.cInfo.dieSkill[1]
		end
		local skillObj = {level = creature.cInfo.level}
		skillObj.weapon = FightCfg.MAIN_ATTACK
		skillObj.scope = creature:getAtkScope(FightCfg.MAIN_ATTACK)
		skillObj._noScaleOffsetX = true

		local NewHandle = game_require("view.fight.handle.NewHandle")
		local skill = NewHandle:createSkill(creature, sId,nil,skillObj)
		if skill and self._dieMagicTime < skill.totalTime and not self.assignTime then
			self._dieMagicTime = skill.totalTime+10
		end
	else
		creature:setVisible(false)
	end
end

function DieHandle:run(dt)
	if self._dieMagicTime then
		self._dieMagicTime = self._dieMagicTime - dt
		if self._dieMagicTime <= 0 then
			self._dieMagicTime = nil
			self:_dieEnd()
		end
	end
end

function DieHandle:_dieEnd()
	FightEngine:removeRunner(self)
	-- local magic = FightEngine:createMagic(creature, FightCfg.MAGIC_DIE)

	-- local image = FightEngine:createTimeImage("#fight_die.png",5000)
	-- image:setPosition(creature:getPosition())
	-- FightDirector:getScene().bottomLayrer:addChild(image)
	FightDirector:getScene():setCreatureTemp(self.creature)
end

function DieHandle:cityWallbossDieHandler()
	local list = FightEngine:getEchelonCityWalllist( echelonIndex )
	for k,v in ipairs(list) do
		if v ~= self.creature then
			FightEngine:setCretureDie()
		end
	end

end

function DieHandle:dispose()
end

return DieHandle