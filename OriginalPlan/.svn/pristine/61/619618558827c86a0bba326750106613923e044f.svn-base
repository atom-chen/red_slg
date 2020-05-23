--[[--
module：   StatSender
desc：        发送 http
]]

local StatSender = {}

function StatSender:init(bugUrl)
    self.bugUrl = bugUrl or GameCfg:getValue("bughttp")
	self._packCount = 0
	self._reqMap = {}
end

--[[--
	purchase
]]
function StatSender:sendPurchase(pack)
	local url
	if gamePlatform then
		url = gamePlatform:getRemoteValue("purchasehttp") 
	end
	if not url or url == "" then
		url = GameCfg:getValue("purchasehttp")
	end


	local request = network.createHTTPRequest(function (event)
		local req = event.request
		if event.name == "completed" and req:getResponseStatusCode() == 200 then
			local str = req:getResponseString()
			print(str)
			print(req:getResponseData())
		end
	end,url,"POST")
	-- request:retain()
	request:addRequestHeader("Content-Type:application/x-www-form-urlencoded")

	for k,v in pairs(pack) do
		request:addPOSTValue(k,v)
	end
	request:start()
end

function StatSender:sendBug(bugStr)
	if not self.bugUrl or self.bugUrl == "" then
		return
	end
	if self.lastBugStr ~= bugStr then
        self.lastBugStr = bugStr
    else
    	return
    end
	local request = network.createHTTPRequest(function (event) self:_onResponse(event) end,self.bugUrl,"POST")
	-- request:retain()
	request:addRequestHeader("Content-Type:application/x-www-form-urlencoded")

	local model = device.phone_model or ""
	local sys_ver = device.phone_sys_ver or ""

	local pid = CMJYXConfig:GetInst():getStringForKey("platform")
    local sId = GAME_SERVER_ID or CCUserDefault:sharedUserDefault():getStringForKey("server_index")
    local aId = CCUserDefault:sharedUserDefault():getStringForKey("gameUserName")
    if RoleModel and RoleModel.roleInfo then
    	sId = sId..","..string.format("%.0f",RoleModel.roleInfo.roleId)
    end
    local ch = gamePlatform:getChannelId() or ""
    local ver = CMJYXConfig:GetInst():getStringForKey("version")
    local gameVer = GAME_VER or GameCfg:getValue("version")

	request:addPOSTValue("platform_id",pid..","..ch)  --平台ID
	request:addPOSTValue("server_id",sId)  --服务器ID
	request:addPOSTValue("account_id",aId)  --帐号ID
	request:addPOSTValue("device",device.platform .. ":"..model)  --手机设备
	request:addPOSTValue("system_version", sys_ver) --系统版本
	request:addPOSTValue("client_version",gameVer..","..ver)  --客户端版本
	request:addPOSTValue("bug",bugStr) --bug字符串
	request:start()
end

function StatSender:_onResponse(event)
	local request = event.request
	if event.name == "completed" then
		local req = event.request
		local str = req:getResponseString()
		print(str)
		print(req:getResponseData())
	end
	-- self._reqMap[request.reqId] = nil
	-- request:release()
end

return StatSender