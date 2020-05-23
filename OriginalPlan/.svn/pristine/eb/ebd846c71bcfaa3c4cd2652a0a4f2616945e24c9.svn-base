--[[--
	module：      LoadingPannel
	author:   wdx
	event：
	无
	example：
		game.LoadingPanel = game_require('launch.LoadingPanel') --加载
		game.LoadingPanel.open() -- 打开界面
		game.LoadingPanel.setProgress(progress)  -- 每步加载过程中调用显示进度  progress
]]

local LoadingPanel = class("LoadingPanel",function() return display.newNode() end)

function LoadingPanel:ctor()
	self:retain()
	self:init()
end

function LoadingPanel:init()

	ResMgr:loadPvr("ui/login/login.pvr.ccz")

	local res = "pic/init_bg.w"

	local bg = display.newXSprite(res)
	bg:setPosition( display.cx,display.cy )
	self:addChild(bg)

	local isSupport =gamePlatform:support(PlatformSupport.REMOVE_GAMELOGO)
	if not isSupport then
		local gameLogo = display.newXSprite("#login_logo.png")
		gameLogo:setAnchorPoint(ccp(0.5,1))
		gameLogo:setPosition(display.cx,display.height-50)
		self:addChild(gameLogo)
	end


	--构建提示文本
	local params = {}
		params.text = "加载中..."
	    params.size = 20
		params.color = display.COLOR_WHITE
	    params.align = ui.TEXT_ALIGN_CENTER
	    params.valign = ui.TEXT_VALIGN_TOP
	   	params.dimensions = CCSize(200,50)
	   	-- params.outlineColor = ccc3(196,217,234)
	self.tipText = ui.newTTFLabelWithOutline(params)
	self.tipText:setPosition(display.cx,50)
	self.tipText:setAnchorPoint(ccp(0.5,0.5))
	self:addChild(self.tipText,2);   --文本

	self.bar = UIProgressBar.new("#load_bar.png","#load_barBg.png")
	self.bar:setAnchorPoint(ccp(0.5,0))
	self.bar:setPosition(display.cx,25)
	self.bar:setClipMode(true)
	self:addChild(self.bar)

	self.magic = SimpleMagic.new(35)
	self.bar:setProgressPoint(self.magic,5,5)
end

function LoadingPanel:setProgress(cur,max)
	self.bar:setMaxProgress(max)
	self.bar:setProgress(cur)
end

function LoadingPanel:setText(str)
	self.tipText:setString(str)
end

function LoadingPanel:show(root)
	if not self:getParent() then
		root:addChild(self,999)
	end
end

function LoadingPanel:dispose()
	self.bar:dispose()
	self.magic:dispose()
	self:removeSelf()
	self:release()
	ResMgr:unload("ui/login/login.pvr.ccz")
end

return LoadingPanel