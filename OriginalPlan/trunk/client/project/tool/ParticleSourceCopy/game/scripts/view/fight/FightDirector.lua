--
-- Author:wdx
-- Date: 2014-04-15 20:00:02
--
local FightDirector = class("FightDirector")


FightCommon =  require("view.fight.FightCommon")  --一些产量
FightEngine = require("view.fight.FightEngine")  --单例
AIMgr = require("view.fight.ai.AIMgr") --单例


Formula = require("view.fight.formula.Formula")


local camera = require("view.fight.FightCamera")  --单例


--local FightPerformer = require("view.fight.performer.FightPerformer")


function FightDirector:ctor()
	EventProtocol.extend(self)
	--self:init(info)
end

function FightDirector:initScene(scene)
	--self.performer = FightPerformer.new()
	--self.performer:init()
	assert(self.scene == nil,"FightDirector  start  error . FightScene is existing")

	self.scene = scene

	local id = 1
	self.scene:initScene(id)
	
end

function FightDirector:start(info)
	
	self._initdata = info
	--local initData = clone(self._initdata)

	self.scene:initCreature(info)

	camera:start(self.scene)

	FightEngine:addCamera(camera)
	FightEngine:addScene(self.scene)

	FightEngine:start()

	local creatureList = self.scene:getCreatureList()
	AIMgr:start(creatureList)
 
	--self.performer:start()
end


function FightDirector:getScene()
	return self.scene
end

function FightDirector:getMap()
	return self.scene.map
end

function FightDirector:getCamera()
	return camera
end

function FightDirector:checkFightOver(creature)
	local failTeam = self.scene:getMateList(creature)
	for i,ct in ipairs(failTeam) do
		if not ct:isDie() then
			return 
		end
	end
	local winTeam = self.scene:getEnemyList(creature)
	for i,ct in ipairs(winTeam) do
		ct:win()
	end

	self:dispatchEvent({name= FightCommon.RESULT})
end

function FightDirector:replay()

	
end

function FightDirector:stop()
	FightEngine:stop()
end

function FightDirector:setIntervalRate(rate)
	FightEngine:setIntervalRate(rate)
end

return FightDirector:new()
