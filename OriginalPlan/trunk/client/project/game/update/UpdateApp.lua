
UpdateApp = {}
require("update.UpdateConst")

StatSender = require("update.StatSender")
GameCfg = require("update.GameCfg")

function UpdateApp:launch()
    CCLuaLog("UpdateApp:launch..111")
    GameCfg:init()

    local bugUrl = GameCfg:getValue("bughttp")
    StatSender:init(bugUrl)

    self.helper = require("update.UpdateHelper")
    self.helper:initSysInfo()

    self:initGamePlatform()  --初始化 游戏平台
    self.storePath = self.helper:getStorePath()

    self:_checkNewApk(self.storePath)

    self:initSearchPath(self.storePath)

    self:_checkLowApp()  --检测是否是low版本的  20m
    self:initScene()
    -- self:enterGame()
end

function UpdateApp:_checkLowApp()
    if self.helper:exists("res/ui/biaoqing.mpng") or GameCfg:getValue("lowApp") == "1" then  --使用png打包的
        if device.platform == "android" then
            ui.DEFAULT_TTF_FONT = ""  --安卓上没字库的时候 去掉字库
        end
        local ResMgrCls = class("ResMgr",function() return ResourceMgr:instance() end) --资源加载套多一层
        ResMgr = ResMgrCls.new()
        ResMgr.loadPvrEx = ResMgr.loadPvr
        function ResMgr:loadPvr(path)
            path = string.gsub(path,"%.pvr.ccz","%.mpng")  --使用mpng结尾
            return ResMgr:loadPvrEx(path)
        end
        ResMgr.unloadEx = ResMgr.unload
        function ResMgr:unload(path)
            path = string.gsub(path,"%.pvr.ccz","%.mpng")  --使用mpng结尾
            return ResMgr:unloadEx(path)
        end
        ResMgr.loadImageEx = ResMgr.loadImage
        function ResMgr:loadImage(path)
            path = string.gsub(path,"%.pvr.ccz","%.mpng")
            return ResMgr:loadImageEx(path)
        end
        AnimationMgr:setSuff(".mpng")
        device.isLowApp = true
    else
        ResMgr = ResourceMgr:instance()
    end
end

--初始化游戏运营平台
function UpdateApp:initGamePlatform()
    -- gamePlatform  全局变量
    gamePlatform = require("update.PlatformSDK")  -- 加载平台相关
    gamePlatform:init() --平台初始化
end

--检测是不是新包
function UpdateApp:_checkNewApk(storePath)
    CCLuaLog("storePath:"..(storePath or "none"))
    if storePath then
        if self:_isNewInstall(storePath) then
            CCLuaLog("isNewInstall true")
            self.helper:emptyFile(storePath)
            local uniquindex = CMJYXConfig:GetInst():getStringForKey("uniquindex")
            self.helper:writeFile(storePath.."/uniquindex.txt", uniquindex)
        end
    end
end

function UpdateApp:_isNewInstall(storePath)
    CCLuaLog("isNewInstall")
    local uniquindexPath = storePath.."/uniquindex.txt"
    local curUniquindex
    if self.helper:exists(uniquindexPath) then
        curUniquindex = self.helper:readFile(uniquindexPath)
    end
    local uniquindex = CMJYXConfig:GetInst():getStringForKey("uniquindex")
    if not curUniquindex or curUniquindex ~= uniquindex then
        return true
    end
    return false
end

--初始化路径
function UpdateApp:initSearchPath(storePath)
    if storePath then
        local localPath = storePath    --"/"..storePath
        CCFileUtils:sharedFileUtils():addSearchPath(localPath)
        CCFileUtils:sharedFileUtils():addSearchPath(localPath.."res/")
        CCFileUtils:sharedFileUtils():addSearchPath("res/")
        -- print(CCFileUtils:sharedFileUtils():getSearchRootPath())
        return true
    else
        CCFileUtils:sharedFileUtils():addSearchPath("res/")
        StatSender:sendBug("z no storePath")
        return false
    end
