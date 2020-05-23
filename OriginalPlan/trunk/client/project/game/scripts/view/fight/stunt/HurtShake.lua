--
local HurtShake = class("HurtShake",Stunt)

function HurtShake:ctor(gId)
	Stunt.ctor(self,gId)
end

function HurtShake:init(creature,stuntId,target,time)
	Stunt.init(self,creature,stuntId,target,time)
	if self.info.sType < 100 then
		self.stuntElem = creature.avContainer
	else
		self.stuntElem = target.avContainer
	end
end

function HurtShake:start()

	Stunt.start(self)

	self.direction = AIMgr:getDirection(self.creature,self.target:getPosition())

	self.speed = self.info.range/((self.totalTime/2)/self.info.per)
	self.dx = 0
	self.dy = 0

	self.speedX,self.speedY = Formula:getSpeedXY(self.speed,self.direction)

	self.maxX,self.maxY = Formula:getSpeedXY(self.info.range,self.direction)
	self.maxX,self.maxY = math.abs(self.maxX),math.abs(self.maxY)

	FightEngine:removeCreatureStunt(self.creature,self.info.sType)
end

function HurtShake:run( dt )

	-- local newR = self.curTime*self.speed
	-- if newR - self.curR > 90 then
	-- 	newR = self.curR - self.curR%90 + 90
	-- end

	local addX = self.speedX*dt
	local addY = self.speedY*dt

	local newX = self.dx + addX
	local newY = self.dy + addY

	if math.abs(newX) >= self.maxX then
		newX = self.maxX * newX/newX
		newY = self.maxY * newY/newY
		addX = newX - self.dx
		addY = newY - self.dy

		self.direction = Formula:turnDirection(self.direction)
		self.speedX,self.speedY = Formula:getSpeedXY(self.speed,self.direction)
	end

	self.dx = newX
	self.dy = newY


	local posX,posY = self.stuntElem:getPosition()
	posX = posX + addX
	posY = posY + addY
	self.stuntElem:setPosition(posX, posY)

	--print("震动。。。。",addX,addY)

	Stunt.run(self,dt)
end

function HurtShake:dispose()
	local posX,posY = self.stuntElem:getPosition()
	posX = posX - self.dx
	posY = posY - self.dy
	self.stuntElem:setPosition(posX,posY)
	Stunt.dispose(self)
end

return HurtShake