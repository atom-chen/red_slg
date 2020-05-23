--
-- Author: wdx
-- Date: 2014-06-03 10:06:47
--

--登陆  账号  页面
-- 这里 有可能是 调用 平台的 登陆sdk 进行登陆
local LoginState = class("LoginState",StateBase)

TouchBase = require("uiLib.container.TouchBase")
UIInfo = require("uiLib.container.UIInfo")
UIAttachText = require("uiLib.container.UIAttachText")
UIButton = require("uiLib.container.UIButton")


function LoginState:init()
	self.LOGIN_IN_MSG = 2001    --登陆 服务器


	local bg = display.newXSprite("ui/login/loginBg.w")
	bg:setPosition( display.cx,display.cy )
	self:addChild(bg)
	
	self:initUI()
end

function LoginState:initUI(  )
	ResMgr:loadPvr("ui/login/login")
	
	self.content = display.newNode()
	self:addChild(self.content)
	local textbg = display.newXSprite("#login_textBg.png")
	textbg:setAnchorPoint(ccp(0,0))
	self.content:addChild(textbg)

	self.content:setPosition(display.cx,display.cy)
	self.content:setAnchorPoint(ccp(0.5,0.5))
	self.content:setContentSize(textbg:getContentSize())

	local params = {}
		params.text = "账号："
	    params.size = 30
		params.color = display.COLOR_WHITE
	    params.align = ui.TEXT_ALIGN_LEFT
	    params.valign = ui.TEXT_VALIGN_TOP
	   	params.dimensions = CCSize(100,50)
	   	params.outlineColor = ccc3(0,0,0)

	local text = ui.newTTFLabel(params)
	text:setPosition(25,180);
	text:setAnchorPoint(ccp(0,0.5));
	self.content:addChild(text);   --文本

	params.text = "密码："
	text = ui.newTTFLabel(params)
	text:setPosition(25,100);
	text:setAnchorPoint(ccp(0,0.5));
	self.content:addChild(text);   --文本

	self.nameText =  ui.newEditBox({image = "#login_inputBg.png", size=CCSize(230,50)}) -- 
	self.nameText:setFont("",25);
	self.nameText:setFontColor(ccc3(0,0,0));
	self.nameText:setPosition(100,164)
	self.nameText:setAnchorPoint(ccp(0,0))
	self.content:addChild(self.nameText)
	self.nameText:setText(ACCOUNT_ID)

	self.passText =  ui.newEditBox({image = "#login_inputBg.png", size=CCSize(230,50)}) -- 
	self.passText:setFont("",25);
	self.passText:setFontColor(ccc3(0,0,0));
	self.passText:setPosition(100,82)
	self.passText:setAnchorPoint(ccp(0,0))
	self.content:addChild(self.passText)

	self.loginBtn = UIButton.new({"#loginBtn.png"})
	self.loginBtn:setText("登陆",25,"",ccc3(0,0,0))
	self.loginBtn:setPosition(25,20)
	self.content:addChild(self.loginBtn)
	self.loginBtn:addEventListener(Event.MOUSE_CLICK,{self,self._onLoginBtn})

	self.registerBtn = UIButton.new({"#loginBtn.png"})
	self.registerBtn:setText("注册",25,"",ccc3(0,0,0))  --fontSize, fontName, fontColor, align, valign
	self.registerBtn:setPosition(188,20)
	self.content:addChild(self.registerBtn)
end


function LoginState:show(mgr)
	StateBase.show(self,mgr)
	NetCenter:addMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	NetCenter:addMsgHandler(NetCenter.CONNECT_FAIL,{self,self.onConnectFail})

	--scheduler.performWithDelayGlobal(function() self:changeState(StateBase.SELECT_SERVER) end ,2)
end

function LoginState:_onLoginBtn( )
	--print("我 ")
	
	NetCenter:connect(SERVER_IP,SERVER_PORT)  --连接服务器
end

function LoginState:onConnectFail()
	NetCenter:removeMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
	NetCenter:removeMsgHandler(NetCenter.CONNECT_FAIL,{self,self.onConnectFail})
	--scheduler.performWithDelayGlobal(function() self:changeState(StateBase.SELECT_SERVER) end ,1)
end

function LoginState:onConnect(  )
	NetCenter:removeMsgHandler(NetCenter.CONNECT_FAIL,{self,self.onConnectFail})
	NetCenter:removeMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})

	local id = self.nameText:getText()
	local password = self.passText:getText()
	self:_toLogin(id,password)
end



function LoginState:_toLogin( id,password )

	ACCOUNT_ID = id

	NetCenter:send(self.LOGIN_IN_MSG,PLATFORM_ID,id,password)  --SESSION_ID
    NetCenter:addMsgHandler(self.LOGIN_IN_MSG,{self,self.onLogin},1,true)
end

function LoginState:onLogin(pack)
	local msg = pack.msg
	NetCenter:removeMsgHandler(self.LOGIN_IN_MSG,{self,self.onLogin})
	if msg.loginResult == 0 then  --登陆成功
		self:changeState(StateBase.SELECT_SERVER)
	else  --登陆失败
		
	end
end


function LoginState:dispose()
	self.loginBtn:dispose()
	self.registerBtn:dispose()
	self.loginBtn:removeEventListener(Event.MOUSE_CLICK,{self,self._onLoginBtn})
	self:removeSelf(true)
	ResMgr:unload("ui/login/login")
end

return LoginState