--[[
class: UIGrid
inherit: CClayer
desc: 创建格子。
author：changao
date: 2014-06-03
event:
	Event.MOUSE_DOWN
	Event.MOUSE_MOVE
	Event.MOUSE_CLICK
	Event.MOUSE_UP
	Event.MOUSE_CANCEL
example：
	local grid = UIGrid.new(CCSize(200, 180))
	grid:setImage("#2.png")
	grid:setBorder("#1.png")
	grid:setBgImage("#3.png")
	grid:setEnable(true)
	grid:setAutoInset(true)
	grid:addEventListener(Event.MOUSE_CLICK, callback)
--]]

local UIGrid = class("UIGrid", TouchBase)

UIGrid._ZBG			= 1
UIGrid._ZIMAGE		= 5
UIGrid._ZUPIMAGE	= 9
UIGrid._ZBORDER		= 13
UIGrid._ZUPBORDER	= 14
UIGrid._ZTOP		= 17
--[[
@brief 创建一个格子。 其中格子由上而下包含 border, image, background-image.
@param size CCSize 如果为nil, 则从border， image和background-image 选择最大的 width 和 height 作为 size。若都没设置， 则选择 CCSize(82,82)作为size
@param images array string image[1]:border; image[2]:image; image[3]:bgground

--]]
UIGrid.num = 0

function UIGrid:ctor(size, images, priority, swallowTouches,isEnabled)
--[[
	UIGrid.num = UIGrid.num +1
	print("创建格子数量：", UIGrid.num)
--]]
	self:retain()
	TouchBase.ctor(self,priority,swallowTouches,isEnabled)

	EventProtocol.extend(self)
	UIUserDataProtocol.extend(self)

	if images then
		self._imageInfo = {imageBorder=images[1], image=images[2], imageBg=images[3], imageRect9=false, borderRect9=false}
	else
		self._imageInfo = {imageRect9=false, borderRect9=false}
	end

	self._eventInfo = {enable=tobool(isEnabled), shrink=false}

	local itemSize = size
	if self._imageInfo.imageBorder then
		self._imageBorder = display.newXSprite(self._imageInfo.imageBorder)
		self._imageBorder:retain()
		self._imageBorder:setAnchorPoint(ccp(0.5,0.5))
		self:getContainer():addChild(self._imageBorder, UIGrid._ZBORDER)
		if not size then
			local borderSize = self._imageBorder:getContentSize()
			itemSize = borderSize
		end
	end

	if self._imageInfo.image then
		self._image = display.newXSprite(self._imageInfo.image)
		self._image:retain()
		self._image:setAnchorPoint(ccp(0.5,0.5))
		self:getContainer():addChild(self._image, UIGrid._ZIMAGE)
		if not size then
			local imageSize = self._image:getContentSize()
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
			local imageBgSize = self._imageBg:getContentSize()
			if not itemSize then
				itemSize = imageBgSize
			else
				itemSize.width, itemSize.height = math.max(itemSize.width, imageBgSize.width), math.max(itemSize.height, imageBgSize.height)
			end
		end
	end

	if not itemSize then
		itemSize = CCSize(90, 90)
	end

	self._size = itemSize
	self:setAnchorPoint(ccp(0.5, 0.5))
	self:setContentSize(CCSize(itemSize.width, itemSize.height*1))

	self:getContainer():setAnchorPoint(ccp(0.5, 0.5))
	self:getContainer():setPosition(itemSize.width/2, itemSize.height*(0.5+0))

	self:setAutoInset(true, true)
	self:setShrinkEnable(true)
	self:touchEnabled(self._eventInfo.enable)

end


function UIGrid:setShrinkEnable(enable)
	self._shrinkEnable = tobool(enable)
end

function UIGrid:getSize()
	return self._size
end

function UIGrid:getBottomHeight()
	return self._size.height*0
end

function UIGrid:setAutoInset(enable, update)
	self._autoInsetEnable = tobool(enable)
	if update then
		self:setBgImageInset()
		self:setImageInset()
		self:setBorderInset()
	end
end

function UIGrid:getContainer()
	if self._container then return self._container end
	self._container = display.newNode()
	self._container:retain()
	self:addChild(self._container)
	return self._container
