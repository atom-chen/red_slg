--[[
class: UIButton
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
	local btn = UIButton.new("#button.png", CCSize(200, 180), true)
	btn:setText("long long ago", 15, nil, ccc3(255, 255, 255), UIInfo.alignment.center, UIInfo.alignment.center)
	btn:setEnlarge(true)
	btn:addRedPoint() -- 添加小红点到右下角

	btn:autoSwitchTextColor(false) --关闭被group自动切换字体颜色

	local textString = btn:getText()
	print(textString)
]]--

local UIButton = class("UIButton", TouchBase)

UIButton.UP = 1
UIButton.DOWN = 2
UIButton.DISABLED = 3
UIButton.SELECTED = 4
UIButton.PRESS_INTERVAL = 120 --

UIAction = game_require("uiLib.container.UIAction")
UIUserDataProtocol = game_require("uiLib.container.UIUserDataProtocol")

function UIButton:ctor(images, priority,swallowTouches)
	TouchBase.ctor(self,priority,swallowTouches)
	EventProtocol.extend(self)
	UIUserDataProtocol.extend(self)

	self._imageInfo = {imageUp=images[1], imageDown=images[2], imageDisabled = images[3], imageSelected = images[4], isSTensile = false, isGray=false}
	self._eventInfo = {enable=true, isEnlarge=false, shrink=false, selected=false, state = self.UP, pedding=false, pressTime=0}
	--print("UIButton ctor :", self._imageInfo.imageUp, ",", self._imageInfo.imageDown, ",", self._imageInfo.imageDisabled)
	--self.content = display.newNode()
	--self:addChild(self.content)

	self._image = display.newXSprite(self._imageInfo.imageUp)
	self._imageUrl = self._imageInfo.imageUp
	--self._image:setSpriteImage(self._imageInfo.imageUp)
	self._image:retain()
	self._image:setAnchorPoint(ccp(0.5,0.5))
	--print("---------------------- btn " .. self._imageUrl)
	--self.content:addChild(self._image)

	self:addChild(self._image)
	local size = self._image:getContentSize()
	self:setContentSize(size)
	--self.content:setPosition(size.width/2,size.height/2)

	self._image:setPosition(size.width/2,size.height/2)
	self._size = size

	self:touchEnabled(self._eventInfo.enable)
	self:retain()

	self:setAutoShrink(true)
	self:autoSwitchTextColor(true)
	self:setImageInfo(ccp(0.5, 0.5), true)
	local padding = UIInfo.button.padding[self._imageInfo.imageUp]
	if padding then
		local originSize = uihelper.getOriginalSize(self._imageInfo.imageUp)
		if originSize and not originSize:equals(self._size) then
			print('self._imageInfo.imageUp', self._imageInfo.imageUp, self._size.width, originSize.width, self._size.height, originSize.height)
			uihelper.setPaddingScale(padding, self._size.width/originSize.width, self._size.height/originSize.height)
			dump(padding)
		end
		self:setTextPadding(padding, true)
	end

	self:setAudioId("u_click")
end

function UIButton:getImageInfo()
	return self._imageInfo
end

function UIButton:getImageUrl()
	return self._imageInfo.imageUp
end

function UIButton:getSize()
	return self._size
end

function UIButton:autoSwitchTextColor(flag, unselectedColor)
	self._autoSwitchTextColor = tobool(flag)
	if unselectedColor then
		self._textInfo.unselectedColor = unselectedColor
	end
	if not self._autoSwitchTextColor then
		self:setSelectedColor()
	else
		if not self._eventInfo.selected then
			self:setUnselectedColor(unselectedColor)
		end
	end
end

function UIButton:setAutoShrink(enable)
	self._autoShrinkEnable = tobool(enable)
end

--设置 大小  isRect9  是否是9宫格拉伸    一般都是9宫格拉伸
function UIButton:setSize(size,isRect9)
--	print("function UIButton:setSize(size,isRect9)", isRect9)
	if isRect9 ~= nil then
		self._imageInfo._isSTensile = tobool(isRect9)
		if self._imageInfo._isSTensile then
			uihelper.setRect9(self._image, self._imageUrl)
		end
	end
	if not size then return end

	local curSize = self:getContentSize()
	if not curSize:equals(size) then
		self._size = size
		if self._text then
			self._text:setSize(size.wid, size.height)
		end
		self:setContentSize(size)
		self:_updateSize()
		self:updateTriangle()
	end
