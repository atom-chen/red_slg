--[[--
class：     ProgressBar
inherit: CCLayer
desc：       通用进度条类
author:  zl
example：
		progressBar = ProgressBar.new("bar.png",
								CCRect(0, 0, 386, 16),
								"bar_9.png",
								CCRect(0, 0, 106, 12),
								CCSize(300, 10),
								CCSize(400, 20),
								ccp(50, 10),
								1000 )
		progressBar:setProgress(10)
		progressBar:startProgressBy(100, 1, 0.1)
		progressBar:setPosition(ccp(0, 200))
		progressBar:setTextFormat(progressBar.TEXT_FORMAT_PERCENT)
		progressBar:setTextFormat(progressBar.TEXT_FORMAT_RATIO)
		lable = CCLabelTTF:create()
		lable:setFontName("宋体")
		lable:setColor(ccc3(255, 0, 0))
		lable:setFontSize(30)
		progressBar:setLableText(lable)
		progressBar:clearLableText()
		progressBar:setText("aaaaaaaaaa")
]]

local ProgressBar = class("ProgressBar", function()
	return display.newLayer()
end)


--[[--
	构造函数
	@param barImage string   		进度条图片
	@param barInsets CCRect  		进度条九宫缩放范围
	@param bgImage string    		背景图片图片
	@param bgInsets CCRect   		背景九宫缩放范围
	@param barMaxSize		 		滚动条大小
	@param bgMaxSize				背景图大小
	@param position CCPoint  		进度条相对于背景背景图位置。锚点在(0, 0)
	@param maxProgress number		进度进度基数
]]

ProgressBar.TEXT_FORMAT_PERCENT = 1 --进度百分比显示 10%
ProgressBar.TEXT_FORMAT_RATIO = 2 	--进度比例显示3/4

function ProgressBar:ctor(barImage, barInsets, bgImage, bgInsets, barMaxSize, bgMaxSize, position, maxProgress)
	EventProtocol.extend(self)


	self._barImage = barImage
	self._bgImage = bgImage
	self._barInsets = barInsets
	self._bgInsets = bgInsets
	self._textFormat = self.TEXT_FORMAT_RATIO
	self._barMaxSize = barMaxSize
	self._bgMaxSize = bgMaxSize
	self._position = position or ccp((bgMaxSize.width - barMaxSize.width)/2, (bgMaxSize.height - barMaxSize.height)/2)
	self._curProgress = 0
	self._maxProgress = maxProgress or 100

	self._lableText = nil

	self:ignoreAnchorPointForPosition(false)
	self:setAnchorPoint(ccp(0, 0))
	self:setContentSize(bgMaxSize)

	self:_updateProgress()
	
end

--[[
	设置进度条滚动时显示文本格式格式
	@param format 	枚举类型 详见ProgressBar.TEXT_FORMAT_*
]]

function ProgressBar:setTextFormat(format)
	if self._textFormat == format then
		return
	end

	self._textFormat = format
	self:_updateText()
end

--[[
	清除显示文本
]]
function ProgressBar:clearLableText()
	if self._lableText then
		self._bgImage:removeChild(self._lableText)
		self._lableText:release()
		self._lableText = nil
	end
end

function ProgressBar:_updateText()
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
function ProgressBar:setLableText(lableText)
	self:clearLableText()

	lableText:retain()
	self._lableText = lableText
	self._bgImage:addChild(lableText)
	-- self:_updateText()
end

--[[
	设置显示文本
	@param lableText CCLabelTTF
]]
function ProgressBar:setText(text)
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
end

--[[--
	设置进度进度条到某个进度
	@param progressNum number 进度条进度
]]
function ProgressBar:setProgress(progressNum)
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
function ProgressBar:addProgress(deltanum)
	local progressNum = self._curProgress + deltanum
	self:setProgress(progressNum)
end

--[[
	获取当前进度条进度
	@return number 当前进度
]]
function ProgressBar:getCurProgress()
	return self._curProgress
end

--[[
	设置进度条最大进度
	@param maxProgress number
]]
function ProgressBar:setMaxProgress(maxProgress)
	self._maxProgress = maxProgress
end

--[[
	返回进度条最大进度
	@param  number
]]
function ProgressBar:getMaxProgress()
	return self._maxProgress
end

function ProgressBar:_updateProgress()
	local bgImage = self._bgImage;
	if type(bgImage) == "string" then
		bgImage = display.newScale9Sprite(bgImage)
		bgImage:setCapInsets(self._bgInsets)
		bgImage:setContentSize(self._bgMaxSize)
		bgImage:retain()
		bgImage:setAnchorPoint(ccp(0, 0))
		self._bgImage = bgImage
		self:addChild(bgImage)
	end

	local barImage = self._barImage
	if type(barImage) == "string" then
		barImage = display.newScale9Sprite(barImage)
		barImage:setCapInsets(self._barInsets)
		barImage:setContentSize(self._barMaxSize)
		barImage:retain()
		self._barImage = barImage
		barImage:setAnchorPoint(ccp(0, 0))
		bgImage:addChild(barImage)
	end

	-- local scaleX = self._curProgress/self._maxProgress
	-- barImage:setScaleX(scaleX)
	if self._curProgress <= 0 then
		barImage:setVisible(false)
	else
		local width = self._barMaxSize.width*self._curProgress/self._maxProgress
		local height = self._barMaxSize.height
		barImage:setContentSize(CCSize(width,height))
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
function ProgressBar:startProgressTo(startNum, endNum, stepNum, interval)
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
function ProgressBar:startProgressBy( deltaNum, stepNum, interval )
	self._deltaNum = deltaNum
	self._stepNum = stepNum
	self._moveHandler = self:_addMoveHandler(handler(self, self._moveFun), interval)
end


function ProgressBar:_moveFun()
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

function ProgressBar:_getLeftProgress()
	return self._maxProgress - self._curProgress
end

function ProgressBar:_addMoveHandler(moverHandler, interval)
	self:_removeMoveHandler()
	local schedule = CCDirector:sharedDirector():getScheduler()
	return schedule:scheduleScriptFunc(moverHandler, interval, false)
end

function ProgressBar:_removeMoveHandler()
	if self._moveHandler then
		local schedule = CCDirector:sharedDirector():getScheduler()
		schedule:unscheduleScriptEntry(self._moveHandler)
		self._moveHandler = nil
	end
end



function ProgressBar:dispose()
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




	self._barImage = nil
	self._bgImage = nil
	self._curProgress = nil
	self._maxProgress = nil
	self._bgInsets  = nil
	self._barInsets = nil
end

return ProgressBar