end

function UIGrid:removeContainer()
	if not self._container then return end
	self._container:release()
	self._container = nil
end

function UIGrid:updateSize(size)
	if not size then return end
	self._size = size
	self:setContentSize(size)
	self:updateLevelNodeSize()
	self:updateStarSize()
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
@brief 设置 grid 的激活状态
@param flag boolean
--]]
function UIGrid:setEnable(flag)
	if tobool(flag) ~= self._eventInfo.enable then
		self._eventInfo.enable = tobool(flag)
		self:touchEnabled(tobool(flag))
	end
end

function UIGrid:setGray(flag)
	if tobool(self._isgrey) ~= tobool(flag) then
		self._isgrey = tobool(flag)
		local fun
		if self._isgrey then
			fun = function (sp) if sp then ShaderMgr:setColor(sp) end end
		else
			fun = function (sp) if sp then ShaderMgr:removeColor(sp) end end
		end

		fun(self._image)
		fun(self._imageBg)
		fun(self._imageBorder)
		fun(self._skillTagImg)
	end
end

function UIGrid:isGray()
	return tobool(self._isgrey)
end

--[[
@brief 设置 格子内的图片
@param imageUrl string
--]]
function UIGrid:setImage(imageUrl, x, y)
	if self._imageInfo.image ~= imageUrl then
		self._imageInfo.image = imageUrl
		if not self._image and imageUrl then
			self._image = display.newXSprite(imageUrl)
			self._image:retain()
			self._image:setAnchorPoint(ccp(0.5,0.5))
			self:getContainer():addChild(self._image, UIGrid._ZIMAGE)
			if self._isgrey then
				ShaderMgr:setColor(self._image)
			end
			if x then
				self._image:setPositionX(x)
			end
			if y then
				self._image:setPositionY(y)
			end
		else
			print("function UIGrid:setImage(imageUrl, x, y)", self._imageInfo.image)
			self._image:setSpriteImage(self._imageInfo.image)
		end
		if self._autoInsetEnable then
			self:setImageInset()
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
		if not self._imageBorder and borderImageUrl then
			self._imageBorder = display.newXSprite(borderImageUrl)
			self._imageBorder:retain()
			self._imageBorder:setAnchorPoint(ccp(0.5,0.5))
			self:getContainer():addChild(self._imageBorder, UIGrid._ZBORDER)
			if self._isgrey then
				ShaderMgr:setColor(self._imageBorder)
			end
		else
			self._imageBorder:setSpriteImage(self._imageInfo.imageBorder)
		end
		if self._autoInsetEnable then
			self:setBorderInset()
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
		if not self._imageBg and bgImageUrl then
			self._imageBg = display.newXSprite(bgImageUrl)
			self._imageBg:retain()
			self._imageBg:setAnchorPoint(ccp(0.5,0.5))
			self:getContainer():addChild(self._imageBg, UIGrid._ZBG)
			if self._isgrey then
				ShaderMgr:setColor(self._imageBg)
			end
		else
			self._imageBg:setSpriteImage(self._imageInfo.imageBg)
		end
		if self._autoInsetEnable then
			self:setBgImageInset()
		end
	end
end

--[[
@brief 设置图片大小为格子大小
@param sp xsprite
--]]
function UIGrid:updateImageSize(sp)
	local siz = sp:getContentSize()
	if siz:equals(self._size) then
		return
	end

	sp:setImageSize(self._size)
end

function UIGrid:setInsetBorder(pixel)
	self._insetBorder = pixel or 8
end

--[[
@brief 设置图片大小不大于格子大小
@param sp xsprite
--]]
function UIGrid:setInset(sp)
	local siz = sp:getContentSize()
	local w, h = siz.width, siz.height

	local iw = self._insetBorder or 8
	if w + iw > self._size.width then
		w = self._size.width - iw
	end

	if h + iw > self._size.height then
		h = self._size.height - iw
	end

	if w == siz.width and h == siz.height then
		return
	end
	--print('UIGrid:setInset(sp)', siz.width, siz.height, "Grid", self._size.width, self._size.height, " new", w, h)
	sp:setImageSize(CCSize(w, h))
