--[[--
class：     UIProgressBar
inherit: 	CCLayer
desc：       通用进度条类
author:  changao
date: 2014-06-03

example：
		UIProgressBar = UIProgressBar.new("bar.png",
								"bar_9.png",
								CCSize(300, 10),
								CCSize(400, 20),
								ccp(50, 10),
								100 )
		UIProgressBar:setMaxProgress(39)
		UIProgressBar:setProgress(10)
		UIProgressBar:startProgressBy(100, 1, 0.1)

		--setClipRect(CCRect(x, y, w, h))
		UIProgressBar:setClipMode(true, addedImageUrl) --暂时只支持 left to right
]]

--local UIProgressBar = class("UIProgressBar", function()return display.newLayer()end)
local UIProgressBar = class("UIProgressBar", TouchBase)


--[[--
	构造函数
	@param barImage string   		进度条图片
	@param bgImage string    		背景图片图片
	@param barMaxSize		 		滚动条大小
	@param bgMaxSize				背景图大小
	@param position CCPoint  		进度条相对于背景背景图位置。锚点在(0, 0)
	@param maxProgress number		进度进度基数
]]

function UIProgressBar:ctor(barImage, bgImage, barMaxSize, bgMaxSize, position, maxProgress, priority, swallowTouches)
	TouchBase.ctor(self,priority,swallowTouches,false)
	EventProtocol.extend(self)

	self._barInsets = barInsets
	self._bgInsets = bgInsets
	self._barMaxSize = barMaxSize
	self._bgMaxSize = bgMaxSize
	self._curProgress = 0
	self._maxProgress = maxProgress or 100

	self._barImageUrl = barImage
	self._bgImageUrl = bgImage

	self._barImage = display.newXSprite(barImage)
	self._bgImage = display.newXSprite(bgImage)

	uihelper.setRect9(self._barImage, barImage)
	uihelper.setRect9(self._bgImage, bgImage)

	if not self._barMaxSize then
		self._barMaxSize = self._barImage:getContentSize()
	else
		self._barImage:setImageSize(self._barMaxSize)
	end

	if not self._bgMaxSize then
		self._bgMaxSize = self._bgImage:getContentSize()
	else
		self._bgImage:setImageSize(self._bgMaxSize)
	end

	self._position = position or ccp((self._bgMaxSize.width - self._barMaxSize.width)/2, (self._bgMaxSize.height - self._barMaxSize.height)/2)

	if self._bgInsets then
		self._bgImage:setRect9(self._bgInsets)
	end

	self._bgImage:retain()
	self._bgImage:setAnchorPoint(ccp(0, 0))
	self:addChild(self._bgImage)

	if self._barInsets then
		self._barImage:setRect9(self._barInsets)
	end

	self._barImage:retain()
	self._barImage:setAnchorPoint(ccp(0, 0))
	self._bgImage:addChild(self._barImage,1)

	self._barImage:setPosition(self._position)

	self:ignoreAnchorPointForPosition(false)
	self:setAnchorPoint(ccp(0, 0))
	self:setContentSize(self._bgMaxSize)

	self._clipMode = false
	self:_updateProgress()
	self:retain()

	self:setEnable(false)

end

function UIProgressBar:setBarOpacity( value )
	self._barImage:setOpacity(value)
end

function UIProgressBar:setBarOffSet( Xf,yf)
    local x,y = self._barImage:getPosition()
    x = x + Xf
    y = y + yf
    self._barImage:setPosition(x,y)
end

function UIProgressBar:getBgSize()
	return self._bgMaxSize
end

function UIProgressBar:getBarSize()
	return self._barMaxSize
end

function UIProgressBar:setEnable(enable)
	self._enable = tobool(enable)
	self:touchEnabled(self._enable)
end

