--[[
class: UIAttachText
inherit: CCLabelTTF
desc: 创建文字Lable。 
author：changao
date: 2014-06-03
example：
	local node = CCNode:new()
	local text = UIAttachText.new("abcefef", 12, "Marker Felt", ccc3(123,123,123))
	node:addChild(text)
	text:setAlignInParent(node, CCSize(120, 100), UIInfo.alignment.center, UIInfo.alignment.bottom)
]]--

local UIAttachText = class("UIAttachText", function (text, fontSize, fontName) 
	return ui.newTTFLabel({text = text,  font = fontName or "Marker Felt", size = fontSize or 18}); 
end)



--[[
@brief 构造UIAttachText
@param text string
@param fontSize int 文字字体大小
@param fontName string 字体名称
@param fontColor ccc3 字体颜色
]]--
function UIAttachText:ctor(text, fontSize, fontName, fontColor)
	self:setColor(fontColor or ccc3(0, 0, 0));
	
	self:setAnchorPoint(ccp(0, 0));
	self:retain()
end

function UIAttachText:setPadding(padding, update)
	if padding < 0 then
		self._padding = 0
	else
		self._padding = padding
	end
	
	if update then
		self:setAlignInParent(self:getParent(), self._size, self._align, self._valign)
	end
end

--[[
@brief 获取要显示的文字的原点。
@param origin CCPoint
@param size CCSize 父节点的大小
@param fontContentSize CCSize 显示的文字内容的大小
@param halignment UIInfo.alignment 水平对齐方式
@param valignment UIInfo.alignment 竖直对齐方式
@return CCPoint 返回相对于父节点的坐标。
]]--
function UIAttachText:getPos(origin, size, fontContentSize, halignment, valignment)
	local padding = self._padding
	local hSub = size.height - fontContentSize.height
	local hpadding = padding
	if padding and hSub > 0 then
		if hpadding > hSub/2 then
			hpadding = hSub/2
			print("hpadding", hpadding)
		end
	end
	local x,y 
	if halignment == UIInfo.alignment.LEFT then
		x = origin.x
		if padding then
			x = x + padding
		end
	elseif halignment == UIInfo.alignment.RIGHT then
		x = origin.x + size.width - fontContentSize.width
		if padding then
			x = x - padding
			print("x", x)
		end
	else
	--elseif halignment == UIInfo.alignment.CENTER then
		x = origin.x + (size.width - fontContentSize.width) / 2
	end
	
	if valignment == UIInfo.alignment.BOTTOM then
		y = origin.y
		if padding and hSub > 0 then
			y = y + hpadding
		end
	elseif valignment == UIInfo.alignment.TOP then
		y = origin.y + hSub
		if padding and hSub > 0 then
			y = y - hpadding
		end
	else
	--elseif valignment == UIInfo.alignment.CENTER then
		y = origin.y + (hSub) / 2
	end
	return ccp(x, y)
end

--[[
@brief 设置当前节点相对于父节点的对齐方式 
@param parent CCNode 父节点
@param size CCSize 其中，如果 size 不为 nil， 则由 size 指定父节点的大小。否则根据 parent 获取 content size 作为大小。
@param align UIInfo.alignment 水平对齐方式
@param valign UIInfo.alignment 竖直对齐方式
]]--
function UIAttachText:setAlignInParent(parent, size, align, valign)
	local parrentSize = size or parent:getContentSize()
	local fontContentSize = self:getContentSize()

	self._parentSize = parrentSize
	self._align = align
	self._valign = valign
	
	local pos = self:getPos(ccp(0, 0), parrentSize, fontContentSize, align or UIInfo.alignment.CENTER, valign or UIInfo.alignment.CENTER);
		
	self:setPosition(pos)
end

--[[
@brief 设置文字内容
@param text string
@param fontSize int 文字字体大小
@param fontName string 字体名称
@param fontColor ccc3 字体颜色
]]--
function UIAttachText:setText(text, fontSize, fontName, fontColor)
	if text then 
		self:setString(text) 
	end

	if fontSize then 
		self:setFontSize(fontSize)
	end
	
	if fontName then 
		self:setFontName(fontName);
	end	
	
	if fontColor then
		self:setColor(fontColor)
	end
end

--[[
@brief 获取文字内容
@return string 返回的文字
]]--
function UIAttachText:getText()
	self:getString()
end


-- --[[
-- @brief 获取文字内容
-- @param text string 
-- ]]--
-- function UIAttachText:setUIAttachText(parent, text)
	-- self:setString(text)
-- end

--[[
@brief 获取文字内容
@return string 返回的文字
]]--
-- function UIAttachText:getUIAttachText(parent)
	-- self:getString()
-- end

function UIAttachText:dispose()
	self._parentSize = nil
	self._align = nil
	self._valign = nil
	self._padding = nil
	
	self:release()
end

return UIAttachText