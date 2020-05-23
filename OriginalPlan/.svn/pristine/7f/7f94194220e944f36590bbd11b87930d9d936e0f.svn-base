--
-- Author: wdx
-- Date: 2016-03-24 15:58:22
--
local TextTag = game_require("uiLib.component.richText.tag.TextTag")
local NumTag = class("NumTag",TextTag)

function NumTag:_newNode()
	print("function NumTag:_newNode()")
--	dump(self.tagInfo)
	local tag = self.tagInfo
	local prefix = tag.prefix
	local postfix = tag.postfix or ".png"
	if not prefix then
		self._text = self.tagInfo.value
		return TextTag._newNode(self)
	end
	local w,h = 0,0
	local node = display.newNode()
	local num = tag.value or tag.text
	if not self._imgs then
		self._imgs = {}
	end
	local pad = tonumber(self.tagInfo.pad) or 0
	local scale = tonumber(self.tagInfo.scale) or 1
	for i=1,num:len() do
		local src = prefix .. num:sub(i,i) .. ".png"
		print(src)
		local img = display.newXSprite(src)
		local siz = img:getContentSize()
		node:addChild(img)
		img:setScale(scale)
		img:setPosition(w+siz.width/2, siz.height/2)
		self._imgs[img] = img
		if h < siz.height then
			h = siz.height
		end
		w = w + siz.width + pad
	end
	node:setContentSize(CCSize(w,h))
	return node
end

function NumTag:setOpacity(opacity)
	TextTag.setOpacity(self, opacity)
	for i,img in pairs(self._imgs) do
		img:setOpacity(opacity)
	end
end

function NumTag:getSize()
	local node = self:getNode()
	if not self.tagInfo.prefix then
		return TextTag.getSize(self)
	else
		return node:getContentSize()
	end
end

function NumTag:dispose()
	self._imgs = nil
	TextTag.dispose(self)
end

return NumTag