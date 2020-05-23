--
-- Author: wdx
-- Date: 2014-06-03 09:48:30
--

--公司logo页面

local LogoState = class("LogoState",StateBase)

function LogoState:init()
	-- body
end

function LogoState:show(mgr)
	StateBase.show(self,mgr)

	local logo = display.newXSprite("ui/login/logo.w")
	logo:setPosition( display.cx,display.cy )
	
	self:addChild(logo)

	--print(logo:getContentSize().width,logo:getContentSize().height)

	--ResourceMgr:instance():dumpResource();

	scheduler.performWithDelayGlobal(handler(self,self.logoEnd),1)
end

function LogoState:logoEnd( )
	--self:changeState(StateBase.LOGIN)
	self:changeState(StateBase.GAME)
end

function LogoState:dispose()
	self:removeSelf(true)
end

return LogoState


