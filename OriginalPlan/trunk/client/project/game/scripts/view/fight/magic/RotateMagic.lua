local RotateMagic = class("RotateMagic",Magic)

function RotateMagic:_getDirection(creature,target)
	return Creature.RIGHT
end

function RotateMagic:getDirection(creature,target)
	return Creature.RIGHT
end

function RotateMagic:setDirection(direction)
	self.direction = direction
	local d = self.creature:getTurnDirection()
	local r = Formula:getAngleByDirection(d)
	r = -r*180/math.pi
	if r == -135 then
		r = r - 10
	end
	self:setRotation(r)
	-- print("角度是多少啊啊啊",r)
end

function RotateMagic:initDirection( direction )
	Magic.initDirection(self,direction)
	-- self:setDirection(direction)
end

function RotateMagic:getMagicScaleX()
	return 1
end


function RotateMagic:getDirectionPId(p1,d)
	return p1
end

return RotateMagic