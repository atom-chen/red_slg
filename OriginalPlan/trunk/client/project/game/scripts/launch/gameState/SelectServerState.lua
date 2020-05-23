--
-- Author: wdx
-- Date: 2014-06-03 10:43:02
--

local SelectServerState = class("SelectServerState",StateBase)

function SelectServerState:ctor(stateMgr)
	StateBase.ctor(self,stateMgr)
	self.clsType = StateMgr.SELECT_SERVER
end

function SelectServerState:init()
	-- body
	self:initBg()
	self:initUI()
end

function SelectServerState:initUI()
	ResMgr:loadPvr("ui/login/login.pvr.ccz")

	self:addLogo()

	self.server = UIButton.new({"#login_fwq.png"})
	-- self.server:setSize(CCSize(480,70))
	self.server:setAnchorPoint(ccp(0.5,0))
	self.server:setPosition(display.cx,140)
	self:addChild(self.server)

	self.okBtn = UIButton.new({"#login_btn_jryx.png"})
	self.okBtn:setAnchorPoint(ccp(0.5,0))
	self.okBtn:setPosition(display.cx,40)
	-- self.okBtn:setText("进入游戏",30,"",ccc3(255,243,218),nil,nil,nil,nil,1)
	self:addChild(self.okBtn)
	-- self.magic = SimpleMagic.new(55)
	-- local size = self.okBtn:getContentSize()
	-- self.magic:setPosition(size.width/2,size.height/2)
	-- self.okBtn:addChild(self.magic)

	if gamePlatform:support(PlatformSupport.CHANGE_ACCOUNT) then
		self:addAccountBtn()
	end

	self:addMouseEvent()
end

function SelectServerState:addMouseEvent()
	self.server:addEventListener(Event.MOUSE_CLICK,{self,self._onServerBtn})
	self.okBtn:addEventListener(Event.MOUSE_CLICK,{self,self._onEnterBtn})
	StateBase.addMouseEvent(self)
end

function SelectServerState:removeMouseEvent()
	self.server:removeEventListener(Event.MOUSE_CLICK,{self,self._onServerBtn})
	self.okBtn:removeEventListener(Event.MOUSE_CLICK,{self,self._onEnterBtn})
	StateBase.removeMouseEvent(self)
end

function SelectServerState:getServerInfo(serverId)
	if self._serverList then
		for i,serverInfo in ipairs(self._serverList) do
			if serverId == serverInfo.serverId then
				return serverInfo
			end
		end
	end
	return nil
end

--获取上次登录的服务器
function SelectServerState:_getLastLoginServer()
	if self._serverList and self._serverList.lastLoginServerList then
		for i,loginInfo in ipairs(self._serverList.lastLoginServerList) do
			local sInfo = self:getServerInfo(loginInfo.serverId)
			if sInfo then
				return sInfo
			end
		end
	end
	return self:_getLastLoginServerLocal()
end

function SelectServerState:_getLastLoginServerLocal()
	local sId = CCUserDefault:sharedUserDefault():getStringForKey("lastLoginServer")
	if sId ~= "" then
		local sList = string.split(sId,":")
		print(sList[1],ACCOUNT_ID,sId)
		if sList[1] == ACCOUNT_ID then
			print(sList[1],ACCOUNT_ID,sId)
			sId = tonumber(sList[2])
			return self:getServerInfo(sId)
		end
	end
	return nil
end

