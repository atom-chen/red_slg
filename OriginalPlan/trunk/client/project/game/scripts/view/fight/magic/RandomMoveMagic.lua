local RandomMoveMagic = class("RandomMoveMagic",Magic)

function RandomMoveMagic:start()
	self.speed = Formula:transformSpeed(self.info.speed or 400)
	self._tx,self._ty = self:_getRandomTarget()
	Magic.start(self)
end

function RandomMoveMagic:run(dt)
	if Magic.run(self,dt) then
		local curX,curY = self:getPosition()
		if self._tx ~= curX or self._ty ~= curY then
			local nextX,nextY = Formula:getNextPos(curX,curY,self._tx,self._ty,self.speed,dt)
			self:setPosition(nextX,nextY)   --移动位置
			if self._tx == nextX and self._ty == nextY then
				self._tx,self._ty = self:_getRandomTarget()
			end
		end
	end
end

function RandomMoveMagic:_getRandomTarget()
	local x,y = self:getPosition()
	local dx,dy = math.random(-20,20) , math.random(-20,20)
	local direction = AIMgr:getDirectionBySpeed(dx,dy)
	-- print("magic,,,设置方向",direction,self.creature.id)
	self:setDirection(direction)
	return x+dx,y+dy
end

function RandomMoveMagic:getDirection()
	return Creature.RIGHT
end

function RandomMoveMagic:_getDirection(creature,target)
	return Creature.RIGHT
end

return RandomMoveMagic