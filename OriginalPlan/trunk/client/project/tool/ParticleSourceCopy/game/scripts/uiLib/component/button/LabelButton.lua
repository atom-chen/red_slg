--[[--
class：   LabelButton
inherit:Button
desc：      标签按钮类
author: HAN Biao
event：
	Event.MOUSE_DOWN:鼠标按下时，发出此事件
	Event.MOUSE_UP：   鼠标松开时，发出此事件
example：
	local labelbtn = LabelButton.new("开始游戏","blb0u.png","blb0d.png","blb0n.png")
	labelbtn:setPosition(ccp(400,150))
	self:addChild(labelbtn)
	labelbtn:addEventListener(Event.MOUSE_UP,{self,self.onClickBtn})
]]

local LabelButton = class("LabelButton",Button)

--文本按钮的默认字体
LabelButton.DEFAULT_FONT_SIZE = 20

--[[--
	构造函数
	@param label  String        按钮上的文本
	@param imageUp String       按钮正常状态下的图片名字，如果是SpriteFrame，图片名字以#开头
	@param imageDown String     按钮按下状态下的图片名字，如果是SpriteFrame，图片名字以#开头
	@param imageDisabled String 按钮禁用状态下的图片名字，如果是SpriteFrame，图片名字以#开头
	@param size  Number         按钮上文字的大小,默认为20，可选参数
]]
function LabelButton:ctor(label,imageUp,imageDown,imageDisabled,size)
	LabelButton.super.ctor(self,imageUp,imageDown,imageDisabled)

	local params = {}
	params.text = label
    params.size = size or LabelButton.DEFAULT_FONT_SIZE
	params.color = display.COLOR_WHITE
    params.align = ui.TEXT_ALIGN_CENTER
    params.valign = ui.TEXT_VALIGN_CENTER
   	params.dimensions = self:getButtonSize()
	self._labelTxt = ui.newTTFLabel(params)
	self._labelTxt:retain()
	self._labelTxt:setPosition(self._offsetX,self._offsetY)
	self:addChild(self._labelTxt,1)
end

--[[--
	设置按钮上的文本
	@param label String
]]
function LabelButton:setLabel(label)
	self._labelTxt:setString(label)
end

function LabelButton:setFontSize(size)
	self._labelTxt:setFontSize(size)
end

--[[--
	析构函数
]]
function LabelButton:dispose()
	self._labelTxt:release()
	self._labelTxt = nil
	LabelButton.super.dispose(self)
end

return LabelButton