--[[--
class：     FloatTip
inherit: CCLayer
desc：       通用飘字类
author:  zl
example：
	floatBar = FloatTip.new("floatBg.png")
	self:addChild(proBar)
	floatBar:startFloat("Hello")
]]


local FloatTip = class("FloatTip", function ()
	return display.newNode()
end)


--[[
	构造函数
	@param barImage string    背景图
	@param startPoint CCPoint    起飘位置 屏幕中央位置
	@param endPoint CCPoint 结束位置 屏幕中央y+100
	@param text string 文本 default ""
	@param fontName string 字体 default:宋体
	@param fontSize number 大小 default:18
	@param frontColor ccc3 字体颜色值 default:ccc3(255, 255, 255)
]]
function FloatTip:ctor(bg, fontSize, fontColor, startPoint, endPoint)
	bg = bg or "#com_ty_dm.png"

	self.bgImage = display.newXSprite(bg)
	local rect = uihelper.getRect(bg)  --获取9宫 rect
	if rect then
		self.bgImage:setRect9(rect)
	end
	self:addChild(self.bgImage)

	local startX = display.width/2
	local startY = display.height/2-100
	local deltaX = 500
	self._startPoint = startPoint or ccp(startX, startY)
	self._endPoint = endPoint or ccp(startX, startY + deltaX)
	self._isFloating = false

--width,height,fontSize,color,linesPacing,align,alignV,shadow
	self._lable = RichText.new(display.width,50)
	self._lable:setFontType(RichText.FontType.outline)
	self._lable:setParams({fontSize=fontSize, color=fontColor, align=RichText.CENTER, alignV=RichText.CENTER})
	--,fontSize or 24,fontColor or display.COLOR_WHITE,0,UIInfo.CENTER,UIInfo.CENTER
	self._lable:setAnchorPoint(ccp(0.5, 0.5))
	self:addChild(self._lable)

	self:setPosition(self._startPoint)

	self:retain()
end

function FloatTip:setColor( color )
	self._lable:setColor(color)
end

--[[
	开始飘字
	@param text string 文本
	注：会顶替掉上一条的飘字
]]
function FloatTip:startFloat(text,offset)
	if self._isFloating then
		self:_stop()
	end
	self._lable:setText(text)
	-- local w,h = self._lable:getTextContentSize()
	-- w = w + 10
	-- if w < 180 then w = 180 else w = w + 100 end
	-- if h < 45 then h = 45 else h = h + 30 end
	-- self.bgImage:setImageSize(CCSize(w,h))

	if offset then
		self:setPosition(self._startPoint.x + offset.x,self._startPoint.y + offset.y)
	else
		self:setPosition(self._startPoint)
	end

	self._isFloating = true
	self:_start()
end


function FloatTip:_start()

	local moveAction = CCMoveTo:create(self._duration or 5 , self._endPoint)
	local endAction1 = CCCallFunc:create(handler(self, self._onMoveEnd))
	local seqAction1 = CCSequence:createWithTwoActions(moveAction, endAction1)
	self:runAction(seqAction1)

	local action = CCFadeOut:create(1.5)
	local endAction = CCCallFunc:create(handler(self, self._onMoveEnd))
	local seqAction = CCSequence:createWithTwoActions(action, endAction)
	self:runAction(seqAction)
	-- transition.execute(self, seqAction)
end

function FloatTip:_stop()
	self:stopAllActions()
	self._isFloating = false
end

function FloatTip:_onMoveEnd()
	self:removeFromParent()
	self._isFloating = false
end

function FloatTip:dispose()
	self:removeFromParent()
	self._lable:dispose()
	self:release()
end

return FloatTip
