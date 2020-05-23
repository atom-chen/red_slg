--[[
	class:		SchedulerHandlerExtend
	author:		郑智敏
]]
local SchedulerHandlerExtend = {}

function SchedulerHandlerExtend.extend(target )
	function target:unscheduleHandle(handleName)
		if nil ~= self[handleName] then
			scheduler.unscheduleGlobal(self[handleName])
			self[handleName] = nil
		end
	end

	function target:scheduleHandle(handleName, func, timeDiff)
		self:unscheduleHandle(handleName)
		self[handleName] = scheduler.scheduleGlobal(func, timeDiff)
	end
end

return SchedulerHandlerExtend