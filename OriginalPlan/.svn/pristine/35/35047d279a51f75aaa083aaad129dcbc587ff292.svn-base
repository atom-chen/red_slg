--[[
class: UIImage
inherit: XSprite
desc: 创建图片。 可以添加文字
author：changao
date: 2014-06-03
example：
	local image = UIImage.new("#button.png", CCSize(200, 180), true)
	image:setText("long long ago", 15, nil, ccc3(255, 255, 255), UIInfo.alignment.center, UIInfo.alignment.center)
	image:setNewImage("#button_down.png")
	local textString = image:getText()
	print(textString)
]]--


local UIImage = class("UIImage", function (argTable) return display.newXSprite() end)


function UIImage:ctor(imageUrl, size, isSTensile)
	self:retain()

	self:setSpriteImage(imageUrl)
	self._isSTensile = isSTensile
	self._imageUrl = imageUrl
		--uihelper.getRect()
	if self._isSTensile then
		uihelper.setRect9(self, imageUrl)
	end

	if size then
		self._size = size
		self:_setImageSize(size)
	else
		self._size = self:getContentSize()
	end

	self:setAnchorPoint(ccp(0, 0))
end

function UIImage:touchContains(x, y)
	local parent = self:getParent()
	local pos = parent:convertToNodeSpace(ccp(x,y))
	local rect = self:getTouchRect()
	if rect:containsPoint(pos) then
		return true
	else
		return false
	end
end

function UIImage:getTouchRect()
	local rect = self:boundingBox()
	return rect
end


function UIImage:clone()
	local img = UIImage.new(self._imageUrl, self._size, self._isSTensile)
	img:setAnchorPoint(ccp(0,0))
	return img
end

function UIImage:updateSize(siz)
	if self._size:equals(siz) then return end
	self._size = siz
	self:_setImageSize(siz)
	if self._text then
		if not self._text:isRichText() then
			self._text:setAlignInParent(textParent, self:getContentSize(), self._textInfo.align, self._textInfo.valign)
		end
	end
end

function UIImage:getImageUrl()
	return self._imageUrl
end

function UIImage:getSize()
	return self._size
end

function UIImage:_setImageSize(size)
	if UIInfo.image.clip[self._imageUrl] then
		local csize = uihelper.getOriginalSize(self._imageUrl)
		if csize and csize.width > size.width and csize.height > siz.height then
			self:setClipRect(CCRect(0,0,size.width, size.height))
		else
			self:setImageSize(size)
		end
	else
		self:setImageSize(size)
	end
end


--[[
@brief 设置新的图片。 且如果构造的时候设置了isSTensile， 那么新image的大小会设置为旧的那么大。
@param text string
]]--
function UIImage:setNewImage(imageUrl, noFitSize)
	if self._imageUrl == imageUrl and not noFitSize then return end
	self:setSpriteImage(imageUrl)
	self._imageUrl = imageUrl
	local size = self:getContentSize()

	self._noFitSize = tobool(noFitSize)
	if noFitSize then
		self._size = size
		return
	end

	if self._isSTensile then
		uihelper.setRect9(self, imageUrl)
	end
	if not size:equals(self._size) then
		self:_setImageSize(self._size)
	end
end

function UIImage:setGray(falg)
	if falg then
		ShaderMgr:setColor(self)
	else
		ShaderMgr:removeColor(self)
	end
end

--[[
@brief 设置新的图片。 且如果构造的时候设置了isSTensile， 那么新image的大小会设置为旧的那么大。
@param text string

function UIImage:setImage(imageUrl)
	return self:setNewImage(imageUrl)
end
]]--
--[[
@brief 构造 设置文字
@param text string
@param fontSize int 文字字体大小
@param fontName string 字体名称
@param fontColor ccc3 字体颜色
@param align UIInfo.alignment 水平对齐方式
@param valign UIInfo.alignment 竖直对齐方式
]]--
function UIImage:setText(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	--print(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	local textParent = self
	if not self._textInfo then
		self._textInfo = {fontSize=fontSize, fontName=fontName, fontColor=fontColor, align=align, valign=valign, useRTF=useRTF, shadow=shadow, outline=outline}
	else
		UIInfo.setTextInfo(self._textInfo, text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	end

	if not text or text == "" then
		if not self._text then return end
		self._text:removeFromParent()
		self._text:dispose()
		self._text = nil
		return
	end

	if not self._text then
		local textnode = UIAttachText.new(self._size.width, self._size.height, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor, self._textInfo.useRTF, self._textInfo.shadow, self._textInfo.outline)

		textParent:addChild(textnode)
		self._text = textnode

		if self._text:isRichText() then
			self._text:setAlign(self._textInfo.align)
			self._text:setAlign(self._textInfo.valign)
		end

		self._text:setText(text)
	else
		self._text:setText(text, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor)
	end

	--	print("	if not self._text:isRichText() then", self._text:isRichText())
	if not self._text:isRichText() then
		self._text:setAlignInParent(textParent, self:getContentSize(), self._textInfo.align, self._textInfo.valign)
	end
	if self._text then
		self._text:setPadding(self._textInfo.padding, true)
	end
end

function UIImage:setTextPadding(padding)
	if not self._textInfo then
		self._textInfo = {}
	end
	self._textInfo.padding = padding

	if self._text then
		self._text:setPadding(padding, true)
	end
end

--[[
@brief 获取文字内容
@return string 返回的文字
]]--
function UIImage:getText()
	if not self._text then
		return nil
	end

	return self._text:getText()
end

--[[
@brief 获取文字节点
@return string 返回的文字
]]--
function UIImage:getTextNode()
	return self._text
end

--[[
@brief 清除图片
@param canRecover boolean 是否可以通过 recoverImage 恢复原装

function UIImage:clearImage(canRecover)
	self:setSpriteImage(nil)
	if canRecover then
		self._canRecover = true
	else
		self._imageUrl = nil
	end
end
--]]
--[[
@brief 恢复图片
--]]
function UIImage:recoverImage()
	--assert(self._canRecover, "UIImage:clearImage(canRecover) canRecover must be true")
	if self._imageUrl then
		self:setSpriteImage(self._imageUrl)
		local siz = self:getContentSize()
		if not siz:equals(self._size) then
			self:setImageSize(siz)
		end
	end
end

function UIImage:dispose()
	self:removeFromParent()
	self:clearImage()

	if self._text then
		self._text:dispose()
		self._text = nil
	end

	self._imageUrl = nil
	self._textInfo = nil
	self._isSTensile = nil
	self._size = nil

	self:release()
end

return UIImage