end

function UpdateApp:initScene()
    self.scene = require("update.UpdateScene")
    self.scene:init()
    self.scene:showLogo(function() self:platformLaunch() end)
end

--启动平台
function UpdateApp:platformLaunch()
    self.scene:initUI()
    local verCheck = require("update.VerCheck")
    local localVerInfo = verCheck:getLocalVerInfo()
    self.scene:setVersionText(localVerInfo.version)

    device.version = localVerInfo.version  --记录下本地版本号

    self.scene:setTipText("启动平台...")
    gamePlatform:addEventListener(PlatformEvent.LUANCH_END,{self,self.platformLaunchEnd})
    gamePlatform:platformLaunch()
end

--平台启动结束
function UpdateApp:platformLaunchEnd(event)
    gamePlatform:removeEventListener(PlatformEvent.LUANCH_END,{self,self.platformLaunchEnd})
    self.scene:setBg()
    local status = event.status
    if status == "ok" then --平台启动成功
        self.scene:setTipText("平台启动完成...")
        --开始检测更新
        scheduler.performWithDelayGlobal(function() self:startUpdate() end, 0.001)

    elseif status == "verError" then --版本错误  提示信息用戶並退出遊戲
        local str = "版本信息错误，请重新启动游戏进行尝试。"
        self.scene:setTipText(str)
        self.helper:tipToExitGame(str)

    elseif status == "exit" then  --直接退出游戏
        self:exit()   --退出游戏
    else  --平台启动出错
        local str
        if event.errorMsg and event.errorMsg ~= "" then
            str = event.errorMsg
        else
            str = "平台启动出错："..tostring(status).." "..tostring(event.eroorCode)
        end
        self.scene:setTipText(str)
        self.helper:tipToExitGame(str)

        StatSender:sendBug("z platformLaunch  error"..str)
    end
end

--正式开始检测更新
function UpdateApp:startUpdate()
    self.scene:setTipText("获取当前游戏版本号...")
    self.scene:addExitListener()

    local updateControl = require("update.UpdateControl")
    updateControl:startUpdate(function() self:updateEnd() end)
end

--更新结束
function UpdateApp:updateEnd()
    self.scene:setTipText("启动游戏模块，准备进入游戏...")

    local verCheck = require("update.VerCheck")
    device.version = verCheck:getVerStr()

    scheduler.performWithDelayGlobal(function() self:enterGame() end,0.001)
end

function UpdateApp:enterGame()
    CCLuaLog("UpdateApp:enterGame..111")
    scheduler.performWithDelayGlobal(function() self:cleanData() end,3)
	if device.platform == "android" then
        local libList = {"lib/config_precompiled.zip","lib/game_precompiled.zip","lib/uilua_precompiled.zip"}
        local name = {"config","game","ui"}
        for i,libzip  in ipairs(libList) do
            local zipPath = CCFileUtils:sharedFileUtils():fullPathForFilename(libzip)
            CCLuaLog("new lib:"..zipPath)
            if UpdateApp.helper:exists(zipPath) then

                self.scene:setTipText("正在启动"..name[i].."模块...")
                CCLuaLoadChunksFromZIP(zipPath)
            else
                self.scene:setTipText("正在启动"..name[i].."模块")
                CCLuaLoadChunksFromZIP(v)
            end
        end
		require("game.main")
	elseif device.platform == "ios" then
		require("scripts.main")
	elseif device.platform == "windows" then
        require("scripts.main")
    end
    self.scene:dispose()
    self.scene = nil
end

function UpdateApp:cleanData()
    UpdateApp = nil
    package.preload["update.UpdateScene"] = nil
    package.preload["update.UpdateHelper"] = nil
    package.preload["update.UpdateControl"] = nil
    package.preload["update.VerCheckControl"] = nil
end

function UpdateApp:exit()
    CCDirector:sharedDirector():endToLua()   --退出游戏
end


return UpdateApp
