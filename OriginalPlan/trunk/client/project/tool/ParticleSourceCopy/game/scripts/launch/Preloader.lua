local PreloaderCls = class("PreloaderCls")


--需要预加载的配置
PreloaderCls.PRELOAD_CONFIGS = {"rect9","skill","buff","magic","hero"}

--预加载进内存的公共组件纹理对象
PreloaderCls.PRELOAD_ATLAS = {"ui/common","ui/home/home"}


function PreloaderCls:preLoad(gameApp)
    --先打开接在界面
    self._gameApp = gameApp
    
    self:_openLoadView(gameApp:getMainScene())
    
    --流程：加载配置->加载公共纹理
    
    self._curStep = 0
    self._totalStep = #PreloaderCls.PRELOAD_CONFIGS + #PreloaderCls.PRELOAD_ATLAS
    self:_preloadCfg()
end


function PreloaderCls:_openLoadView(scene)
    self._loadingPanel = require('launch.LoadingPanel') --加载
    self._loadingPanel:show(scene) -- 打开界面    
end

function PreloaderCls:_preloadCfg()
    self._cfgLoadedIndex = 1
    self._timeHandlerId = scheduler.scheduleGlobal(function() self:_loadNextCfg() end,0.01,false)
end

function PreloaderCls:_loadNextCfg()
    ConfigMgr:requestConfig(PreloaderCls.PRELOAD_CONFIGS[self._cfgLoadedIndex],function() self:_onCfgLoaded() end)
end

function PreloaderCls:_onCfgLoaded()
    self._cfgLoadedIndex = self._cfgLoadedIndex + 1
    self:_nextStep(1)
    if self._cfgLoadedIndex > #PreloaderCls.PRELOAD_CONFIGS then  --配置加载成功
        scheduler.unscheduleGlobal(self._timeHandlerId)
        self:_preLoadAtlas()
    end
end

function PreloaderCls:_preLoadAtlas()
    self._loadAtlasIndex = 1
    self._timeHandlerId = scheduler.scheduleGlobal(function() self:_loadNextAtlas() end,0.01,false)
end

function PreloaderCls:_loadNextAtlas()
    local atlas = PreloaderCls.PRELOAD_ATLAS[self._loadAtlasIndex]
    
    ResMgr:loadPvr(atlas)
    
    self._loadAtlasIndex = self._loadAtlasIndex + 1
    self:_nextStep(1)
    --scheduler.unscheduleGlobal(self._timeHandlerId)
    if self._loadAtlasIndex > #PreloaderCls.PRELOAD_ATLAS then --加载plist完成
        scheduler.unscheduleGlobal(self._timeHandlerId)

        --scheduler.performWithDelayGlobal(function() self._gameApp:starGame() end ,10)
        
        self._gameApp:starGame()
    end
end

function PreloaderCls:_nextStep(step)
    step = step or 1
    self._curStep = self._curStep+step
    local progress = math.floor((self._curStep/self._totalStep)*100)
    echo(step,self._curStep.."/"..self._totalStep)
    --设置LoadingPanel中的显示
    self._loadingPanel:setProgress(self._curStep,self._totalStep)
end

function PreloaderCls:dispose()
    self._loadingPanel:dispose()
    self._loadingPanel = nil
    
end

local Preloader = PreloaderCls.new()
return Preloader