end

function UIButton:setOpacity(opacity)
	self._image:setOpacity(opacity)
end
local function size2str(size)
	if (type(size) ~= "userdata") then
		return nil
	end
	return "w:" .. size.width .. " h:" .. size.height;
end

local function pos2str(pos)
	if (type(pos) ~= "userdata") then
		return ts(pos)
	end
	 return "(" .. pos.x .. "," .. pos.y .. ")";
end

local function rect2str(rect)
	if (type(rect) ~= "userdata") then
		return nil
	end
	return pos2str(rect.origin) .. "_" .. size2str(rect.size);
end

-- same as dump
local function ts(...)
	local s = ""
	for n,i in pairs({...}) do
		if type(i) == 'table' then
			s = s .. "table:{"
			for k,v in pairs(i) do
				s = s .. "(" .. k .. ":" .. v .. ")"
			end
			s = s .. "}"
		elseif type(i) == 'userdata' and i.origin then
			s = s .. ts(i.origin) .. ts(i.size)
		else
			s = s .. type(i) .. ":" .. tostring(i)
		end
	end
	return s
end

--[[
@brief 获取组
@return UIGroup
--]]
function UIButton:getGroup()
	return self._group
end

--[[
@brief 设置组
@param group UIGroup
@return bool
--]]
function UIButton:setGroup(group)
	if self._group then
		return false
	end
	self._group = group
	return true
end

function UIButton:clearGroup()
	self._group = nil
end

--[[
@brief 将 button 一些信息组装成字符串返回。 用于调试查看
@return string
]]--
function UIButton:_toString()
	local cs = self:getContentSize()
	local x,y  = self:getPosition()
	local ap = self:getAnchorPointInPoints()
	local rect = self:boundingBox() -- CCRect

	local s = ""
	--s = s .. ts({a,b,c,d})
	s = s .. "ContentSize(" .. cs.width .. "," .. cs.height .. ")  "
	s = s .. "Position(" .. x .. "," .. y .. ")  "
--	s = s .. "AnctorPoint(" .. a.x .. "," .. a.y .. ")  "
--	s = s .. "AnchorPointInPoints(" .. ap.x .. "," .. ap.y .. ")  "
	if (rect) then
		--s = s .. "boundingBox(" .. rect.origin.x .. "," .. rect.origin.y .. " w:" .. rect.size.width .. " h:" .. rect.size.height  ..  ")"
	else
		s = s .. ts(rect)
		s = s .. "boundingBox(" .. rect.origin.x .. "," .. rect.origin.y .. " w:" .. " h:" .. ")"
	end

	local worldPoint = CCPoint(x, y)
	local nodePoint = self:convertToWorldSpace(worldPoint)
	local nodePointAR = self:convertToWorldSpaceAR(worldPoint) -- 计算锚点对坐标的影响

	--s = s .. self.super.__cname .. self.super.__ctype .. " "
	s = s .. "nodePoint(" .. nodePoint.x .. "," .. nodePoint.y .. ")  "
	spx, spy = self._image:getPosition()
	s = s .. "c:" .. pos2str({x=spx, y=spy})
	s = s .. "size:" .. size2str(self._image:getContentSize())
	s = s .. "nodePointAR(" .. nodePointAR.x .. "," .. nodePointAR.y .. ")  "
	return s
end


--[[
@brief 是否扩大 button 的响应范围
@flag flag boolean
]]--
function UIButton:setEnlarge(flag)
	self._eventInfo.isEnlarge = tobool(flag)
end

--[[
@brief 设置 button 的激活状态
@flag flag boolean
]]--
function UIButton:setEnable(flag)
	if tobool(flag) ~= self._eventInfo.enable then
		self._eventInfo.enable = tobool(flag)
		self:touchEnabled(self._eventInfo.enable)
		if (flag) then
			self._eventInfo.state = self.UP
			self:_updateImage(self._imageInfo.imageUp)
			if not self._imageInfo.imageDisabled then
				ShaderMgr:removeColor(self._image)
			end
		elseif self._imageInfo.imageDisabled then
			self._eventInfo.state = self.DISABLED
			self:_updateImage(self._imageInfo.imageDisabled)
		else
			ShaderMgr:setColor(self._image)  --变灰
		end
		if self._textInfo then
			self:_setTextGray(not flag)
		end
	end
