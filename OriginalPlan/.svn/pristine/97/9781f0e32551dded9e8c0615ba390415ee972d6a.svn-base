--[[--
class：     UISimpleProgress
inherit: 	CCLayer
desc：       通用进度条类
author:  changao
date: 2014-06-03
		
example：
		UISimpleProgress = UISimpleProgress.new("bar.png",
								"bar_9.png",
								CCSize(300, 10),
								CCSize(400, 20),
								ccp(50, 10),
								100 )
		UISimpleProgress:setMaxProgress(39)
		UISimpleProgress:setProgress(10)
		UISimpleProgress:startProgressBy(100, 1, 0.1)
		UISimpleProgress:setPosition(ccp(0, 200))
		UISimpleProgress:setText("aaaaaaaaaa")
		
		--setClipRect(CCRect(x, y, w, h))
		UISimpleProgress:setClipMode(true, addedImageUrl) --暂时只支持 left to right
]]

--local UISimpleProgress = class("UISimpleProgress", function()return display.newLayer()end)
local UISimpleProgress = class("UISimpleProgress", function() return display.newNode() end)



function UISimpleProgress:ctor(barImage, barMaxSize, chipMode)
	self:retain()
	self._barMaxSize = barMaxSize
	self._curProgress = 0
	self._maxProgress = maxProgress or 100
	self._barImageUrl = barImage
	
	self._barImage = display.newXSprite(barImage)


	uihelper.setRect9(self._barImage, barImage)

	
	if not self._barMaxSize then 
		self._barMaxSize = self._barImage:getContentSize() 
	else
		self._barImage:setImageSize(self._barMaxSize)
	end

	self._barImage:retain()
	self._barImage:setAnchorPoint(ccp(0, 0))
	self:addChild(self._barImage)
	--self._barImage:setPosition(self._position)
	
	self:ignoreAnchorPointForPosition(false)
	self:setAnchorPoint(ccp(0, 0))
	self:setContentSize(self._barMaxSize)

	self._clipMode = chipMode
	self:_updateProgress()
end

function UISimpleProgress:getBarSize()
	return self._barMaxSize
end

function UISimpleProgress:setRightToLeft(flag)
	assert(nil, "no implement")
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


function UISimpleProgress:setBarImage(imageUrl, update)
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


function UISimpleProgress:setClipMode(flag, addedImageUrl, anchor)
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


function UISimpleProgress:setRect9(barInset)
	if not barInset then
		uihelper.setRect9(self._barImage, self._barImageUrl)
	else
		self._barInsets = barInset
	end
end


function UISimpleProgress:setCurProgress(cur,max)
	if max then
		self:setMaxProgress(max)
	end
	self:setProgress(cur)
end

--[[--
	设置进度进度条到某个进度
	@param progressNum number 进度条进度
]]
function UISimpleProgress:setProgress(progressNum)
	-- if progressNum == 0 then
	-- 	self._barImage:setVisible(false)
	-- else
	-- 	self._barImage:setVisible(true)
	-- end

	if  progressNum > self._maxProgress then
		progressNum = self._maxProgress
	end

	self._curProgress = progressNum
	self:_updateProgress()
end

--[[--
	改变进度条当前进度值
	@param deltanum number 进度改变值
]]
function UISimpleProgress:addProgress(deltanum)
	local progressNum = self._curProgress + deltanum
	self:setProgress(progressNum)
end

function UISimpleProgress:addProgressAdded(deltanum)
	local progressNum = self._curProgress + deltanum
	self:setProgress(progressNum)
end

function UISimpleProgress:setAddedImage(img)
	self._addedBarImageUrl = img
end

function UISimpleProgress:setAddedProgress(progress)
	if not self._addedBarImage then
		self._addedAnchorProgress = self._curProgress
		self._addedBarImage = UIImage.new(self._addedBarImageUrl, nil, true)
		self._addedBarImage:setPositionY(self._position.y)
		self:addChild(self._addedBarImage, 1)
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
		print("function UISimpleProgress:setAddedProgress(progress)", barWidth, width, height)
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

function UISimpleProgress:clearAddedProgress()
	if self._addedBarImage then
		self._addedBarImage:dispose()
		self._addedBarImage = nil
	end
end

--[[
	获取当前进度条进度
	@return number 当前进度
]]
function UISimpleProgress:getCurProgress()
	return self._curProgress
end

--[[
	设置进度条最大进度
	@param maxProgress number
]]
function UISimpleProgress:setMaxProgress(maxProgress)
	self._maxProgress = maxProgress
end

--[[
	返回进度条最大进度
	@param  number
]]
function UISimpleProgress:getMaxProgress()
	return self._maxProgress
end

--[[
@brief 更新进度的处理。 包括更新图片等。 
]]--
function UISimpleProgress:_updateProgress()
	local barImage = self._barImage
	-- local scaleX = self._curProgress/self._maxProgress
	-- barImage:setScaleX(scaleX)
	if self._curProgress <= 0 then
		barImage:setVisible(false)
	else
		local width = self._barMaxSize.width*self._curProgress/self._maxProgress
		local height = self._barMaxSize.height
		print("function UISimpleProgress:_updateProgress()", width, height)
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
end


--[[
	进度条从某一进度到另一个进度
	@param startNum number 起始进度
	@param endNum number 结束进度
	@param stepNum number 每个时间改变进度
	@param interval number 时间间隔
	@return number 当前进度
]]
function UISimpleProgress:startProgressTo(startNum, endNum, stepNum, interval,callback)
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
function UISimpleProgress:startProgressBy( deltaNum, stepNum, interval,callback )
	self._deltaNum = deltaNum
	self._stepNum = stepNum or self._deltaNum/30
	interval = interval or 0.03
    self.endCallback = callback
	self:_addMoveHandler(handler(self, self._moveFun), interval)
end

--[[
@brief 进度条变动时候的处理函数
]]--
function UISimpleProgress:_moveFun()
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
function UISimpleProgress:_getLeftProgress()
	return self._maxProgress - self._curProgress
end


--[[
@brief 添加移动监听
@return int
]]--
function UISimpleProgress:_addMoveHandler(moverHandler, interval)
	self:_removeMoveHandler()
	local schedule = CCDirector:sharedDirector():getScheduler()
	self._moveHandler = schedule:scheduleScriptFunc(moverHandler, interval, false)
end

--[[
@brief 移除移动监听句柄
]]--
function UISimpleProgress:_removeMoveHandler()
	if self._moveHandler then
		local schedule = CCDirector:sharedDirector():getScheduler()
		schedule:unscheduleScriptEntry(self._moveHandler)
		self._moveHandler = nil
	end
end



function UISimpleProgress:clearImage(canRecover)
	if self._barImage then
		self._barImage:setSpriteImage(nil)
	end
	
	if canRecover then
		self._canRecover = true
	else
		self._barImageUrl = nil
	end
end

function UISimpleProgress:recoverImage()
	assert(self._canRecover, "function UISimpleProgress:clearImage(canRecover) canRecover must be true")
	if self._barImage then
		self._barImage:setSpriteImage(self._barImageUrl)
		self._barImage:setImageSize(self._barMaxSize)
	end

	self:_updateProgress()
end

function UISimpleProgress:dispose()
	self:clearImage()

	self:clearAddedProgress()
	
	--从父节点移除
	self:removeFromParent()
	
	if self._addedImage then
		self._addedImage:dispose()
		self._addedImage = nil
	end
	
	self._barImage = nil
	self._curProgress = nil
	self._maxProgress = nil
	self._barInsets = nil
	self:release()
end

return UISimpleProgress