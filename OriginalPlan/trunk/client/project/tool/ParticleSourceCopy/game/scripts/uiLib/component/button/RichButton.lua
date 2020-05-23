--[[--
class：   RichButton
inherit:Button
desc：      标签按钮类
author: zl
event：
	Event.MOUSE_DOWN:鼠标按下时，发出此事件
	Event.MOUSE_UP：   鼠标松开时，发出此事件
example：
	local richbtn = RichButton.new("开始游戏","blb0u.png","blb0d.png","blb0n.png")
	self:addChild(labelbtn)
	richbtn:addEventListener(Event.MOUSE_UP,{self,self.onClickBtn})
]]

local RichButton = class("RichButton",Button)

--文本按钮的默认字体
RichButton.DEFAULT_FONT_SIZE = 20

--[[--
	构造函数
	@param richStr String 	    按钮上富文本
	@param imageUp String       按钮正常状态下的图片名字，如果是SpriteFrame，图片名字以#开头
	@param imageDown String     按钮按下状态下的图片名字，如果是SpriteFrame，图片名字以#开头
	@param imageDisabled String 按钮禁用状态下的图片名字，如果是SpriteFrame，图片名字以#开头
	@param size  Number         按钮上文字的大小,默认为20，可选参数
	@param color 				文字颜色  默认白色
]]
function RichButton:ctor(richTxt,imageUp,imageDown,imageDisabled,size,color)
	RichButton.super.ctor(self,imageUp,imageDown,imageDisabled)
	size = size or RichButton.DEFAULT_FONT_SIZE
	color = color or GameConst.COLOR_WHITE

   	local btnSize = self:getButtonSize()
	self._richTxt = RichText.new(btnSize.width,
						size,
						size,
						color,
						0,
						RichText.ALIGN_CENTER)

	self._richTxt:setString(richTxt)
	self._richTxt:setAnchorPoint(ccp(0.5, 0.5))
	self._richTxt:retain()
	self._richTxt:setPosition(btnSize.width/2,btnSize.height/2)
	self:addChild(self._richTxt,1)
end

--[[--
	设置按钮上的文本
	@param label String
]]
function RichButton:setRichTxt(richTxt)
	self._richTxt:setString(richTxt)
end

--[[--
	析构函数
]]
function RichButton:dispose()
	self._richTxt:dispose()
	self._richTxt:release()
	self._richTxt = nil
	RichButton.super.dispose(self)
end

return RichButton