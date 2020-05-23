--[[
@number
@brief 一个竖直容器。
--]]
local UIVerticalContainer = class("UIVerticalContainer", function() return display.newNode() end)

function UIVerticalContainer:ctor(height, num, anchor, disposeChild)
	self:retain()
	
	self._padding = {left=0, right=0, bottom=0, top=0}
	self._nodesindex = {}
	self._nodes = {}
	self._height = height
	assert(num > 0, "UIVerticalContainer max number should be max than zero")
	self._maxnum = num or 1
	self._anchor = anchor or ccp(0.5, 0.5)
	self._wstep = 0
	self._hstep = self._height / self._maxnum
	self._count = 0
	self._autoupdate = true
	self._disposeChild = disposeChild ~= false
	self:setAnchorPoint(ccp(0, 0))
	
	self:update()
end

function UIVerticalContainer:setAutoUpdate(auto)
	self._autoupdate = tobool(auto)
end

function UIVerticalContainer:setPadding(padding)
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
	
	self._hstep = (self._height - self._padding.bottom - self._padding.top) / self._maxnum
	
	if self._autoupdate then
		self:update()
	end
end

function UIVerticalContainer:addCell(cell, pos)
	if not cell then return end
	assert(self._count < self._maxnum, "contaner is full, all is" .. self._count .. " max is" .. self._maxnum)
	
	if not pos then
		assert(#self._nodes < self._maxnum, "pos must less than the max number")
		self:addChild(cell)
		
		self._nodesindex[cell] = cell
		table.insert(self._nodes, cell)
		self._count = self._count + 1
	else
		if self._nodes[pos] then
			self._nodes[pos]:removeFromParent()
			self:addChild(cell)
			self._nodes[pos] = cell
		else
			self:addChild(cell)
			self._nodes[pos] = cell
			self._count = self._count + 1
		end
	end
	
	if self._autoupdate then
		self:update()
	end
end

function UIVerticalContainer:removeCell(cell)
	for i,node in ipairs(self._nodes) do
		if node == cell then
			self:removeChild(cell)
			self._nodesindex[cell] = nil
			table.remove(self._nodes, i)
			break
		end
	end
	if self._autoupdate then
		self:update()
	end
end


function UIVerticalContainer:getWStep()
	local m = 0
	for i=1,self._maxnum do
		local node = self._nodes[i]
		if node then
			local siz = node:getContentSize()
			if m < siz.height then
				m = siz.height
			end
		end
	end
	return m
end

function UIVerticalContainer:update()
	self._wstep = self:getWStep()
	self._width = self._padding.left + self._padding.right + self._wstep
	self:setContentSize(CCSize(self._width, self._height))
	local x, y = self._padding.left + self._wstep * self._anchor.x, 
		self._padding.bottom + self._hstep * self._anchor.y
	for i=1,self._maxnum do
		local node = self._nodes[i]
		if node then
			local siz = node:getContentSize()
			local anchor = node:getAnchorPoint()
			node:setPosition(ccp(x + (anchor.x - self._anchor.x) * siz.width,
									y + (anchor.y - self._anchor.y) * siz.height))
		end
		y = y + self._hstep
	end
end

function UIVerticalContainer:getCount()
	return #self._nodes
end

function UIVerticalContainer:isFull()
	return self._maxnum == self:getCount()
end


function UIVerticalContainer:dispose(disposeChild)
	local tdisposeChild = disposeChild or self._disposeChild
	self:removeAllChildren()
	if tdisposeChild then
		if self._nodes then
			for i,v in ipairs(self._nodes) do
				if v.dispose then
					v:dispose()
				end
			end
		end
	end
	self._padding = nil
	self._nodes = nil
	self._nodesindex = nil
	self._anchor = nil
	
	self:release()
end

return UIVerticalContainer 