end

function UIButton:setGray(flag)
	if true == flag then
		ShaderMgr:setColor(self._image)
	else
		ShaderMgr:removeColor(self._image)
	end
	self:_setTextGray(flag)
end

function UIButton:_setTextGray(flag)
	local outline = false
	local shadow = self._textInfo.shadow
	if flag then
		self._textInfo.fontColorBak = self._textInfo.fontColor
		self._textInfo.fontColor = UIInfo.color.black
		if not self._textInfoBak then
			self._textInfoBak = {}
			for k,v in pairs(self._textInfo) do self._textInfoBak[k] = v end
		--	self._textInfoBak.outline = false
		end
	else
		if self._textInfo.fontColorBak then
			self._textInfo.fontColor = self._textInfo.fontColorBak
		end
		if self._textInfoBak then
			outline = self._textInfoBak.outline
		else
			outline = self._textInfo.outline
		end
	end
	if not self._text then return end
	print("function UIButton:_setTextGray(flag)", self._text:getText())
	--if not self._text:isRichText() then return end
	local text = self._text:getText()
	--print(text, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor, nil, nil, shadow, outline)
	if outline ~= tobool(self._textInfo.outline) then
		self._text:dispose()
		self._text = nil
	end
	self:setText(text, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor, nil, nil, nil, shadow, outline)
end

--[[
@brief 设置 button 的选中状态
@flag flag boolean
--]]
function UIButton:setSelected(flag)
	if not self._eventInfo.enable then return end
	if tobool(flag) ~= self._eventInfo.selected then
		self._eventInfo.selected = tobool(flag)
		if (flag) then
			self._eventInfo.state = self.SELECTED
			self:_updateImage(self._imageInfo.imageSelected)
		elseif self._imageInfo.imageSelected then
			self._eventInfo.state = self.UP
			self:_updateImage(self._imageInfo.imageUp)
		end
		self:onSelected(flag)
	end
end

--[[
@brief 获取 button 的激活状态
@return boolean
--]]
function UIButton:isEabled()
	return tobool(self._eventInfo.enable)
end

--[[
@brief 获取 button 的选中状态
@return boolean
--]]
function UIButton:isSelected()
	return tobool(self._eventInfo.selected)
end

--[[
@brief 设置 up 状态的图片
@param imageUrl string 图片
@param update boolean 是否更新
--]]
function UIButton:setUpImage(imageUrl, update)
	self._imageInfo.imageUp = imageUrl
	if update then
		if self._eventInfo.state ~= self.UP then return end
		self:_updateImage(imageUrl)
	end
end

--[[
@brief 设置 down 状态的图片
@param imageUrl string 图片
@param update boolean 是否更新
--]]
function UIButton:setDownImage(imageUrl, update)
	self._imageInfo.imageDown = imageUrl
	if update then
		if self._eventInfo.state ~= self.DOWN then return end
		self:_updateImage(imageUrl)
	end
end

--[[
@brief 设置 disabled 状态的图片
@param imageUrl string 图片
@param update boolean 是否更新
--]]
function UIButton:setDisabledImage(imageUrl, update)
	self._imageInfo.imageDisabled = imageUrl
	if update then
		if self._eventInfo.state ~= self.DISABLED then return end
		self:_updateImage(imageUrl)
	end
end

--[[
@brief 设置 selected 状态的图片
@param imageUrl string 图片
@param update boolean 是否更新
--]]
function UIButton:setSelectedImage(imageUrl, update)
	self._imageInfo.imageSelected = imageUrl
	if update then
		if self._eventInfo.state ~= self.SELECTED then return end
		self:_updateImage(imageUrl)
	end
end

--获取点击区域    重写方法
function UIButton:getTouchRect()
	local rect = self:boundingBox()
	if (self._eventInfo.isEnlarge) then
		local minX = rect:getMinX()
		local minY = rect:getMinY()
		local w = (rect:getMaxX() - minX)
		local h = (rect:getMaxY()- minY)
		rect:setRect( minX- w*0.15,minY - h*0.15,w*1.3,h*1.3)
	end
	return rect