end

function UIGrid:setImageInset()
	if self._image then
		self:setInset(self._image)
	end
end

function UIGrid:setBgImageInset()
	if self._imageBg then
		self:updateImageSize(self._imageBg)
	end
end

function UIGrid:setBorderInset()
	if self._imageBorder then
		self:updateImageSize(self._imageBorder)
	end
end

--[[
@brief 获取格子边框的图片
@param borderImageUrl string
--]]
function UIGrid:getBorder()
	return self._imageInfo.imageBorder
end

--[[
@brief 获取格子背景的图片
@param borderImageUrl string
--]]
function UIGrid:getImage()
	return self._imageInfo.image
end

--[[
@brief 获取格子背景的图片
@param borderImageUrl string
--]]
function UIGrid:getBgImage()
	return self._imageInfo.imageBg
end


--[[
@brief 重置精灵的图像到初始状态
--]]
function UIGrid:_imageReset(onComplete)
	if self._eventInfo.shrink then
		self._eventInfo.shrink = false
		UIAction.shrinkRecover(self:getContainer(), onComplete)
	else
		if onComplete then onComplete() end
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
	local rect = self:boundingBox()
	return rect
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
	if self._shrinkEnable then
		self._eventInfo.shrink = true
		--UIAction.shrinkScale(self._imageBorder, 0.95);
		transition.scaleTo(self:getContainer(), {time=0.05, scale=0.98})
	end

	self:dispatchEvent({name = Event.MOUSE_DOWN,target=self})
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

function UIGrid:onTouchEnd(x,y)
	self:dispatchEvent({name = Event.MOUSE_END,target = self})
end


function UIGrid:setNumberText(text, color)
	self:setBottomText(text, UIInfo.alignment.right, color)
end

function UIGrid:getOffset(w)
	local offset = 3
	if self._size.width >= 50 then
		local val = math.floor((self._size.width-40)/10)
		offset = offset + val
		--[[
		if offset > 10 then
			offset = 10
		end
		--]]
	end
	return offset
end

function UIGrid:getHOffset()
	local offset = 6
	if self._size.width >= 50 then
		local val = math.floor((self._size.width-40)/10)
		offset = offset + val
		--[[
		if offset > 10 then
			offset = 10
		end
		--]]
	end
	return offset
end

function UIGrid:getVOffset()
	return self:getOffset()
end


function UIGrid:getFontSize()
	local fontSize = 16
	if self._size.width >= 50 then
		local val = math.floor((self._size.width-40)/10)
		fontSize = fontSize + val
		if fontSize > 24 then
			fontSize = 24
		end
	end
	-- print("function UIGrid:getFontSize()", fontSize)
	return fontSize
end


--[[
@brief 格子上方显示内容
@param text string
@param align UIInfo.align
--]]
function UIGrid:setTopText(text, align)
	--print("function UIGrid:setNumberText(text)",text)
	local textParent = self:getContainer()

	if not text or text == "" then
		if not self._text then return end
		self._text:dispose()
		self._text = nil
		return
	end

	local offset = self:getHOffset()
	local width = self._size.width*2
	local fontSize = self:getFontSize()
	if not self._text then


		self._text = UIText.new(width, fontSize, fontSize, nil, UIInfo.color.white, UIInfo.alignment.RIGHT, UIInfo.alignment.TOP, true, false, true)
		self._text:setAnchorPoint(ccp(0, 0))
		textParent:addChild(self._text, UIGrid._ZUPBORDER)

	end
	if align == UIInfo.alignment.left then
		self._text:setPosition(-self._size.width/2+offset, self._size.height/2-fontSize)
	else
		self._text:setPosition(self._size.width/2-offset-width, self._size.height/2-fontSize)
	end
	self._text:setText(text, nil, nil, nil, align)
end

function UIGrid:clearTopText()
	if self._text then
		self._text:dispose()
		self._text = nil
	end
end



