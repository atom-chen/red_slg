--
-- Author: wdx
-- Date: 2014-06-03 10:06:47
--

--登录  账号  页面
-- 这里 有可能是 调用 平台的 登录sdk 进行登录
local LoginSDKState = class("LoginSDKState",StateBase)

function LoginSDKState:ctor(stateMgr)
	StateBase.ctor(self,stateMgr)
	self.clsType = StateMgr.LOGIN_SDK
end

function LoginSDKState:init(openLogin)
    ACCOUNT_ID = ""  --账号id 初始化为空

    self:initBg()
    -- self:setTipText("平台账号登录中...")

    self:addLogo()

    self.okBtn = UIButton.new({"#com_btn_2.png"})
    self.okBtn:setAnchorPoint(ccp(0.5,0))
    self.okBtn:setPosition(display.cx,40)
    self.okBtn:setText("账号登录",30,"",ccc3(255,243,218),nil,nil,nil,nil,1)
    self.okBtn:addEventListener(Event.MOUSE_CLICK,{self,self._onLoginBtn})

    gamePlatform:addEventListener(PlatformEvent.LOGIN_END, {self,self._onLoginEnd})

    scheduler.performWithDelayGlobal(function() 
        if self.okBtn then
           self:addChild(self.okBtn) 
        end
     end, 1)
end

function LoginSDKState:show(isFirstLogin)
    if isFirstLogin then
        gamePlatform:platformLogin()
    else
        scheduler.performWithDelayGlobal(function()
            if self.okBtn then
                local userInfo = gamePlatform:getUserInfo()
                if userInfo then
                    if not self._timeId then
                        self._timeId =scheduler.performWithDelayGlobal(function() 
                            self._timeId = nil
                            self:changeState(StateMgr.LOGIN) end, 0.01)
                    end
                end
            end
        end, 0.5)
    end
end

function LoginSDKState:_onLoginBtn()
    gamePlatform:addEventListener(PlatformEvent.LOGIN_END, {self,self._onLoginEnd})
    gamePlatform:platformLogin()
end

function LoginSDKState:_onLoginEnd(event)
	CCLuaLog("LoginSDKState:_onLoginEnd  000000");
	local status = event.status
    if status == "ok" then  --登录成功
		CCLuaLog("LoginSDKState:_onLoginEnd  111111111111");
        gamePlatform:removeEventListener(PlatformEvent.LOGIN_END, {self,self._onLoginEnd})
        if not self._timeId then
            self._timeId =scheduler.performWithDelayGlobal(function()
                self._timeId = nil
             self:changeState(StateMgr.LOGIN) end, 0.01)
        end
    else
		CCLuaLog("LoginSDKState:_onLoginEnd  22222")
        if status == "error" then  --登录失败
            gamePlatform:removeEventListener(PlatformEvent.LOGIN_END, {self,self._onLoginEnd})
            -- self:setTipText("平台账号登录错误")
            local str 
            if event.errorMsg and event.errorMsg ~= "" then
                str = event.errorMsg
            else
                str = "平台账号登录失败，请尝试重新登录"
            end
            openTipPanel(str)    
        end        
    end
end

function LoginSDKState:dispose()
    if self._timeId then
        scheduler.unscheduleGlobal(self._timeId)
        self._timeId = nil
    end
    self.okBtn:dispose()
    self.okBtn = nil
    gamePlatform:removeEventListener(PlatformEvent.LOGIN_END, {self,self._onLoginEnd})
	StateBase.dispose(self) 
end

return LoginSDKState