function UIProgressBar:setRightToLeft(flag)
	if tobool(self._rightToLeft) ~= tobool(flag) then
		self._rightToLeft = tobool(flag)
		if self._rightToLeft then
			local right = ccp(self._position.x+self._barMaxSize.width, self._position.y)
			self._barImage:setPosition(right)
			self._barImage:setRotationY(180)
		else
			self._barImage:setPosition(self._position)
			self._barImage:setRotationY(180)
		end
	end
end

function UIProgressBar:bottomToTop(flag)
	if tobool(self._bottomToTop) ~= tobool(flag) then
		self._bottomToTop = tobool(flag)
	end
end

function UIProgressBar:setProgressPoint(node,offsetX,offsetY)
	self._curPointNode = node
	node._offsetX = offsetX or 0
	node._offsetY = offsetY or 0
	self:addChild(node,10)
	local height = self._bgImage:getContentSize().height
	node:setPositionY(height/2)
	local width = self._barMaxSize.width*self._curProgress/self._maxProgress
	local x = self._barImage:getPositionX()
	x = x + width
	self._curPointNode:setPosition(x+node._offsetX,self._barMaxSize.height/2+node._offsetY)
end

function UIProgressBar:setBgImage(imageUrl)
	if self._bgImageUrl ~= imageUrl then
		self._bgImageUrl = imageUrl
		self._bgImage:setSpriteImage(self._bgImageUrl)
		if self._bgImageUrl then
			self._bgImage:setImageSize(self._bgMaxSize)
		end
	end
end

function UIProgressBar:setBarImage(imageUrl, update)
	if self._barImageUrl ~= imageUrl then
		self._barImageUrl = imageUrl
		self._barImage:setSpriteImage(self._barImageUrl)
		if self._barImageUrl then
			uihelper.setRect9(self._barImage, self._barImageUrl)
			self._barImage:setImageSize(self._barMaxSize)
		end
	end
	if update then
		self:_updateProgress()
	end
end

--在进度条好 背景之间还有一个图片
function UIProgressBar:setBottomBar(imageUrl)
	if self._bottomImage == imageUrl then
		return
	end
	self._bottomImage = imageUrl
	if not self._bottomBar then
		self._bottomBar = display.newXSprite(imageUrl)
		self._bottomBar:setAnchorPoint(ccp(0,0))
		self._bgImage:addChild(self._bottomBar)
		local x,y = self._barImage:getPosition()
		self._bottomBar:setPosition(x,y)
		uihelper.setRect9(self._bottomBar, imageUrl)
		self._bottomBar:setImageSize(self._barMaxSize)
	else
		self._bottomBar:setSpriteImage(imageUrl)
		uihelper.setRect9(self._bottomBar, imageUrl)
	--	self._bottomBar:setPosition(x,y)
		self._bottomBar:setImageSize(self._barMaxSize)
	end
	--print("self._bottomBar ", self._bottomBar:getPositionY(), self._bottomBar:getContentSize().height, self._barImage:getPositionY(), self._barImage:getContentSize().height)
end

--[[
	--addedImageUrl 锚点在ccp(0, 0.5)
	--addedImageUrl anchor 只在 flag有变化的时候生效
--]]
function UIProgressBar:setClipMode(flag, addedImageUrl, anchor)
	local newMode = tobool(flag)
	if newMode ~= self._clipMode then
		if newMode then
			if addedImageUrl then
				self._addedImage = UIImage.new(addedImageUrl)
				self._barImage:addChild(self._addedImage)
				self._addedImage:setAnchorPoint(anchor or ccp(0, 0.5))
			end
		else
			if self._addedImage then
				self._addedImage:dispose()
				self._addedImage = nil
			end
		end
		self._clipMode = newMode
		self:_updateProgress()
	end
end

--[[
	设置进度条/背景的九宫格
	@param barInset CCRect 进度条九宫缩放范围
	@param bgInset CCRect 背景九宫缩放范围
]]
function UIProgressBar:setRect9(barInset, bgInset)
	if not barInset then
		uihelper.setRect9(self._barImage, self._barImageUrl)
	else
		self._barInsets = barInset
	end

	if not bgInset then
		uihelper.setRect9(self._bgImage, self._bgImageUrl)
	else
		self._bgInsets = bgInset
	end
