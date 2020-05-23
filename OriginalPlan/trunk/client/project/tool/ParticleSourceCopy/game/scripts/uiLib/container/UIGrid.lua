--[[
class: UIGrid
inherit: CClayer
desc: 创建按钮。
author：changao
date: 2014-06-03
event:
	Event.MOUSE_DOWN
	Event.MOUSE_MOVE
	Event.MOUSE_CLICK
	Event.MOUSE_UP
	Event.MOUSE_CANCEL
example：
	local btn = UIGrid.new("#button.png", CCSize(200, 180), true)
	btn:setText("long long ago", 15, nil, ccc3(255, 255, 255), UIInfo.alignment.center, UIInfo.alignment.center)	
	btn:setEnlarge(true)
	local textString = btn:getText()
	print(textString)
--]]

local UIGrid = class("UIGrid", TouchBase)

UIGrid._ZBG = 1
UIGrid._ZIMAGE = 2
UIGrid._ZBORDER = 3

--[[
@brief 创建一个格子。 其中格子由上而下包含 border, image, background-image.
@param size CCSize 如果为nil, 则从border， image和background-image 选择最大的 width 和 height 作为 size。若都没设置， 则选择 CCSize(82,82)作为size
@param images array string image[1]:border; image[2]:image; image[3]:bgground
--]]

function UIGrid:ctor(size, images, priority,swallowTouches)
	print(images[1], images[2])
	
	TouchBase.ctor(self,priority,swallowTouches)
	EventProtocol.extend(self)
	self._imageInfo = {imageBorder=images[1], image=images[2], imageBg=images[3], imageRect9=false, borderRect9=false}
	self._eventInfo = {enable=false, shrink=false}

	local itemSize = size
	if self._imageInfo.imageBorder then
		self._imageBorder = display.newXSprite(self._imageInfo.imageBorder)
		self._imageBorder:retain()
		self._imageBorder:setAnchorPoint(ccp(0.5,0.5))
		self:getContainer():addChild(self._imageBorder, UIGrid._ZBORDER)
		if not size then
			local borderSize = self._imageBorder:getImgSize()
			itemSize = borderSize
		end
	end

	
	if self._imageInfo.image then
		self._image = display.newXSprite(self._imageInfo.image)
		self._image:retain()
		self._image:setAnchorPoint(ccp(0.5,0.5))
		self:getContainer():addChild(self._image, UIGrid._ZIMAGE)
		if not size then
			local imageSize = self._image:getImgSize()
			if not itemSize then 
				itemSize = imageSize 
			else
				itemSize.width, itemSize.height = math.max(itemSize.width, imageSize.width), math.max(itemSize.height, imageSize.height)
			end
		end
	end
	
	if self._imageInfo.imageBg then
		self._imageBg = display.newXSprite(self._imageInfo.imageBg)
		self._imageBg:retain()
		self._imageBg:setAnchorPoint(ccp(0.5,0.5))
		self:getContainer():addChild(self._imageBg, UIGrid._ZBG)
		if not size then
			local imageBgSize = self._imageBg:getImgSize()
			if not itemSize then 
				itemSize = imageBgSize 
			else
				itemSize.width, itemSize.height = math.max(itemSize.width, imageBgSize.width), math.max(itemSize.height, imageBgSize.height)
			end
		end
	end
	
	if not itemSize then
		itemSize = CCSize(82, 82)
	end

	self._size = itemSize
	self:setAnchorPoint(ccp(0.5, 0.5))
	self:setContentSize(itemSize)

	self:getContainer():setAnchorPoint(ccp(0.5, 0.5))
	self:getContainer():setPosition(itemSize.width/2, itemSize.height/2)
	
--[[
	self._imageBorder:addChild(self._image)
	
	self:addChild(self._imageBorder)
	
	
	

	self._image:setPosition(sizeImage.width/2,sizeImage.height/2)
	self._imageBorder:setPosition(sizeBorder.width/2,sizeBorder.height/2)

	
	self._size = sizeImage
	self._sizeBorder = sizeBorder
	print("image size: ", sizeImage.width, sizeImage.height)
	print("border size: ", sizeBorder.width, sizeBorder.height)
	--]]
	--self:setAnchorPoint(ccp(0, 0))
	print("size:", itemSize.width, ",", itemSize.height)
	function pp(p) 	
		print(p.x, p.y) 
	end
	local node = self:getContainer()
	local anchor = node:getAnchorPoint()
	local x,y = node:getPosition()
	local pos = ccp(x, y)
	print(type(pos), ":", pos)
	local worldpos = node:convertToWorldSpace(ccp(x,y))
	pp(anchor)
	pp(pos)
	pp(worldpos)
	self:touchEnabled(true)
	self:retain()
