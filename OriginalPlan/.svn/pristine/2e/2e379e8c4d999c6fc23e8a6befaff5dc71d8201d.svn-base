--
--

local ShakeStunt = class("ShakeStunt",Stunt)

function ShakeStunt:ctor(gId)
	Stunt.ctor(self,gId)
end

function ShakeStunt:init(creature,stuntId,target,time)
	Stunt.init(self,creature,stuntId,target,time)
	if self.info.sType == 0 then  --震屏  获取到场景
		self.stuntElem = FightDirector:getScene()
	elseif self.info.sType < 100 then
		self.stuntElem = creature.avContainer
	else
		self.stuntElem = target.avContainer
	end
end


function ShakeStunt:start()
	Stunt.start(self)

	self.direction = Creature.DOWN

	self.speed = math.pi/(self.totalTime/self.info.per)
	self.curR = 0
	self.dx = 0
	self.dy = 0

	self.range = self.info.range
	self.scaleRate = self.info.scale/1000
	self.addScale = 0

	self.offsetX,self.offsetY = 0,math.random(-self.range,self.range)

	local posX,posY = self.stuntElem:getPosition()
	posX = posX + self.offsetX/2
	posY = posY + self.offsetY/2
	self.stuntElem:setPosition(posX,posY)

	if self.direction == Creature.RIGHT_UP then
		self.curR = 0
	elseif self.direction == Creature.RIGHT_DOWN then
		self.curR = math.pi/2
	elseif self.direction == Creature.LEFT_DOWN then
		self.curR = math.pi
	else
		self.curR = -math.pi/2
	end

	FightEngine:removeCreatureStunt(self.creature,self.info.sType)
end

function ShakeStunt:run( dt )

	-- local newR = self.curTime*self.speed
	-- if newR - self.curR > 90 then
	-- 	newR = self.curR - self.curR%90 + 90
	-- end
	self.curR = self.curR + 30* self.speed

	local curScale = self.stuntElem:getScale()
	curScale = curScale - self.addScale
	local newScale = self.scaleRate*(self.curR%math.pi)/math.pi
	self.addScale = newScale
	curScale = curScale + newScale
	self.stuntElem:setScale(curScale)

	local posX,posY = self.stuntElem:getPosition()
	posX = posX - self.dx
	posY = posY - self.dy

	self.dx = math.floor(math.sin(self.curR) * self.range + 0.5)
	self.dy = math.floor(math.cos(self.curR) * self.range + 0.5)

	self.stuntElem:setPosition(posX+self.dx, posY+self.dy)

	-- if self.info.sType == 1 then
	-- 	print("shake",self.offsetX,self.offsetY,self.dx,self.dy)
	-- end


	Stunt.run(self,dt)
end

function ShakeStunt:dispose()
	local curScale = self.stuntElem:getScale()
	curScale = curScale - self.addScale
	self.stuntElem:setScale(curScale)

	local posX,posY = self.stuntElem:getPosition()
	posX = posX - self.dx - self.offsetX/2
	posY = posY - self.dy - self.offsetY/2
	self.stuntElem:setPosition(posX,posY)
	Stunt.dispose(self)

end

return ShakeStunt