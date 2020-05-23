--
-- Author:wdx
-- Date: 2014-06-03 11:46:54
--

game_require("launch.encrypt")

game_require("common.CommonInit")

StateMgr = game_require("launch.StateMgr")
NetCenter = game_require("launch.net.NetCenter")
Event = game_require("common.Event")
NotifyCenter = game_require("launch.NotifyCenter")

ConfigMgr = game_require("config.ConfigMgr")

AudioMgr = game_require("launch.AudioMgr")

util = game_require("model.utils.util")
ResMgr = ResMgr or ResourceMgr:instance()
ResMgr:loadPvr("ui/common.pvr.ccz")


ResCfg = game_require("config.ResCfg")
LangCfg = game_require("config.LangCfg")
uihelper = game_require("uiLib.uihelper")
ModelMgr = game_require("model.ModelMgr")
ViewMgr = game_require("view.ViewMgr")

--配置层、数据层、显示组件库

if StatSender == nil and device.platform == "windows" then
    StatSender = require("update.StatSender")
    StatSender:init(BUG_URL)
end
if device.platform ~= "android" and device.platform ~= "ios" then
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    if CCFileUtils:sharedFileUtils():isFileExist("res/anim/hero/ApocalypseTank.mpng") then
        AnimationMgr:setSuff(".mpng")
    end
end


XUtil:setAnimationType(1)

-- audio.setBackgroundMusicVolume(0.1)
--没有游戏平台的  一般是pc
if not gamePlatform then
    gamePlatform = {}

    PlatformSupport = {}
    PlatformEvent = {}
    mt = {__index = function() return "platformEvent" end}
    setmetatable(PlatformEvent, mt)

    local mt = {__index = function() print("no platform sdk") return function() end end}
    setmetatable(gamePlatform, mt)
end

local GameLaunch = {}

ParticleEftCfg = game_require("config.particle.ParticleEftCfg")
ParticleEftCfg:init()

function GameLaunch:startup()

    LangCfg:init()
    ResCfg:init()
	ConfigMgr:init()
	AudioMgr:init()

    --初始化scene
    self.mainScene = display.newScene("MainScene")
    display.replaceScene(self.mainScene)

    NetCenter:init()
    NotifyCenter:init()

    --初始化配置管理器以及资源管理器
    uihelper:init()
    ViewMgr:init(self.mainScene)
    ModelMgr:init()
    --登录流程状态管理

    self.stateMgr = StateMgr.new(true)
    self.stateMgr:start(self)


    self:addPlatformHanlder(self.mainScene)  --添加平台处理相关

    -- StatSender:sendBug("nbugggggggggggggg w  cao   f.............")
    -- local size = XUtil:getTextSize("账  号",26,ui.DEFAULT_TTF_FONT)
    -- CCLuaLog("  text 文本 大小 :"..size.width..","..size.height)
end

--平台处理相关
function GameLaunch:addPlatformHanlder( scene )

    if device.platform == "android" then
        scene:setKeypadEnabled(true)
        scene:addKeypadEventListener(function(event)
                if event == "back" then
                    toTipExitGame()
                end
            end)
        -- CCLuaLog("GameLaunch:addPlatformHanlder。。。。end")
    end
end

--全局函数  提示退出游戏
function toTipExitGame()
    if device.platform == "android" and not gamePlatform:support(PlatformSupport.EXIT_GAME) then    --安卓平台的退出
        local javaClassName = GameJavaCallCalss
         local javaMethodName = "showAlertDialog"
         local javaParams = {
             "提示",
             "是否退出游戏？",
             "确定",
             "取消",
             function(event)
                 if event == "ok" then
                     toExitGame(true)   --退出游戏
                 end
             end
         }
         local javaMethodSig = "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V"
         luaj.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    elseif device.platform == "ios" then
        local btnList = {"确定","取消"}
        device.showAlert("提示","是否退出游戏？",btnList,function(event)
                if event.buttonIndex  == 1 then
                    toExitGame(true) --退出游戏
                end
            end)
    else
        toExitGame(true)   --退出游戏
    end
end


function _exitGame(sendToServer)
    if sendToServer and NetCenter:isConnected() and NetCenter._reconnectEnable then
        scheduler.performWithDelayGlobal(function() CCDirector:sharedDirector():endToLua() end,1)
        NetCenter:send(MsgType.TO_EXIT_GAME)
    else
        CCDirector:sharedDirector():endToLua()   --退出游戏
    end
end

--全局函数  退出游戏
function toExitGame(sendToServer)
	if gamePlatform:support(PlatformSupport.EXIT_GAME) then
		gamePlatform:exitGame(sendToServer)
	else
		_exitGame(sendToServer)
	end
end


--正式进入游戏
function GameLaunch:enterGame(roleInfo)
    if self.stateMgr then
        self.stateMgr:dispose()
        self.stateMgr = nil
    end

    if nil == self._gameApp then
       local GameApp = game_require("launch.GameApp")
       self._gameApp = GameApp.new()
    end
    self._gameApp:startup(self.mainScene)
end


function GameLaunch:relaunchGame()
    -- body
    if NetCenter:isConnected() then
        NetCenter:disconnect()
    end
    NetCenter:reset()
    if self.stateMgr then
        self.stateMgr:dispose()
    end
    self.stateMgr = StateMgr.new(false)
    self.stateMgr:start(self)

    if self._gameApp then
        self._gameApp:resetGame()
    end
    ViewMgr:closeAllPanels()
    NotifyCenter:dispatchEvent({name = Notify.START_RELAUNCH})
	gamePlatform:gameLogoutFinish()
end


return GameLaunch
