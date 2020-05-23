--[[
-- anchor: changao
-- date: 2014-10-21
-- desc:等待duration秒之后执行回调
--]]
local UIDelayCall = class("UIDelayCall")

function UIDelayCall:ctor(duration, callback, start)
	self._duration = duration or 1
	self._callback = callback
	self._handler = nil
	
	if start then
		self:start()
	end
end

function UIDelayCall:setDelayCall(duration, callback)
	self._duration = duration or 1
	self._callback = callback
end

function UIDelayCall:_timerFun()
	self:stop()
	if self._callback then
		uihelper.call(self._callback, {this=self})
	end
end

function UIDelayCall:start()
	if self._handler then
		return false
	end
	
	local callback = function() self:_timerFun() end
	self._handler = scheduler.scheduleGlobal(callback, self._duration)
	return true
end

function UIDelayCall:isRunning()
	return tobool(self._handler)
end

function UIDelayCall:stop()
	if self._handler then
		scheduler.unscheduleGlobal(self._handler)
		self._handler = nil
	end
end

function UIDelayCall:dispose()
	self:stop()
	self._duration = nil
	self._callback = nil
	self._handler = nil
end

return UIDelayCall