--
-- Author:zhangzhen
-- Date: 2016-06-22 20:00:02
--

local MagicAutoTrigger = class("MagicAutoTrigger")
function MagicAutoTrigger:ctor(magicId,creature,target,preMagicGId,targetlist,skillInfo,skillParams,skillGId,atkRotation,hookObj)
	self.curRound = 0
	self.totalRound = 0
	self.totalTime = 0
	self.lastTime = 0
	self.curTime = 0
	self.preMagicGId = preMagicGId
	self.keyTime = {}
	self.targetlist = targetlist
	self.creature = creature
	self.target = target
	self.skillParams = skillParams
	self.skillInfo = skillInfo
	self.skillGId = skillGId
	self._atkRotation = atkRotation
	self.hookObj = hookObj
	self:initMagicInfo(magicId)
	print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH4444444444444")
end

function MagicAutoTrigger:initMagicInfo(magicId)
	self.magicId = magicId
	self.magicInfo = FightCfg:getMagic(magicId)
	if not self.magicInfo then
		self:_triggerEnd()
		return
	end
	self.totalRound = self.magicInfo.triggerTimes-1
	for k=1,self.totalRound do
		self.keyTime[#self.keyTime] = k*self.magicInfo.triggerInterval
	end
	self.totalTime = self.totalRound*self.magicInfo.triggerInterval
	self:start()
end

function MagicAutoTrigger:start()
	if not self.targetlist or #self.targetlist==0 then
		self:_triggerEnd()
		return
	end
	FightEngine:addRunner(self)
end

function MagicAutoTrigger:run(dt)
	if not self:check() then
	end
	self.lastTime =self.curTime
	self.curTime = self.curTime + dt
	for k,v in ipairs( self.keyTime ) do
		if v>self.lastTime and v<self.curTime then
			if not self:createMagic() then
				return
			end
		end
	end

end

function MagicAutoTrigger.getObjFromList(list,targetNum,index)
	local objs = {}
	local skipCount = index*targetNum
	local count = 0
	for k=1,#list do
		count = count + 1
		print("xxxxxxxxxxxx",k,skipCount,#objs,targetNum)
		if count>skipCount and #objs<targetNum then
			table.insert(objs,list[k])
		end

		if targetNum < #list and k == #list then
			k = 0
		end
	end
	return objs
end

function MagicAutoTrigger:check()
	if self.curTime >= self.totalTime then
		self:_triggerEnd()  --结束了
		return false
	end
	return
end

function MagicAutoTrigger:createMagic()
	self.curRound = self.curRound +1
	local targets = MagicAutoTrigger.getObjFromList(self.targetlist,self.magicInfo.targetNum,self.curRound)
	if #targets >0 then
		return
	end
	local magic = FightEngine:createMagic(self.creature,self.magicId,self.target,self.info,self.skillParams,self.skillGId,self.hookObj) --播放一个魔法特效
	if magic then
		magic:setHitTarget(targets)
		if target and target.posLength > 1 and FightCfg:getMagic(magicId).parent == 2 then
			local x,y = magic:getPosition()
			x = x + math.random(-FightMap.HALF_TILE_W*(target.posLength*0.5),FightMap.HALF_TILE_W*(target.posLength*0.5))
			y = y + math.random(-FightMap.HALF_TILE_H*(target.posLength*0.5),FightMap.HALF_TILE_H*(target.posLength*0.5))
			magic:setPosition(x,y)
		end

		if magic.info.direction == 1 then
			if self._atkRotation then
				magic:setRotation(self._atkRotation)
			end

			if creature.getCurAtkOffsetPos then
				local off = creature:getCurAtkOffsetPos()
				if off then
					local x,y = magic:getPosition()
					magic:setPosition(x+off[1],y+off[2])
				end
			end
		end
	end

	--校验是否结束
	local round = self.curRound +1
	local list = self:getObjFromList(self.targetlist,self.magicInfo.targetNum,round)
	if #list == 0 then
		self:_triggerEnd()  --结束了
		return false
	end
	return true
end

function MagicAutoTrigger:_triggerEnd()
	FightEngine:removeRunner(self)
end

function MagicAutoTrigger:dispose()

end
return MagicAutoTrigger