
local ResMgr = ResMgr or ResourceMgr:instance()

local scene = display.newScene()
scene:retain()

--初始化
function scene:init()
    ResMgr:loadPvr("res/pic/ui.pvr.ccz")
    if CCDirector:sharedDirector():getRunningScene() then
        CCDirector:sharedDirector():replaceScene(self)
    else
        CCDirector:sharedDirector():runWithScene(self)
    end
end

function scene:showLogo(callBack)
	--[[
    local hasPlatformLogo = false
    local res = "res/pic/logo_base.w"
    local LogoPath = CCFileUtils:sharedFileUtils():fullPathForFilename(res)
    local logoTime = 1.5
    if UpdateApp.helper:exists(LogoPath) then
        hasPlatformLogo = true
        logoTime = 2.5
    else
        hasPlatformLogo = false
        res = "#logo.png"
        logoTime = 1.6
    end
    self.logo = display.newXSprite(res)
    self.logo:setPosition(display.cx,display.cy)
    self:addChild(self.logo)

    if hasPlatformLogo then
        scheduler.performWithDelayGlobal(function() self.logo:setSpriteImage("#logo.png") end, logoTime/2)
    end

    scheduler.performWithDelayGlobal(function() self.logo:removeFromParent()
                                                 callBack()
                                                 end, logoTime)
												 --]]

	callBack()
end

function scene:initUI()

    self.versionText = ui.newTTFLabel({text="", size=14,align=ui.TEXT_ALIGN_LEFT})
    self.versionText:setAnchorPoint(ccp(0,1))
    self.versionText:setPosition(0, display.height)
    self:addChild(self.versionText)

    self.tipText = ui.newTTFLabelWithOutline({text="", size=19,align=ui.TEXT_ALIGN_CENTER})
    self.tipText:setPosition(display.cx, 18)
    self:addChild(self.tipText)
end

function scene:setBg()
    local bg = display.newXSprite("res/pic/init_bg.w")
    self:addChild(bg,-1)
    bg:setPosition(display.cx,display.cy)
end

function scene:setVersionText(version)
    self.versionText:setString(version)
end

function scene:setNextVersionText(version)
    if version then
        if not self.nextVersionText then
            self.nextVersionText = ui.newTTFLabel({text="", size=14,align=ui.TEXT_ALIGN_RIGHT})
            self.nextVersionText:setAnchorPoint(ccp(1,1))
            self.nextVersionText:setPosition(display.width, display.height)
            self:addChild(self.nextVersionText)
            self.nextVersionText:setString(version)
        end
    elseif self.nextVersionText then
        self:removeChild(self.nextVersionText)
        self.nextVersionText = nil
    end
end

function scene:setTipText(str)
    self.tipText:setString(str)
end

function scene:addProgress()
    if not self.barContainer then
        self.barContainer = display.newNode()
        self.barContainer:setPosition(display.cx,55)
        self:addChild(self.barContainer)
        local barBg = display.newSprite("#login_barBg.png");
        self.barContainer:addChild(barBg)
        self.progress = display.newXSprite("#login_bar.png")
        self.progress:setPositionY(1)
        self.progress:setAnchorPoint(ccp(0,0.5))

        self.barContainer:addChild(self.progress)

        self.barSize = self.progress:getContentSize()
        self.progress:setPositionX(-self.barSize.width/2)
        -- self.progress:setMidpoint(ccp(0, 0))
        -- self.progress:setBarChangeRate(ccp(1, 0))

        self.funnyText = ui.newTTFLabelWithOutline({text="", size=22,align=ui.TEXT_ALIGN_CENTER})
        self.funnyText:setPosition(0, 40)
        self.barContainer:addChild(self.funnyText)

        self:_getUpdateTip()

        self:_showFunnyText()
        if not self.funnyTimeId then
            self.funnyTimeId = scheduler.scheduleGlobal(function()
                self:_showFunnyText()
             end, 3)
        end
    end
    -- self.progress:setPercentage(0)
    self.progress:setClipRect(CCRect(0,0,1,self.barSize.height))
end

function scene:_showFunnyText()
    if type(self._resTip) == "table" then
        local str = self._resTip[math.random(1,#self._resTip)]
        self.funnyText:setString(str)
    else
        local tipCfg = require("update.load_tip_cfg")
        local str = tipCfg[math.random(1,#tipCfg)]
        self.funnyText:setString(str.tip)
    end
end

function scene:_getUpdateTip()  --获取服务器的更新提示
    if self._resTip == nil then
        local url = GameCfg:getValue("tiphttp")
        if not url or url == "" then
            self._resTip = "error"
            return
        end
        local request = network.createHTTPRequest(function (event)
            if (event.name == "progress") then
                return
            end
            local req = event.request
            if event.name == "completed" then
                if req:getResponseStatusCode() == 200 then
                    local resInfoTxt = req:getResponseString()
                    if resInfoTxt ~= "" then
                        self._resTip = string.splitEx(resInfoTxt, "\n")
                        for i=#self._resTip,1,-1 do
                            if self._resTip[i] == "" then
                                table.remove(self._resTip,i)
                            end
                        end
                        if #self._resTip > 0 then
                            self:_showFunnyText()
                            return
                        end
                    end
                end
                self._resTip = "error"
            else
                self._resTip = "error"
            end
        end,url,"GET")
        request:addRequestHeader("Content-Type:application/x-www-form-urlencoded")
        request:start()
    end
end

function scene:setProgress(pro)
    if self.progress then
            self.progress:setClipRect(CCRect(0,0,self.barSize.width*pro,self.barSize.height))
        -- self.progress:setPercentage(pro)
    end
end

function scene:removeProgress()
    if self.barContainer then
        self.barContainer:removeFromParent()
        self.barContainer = nil
        self.progress = nil
        if self.funnyTimeId then
            scheduler.unscheduleGlobal(self.funnyTimeId)
            self.funnyTimeId = nil
        end
    end
end

function scene:addExitListener()
    if device.platform == "android" then
        self:setKeypadEnabled(true)
        self:addKeypadEventListener(function(event)
                if event == "back"  then
                    if gamePlatform:support(PlatformSupport.EXIT_GAME) then
                        gamePlatform:exitGame()
                    elseif UpdateApp then
                        UpdateApp.helper:nativeMessageBox( "提示","确定退出游戏？","确定","取消",
                        function() UpdateApp:exit() end)
                    else
                        CCDirector:sharedDirector():endToLua()
                    end
                end
            end)
    end
end

function scene:dispose()
    CCLuaLog("scene:dispose")
    ResMgr:unload("res/pic/ui.pvr.ccz")
    if device.platform == "android" then
        self:setKeypadEnabled(false)
    end
    if self.funnyTimeId then
        scheduler.unscheduleGlobal(self.funnyTimeId)
        self.funnyTimeId = nil
    end
    self:removeProgress()
    self:release()
end

return scene
