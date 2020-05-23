--
-- Author: wdx
-- Date: 2014-06-03 09:57:14
--

local StateBase = class("StateBase",function() return display.newNode() end)

function StateBase:ctor(stateMgr)
	self.touchLayer = TouchBase.new(-1,true,false)
	self.touchLayer:setContentSize(CCSize(display.width,display.height))
	self:addChild(self.touchLayer)
	self:retain()
	self.stateMgr = stateMgr
end

function StateBase:initBg()
	local res = "pic/init_bg.w"
	local bg = display.newXSprite(res)
    -- bg:setImageSize(display.width,display.height)
	bg:setPosition( display.cx,display.cy )
	self:addChild(bg)
end

function StateBase:addLogo()
	local isSupport =gamePlatform:support(PlatformSupport.REMOVE_GAMELOGO)
	if not isSupport then
		local gameLogo = display.newXSprite("#login_logo.png")
		gameLogo:setAnchorPoint(ccp(0.5,1))
		gameLogo:setPosition(display.cx,display.height-50)
		self:addChild(gameLogo)
	end

end

function StateBase:init()

end

function StateBase:show()

end

function StateBase:setTipText(str)
	if self.text == nil then
		self.text = ui.newTTFLabel({text=str,size=22,color=ccc3(255,0,0)})
    	self:addChild(self.text)
    	self.text:setPosition(display.cx,50)
	else
		self.text:setString(str)
	end
end

function StateBase:addAccountBtn()
CCLuaLog("---- StateBase:addAccountBtn  begin");
	self.accountBtn = UIButton.new({"#login_qhan.png"})
	self.accountBtn:setText("",29,"",ccc3(255,243,218),nil,nil,nil,nil,1)
	self.accountBtn:setScale(0.9)
	self:addChild(self.accountBtn)
	self.accountBtn:setPosition(display.width-15,display.height-15)
	self.accountBtn:setAnchorPoint(ccp(1,1))
end

function StateBase:addBindtBtn()
	self.bindBtn = UIButton.new({"#login_qhan.png"})
	self.bindBtn:setText("   绑定账号",29,"",ccc3(255,243,218),nil,nil,nil,nil,1)
	self.bindBtn:setScale(0.8)
	self:addChild(self.bindBtn)
	self.bindBtn:setPosition(display.width-10,display.height-65)
	self.bindBtn:setAnchorPoint(ccp(1,1))
end

function StateBase:addMouseEvent()
	if self.accountBtn then
		self.accountBtn:addEventListener(Event.MOUSE_CLICK,{self,self._onAccountBtn})
	end
	if self.bindBtn then
		self.bindBtn:addEventListener(Event.MOUSE_CLICK,{self,self._onBindBtn})
	end
end

function StateBase:removeMouseEvent()
	if self.accountBtn then
		self.accountBtn:removeEventListener(Event.MOUSE_CLICK,{self,self._onAccountBtn})
	end
	if self.bindBtn then
		self.bindBtn:removeEventListener(Event.MOUSE_CLICK,{self,self._onBindBtn})
	end
end

--切换账号
function StateBase:_onAccountBtn()
	CCLuaLog("---- StateBase:_onAccountBtn  begin");
	-- self:changeState(StateMgr.CHANGE_ACCOUNT)
	gamePlatform:changeAccount()
end

--绑定账号
function StateBase:_onBindBtn()
	gamePlatform:bindUser()
	if not self.bindUserTimer then
		self.bindUserTimer = scheduler.scheduleGlobal(function()
				if not gamePlatform:isVisitor() then
					if self.bindBtn then
						self.bindBtn:dispose()
						self.bindBtn = nil
					end
					scheduler.unscheduleGlobal(self.bindUserTimer)
					self.bindUserTimer = nil
				end
			end, 1)
	end
end

function StateBase:addNetErrorHandler()
	NetCenter:addMsgHandler(NetCenter.DISCONNECT,{self,self.onDisConnect})
end

function StateBase:addNetFailHandler()
	NetCenter:addMsgHandler(NetCenter.CONNECT_FAIL,{self,self.onConnectFail})
end

--中途断开连接了 直接返回
function StateBase:onDisConnect()
	local btnList = { {text="确定",obj=self,callfun=self._onCancel}}
	openErrorPanel("网络异常，请重新登录",btnList)
end

--连接不了  尝试重连 挥着返回
function StateBase:onConnectFail()
	--scheduler.performWithDelayGlobal(function() self:changeState(StateMgr.SELECT_SERVER) end ,1)
	-- self:enableTouch(true)
	local btnList = { {text="重试",obj=self,callfun=self._onReConnect}, {text="取消",obj=self,callfun=self._onCancel}}
	openErrorPanel("网络异常，请确保在稳定网络下进行游戏",btnList)
end

--取消返回 登录界面
function StateBase:_onCancel()
	if self.clsType ~= StateMgr.FIRST_STATE then
		self:changeState(StateMgr.FIRST_STATE)
	else
		LoadingControl:stopAll()
		self:enableTouch(true)
	end
end

--重连
function StateBase:_onReConnect()
	NetCenter:_onReConnect()
end


function StateBase:enableTouch(flag)
	self.touchLayer:touchEnabled(not flag)
end

function StateBase:changeState( state,... )
	self.stateMgr:changeState( state,...)
end

function StateBase:tipExitGame(str)
	local btnList = { {text="确定",obj=self,callfun=self.exitGame}}
	openErrorPanel(str,btnList)
end

function StateBase:exitGame()
	CCDirector:sharedDirector():endToLua()   --退出游戏
end

function StateBase:dispose()
	if self.accountBtn then
		self.accountBtn:dispose()
		self.accountBtn = nil
	end
	if self.bindBtn then
		self.bindBtn:dispose()
		self.bindBtn = nil
	end
	if self.bindUserTimer then
		scheduler.unscheduleGlobal(self.bindUserTimer)
		self.bindUserTimer = nil
	end
	NetCenter:removeMsgHandler(NetCenter.DISCONNECT,{self,self.onDisConnect})
	NetCenter:removeMsgHandler(NetCenter.CONNECT_FAIL,{self,self.onConnectFail})
	self:removeSelf(true)
	self.touchLayer:dispose()
	self:release()
end

return StateBase