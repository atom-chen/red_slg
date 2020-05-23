--
-- Author: wdx
-- Date: 2016-03-24 15:58:22
--
local NodeTag = game_require("uiLib.component.richText.tag.NodeTag")
local ImageTag = class("ImageTag",NodeTag)

function ImageTag:_newNode()
	local bg
	if self.tagInfo.bg then
		bg = display.newXSprite(self.tagInfo.bg)
		bg:setAnchorPoint(ccp(0,0))
	end

	local img 
	if self.tagInfo.src then
		local res = GameConst.RES_ICON[self.tagInfo.src] or self.tagInfo.src
		img = display.newXSprite(res)
		img:setAnchorPoint(ccp(0,0))
		if self.tagInfo.scale then
			img:setScale(self.tagInfo.scale)
		end
		if self.tagInfo.w then
			img:setImageSize(CCSize(self.tagInfo.w,self.tagInfo.h))
		end
		if bg then
			bg:addChild(img)
			bg.img = img
		end
	end
	return bg or img
end

function ImageTag:getSize()
	if self.tagInfo.bg and not self.tagInfo.src then
		return CCSize(0,0)
	end

	local node = self:getNode()
	if node.img then
		return node.img:getContentSize()
	end
	return NodeTag.getSize(self)
end

function ImageTag:setOpacity(opacity)
	local img = self:getNode()
	img:setOpacity(opacity)
	if img.bg and img.bg.setOpacity then
		img.bg:setOpacity(opacity)
	end
end

return ImageTag