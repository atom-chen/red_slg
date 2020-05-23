--
-- Author: wdx
-- Date: 2014-06-03 10:06:47
--

--登录  账号  页面
local LoginState = class("LoginState",StateBase)


function LoginState:ctor(stateMgr)
	StateBase.ctor(self,stateMgr)
	self.clsType = StateMgr.LOGIN
end

function LoginState:init()
    self:initBg()
	self:initUI()
end

function LoginState:initUI(  )
	self:setTipText("开始连接服务器...")

	ResMgr:loadPvr("ui/login/login.pvr.ccz")
	if gamePlatform:support(PlatformSupport.CHANGE_ACCOUNT) then
		self:addAccountBtn()
	end

	self:addLogo()

	self:addMouseEvent()
end

function LoginState:show()
	StateBase.show(self)
	self:addNetErrorHandler()
	self:addNetFailHandler()

    self:_login()
end

function LoginState:_login()
	CCUserDefault:sharedUserDefault():setStringForKey("gameUserName",ACCOUNT_ID );
	CCUserDefault:sharedUserDefault():flush()

	if gamePlatform:getRemoteValue("serverClose") then  --服务器关闭
		self:tipExitGame(gamePlatform:getRemoteValue("serverClose"))
		return
	end

    if NetCenter:connect(SERVER_IP,SERVER_PORT) then  --连接服务器
		self:_toLogin()
	else
		self:setTipText("连接服务器中...")
		NetCenter:addMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	end
end

function LoginState:onConnect(  )
	NetCenter:removeMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	self:_toLogin()
end

local function onJunhaiLoginBack(pack)
	NetCenter:removeMsgHandler(MsgType.JUNHAI_LOGIN_MAG, onJunhaiLoginBack)
	local msg = pack.msg
	CCLuaLog("---- onJunhaiLoginBack  begin"..msg.lgnjson)
	gamePlatform:loginNotifySDK(msg.lgnjson)
end

function LoginState:_toLogin()
    self:setTipText("登录服务器中...")
	CCLuaLog("---- LoginState:_toLogin  begin")
    local userInfo = gamePlatform:getUserInfo()
    if not userInfo then  --这时候还没平台用户信息  应该直接退出游戏了
		CCLuaLog("---- LoginState:_toLogin  not userInfo")
    else
        local isGuest = gamePlatform:isVisitor()
        if isGuest then
            isGuest = 0   --sdk过来的  全部是非游客  游客概念只在他们平台那边
        else
            isGuest = 0
        end

		local data = ""
		--CCLuaLog("wuwei authorizeCode "..AUTHORIZE_CODE)
		if AUTHORIZE_CODE then
			data = AUTHORIZE_CODE
		else
			data = "channel_id="..gamePlatform:getChannelId().."&game_id="..GAME_ID.."&uid="..userInfo.userId.."&session_id="..userInfo.sessionId;
        end
        CCLuaLog("---- LoginState:_toLogin  junhai"..data)
        local os = 0
	    if device.platform == "android" then
	        os = 1
	    elseif device.platform == "ios" then
	        os = 2
	    end

		NetCenter:send(MsgType.LOGIN_IN_MSG,PLATFORM_ID,ACCOUNT_ID,data,isGuest,os)  --SESSION_ID
		NetCenter:addMsgHandler(MsgType.LOGIN_IN_MSG,{self,self.onLogin},1,true)
        NetCenter:addMsgHandler(MsgType.SERVER_LIST_MSG, {self,self.onServerList},1,true)
		NetCenter:addMsgHandler(MsgType.JUNHAI_LOGIN_MAG,onJunhaiLoginBack,1,true)
        self:enableTouch(false)
    end
	CCLuaLog("---- LoginState:_toLogin  end")
end

function LoginState:onLogin(pack)
	local msg = pack.msg
	if msg.result == 0 then  --登录成功  成功不用返回的
		CCLuaLog("---- LoginState:onLogin  sucess")
	else  --登录失败
		CCLuaLog("---- LoginState:onLogin  fail")
		self:setTipText("登录服务器失败")
		NetCenter:removeMsgHandler(MsgType.SERVER_LIST_MSG, {self,self.onServerList})
		NetCenter:removeMsgHandler(MsgType.LOGIN_IN_MSG,{self,self.onLogin})
		local str = LangCfg:getErrorString(msg.result)
		if not str  then  --封号
			str = "未知错误："..msg.result
		end
		local btnList = { {text="重试",obj=self,callfun=function() self:changeState(StateMgr.LOGIN_SDK) end}}
		openErrorPanel(str,btnList)
	end

end

function LoginState:onServerList( pack )

	CCLuaLog("---- LoginState:onServerList begin")
    self:setTipText("成功登录服务器")
    LoadingControl:stopShow("onLogin")

	NetCenter:removeMsgHandler(MsgType.SERVER_LIST_MSG, {self,self.onServerList})
	NetCenter:removeMsgHandler(MsgType.LOGIN_IN_MSG,{self,self.onLogin})

	local msg = pack.msg
	self:changeState(StateMgr.SELECT_SERVER,msg.platformList)
	if ViewMgr:isOpen(Panel.ERROR_TIP_PANEL) then
    	ViewMgr:close(Panel.ERROR_TIP_PANEL)
    end
end

function LoginState:dispose()
	NetCenter:removeMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	NetCenter:removeMsgHandler(MsgType.SERVER_LIST_MSG, {self,self.onServerList})
	NetCenter:removeMsgHandler(MsgType.LOGIN_IN_MSG,{self,self.onLogin})
	ResMgr:unload("ui/login/login.pvr.ccz")
	StateBase.dispose(self)
end

return LoginState