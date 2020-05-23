--wdx
--2015 9 22

local ComInfoTips_1 = class("ComInfoTips_1",function() return display.newNode()  end)

function ComInfoTips_1:ctor()
	self:retain()
	self:init()
end

function ComInfoTips_1:setTipsPosition(x, y, height)
	self:setPosition(x,y+height-160)
end

function ComInfoTips_1:init(  )
	-- body
	self.uiNode = UINode.new()
	self.uiNode:setUI("com_tip")
	self:addChild(self.uiNode)
	local bg = self.uiNode:getNodeByName("bg")
	self:setContentSize(bg:getContentSize())
	self._content = self.uiNode:getNodeByName("content")
end

function ComInfoTips_1:getContentWidth()
	return self:getContentSize().width
end

function ComInfoTips_1:setContent(text,x,y)
	self._content:setText(text)
	local bg = self.uiNode:getNodeByName("bg")
	local layer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY_TOP)
	layer:addChild(self)
	self:setTipsPosition(x,y,bg:getContentSize().height)
end

function ComInfoTips_1:dispose()
	self._content:setText("")
	if self.uiNode then
		self.uiNode:dispose()
		self.uiNode = nil
	end

	self:removeFromParent()
	self:release()
end

return ComInfoTips_1
