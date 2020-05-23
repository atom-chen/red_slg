local TimeImage = class("TimeImage",function() return display.newXSprite() end)

function TimeImage:ctor(gId)
	self.gId = gId
end

function TimeImage:init(res,time)
	self:setSpriteImage(res)
	self:setTime(time)
end

function TimeImage:setTime(time)
	self.opacityTime = time*3/4
	self.curTime = time
end

function TimeImage:start()
	FightEngine:addRunner(self)
end

function TimeImage:run(dt)
	self.curTime = self.curTime - dt
	if self.curTime <= 0 then
		FightEngine:removeRunner(self)
	elseif self.curTime < self.opacityTime then
		local a = 255*self.curTime/self.opacityTime
		self:setOpacity(a)
	end
end

function TimeImage:reset()
	self:setOpacity(255)
	self:setRotation(0)
	self:setScale(1)
end

function TimeImage:dispose()
	self:removeFromParent()
	FightCache:saveTimeImage(self)
end

return TimeImage