
local Preloader = class("Preloader")

--需要预加载的配置
Preloader.PRELOAD_CONFIGS = {"lang","rect9","resource"}

--预加载进内存的公共组件纹理对象
Preloader.PRELOAD_ATLAS = {--"ui/majorCity/majorCity.pvr.ccz",
							--"ui/home/home.pvr.ccz",
                        --"ui/dungeon/dungeon.pvr.ccz",
                        "ui/biaoqing.pvr.ccz",}
--预加载 图片
Preloader.PRELOAD_IMAGE = {}--,"word.png"

Preloader.LOAD_COMPLETE = "load_complete"
Preloader.LOAD_CONFIG_COMPLETE = "load_config_complete"

function Preloader:ctor()
    EventProtocol.extend(self)
end

function Preloader:preLoad(scene)
    --先打开接在界面
    self:_openLoadView(scene)

    --流程：加载公共纹理->加载配置
    self._curStep = 0
    self._totalStep = #Preloader.PRELOAD_CONFIGS + #Preloader.PRELOAD_ATLAS + #Preloader.PRELOAD_IMAGE
    self:_preloadCfg()

    -- AudioMgr:preloadEffect("MainClick")
end

function Preloader:_openLoadView(scene)
    self._loadingPanel = game_require('launch.LoadingPanel').new() --加载
    self._loadingPanel:show(scene) -- 打开界面
end

function Preloader:setLoadVisible(flag,scene)
    if flag then
        self._loadingPanel:show(scene)
    else
        self._loadingPanel:removeFromParent()
    end
end

function Preloader:_preLoadAtlas()
    self._loadAtlasIndex = 1
    self.atlas_co = coroutine.create(function ()
                    for k =1,#Preloader.PRELOAD_ATLAS do
                        self:_loadNextAtlas()
                        coroutine.yield()
                    end
                end)
    self._timeHandlerId = scheduler.scheduleGlobal(function() self:_updateAtlasState() end,0.001,false)
end

function Preloader:_loadNextAtlas()
    local atlas = Preloader.PRELOAD_ATLAS[self._loadAtlasIndex]
    ResMgr:loadPvr(atlas)
    self._loadAtlasIndex = self._loadAtlasIndex + 1
    self:_nextStep(1)
end

function Preloader:_updateAtlasState()
    if self._loadAtlasIndex > #Preloader.PRELOAD_ATLAS then --加载plist完成
        scheduler.unscheduleGlobal(self._timeHandlerId)
        self._timeHandlerId = nil
        self:dispatchEvent({name=self.LOAD_COMPLETE})
    else
        coroutine.resume(self.atlas_co)
    end
end

function Preloader:_preLoadImage()
    self._loadImageIndex = 1
    self.img_co = coroutine.create(function ()
                    for k =1,#Preloader.PRELOAD_IMAGE do
                        self:_loadNextImage()
                        coroutine.yield()
                    end
                end)
    self._timeHandlerId = scheduler.scheduleGlobal(function() self:_updateImageState() end,0.001,false)
end

function Preloader:_loadNextImage()
    if self._loadImageIndex <= #Preloader.PRELOAD_IMAGE then --加载plist完成e
       local atlas = Preloader.PRELOAD_IMAGE[self._loadImageIndex]
        ResMgr:loadImage(atlas)
        self._loadImageIndex = self._loadImageIndex + 1
        self:_nextStep(1)
    end
end

function Preloader:_updateImageState()
    if self._loadImageIndex > #Preloader.PRELOAD_IMAGE then --加载plist完成
        scheduler.unscheduleGlobal(self._timeHandlerId)
        self._timeHandlerId = nil
        self:_preLoadAtlas()
    else
        coroutine.resume(self.img_co)
    end
end

function Preloader:_preloadCfg()
    self._cfgLoadedIndex = 1
    self.cfg_co = coroutine.create(function ()
                    for k =1,#Preloader.PRELOAD_CONFIGS do
                        self:_loadNextCfg()
                        coroutine.yield()
                    end
                end)
    self._timeHandlerId = scheduler.scheduleGlobal(function() self:_updateCfgState() end,0.001,false)
end

function Preloader:_loadNextCfg()
    ConfigMgr:requestConfig(Preloader.PRELOAD_CONFIGS[self._cfgLoadedIndex])
    self._cfgLoadedIndex = self._cfgLoadedIndex + 1
    self:_nextStep(1)
end

function Preloader:_updateCfgState()

    if self._cfgLoadedIndex > #Preloader.PRELOAD_CONFIGS then  --配置加载成功
        scheduler.unscheduleGlobal(self._timeHandlerId)
        self._timeHandlerId = nil
        scheduler.performWithDelayGlobal(function() self:dispatchEvent({name=self.LOAD_CONFIG_COMPLETE}) end ,0.001)
        self:_preLoadImage()
    else
        coroutine.resume(self.cfg_co)
    end
end

function Preloader:_nextStep(step)
    step = step or 1
    self._curStep = self._curStep+step
    local progress = math.floor((self._curStep/self._totalStep)*100)
    --echo(step,self._curStep.."/"..self._totalStep)
    --设置LoadingPanel中的显示
    self._loadingPanel:setProgress(self._curStep,self._totalStep)
end

function Preloader:setText(str)
    self._loadingPanel:setText(str)
end

function Preloader:dispose()
    if self._timeHandlerId then
        scheduler.unscheduleGlobal(self._timeHandlerId)
        self._timeHandlerId = nil
    end
    self:removeAllEventListeners()
    self._loadingPanel:dispose()
    self._loadingPanel = nil
end

return Preloader