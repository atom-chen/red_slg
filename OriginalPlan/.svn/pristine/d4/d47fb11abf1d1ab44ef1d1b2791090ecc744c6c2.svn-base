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

	self.magic = SimpleMagic.new(55)
	self.okBtn:addChild(self.magic)

	local size = self.okBtn:getContentSize()
	self.magic:setPosition(size.width/2,size.height/2)

	self:addAccountBtn()

	if gamePlatform:isVisitor() then
		self:addBindtBtn()
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

function SelectServerState:show(serverList)
	StateBase.show(self)

	self._serverList = serverList
	local serverInfo = gamePlatform:getServerInfo()
	self:_showServer(serverInfo)

	self:addNetErrorHandler()
	self:addNetFailHandler()
	--scheduler.performWithDelayGlobal(function() self:changeState(StateBase.UPDATE) end ,1)


end

--点击换服
function SelectServerState:_onServerBtn()
	gamePlatform:addEventListener(PlatformEvent.CHANGE_SERVER_END, {self,self._onChangeServer})
	gamePlatform:changeServer()
end

function SelectServerState:_onChangeServer(event)
	gamePlatform:removeEventListener(PlatformEvent.CHANGE_SERVER_END, {self,self._onChangeServer})
	local serverInfo = gamePlatform:getServerInfo()
	self:_showServer(serverInfo)
end

function SelectServerState:_showServer( serverInfo )
	CCLuaLog("SelectServerState:_showServer1111111111111")
	if serverInfo then
		CCLuaLog("SelectServerState:_showServer22222222222222")
		local statusStr = ""
		-- if serverInfo.status == 1 then
		-- 	statusStr = "(维护中)"
		-- end
		if serverInfo.serverId then
			CCLuaLog("SelectServerState:_showServer3333333333")
		else
			CCLuaLog("SelectServerState:_showServer4444444444")
		end

		if serverInfo.serverName then
			CCLuaLog("SelectServerState:_showServer5555555555")
		else
			CCLuaLog("SelectServerState:_showServer66666666666"..serverInfo.serverName)
		end
		self.server:setText(tostring(serverInfo.serverId).."服    "..serverInfo.serverName,24,"",nil,nil,nil,nil,nil,1)
	end
end

--准备进入游戏  先要平台验证
function SelectServerState:_onEnterBtn()
	local serverInfo = gamePlatform:getServerInfo()
	if serverInfo then
		gamePlatform:addEventListener(PlatformEvent.LOGIN_GAME_END, {self,self._onPlatformLoginGameEnd})
		gamePlatform:loginGameServer(tostring(serverInfo.serverId),serverInfo.sName)
	else
		self:tipExitGame("无法获取服务器信息，请重新启动游戏进行尝试。")
	end
end

--正式开始登录游戏服
function SelectServerState:_onPlatformLoginGameEnd(event)
	gamePlatform:removeEventListener(PlatformEvent.LOGIN_GAME_END, {self,self._onPlatformLoginGameEnd})
	if event.status == "ok" then
		self:toEntryServer()
	elseif event.status == "error" then
		if event.errorMsg then
			openTipPanel(event.errorMsg)
		else
			local str = "平台登录验证错误，请重新启动游戏进行尝试。"
			if event.errorCode then
				str = str..event.errorCode
			end
			self:tipExitGame(str)
		end
	end
end

function SelectServerState:toEntryServer()
	local serverInfo = gamePlatform:getServerInfo()
	CCUserDefault:sharedUserDefault():setStringForKey("server_index",""..serverInfo.serverId )
	CCUserDefault:sharedUserDefault():flush()

	self:enableTouch(false)
	CCLuaLog("_onPlatformLoginGameEnd"..serverInfo.serverId)
	NetCenter:addMsgHandler(MsgType.SELECT_SERVER_MSG_RET, {self,self.onServerInfo},1,true)
	NetCenter:send(MsgType.SELECT_SERVER_MSG,serverInfo.serverId)  --选择服务器id
	LoadingControl:show("toEntryServer",true)
end

