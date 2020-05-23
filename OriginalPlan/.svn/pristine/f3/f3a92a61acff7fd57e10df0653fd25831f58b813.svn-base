--[[
class: UIText
inherit: newBMFontLabel or newBMFontLabelWithShadow
desc: 创建文字Lable。
author：changao
date: 2014-06-03
example：
	local node = CCNode:new()
	local text = UIText.new("abcefef", 12, "Marker Felt", ccc3(123,123,123))
	node:addChild(text)
	text:setAlignInParent(node, CCSize(120, 100), UIInfo.alignment.CENTER, UIInfo.alignment.BOTTOM)
--]]

local function _getAlignmentValue(align, valign)
	local aligns = {
	[UIInfo.alignment.LEFT]=ui.TEXT_ALIGN_LEFT,
	[UIInfo.alignment.CENTER]=ui.TEXT_ALIGN_CENTER,
	[UIInfo.alignment.RIGHT]=ui.TEXT_ALIGN_RIGHT,}

	local valigns = {
	[UIInfo.alignment.BOTTOM]=ui.TEXT_VALIGN_BOTTOM,
	[UIInfo.alignment.CENTER]=ui.TEXT_VALIGN_CENTER,
	[UIInfo.alignment.TOP]=ui.TEXT_VALIGN_TOP,}
	local a, va
	if align then
		a = aligns[align]
	end
	if valign then
		va = valigns[valign]
	end
	print("local function _getAlignmentValue(align, valign)", align, valign, a, va)
	return a, va
end

local UIText = class("UIText", function (width, height, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	local uitext
	if useRTF then
		uitext = RichText.new(width, height, fontSize, fontColor, 0, align, valign, shadow, outline)
		if fontSize then
			uitext:setFontSize(fontSize)
			uitext:setColor(fontColor)
			uitext:setAlign(align)
			uitext:setAlignV(valign)
		end
		if shadow then
			uitext:setFontType(RichText.FontType.shadow)
		elseif outline then
			uitext:setFontType(RichText.FontType.outline)
		end
	else
		uitext = UISimpleText.new(width, height, fontSize, nil, fontColor, align, valign, shadow, outline)
	end
	--[[
	elseif shadow then
		local a,va = _getAlignmentValue(align, valign)
		uitext = ui.newTTFLabelWithShadow({size=fontSize, color=fontColor, align=a, valign=va})
		if width and height then
			uitext:setContentSize(CCSize(width, height))
		end
	else
		local a,va = _getAlignmentValue(align, valign)
		uitext = ui.newTTFLabel({size=fontSize, color=fontColor, align=a, valign=va})
		if width and height then
			uitext:setContentSize(CCSize(width, height))
		end
	end
	--]]
	return uitext
end)

--[[
@brief 构造UIAttachText
@param text string
@param fontSize int 文字字体大小
@param fontName string 字体名称
@param fontColor ccc3 字体颜色
]]--
function UIText:ctor(width, height, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	--assert(width or height, "should not be nil")
	if width and height then
		self._parentSize = CCSize(width, height)
	end
	self._useRTF = useRTF

	--self:setColor(fontColor or ccc3(0, 0, 0));
	--self:setAnchorPoint(ccp(0, 0))
	self:retain()

	--dump(getmetatable(self))
end

function UIText:isRichText()
	return tobool(self._useRTF)
end

--[[
@brief 设置文字内容
@param text string
@param fontSize int 文字字体大小
@param fontName string 字体名称
@param fontColor ccc3 字体颜色
]]--
function UIText:setText(text, fontSize, fontName, fontColor, align, valign, shadow, outline)
	--print("UIText:setText(", text, fontSize, fontName, fontColor, align, valign, ")")
	if fontSize and self.setFontSize then
		self:setFontSize(fontSize)
	end

	if fontColor then
		self:setColor(fontColor)
	end
	local textStr = ""
	if text ~= nil then
		textStr = tostring(text)
	end

	if shadow ~= nil then
		self:setShadow(shadow)
	end

	if outline ~= nil then
		self:setOutline(outline)
	end
	if self:isRichText() then
		--self:setAlignment(align, valign)
		if align then
			self:setAlign(align)
		end
		if valign then
			self:setAlignV(valign)
		end
		RichText.setText(self, text)
	else
		--local aligns = {[UIInfo.alignment.left]=kCCTextAlignmentLeft, [UIInfo.alignment.center]=kCCTextAlignmentCenter, [UIInfo.alignment.right]=kCCTextAlignmentRight}
		--local aligns = {[UIInfo.alignment.left]=ui.TEXT_ALIGN_LEFT, [UIInfo.alignment.center]=ui.TEXT_ALIGN_CENTER, [UIInfo.alignment.right]=ui.TEXT_ALIGN_RIGHT}
		UISimpleText.setText(self, text, fontSize, fontName, fontColor, align, valign)
	end
end

--[[
@brief 获取文字内容
@return string 返回的文字
]]--
function UIText:getText()
	if (self:isRichText()) then
		return RichText.getText(self)
	end
	return UISimpleText.getText(self)
end


function UIText:dispose()
	self._parentSize = nil
	self._align = nil
	self._valign = nil
	self._padding = nil

	--self:dispose()
	if (self:isRichText()) then
		RichText.dispose(self)
	else
		UISimpleText.dispose(self)
	end
	self:release()
end

return UIText