end


--[[
@brief 构造 设置文字
@param text string
@param fontSize int 文字字体大小
@param fontName string 字体名称
@param fontColor ccc3 字体颜色
@param align UIInfo.alignment 水平对齐方式
@param valign UIInfo.alignment 竖直对齐方式
]]--
function UIProgressBar:setText(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow)
--(text, fontSize, fontName, fontColor, useRTF, shadow)
	local textParent = self
	if not self._textInfo then
		self._textInfo = {fontSize=fontSize, fontName=fontName, fontColor=fontColor, align=align, valign=valign, useRTF=useRTF, shadow=shadow}
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
		local textnode = UIAttachText.new(self._bgMaxSize.width, self._bgMaxSize.height, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor, self._textInfo.useRTF, self._textInfo.shadow)

		textParent:addChild(textnode)
		self._text = textnode

		if self._text:isRichText() then
			self._text:setAlignment(self._textInfo.align, self._textInfo.valign)
		end

		self._text:setText(text)
	else
		self._text:setText(text, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor)
	end

	-- align
	if not self._text:isRichText() then
		self._text:setAlignInParent(textParent, self._bgMaxSize, self._textInfo.align, self._textInfo.valign)
	end
end


--[[
@brief 获取文字内容
@return string 返回的文字
]]--
function UIProgressBar:getText()
	if not self._text then
		return nil
	end

	return self._text.getText()
end

function UIProgressBar:setCurProgress(cur,max)
	print("UIProgressBar:setProgress",cur,max)
	if max then
		self:setMaxProgress(tonumber(max))
	end
	self:setProgress(tonumber(cur))
end


--[[--
	设置进度进度条到某个进度
	@param progressNum number 进度条进度
]]
function UIProgressBar:setProgress(progressNum, forceUpdate)
	if  progressNum > self._maxProgress then
		progressNum = self._maxProgress
	end

	if self._curProgress ~= progressNum or forceUpdate then
		self._curProgress = progressNum
		self:_updateProgress()
	end

end

--[[--
	改变进度条当前进度值
	@param deltanum number 进度改变值
]]
function UIProgressBar:addProgress(deltanum)
	local progressNum = self._curProgress + deltanum
	self:setProgress(progressNum)
end

function UIProgressBar:addProgressAdded(deltanum)
	local progressNum = self._curProgress + deltanum
	self:setProgress(progressNum)
end

function UIProgressBar:setAddedImage(img)
	self._addedBarImageUrl = img
end

function UIProgressBar:setAddedProgress(progress)
	if not self._addedBarImage then
		self._addedAnchorProgress = self._curProgress
		self._addedBarImage = UIImage.new(self._addedBarImageUrl, nil, true)
		self._addedBarImage:setPositionY(self._position.y)
		self._bgImage:addChild(self._addedBarImage, 1)
	end


	if progress <= self._addedAnchorProgress then
		self:clearAddedProgress()
		self:setProgress(progress)
	else
		self:setProgress(self._addedAnchorProgress)
		self._curProgress = progress
		--self._maxProgress
		local p = progress - self._addedAnchorProgress

		local barWidth = self._barMaxSize.width*self._addedAnchorProgress/self._maxProgress
		local width = self._barMaxSize.width*p/self._maxProgress
		local height = self._barMaxSize.height
		--print("function UIProgressBar:setAddedProgress(progress)", barWidth, width, height)
		if self._clipMode then
			self._addedBarImage:setClipRect(CCRect(barWidth,0,width,height))
			if self._addedImage then
				self._addedImage:setPosition(ccp(barWidth+width, height/2))
			end
		else
			self._addedBarImage:setImageSize(CCSize(width,height))
		end
		self._addedBarImage:setPositionX(self._position.x+barWidth)

	end
end

