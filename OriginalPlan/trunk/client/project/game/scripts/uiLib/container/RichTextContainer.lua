--[[
@desc 提供精确反应实际大小的containerSize， 其中containerSize 不小于 初始化richtext的 width 和 height
	且richtext的valignment必须为TOP
@sample
	local richtext = ...
	local richtextContainer = RichTextContainer.new(richtext)
	node:addChild(richtextContainer)
	richtextContainer:setText("12222\n2222")
	
--]]

local RichTextContainer = class("RichTextContainer", function(richtext) return display.newNode()end)

--[[
@param richtext RichText
@disposeRichText boolean 是否自dispose的时候是否dispose richtext
--]]
function RichTextContainer:ctor(richtext, disposeRichText)
	self:retain()
	self._richtext = richtext
	self._richtext:retain()
	self._disposeRichText = disposeRichText ~= false
	self:addChild(richtext)
	self._richtext:setAnchorPoint(ccp(0, 0))
	self:update()
	
end
--[[
function RichTextContainer:getContentSize()
	self._richtext:getTextContentSize()
end
--]]

function RichTextContainer:update(resetPosition)
	local csiz = self._richtext:getContentSize()
	local vsiz = CCSize(self._richtext:getTextContentSize())
	local siz = CCSize(vsiz.width, vsiz.height)
	-- [[
	if siz.width < csiz.width then
		siz.width = csiz.width
	end
	if siz.height < csiz.height then
		siz.height = csiz.height
	end
	--]]
	self:setContentSize(siz)
--	print("function RichTextContainer:update()", siz.width, siz.height, vsiz.width, vsiz.height)
	if resetPosition == nil or resetPosition then
		self._richtext:setPositionY(siz.height-csiz.height)
	end
	self:updateBgImage(siz)
end

function RichTextContainer:setText(text)
	self._richtext:setText(text)
	self:update()
end


function RichTextContainer:setBgImage(bgImage)
	if not self._bgImage then
		self._bgImage = UIImage.new(bgImage, nil, true)
		self._bgImage:setAnchorPoint(ccp(0,0))
		self:addChild(self._bgImage,-1)
	end
	
	self._bgImage:setNewImage(bgImage)
	self:updateBgImage(self:getContentSize())
end

function RichTextContainer:clearBgImage()
	if self._bgImage then
		self._bgImage:setSpriteImage(nil)
		self._bgImage:dispose()
		self._bgImage = nil
	end
end

function RichTextContainer:updateBgImage(siz, pos, anchor)
	if not self._bgImage then return end
	
	if siz then
		self._bgImage:setImageSize(siz)
	end
	
	if pos then
		self._bgImage:setPosition(pos)
	end
	
	if anchor then
		self._bgImage:setAnchorPoint(anchor)
	end
end


function RichTextContainer:dispose(disposeRichText)
	self:clearBgImage()
	local dispose = tobool(disposeRichText or self._disposeRichText)
	if dispose then
		self._richtext:dispose()
	end
	self._richtext:release()
	self._richtext = nil
	self:removeFromParent()
	self:release()
end

return RichTextContainer