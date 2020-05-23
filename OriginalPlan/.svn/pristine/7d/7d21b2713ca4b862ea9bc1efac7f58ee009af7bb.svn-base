--
-- Author: lyc
-- Date: 2016-05-24 14:49:00
--

local TownNodeBase = class('TownNodeBase', function()  return display.newNode() end)

TownNodeBase.LOAD_HANDLE = 'townnodebase_load_handle'
TownNodeBase.UNLOAD_HANDLE = 'townnodebase_unload_handle'

function TownNodeBase:ctor( _town , enterNum )
	self._town = _town
	self._enterNum = enterNum
	self:setNodeEventEnabled(true)
	SchedulerHandlerExtend.extend(self)
end

function TownNodeBase:load()
	self:unscheduleHandle(self.UNLOAD_HANDLE)
	self:scheduleHandle(self.LOAD_HANDLE, function()
		self:startLoading()
		self:unscheduleHandle(self.LOAD_HANDLE)
	end, 0.1 * self._enterNum)
end

function TownNodeBase:unload()
	self:unscheduleHandle(self.LOAD_HANDLE)
	self:scheduleHandle(self.UNLOAD_HANDLE, function()
		self:startUnloading()
		self:unscheduleHandle(self.UNLOAD_HANDLE)
	end, 0.1 * self._enterNum)
end

function TownNodeBase:startLoading()
end

function TownNodeBase:startUnloading()

end

function TownNodeBase:dispose()

end

return TownNodeBase