function SelectServerState:getDefaultServer()
	if self._serverList then
		if (device.platform == "windows" and DEBUG == 2) then
			for i,sInfo in pairs(self._serverList) do
				if sInfo.serverId == 21 then
					return sInfo
				end
			end
			return self._serverList[1]
		else
			for i=#self._serverList,1,-1 do
				local info = self._serverList[i]
				if info.status ~= 0 then
					return info
				end
			end
			return self._serverList[#self._serverList]
		end
	end
	return nil
end

function SelectServerState:_onLastLoginServer(event)
	LoadingControl:stopShow("LAST_LOGIN_SERVER")
	local msg = event.msg
	NetCenter:removeMsgHandler(MsgType.LAST_LOGIN_SERVER_RET, {self,self._onLastLoginServer},1)
	self._serverList.lastLoginServerList = msg.loginLogList
	self:show(self._serverList,self.serverId)
end

function SelectServerState:_handleServerList(serverList)
	if device.platform == "ios" then
		local startIndex = tonumber(GameCfg:getValue("serverStart"))
		if startIndex and startIndex > 1 then
			for i=#serverList,1,-1 do
				local sInfo = serverList[i]
				if sInfo.serverId < startIndex then
					table.remove(serverList,1)
				else
					sInfo.showIndex = sInfo.serverId - startIndex + 1
				end
			end
		end
	end
end

function SelectServerState:show(serverList, serverId)
	StateBase.show(self)

	self:_handleServerList(serverList)

	self._serverList = serverList

	local sInfo = nil
	if serverId then
		sInfo = self:getServerInfo(serverId)
	end

	if not sInfo then
		sInfo = self:_getLastLoginServer()
	end

	if not sInfo then
		if not self._serverList.lastLoginServerList then--没有上次登录的服务器列表  需要请求
			self.serverId = serverId
			NetCenter:addMsgHandler(MsgType.LAST_LOGIN_SERVER_RET, {self,self._onLastLoginServer})
			NetCenter:send(MsgType.LAST_LOGIN_SERVER)  --请求上次登录过的服务器列表
			LoadingControl:show("LAST_LOGIN_SERVER",true)
			return
		end
	end
	if not sInfo then
		sInfo = self:getDefaultServer()
	end
	self:_showServer(sInfo)


	self:addNetErrorHandler()
	self:addNetFailHandler()
	--scheduler.performWithDelayGlobal(function() self:changeState(StateBase.UPDATE) end ,1)

	--gamePlatform:showPlatformIcon(true)
end

--点击换服
function SelectServerState:_onServerBtn(  )
	--[[
	local index = self.curServerId + 1
	if index > #self._serverList then
		index = 1
	end
	self:_showServer(index)
	--]]
	self:changeState(StateMgr.SERVER_LIST, self._serverList)
end

function SelectServerState:_showServer( serverInfo )
	if serverInfo then
		local sId = serverInfo.showIndex or serverInfo.serverId
		self.server:setText(tostring(sId).."服    "..serverInfo.serverName,24,"",nil,nil,nil,nil,nil,1)
		self.serverId = serverInfo.serverId
	end
end

function SelectServerState:_onEnterBtn()
	self:toEntryServer(self.serverId)
end

function SelectServerState:toEntryServer(id)
	local sInfo = self:getServerInfo(id)
	if sInfo and sInfo.status == 0 then
		local gameClose = gamePlatform:getRemoteValue("gameClose")
		if gameClose then
            local btnList = { {text="确定",obj=self,callfun=toExitGame}}
        	openErrorPanel(gameClose,btnList)
		else
			local btnList = { {text="确定",obj=self,callfun=toExitGame}}
        	openTipPanel("服务器维护中，请选择其他服务器进入",btnList)
		end
		return
	end

	self:enableTouch(false)

	NetCenter:addMsgHandler(MsgType.SELECT_SERVER_MSG_RET, {self,self.onServerInfo},1,true)
	NetCenter:send(MsgType.SELECT_SERVER_MSG,id)  --选择服务器id
end

function SelectServerState:onServerInfo(pack)
	local msg = pack.msg
	NetCenter:removeMsgHandler(MsgType.SELECT_SERVER_MSG_RET, {self,self.onServerInfo})

	if msg.result == 0 then
	 	--断开  于 登录服务器的链接    重新链接游戏服务器
	 	GAME_MD5 = msg.md5
		GAME_ACCOUNT = msg.accountId
		GAME_SERVER_ID = self.serverId
		local sInfo = self:getServerInfo(GAME_SERVER_ID)
		if sInfo then
			SERVER_NAME = sInfo.serverName
		else
			SERVER_NAME = "未知服务器"
		end
		if SERVER_NAME == "" then
			SERVER_NAME = "测试服"..GAME_SERVER_ID
		end

		PLATFORM_ID = msg.platformId
		-- print("serverName..."..SERVER_NAME)
        -- CCLuaLog("SelectServerState:onServerInfo md5:"..msg.md5)
	 	if NetCenter:connect(msg.ip,msg.port) then
	 		self:onConnect()
	 	else
			NetCenter:addMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	 	end

	 	CCUserDefault:sharedUserDefault():setStringForKey("lastLoginServer",ACCOUNT_ID..":"..self.serverId )
		CCUserDefault:sharedUserDefault():flush()
	else
		self:enableTouch(true)
		local str = "server info error："..msg.result
        openTipPanel(str)
	end
end

--链接上 游戏服了
function SelectServerState:onConnect()
	NetCenter:removeMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})

	local msg = {}
	if device.platform == "android" then
        msg.os = 1
    elseif device.platform == "ios" then
        if GameCfg:getBoolean("iosLegal") then  --正版
        	msg.os = 3
        else
        	msg.os = 2
        end
    else
        msg.os = 3
    end
    msg.osVersion = device.phone_model or "unknow"
    if device.phone_sys_ver then
        msg.osVersion = msg.osVersion .. "  "..device.phone_sys_ver
    end
	msg.serverId = self.serverId;
    msg.platformId = PLATFORM_ID
    msg.accountId = GAME_ACCOUNT
    msg.md5 = GAME_MD5
    msg.relogin = 0
    msg.channel = gamePlatform:getChannelId() or "wucai"

	NetCenter:sendMsg(MsgType.LOGIN_GAME_SERVER_MSG,msg)  --登录游戏服  0表示第一次登录

	NetCenter:addMsgHandler(MsgType.LOGIN_GAME_SERVER_MSG_RET, {self,self.onLoginGameServer},1,true)
	NetCenter:addMsgHandler(MsgType.GAME_SERVER_READY_MSG, {self,self.onServerReadyMsg},1,true)

	-- LoadingControl:show("loginGameServer")
