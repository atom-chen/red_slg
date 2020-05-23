--[[--
class：     UIProgressBar
inherit: 	CCLayer
desc：       通用进度条类
author:  changao
date: 2014-06-03
event:  Event.PROGRESS_END
		Event.PROGRESS_MAX
		
example：
		UIProgressBar = UIProgressBar.new("bar.png",
								"bar_9.png",
								CCSize(300, 10),
								CCSize(400, 20),
								ccp(50, 10),
								100 )
		UIProgressBar:setProgress(10)
		UIProgressBar:startProgressBy(100, 1, 0.1)
		UIProgressBar:setPosition(ccp(0, 200))
		UIProgressBar:setTextFormat(UIProgressBar.TEXT_FORMAT_PERCENT)
		UIProgressBar:setTextFormat(UIProgressBar.TEXT_FORMAT_RATIO)
		lable = CCLabelTTF:create()
		lable:setFontName("宋体")
		lable:setColor(ccc3(255, 0, 0))
		lable:setFontSize(30)
		UIProgressBar:setLableText(lable)
		UIProgressBar:clearLableText()
		UIProgressBar:setText("aaaaaaaaaa")
]]

local UIProgressBar = class("UIProgressBar", function()
	return display.newLayer()
end)


--[[--
	构造函数
	@param barImage string   		进度条图片
	@param bgImage string    		背景图片图片
	@param barMaxSize		 		滚动条大小
	@param bgMaxSize				背景图大小
	@param position CCPoint  		进度条相对于背景背景图位置。锚点在(0, 0)
	@param maxProgress number		进度进度基数
]]

UIProgressBar.TEXT_FORMAT_PERCENT = 1 --进度百分比显示 10%
UIProgressBar.TEXT_FORMAT_RATIO = 2 	--进度比例显示3/4

function UIProgressBar:ctor(barImage, bgImage, barMaxSize, bgMaxSize, position, maxProgress)
	EventProtocol.extend(self)
	
	self._barInsets = barInsets
	self._bgInsets = bgInsets
	self._textFormat = self.TEXT_FORMAT_RATIO
	self._barMaxSize = barMaxSize
	self._bgMaxSize = bgMaxSize
	self._curProgress = 0
	self._maxProgress = maxProgress or 100

	self._lableText = nil

	self._barImage = display.newXSprite(barImage)
	self._bgImage = display.newXSprite(bgImage)

	if not self._barMaxSize then 
		self._barMaxSize = self._barMaxSize:getImgSize() 
	else
		self._barImage:setImageSize(self._barMaxSize)
	end
	
	if not self._bgMaxSize then 
		self._bgMaxSize = self._bgImage:getImgSize()
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
	self._bgImage:addChild(self._barImage)
	
	self:ignoreAnchorPointForPosition(false)
	self:setAnchorPoint(ccp(0, 0))
	self:setContentSize(self._bgMaxSize)

	self:_updateProgress()
	self:retain()
end


--[[
	设置进度条/背景的九宫格
	@param barInset CCRect 进度条九宫缩放范围
	@param bgInset CCRect 背景九宫缩放范围
]]
function UIProgressBar:setRect9(barInset, bgInset)
	self._barInsets = barInset
	self._bgInsets = bgInset
end


--[[
	设置进度条滚动时显示文本格式格式
	@param format 	枚举类型 详见UIProgressBar.TEXT_FORMAT_*
]]

function UIProgressBar:setTextFormat(format)
	if self._textFormat == format then
		return
	end

	self._textFormat = format
	self:_updateText()
end

--[[
	清除显示文本
]]
function UIProgressBar:clearLableText()
	if self._lableText then
		self._bgImage:removeChild(self._lableText)
		self._lableText:release()
		self._lableText = nil
	end
end

function UIProgressBar:_updateText()
	if not self._lableText then
		return
	end


	if not self._formatList then
		self._formatList = {}
	end

	self._formatList[self.TEXT_FORMAT_PERCENT] = (self._curProgress/self._maxProgress*100).."%"
	self._formatList[self.TEXT_FORMAT_RATIO] = self._curProgress.."/"..self._maxProgress

	local text = self._formatList[self._textFormat]
	if  text then
		self:setText(text)
		return
	end

end
--[[
	设置文本lableText
	@param lableText CCLabelTTF
]]
function UIProgressBar:setLableText(lableText)
	self:clearLableText()

	lableText:retain()
	self._lableText = lableText
	self._bgImage:addChild(lableText)
	-- self:_updateText()
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
function UIProgressBar:setText(text, fontSize, fontName, fontColor, align, valign)
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
		text:setAlignInParent(self, self._bgMaxSize, align, valign)
		self._text = text
	else
		self._text.setText(text, fontSize, fontName, fontColor)
		if align and valign then
			self._text:setAlignInParent(self, self._bgMaxSize, align, valign)
		end
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