end

function UIButton:addActionCallback(func)
	if not func then return func end
	self._actionComplete = false

	self._actionCallback = function()
		self._actionComplete = true
		func()
	end
	return self._actionCallback
end

--[[
@brief 重置精灵的图像到初始状态
]]--
function UIButton:_imageReset(onComplete)
	local callBack = function ()
		local url = self._imageInfo.imageUp
		if self._eventInfo.selected then
			url = self._imageInfo.imageSelected
		end
		self:_updateImage(url)

		self._eventInfo.began = false
		self._eventInfo.leave = true
		self._eventInfo.state = self.UP
		--self._eventInfo.pedding = false

		local typestr = type(onComplete)
		if typestr == "function" then
			onComplete()
		elseif typestr == "table" then
			onComplete[1](onComplete[2])
		end
	end
	--[[
	if self._eventInfo.shrink then
		self._eventInfo.shrink = false
		UIAction.shrinkRecover(self._image, callBack);
	elseif true == self._eventInfo.hasFrame then
		self._frame:retain()
		self._frame:removeFromParent()
		callBack()
	else
		self:_updateImage(self._imageInfo.imageUp)
		callBack()
	end
	--]]
	self._eventInfo.state = self.UP
	if self._eventInfo.hasFrame == true then
		self._frame:retain()
		self._frame:removeFromParent()
	end

	if self._eventInfo.shrink then
		self._eventInfo.shrink = false
		ViewMgr:touchCover(0.15)
		UIAction.shrinkRecover(self._image, self:addActionCallback(callBack),nil, nil,0.1 ,0.05);
		--UIAction.recover(self._image, self:addActionCallback(callBack))
	elseif self._eventInfo.hasFrame == false then
		self:_updateImage(self._imageInfo.imageUp)
		callBack()
	else
		self:_updateImage(self._imageInfo.imageUp)
		callBack()
	end
end

--[[
@brief 设置按钮对齐方式
@param anchor CCPoint 对齐的锚点
@param fitSize boolean 是否更改大小到_siz
--]]
function UIButton:setImageInfo(anchor, fitSize)
	self._imageInfo.anchor = anchor or ccp(0.5, 0.5)
	self._imageInfo.fitSize =  tobool(fitSize)
end


function UIButton:update()
	self:_updateImage(self._imageUrl, true)
end
--[[
100 0.8
80

40*0.8 32 8

]]
--[[
@brief 更新图像大小
]]--
function UIButton:_updateSize()
	local size = self._image:getContentSize()

	if self._imageInfo.fitSize and not size:equals(self._size) then
		self._image:setImageSize(self._size)
		self._image:setContentSize(self._size)
		size = self._size
	end

--	size = self._image:getContentSize()

	local anchor = self._imageInfo.anchor or ccp(0.5, 0.5)
	self._image:setAnchorPoint(ccp(0.5, 0.5))
	self._image:setPosition(ccp(self._size.width * anchor.x - size.width * (anchor.x-0.5), self._size.height * anchor.y - size.height * (anchor.y-0.5)))
--	print("function UIButton:_updateSize()", anchor.x, anchor.y, self._size.width * anchor.x - size.width * (anchor.x-0.5), self._size.height * anchor.y - size.height * (anchor.y-0.5))
--	print(self:getPosition(), size.width, size.height, self._size.width, self._size.height)
	--[[
	if not size:equals(self._size) then

		self._image:setImageSize(self._size)
	end
	--]]
end

--[[
@brief 更新图像内容
@param imageUrl string 图像的内容
]]--
function UIButton:_updateImage(imageUrl, forceUpdate)
	--print("---------------------- btn " .. self._imageUrl .. " " .. imageUrl)
	if self._imageUrl ~= imageUrl or forceUpdate then
		self._imageUrl = imageUrl
		self._image:setSpriteImage(imageUrl)
		if self._imageInfo._isSTensile then  --支持9宫格拉伸
			local rect = uihelper.getRect(self._imageUrl)  --获取9宫 rect
			if rect then
				self._image:setRect9(rect)
			end
		end
		if self._imageInfo.fitSize then
			self:setSize(self._image:getContentSize())
		else
			self:_updateSize()
		end
	end
