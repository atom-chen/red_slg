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
	local textString = btn:getText()
	print(textString)
]]--

local UIButton = class("UIButton", TouchBase)

UIAction = require("uiLib.container.UIAction")
function UIButton:ctor(images, priority,swallowTouches)
	print(images[1], images[2])

	TouchBase.ctor(self,priority,swallowTouches)
	EventProtocol.extend(self)
	self._imageInfo = {imageUp=images[1], imageDown=images[2] or images[1], imageDisabled= images[3] or images[1], isSTensile = false}
	self._eventInfo = {enable=true, isEnlarge=false, shrink=false}

	--self.content = display.newNode()
	--self:addChild(self.content)
	
	self._image = display.newXSprite(self._imageInfo.imageUp)
	self._imageUrl = self._imageInfo.imageUp
	--self._image:setSpriteImage(self._imageInfo.imageUp)
	self._image:retain()
	self._image:setAnchorPoint(ccp(0.5,0.5))

	--self.content:addChild(self._image)
	
	self:addChild(self._image)
	local size = self._image:getImgSize()
	self:setContentSize(size)
	--self.content:setPosition(size.width/2,size.height/2)
	
	self._image:setPosition(size.width/2,size.height/2)
	self._size = size

	self:touchEnabled(true)
	self:retain()
end

--设置 大小  isRect9  是否是9宫格拉伸    一般都是9宫格拉伸
function UIButton:setSize(size,isRect9)
	if not size then return end
	
	if isRect9 ~= nil then
		self._imageInfo._isSTensile = isRect9
	end
	local curSize = self:getContentSize()
	if not curSize:equals(size) then
		self._size = size
		self:setContentSize(size)
		self:_updateSize()
	end
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
@brief 将 button 一些信息组装成字符串返回。 用于调试查看
@return string
]]--
function UIButton:_toString()
	local cs = self:getContentSize()
	local x,y  = self:getPosition()
--	local a  = self:getAnctorPoint()
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
	s = s .. "size:" .. size2str(self._image:getImgSize())
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
	if flag ~= self._eventInfo.enable then
		self._eventInfo.enable = flag
		if (flag) then
			self._updateImage(self._imageInfo.imageUp)
		elseif self._imageInfo.imageDisabled then
			self._updateImage(self._imageInfo.imageDisabled)
		end
	end
	--[[
	if flag then
		self:add_touchEventListener(handler(self, self._touchEvent), false)
		self:setTouchEnabled(true)
	else
		self:setTouchEnabled(false)
		--self:remove_touchEventListener()
	end
	]]--
end

--获取点击区域    重写方法
function UIButton:getTouchRect()
	local size = self:getContentSize()
	if (self._eventInfo.isEnlarge) then
		return {x=0,y=0,width=size.width+10,height=size.height+10}
	else
		return {x=0,y=0,width=size.width,height=size.height}
	end
end

-- --[[
-- @brief 世界坐标系的坐标(x, y)是否在 button 的范围内
-- @param x float
-- @param y float
-- @return 包含则返回 true， 否则 false
-- ]]--
-- function UIButton:contains(x, y)
-- 	local ox, oy = self:getPosition()
-- 	local worldPos = self:convertToWorldSpace(ccp(0, 0))
-- 	local width = self._size.width
-- 	local height = self._size.height
-- 	if (self._eventInfo.isEnlarge) then
-- 		worldPos.x = worldPos.x - 1
-- 		worldPos.y = worldPos.y - 1
-- 		width = width + 1
-- 		height = height + 1
-- 	end
	
-- 	local c = false
-- 	--[[
-- 	print("node", ox, oy, width, height)
-- 	print("event:(", x, ",", y, ")")
-- 	print("worldly:(", worldPos.x, ",", worldPos.y, ")")
-- 	]]--
-- 	if (x >= worldPos.x and x <= worldPos.x+width) and (y >= worldPos.y and y <= worldPos.y+height) then
-- 		c = true
-- 	end
-- 	return c
-- end


