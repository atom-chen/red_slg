local WMMarchElemArrow = class('WMMarchElemArrow', function() return display.newNode(); end)

function WMMarchElemArrow:ctor(map, marchController)
	--! WorldMap
	self._map = map
	--! WMMarchController
	self._marchController = marchController
	self:setPosition(0,0)
	self._marchController:getMarchNode():addChild(self,-1)
	self:retain()
end

function WMMarchElemArrow:createArrows(srcBlockPos, destBlockPos, color)
	self._srcBlockPos = srcBlockPos
	self._destBlockPos = destBlockPos

	local srcPos = self._map:getWorldPosFromBlockPos(srcBlockPos)
	local destPos = self._map:getWorldPosFromBlockPos(destBlockPos)

	local tempBlock = self._map:getBlockPosFromWorldPos(srcPos)
	assert(srcBlockPos.x == tempBlock.x and srcBlockPos.y == tempBlock.y)
	tempBlock = self._map:getBlockPosFromWorldPos(destPos)
	assert(destBlockPos.x == tempBlock.x and destBlockPos.y == tempBlock.y)

	self._srcPos = srcPos
	self._destPos = destPos

	local dx = destPos.x-srcPos.x
	local dy = destPos.y-srcPos.y
	local dist = math.sqrt(dx*dx+dy*dy)
	local interval = 30
	local px = destPos.x
	local py = destPos.y
	local pp = cc.pSub(destPos,srcPos):normalize()
	local pa = MathUtil:RadToAngle(pp:getAngle())
	local count = dist/interval
	count = math.ceil(count)
	local tempDestPos = self._destPos
	local tempSrcPos = srcPos:lerp(destPos, 40/dist);
	dist = math.sqrt((tempDestPos.x-tempSrcPos.x)*(tempDestPos.x-tempSrcPos.x)
		+(tempDestPos.y-tempSrcPos.y)*(tempDestPos.y-tempSrcPos.y));
	for k=1, count-2 do
		local sprite = display.newXSprite(string.format('ui/world/world_xjjy_%d.png', color))
		sprite:setAnchorPoint(ccp(0.5,0.5))
		local pz = tempSrcPos:lerp(destPos, (interval*k-1)/dist)
		tempDestPos = ccp(pz.x,pz.y);
		sprite:setPosition(tempDestPos)
		sprite:setRotation(-pa)
		self:addChild(sprite)
	end
end

function WMMarchElemArrow:getSrcBlockPos()
	return self._srcBlockPos
end

function WMMarchElemArrow:getDestBlockPos()
	return self._destBlockPos
end

function WMMarchElemArrow:update(dt)
end

function WMMarchElemArrow:getSrcPos()
	return self._srcPos
end

function WMMarchElemArrow:getDestPos()
	return self._destPos
end

function WMMarchElemArrow:dispose()
	self:release()
	self:removeFromParent()
end

return WMMarchElemArrow