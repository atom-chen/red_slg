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


function UIImage:ctor(imageurl, size, isSTensile)
	self:setSpriteImage(imageurl)
	self._isSTensile = isSTensile
	if isSTensile and size then
		self._size = size
		self:setImageSize(size)
	else
		self._size = self:getImgSize()
	end
	self:setAnchorPoint(ccp(0, 0))
	self:retain()
end

--[[
@brief 设置新的图片。 且如果构造的时候设置了isSTensile， 那么新image的大小会设置为旧的那么大。 
@param text string
]]--
function UIImage:setNewImage(imageurl)
	self:setSpriteImage(imageurl)
	if self._isSTensile and self._size then
		if self._size ~= self:getImgSize() then
			self:setImageSize(self._size)
		end
	else
		self._size = self:getImgSize()
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
]]--
function UIImage:setText(text, fontSize, fontName, fontColor, align, valign)
	if not text or text == "" then
		if not self._text then return end
		self.removeChild(self._text)
		self._text:dispose()
		self._text = nil
		return
	end
	
	if not self._text then
		local text = UIAttachText.new(text, fontSize, fontName, fontColor)
		
		self:addChild(text)
		text:setAlignInParent(self, self:getContentSize(), align, valign)
		self._text = text
	else
		self._text.setText(text, fontSize, fontName, fontColor)
		if align and valign then
			self._text:setAlignInParent(self, self:getContentSize(), align, valign)
		end
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
	
	return self._text.getText()
end

function UIImage:dispose()
	if self._text then
		self._text:dispose()
		self._text = nil
	end
	
	self._isSTensile = nil
	self._size = nil
	self:release()
end

return UIImage