--[[
@brief 格子上方显示内容
@param text string
@param align UIInfo.align
--]]
function UIGrid:setBottomText(text, align, color)
	--print("function UIGrid:setNumberText(text)",text)
	local textParent = self:getContainer()
	color = color or UIInfo.color.white
	if not text or text == "" then
		if not self._textBottom then return end
		self._textBottom:dispose()
		self._textBottom = nil
		return
	end

	local offset = self:getHOffset()
	local width = self._size.width*2
	local fontSize = self:getFontSize()
	if not self._textBottom then
		self._textBottom = UIText.new(width, fontSize, fontSize, nil, color, UIInfo.alignment.RIGHT, UIInfo.alignment.TOP, false, false, true)
		self._textBottom:setAnchorPoint(ccp(0, 0))
		textParent:addChild(self._textBottom, UIGrid._ZUPBORDER)
	end
	if align == UIInfo.alignment.left then
		self._textBottom:setPosition(-self._size.width/2+offset, -self._size.height/2+offset-5)
	else
		self._textBottom:setPosition(self._size.width/2-offset-width, -self._size.height/2+offset-5)
	end
	self._textBottom:setText(text, nil, nil, color, align)
end

function UIGrid:clearBottomText()
	if self._textBottom then
		self._textBottom:dispose()
		self._textBottom = nil
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

	return self._text:getText()
end

--[[
@brief 获取文字节点
@return string 返回的文字
]]--
function UIGrid:getTextNode()
	return self._text
end

--[[
@brief 添加左下角等级节点
@param level number or string 等级
--]]
function UIGrid:setLevelNode(level)
	if not self._levelText then
		self._levelImage = UIImage.new('#role_shudi.png', nil, false)
		self:getContainer():addChild(self._levelImage, self._ZUPIMAGE)
		self._levelImage:setAnchorPoint(ccp(0, 0))
		local siz = self._levelImage:getContentSize()
		--self._levelText = RichText.new(self:getContentSize().width,30, 30)
		self._levelText = UIText.new(siz.width, siz.height, 24, nil, nil, UIInfo.alignment.CENTER, UIInfo.alignment.CENTER, true, false)
		self._levelImage:addChild(self._levelText)
		self._levelText:setAnchorPoint(ccp(0, 0))
		--self._levelText:setPosition(ccp(0, 5))
		self._levelImage:setPosition(ccp(5-self._size.width/2, 16-self._size.height/2))
		self:updateLevelNodeSize()
	end
	self._levelText:setText(tostring(level))
end

function UIGrid:updateLevelNodeSize()
	if not self._levelImage then return end

	if self._size.width < 90 then
		self._levelImage:setScale(self._size.width/90)
	end
end

--[[
@brief 移除左下角等级节点
--]]
function UIGrid:removeLevelNode()
	if self._levelText then
		self._levelText:dispose()
		self._levelText = nil
	end
	if self._levelImage then
		self._levelImage:dispose()
		self._levelImage = nil
	end
end

function UIGrid:setStar(star)
	local img = HeroCfg:getStarIcon(star)
	assert(img, "error with star " ..star)
	if not self._starImage then
		self._starImage = UIImage.new(img)
		self:getContainer():addChild(self._starImage, self._ZUPBORDER)
		self._starImage:setAnchorPoint(ccp(0, 0))
		local siz = self._starImage:getContentSize()
		self._starImage:setPosition(ccp(6-self._size.width/2, 4-self._size.height/2))
		self:updateStarSize()
	end
	self._starImage:setSpriteImage(img)
end

function UIGrid:updateStarSize()
	if not self._starImage then return end
	self._starImage:setScale((self._size.width-10)/91)
end

function UIGrid:clearStar()
	if self._starImage then
		self._starImage:dispose()
		self._starImage = nil
	end
end

function UIGrid:_setBlood(percent)
	if not self._blood  then
		local width = self._size.width * 0.70
		self._blood = UIBlood.new(width, nil, "green")
		self:getContainer():addChild(self._blood, self._ZUPIMAGE)
		self._blood:setAnchorPoint(ccp(0, 0))
		local siz = self._blood:getBgSize()
		self._blood:setPosition(ccp(-siz.width/2, -(10+siz.height)+self._size.height/2))
		self._blood:setMaxBlood(100)
	end

	if percent <= 1 and percent >= 0 then
		self._blood:setBlood(percent*100)
	else
		assert(percent <= 1 and percent >= 0, "error blood percent " .. percent)
	end
