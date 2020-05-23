--
-- Author: wdx
-- Date: 2014-06-03 10:02:31
--

--检测更新页面

local UpdateState = class("UpdateState",StateBase)

function UpdateState:init()
	-- body

	local bg = display.newXSprite("ui/login/loginBg.w")
	bg:setPosition( display.cx,display.cy )
	self:addChild(bg)
	
	self:initUI()
end

function UpdateState:initUI()

	ResMgr:loadPvr("ui/login/login")

	local params = {}
		params.text = "检测版本更新..."
	    params.size = 20
		params.color = display.COLOR_WHITE
	    params.align = ui.TEXT_ALIGN_CENTER
	    params.valign = ui.TEXT_VALIGN_TOP
	   	params.dimensions = CCSize(300,50)
	   	params.outlineColor = ccc3(0,0,0)
	self.tipText = ui.newTTFLabelWithOutline(params)
	self.tipText:setPosition(display.cx,50)
	self.tipText:setAnchorPoint(ccp(0.5,0.5))
	self:addChild(self.tipText);   --文本

end

function UpdateState:show(mgr)
	StateBase.show(self,mgr)

	scheduler.performWithDelayGlobal(handler(self,self.updateEnd),1)
	--做一些版本检测的事情
end

function UpdateState:updateEnd( )
	self:changeState(StateBase.GAME)
end

function UpdateState:dispose()
	self:removeSelf(true)

	ResMgr:unload("ui/login/login")
end

return UpdateState