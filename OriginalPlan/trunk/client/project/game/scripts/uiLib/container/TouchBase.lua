--[[--
class：     TouchBase
inherit: CCLayer
desc：       事件处理的基类
author:  wdx
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
	touchEnabled(isEnabled)
	setSwallowTouches(swallowTouches)
	可重写  onTouchDown   onTouchMove onTouchUp  onTouchCanceled
]]

local TouchBase = class("TouchBase",function()
	return display.newLayer()
end)

--[[
priority,  优先级
swallowTouches   是否吞事件
isEnabled   是否可点击  默认true
]]

function TouchBase:ctor(priority,swallowTouches,isEnabled)
	self:setContentSize(CCSize(0,0))
	self:ignoreAnchorPointForPosition(false)
	self:setAnchorPoint(ccp(0,0))

	self._priority = priority or 0


	self._swallowTouches = (swallowTouches == nil and true) or swallowTouches

	isEnabled = (isEnabled == nil and true) or isEnabled

	--处理触摸事件时，需要用到触摸过程中有没有移动、移动幅度的变量
  	self._touchDownPoint = nil
  	self._isMove = 0
	self:setScrollViewCheck(false)
	self:setTouchMoveValidCheck(false)
	self:turnAudioOn()

    self:touchEnabled(isEnabled)
  	self:retain()
end

function TouchBase:turnAudioOn()
	self:turnAudio(true)
end

function TouchBase:turnAudioOff()
	self:turnAudio(false)
end

function TouchBase:turnAudio(on)
	self._autoAudio = tobool(on)
end

function TouchBase:setAudioId(id)
	self._audioId = id
end

--是否在滚动面板的检测
function TouchBase:setScrollViewCheck(enable)
	self._scrollVeiwCheckEnable = tobool(enable)
	self._touchValidCheck = tobool(enable)
end

--[[
--@brief 点击事件之中移动太远后是否触发相关事件.
--@param flag boolean  true开启检测, false 关闭检测, 不设置则为false
--]]
function TouchBase:setTouchMoveValidCheck(flag)
	self._touchValidCheck = tobool(flag)
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

function TouchBase:touchPriority( priority )
	self._priority = priority
	self:setTouchPriority(priority)
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
	local rect = self:boundingBox()
	return rect
end

--[[
@brief 世界坐标系的坐标(x, y)是否在范围内
@return 包含则返回 true， 否则 false

子类有需求的可以 重写该方法
]]--
function TouchBase:touchContains(x, y)
	local parent = self:getParent()
	local pos = parent:convertToNodeSpace(ccp(x,y))
	local rect = self:getTouchRect()
	if rect:containsPoint(pos) then
		return true
	else
		return false
	end
end

-- support "began" "ended"

function TouchBase:setTouchStat(event)
	local rect = self:getTouchRect()
	local x,y = rect.origin.x, rect.origin.y

	return self:_onTouch(event, x, y)
end

-- 手动设置点击
function TouchBase:setTouchClick()
	self:setTouchStat("began")
	self:setTouchStat("ended")
end

function TouchBase:_onTouch(event,x,y)
	-- print("function TouchBase:_onTouch(event,x,y)", event,x,y)
	local ret
	if event == "began" then
		ret = self:_onTouchBegin(x,y)
	elseif event == "moved" then
		self:_onTouchMove(x,y)
	elseif event == "ended" then
		if self._autoAudio and self._audioId then
			AudioMgr:playEffect(self._audioId)
		end
		self:_onTouchEnd(x,y)
	elseif event == "canceled" then
		self:onTouchCanceled(x,y)
	end
	return ret
end

--触摸到检测区域内
function TouchBase:_onTouchBegin(x,y)
	if self:touchContains(x,y) then  --点击到了
	  	self._touchDownPoint = ccp(x,y)
	  	self._isMove = false
		if self._scrollVeiwCheckEnable and not uihelper.isTouchInView(self, x, y) then
			return false
		end
		return self:onTouchDown(x,y)
	else
		if self.onNotTouchOn then
			self.onNotTouchOn(self, x, y)
		end
		return false
	end
end

--触摸开始
function TouchBase:_onTouchMove( x,y )
	self:onTouchMove(x,y)
	if self._touchValidCheck then
		if not self._isMove and math.abs(self._touchDownPoint.x-x) + math.abs(self._touchDownPoint.y-y) > 50 then
			self._isMove = true
		end
		if self._isMove then
			self:onTouchMoveOut(x,y)
		end
	end
end

--触摸结束
function TouchBase:_onTouchEnd(x,y)
	if (not self._touchValidCheck or not self._isMove ) and self:touchContains(x,y) then
		self:onTouchUp(x,y)
	else
		self:onTouchCanceled(x,y)
	end
	self:onTouchEnd(x,y)
end

--子类有需求的可以 重写该方法
function TouchBase:onTouchDown(x,y)
	-- print("function TouchBase:onTouchDown(x,y)", x, y)
	return true
end

function TouchBase:onTouchMoveOut(x,y)

end

--子类有需求的可以 重写该方法
function TouchBase:onTouchMove( x,y )

end

--子类有需求的可以 重写该方法
function TouchBase:onTouchUp( x,y )

end

--子类有需求的可以 重写该方法
function TouchBase:onTouchCanceled( x,y )

end

--子类有需求的可以 重写该方法
function TouchBase:onTouchEnd(x,y)

end

function TouchBase:dispose()
  	self._touchDownPoint = nil
  	self:removeFromParent()
	self:removeTouchEventListener()
	self:release()
end

return TouchBase
