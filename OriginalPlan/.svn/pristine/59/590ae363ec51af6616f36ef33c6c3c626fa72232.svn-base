--[[
class: UISimpleText
inherit: XSprite
desc: 创建图片。 可以添加文字
author：changao
date: 2014-06-03
example：

]]--


local UISimpleText = class("UISimpleText", function () return display.newNode() end)


function UISimpleText:ctor(width, height, fontSize, fontName, fontColor, align, valign, shadow, outline)
	self:retain()
	--print("function UISimpleText:ctor(width, height, fontSize, fontName, fontColor, align, valign, shadow)",
	--	width, height, fontSize, fontName, fontColor, align, valign, shadow)
	self._textInfo = {fontSize=fontSize, fontName=fontName, fontColor=fontColor, align=align, valign=valign, shadow=shadow, useRTF=false, outline=outline}
	self._size = CCSize(width, height)
	self:setContentSize(self._size)
	self:setAnchorPoint(ccp(0, 0))
end

function UISimpleText:setShadow(flag)
	self._textInfo.shadow = falg
	if self._textInfo.shadow then
		self._textInfo.outline = false
	end
end

function UISimpleText:setOutline(flag)
	self._textInfo.outline = falg
	if self._textInfo.outline then
		self._textInfo.shadow = false
	end
end

--[[
@brief 构造 设置文字
@param text string
@param fontSize int 文字字体大小
@param fontName string 字体名称
@param fontColor ccc3 字体颜色
@param align UIInfo.alignment 水平对齐方式
@param valign UIInfo.alignment 竖直对齐方式
@param useRTF 使用富文本
@param shadow 阴影
@param outline 描边 注意 outline和shadow冲突， 无法同时为true。
]]--
function UISimpleText:setText(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
--	print("function UISimpleText:setText(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow)", 
--		text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline, ")")
--(text, fontSize, fontName, fontColor, useRTF, shadow)
	local textParent = self
	if not self._textInfo then
		self._textInfo = {fontSize=fontSize, fontName=fontName, fontColor=fontColor, align=align, valign=valign, useRTF=useRTF, shadow=shadow, outline=outline}
	else
		UIInfo.setTextInfo(self._textInfo, text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	end
	
	if not text or text == "" then
		self:clearText()
		return
	end
	
	if not self._text then
		local textnode = UIAttachText.new(self._size.width, self._size.height, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor, self._textInfo.useRTF, self._textInfo.shadow, self._textInfo.outline)
		
		textParent:addChild(textnode)
		self._text = textnode
		
		if self._text:isRichText() then
			self._text:setAlignment(self._textInfo.align, self._textInfo.valign)
		end
		
		self._text:setText(text)
	else
		self._text:setText(text, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor)
	end
	
	-- align
	if not self._text:isRichText() then
		self._text:setAlignInParent(textParent, self:getContentSize(), self._textInfo.align, self._textInfo.valign)
	end
end

function UISimpleText:clearText()
	if self._text then
		self._text:dispose()
		self._text = nil
	end
end

function UISimpleText:setColor(color)
	if self._textInfo then
		self._textInfo.fontColor = color
	end
	if self._text then
		self._text:setColor(color)
	end
end

--[[
@brief 获取文字内容
@return string 返回的文字
]]--
function UISimpleText:getText()
	if not self._text then
		return nil
	end
	
	return self._text:getText()
end

--[[
@brief 获取文字节点
@return string 返回的文字
]]--
function UISimpleText:getTextNode()
	return self._text
end

function UISimpleText:dispose()
	self:removeFromParent()
	if self._text then
		self._text:dispose()
		self._text = nil
	end
	
	self._textInfo = nil
	self._size = nil
	
	self:release()
end

return UISimpleText