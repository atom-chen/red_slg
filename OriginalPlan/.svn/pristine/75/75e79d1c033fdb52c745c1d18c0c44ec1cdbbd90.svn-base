--
-- Author: wdx
-- Date: 2016-05-03 16:36:16
--

local CDTextDelegate = class("CDTextDelegate")

function CDTextDelegate:ctor(text,formatStr)
	self._formatTimeFunc = util.formatTime  --默认的格式化时间方法 xx:xx:xx
	self._text = text
	self:setText(formatStr)
	-- print(debug.traceback())
end

function CDTextDelegate:setText(formatStr)
	self._formatStr = formatStr
end

function CDTextDelegate:setEndCallback(func)
	self._endCallback = func
end

--格式化 时间的方法   func  接受一个cd （秒）  返回一个字符串  参看 util.formatTime
function CDTextDelegate:setFormatTimeFunc(func)
	self._formatTimeFunc = func
end

--设置cd  剩余多少毫秒秒
function CDTextDelegate:setTime(cd)
	local endTime = TimeCenter:getTime() + cd
	self:setEndTime(endTime)
end

--设置结束时间  毫秒
function CDTextDelegate:setEndTime(endTime)
	if endTime < TimeCenter:getTime() then
		self:_timeEnd()
	else
		self._endTime = endTime
		self:start()
	end
end

function CDTextDelegate:start()
	NotifyCenter:addEventListener(Notify.SECOND_CLOCK, {self,self._onTimer})
	self:_updateText()
end

function CDTextDelegate:stop()
	NotifyCenter:removeEventListener(Notify.SECOND_CLOCK, {self,self._onTimer})
end

function CDTextDelegate:_onTimer()
	if self._endTime < TimeCenter:getTime() then
		self:_timeEnd()
	else
		self:_updateText()
	end
end

function CDTextDelegate:_updateText()
	local cd = math.ceil( (self._endTime - TimeCenter:getTime()))
	cd = math.max(cd,0)
	local cdStr = self._formatTimeFunc(cd)
	if self._text.setText then
		self._text:setText(string.format(self._formatStr,cdStr))
	else
		self._text:setString(string.format(self._formatStr,cdStr))
	end
end

function CDTextDelegate:_timeEnd()
	self._cd = 0
	self._endTime = 0
	self:_updateText()
	self:stop()
	uihelper.call(self._endCallback)
end

function CDTextDelegate:dispose()
	self:stop()
end

return CDTextDelegate