--[[
class: UIGridLayout
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
	local btn = UIGridLayout.new("#button.png", CCSize(200, 180), true)
	btn:setText("long long ago", 15, nil, ccc3(255, 255, 255), UIInfo.alignment.center, UIInfo.alignment.center)	
	btn:setEnlarge(true)
	local textString = btn:getText()
	print(textString)
--]]

local UIGridLayout = class("UIGridLayout", TouchBase)

--[[
@brief 创建一个格子。 其中格子由上而下包含 border, image, background-image.
@param size CCSize 如果为nil, 则从border， image和background-image 选择最大的 width 和 height 作为 size。若都没设置， 则选择 CCSize(82,82)作为size
@param bgimage bgground
--]]

function UIGridLayout:ctor(bgImage, priority,swallowTouches)
	
	self._padding = {left=0, right=0, bottom=0, top=0}
	TouchBase.ctor(self,priority,swallowTouches)
	EventProtocol.extend(self)
	self._imageInfo = {imageBg=bgImage}
	self._eventInfo = {enable=false, shrink=false}
	
	if self._imageInfo.bgImage then
		self._image = display.newXSprite(self._imageInfo.bgImage)
		self._image:retain()
		self._image:setAnchorPoint(ccp(0.5,0.5))
		self:addChild(self._image)
	end
	
	self._size = self._image:getImgSize()
	self:setContentSize(self._size)
	self:setAnchorPoint(ccp(0.5, 0.5))

	self._items = {}
	self._itemSize = CCSize(82, 82)
	self:touchEnabled(true)
	self:retain()
end

function UIGridLayout:setItemSize(itemSize, update)
	self._itemSize = itemSize
	if update then
		self:update()
	end
end

function UIGridLayout:update()
	local cnt = #self._items
	if cnt < 1 then return end
	
	local w,h = size.width-self._padding.left-self._padding.right
	local wcount = math.floor(w/self._itemSize.width)
	local wstep = w/wcount
	local hstep = self._itemSize.height
	local x_begin = size.width - self._padding.left + wstep/2
	local y = size.height - self._padding.top + hstep/2
	
	x = x_begin
	for i=1, cnt do
		self:_setCenter(self._items[i], x, y)
		x = x + wstep
		if (i%wcount == 0) then
			y = y + hstep
			x = x_begin
		end
	end
end

function UIGridLayout:add(node)
	local w,h = size.width-self._padding.left-self._padding.right
	local wcount = math.floor(w/self._itemSize.width)
	local wstep = w/wcount
	local hstep = self._itemSize.height
	local x = size.width - self._padding.left + wstep/2
	local y = size.height - self._padding.top + hstep/2
	local cnt = #self._items
	self._items[cnt+1] = node
	self:addChild(node)
	x = x + (cnt % wcount) * wstep
	y = y - math.floor((cnt + 1)/wcount) * hstep
	self:_setCenter(node, x, y)
end

function UIGridLayout:clear()
	self:removeAllChildren()
	for i=1, #self._items do
		self._itemsp[i]:dispose()
	end
	
	self._items = {}
end
function UIGridLayout:_setCenter(node, x, y)
	local anchor = node:getAnchorPoint()
	local size = node:getContentSize()
	local w = size.width * (anchor.x - 0.5)
	local h = size.height * (anchor.y - 0.5)
	node:setPosition(ccp(x + w, y - h))
end

--[[
@brief 设置 button 的激活状态
@param flag boolean 
--]]
function UIGridLayout:setEnable(flag)
	if tobool(flag) ~= self._eventInfo.enable then
		self._eventInfo.enable = tobool(flag)
	end
end

--[[
@brief 设背景图片
@param borderImageUrl string 
--]]
function UIGridLayout:setBgImage(bgImageUrl)
	if self._imageInfo.imageBg ~= bgImageUrl then
		self._imageInfo.imageBg = bgImageUrl
		if not self._image then
			self._image = display.newXSprite(bgImageUrl)
			self._image:retain()
			self._image:setAnchorPoint(ccp(0.5,0.5))
			self:getContainer():addChild(self._image)
		else
			self._image:setImage(self._imageInfo.image)
		end
	end
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
function UIGridLayout:setText(text, fontSize, fontName, fontColor, align, valign)
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
function UIGridLayout:getText()
	if not self._text then
		return nil
	end
	
	return self._text.getText()
end

function UIGridLayout:dispose()
	self:clear()
	self._imageInfo = nil
	self._eventInfo = nil
	self._size = nil
	self._items = nil
	
	if self._text then
		self._text:dispose()
		self._text = nil
	end	
	
	self:removeAllChildren()
	
	if not self._image then
		self._image:release()
		self._image = nil
	end
	
	self:release()
	TouchBase.dispose(self)
end

return UIGridLayout