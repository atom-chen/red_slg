local UIHList = class("UIHList", function(height, anchorx, bgImage) 
--	if bgImage then
	--	return UIImage.new(bgImage, nil, true)
--	end
	return display.newNode()
end)

function UIHList:ctor(height, anchory, bgImage)
	self:retain()
	assert(type(anchory) == "number")
	self._padding = {left=0, right=0, bottom=0, top=0}
	self._nodesindex = {}
	self._nodes = {}
	self._anchory = anchory or 0.5
	self._count = 0
	self._margin = 0
	self._height = height
	self._autoupdate = true
	self:setBgImage(bgImage)
	self:setAnchorPoint(ccp(0, 0))
	
	self:update()
	self:setAutoPos(true)
end

function UIHList:setHeight(height)
	self._height = height or self._height
end

function UIHList:getContentHeight()
	return self._height - self._padding.bottom - self._padding.top
end

function UIHList:setAutoPos(autoPos)
	self._autoPos = tobool(autoPos)
end

function UIHList:getHeight()
	return self._Height
end

function UIHList:setMargin(margin)
	self._margin = margin or self._margin
end

function UIHList:setBgImage(bgImage)
	if not self._bgImage then
		self._bgImage = UIImage.new(bgImage, nil, true)
		self:addChild(self._bgImage)
	end
	
	self._bgImage:setNewImage(bgImage)
end

function UIHList:clearBgImage()
	if self._bgImage then
		self._bgImage:setSpriteImage(nil)
		self._bgImage:dispose()
		self._bgImage = nil
	end
end

function UIHList:updateBgImage(siz, pos, anchor)
	if not self._bgImage then return end
	
	if siz then
		self._bgImage:setImageSize(siz)
	end
	
	if pos then
		self._bgImage:setPosition(pos)
	end
	
	if anchor then
		self._bgImage:setAnchorPoint(anchor)
	end
end

function UIHList:setAutoUpdate(auto)
	self._autoupdate = tobool(auto)
end

function UIHList:setPadding(padding)
	if not padding then return end
	if type(padding) == "number" then
		local pad = padding
		if padding < 0 then
			pad = 0
		end
		self._padding = {left=pad, right=pad, bottom=pad, top=pad}
	else
		self._padding.left = padding.left or self._padding.left
		self._padding.right = padding.right or self._padding.right
		self._padding.bottom = padding.bottom or self._padding.bottom
		self._padding.top = padding.top or self._padding.top
	end
	
	if self._autoupdate then
		self:update()
	end
end
--[[
function UIHList:getNowContentSize()
	local size = CCSize(0, 0)
	local item
	
	if self.direction == kCCScrollViewDirectionHorizontal then
		size.height = self:getContentSize().height
		item = "width"
	else
		size.width = self:getContentSize().width
		item = "height"
	end
	
	for i, cell in ipairs(self._nodes) do
		local cellSize = cell:getContentSize()
		size[item] = size[item] + cellSize[item] + self._margin
	end
	
	return size
end
--]]

function UIHList:getNowContentSize()
	local size = CCSize(0, self._height)
	for i, cell in ipairs(self._nodes) do
		local cellSize = cell:getContentSize()
		size["width"] = size["width"] + cellSize["width"] + self._margin
	end
	
	size.width = size.width + self._padding.left + self._padding.right
	return size
end

function UIHList:updateContentSize()
	local size = self:getContentSize()
	local nowSize = self:getNowContentSize()
	if size.width == nowSize.width and size.height == nowSize.height then
	--if nowSize:equals(size) then
		return
	end
	self:setContentSize(nowSize)
	self:updateBgImage(nowSize)
	--self:setImageSize(nowSize)
	--[[
	local parent = self:getParent()
	if parent and self._autoPos and 
		(size.width ~= nowSize.width or size.height ~= nowSize.height) then
		local anchor = self:getAnchorPoint()
		local x,y = self:getPosition()
		print(y+(nowSize.height - size.height)*(anchor.y-1))
		self:setPositionY(y+(nowSize.height - size.height)*(anchor.y-1))
	end--]]
	
	self:updatePosition()
end

function UIHList:updatePosition()
	local x,y = self._padding.left,self._padding.bottom
	local height = self._height - (self._padding.bottom + self._padding.top)
	for i = 1,#self._nodes do
		local cell = self._nodes[i]
		local anchor = cell:getAnchorPoint()
		local cellSize = cell:getContentSize()
		
		cell:setPosition(x+self._padding.left+cellSize.width*anchor.x,
			self._padding.bottom+(height-cellSize.width)*(self._anchory-anchor.y))
		x = x + cellSize.width + self._margin
	end
end

function UIHList:update()
	self:updateContentSize()
	--self:updatePosition()
end

function UIHList:addCell(cell)
	if not cell then return end
	if self._nodesindex[cell] then
		assert(false, "function UIHList:addCell(cell) cell already exists")
	end
	cell:retain()
	self:addChild(cell)
	
	self._nodesindex[cell] = cell
	table.insert(self._nodes, cell)
	self._count = self._count + 1

	if self._autoupdate then
		self:update()
	end
end

function UIHList:getCount()
	return #self._nodes
end

function UIHList:isFull()
	return self._maxnum == self:getCount()
end

function UIHList:clearCell(dispose)
	if self._nodes then
		for i,node in ipairs(self._nodes) do
			node:removeFromParent()
			if node.dispose and dispose then
				node:dispose()
			end
			node:release()
		end
		self._nodes = {}
	end
end

function UIHList:getAllCell()
	return self._nodes
end

function UIHList:clear()
	self:clearBgImage()
	self:clearCell(true)
end

function UIHList:dispose()
	self:clear()
	self:removeFromParent()
	
	self._padding = nil
	self._nodes = nil
	self._nodesindex = nil
	self._anchor = nil

	self:release()
end


return UIHList