
local SimpleTips = class("SimpleTips", UIVList)

function SimpleTips:ctor(priority,layerID, width, bgImage)
	UIVList.ctor(self, width or 300, 0.5, bgImage or "#com_tips.png")
	if type(layerID) == "string" then
		self.layerID = layerID
		self._priority = GameLayer.priority[self.layerID]
	else
		self._priority = layerID
	end
	
	self._fontSize = 18
	self._rowInterval = 3
	self:init()
end

function SimpleTips:init()
	self:setPadding({left=20, right=20, bottom=10, top=20})
	self:setMargin(10)
	self:setAutoUpdate(false)
end

function SimpleTips:addText(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	local text = self:_getText(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	self:addCell(text)
	self:update()
end

function SimpleTips:_getText(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	local width = self:getContentWidth()
	if not self._textInfo then
		self._textInfo = {fontSize=fontSize, fontName=fontName, fontColor=fontColor, align=align, valign=valign, useRTF=useRTF, shadow=shadow,outline=outline}
	else
		UIInfo.setTextInfo(self._textInfo, text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	end
	
	local textnode = UIAttachText.new(width, self._textInfo.fontSize or 20, self._textInfo.fontSize or 20, self._textInfo.fontName, self._textInfo.fontColor, self._textInfo.useRTF or true, self._textInfo.shadow, self._textInfo.outline)
	if textnode:isRichText() then
		textnode:setAlignment(self._textInfo.align, self._textInfo.valign)
		textnode:setRowInterval(self._rowInterval)
		textnode = RichTextContainer.new(textnode)
	end
	
	textnode:setText(text)
	
	return textnode
end

return SimpleTips