--
--
local pairs = pairs
local ipairs = ipairs
local table = table

local Stunt = class("Stunt")

function Stunt:ctor(gId)
	self.gId = gId
end

function Stunt:init(creature,stuntId,target,time)
	self.info = FightCfg:getStunt(stuntId)

	self.creature = creature
	self.target = target

	self.info.id = stuntId

	self.colorList = {}
	if self.info.sType < 100 then
		self.stuntElem = creature
		self.colorList[#self.colorList+1] = creature.av
		self.colorList[#self.colorList+1] = creature.atkAv
	else
		self.stuntElem = target
		self.colorList[#self.colorList+1] = target.av
		self.colorList[#self.colorList+1] = target.atkAv
	end
	self.totalTime = time

	assert(self.totalTime," stime"..stuntId)
end

function Stunt:start()
	self.curTime = 0
	self:setColor()
	if self.info.alpha then
		for i,elem in ipairs(self.colorList) do
			elem:setOpacity(self.info.alpha)
		end
	end
	if self:isSameType(9) then
		for i,elem in ipairs(self.colorList) do
			elem:setBlendFunc(0,2)
		end
	end
end

function Stunt:restart(  )
	-- print("restart",self.info.sType)
	self:setColor()
	if self.info.alpha then
		for i,elem in ipairs(self.colorList) do
			elem:setOpacity(self.info.alpha)
		end
	end
end

function Stunt:setColor()
	if self.info.color then
		if self.info.sType%100 == 8 then
			for i,elem in ipairs(self.colorList) do
				elem:setColor(ccc3(self.info.color[1],self.info.color[2],self.info.color[3]))
			end
		else
			local color = ccc4f(self.info.color[1]/100,self.info.color[2]/100,self.info.color[3]/100,self.info.color[4]/100)
			for i,elem in ipairs(self.colorList) do
				ShaderMgr:setColor(elem,color)
			end
		end
	end
end

function Stunt:run( dt )
	self.curTime = self.curTime + dt
	if self.totalTime >= 0 and self.curTime >= self.totalTime then
		self:_stuntEnd()
		return false
	end
	return true
end

function Stunt:isSameType( sType )
	return self.info.sType%100 == sType%100
end

function Stunt:_stuntEnd()
	FightEngine:removeStunt(self)
	if self._endCallback then
		self._endCallback()
	end
	self._endCallback = nil
end

function Stunt:getEffectTarget( )
	if self.info.sType < 100 then
		return self.creature
	else
		return self.target
	end
end

function Stunt:setEndCallBack( fun )
	self._endCallback = fun
end

function Stunt:dispose()
	if self.info.color then
		if self.info.sType%100 == 8 then
			for i,elem in ipairs(self.colorList) do
				elem:setColor(ccc3(255,255,255))
			end
		else
			for i,elem in ipairs(self.colorList) do
				ShaderMgr:removeColor(elem)
			end
		end
	end
	if self.info.alpha then
		for i,elem in ipairs(self.colorList) do
			elem:setOpacity(255)
		end
	end
	if self:isSameType(9) then
		for i,elem in ipairs(self.colorList) do
			elem:setBlendFunc(0,1)
		end
	end
	self.target = nil
	self.creature = nil
	self.stuntElem = nil
end

return Stunt




