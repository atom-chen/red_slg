--
-- Author: wdx
-- Date: 2014-05-20 20:51:57
--

local fGrid = class("fGrid",function()
								return display.newLayer() 
							end)

function fGrid:ctor(id)
	-- body
	self:setTouchEnabled(true)
	self:addTouchEventListener(handler(self,self._onTouch),false,-1,true)

	self.sp = display.newSprite("head/"..id..".png")
	self.sp:setAnchorPoint(ccp(0,0))
	self:addChild(self.sp)

	self.id = id

	local size = self.sp:getContentSize()
	self.width = size.width 
	self.height = size.height
	self:retain()
end

--鼠标事件，
function fGrid:_onTouch(event,x,y)
	if event == "began" then
		ret = self:_onTouchBegan(event,x,y)
	elseif event == "moved" then
		self:_onTouchMoved(event,x,y)
	elseif event == "ended" then
		self:_onTouchEnded(event,x,y)
	elseif event == "canceled" then
		self:_onTouchEnded(event,x,y)
	end
	return ret
end

function fGrid:_onTouchBegan( e,x,y )
	local pos = self:convertToNodeSpace(ccp(x,y))
	--local curPos = self:getPosition()
	--print(pos.x,pos.y,x,y)
	if pos.x > 0 and pos.x < self.width and pos.y > 0 and pos.y < self.height then
		return true
	else
		return false
	end
end

function fGrid:_onTouchMoved(e,x,y )
	self:setPosition(x - self.width/2,y - self.height/2)
end

function fGrid:_onTouchEnded( e,x,y )
	local parent = self:getParent()
	parent:onGirdMoveEnd(self,x,y)
	return true
end


function fGrid:dispose()
	self:removeTouchEventListener()
	self:removeFromParent()

	self:release()
end

return fGrid