end

-- --[[
-- @brief 触屏（鼠标）事件响应
-- @param e string 事件名称
-- @param x float 世界坐标系的x
-- @param y float 世界坐标系的y
-- @return boolean
-- ]]--
-- function UIButton:_touchEvent(e,x,y)

-- 	if e == "began" then
-- 		return self:_touchBegin(e,x,y)
-- 	elseif e == "moved" then
-- 		return self:_touchMove(e,x,y)
-- 	elseif e == "ended" then
-- 		return self:_touchEnd(e,x,y)
-- 	elseif e == "canceled" then
-- 		return self:_touchCencel(e,x,y)
-- 	end
-- end


function UIButton:setFrame(frameUrl)
	if nil ~= self._frame then
		if true == self._eventInfo.hasFrame then
			self._frame:removeFromParent()
			self._eventInfo.hasFrame = false
		else
			self._frame:release()
		end

		self._frame = nil
	end
	self._frame = display.newXSprite(frameUrl)
	self._frame:setAnchorPoint(ccp(0.5,0.5))
	self._frame:retain()
end

function UIButton:isPressTooQuick()
	local t = XUtil:getCurTime()
	if self._eventInfo.pressTime == 0 then
		self._eventInfo.pressTime = t
		return false
	end

	local ret
	-- CCLuaLog(string.format("function UIButton:isPressTooQuick(),cur:%s pressTime:%s interval:%s", t, self._eventInfo.pressTime, self.PRESS_INTERVAL))
	if t > self._eventInfo.pressTime + self.PRESS_INTERVAL then
		ret = false
	else
		self._eventInfo.pressTime = t
		ret = true
	end

	return ret
end

--[[
@brief 触屏（鼠标） began 事件响应
@param x float 世界坐标系的x
@param y float 世界坐标系的y
@return boolean 返回是否接受后续事件
]]--
function UIButton:onTouchDown(x,y)
	-- CCLuaLog(string.format("function UIButton:onTouchDown(%d,%d), eventinfo.enable:%s", x, y, self._eventInfo.enable))
	if not self._eventInfo.enable then
		return false
	end

	if self:isPressTooQuick() then
		return false
	end

--	if self._eventInfo.pedding then
--		return false
--	end

--	self._eventInfo.pedding = true
	--print("image up down", self._imageInfo.imageUp, self._imageInfo.imageDown)
	self._eventInfo.state = self.DOWN
	if self._imageInfo.imageDown and self._imageInfo.imageUp and self._imageInfo.imageDown ~= self._imageInfo.imageUp then
		self:_updateImage(self._imageInfo.imageDown)
	elseif nil~= self._frame then
		self._image:addChild(self._frame)
		self._frame:release()
		local imageSize = self._image:getContentSize()
		self._frame:setPosition(ccp(imageSize.width/2, imageSize.height/2))
		self._eventInfo.hasFrame = true
	end

	-- 缩小
	if self._autoShrinkEnable then
		self._eventInfo.shrink = true
		UIAction.shrink(self._image)
	end

	self:dispatchEvent({name = Event.MOUSE_DOWN,target = self, x=x,y=y})
	return true
end


-- --[[
-- @brief 触屏（鼠标） move 事件响应
-- @param e string 事件名称
-- @param x float 世界坐标系的x
-- @param y float 世界坐标系的y
-- @return boolean
-- ]]--
function UIButton:onTouchMove(x,y)
 --	if self:contains(x,y) then
 		self:dispatchEvent({name = Event.MOUSE_MOVE, target=self, x=x, y=y})
 --		return true
-- 	else
-- 		self._image:_updateImage(self._imageInfo.imageUp)
-- 		self._eventInfo.leave = true
-- 		return false
-- 	end
 end

--[[
@brief 触屏（鼠标） end 事件响应
@param x float 世界坐标系的x
@param y float 世界坐标系的y
@return boolean
]]--
function UIButton:onTouchUp(x,y)
	self:dispatchEvent({name = Event.MOUSE_UP,target = self})

	local fun = function () self:dispatchEvent({name = Event.MOUSE_CLICK,target = self, x=x, y=y}) end
	--fun()
	self:_imageReset(fun)
