--
--
local pairs = pairs
local ipairs = ipairs
local table = table


FightEngine  = {}

local FightEngine = FightEngine

Skill = game_require("view.fight.skill.Skill")
PassiveSkill = game_require("view.fight.skill.PassiveSkill")  --被动技能

--local PlayerSkill = game_require("view.fight.skill.PlayerSkill")
local LaserSkill = game_require("view.fight.skill.LaserSkill")

Magic = game_require("view.fight.magic.Magic")
local TrackMagic = game_require("view.fight.magic.TrackMagic")  --跟踪轨迹的
local ArcMagic = game_require("view.fight.magic.ArcMagic")
local CircleTrackMagic = game_require("view.fight.magic.CircleTrackMagic")
local LaserMagic = game_require("view.fight.magic.LaserMagic")
local RotateMagic = game_require("view.fight.magic.RotateMagic")
local RandomMoveMagic = game_require("view.fight.magic.RandomMoveMagic")
local SimpleMoveMagic = game_require("view.fight.magic.SimpleMoveMagic")
local StopFrameMaigc = game_require("view.fight.magic.StopFrameMaigc")
local RocketMagic = game_require("view.fight.magic.RocketMagic")  --箭头


local MagicCache = game_require("view.fight.magic.MagicCache")

Buff = game_require("view.fight.buff.Buff")
local CharmBuff = game_require("view.fight.buff.CharmBuff")

Stunt = game_require("view.fight.stunt.Stunt")
ShakeStunt = game_require("view.fight.stunt.ShakeStunt")
HurtShake = game_require("view.fight.stunt.HurtShake")
ScaleStunt = game_require("view.fight.stunt.ScaleStunt")
FloatStunt = game_require("view.fight.stunt.FloatStunt")
YShakeStunt = game_require("view.fight.stunt.YShakeStunt")

FightLight = game_require("view.fight.light.FightLight")

function FightEngine:ctor()
	self.skillList = {}
	self.magicList = {}
	self.creatureList = {}
	self.aiList = {}
	self.buffList = {}

	MagicCache:init()

	self.congealList = {}

	self.stuntList = {}

	self._firstRunList = {}

	self.newSkillList = {}

	self._runList = {}

	self._delayDisposeList = {}

	self.intervalTime = FightCommon.intervalTime  --播放速度  毫秒
	self.intervalRate = 1  --播放速率  1倍

	self.animationDefaultTime = FightCommon.animationDefaultTime   --动画播放帧  时间 毫秒
	self.gId = 0

	self.stuntClassList = {[0]=ShakeStunt,[1]=ShakeStunt,[2]=ScaleStunt,[6]=FloatStunt,[7]=YShakeStunt}

	self.magicClassList = {[1]=TrackMagic,[2]=ArcMagic,[3]=CircleTrackMagic,[4]=LaserMagic,[5]=RotateMagic
							,[6]=RandomMoveMagic,[7]=SimpleMoveMagic,[8]=CircleTrackMagic,[9]=RocketMagic}

	self.buffClassList = {charm=CharmBuff}

	self.skillClassList = {[1]=LaserSkill}
end

--获取战斗引擎的一个全局唯一id
function FightEngine:getGlobalId()
	self.gId = self.gId + 1
	return self.gId
end

function FightEngine:start()
	if self._timerId == nil then
		self.smooth = true
		self._runRateTime = 0
		self._runRate = 1
		self.intervalRate = 1
		self.passTime = 0
		self.curTime = 0
		self._timerId = scheduler.scheduleUpdateGlobal(function(dt) self:_enginRun(dt) end)
	end
end

function FightEngine:setIntervalRate(rate)
	self.intervalRate = rate
end

--临时改变播放速度  在多少tiem时间内  改变整体速度
function FightEngine:setRunRate( rate,time )
	self._runRateTime = time
	self._runRate = rate
end

function FightEngine:resetTime()
	self.curTime = 0
end

function FightEngine:pause(  )
	if self._timerId  then
		scheduler.unscheduleGlobal(self._timerId)
		self._timerId = nil
	end
end

function FightEngine:resume()
	if self._timerId == nil then
		self.passTime = 0
		self._timerId = scheduler.scheduleUpdateGlobal(function(dt) self:_enginRun(dt) end)
	end
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
	self:removeCreatureAllStunt(creature)
	for i,c in ipairs(self.creatureList) do
		if c == creature then
			table.remove(self.creatureList,i)
			creature:release()
			break
		end
	end
end

