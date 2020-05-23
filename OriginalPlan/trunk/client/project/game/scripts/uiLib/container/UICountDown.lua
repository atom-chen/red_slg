-- anchor: changao
-- date: 2015-04-16

local UICountDown = class("UICountDown", UISimpleTimer)

function UICountDown:ctor(seconds, interval, callback, onCompete)
--[[
	local timer = UISimpleTimer.new(interval, {self, self._countDownFunc}, onCompete)
	for k,v in pairs(timer) do
		self[k] = v
	end
--]]
	UISimpleTimer.ctor(self, interval, {self, self._countDownFunc}, onCompete)
	self._countDown = {callback=callback, interval=interval, seconds=seconds}
end

function UICountDown:getLeftTime()
	return self._countDown.seconds
end

function UICountDown:_immdiateFunc()
	local ret = uihelper.call(self._countDown.callback, {seconds=self._countDown.seconds, interval=self._countDown.interval})

	if self._countDown.seconds <= 0 then
		return false
	end
	
	if not ret then
		return false
	end
	
	self._countDown.countFunc = self._delayFunc
	return true
end

function UICountDown:_delayFunc()
	local seconds = self._countDown.seconds
	local interval = self._countDown.interval
	seconds = seconds - interval
	self._countDown.seconds = seconds
	local ret = uihelper.call(self._countDown.callback, {seconds=seconds, interval=interval})
	
	if not ret then
		return false
	end
	if seconds <= 0 then
		return false
	end
	return ret
end

function UICountDown:_countDownFunc()
	if not self._countDown.countFunc then
		if self:isStarImmediately() then
			self._countDown.countFunc = self._immdiateFunc
		else
			self._countDown.countFunc = self._delayFunc
		end
	end
	return self._countDown.countFunc(self)
end


function UICountDown:dispose()
	UISimpleTimer.dispose(self)
	self._countDown = nil
end

return UICountDown