--[[
@brief 重置精灵的图像到初始状态
]]--
function UIButton:_imageReset()
	if self._eventInfo.shrink then
		self._eventInfo.shrink = false
		UIAction.shrinkRecover(self._image);
	else
		self:_updateImage(self._imageInfo.imageUp)
	end
	self._eventInfo.began = false
	self._eventInfo.leave = true
end


--[[
@brief 更新图像大小
]]--
function UIButton:_updateSize()
	if self._size then
		self._image:setImageSize(self._size)
		self._image:setPosition(ccp(self._size.width/2, self._size.height/2))
		if self._imageInfo._isSTensile then  --支持9宫格拉伸
			local rect = uihelper.getRect(self._imageUrl)  --获取9宫 rect
			if not rect then return end
			self._image:setRect9(rect)
		end
	end
end

--[[
@brief 更新图像内容
@param imageurl string 图像的内容
]]--
function UIButton:_updateImage(imageUrl)
	if self._imageUrl ~= imageUrl then
		self._imageUrl = imageUrl
		self._image:setSpriteImage(imageUrl)
		self:_updateSize()
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

--[[
@brief 触屏（鼠标） began 事件响应
@param x float 世界坐标系的x
@param y float 世界坐标系的y
@return boolean 返回是否接受后续事件
]]--
function UIButton:onTouchDown(x,y)
	if not self._eventInfo.enable then
		return false
	end
	--print("image up down", self._imageInfo.imageUp, self._imageInfo.imageDown)
	if self._imageInfo.imageDown and self._imageInfo.imageUp and self._imageInfo.imageDown ~= self._imageInfo.imageUp then
		self:_updateImage(self._imageInfo.imageDown)
	else
		self._eventInfo.shrink = true
		UIAction.shrink(self._image);
	end
	self:dispatchEvent({name = Event.MOUSE_DOWN,target = self.content})
	return true
end

-- --[[
-- @brief 触屏（鼠标） move 事件响应
-- @param e string 事件名称
-- @param x float 世界坐标系的x
-- @param y float 世界坐标系的y
-- @return boolean
-- ]]--
-- function UIButton:onTouchMove(e,x,y)
-- 	if self:contains(x,y) then
-- 		self:dispatchEvent({name = Event.MOUSE_MOVE})
-- 		return true
-- 	else
-- 		self._image:_updateImage(self._imageInfo.imageUp)
-- 		self._eventInfo.leave = true
-- 		return false
-- 	end	
-- end

--[[
@brief 触屏（鼠标） end 事件响应
@param x float 世界坐标系的x
@param y float 世界坐标系的y
@return boolean
]]--
function UIButton:onTouchUp(x,y)
	--print("UIButton up")
	self:_imageReset()
	self:dispatchEvent({name = Event.MOUSE_UP,target = self})
	self:dispatchEvent({name = Event.MOUSE_CLICK,target = self})
end

--[[
@brief 触屏（鼠标） cancel 事件响应
@param x float 世界坐标系的x
@param y float 世界坐标系的y
@return boolean
]]--
function UIButton:onTouchCanceled(x,y)
	--print("UIButton cancel")
	self:_imageReset()
	self:dispatchEvent({name = Event.MOUSE_CANCEL,target = self})
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
function UIButton:setText(text, fontSize, fontName, fontColor, align, valign)
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
		self._text:setText(text, fontSize, fontName, fontColor)
		if align and valign then
			self._text:setAlignInParent(self, self:getContentSize(), align, valign)
		end
	end
end

--[[
@brief 获取文字内容
@return string 返回的文字
]]--
function UIButton:getText()
	if not self._text then
		return nil
	end
	
	return self._text.getText()
end

function UIButton:dispose()
	self._imageInfo = nil
	self._eventInfo = nil
	self._size = nil
	
	if self._text then
		self._text:dispose()
		self._text = nil
	end
	
	
	self:removeAllChildren()
	self._image:release()
	self._image = nil
	
--	self:remove_touchEventListener()
	-- self:removeAllEventListeners()
	self:release()
	TouchBase.dispose(self)
end

return UIButton