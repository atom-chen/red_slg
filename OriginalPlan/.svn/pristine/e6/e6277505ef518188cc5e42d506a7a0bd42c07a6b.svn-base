-- luacall = game_require("launch.luacall")

local GameApp = class("GameApp")

function GameApp:startup(stage)
	print("GameApp:startup(stage)")
    self.mainScene = stage

    self._netOk = false
    self._loadOk = false
    --预加载
    self._preLoader = game_require("launch.Preloader").new()
    self._preLoader:addEventListener(self._preLoader.LOAD_CONFIG_COMPLETE, {self,self._onConfigLoaded})
    self._preLoader:addEventListener(self._preLoader.LOAD_COMPLETE, {self,self._loadComplete})
    self._preLoader:preLoad(self.mainScene)

end

function GameApp:getMainScene()
    return self.mainScene
end

--配置加载成功了
function GameApp:_onConfigLoaded(e)
	print("GameApp:_onConfigLoaded(e)")
	self._preLoader:removeEventListener(self._preLoader.LOAD_CONFIG_COMPLETE, {self,self._onConfigLoaded})
	self._preLoader:setText("正在进入游戏...")

	local msg = {}
	msg.roleUID = 0;
	NetCenter:sendMsg(MsgType.ENTER_GAME, msg)  --客户端进入游戏

	NotifyCenter:addEventListener(Notify.NET_INIT_OK, {self,self._onNetInit})
end

function GameApp:_onNetInit(event)
  	print("function GameApp:_onNetInit()", self._netOk, self._loadOk, self._shouldSelectGroup)
  	self._netOk = true
  	NotifyCenter:removeEventListener(Notify.NET_INIT_OK, {self,self._onNetInit})
  	if self._loadOk then
  		self:starGame()
  	end
end

function GameApp:_loadComplete()
    self._preLoader:removeEventListener(self._preLoader.LOAD_COMPLETE, {self,self._loadComplete})
    self._loadOk = true
	self._netOk  = true
    if self._netOk then
        self:starGame()
    else
        if LOCAL_RUN then
            self:starGame()
        else
            self._preLoader:setText("初始化指挥官信息...")
        end
    end
end

--预加载成功
function GameApp:starGame()
    --配置、公共纹理全部加载进来了,开始初始化游戏
    self._preLoader:dispose()
    self._preLoader = nil
    self:enterGame()

    local notificationCenter = CCNotificationCenter:sharedNotificationCenter()
    notificationCenter:registerScriptObserver(nil, handler(self, self.onEnterForeground), "APP_ENTER_FOREGROUND")
    -- notificationCenter:registerScriptObserver(nil, handler(self, self.onBackground), "APP_ENTER_BACKGROUND")
end


--从后台 进入前台的时候
function GameApp:onEnterForeground()
    scheduler.performWithDelayGlobal( function()
            -- if NetCenter.status ~= NetCenter.CONNECT_SUCCESS then
            if NetCenter._reconnectEnable then
                NetCenter:_onReConnect()
            end
            -- end
          end, 0.06)
end

--[[--
  --成功进入游戏同时进入界面：
]]
function GameApp:enterGame()
	-- if true then ViewMgr:open(Panel.OPEN_FILM) return end
	--if true then ViewMgr:open(Panel.TEMP_HOME);return;end

	--  ViewMgr:open(Panel.LOADING)
	-- GuideModel:addNewGuide(GuideModel.TACTIC_ENEMY)
	if LOCAL_RUN then
		--ViewMgr:open(Panel.FIGHT)
		--ViewMgr:open(Panel.TOWN)
		ViewMgr:open(Panel.MAIN_UI)
		return
	end

    local ver = CCUserDefault:sharedUserDefault():getStringForKey("updateNewVer")
    if ver and ver ~= "" then
        CCUserDefault:sharedUserDefault():setStringForKey("updateNewVer","")
        CCUserDefault:sharedUserDefault():flush()
        NetCenter:send(MsgType.UPDATE_REWARD,ver)
    end

    ViewMgr:open(Panel.MAIN_UI,nil,true)
end

--重置游戏
function GameApp:resetGame()
    if self._preLoader then
        self._preLoader:dispose()
        self._preLoader = nil
    end
    ModelMgr:reset()
end

return GameApp