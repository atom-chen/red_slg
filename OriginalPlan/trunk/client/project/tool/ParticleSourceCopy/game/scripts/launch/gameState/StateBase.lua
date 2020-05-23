--
-- Author: wdx
-- Date: 2014-06-03 09:57:14
--

local StateBase = class("StateBase",function() return display.newNode() end)
StateBase.LOGO = "logo"
StateBase.LOGIN = "login"
StateBase.UPDATE = "update"
StateBase.SELECT_SERVER = "selectServer"
StateBase.GAME = "game"

function StateBase:init()
	-- body
end

function StateBase:show(stateMgr)
	self.stateMgr = stateMgr

end

function StateBase:changeState( state,... )
	self.stateMgr:changeState( state,...)
end

function StateBase:dispose()
	self:removeSelf(true)
end

return StateBase