function UIProgressBar:clearAddedProgress()
	if self._addedBarImage then
		self._addedBarImage:dispose()
		self._addedBarImage = nil
	end
end

--[[
	获取当前进度条进度
	@return number 当前进度
]]
function UIProgressBar:getCurProgress()
	return self._curProgress
end

--[[
	设置进度条最大进度
	@param maxProgress number
]]
function UIProgressBar:setMaxProgress(maxProgress)
	self._maxProgress = maxProgress
end

--[[
	返回进度条最大进度
	@param  number
]]
function UIProgressBar:getMaxProgress()
	return self._maxProgress
end

--[[
@brief 更新进度的处理。 包括更新图片等。
]]--
function UIProgressBar:_updateProgress(targetWidth)
	local bgImage = self._bgImage;
	local barImage = self._barImage
	-- local scaleX = self._curProgress/self._maxProgress
	-- barImage:setScaleX(scaleX)
	local width = 0
	if self._curProgress <= 0 then
		barImage:setVisible(false)
	else
		width = targetWidth or self._barMaxSize.width*self._curProgress/self._maxProgress
		local height = self._barMaxSize.height
		if self._bottomToTop then
			width =  self._barMaxSize.width
			height = self._barMaxSize.height*self._curProgress/self._maxProgress
			local bottom = ccp(0, self._bgMaxSize.height-height-3)
			self._barImage:setPosition(bottom)
		end

		if self._clipMode then
			self._barImage:setClipRect(CCRect(0,0,width,height))
			if self._addedImage then
				self._addedImage:setPosition(ccp(width, height/2))
			end
		else
			barImage:setImageSize(CCSize(width,height))
		end
		--[[
		if self._rightToLeft then
			local x = self._position.x + self._barMaxSize.width - width
			barImage:setPositionX(x)
		else
			barImage:setPosition(self._position)
		end
		barImage:setPosition(self._position)
		--]]
		barImage:setVisible(true)
	end
	if self._curPointNode then
		local x = self._barImage:getPositionX()
		x = x + width
		self._curPointNode:setPositionX(x+self._curPointNode._offsetX)
	end
end


--[[
	进度条从某一进度到另一个进度
	@param startNum number 起始进度
	@param endNum number 结束进度
	@param stepNum number 每个时间改变进度
	@param interval number 时间间隔
	@return number 当前进度
]]
function UIProgressBar:startProgressTo(startNum, endNum, stepNum, interval,callback)
	if endNum > self._maxProgress then
		endNum = self._maxProgress
	end
	local deltaNum = endNum - startNum
	self:setProgress(startNum,true)
	self:startProgressBy(deltaNum, stepNum, interval,callback)
end

--[[
	@param deltaNum number 进度改变值
	@param stepNum number 每个时间改变进度
	@param interval number 时间间隔
	@return number 当前进度
]]
function UIProgressBar:startProgressBy( deltaNum, stepNum, interval,callback )
	self._deltaNum = deltaNum
	self._stepNum = stepNum or self._deltaNum/30
	interval = interval or 0.03
    self.endCallback = callback
	self:_addMoveHandler(handler(self, self._moveFun), interval)
end

--[[
@brief 进度条变动时候的处理函数
]]--
function UIProgressBar:_moveFun()
	local leftProgress = self:_getLeftProgress()

	if self._deltaNum ~= 0 then
		if self._stepNum < 0 then
			--剩余进度够减少
			-- print("进度。。。。。",self._deltaNum,self._stepNum)
			if self._deltaNum < self._stepNum  then
				self._deltaNum = self._deltaNum - self._stepNum
				self:addProgress(self._stepNum)
			else
				--剩余进度不够减少
				-- self._deltaNum = self._deltaNum - leftProgress
				self:addProgress(self._deltaNum)
				self._deltaNum = 0
			end
		else
			--剩余进度够减少
			if self._deltaNum > self._stepNum  then
				self._deltaNum = self._deltaNum - self._stepNum
				self:addProgress(self._stepNum)
			else
				--剩余进度不够减少
				--self._deltaNum = self._deltaNum - leftProgress
				self:addProgress(self._deltaNum)
				self._deltaNum = 0
			end
		end
	end

	if self._deltaNum == 0 then
		self:_removeMoveHandler()
		if self.endCallback then
			local cur,max = self:getCurProgress(),self:getMaxProgress()
			if cur+0.00001 >= max then
				self.endCallback(true)
			else
				self.endCallback(false)
			end
		end
	end