--	self._eventInfo.state = self.UP
end

--[[
@brief 触屏（鼠标） cancel 事件响应
@param x float 世界坐标系的x
@param y float 世界坐标系的y
@return boolean
]]--
function UIButton:onTouchCanceled(x,y)
	--print("UIButton cancel")

	self:dispatchEvent({name = Event.MOUSE_CANCEL, target = self, x=x, y=y})
	self:_imageReset()
end

--[[
@brief 添加节点到button的指定位置。 已锚点对齐。
@param node CCNode
@param anchor CCPoint
--]]
function UIButton:addImageChild(node, anchor, zorder)
	if nil == zorder then
		zorder = 1
	end
	self._image:addChild(node, zorder)
	if not anchor then return end
	self:setAddedImageAnchor(node, anchor)
end

--[[
@brief 设置添加到image的节点相对于父节点的位置。
@param node CCNode 已添加的节点
@param anchor CCPoint 相对位置
--]]
function UIButton:setAddedImageAnchor(node, anchor)
	if nil == anchor then
		return
	end
	local siz = self._image:getContentSize()

	local na = node:getAnchorPoint()
	local nsiz = node:getContentSize()
	local p = ccp(siz.width * (anchor.x) + nsiz.width * (na.x - 0.5),
					siz.height * (anchor.y) + nsiz.height * (na.y - 0.5))

	node:setPosition(p)
end

--[[
@brief 添加小红点到指定位置， 若小红点已经添加， 则从新设置位置
@param anchor CCPoint 相对于button的image的位置
--]]
function UIButton:addRedPoint(anchor,res)
	if not self._redPoint then
		self._redPoint = display.newXSprite(res or "#com_new.png")
		self:addImageChild(self._redPoint, anchor or ccp(0.87, 0.87))
	else
		self:setAddedImageAnchor(self._redPoint, anchor)
	end
end

--[[
@brief 移除小红点
--]]
function UIButton:removeRedPoint()
	if self._redPoint then
		self._redPoint:removeFromParent()
		self._redPoint = nil
	end
end

function UIButton:hasRedPoint()
	return self._redPoint ~= nil
end

-- --[[
-- @brief 返回 button 的大小
-- @param e string 事件名称
-- @param x float 世界坐标系的x
-- @param y float 世界坐标系的y
-- @return CCSize
-- ]]--
-- function UIButton:getContentSize()
-- 	return self._size;
-- end

--[[
@brief 构造 设置文字
@param text string
@param fontSize int 文字字体大小
@param fontName string 字体名称
@param fontColor ccc3 字体颜色
@param align UIInfo.alignment 水平对齐方式
@param valign UIInfo.alignment 竖直对齐方式
]]--
function UIButton:setText(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)

	local textParent = self._image
	if not self._textInfo then
		self._textInfo = {fontSize=fontSize, fontName=fontName, fontColor=fontColor, align=align, valign=valign, useRTF=useRTF, shadow=shadow,outline=outline}
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
	--	print("setText, ", text, self._size.width, self._size.height, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor, self._textInfo.useRTF, self._textInfo.shadow, self._textInfo.outline)
		local textnode = UIAttachText.new(self._size.width, self._size.height, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor, self._textInfo.useRTF, self._textInfo.shadow, self._textInfo.outline)

		textParent:addChild(textnode)
		self._text = textnode

		if self._text:isRichText() then
			self._text:setAlign(self._textInfo.align)
			self._text:setAlignV(self._textInfo.valign)
		end

		self._text:setText(text)
	else
		self._text:setText(text, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor)
	end

	-- align
	if not self._text:isRichText() then
		self._text:setAlignInParent(textParent, self:getContentSize(), self._textInfo.align, self._textInfo.valign)
	end
	if self._text then
		self._text:setPadding(self._textInfo.padding, true)
	end
end

function UIButton:_updateTextPosition()
	if not self._text then
		return
	end
	local textParent = self._image
	if not self._text:isRichText() then
		self._text:setAlignInParent(textParent, self:getContentSize(), self._textInfo.align, self._textInfo.valign)
	end
	if self._text then
		self._text:setPadding(self._textInfo.padding, true)
	end
end

