--
-- Author: wdx
-- Date: 2014-06-03 11:00:59
--

local StateMgr = class("StateMgr")

StateMgr.LOGIN_SDK = "loginSDK"
StateMgr.LOGIN = "login"
StateMgr.SELECT_SERVER = "selectServer"
StateMgr.SERVER_LIST = "serverList"
StateMgr.GAME = "game"
StateMgr.CHANGE_ACCOUNT = "changeAccount"



function StateMgr:ctor(isFirstLogin)
	self.isFirstLogin = isFirstLogin
	StateMgr.FIRST_STATE = StateMgr.LOGIN
	if (device.platform == "android" or device.platform == "ios") then
		StateBase = game_require("launch.SdkGameState.StateBase")
		if gamePlatform:support(PlatformSupport.LOGIN) then  --平台有自己的 登录
			LoginSDKState = game_require("launch.SdkGameState.LoginSDKState")
			LoginState = game_require("launch.SdkGameState.LoginState")
			StateMgr.FIRST_STATE = StateMgr.LOGIN_SDK
		else
			LoginState = game_require("launch.gameState.LoginState")
		end
		if gamePlatform:support(PlatformSupport.CHANGE_SERVER) then  --平台有自己的 选服
			SelectServerState = game_require("launch.SdkGameState.SelectServerState")
		else
			SelectServerState = game_require("launch.gameState.SelectServerState")
			ServerListState = game_require("launch.gameState.ServerListState")
		end
		ChangeAccount = game_require("launch.SdkGameState.ChangeAccount")
	else
		StateBase = game_require("launch.gameState.StateBase")
		LoginState = game_require("launch.gameState.LoginState")
		SelectServerState = game_require("launch.gameState.SelectServerState")
		ServerListState = game_require("launch.gameState.ServerListState")
	end
	self.stateClass = { [StateMgr.LOGIN] = LoginState,[StateMgr.LOGIN_SDK] = LoginSDKState,
						[StateMgr.CHANGE_ACCOUNT] = ChangeAccount,
						 [StateMgr.SELECT_SERVER] = SelectServerState,
						 [StateMgr.SERVER_LIST] = ServerListState}

end

function StateMgr:start(launch)
	self.gameLaunch = launch

	if LOCAL_RUN then
		self:changeState(StateMgr.GAME)
	else
		self:changeState(StateMgr.FIRST_STATE,self.isFirstLogin)
	end

	scheduler.performWithDelayGlobal(handler(self,self.playMusic),0.01)
end

function StateMgr:playMusic()
    --AudioMgr:playGround(AudioConst.BACK_GROUND_ID)
end

function StateMgr:changeState( state,... )
	LoadingControl:stopAll()
	if state == StateMgr.GAME then  --进入游戏
		if self.curState then
			self.curState:dispose()
			self.curState = nil
		end
		self.gameLaunch:enterGame()
		return
	end
	local newState = self:newState(state)
	if self.curState then
		self.curState:dispose()
	end
	self.curState = newState
	self.gameLaunch.mainScene:addChild(newState)
	newState:show(...)
end

-- function StateMgr:saveRoleInfo( rInfo )
-- 	self.roleInfo = rInfo
-- end

function StateMgr:newState( state )
	local cls = self.stateClass[state]
	local newState = cls.new(self)
	newState:init()
	return newState
end

function StateMgr:dispose()
	if self.curState then
		self.curState:dispose()
	end
end

return StateMgr