end



function UIGrid:getContainer()
	if self._container then return self._container end
	self._container = display.newNode()
	self:addChild(self._container)
	return self._container
end

function UIGrid:removeContainer()
	if not self._container then return end
	self._container:removeAllChildren()
	self._container:release()
	self._container = nil
end

function UIGrid:updateSize(size)
	if not size then return end
	self._size = size
	self:setContentSize(size)

	--[[
	local array = self:getContainer():getChildren()
	local pos = ccp(size.width/2, size.height/2)
	for i = 0, array:count() - 1 do
		self:setPosition(pos)
	end
	--]]
end
--[[ cannot set size
--设置 大小  isRect9  是否是9宫格拉伸    一般都是9宫格拉伸
function UIGrid:setImageSize(imageSize,isImageRect9)
	if not imageSize then return end
	
	if isImageRect9 ~= nil then
		self._imageInfo.imageRect9 = tobool(isImageRect9)
	end
	local curSize = self._size
	if not curSize:equals(imageSize) then
		self._size = imageSize
		self:_updateImageSize()
	end
end


--设置 大小  isRect9  是否是9宫格拉伸    一般都是9宫格拉伸
function UIGrid:setBorderSize(bordreSize,isBorderRect9)
	if not bordreSize then return end
	
	if isBorderRect9 ~= nil then
		self._imageInfo.imageBorderRect9 = tobool(isBorderRect9)
	end
	local curSize = self._sizeBorder
	if not curSize:equals(imageSize) then
		self._sizeBorder = bordreSize
		self:setContentSize(bordreSize)
		self:_updateBorderSize()
	end
end
--]]

--[[
@brief 设置 button 的激活状态
@param flag boolean 
--]]
function UIGrid:setEnable(flag)
	if tobool(flag) ~= self._eventInfo.enable then
		self._eventInfo.enable = tobool(flag)
	end
end

--[[
@brief 设置 格子内的图片
@param imageUrl string 
--]]
function UIGrid:setImage(imageUrl)
	if self._imageInfo.image ~= imageUrl then
		self._imageInfo.image = imageUrl
		if not self._image then
			self._image = display.newXSprite(imageUrl)
			self._image:retain()
			self._image:setAnchorPoint(ccp(0.5,0.5))
			self:getContainer():addChild(self._image, UIGrid._ZIMAGE)
		else
			self._image:setImage(imageUrl)
		end
	end
end

--[[
@brief 设格子border的图片
@param borderImageUrl string 
--]]
function UIGrid:setBorder(borderImageUrl)
	if self._imageInfo.imageBorder ~= borderImageUrl then
		self._imageInfo.imageBorder = borderImageUrl
		if not self._imageBorder then
			self._imageBorder = display.newXSprite(borderImageUrl)
			self._imageBorder:retain()
			self._imageBorder:setAnchorPoint(ccp(0.5,0.5))
			self:getContainer():addChild(self._imageBorder, UIGrid._ZBORDER)
		else
			self._imageBorder:setImage(borderImageUrl)
		end
	end
end

--[[
@brief 设格子背景的图片
@param borderImageUrl string 
--]]
function UIGrid:setBgImage(bgImageUrl)
	if self._imageInfo.imageBg ~= bgImageUrl then
		self._imageInfo.imageBg = bgImageUrl
		if not self._imageBg then
			self._imageBg = display.newXSprite(bgImageUrl)
			self._imageBg:retain()
			self._imageBg:setAnchorPoint(ccp(0.5,0.5))
			self:getContainer():addChild(self._imageBg, UIGrid._ZBG)
		else
			self._imageBg:setImage(self._imageInfo.image)
		end
	end
end

--[[
@brief 重置精灵的图像到初始状态
--]]
function UIGrid:_imageReset()
	if self._eventInfo.shrink then
		self._eventInfo.shrink = false
		UIAction.shrinkRecover(self:getContainer());
	end
	self._eventInfo.began = false
	self._eventInfo.leave = true
end

