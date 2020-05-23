--[[
	class:		TouchLayer
	desc:
	author:		郑智敏
]]

local TouchLayer = class('TouchLayer', TouchBase)

function TouchLayer:ctor(priority,swallowTouches)
	TouchBase.ctor(self,priority,swallowTouches)
	EventProtocol.extend(self)
end

function TouchLayer:setShrinkEnable(enable)
	self._shrinkEnable = enable
end

function TouchLayer:onTouchDown(x,y)
	self:dispatchEvent({name = Event.MOUSE_DOWN,target = self, x = x, y= y})
	if self._shrinkEnable then
		UIAction.shrink(self)
	end
	return true
end

function TouchLayer:onTouchUp(x,y)
	self:dispatchEvent({name = Event.MOUSE_UP,target = self, x = x, y= y})
	self:dispatchEvent({name = Event.MOUSE_CLICK,target = self, x = x, y= y})
end

function TouchLayer:onTouchMove(x,y)
	self:dispatchEvent({name = Event.MOUSE_MOVE,target = self, x = x, y= y})
end

function TouchLayer:onTouchMoveOut()
	if self._shrinkEnable then
		UIAction.shrinkRecover(self, nil,nil, nil,0.1 ,0.05);
	end
	self:dispatchEvent({name = Event.MOUSE_MOVE_OUT,target = self})
end

function TouchLayer:onTouchEnd(x,y)
	if self._shrinkEnable then
		UIAction.shrinkRecover(self, nil,nil, nil,0.1 ,0.05);
	end
	self:dispatchEvent({name = Event.MOUSE_END,target = self,x = x, y= y})
end

return TouchLayer