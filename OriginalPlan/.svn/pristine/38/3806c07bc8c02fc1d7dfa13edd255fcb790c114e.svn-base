local TagBase = game_require("uiLib.component.richText.tag.TagBase")
--普通的空节点
local NodeTag = class("NodeTag",TagBase)

function NodeTag:ctor(tInfo)
	self.tagInfo = tInfo
	if tInfo.w and tInfo.h then
		self:getNode():setContentSize(CCSize(tInfo.w,tInfo.h or 20))
	end
end

function NodeTag:getNode()
	if not self.node then
		self.node = self:_newNode()
		if self.tagInfo.scale then
			self.node:setScale(self.tagInfo.scale)
		end
		self.node:retain()
	end
	return self.node
end

function NodeTag:_newNode( )
	return display.newNode()
end

function NodeTag:addTag(tag)
	local node = tag:getNode()
	if node then
		self:getNode():addChild(node)
	end
end

function NodeTag:getSize()
	return self:getNode():getContentSize()
end

function NodeTag:setOpacity(opacity)
--	print("function NodeTag:setOpacity(opacity)", opacity)
	local node = self:getNode()
	if node and node.setOpacity then
		node:setOpacity(opacity)
	end
end

function NodeTag:dispose()
	if self.node then
		self.node:removeFromParent()
		self.node:release()
	end
end



-------------一个个显示的时候----------------
function NodeTag:show(num)
	self:getNode():setVisible(true)
	return true
end

return NodeTag