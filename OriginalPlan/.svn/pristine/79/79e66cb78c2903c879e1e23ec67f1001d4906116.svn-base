-- anchor: changao
-- date: 2014-9-19

local UISimpleTimer = class("UISimpleTimer")

function UISimpleTimer:ctor(interval, callback, onCompete)
	self._interval = interval or 1
	self._callback = callback
	self._onComplete = onCompete
	self._handler = nil
end

function UISimpleTimer:_timerEnd()
	uihelper.call(self._onComplete, {this=self})
end

function UISimpleTimer:_timerFun()
	local ret = false
	if self._callback then
		ret = uihelper.call(self._callback, {this=self})
	end
	if not ret then
		self:_timerEnd()
		self:stop()
	end
	return ret
end

-- callImmediately立即调用 默认为true
function UISimpleTimer:start(callImmediately)
	if self._handler then
		return false
	end
	local callback = function() self:_timerFun() end
	self._handler = scheduler.scheduleGlobal(callback, self._interval)
	if callImmediately == nil or tobool(callImmediately) then
		self._callImmediately = true
		callback()
	else
		self._callImmediately = false
	end
	return true
end

function UISimpleTimer:isStarImmediately()
	return self._callImmediately
end

function UISimpleTimer:loopStart()
	while self:_timerFun()  do
	end
end

function UISimpleTimer:isRunning()
	return tobool(self._handler)
end

function UISimpleTimer:stop()
	if self._handler then
		scheduler.unscheduleGlobal(self._handler)
		self._handler = nil
	end
end

function UISimpleTimer:dispose()
	self:stop()
	self._interval = nil
	self._callback = nil
	self._onComplete = nil
	self._handler = nil
end

return UISimpleTimer