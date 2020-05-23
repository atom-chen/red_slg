--
-- Author: wdx
-- Date: 2014-04-15 10:08:42
--

local FightEngine  = class("FightEngine")

Skill = require("view.fight.skill.Skill")
Magic = require("view.fight.magic.Magic")
TrackMagic = require("view.fight.magic.TrackMagic")



function FightEngine:ctor()
	self.skillList = {}
	self.magicList = {}
	self.creatureList = {}
	self.aiList = {}

	self.intervalTime = FightCommon.intervalTime  --播放速度  毫秒
	self.intervalRate = 1  --播放速率  1倍 

	self.animationDefaultTime = FightCommon.animationDefaultTime   --动画播放帧  时间 毫秒

end

function FightEngine:start()
	if self._timerId == nil then
		self._lastTime = os.clock()
		self._timerId = scheduler.scheduleGlobal(function() self:_enginRun() end,self.intervalTime/1000,false)
	end
end

function FightEngine:setIntervalRate(rate)
	self.intervalRate = rate
end

function FightEngine:stop()
	scheduler.unscheduleGlobal(self._timerId)
	self._timerId = nil
	for i ,creature in ipairs(self.creatureList) do
		creature:release()
	end
	self.creatureList = {}

	for i,skill in ipairs(self.skillList) do
		skill:dispose()
	end
	self.skillList = {}

	for i,ai in ipairs(self.aiList) do
		ai:dispose()
	end
	self.aiList = {}

	for i,magic in ipairs(self.magicList) do
		magic:dispose()
	end
	self.magicList = {}

end

function FightEngine:addCamera(camera)
	self.camera = camera
end

function FightEngine:addScene(scene)
	self.scene = scene
end

function FightEngine:addCreature(creature)
	creature:retain()
	self.creatureList[#self.creatureList+1] = creature
end

function FightEngine:removeCreature(creature)
	for i,c in ipairs(self.creatureList) do
		if c == creature then
			table.remove(self.creatureList,i)
			creature:release()
			break
		end
	end
end

function FightEngine:addAI(ai)
	self.aiList[#self.aiList +1] = ai
end

function FightEngine:removeAI( ai )
	for i,a in ipairs(self.aiList) do
		if a == ai then
			table.remove(self.aiList,i)
			break
		end
	end
end

function FightEngine:addSkill(skill)
	self.skillList[#self.skillList+1] = skill
	skill:start()
end

function FightEngine:addMagic(magic)
	self.magicList[#self.magicList+1] = magic
	magic:start()
end

function FightEngine:removeSkill(skill)
	for i,s in ipairs(self.skillList) do
		if s == skill then
			table.remove(self.skillList,i)
			skill:dispose()
			break
		end
	end
end

function FightEngine:stopCreatureSkill(creature)
	for i,skill in ipairs(self.skillList) do
		if skill:getCreature() == creature then
			table.remove(self.skillList,i)
			skill:dispose()
		end
	end
end

function FightEngine:removeMagic(magic)
	for i,m in ipairs(self.magicList) do
		if m == magic then
			table.remove(self.magicList,i)
			magic:dispose()
			break
		end
	end
end

function FightEngine:_enginRun()

	local now = os.clock()

	local passTime = (now - self._lastTime)*1000
	if passTime >= self.intervalTime then
		self._lastTime = now
		passTime = passTime*self.intervalRate

		self.camera:run(passTime)

		self.scene:run(passTime)

		for i,creature in ipairs(self.creatureList) do
			creature:run(passTime)
		end

		for id,skill in pairs(self.skillList) do
			skill:run(passTime)
		end

        for i,magic in ipairs(self.magicList) do
        	magic:run(passTime)
		end

		for i ,ai in ipairs(self.aiList) do
			ai:run(passTime)
		end
	end
end

function FightEngine:createMagic(creature,magicId,target)
	local info = FightCfg:getMagicCfg(magicId)
	local magic
	if  info.type == 1 then
		magic = Magic.new()
	elseif info.type == 2 then
		magic = TrackMagic.new()
	end
	magic:init(creature,magicId,target)
	return magic
end

function FightEngine:createSkill(creature,skillId,target)
	local skill = Skill.new()
	skill:init(creature, skillId, target)
	return skill
end


return FightEngine.new()