end

--登录游戏
function SelectServerState:onLoginGameServer( pack )
	local msg = pack.msg
	if msg.result == 0 then  --登录成功  不发过来

	else  --登录失败
		if msg.result == -52 then
			--当前服务器没有角色，进入创建角色的界面
			ViewMgr:open(Panel.ROLE_CREATE)
			return
		end
		print("--登录失败 result=",msg.result)
		local str = LangCfg:getErrorString(msg.result)
		if not str  then  --封号
			str = "未知错误："..msg.result
		end
        openErrorPanel(str)
		NetCenter:removeMsgHandler(MsgType.LOGIN_GAME_SERVER_MSG_RET, {self,self.onLoginGameServer})
		NetCenter:removeMsgHandler(MsgType.GAME_SERVER_READY_MSG, {self,self.onServerReadyMsg})
		-- LoadingControl:stopShow("loginGameServer")
		self:enableTouch(true)
	end
end

--服务端数据加载完成
function SelectServerState:onServerReadyMsg( pack )
	-- local msg = pack.msg
	self:_checkLogin()
end

function SelectServerState:_checkLogin()
	self:enableTouch(true)
	NetCenter:removeMsgHandler(MsgType.LOGIN_GAME_SERVER_MSG_RET, {self,self.onLoginGameServer})
	NetCenter:removeMsgHandler(MsgType.GAME_SERVER_READY_MSG, {self,self.onServerReadyMsg})
	-- print("stare...."..StateMgr.GAME)

	self:changeState(StateMgr.GAME)
	-- LoadingControl:stopShow("loginGameServer")
end


function SelectServerState:dispose()
	NetCenter:removeMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	NetCenter:removeMsgHandler(MsgType.LOGIN_GAME_SERVER_MSG_RET, {self,self.onLoginGameServer})
	NetCenter:removeMsgHandler(MsgType.GAME_SERVER_READY_MSG, {self,self.onServerReadyMsg})
	NetCenter:removeMsgHandler(MsgType.SELECT_SERVER_MSG_RET, {self,self.onServerInfo})

	self:removeMouseEvent()
	self.server:dispose()
	self.okBtn:dispose()
	-- self.magic:dispose()
	StateBase.dispose(self)
	ResMgr:unload("ui/login/login.pvr.ccz")
end

return SelectServerState