function SelectServerState:onServerInfo(pack)
	LoadingControl:stopShow("toEntryServer")
	local msg = pack.msg
	NetCenter:removeMsgHandler(MsgType.SELECT_SERVER_MSG_RET, {self,self.onServerInfo})

	if msg.result == 0 then
	 	--断开  于 登录服务器的链接    重新链接游戏服务器
	 	GAME_MD5 = msg.md5
		GAME_ACCOUNT = msg.accountId
		local serverInfo = gamePlatform:getServerInfo()
		GAME_SERVER_ID = tonumber(serverInfo.serverId)
		SERVER_NAME = serverInfo.sName
		PLATFORM_ID = msg.platformId
	 	if NetCenter:connect(msg.ip,msg.port) then
	 		self:onConnect()
	 	else
			NetCenter:addMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	 	end
	else
		self:enableTouch(true)
		local str = LangCfg:getErrorString(msg.result)
		if not str  then  --封号
			str = "未知错误："..msg.result
		end
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
    local userInfo = gamePlatform:getUserInfo()
    msg.platformId = PLATFORM_ID
    msg.accountId = GAME_ACCOUNT
    msg.md5 = GAME_MD5
    msg.relogin = 0
    msg.channel = gamePlatform:getChannelId() or "wucai"

    self:enableTouch(false)
	NetCenter:sendMsg(MsgType.LOGIN_GAME_SERVER_MSG,msg)  --登录游戏服  0表示第一次登录  不是断线重连
	NetCenter:addMsgHandler(MsgType.LOGIN_GAME_SERVER_MSG_RET, {self,self.onLoginGameServer},1,true)
	NetCenter:addMsgHandler(MsgType.GAME_SERVER_READY_MSG, {self,self.onServerReadyMsg},1,true)

	-- LoadingControl:show("loginGameServer")
end

--登录游戏
function SelectServerState:onLoginGameServer( pack )
    self:enableTouch(true)
	local msg = pack.msg
	if msg.result == 0 then  --登录成功  不发过来

	else
		if msg.result == -52 then
			--当前服务器没有角色，进入创建角色的界面
			ViewMgr:open(Panel.ROLE_CREATE)
			return
		end
		print("--登录失败 result=",msg.result)
		--登录失败
		local str = LangCfg:getErrorString(msg.result)
		if not str  then  --封号
			str = "未知错误："..msg.result
		end
        openErrorPanel(str)
		NetCenter:removeMsgHandler(MsgType.LOGIN_GAME_SERVER_MSG_RET, {self,self.onLoginGameServer})
		NetCenter:removeMsgHandler(MsgType.GAME_SERVER_READY_MSG, {self,self.onServerReadyMsg})
		-- LoadingControl:stopShow("loginGameServer")
	end
end

--服务端数据加载完成
function SelectServerState:onServerReadyMsg( pack )
	-- LoadingControl:stopShow("onLoginGameServer")
	-- local msg = pack.msg
	self:_checkLogin()
end

function SelectServerState:_checkLogin()
	    self:enableTouch(true)
		NetCenter:removeMsgHandler(MsgType.LOGIN_GAME_SERVER_MSG_RET, {self,self.onLoginGameServer})
		NetCenter:removeMsgHandler(MsgType.GAME_SERVER_READY_MSG, {self,self.onServerReadyMsg})
		self:changeState(StateMgr.GAME)
		-- LoadingControl:stopShow("loginGameServer")


end


function SelectServerState:dispose()
	NetCenter:removeMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	NetCenter:removeMsgHandler(MsgType.LOGIN_GAME_SERVER_MSG_RET, {self,self.onLoginGameServer})
	NetCenter:removeMsgHandler(MsgType.GAME_SERVER_READY_MSG, {self,self.onServerReadyMsg})
	NetCenter:removeMsgHandler(MsgType.SELECT_SERVER_MSG_RET, {self,self.onServerInfo})

	gamePlatform:removeEventListener(PlatformEvent.CHANGE_SERVER_END, {self,self._onChangeServer})
	gamePlatform:removeEventListener(PlatformEvent.LOGIN_GAME_END, {self,self._onPlatformLoginGameEnd})

	self:removeMouseEvent()
	self.server:dispose()
	self.okBtn:dispose()
	self.magic:dispose()
	ResMgr:unload("ui/login/login.pvr.ccz")
	StateBase.dispose(self)
end

return SelectServerState