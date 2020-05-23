--[[
	class:		LoadingControl
	desc:		读取控制器
	author:		郑智敏
]]

local LoadingControl = {}

function LoadingControl:init()
	self._loadingList = {}
	self._unstopList = {}
	self._count = 0
	self._timeCount = 0
end

function LoadingControl:setText(str)
	local panel = ViewMgr:getPanel(Panel.LOADING)
	if panel then
		panel:setText(str)
	end
end

function LoadingControl:onTimer()
	self._timeCount = self._timeCount or 0
	self._timeCount = self._timeCount + 1
	if 5 < self._timeCount then
		for _,v in pairs(self._unstopList) do
			if true == v then
				return
			end
		end
		-- for loadingName,v in pairs(self._loadingList) do
		-- 	if v > 0 then
		-- 		NotifyCenter:dispatchEvent({name = Notify.LOADING_OVER_TIME, loadingName = loadingName})
		-- 	end
		-- end
		self:stopAll()
	end
end

function LoadingControl:show(loadingName, unstopFlag)
	print("show loading",loadingName, unstopFlag)

	if nil == self._loadingList[loadingName] then
		self._loadingList[loadingName] = 1
	else
		self._loadingList[loadingName] = self._loadingList[loadingName] + 1
	end
	self._count = self._count + 1
	if true ~= self._unstopList[loadingName] and true == unstopFlag then
		self._unstopList[loadingName] = true
	elseif not unstopFlag then
		self._timeCount = 0
	end
	ViewMgr:open(Panel.LOADING)

	if nil == self._scheduleHandle then
		self._scheduleHandle = scheduler.scheduleGlobal(function() self:onTimer() end, 1.0)
	end
end

function LoadingControl:stopShow(loadingName)
	print("close loading",loadingName)
	if nil == self._loadingList[loadingName] or 0 == self._loadingList[loadingName] then
		return
	end

	self._loadingList[loadingName] = self._loadingList[loadingName] - 1
	if self._loadingList[loadingName] > 0 then
		return
	end
	self._unstopList[loadingName] = nil
	self._count = self._count - 1
	if 0 < self._count then
		return
	end
	ViewMgr:close(Panel.LOADING)
	if nil ~= self._scheduleHandle then
		scheduler.unscheduleGlobal(self._scheduleHandle)
		self._scheduleHandle = nil
	end
end

function LoadingControl:stopAll()
	self._loadingList = {}
	self._unstopList = {}
	self._count = 0
	if nil ~= self._scheduleHandle then
		scheduler.unscheduleGlobal(self._scheduleHandle)
		self._scheduleHandle = nil
	end
	ViewMgr:close(Panel.LOADING)
end

return LoadingControl