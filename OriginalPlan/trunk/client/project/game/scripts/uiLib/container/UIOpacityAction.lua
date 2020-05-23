local UIOpacityAction = class("UIOpacityAction")


function UIOpacityAction:ctor(beginOpacity, endOpacity, duration, times, callback)
	self._callback = callback
	self._interval = 0.02
	self._duration = duration or 2
	self._stepCount = math.floor(self._duration / self._interval)

	self._begin = beginOpacity
	self._end = endOpacity

	self._opacity = self._begin
	self._step = (endOpacity - beginOpacity)/self._stepCount
	self._idx = 0
	self._times = 0
	self._totleTimes = tonumber(times or -1)
end

function UIOpacityAction:setInerval(interval)
	self._interval = interval
end

function UIOpacityAction:setDuration(duration)
	self._duration = duration
end

function UIOpacityAction:_changeOpacity()
--	print("function UIOpacityAction:_changeOpacity()", self._idx, self._stepCount)
	local ret = true
	if self._idx == 2*self._stepCount then
		self._idx = 0

		self._times = self._times + 1
		if self._totleTimes < 0 then
			ret = true
		elseif self._times == self._totleTimes then
			ret = false
		end
	else
		self._idx = self._idx + 1

	end

	local opacity = self._end - math.abs(self._idx - self._stepCount)*self._step
	--print(opacity)
	self._targetNode:setOpacity(opacity)

	return ret
end

function UIOpacityAction:start()
	print("function UIOpacityAction:start()")
	if self._timer then
		self._timer:dispose()
		self._timer = nil
	end
	self._timer = UISimpleTimer.new(self._interval, {self, self._changeOpacity}, self._callback)
	self._timer:start(false)
end

function UIOpacityAction:stop()
	if self._timer then
		self._timer:dispose()
		self._timer = nil
	end
end

function UIOpacityAction:setCallback(callback)
	self._callback = callback
end

function UIOpacityAction:setTarget(node)
	self._targetNode = node
end

function UIOpacityAction:getTarget()
	return self._targetNode
end

function UIOpacityAction:dispose()
	self:stop()
end


return UIOpacityAction