--[==[
--[[
@brief 更新图像大小
--]]
function UIGrid:_updateImageSize()
	if self._imageSize then
		self._image:setImageSize(self._imageSize)
		self._image:setPosition(ccp(self._imageSize.width/2, self._imageSize.height/2))
		if self._imageInfo.imageRect9 then  --支持9宫格拉伸
			local rect = uihelper.getRect(self._imageInfo.image)  --获取9宫 rect
			if not rect then return end
			self._image:setRect9(rect)
		end
	end
end

--[[
@brief 更新图像大小
--]]
function UIGrid:_updateBorderSize()
	if self._size then
		self._imageBorder:setImageSize(self._sizeBorder)
		self._imageBorder:setPosition(ccp(self._sizeBorder.width/2, self._sizeBorder.height/2))
		if self._imageInfo.imageBorderRect9 then  --支持9宫格拉伸
			local rect = uihelper.getRect(self._imageInfo.imageBorder)  --获取9宫 rect
			if not rect then return end
			self._imageBorder:setRect9(rect)
		end
	end
end



--[[
@brief 更新图像内容
@param imageurl string 图像的内容
--]]
function UIGrid:_updateImage(imageUrl)
	if self._imageInfo.image ~= imageUrl then
		self._imageInfo.image  = imageUrl
		self._image:setSpriteImage(imageUrl)
		self:_updateImageSize()
	end
end

--[[
@brief 更新border内容
@param imageBorderUrl string 图像的内容
--]]
function UIGrid:_updateBorder(imageBorderUrl)
	if self._imageInfo.imageBorder ~= imageBorderUrl then
		self._imageInfo.imageBorder  = imageBorderUrl
		self._image:setSpriteImage(imageBorderUrl)
		self:_updateBorderSize()
	end
end
--]==]

--[[
@brief 获取响应区域
@param imageurl string 图像的内容
--]]
function UIGrid:getTouchRect()
	local size = self._size
	--local pos = self._image:getPosition()
	return {x=0,y=0,width=size.width,height=size.height}
end

--[[
@brief 触屏（鼠标） began 事件响应
@param x float 世界坐标系的x
@param y float 世界坐标系的y
@return boolean 返回是否接受后续事件
--]]
function UIGrid:onTouchDown(x,y)
	if not self._eventInfo.enable then
		return false
	end
	
	self._eventInfo.shrink = true
	--UIAction.shrinkScale(self._imageBorder, 0.95);
	transition.scaleTo(self:getContainer(), {time=0.05, scale=0.98})
	self:dispatchEvent({name = Event.MOUSE_DOWN,target = self.content})
	return true
end

--[[
@brief 触屏（鼠标） end 事件响应
@param x float 世界坐标系的x
@param y float 世界坐标系的y
@return boolean
--]]
function UIGrid:onTouchUp(x,y)
	self:_imageReset()
	self:dispatchEvent({name = Event.MOUSE_UP,target = self})
	self:dispatchEvent({name = Event.MOUSE_CLICK,target = self})
end

--[[
@brief 触屏（鼠标） cancel 事件响应
@param x float 世界坐标系的x
@param y float 世界坐标系的y
@return boolean
--]]
function UIGrid:onTouchCanceled(x,y)
	self:_imageReset()
	self:dispatchEvent({name = Event.MOUSE_CANCEL,target = self})
end


--[[
@brief 构造 设置文字
@param text string
@param fontSize int 文字字体大小
@param fontName string 字体名称
@param fontColor ccc3 字体颜色
@param align UIInfo.alignment 水平对齐方式 默认UIInfo.alignment.RIGHT
@param valign UIInfo.alignment 竖直对齐方式 默认UIInfo.alignment.BOTTOM
--]]
function UIGrid:setText(text, fontSize, fontName, fontColor, align, valign)
	if not text or text == "" then
		if not self._text then return end
		self.removeChild(self._text)
		self._text:dispose()
		self._text = nil
		return
	end
	
	if not self._image then return end
	if not self._text then
		print("text:", text)
		local text = UIAttachText.new(text, fontSize, fontName, fontColor)
		
		self._image:addChild(text, 0)
		
		local alignment = align or UIInfo.alignment.RIGHT
		local valignment = align or UIInfo.alignment.BOTTOM
		text:setPadding(8)
		text:setAlignInParent(self, self:getContentSize(), alignment, valignment)
		self._text = text
	else
		self._text:setText(text, fontSize, fontName, fontColor)
		if align and valign then
			self._text:setAlignInParent(self, self:getContentSize(), align, valign)
		end
	end
end

--[[
@brief 获取文字内容
@return string 返回的文字
--]]
function UIGrid:getText()
	if not self._text then
		return nil
	end
	
	return self._text.getText()
end

function UIGrid:dispose()
	self._imageInfo = nil
	self._eventInfo = nil
	self._size = nil
	
	if self._text then
		self._text:dispose()
		self._text = nil
	end	
	
	self:removeContainer()
	self:removeAllChildren()
	
	if not self._imageBorder then
		self._imageBorder:release()
		self._imageBorder = nil
	end
	if not self._image then
		self._image:release()
		self._image = nil
	end
	if not self._imageBg then
		self._imageBg:release()
		self._imageBg = nil
	end
	
	self:release()
	TouchBase.dispose(self)
end

return UIGrid