end

function UIGrid:_clearBlood()
	if self._blood then
		self._blood:removeFromParent()
		self._blood:dispose()
		self._blood = nil
	end
end

function UIGrid:setDarkNotice(text)
	if self._darkText then
	--	if not text then return end
		self._darkText:setText(text)
		return
	end

	self._darkColor = UIImage.new("#tt_2.png", CCSize(self._size.width, self._size.height), true)--CCLayerColor:create(ccc4(33, 33, 33, 150), self._size.width, self._size.height)
	self:getContainer():addChild(self._darkColor, UIGrid._ZTOP)
	self._darkColor:setAnchorPoint(ccp(0,0))
	self._darkColor:setPosition(-self._size.width/2, -self._size.height/2)
	local fontSize = math.floor(self._size.width*0.25)
	self._darkText = UIText.new(self._size.width, fontSize, fontSize, nil, ccc3(160,75,75), UIInfo.alignment.CENTER, UIInfo.alignment.CENTER, true, true)
	self._darkColor:addChild(self._darkText, UIGrid._ZTOP+1)
	self._darkText:setText(text)
	self._darkText:setAnchorPoint(ccp(0,0))
	local siz = self._darkText:getContentSize()
	self._darkText:setPosition(0, self._size.height - siz.height - 8)
end

function UIGrid:clearDarkNotice()
	if self._darkText then
		self._darkText:removeFromParent()
		self._darkText:dispose()
		self._darkText = nil
		if self._darkColor.dispose then
			self._darkColor:dispose()
		else
			self._darkColor:removeFromParent()
		end
		self._darkColor = nil
	end
end

function UIGrid:_setDeath()
	self:setDarkNotice("已阵亡")
end

function UIGrid:_clearDeath()
	self:clearDarkNotice()
end

--[[
@param percent 0.0-1.0
--]]
function UIGrid:setHP(percent, showDeath)
	if percent <= 0 and showDeath then
		self:_clearBlood()
		self:_setDeath()
	else
		self:_clearDeath()
		self:_setBlood(percent)
	end
end

function UIGrid:clearHP()
	self:_clearBlood()
	self:_clearDeath()
end


function UIGrid:addLockImage(center, opacity)
	if self._lockImage then return end
	local imgSize = self._image:getContentSize()
	self._lockImage = UIImage.new("#rune_suo.png", CCSize(32, 32), true)
	if opacity then
		self._lockImage:setOpacity(opacity or 80)
	end
	local lockSize = self._lockImage:getContentSize()
	self:getContainer():addChild(self._lockImage, UIGrid._ZIMAGE)
	if center then
		self._lockImage:setPosition(ccp(-lockSize.width/2, -lockSize.height/2))
	else
		self._lockImage:setPosition(ccp(-imgSize.width/2, -lockSize.height+imgSize.height/2))
	end
end

function UIGrid:clearLockImage()
	if self._lockImage then
		self._lockImage:dispose()
		self._lockImage = nil
	end
end
--[[
function UIGrid:addItemFlag(url)
	local img = UIImage.new(url, nil, true)
		--local siz = img:getContentSize()
	local siz = CCSize(30,30)
	local stard = 90
	local scale = self._size.width/stard
	if scale > 1 then
		scale = 1
	end
	siz.width, siz.height = math.floor(siz.width*scale), math.floor(siz.height*scale)
	img:setImageSize(siz)
	self:getContainer():addChild(img, UIGrid._ZUPIMAGE)
	img:setPosition(ccp(-self._size.width/2+6*scale, self._size.height/2-siz.height-4*scale))
	return img
end

function UIGrid:addMaterialFlag()
	if not self._materialFlag then
		--self._materialFlag = self:addItemFlag("#com_suipian.png")
	end
end

function UIGrid:clearMaterialFlag()
	if self._materialFlag then
		--self._materialFlag:removeFromParent()
		--self._materialFlag:dispose()
		--self._materialFlag = nil
	end
end

function UIGrid:addSoulStoneFlag()
	if not self._soulStoneFlag then
		--self._soulStoneFlag = self:addItemFlag("#com_soul.png")
	end
end

function UIGrid:clearSoulStoneFlag()
	if self._soulStoneFlag then
		--self._soulStoneFlag:removeFromParent()
		--self._soulStoneFlag:dispose()
		--self._soulStoneFlag = nil
	end
end
--]]