function UIButton:setTextColorTemp(color)
	if self._text then
		self._text:setColor(color)
	end
end

function UIButton:setTextPadding(padding)
	if not self._textInfo then
		self._textInfo = {}
	end
	self._textInfo.padding = padding

	if self._text then
		self._text:setPadding(padding, true)
	end
end

function UIButton:setSelectedColorInfo(selectedColor, unselectedColor)
	print("function UIButton:setSelectedColorInfo(selectedColor, unselectedColor)")
	self._selectColorInfo = {selected=selectedColor, unselected=unselectedColor}
end

function UIButton:setUnselectedColor(textColor, fromGroup)
	if not self._autoSwitchTextColor and fromGroup then
		return
	end

	if nil == self._textInfo or nil == self._text then
		return
	end
	if nil == textColor then
		if self._selectColorInfo then
			textColor = self._selectColorInfo.unselected
		else
			textColor = self._textInfo.unselectedColor or UIInfo.color.button_disabled
		end
	end

	local text = self._text:getText()
	self._text:setColor(textColor)
end

function UIButton:setSelectedColor(fromGroup)
	if not self._autoSwitchTextColor and fromGroup then
		return
	end

	if nil == self._textInfo or nil == self._text then
		return
	end

	local text = self._text:getText()
	local textColor
	if self._selectColorInfo then
		textColor = self._selectColorInfo.selected
	else
		textColor = self._textInfo.fontColor
	end
	self._text:setColor(textColor)
	--self:setText(text)
end

--[[
@brief 获取文字内容
@return string 返回的文字
]]--
function UIButton:getText()
	if not self._text then
		return nil
	end

	return self._text:getText()
end

--[[
@brief 获取文字节点
@return string 返回的文字
--]]
function UIButton:getTextNode()
	return self._text
end

--[[
@brief 清除图片
@param canRecover boolean 是否可以通过 recoverImage 恢复原装
--]]
function UIButton:clearImage(canRecover)
	self._image:setSpriteImage(nil)
	if canRecover then
		self._canRecover = true
	else
		self._imageUrl = nil
	end
end

--[[
@brief 恢复图片
@param canRecover boolean 是否可以通过 recoverImage 恢复原装
--]]
function UIButton:recoverImage()
	assert(self._canRecover, "UIButton:clearImage(canRecover) canRecover must be true")
	if self._image and self._imageUrl then
		self._image:setSpriteImage(self._imageUrl)
		local siz = self._image:getContentSize()
		if not siz:equals(self._size) then
			self._image:setImageSize(siz)
		end
	end
end

function UIButton:addTriangle()
	if not self._addedTriangle then
		self._addedTriangle = {}
		self._addedTriangle.left = UIImage.new("#com_teshu1.png")
		self._addedTriangle.left:setAnchorPoint(ccp(1, 0.5))

		self._addedTriangle.right = UIImage.new("#com_teshu2.png")
		self._addedTriangle.right:setAnchorPoint(ccp(0, 0.5))

		self._image:addChild(self._addedTriangle.left)
		self._image:addChild(self._addedTriangle.right)
	end
	self:updateTriangle()
end

function UIButton:onSelected(flag)
end

function UIButton:updateTriangle()
	if not self._addedTriangle then return end
	local x1 = 12--15
	local x2 = 12--16
	self._addedTriangle.left:setPosition(ccp(0+x1, self._size.height/2))
	self._addedTriangle.right:setPosition(ccp(self._size.width-x2, self._size.height/2))
end

function UIButton:clearTriangle()
	if not self._addedTriangle then return end
	self._addedTriangle.left:dispose()
	self._addedTriangle.right:dispose()
	self._addedTriangle = nil
end

function UIButton:dispose()
	self:removeFromParent()
	if self._group then
		self._group:remove(self)
	end

	self:clearImage()
	self:clearTriangle()

	self._imageInfo = nil
	self._eventInfo = nil
	self._size = nil
	self._group = nil
	self._textInfo = nil
	self:clearUserData()

	if self._text then
		self._text:dispose()
		self._text = nil
	end

	self:removeAllChildren()
	self._image:release()
	self._image = nil

	TouchBase.dispose(self)
--	self:remove_touchEventListener()
	self:removeAllEventListeners()
	self:release()

end

return UIButton