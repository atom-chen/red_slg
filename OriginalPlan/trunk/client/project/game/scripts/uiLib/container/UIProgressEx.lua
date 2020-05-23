--[[--
class：     UIProgressEx
inherit: 	CCLayer
desc：       通用进度条类
author:  changao
date: 2014-06-03

example：
		UIProgressEx = UIProgressEx.new("bar.png",
								"bar_9.png",
								CCSize(300, 10),
								CCSize(400, 20),
								ccp(50, 10),
								100 )

]]

--local UIProgressEx = class("UIProgressEx", function()return display.newLayer()end)
local UIProgressEx = class("UIProgressEx", function () return display.newNode() end)

function UIProgressEx:ctor(barImage, bar2Image, siz, margin)
	self:retain()
	local bar = display.newXSprite(barImage)
	self._barSize = bar:getContentSize()
	self._size = siz
	self._curProgress = 0
	self._maxProgress = 100
	self._newProgress = 0
	self._nodes = {}
	self._urls = {}
	self._barImage = barImage
	self._bar2Image = bar2Image
	self:setMargin(margin or 0)
	self:retain()
end

function UIProgressEx:setBarSize(siz)
	self._barSize = siz
end

function UIProgressEx:setMaxProgress(maxProgress)
	self._maxProgress = maxProgress
end

function UIProgressEx:setMargin(margin)
	self._margin = margin
end

function UIProgressEx:setNewImage( newImageUrl )
	-- body
	self._bar2Image = newImageUrl
end

function UIProgressEx:setCurImage( curImageUrl )
	-- body
	self._barImage = curImageUrl
end

function UIProgressEx:setProgress(cur, new, maxProgress)
	print("function UIProgressEx:setProgress(cur, new, maxProgress)", cur, new, maxProgress)
	if maxProgress then
		self:setMaxProgress(maxProgress)
	end

	local maxCount = math.floor((self._size.width + self._margin)/(self._barSize.width + self._margin))
	local newCnt = 0
	local curCnt = 0
	if not new then
		newCnt = 0
		curCnt = math.floor(cur/self._maxProgress*maxCount)
	else
		curCnt = math.floor(cur/self._maxProgress*maxCount)
		newCnt = math.floor(new/self._maxProgress*maxCount)
		if newCnt < curCnt then
			curCnt = 0
		end
	end
	curCnt = math.max(curCnt, 0)
	newCnt = math.max(newCnt, 0)

	curCnt = math.min(curCnt, maxCount)
	newCnt = math.min(newCnt, maxCount)


	print(curCnt, newCnt, self._maxProgress, maxCount, self._size.width)
	local img = self._barImage
	for i=1,curCnt do
		local node = self._nodes[i]
		if not node then
			node = display.newXSprite(img)
			self:addChild(node)
			node:setAnchorPoint(ccp(0, 0))
			node:setPositionX((self._barSize.width+self._margin)*(i-1))
			self._nodes[i] = node
		--	print(img, node:getPosition())
		elseif img ~= self._urls[i] then
			node:setSpriteImage(img)
			self._urls[i] = img
		end
	end

	img = self._bar2Image
	for i=curCnt+1,newCnt do
		local node = self._nodes[i]
		if not node then
			node = display.newXSprite(img)
			self:addChild(node)
			node:setAnchorPoint(ccp(0, 0))
			node:setPositionX((self._barSize.width+self._margin)*(i-1))
	--		print(img, node:getPosition())
			self._nodes[i] = node
		elseif img ~= self._urls[i] then
			node:setSpriteImage(img)
			self._urls[i] = img
		end
	end

	for i=math.max(curCnt, newCnt)+1, maxCount do
		local node = self._nodes[i]
		if node then
			node:removeFromParent()
			self._nodes[i] = nil
			self._urls[i] = nil
		else
			break
		end
	end
end

function UIProgressEx:dispose()
	--从父节点移除
	self:removeFromParent()
	self._curProgress = nil
	self._newProgress = nil
	self._maxProgress = nil
	self._nodes = nil
	self._urls = nil
	self:release()
end

return UIProgressEx