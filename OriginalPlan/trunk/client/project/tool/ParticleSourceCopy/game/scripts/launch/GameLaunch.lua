--
-- Author:wdx
-- Date: 2014-06-03 11:46:54
--
require("gameSettings")
require("framework.init")
require("framework.shortcodes")
--require("framework.cc.init")

StateMgr = require("launch.gameState.StateMgr")
NetCenter = require("launch.net.NetCenter")
Event = require("common.Event")
StatSender = require("launch.StatSender")

AudioMgr = require("launch.AudioMgr")

ResMgr = ResourceMgr:instance()


local GameLaunch = class("GameLaunch")
function GameLaunch:ctor()

end

function GameLaunch:startup()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")



    --初始化scene
    self.stage = display.newScene("MainScene")
    display.replaceScene(self.stage, "fade", 0.6, display.COLOR_WHITE)

    NetCenter:init()
    --登陆流程状态管理

    StateMgr:start(self)
end

--正式进入游戏
function GameLaunch:enterGame(roleInfo)
	local GameCls = require("launch.GameApp")
	local gameApp = GameCls.new()
	gameApp:startup(self.stage,roleInfo)
end

return GameLaunch.new()
