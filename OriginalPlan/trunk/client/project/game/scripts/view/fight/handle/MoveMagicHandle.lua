local MoveMagicHandle = class("MoveMagicHandle")

local SOLDIER_BUFF = 2
function MoveMagicHandle:showMoveMagic(creature)
-- 	do
-- 	return
-- end
	if creature.cInfo.speciaAI == 17 then  --士兵ai
		if self._standBuff then
			FightEngine:removeCreatureBuffByBuffId(creature,SOLDIER_BUFF)
			self._standBuff = nil
		end
	end
	if self.standMagicList then
		for _,gId in ipairs(self.standMagicList) do
			FightEngine:removeMagicById(gId)
		end
		self.standMagicList = nil
	end
	if not FightEngine:isSmooth() then
		return
	end
	if self._removeMagicTimer then
		scheduler.unscheduleGlobal(self._removeMagicTimer)
		self._removeMagicTimer = nil
	end
	if not self.moveMagicList and creature.cInfo.moveMagic then
		self.moveMagicList = {}
		for _,mId in ipairs(creature.cInfo.moveMagic) do
			local magic = FightEngine:createMagic(creature, mId)
			if magic then
				self.moveMagicList[#self.moveMagicList+1] = magic.gId
			end
		end
	end
end

function MoveMagicHandle:removeMoveMagic(creature)
	if creature.cInfo.standMagic then
		if self.moveMagicList then
			for _,gId in ipairs(self.moveMagicList) do
				FightEngine:removeMagicById(gId)
			end
			self.moveMagicList = nil
		end
		if not FightEngine:isSmooth() then
			return
		end
		if not self.standMagicList then
			self.standMagicList = {}
			for _,mId in ipairs(creature.cInfo.standMagic) do
				local magic = FightEngine:createMagic(creature, mId)
				if magic then
					self.standMagicList[#self.standMagicList+1] = magic.gId
				end
			end
		end
	elseif not self._removeMagicTimer and self.moveMagicList then
		self._removeMagicTimer = scheduler.performWithDelayGlobal(function()
			if self.moveMagicList then
				for _,gId in ipairs(self.moveMagicList) do
					FightEngine:removeMagicById(gId)
				end
				self.moveMagicList = nil
			end
		 end,2)
	end
end

function MoveMagicHandle:dispose()
	if self._removeMagicTimer then
		scheduler.unscheduleGlobal(self._removeMagicTimer)
		self._removeMagicTimer = nil
	end
end

return MoveMagicHandle