function UIGrid:addSelectedImage(url, x, y)
	if self._selectedImage then return end
	local imgSize = self._image:getContentSize()
	self._selectedImage = UIImage.new(url or "#box_gou.png", nil, false)
	local lockSize = self._selectedImage:getContentSize()
	self:getContainer():addChild(self._selectedImage,self._ZTOP+1)--
	self._selectedImage:setPosition(ccp(-lockSize.width/2+(x or 0), -lockSize.height/2+(y or 0)))
end

function UIGrid:getSelectedImage()
	return self._selectedImage
end

function UIGrid:clearSelectedImage()
	if self._selectedImage then
		self._selectedImage:dispose()
		self._selectedImage = nil
	end
end

--[[
@brief 清除图片
@param canRecover boolean 是否可以通过 recoverImage 恢复原装
--]]
function UIGrid:clearImage()
	if self._imageBorder then
		self._imageInfo.imageBorder = nil
		self._imageBorder:setSpriteImage(nil)
	end
	if self._image then
		self._imageInfo.image = nil
		self._image:setSpriteImage(nil)
	end
	if self._imageBg then
		self._imageInfo.imageBg = nil
		self._imageBg:setSpriteImage(nil)
	end
end

--[[
@brief 恢复图片
@param canRecover boolean 是否可以通过 recoverImage 恢复原装
--]]
function UIGrid:recoverImage()
	assert(false, "UIGrid:recoverImage() not support")
end

function UIGrid:addRightTop(node, offset)
	local x,y = self._size.width/2, self._size.height/2
	if offset then
		x = x + offset.x
		y = y + offset.y
	end
	self:getContainer():addChild(node, UIGrid._ZTOP)
end

function UIGrid:addQualityMagic(quality)
	local qualityIds = {nil, nil, nil, 114, 110,  153}
	quality = quality or 1
	-- local quality = 1
	-- if type(itemInfo) == "number" then
	-- 	local cfg = ItemCfg:getCfg(itemInfo)
	-- 	quality =  cfg and cfg['quality']
	-- 	quality
	-- else
	-- 	quality = itemInfo.cfg.quality
	-- end

	local id = qualityIds[quality]
	if id == self._qMagicId then
		return
	end
	self:clearQualityMagic()
	self._qMagicId = id
	if id == nil then return end
	self._qMagic = SimpleMagic.new(id, -1)
	self:getContainer():addChild(self._qMagic, 127)
	local rect = self:boundingBox()

	local width = rect.size.width
	--self._qMagic:setScale(width/92)
	self._qMagic:setPScale(width/92)
	print("UIGrid:addQualityMagic(itemInfo)", width, width/92)
end

function UIGrid:clearQualityMagic()
	if self._qMagic then
		self._qMagic:dispose()
		self._qMagic = nil
		self._qMagicId = nil
	end
end

function UIGrid:dispose()
	TouchBase.dispose(self)
	self:removeAllEventListeners()
	self:removeLevelNode()



	self:clearUserData()
	self:clearSelectedImage()
	self:clearImage()
	self:clearLockImage()
	self:clearHP()
	self:clearStar()
	self:clearDarkNotice()

	self._imageInfo = nil
	self._eventInfo = nil
	self._size = nil

	self._isgrey = nil

	self:removeContainer()

	if self._text then
		self._text:dispose()
		self._text = nil
	end

	if self._imageBorder then
		self._imageBorder:release()
		self._imageBorder = nil
	end

	if self._image then
		self._image:release()
		self._image = nil
	end

	if self._imageBg then
		self._imageBg:release()
		self._imageBg = nil
	end

	self:release()
	--[[
	UIGrid.num = UIGrid.num - 1
	print("格子对象。。。。。数量：：：："..UIGrid.num)
	--]]
end

return UIGrid
