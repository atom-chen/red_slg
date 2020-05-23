--
-- Author: wdx
-- Date: 2014-06-03 11:00:59
--

StateBase = require("launch.gameState.StateBase")
LogoState = require("launch.gameState.LogoState")
LoginState = require("launch.gameState.LoginState")
SelectServerState = require("launch.gameState.SelectServerState")
UpdateState = require("launch.gameState.UpdateState")


local StateMgr = class("StateMgr")

function StateMgr:ctor()
	self.stateClass = { [StateBase.LOGO] = LogoState, [StateBase.LOGIN] = LoginState, [StateBase.UPDATE] = UpdateState,
						 [StateBase.SELECT_SERVER] = SelectServerState }

end

function StateMgr:start(launch)
	self.gameLaunch = launch
	self:changeState(StateBase.LOGO)
end

function StateMgr:changeState( state,... )
	print("改变登陆状态:"..state)
	if state == StateBase.GAME then  --进入游戏
		self.gameLaunch:enterGame(self.roleInfo)
		if self.curState then
			self.curState:dispose()
		end
		return
	end
	local newState = self:newState(state)
	if self.curState then
		self.curState:dispose()
	end
	self.curState = newState
	self.gameLaunch.stage:addChild(newState)
	newState:show(self)
end

function StateMgr:saveRoleInfo( rInfo )
	self.roleInfo = rInfo
end

function StateMgr:newState( state )
	local cls = self.stateClass[state]
	local newState = cls.new()
	newState:init()
	return newState
end

return StateMgr.new()