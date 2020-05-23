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

local UIAttachText = class("UIAttachText", function (width, height, fontSize, fontName, fontColor, useRTF, shadow, outline)
--	print(width, height, fontSize, fontName, fontColor, useRTF, shadow, outline)
	local uitext
	if useRTF then
		uitext = RichText.new(width, height, fontSize, fontColor, 0, nil, nil, shadow)
	elseif shadow then
		uitext = ui.newTTFLabelWithShadow({align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_VALIGN_CENTER, size=fontSize, color=fontColor})
	elseif outline then
		local outlineColor = UIInfo.getOutlineColor(outline)
		uitext = ui.newTTFLabelWithOutline({ align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_VALIGN_CENTER, size=fontSize, color=fontColor,outlineColor=outlineColor})
	else
		uitext = ui.newTTFLabel({ align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_VALIGN_CENTER, size=fontSize, color=fontColor})
	end
	uitext:setAnchorPoint(ccp(0,0))
	return uitext
end)



--[[
@brief 构造UIAttachText
@param text string
@param fontSize int 文字字体大小
@param fontName string 字体名称
@param fontColor ccc3 字体颜色
]]--
function UIAttachText:ctor(width, height, fontSize, fontName, fontColor, useRTF, shadow,outline)
	self:retain()
	assert(width or height, "should not be nil")
	self._parentSize = CCSize(width, height)
	self._useRTF = useRTF
	self._shadow = shadow
	self._outline = outline

	--self:setColor(fontColor or ccc3(0, 0, 0));

	self:setAnchorPoint(ccp(0, 0))
	self._padding = uihelper.setPadding(nil, 0)
end

function UIAttachText:isRichText()
	return tobool(self._useRTF)
end

function UIAttachText:setPadding(padding, update)

	self._padding = uihelper.setPadding(self._padding, padding)

	if update then
		self:setAlignInParent(self:getParent(), self._parentSize, self._align, self._valign)
	end
end

function UIAttachText:setSize(width, height)
	if self._useRTF then
		self:setSize(width, height)
		self._parentSize = CCSize(width, height)
	end
	self:setAlignInParent(self:getParent(), self._parentSize, self._align, self._valign)
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
	local hpadding = padding.top + padding.bottom
	--[[
	if padding and hSub > 0 then
		if hpadding > hSub/2 then
			hpadding = hSub/2
			--print("hpadding", hpadding)
		end
	end
	--]]

	local x,y
	if halignment == UIInfo.alignment.LEFT then
		x = origin.x + padding.left

	elseif halignment == UIInfo.alignment.RIGHT then
		x = origin.x + size.width - fontContentSize.width
		x = x - padding.right
	else
	--elseif halignment == UIInfo.alignment.CENTER then
		x = origin.x + padding.left + (size.width - padding.left - padding.right - fontContentSize.width) / 2
	end
	--print("origin", origin.x, origin.y, " anchor", self:getAnchorPoint().x, self:getAnchorPoint().y)
	--print("function UIAttachText:getPos(origin, size, fontContentSize, halignment, valignment) x size", x, size.width, size.height, "font", fontContentSize.width, fontContentSize.height, halignment, valignment)
	if valignment == UIInfo.alignment.BOTTOM then
		y = origin.y + padding.bottom
	elseif valignment == UIInfo.alignment.TOP then
		y = origin.y + hSub - padding.top
	else
	--elseif valignment == UIInfo.alignment.CENTER then
		y = origin.y + padding.bottom + (size.height - padding.bottom - padding.top - fontContentSize.height) / 2
	end
--	print("UIAttachText:getPos(origin, size, fontContentSize, halignment, valignment)", x, y, origin.x, origin.y, size.width, size.height, fontContentSize.width, fontContentSize.height)
--	dump(padding)

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
	if align then
		self._align = align
	end
	if valign then
		self._valign = valign
	end


--	print("function UIAttachText:setAlignInParent(parent, size, align, valign)", self:getScaleX(), self:getScaleY())
	local siz = CCSize(fontContentSize.width*self:getScaleX(), fontContentSize.height*self:getScaleY())
	local pos = self:getPos(ccp(0, 0), parrentSize, siz, self._align or UIInfo.alignment.CENTER, self._valign or UIInfo.alignment.CENTER);
--[[
	print("pos:", pos.x, pos.y, "parrentSize:", parrentSize.width, parrentSize.height, "rsize:", siz.width, siz.height, "osize:", fontContentSize.width, fontContentSize.height)

	if self._img then
		self._img:dispose()
	end
	self._img = UIImage.new("#tt_2.png", fontContentSize)
	parent:addChild(self._img)
	self._img:setPosition(pos)

	if self._imgBg then
		self._imgBg:dispose()
	end
	self._imgBg = UIImage.new("#tt_3.png", parrentSize)
	parent:addChild(self._imgBg)
--]]
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
--	print("function UIAttachText:setText(text, fontSize, fontName, fontColor)", text, fontSize, fontName, fontColor)
	if fontSize and self.setFontSize then
		self:setFontSize(fontSize)
	end

	if fontName and self.setFontName then
		self:setFontName(fontName)
	end

	if fontColor then
		self:setColor(fontColor)
	end

	if text then
		self:setString(text)
	end
end

--[[
@brief 获取文字内容
@return string 返回的文字
]]--
function UIAttachText:getText()
	if self._useRTF then
		return RichText.getText(self)
	end
	return self:getString()
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
	self:removeFromParent()

	self._parentSize = nil
	self._align = nil
	self._valign = nil
	self._padding = nil

	--self:dispose()
	if (self:isRichText()) then
		RichText.dispose(self)
	end
	self:release()
end

return UIAttachText
