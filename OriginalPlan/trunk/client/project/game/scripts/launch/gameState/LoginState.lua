--
-- Author: wdx
-- Date: 2014-06-03 10:06:47
--

--登录  账号  页面
-- 这里 有可能是 调用 平台的 登录sdk 进行登录
local LoginState = class("LoginState",StateBase)

local LoginContainer = game_require("launch.gameState.LoginContainer")

function LoginState:ctor(stateMgr)
	StateBase.ctor(self,stateMgr)
	self.clsType = StateMgr.LOGIN
end

function LoginState:init()

    self:initBg()
	self:initUI()
end

function LoginState:initUI(  )
	ResMgr:loadPvr("ui/login/login.pvr.ccz")

    self:addLogo()

    self.loginContainer = LoginContainer.new()
    self.loginContainer:retain()
    self.loginContainer:setPosition(display.cx,display.cy-50)
    self:addChild( self.loginContainer)

    self.loginContainer.loginBtn:addEventListener(Event.MOUSE_CLICK,{self,self._onLoginBtn})
    self.loginContainer.registerBtn:addEventListener(Event.MOUSE_CLICK,{self,self._openRegister})

end

function LoginState:show(isFirstLogin)
	StateBase.show(self)
	self:addNetErrorHandler()
	self:addNetFailHandler()
	--scheduler.performWithDelayGlobal(function() self:changeState(StateMgr.SELECT_SERVER) end ,2)
end

function LoginState:checkName(value)
    local len = string.utf8len(value);
    if(len < 3 or len > 50)then
        floatText("账号长度无效(3-50字符)",ccc3(255,0,0))
        return 1;
    end
    local tt =  value.find(value, "[^%w%u_]");
    if tt ~= nil then  --假如有不是_下横线的 标点符号
        floatText("账号包含非法字符，只能使用数字、字母或下划线",ccc3(255,0,0))
        return 2
    end
    return 0
end

function LoginState:_openRegister()
    if not self.registerCon then
        local RegisterContainer = game_require("launch.gameState.RegisterContainer")
        self.registerCon = RegisterContainer.new()
        self.registerCon:retain()
        self.registerCon:setPosition(display.cx,display.cy-50)
        self.registerCon.backBtn:addEventListener(Event.MOUSE_CLICK, {self,self._openLogin})
        self.registerCon.okBtn:addEventListener(Event.MOUSE_CLICK, {self,self._registerLogin})
    end
    if not self.registerCon:getParent() then
        self:addChild(self.registerCon)
    end
    self.loginContainer:removeFromParent()
end

function LoginState:_openLogin()
    self.registerCon:removeFromParent()
    if not self.loginContainer:getParent() then
        self:addChild(self.loginContainer)
    end
end

function LoginState:_onLoginBtn( )
    local name = self.loginContainer.nameText:getText()
    if self:checkName(name) ~= 0 then
        return
    end
    local pwd = self.loginContainer.passText:getText()
    if pwd == "" and device.platform ~= "windows" then
        floatText("请输入密码",ccc3(255,0,0))
        return
    end
    self.isRegister = false
    self:_login(name,pwd)
end

function LoginState:_registerLogin()
    local name = self.registerCon.nameText:getText()
    if self:checkName(name) ~= 0 then
        return
    end
    local pwd = self.registerCon.passText:getText()
    if pwd == "" then
        floatText("请输入密码",ccc3(255,0,0))
        return
    end
    if pwd ~= self.registerCon.passText2:getText() then
        floatText("输入密码不一致",ccc3(255,0,0))
        return
    end
    self.isRegister = true
    self:_login(name,pwd)
end

function LoginState:_login(name,pwd)
    if gamePlatform:getRemoteValue("serverClose") then  --服务器关闭
        self:tipExitGame(gamePlatform:getRemoteValue("serverClose"))
        return
    end
    self.useName = name
    self.pwd = pwd

    LoadingControl:show("LoginState.onConnect",true)
    if NetCenter:connect(SERVER_IP,SERVER_PORT) then  --连接服务器
		self:_toLogin()
	else
		NetCenter:addMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect},1)
	end
end

function LoginState:onConnect(  )
    LoadingControl:stopShow("LoginState.onConnect")
	NetCenter:removeMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	self:_toLogin()
end

local function onJunhaiLoginBack(pack)
    NetCenter:removeMsgHandler(MsgType.JUNHAI_LOGIN_MAG, {self,onJunhaiLoginBack})
    local msg = pack.msg
    gamePlatform:loginNotifySDK(msg.lgnjson)
end

function LoginState:_toLogin()
    local pwd = crypto.md5(self.pwd, false)
--    if PLATFORM_ID ~= 102 and device.platform == "windows" then
--        pwd = self.pwd
--    end

    ACCOUNT_ID = self.useName

    LoadingControl:show("LoginState.toLogin",true)
    local os = 0
    if device.platform == "android" then
        os = 1
    elseif device.platform == "ios" then
        os = 2
    end
    if self.isRegister then
        NetCenter:send(MsgType.REGISTER_MSG,PLATFORM_ID,ACCOUNT_ID,pwd,os)
    else
	    NetCenter:send(MsgType.LOGIN_IN_MSG,PLATFORM_ID,ACCOUNT_ID,pwd,0,os)
    end
	NetCenter:addMsgHandler(MsgType.JUNHAI_LOGIN_MAG,{self,onJunhaiLoginBack},1,true)

    NetCenter:addMsgHandler(MsgType.LOGIN_IN_MSG,{self,self.onLogin},1,true)
    NetCenter:addMsgHandler(MsgType.SERVER_LIST_MSG, {self,self.onServerList},1,true)
    NetCenter:addMsgHandler(MsgType.REGISTER_MSG,{self,self.onLogin},1,true)
end

function LoginState:onLogin(pack)
    LoadingControl:stopShow("LoginState.toLogin")
	local msg = pack.msg
	if msg.result == 0 then  --登录成功  成功不用返回的
		CCLuaLog("---- LoginState:onLogin  sucess")
	else  --登录失败
		CCLuaLog("---- LoginState:onLogin  fail")
		NetCenter:removeMsgHandler(MsgType.SERVER_LIST_MSG, {self,self.onServerList})
		NetCenter:removeMsgHandler(MsgType.LOGIN_IN_MSG,{self,self.onLogin})
        NetCenter:removeMsgHandler(MsgType.REGISTER_MSG,{self,self.onLogin})
		local str = LangCfg:getErrorString(msg.result)
		if not str  then  --封号
			str = "未知错误："..msg.result
		end
		openErrorPanel(str)
	end
end

function LoginState:onServerList( pack )
    LoadingControl:stopShow("LoginState.toLogin",true)
	CCUserDefault:sharedUserDefault():setStringForKey("gameUserName",ACCOUNT_ID );
	CCUserDefault:sharedUserDefault():flush()
	local msg = pack.msg

	self:changeState(StateMgr.SELECT_SERVER,msg.platformList)
end

function LoginState:dispose()
	NetCenter:removeMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	NetCenter:removeMsgHandler(MsgType.SERVER_LIST_MSG, {self,self.onServerList})
	NetCenter:removeMsgHandler(MsgType.LOGIN_IN_MSG,{self,self.onLogin})
    NetCenter:removeMsgHandler(MsgType.REGISTER_MSG,{self,self.onLogin})
    self.loginContainer:dispose()
    if self.registerCon then
        self.registerCon:dispose()
    end
	StateBase.dispose(self)
    ResMgr:unload("ui/login/login.pvr.ccz")
end

return LoginState