function FightEngine:addFirstRun(runner)
	self._firstRunList[#self._firstRunList+1] = runner
end

function FightEngine:addRunner(runner)
	self._runList[#self._runList+1] = runner
end

function FightEngine:removeRunner(runner)
	for i,r in ipairs(self._runList) do
		if r == runner then
			table.remove(self._runList,i)
			r:dispose()
			break
		end
	end
end

function FightEngine:addSkill(skill)
	self.skillList[#self.skillList+1] = skill
	skill:start()
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
	if creature:getSkillCount() > 0 then
		for i,skill in ipairs(self.skillList) do
			if skill:getCreature() == creature then
				table.remove(self.skillList,i)
				skill:dispose()
				break
			end
		end
	end
end

function FightEngine:addMagic(magic)
	self.magicList[magic.gId] = magic
	magic:start()
end

function FightEngine:getMagicById( gId )
	return self.magicList[gId]
end

function FightEngine:removeMagic(magic)
	self.magicList[magic.gId] = nil
	magic:dispose()
end

function FightEngine:removeMagicById(gId)
	local magic = self.magicList[gId]
	if magic then
		self.magicList[gId] = nil
		magic:dispose()
	end
end

function FightEngine:removeCreatureMagicById(creature,mId)
	for gId,magic in pairs(self.magicList) do
		if magic:getCreatureParent() == creature and magic.magicId == mId then
			self.magicList[gId] = nil
			magic:dispose()
			break
		end
	end
end

function FightEngine:removeCreatureMagic(creature)
	local mList = {}
	for gId,magic in pairs(self.magicList) do
		if magic.creature == creature and magic.info.live == 1 then
			mList[#mList+1] = magic
		end
	end
	for i,m in ipairs(mList) do
		self:removeMagic(m)
	end
end

function FightEngine:removeAllCreatureMagic(creature)
	local mList = {}
	for _,magic in pairs(self.magicList) do
		if magic.creature == creature or magic.target == creature then
			mList[#mList+1] = magic
		end
	end
	for i,m in ipairs(mList) do
		self:removeMagic(m)
	end
end

function FightEngine:addBuff( buff )
	self.buffList[#self.buffList + 1] = buff
	buff:start()
end

function FightEngine:removeBuff( buff )
	for i,b in ipairs(self.buffList) do
		if b == buff then
			table.remove(self.buffList,i)
			buff:dispose()
			break
		end
	end
end

function FightEngine:removeAllBuff()
	for i,b in ipairs(self.buffList) do
		b:dispose()
	end
	self.buffList = {}
end

function FightEngine:removeBuffByType( creature,bType,num )
	local buffList = creature:getBuffList()
	for i=#buffList,1,-1 do
		local buff = buffList[i]
		if buff.info.bType == bType then
			if num >= 0 then
				self:removeBuff(buff)
			end
			num = num - 1
		end
	end
end

function FightEngine:removeCreatureBuff( creature )
	local buffList = creature:getBuffList()
	for i=#buffList,1,-1 do
		self:removeBuff(buffList[i])
	end
end

function FightEngine:removeCreatureBuffByBuffId( creature,buffId )
	local buffList = creature:getBuffList()
	for i=#buffList,1,-1 do
		local buff = buffList[i]
		if buff.buffId == buffId then
			self:removeBuff(buff)
		end
	end
end

function FightEngine:getBuffByGlobalId( id )
	for i,b in ipairs(self.buffList) do
		if b.gId == id then
			return b
		end
	end
	return nil
end

function FightEngine:isCongeal()
	return #self.congealList ~= 0
end

function FightEngine:addCongeal( congeal )
	local index = table.indexOf(self.congealList,congeal)
	if index < 0 then
		self.congealList[#self.congealList + 1] = congeal
	end
end

function FightEngine:removeCongeal( congeal )
	for i,cgl in ipairs(self.congealList) do
		if cgl == congeal then
			table.remove(self.congealList,i)
			if cgl.isCongealDispose then
				cgl:dispose()
			end
			break
		end
	end
end

function FightEngine:removeAllCongeal()
	for i,cgl in ipairs(self.congealList) do
		if cgl.isCongealDispose then
			cgl:dispose()
		end
	end
	self.congealList = {}
end

function FightEngine:addStunt(stunt)
	stunt:start()
	self.stuntList[#self.stuntList+1] = stunt
end

function FightEngine:removeStunt( stunt )
	for i,st in ipairs(self.stuntList) do
		if st == stunt then
			table.remove(self.stuntList,i)
			local sType = stunt.info.sType
			local creature = stunt:getEffectTarget()
			stunt:dispose()
			self:restartStunt(creature,sType,i-1)
			break
		end
	end
end

function FightEngine:removeCreatureStunt( creature,sType )
	sType = sType%100
	for i = #self.stuntList,1,-1 do
		local stunt = self.stuntList[i]
		if stunt.creature == creature and stunt:isSameType(sType) then
			table.remove(self.stuntList,i)
			stunt:dispose()
		end
	end
end

function FightEngine:removeCreatureAllStunt(creature)
	for i = #self.stuntList,1,-1 do
		local stunt = self.stuntList[i]
		if stunt:getEffectTarget() == creature then
			table.remove(self.stuntList,i)
			stunt:dispose()
		end
	end
end

function FightEngine:restartStunt(creature, sType )
	sType = sType%100
	for i=#self.stuntList,1,-1 do
		local stunt = self.stuntList[i]
		if stunt:getEffectTarget() == creature and stunt:isSameType(sType) then
			stunt:restart()
			break
		end
	end
end

function FightEngine:getCurTime(  )
	return self.curTime
end

function FightEngine:resetCurTime( )
	self.curTime = 0
end

function FightEngine:delayDisposeElem(elem)
	self._delayDisposeList[elem] = true
end

function FightEngine:isSmooth()
	return self.smooth
end

function FightEngine:_removeIgnoreMagic()
	for i,magic in pairs(self.magicList) do
		if magic.info.ignore then
			self:removeMagic(magic)
		end
	end
end

function FightEngine:_enginRun(dt)
	if dt > 0.05 and self.smooth then
		local magicNum = 0
        for i,magic in pairs(self.magicList) do
        	magicNum = magicNum + 1
        	if magicNum > 10 then
				self.smooth = false
				self.intervalTime = FightCommon.intervalTime + 20
				self:_removeIgnoreMagic()
				break
			end
		end
	elseif dt < 0.04 then
		self.smooth = true
		self.intervalTime = FightCommon.intervalTime
	end


	self.passTime = dt*1000 + self.passTime
	--CCLuaLog("fight time :"..now.."   passtime:  "..(passTime/1000) .." bit time: "..passTime.."  interval time:  "..self.intervalTime)
	if self.passTime >= self.intervalTime then
		-- local tt = XUtil:getCurTime()

		local passTime = self.passTime
		self.passTime = 0

		passTime = passTime*self.intervalRate

		if self._runRateTime > 0 then
			self._runRateTime = self._runRateTime - passTime
			passTime = passTime*self._runRate
		end

		-- if self.intervalRate ~= 1 or self._runRate ~= 1 then
		-- 	print("self.intervalRate  : ",self.intervalRate,self._runRate)
		-- end

		self.curTime = self.curTime + passTime

		for i,firstRun in ipairs(self._firstRunList) do
			firstRun:run(passTime)
		end

		self.camera:run(passTime)

		FightAudio:run(passTime)

		if FightDirector:isNetFight() then
			FightNet:run()
		end

		self.scene:run(passTime)
		if #self.congealList > 0 then
			for i,congeal in ipairs(self.congealList) do
				congeal:runCongeal(passTime)
			end
			return
		end

		for i,stunt in ipairs(self.stuntList) do
			stunt:run(passTime)
		end

		local magicNum = 0
		-- local t = XUtil:getCurTime()
        for i,magic in pairs(self.magicList) do
        	magic:run(passTime)
        	magicNum = magicNum + 1
        	if magicNum > 30 then
        		self.smooth = false
        	end
		end

		for id,skill in pairs(self.skillList) do
			skill:run(passTime)
		end
		if #self.newSkillList > 0 then
			for i,info in ipairs(self.newSkillList) do
				self:createSkill(info[1],info[2],info[3],info[4])
			end
			self.newSkillList = {}
		end

		-- print("magic run花费了多少时间。。。。",XUtil:getCurTime() - t)

		-- print("self.smooth ",self.smooth,dt,magicNum)

		for i,buff in ipairs(self.buffList) do
			buff:run(passTime)
		end

		for i,runner in ipairs(self._runList) do
			runner:run(passTime)
		end

		AIMgr:run(passTime)

		for i,creature in ipairs(self.creatureList) do
			creature:run(passTime)
		end

		if #self._delayDisposeList > 0 then
			for elem,_ in pairs(self._delayDisposeList) do  --消耗掉
				elem:dispose()
			end
			self._delayDisposeList = {}
		end

		FightTrigger:dispatchEvent({name=FightTrigger.TIME_TICK ,dt=passTime})

		-- print("FightEngine run花费了多少时间。。。。",XUtil:getCurTime() - tt)
	end

	-- collectgarbage("collect")
end

function FightEngine:stop()
	if self._timerId then
		scheduler.unscheduleGlobal(self._timerId)
		self._timerId = nil
	end

	for i,run in ipairs(self._firstRunList) do
		run:dispose()
	end
	self._firstRunList = {}

	for i,skill in pairs(self.skillList) do
		skill:dispose()
	end
	self.skillList = {}

	for i,magic in pairs(self.magicList) do
		magic:dispose()
	end
	self.magicList = {}

	for i,buff in ipairs(self.buffList) do
		buff:dispose()
	end
	self.buffList = {}

	for i,stunt in ipairs(self.stuntList) do
		stunt:dispose()
	end
	self.stuntList = {}


	for i,run in ipairs(self._runList) do
		run:dispose()
	end
	self._runList = {}

	for i,cgl in ipairs(self.congealList) do
		if cgl.isCongealDispose then
			cgl:dispose()
		end
	end
	self.congealList = {}

	for i ,creature in ipairs(self.creatureList) do
		creature:release()
	end
	self.creatureList = {}

	self:removeAllCongeal()

	self.newSkillList = {}

	self.gId = 0

	if FightDirector:isNetFight() then
		FightNet:stop()
	end

	if #self._delayDisposeList > 0 then
		-- print("还有多余的销毁",#self._delayDisposeList)
		for elem,_ in pairs(self._delayDisposeList) do  --消耗掉
			elem:dispose()
		end
		self._delayDisposeList = {}
	end
end

function FightEngine:reset()
	for i,skill in pairs(self.skillList) do
		skill:dispose()
	end
	self.skillList = {}

	for i,magic in pairs(self.magicList) do
		magic:dispose()
	end
	self.magicList = {}

	for i,buff in ipairs(self.buffList) do
		buff:dispose()
	end
	self.buffList = {}

	for i,stunt in ipairs(self.stuntList) do
		stunt:dispose()
	end
	self.stuntList = {}

	for i,cgl in ipairs(self.congealList) do
		if cgl.isCongealDispose then
			cgl:dispose()
		end
	end
	self.congealList = {}
end

function FightEngine:fightOver()
	for i=#self._runList,1,-1 do
		local runner = self._runList[i]
		if runner.isFightOverEnd then
			runner:dispose()
			table.remove(self._runList,i)
		end
	end
end

function FightEngine:_magicRepeat(info,magicId,creature,target,skillParams,hookObj)
	local parent,x,y
	hookObj = hookObj or creature
	if info.parent == 1 then
		parent = hookObj or creature
	elseif info.parent == 2 then
		parent = target
	elseif info.parent == 3 then
		if hookObj then
			if hookObj.getPosition then
				x,y = hookObj:getPosition()
			else
				x,y = hookObj.x,hookObj.y
			end
		end
	elseif info.parent == 4 then
		x,y = target:getPosition()
	else
		x,y = skillParams.x,skillParams.y
	end
	for gId,magic in pairs(self.magicList) do
		if magic.magicId == magicId and magic:getCreatureParent() == parent and magic.curTime/magic.totalTime <0.7  then
			if parent then
				return true
			else
				local cx,cy = magic:getPosition()
				if math.abs(cx-x) + math.abs(cy-y) < 50 then
					return true
				end
			end
		end
	end
	return false
end

function FightEngine:createMagic(creature,magicId,target,skillInfo,skillParams,skillGid,hookObj)
	hookObj = hookObj or creature
	if FightDirector.status == FightCommon.stop then
		return
	end
	local info = FightCfg:getMagic(magicId)
	if info == nil then
		return
	end
	local isHide = false
	if not self:isSmooth() and info.ignore then
		if info.ignore == 3 then
			if self:_magicRepeat(info,magicId,creature,target,skillParams,hookObj) then
				isHide = true
			end
		else
			isHide = true
		end
	end
	if info.ignore == 2 and self:_magicRepeat(info,magicId,creature,target,skillParams,hookObj) then
		-- print("重复 magic ",magicId)
		isHide = true
	end

	skillParams = skillParams or {}
	local magic --= MagicCache:getMagic(magicId,creature,target)
	if not magic then
		local cls
		if info.stopFrame then
			cls = StopFrameMaigc.new()
		else
			cls = self.magicClassList[info.type]
		end
		if cls then
			magic = cls.new()
		else
			magic = Magic.new()
		end
		magic:init(magicId,creature,target)
	else
		-- print("缓存找到了。。。。。",magicId)
	end
	magic:setGlobalID(self:getGlobalId())
	magic:setParams(creature,target,skillInfo,skillParams,skillGid,hookObj,isHide)
	self:addMagic(magic)
	return magic
end

function FightEngine:addNewSkill( creature,skillId,target,skillParams)
	self.newSkillList[#self.newSkillList+1] = {creature,skillId,target,skillParams}
end

function FightEngine:createSkill(creature,skillId,target,skillParams)

	if FightDirector.status == FightCommon.stop then
		return
	end
	skillParams = skillParams or {}
	local info = FightCfg:getSkill(skillId)
	local skill = self:_getNewSkill(info)
	if not skillParams.gId then
		skillParams.gId = skill.gId
	end
	skill:init(creature, skillId, target,skillParams)
	if not skill:breakLastSkill() then  --瞬发的技能技能 不会打断之前的技能
		skill:start()
		skill:dispose()
		return skill
	end
	if creature:getSkillCount() > 0 then
		self:stopCreatureSkill(creature)
	end
	self:addSkill(skill)

	return skill
end

function FightEngine:_getNewSkill(info)
	local skill
	local gId = self:getGlobalId()

	if info.specialType then
		local sClass = self.skillClassList[info.specialType]
		if sClass then
			skill = sClass.new(gId)
		end
	end

	if not skill then
		skill = Skill.new(gId)
	end

	return skill
end

function FightEngine:createBuff( creature,buffId,time,buffOwner,skillInfo,skillParams,target)
	if FightDirector.status == FightCommon.stop then
		return
	end
	skillParams = skillParams or {}
	skillParams.level = skillParams.level or 1
	local info = FightCfg:getBuff(buffId)
	local gId = self:getGlobalId()
	local buff
	-- info.transfer = 2
	if info.bType then
		local num = info.bTypeNum or 1
		self:removeBuffByType(creature,info.bType,num -1)  --移除同类型的buff  覆盖掉
	end
	for key,bClass in pairs(self.buffClassList) do
		if info[key] then  --有不同属性的 会创建不同的buff
			buff = bClass.new(gId)
			break
		end
	end
	if not buff then
		buff = Buff.new(gId)
	end
	buff:init(creature, buffId, time,buffOwner,skillInfo,skillParams,target)
	self:addBuff(buff)
	return buff
end

function FightEngine:createStunt( creature,stuntId,target,time )
	if FightDirector.status == FightCommon.stop then
		return
	end
	local info = FightCfg:getStunt(stuntId)
	local stunt
	local gId = self:getGlobalId()

	-- if stuntId == 1 or stuntId == 2 then   --HurtShake受击的震动
	-- 	stunt = HurtShake.new(gId)
	-- else
		local index = info.sType%100
		-- index = 6
		local cls = self.stuntClassList[index]
		if cls then
			stunt = cls.new(gId)
		else
			stunt = Stunt.new(gId)
		end
	-- end
	stunt:init(creature,stuntId,target,time)
	self:addStunt(stunt)
	return stunt
end

function FightEngine:createFightNum( creature,text,hurtParams,color )
	if FightDirector.status == FightCommon.stop then
		return
	end
	local fightNum = FightNum.new()
	fightNum:init(creature,text,hurtParams,color)
	self:addFightNum(fightNum)
end


function FightEngine:createLight(target,x,y,color,res)
	if FightDirector.status == FightCommon.stop then
		return
	end
	local light = FightLight.new(res)
	light:init(target,x,y,color)
	light:start()
	-- self:addRunner(light)
	return light
end

function FightEngine:createTimeImage(res,time)
	local image = FightCache:getTimeImage()
	image:init(res,time)
	image:start()
	return image
end

function FightEngine:getAllCreture()
	return self.creatureList
end

function FightEngine:getCityWallBoss( echelonIndex )
	echelonIndex = math.floor(echelonIndex/10)*10
	for k, creture in pairs(self.creatureList) do
		if creture:isCityWallBoss(echelonIndex ) then
			return creture
		end
	end
	return nil
end

function FightEngine:cityWallRelocation( creature )
	if creature:isCityWall() then
			if creature:isCityWallBoss(creature.cInfo.echelonType ) then
				return creature
			end
			local cityWallboss = self:getCityWallBoss( creature.cInfo.echelonType )
			return cityWallboss
		end

	return creature
end

function FightEngine:getEchelonCityWalllist( echelonIndex )
	local list = {}
	for k, creture in pairs(self.creatureList) do
		if creature:isCityWall(echelonIndex ) then
			table.insert(list,creture)
		end
	end

	return list
end

function FightEngine:setCretureDie( creture )
	creature:setHp(0)
	local DieHandle = game_require("view.fight.handle.DieHandle")
	local handle = DieHandle.new(creature)
	handle:start(true)
end

FightEngine:ctor()


