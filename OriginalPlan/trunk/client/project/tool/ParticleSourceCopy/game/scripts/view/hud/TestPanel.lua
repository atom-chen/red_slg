--
-- Author: Your Name
-- Date: 2014-05-23 10:06:49
--

ParticleMgr = require("view.ParticleMgr")

local TestPanel = class("TestPanel",PanelProtocol)

function TestPanel:ctor()
	PanelProtocol.ctor(self,GameLayer.HUD)
	self:initUI()
end


function TestPanel:setText(text, x, y, tag)
	print(text)
	
	local ttag = tag or 1001
	local child = self:getChildByTag(ttag)
	if (child) then
		child:setString(text)
		child:setPosition(ccp(x or 0, y or 0))
	else
		local idx = #self._uiList + 1
		self._uiList[idx] = RichText.new(string.len(text) * 10, 20, 18, ccc3(255, 255, 255), 0, RichText.ALIGN_LEFT)
		self._uiList[idx]:setPosition(ccp(x or 0, y or 0))
		self:addChild(self._uiList[idx], 0, ttag)
	end
end

function TestPanel:testProcessBar()

	local bar = UIProgressBar.new("#btn_green_0u.png", "#btn_yellow1u.png", CCSize(80, 20), CCSize(100, 30), ccp(0, 5), 100)
	self:addChild(bar)
	bar:setProgress(20)
	bar:setText("1")
	UIProgressBar:setTextFormat(UIProgressBar.TEXT_FORMAT_PERCENT)
	bar:setPosition(100, 100)
	bar:setProgress(100)

end

function TestPanel:initUI(  )

	self:setAnchorPoint(ccp(0, 0))
	self:setContentSize(CCSize(0, 0))
	self:test()
end

function TestPanel:test()
	print("kaishi......11111111111")
	SourceCopy = require("source_copy")
	SourceCopy:source_copy();
end

function TestPanel:getRoot()
	return ViewMgr.hudRoot
end

function TestPanel:onEnter()
	
end

function TestPanel:onExit()
	
end



return TestPanel




