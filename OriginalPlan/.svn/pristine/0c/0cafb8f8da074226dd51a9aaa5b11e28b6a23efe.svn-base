--[[
	class:		TimeCenter
	desc:		时间管理器，用于处理刷新时间等操作
]]

local TimeCenter = {}

----------TimeCenter 常量定义----------------------
TimeCenter.DAILY_REFRESH_TIME = {hour =5, min = 0, sec = 0}

-----------常量定义 end------------------------

--[[
	desc:初始化函数
]]
function TimeCenter:init()
	self._refreshList = {}
	self._scheduleHandle = nil
	self._index = 0

	NetCenter:addMsgHandler(MsgType.NET_TIME_REQ, {self, self._onGetNetTime})

	self:_reqNetTime()

	self._secondTimer = scheduler.scheduleGlobal(function(dt) NotifyCenter:dispatchEvent({name =Notify.SECOND_CLOCK,dt = dt } ) end, 1)
end

--[[
	desc:向服务器请求服务器时间
]]
function TimeCenter:_reqNetTime()
	NetCenter:send(MsgType.NET_TIME_REQ)
end

--[[
	desc:对服务器的服务器时间请求应答的处理函数
]]
function TimeCenter:_onGetNetTime(event)
	self._timeDiff = event.msg.nowTime - os.time()

	self:_startTimer()
end

function TimeCenter:_startTimer()
	self:clear()
	local leftTime = self:getRefreshLeftTime()
	leftTime = leftTime + 1  --多加1秒刷新
	self._scheduleHandle = scheduler.performWithDelayGlobal(function()
		self._scheduleHandle = nil
	 	self:_refreshDay()
	 end, leftTime)
end

--每日刷新
function TimeCenter:_refreshDay()
	self:_startTimer()
	NotifyCenter:dispatchEvent({name = Notify.DAILY_REFRESH})
end

--[[
	desc:获取当前的服务器时间 秒
]]
function TimeCenter:getTime()
	if not self._timeDiff then
		nowTime = os.time()
	else
		nowTime = os.time() + self._timeDiff
	end
	return nowTime
end

--获取每天刷新的剩余时间 凌晨5点刷新   单位： 秒
function TimeCenter:getRefreshLeftTime()
	local now = self:getTime()
	local date = os.date("*t", nowTime)
	local refreshData = TimeCenter.DAILY_REFRESH_TIME
	local offsetTime = (refreshData.hour*60*60 + refreshData.min*60 + refreshData.sec ) - (date.hour*60*60 + date.min*60 + date.sec)
	if offsetTime >= 0 then
		return offsetTime
	else
		return 24*60*60 + offsetTime
	end
end

function TimeCenter:clear()
	if self._scheduleHandle then
		scheduler.unscheduleGlobal(self._scheduleHandle)
		self._scheduleHandle = nil
	end
	if self._secondTimer then
		scheduler.unscheduleGlobal(self._secondTimer)
		self._secondTimer = nil
	end
end


return TimeCenter