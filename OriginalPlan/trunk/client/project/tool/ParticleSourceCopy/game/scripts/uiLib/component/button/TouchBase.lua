--[[--
class：     TouchBase
inherit: CCLayer
desc：       事件处理的基类
author:  HAN Biao
event：

触摸相关接口：
CCLayer/CCLayerExtend内置：
	setTouchEnabled(isEnabled)
	isTouchEnabled()
	getTouchPriority()
	setTouchPriority(priority)
	addTouchEventListener(handler,mutliTouches,priority,swallowTouches)
	removeTouchEventListener()

本类额外增加：
	changeTouchEnabled(isEnabled)
	setSwallowTouches(swallowTouches)
	接收事件，统一由派生类复写_onTouch()处理
]]

local TouchBase = class("TouchBase",function()
	return display.newLayer(false)
end)

function TouchBase:ctor(priority,swallowTouches)
	self:setContentSize(CCSize(0,0))
	self:ignoreAnchorPointForPosition(false)
	self:setAnchorPoint(ccp(0,0))

	self._priority = priority or 0
	self._swallowTouches = swallowTouches or false
	
	--处理触摸事件时，需要用到触摸过程中有没有移动、移动幅度的变量
	self._isMoved = false
  	self._touchDownPoint = nil
  	self._mhtDistance = 0

  	self:retain()
end

--[[--
	是否开启触摸
	@param isEnabled Boolean
]]
function TouchBase:touchEnabled(isEnabled)
	self:setTouchEnabled(isEnabled)
	if isEnabled then  --从未开启切换为开启，重新监听事件
		self:addTouchEventListener(handler(self,self._onTouch),false,self._priority,self._swallowTouches)
	else
		self:removeTouchEventListener()
	end
end

--[[--
	设置是否遮挡比自己优先级低的事件
	@param swallowTouches Boolean
]]
function TouchBase:setSwallowTouches(swallowTouches)
	swallowTouches = tobool(swallowTouches)
	if self._swallowTouches == swallowTouches then
		return
	end
	self._swallowTouches = swallowTouches
	if self:isTouchEnabled() then --如果开启了触摸，则重新监听
		self:addTouchEventListener(handler(self,self._onTouch),false,self._priority,self._swallowTouches)
	end
end

--获取点击区域   子类有需求的可以 重写该方法
function TouchBase:getTouchRect()
	local size = self:getContentSize()
	return {x=0,y=0,width=size.width,height=size.height}
end

--[[
@brief 世界坐标系的坐标(x, y)是否在范围内
@return 包含则返回 true， 否则 false

子类有需求的可以 重写该方法
]]--
function TouchBase:touchContains(x, y)
	local ox, oy = self:getPosition()
	local rect = self:getTouchRect()
	local worldPos = self:convertToWorldSpace(ccp(rect.x, rect.y))
	local width = rect.width
	local height = rect.height
	
	if (x >= worldPos.x and x <= worldPos.x+width) and (y >= worldPos.y and y <= worldPos.y+height) then
		return true
	else
		return false
	end
end

function TouchBase:_onTouch(event,x,y)
	local ret
	if event == "began" then
		ret = self:_onTouchBegin(x,y)
	elseif event == "moved" then
		self:_onTouchMove(x,y)
	elseif event == "ended" then
		self:_onTouchEnd(x,y)
	elseif event == "canceled" then
		self:onTouchCanceled(x,y)
	end
	return ret
end

--触摸到检测区域内   
function TouchBase:_onTouchBegin(x,y)
	if self:touchContains(x,y) then  --点击到了
		self._isMoved = false
	  	self._touchDownPoint = ccp(x,y) 
	  	self._mhtDistance = 0
	  	self:onTouchDown(x,y)
		return true   
	else
		return false
	end
end

--触摸结束
function TouchBase:_onTouchEnd(x,y)
	local nowPoint = ccp(x,y)--self:convertToWorldSpace(ccp(x,y))
	self._mhtDistance = util.mhtInstance(nowPoint,self._touchDownPoint)
	if self:_isTouchValid() then
		self:onTouchUp(x,y)
	else
		self:onTouchCanceled(x,y)
	end
end

--子类有需求的可以 重写该方法
function Touchbase:onTouchDown(x,y)
	-- body
end

--子类有需求的可以 重写该方法
function TouchBase:_onTouchMove( x,y )
	
end

--子类有需求的可以 重写该方法
function TouchBase:onTouchUp( x,y )
	
end

--子类有需求的可以 重写该方法
function TouchBase:onTouchCanceled( x,y )
	
end


--触摸到区域后，是否是有效触摸   有移动过  不算有效点击
function TouchBase:_isTouchValid()
	if self._isMoved then
	    if self._mhtDistance < GameConst.MHT_DISTANCE then
			return true
		else
		  return false
		end
	end
	return true
end

function TouchBase:dispose()
  	self._touchDownPoint = nil
	self:removeTouchEventListener()
	self:release()
end

return TouchBase