--[[
class: UIClipImage
inherit: XSprite
desc: 创建图片。 可以添加文字
author：changao
date: 2014-06-03
example：
	local image = UIClipImage.new("#button.png", CCSize(200, 180), true)
	image:setText("long long ago", 15, nil, ccc3(255, 255, 255), UIInfo.alignment.center, UIInfo.alignment.center)	
	image:setNewImage("#button_down.png")
	local textString = image:getText()
	print(textString)
]]--


local UIClipImage = class("UIClipImage", function (argTable) return display.newXClipSprite() end)


function UIClipImage:ctor(imageUrl, maskUrl, size)
	self:retain()
	
	if imageUrl and imageUrl ~= "" and imageUrl ~= maskUrl then
		self:setSpriteImage(imageUrl, maskUrl, false)
	end
	self._imageUrl = imageUrl
	self._maskUrl = maskUrl
	
	self._csize = self:getContentSize()
	if size then
		self._size = size
		self:_setImageSize(size)
	else
		self._size = CCSize(self._csize.width, self._csize.height)
	end
	self:setAnchorPoint(ccp(0, 0))
--[[
	node:setSpriteImage(url, "#com_renwu_activity_4_a.png", true)
	local siz = node:getContentSize()
	node:setAnchorPoint(ccp(0.5, 0.5))
	local parentSize = parent:getContentSize()
	node:setPosition(ccp(parentSize.width/2, parentSize.height/2))
	node:setScale(parentSize.width/siz.width)
--]]
end

function UIClipImage:clone()
	local img = UIClipImage.new(self._imageUrl, self._maskUrl, self._size)
	img:setAnchorPoint(ccp(0,0))
	return img
end

function UIClipImage:updateSize(siz)
	if self._size:equals(siz) then return end
	self._size = siz
	self:_setImageSize(siz)
end

function UIClipImage:_setImageSize(size)
--[[
	if UIInfo.image.clip[self._imageUrl] then
		local csize = self:getContentSize()
		if csize.width > size.width and csize.height > siz.height then
			self:setClipRect(CCRect(0,0,size.width, size.height))
		else
			self:setImageSize(size)
		end
	else
		self:setImageSize(size)
	end
	--]]
	self:setScaleX(size.width/self._csize.width)
	self:setScaleY(size.height/self._csize.height)
end



--[[
@brief set new image. not use setImage, because of name repeat
@param text string
]]--
function UIClipImage:setNewImage(imageUrl, maskUrl)
	if self._imageUrl == imageUrl and (self._maskUrl == maskUrl or maskUrl == nil) then return end
	self._imageUrl = imageUrl
	if type(maskUrl) == 'string' then
		self._maskUrl = maskUrl
	end
	self:setSpriteImage(imageUrl, self._maskUrl, false)
	
--[[
	if not size:equals(self._size) then
		self:_setImageSize(size)
	end
--]]
end

function UIClipImage:setGray(falg)
	if falg then
		ShaderMgr:setColor(self)
	else
		ShaderMgr:removeColor(self)
	end
end

--[[
@brief 
@param text string

function UIClipImage:setImage(imageUrl)
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
function UIClipImage:setText(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
--(text, fontSize, fontName, fontColor, useRTF, shadow)
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

--[[
@brief 获取文字内容
@return string 返回的文字
]]--
function UIClipImage:getText()
	if not self._text then
		return nil
	end
	
	return self._text:getText()
end

--[[
@brief 获取文字节点
@return string 返回的文字
]]--
function UIClipImage:getTextNode()
	return self._text
end


function UIClipImage:dispose()
	self:removeFromParent()
	self:clearImage()
	
	if self._text then
		self._text:dispose()
		self._text = nil
	end
	
	self._imageUrl = nil
	self._maskUrl = nil
	self._textInfo = nil
	self._size = nil
	
	self:release()
end

return UIClipImage