end

--[[
@brief 获取剩下的进度
@return number
]]--
function UIProgressBar:_getLeftProgress()
	return self._maxProgress - self._curProgress
end


--[[
@brief 添加移动监听
@return int
]]--
function UIProgressBar:_addMoveHandler(moverHandler, interval)
	self:_removeMoveHandler()
	local schedule = CCDirector:sharedDirector():getScheduler()
	self._moveHandler = schedule:scheduleScriptFunc(moverHandler, interval, false)
end

--[[
@brief 移除移动监听句柄
]]--
function UIProgressBar:_removeMoveHandler()
	if self._moveHandler then
		local schedule = CCDirector:sharedDirector():getScheduler()
		schedule:unscheduleScriptEntry(self._moveHandler)
		self._moveHandler = nil
	end
end

function UIProgressBar:setTouchRectByBg()
	self._touchRectNode = self._bgImage
end

function UIProgressBar:setTouchRectByBar()
	self._touchRectNode = self._barImage
end

-- [[
function UIProgressBar:touchContains(x, y)
	local that = self._touchRectNode or self._bgImage
	local parent = that:getParent()
	local pos = parent:convertToNodeSpace(ccp(x,y))
	local rect = that:boundingBox()
	if rect:containsPoint(pos) then
		return true
	else
		return false
	end
end
--]]
function UIProgressBar:onTouchDown(x,y)
	if not self._enable then return end
	self:dispatchEvent({name = Event.MOUSE_DOWN,target = self})
	self:dispatchEvent({name = Event.MOUSE_CLICK,target = self})
	return true
end

function UIProgressBar:onTouchUp(x,y)
	if not self._enable then return end
	self:dispatchEvent({name = Event.MOUSE_UP,target = self})
end

function UIProgressBar:onTouchCanceled(x,y)
	if not self._enable then return end
	self:dispatchEvent({name = Event.MOUSE_CANCEL,target = self})
end

function UIProgressBar:clearImage(canRecover)
	if self._barImage then
		self._barImage:setSpriteImage(nil)
	end

	if self._bgImage then
		self._bgImage:setSpriteImage(nil)
	end
	if canRecover then
		self._canRecover = true
	else
		self._barImageUrl = nil
		self._bgImageUrl = nil
	end
end

function UIProgressBar:recoverImage()
	assert(self._canRecover, "function UIProgressBar:clearImage(canRecover) canRecover must be true")
	if self._barImage then
		self._barImage:setSpriteImage(self._barImageUrl)
		self._barImage:setImageSize(self._barMaxSize)
	end

	if self._bgImage then
		self._bgImage:setSpriteImage(self._bgImageUrl)
		self._bgImage:setImageSize(self._bgMaxSize)
	end
	self:_updateProgress()
end

function UIProgressBar:dispose()
	self:clearImage()
	self:clearAddedProgress()

	--从父节点移除
	self:removeFromParent()

	--移除Touch监听

	--移除定时监听
	self:_removeMoveHandler()
	--移除节点事件监听

	self._barImage:release()
	self._bgImage:release()

	if self._text then
		self._text:dispose()
		self._text = nil
	end

	self._touchRectNode = nil
	self._barImage = nil
	self._bgImage = nil
	self._curProgress = nil
	self._maxProgress = nil
	self._bgInsets  = nil
	self._barInsets = nil
	self:release()
	TouchBase.dispose(self)
end

return UIProgressBar