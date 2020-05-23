--[[--
	module：      LoadingPannel
	author:   wdx
	event：
	无
	example：
		game.LoadingPanel = require('launch.LoadingPanel') --加载
		game.LoadingPanel.open() -- 打开界面
		game.LoadingPanel.setProgress(progress)  -- 每步加载过程中调用显示进度  progress
]]

local LoadingPanel = class("LoadingPanel",function() return display.newNode() end)

function LoadingPanel:ctor()
	self:retain()
	self:init()
end

function LoadingPanel:init()

	ResMgr:loadPvr("ui/login/login")

	local bg = display.newXSprite("ui/login/loginBg.w")
	bg:setPosition( display.cx,display.cy )
	self:addChild(bg)
	
	--构建提示文本
	local params = {}
		params.text = "初始化游戏..."
	    params.size = 20
		params.color = display.COLOR_WHITE
	    params.align = ui.TEXT_ALIGN_CENTER
	    params.valign = ui.TEXT_VALIGN_TOP
	   	params.dimensions = CCSize(300,50)
	   	params.outlineColor = ccc3(0,0,0)
	self.tipText = ui.newTTFLabelWithOutline(params)
	self.tipText:setPosition(display.cx,80)
	self.tipText:setAnchorPoint(ccp(0.5,0.5))
	self:addChild(self.tipText);   --文本

--barImage, barInsets, bgImage, bgInsets, barMaxSize, bgMaxSize, position, maxProgress
	local bar = "login_bar.png"
	local barBg = "login_barBg.png"
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	local barSize = cache:spriteFrameByName(bar):getOriginalSize();
	local barBgSize = cache:spriteFrameByName(barBg):getOriginalSize();
	--print(barSize.width,barSize.height,"dddddddddddd",barBgSize.width,barBgSize.height)
	self.bar = UIProgressBar.new("#"..bar,"#"..barBg,barSize,barBgSize)
	self.bar:setAnchorPoint(ccp(0.5,0))
	self.bar:setPosition(display.cx,50)
	self:addChild(self.bar)
end

function LoadingPanel:setProgress(cur,max)
	self.bar:setMaxProgress(max)
	self.bar:setProgress(cur)
end

function LoadingPanel:show(root)
	root:addChild(self)
end

function LoadingPanel:dispose()
	self.bar:dispose()
	self:removeSelf()
	self:release()
	ResMgr:unload("ui/login/login")
end

return LoadingPanel.new()