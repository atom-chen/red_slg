--
-- Author: wdx
-- Date: 2015-01-27 21:46:51
--

--切换账号
local ChangeAccount = class("ChangeAccount",StateBase)

function ChangeAccount:ctor(stateMgr)
	StateBase.ctor(self,stateMgr)
	self.clsType = StateMgr.CHANGE_ACCOUNT
end

function ChangeAccount:init()
	CCLuaLog("---- ChangeAccount:init  begin");
    self:initBg()

    self:addLogo()

    self.okBtn = UIButton.new({"#com_btn_2.png"})
    self.okBtn:setAnchorPoint(ccp(0.5,0))
    self.okBtn:setPosition(display.cx,40)
    self.okBtn:setText("账号登录",30,"",ccc3(255,243,218),nil,nil,nil,nil,1)
    self.okBtn:addEventListener(Event.MOUSE_CLICK,{self,self._onLoginBtn})

    gamePlatform:addEventListener(PlatformEvent.LOGIN_END, {self,self._onLoginEnd})
	CCLuaLog("---- ChangeAccount:init  end");
    gamePlatform:changeAccount()  --切换账户
end

function ChangeAccount:_onLoginBtn( ... )
    gamePlatform:addEventListener(PlatformEvent.LOGIN_END, {self,self._onLoginEnd})
    gamePlatform:changeAccount()  --切换账户
end

function ChangeAccount:_onLoginEnd(event)
    gamePlatform:removeEventListener(PlatformEvent.LOGIN_END, {self,self._onLoginEnd})
	CCLuaLog("ChangeAccount:_onLoginEnd  000000");
	local status = event.status
    if status == "ok" then  --登录成功
		CCLuaLog("ChangeAccount:_onLoginEnd  11111");
        self:changeState(StateMgr.LOGIN)
    else
		CCLuaLog("ChangeAccount:_onLoginEnd  222222");
        openErrorPanel("切换账号失败")
    end
end

function ChangeAccount:dispose()
    self.okBtn:dispose()
    gamePlatform:removeEventListener(PlatformEvent.LOGIN_END, {self,self._onLoginEnd})
	StateBase.dispose(self)
end

return ChangeAccount