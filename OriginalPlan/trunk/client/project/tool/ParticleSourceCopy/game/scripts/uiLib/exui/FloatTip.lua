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
	return display.newLayer()
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
function FloatTip:ctor(bgImage, startPoint, endPoint, text, fontName, fontSize, fontColor)
	self._bgImage = bgImage or "#floatBg.png"
	local winSize = CCDirector:sharedDirector():getWinSize()
	local startX = winSize.width/2
	local startY = winSize.height/2 + 100
	local deltaX = 50
	self._startPoint = startPoint or ccp(startX, startY)
	self._endPoint = endPoint or ccp(startX, startY + deltaX)
	self._text = text or ""
	self._fontName = fontName or "宋体"
	self._fontSize = fontSize or 18
	self._fontColor = fontColor or ccc3(255, 255, 255)
	self._lable = nil
	self._isFloating = false
	self._duration= 2.0
	self:_update()
	self:retain()
end

--[[
	开始飘字
	@param text string 文本
	注：会顶替掉上一条的飘字
]]
function FloatTip:startFloat(text)
	-- if self._text == text then
	-- 	return
	-- end

	if self._isFloating then
		self:_stop()
	end

	self:setVisible(true)
	self._isFloating = true
	self._text = text
	self:_update()
	self:_start()
end


function FloatTip:_start()
	local moveAction = CCMoveTo:create(self._duration, self._endPoint)
	local endAction = CCCallFunc:create(handler(self, self._onMoveEnd))
	local seqAction = CCSequence:createWithTwoActions(moveAction, endAction)
	self:runAction(seqAction)
end

function FloatTip:_stop()
	self:setVisible(false)
	self:stopAllActions()
	self._isFloating = false
	self._text = nil
end

-- function FloatTip:_outRetainCount()
-- 	-- self._debug("self._moveAction", self._moveAction)
-- 	-- self._debug("self._endAction", self._endAction)
-- 	-- self._debug("self._seqAction", self._seqAction)
-- end

-- function FloatTip._debug(objName, obj)
-- 	print(objName, " retain count:", obj:retainCount())
-- end

function FloatTip:_onMoveEnd()
	self:_stop()
end

function FloatTip:_update()
	
	-- local image = self._bgImage
	-- if type(image) == "string" then
	-- 	image = display.newSprite(image)
	-- 	self:addChild(image)
	-- 	image:retain()
	-- 	self._bgImage = image
	-- end

	local imageSize = CCSize(100,50)--image:getContentSize()
	local lable = self._lable
	if not  lable then
		-- lable = CCLabelTTF:create()
		lable = RichText.new(imageSize.width,
						self._fontSize,
						self._fontSize,
						self._fontColor,
						0,
						RichText.ALIGN_CENTER)
		lable:setAnchorPoint(ccp(0.5, 0.5))
		-- lable:setPosition()
		--image:addChild(lable)
		self:addChild(lable)
		lable:retain()
		self._lable = lable
	end


	
	lable:setPosition(imageSize.width/2, imageSize.height/2)
	lable:setString(self._text)
	-- lable:setFontName(self._fontName)
	-- lable:setColor(self._fontColor)
	-- lable:setFontSize(self._fontSize)
	self:setPosition(self._startPoint)
end

function FloatTip:dispose()
	--停动作
	self:_stop()

	--从父节点移除
	self:cleanup() 
	self:removeFromParentAndCleanup(true)

	--析构自己持有的计数引用
	self._lable:dispose()
	self._lable:release()
	--self._bgImage:release()
	self._lable = nil
	self._bgImage = nil

	--析构自己
	self:release()
end

return FloatTip