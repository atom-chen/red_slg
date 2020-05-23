--[[--
class：     CheckBox
inherit: Button
desc：       checkBox复选框
author:  linchm
version: 20131129
event：
	继承button event
example：
	checkBox = CheckBox.new('fuck')
	self:addChild( checkBox )
	checkBox:setPosition( display.cx / 3, display.cy / 2 )
	checkBox:setTextSize( 50 )
	checkBox:setSpanWidth(37)
]]

local CheckBox = class("CheckBox",Button)

CheckBox.SPAN_WIDTH	= 40

--[[--
构造函数
	@param text  String        复选框文本
	@param imageToggle String 	按钮正常状态下的图片名字，如果是SpriteFrame，图片名字以#开头
	@param imageUp String       按钮正常状态下的图片名字，如果是SpriteFrame，图片名字以#开头
	@param imageDown String     按钮按下状态下的图片名字，如果是SpriteFrame，图片名字以#开头,没有的时候，取imageUp的值
	@param imageDisabled String 按钮禁用状态下的图片名字，如果是SpriteFrame，图片名字以#开头,没有的时候，取imageUp的值
]]
function CheckBox:ctor(text, span, fontSize, imageToggle,imageUp,imageDown,imageDisabled)
	assert(type(text) == "string",
           "[common.CheckBox] ctor() invalid text")
  
    local imageUp = imageUp or '#btn_blue8u.png'
    local imageToggle = imageToggle or '#btn_blue8s.png'
    local span = span or CheckBox.SPAN_WIDTH
    local fontSize = fontSize or 16
  
 	CheckBox.super.ctor(self,imageUp,imageDown,imageDisabled)
	self:toggleSelect(imageToggle)
	
	-- self._text = ui.newTTFLabel({
 --        text = text,
 --        size = 32,
 --        textAlign = ui.TEXT_ALIGN_LEFT,
 --        dimensions = CCSize(400, 30)
 --    })

	self._text = RichText.new(400, 30, fontSize )
 	self._text:retain()
 	self._text:setString(text)
   	self:addChild(self._text)

	self._text:setAnchorPoint(CCPoint(0, 1))
	local textW, textH = self._text:getTextContentSize()
	local size = self:getContentSize()
	self._text:setPosition(size.width + span, size.height / 2 + textH / 2)
	self:setContentSize(CCSize(size.width + span + textW, size.height))

end

--[[--
	设置文体
]]
function CheckBox:setString(str)
	str = tostring(str)
	self._text:setString(str)
end

--[[--
	设置复选框按钮和文本之间距离
]]
-- function CheckBox:setSpanWidth(width)
-- 	self._text:setPosition(self:getButtonSize().width / 2 + width, 0)
-- 	self:setContentSize(CCSize(size.width + self.SPAN_WIDTH + textW, size.height))
-- end

--[[--
	设置文本文字大小
	@param size  float 字体大小
]]
-- function CheckBox:setTextSize(size)
-- 	self._text:setFontSize(size)
-- end

function CheckBox:showBackground()
	local colorBg = CCLayerColor:create(GameConst.COLOR_PLACEHOLDER)
	self:addChild(colorBg)
end

--[[--
  	析构函数：移除事件监听、cleanup定时以及动作、点击监听，析构时调用
]]
function CheckBox:dispose()
	--移除事件监听

	--从父节点移除并清理

	--移除Touch监听

	--移除定时监听

	--移除节点事件监听
 
	--析构自己持有的计数引用
	self._text:release()
	self._text = nil
	--调用父结点dispose
	CheckBox.super.dispose(self)
end

return CheckBox