--[[
	设置显示文本
	@param lableText CCLabelTTF

function UIProgressBar:setText(text)
	if not text then
		return
	end

	local lableText = self._lableText
	if  not lableText then
		lableText = CCLabelTTF:create()
		lableText:setString(text)
		lableText:retain()
		self._lableText = lableText
		self._lableText:setPosition( ccp(self._bgMaxSize.width/2, self._bgMaxSize.height/2) )
		self._bgImage:addChild(lableText)
	else
		self._lableText:setPosition( ccp(self._bgMaxSize.width/2, self._bgMaxSize.height/2) )
		lableText:setString(text)
	end
end]]

--[[--
	设置进度进度条到某个进度
	@param progressNum number 进度条进度
]]
function UIProgressBar:setProgress(progressNum)
	-- if progressNum == 0 then
	-- 	self._barImage:setVisible(false)
	-- else
	-- 	self._barImage:setVisible(true)
	-- end

	if  progressNum > self._maxProgress then
		progressNum = self._maxProgress
	end

	if self._curProgress ~= progressNum then
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
function UIProgressBar:_updateProgress()
	local bgImage = self._bgImage;
	local barImage = self._barImage
	-- local scaleX = self._curProgress/self._maxProgress
	-- barImage:setScaleX(scaleX)
	if self._curProgress <= 0 then
		barImage:setVisible(false)
	else
		local width = self._barMaxSize.width*self._curProgress/self._maxProgress
		local height = self._barMaxSize.height
		barImage:setImageSize(CCSize(width,height))
		barImage:setPosition(self._position)
		barImage:setVisible(true)
	end
	self:_updateText()
end


--[[
	进度条从某一进度到另一个进度
	到达目标进度会发出Event.PROGRESS_END 事件
	@param startNum number 起始进度
	@param endNum number 结束进度
	@param stepNum number 每个时间改变进度
	@param interval number 时间间隔
	@return number 当前进度
]]
function UIProgressBar:startProgressTo(startNum, endNum, stepNum, interval)
	local deltaNum = endNum - startNum
	self:setProgress(startNum)
	self:startProgressBy(deltaNum, stepNum, interval)
end

--[[
	进度条从某一进度到另一个进度
	到达目标进度会发出Event.PROGRESS_END 事件
	@param deltaNum number 进度改变值
	@param stepNum number 每个时间改变进度
	@param interval number 时间间隔
	@return number 当前进度
]]
function UIProgressBar:startProgressBy( deltaNum, stepNum, interval )
	self._deltaNum = deltaNum
	self._stepNum = stepNum
	self._moveHandler = self:_addMoveHandler(handler(self, self._moveFun), interval)
end

--[[
@brief 进度条变动时候的处理函数
]]--
function UIProgressBar:_moveFun()
	local leftProgress = self:_getLeftProgress()

	if self._deltaNum ~= 0 then
		--剩余进度够减少
		if leftProgress > self._stepNum  then
			self._deltaNum = self._deltaNum - self._stepNum
			self:addProgress(self._stepNum)
		else
			--剩余进度不够减少
			self._deltaNum = self._deltaNum - leftProgress
			self:addProgress(leftProgress)
			self._deltaNum = 0
		end
	end

	if self._deltaNum <= 0 then
		self:_removeMoveHandler()
		if self:getCurProgress() < self:getMaxProgress() then
			self:dispatchEvent({name = Event.PROGRESS_END})
		else
			self:dispatchEvent({name = Event.PROGRESS_MAX})
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
	return schedule:scheduleScriptFunc(moverHandler, interval, false)
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


function UIProgressBar:dispose()
	--移除事件监听
	self:removeAllEventListenersForEvent(Event.PROGRESS_END)
	self:removeAllEventListenersForEvent(Event.PROGRESS_MAX)

	--从父节点移除
	self:cleanup() 
	self:removeFromParentAndCleanup(true)


	--移除Touch监听

	--移除定时监听
	self:_removeMoveHandler()
	--移除节点事件监听

	--析构自己持有的计数引用
	self:clearLableText()

	self._barImage:release()
	self._bgImage:release()
	
	if self._text then
		self._text:dispose()
		self._text = nil
	end
	
	self._barImage = nil
	self._bgImage = nil
	self._curProgress = nil
	self._maxProgress = nil
	self._bgInsets  = nil
	self._barInsets = nil
	self:release()
end

return UIProgressBar