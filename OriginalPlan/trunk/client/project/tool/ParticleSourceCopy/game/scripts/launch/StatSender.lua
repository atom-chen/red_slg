--[[--
module：   StatSender
desc：        发送统计或日志消息给后台
author:  HAN Biao
event：
	无
example：
	local pack = {}
	pack.msgType = 10001
	StatSender:sendStat(pack)

	不需要监听返回
]]


local StatSenderCls = class("StatSender")
local StatSender = StatSenderCls.new()

function StatSenderCls:init(svrStatUrl)
	self._packCount = 0
	self._reqMap = {}
	self._svrStatUrl = svrStatUrl
end

--[[--
	向后台发送一个统计数据包
]]
function StatSenderCls:sendStat(pack,url)
	if (not url) and (not self._svrStatUrl) then
		return
	end
	local request = network.createHTTPRequest(self._onResponse,(url or self._svrStatUrl))
	request:addRequestHeader("Content-Type:application/x-www-form-urlencoded")
	self._packCount = self._packCount+1
	request.reqId = self._packCount
	self._reqMap[self._packCount] = request
  
  --[[--
	pack.accountId = ACCOUNT_ID
	pack.pf = PLATFORM_ID
	pack.roleId = ROLE_ID
	pack.svrid = SVRID_ID
  --]]
	local str = json.encode(pack, true)
	request:addPOSTValue("q",str)
	request:start()
end

function StatSenderCls:_onResponse(event)
	local request = event.request
	self._reqMap[request.reqId] = nil
	request:release()
end

return StatSender