--[[
@desc 垂直增长的格子类
@demand:
	1. 末尾自动增加
	2. 任意位置删除
	3. 排序(指定排序函数)
	4. 整体padding
	5. 行间距设定
	6. 所有cell的 padding, anchor
	7. 已知宽度， 数目
@anchor changao


--]]

local UIVGrid = class("UIVGrid", function(width, num, anchor, bgImage, autoDispose)
	return display.newNode()
end)

function UIVGrid:ctor(width, num, anchor, bgImage, autoDispose)
	self:retain()
	self._padding = {left=0, right=0, bottom=0, top=0}

	self._nodesindex = {}
	self._nodes = {}

	self._anchor = anchor or ccp(0.5, 0.5)
	self._count = 0
	self._lineNum = num or 1
	self._margin = 0
	self._width = width	--  包括实际的宽度
	self._height = 0
	self._autoDispose = autoDispose ~= false
	--	除去padding之后的width height
	self._rwidth = self._width - self._padding.left - self._padding.right
	self._rheight = 0

	self._cellWidth = self._rwidth / self._lineNum
	self._cellinfo = {padding = {}}
	self:_setPadding(self._cellinfo.padding, 0)

	self._autoUpdate = true
	self:setBgImage(bgImage)
	self:setAnchorPoint(ccp(0, 0))

	self:update()
	self:setAutoPos(true)
end

function UIVGrid:_calDetail()
	self._wstep = self._rwidth / self._lineNum
end

function UIVGrid:setCellInfo(info)
	if not info then return end

	self._anchor = info.anchor or self._anchor
	self._cellinfo.height = info.height or self._cellinfo.height

	self:_setPadding(self._cellinfo.padding, info.padding)
	self:updateConfig()
end

function UIVGrid:_setPadding(selfPadding, padding)
	if not padding then return end
	if type(padding) == "number" then
		local pad = padding
		if padding < 0 then
			pad = 0
		end
		local newPadding = {left=pad, right=pad, bottom=pad, top=pad}
		for k,v in pairs(newPadding) do selfPadding[k] = v end
	else
		selfPadding.left = padding.left or selfPadding.left
		selfPadding.right = padding.right or selfPadding.right
		selfPadding.bottom = padding.bottom or selfPadding.bottom
		selfPadding.top = padding.top or selfPadding.top
	end
end

function UIVGrid:setPadding(padding)
	self:_setPadding(self._padding, padding)
	self:updateConfig()
end


function UIVGrid:getLineHeight(start)
	if self._cellinfo.height then
		return self._cellinfo.height
	end

	if start > self._count or self._count < 1 then return 0 end

	local last = start + self._lineNum - 1
	if last > self._count then
		last = self._count
	end

	local height = 0
	for i=start, last do
		local node = self._nodes[i]
		local h = node:getContentSize().height
		if h > height then
			height = h
		end
	end

	height = height + self._cellinfo.padding.bottom + self._cellinfo.padding.top
	return height
end

function UIVGrid:getLastLineHeight()
	local start
	if self._count % self._lineNum == 0 then
		start = self._count - self._lineNum + 1
	else
		start = math.floor(self._count / self._lineNum) * self._lineNum + 1
	end
	return self:getLineHeight(start)
end

function UIVGrid:getCellWidth(update)
	if update or not self._cellWidth then
		local w = self._rwidth / self._lineNum
		local pad = self._cellinfo.padding
		self._cellWidth = w - pad.left - pad.right
	end
	return self._cellWidth
end

function UIVGrid:updateConfig()
	self._rwidth = self._width - self._padding.left - self._padding.right
	self._cellWidth = self._rwidth / self._lineNum
	local pad = self._cellinfo.padding
	local w = self._rwidth / self._lineNum
	self._cellWidth = w - pad.left - pad.right
end

function UIVGrid:update(recal)
	if recal then
		self:updateConfig()
	end

	if self._count < 1 then
		self._rheight = 0
		self._height = self._padding.bottom + self._padding.bottom + self._rheight
		self:setContentSize(CCSize(self._width, self._height))
		return
	end

	local height = self._padding.bottom
	local lastLineFirst = math.floor(self._count/self._lineNum) * self._lineNum + 1
	if lastLineFirst <= self._count then
		local lheight = self:getLineHeight(lastLineFirst)
		for i = lastLineFirst, self._count, 1 do
			local node = self._nodes[i]
			local pos = self:_getRPos(node, self._cellWidth, lheight)
			local idx = (i + self._lineNum - 1) % self._lineNum
			--print(idx, pos.x, self._padding.left, pos.y, height)
			node:setPosition(ccp(pos.x+self._padding.left + idx*self._cellWidth, pos.y+height))
		end
		height = height + self._margin + lheight
		--
	--	print("a", height, lheight, self._margin)
	end

	for l=lastLineFirst-self._lineNum, 1, -self._lineNum do
		local lheight = self:getLineHeight(l)
		for i = l, l+self._lineNum-1, 1 do
			local node = self._nodes[i]
			local pos = self:_getRPos(node, self._cellWidth, lheight)
		--	print(i-l, pos.x, self._padding.left, pos.y, height)
			node:setPosition(ccp(pos.x+self._padding.left + (i-l)*self._cellWidth, pos.y+height))
		end
		height = height + self._margin + lheight
	--
--	print("b", height, lheight, self._margin)
	end
	height = height - self._margin + self._padding.top

	self._height = height
	self._rheight = self._height - self._padding.bottom - self._padding.top
	self:setContentSize(CCSize(self._width, self._height))
--	print("content size", self._width, self._height)
end

function UIVGrid:_addRandom(node, idx)
--	print("function UIVGrid:_addRandom(node, idx)", node, self.getLastLineHeight)
	if not idx or idx <=0 or idx > self._count then
		return self:_addTail(node)
	end

	self:_insertNode(node, idx)

	if self._autoUpdate then
		self:update()
	end
end

function UIVGrid:_addTail(node)
--	print("function UIVGrid:_addTail(node)", node, self.getLastLineHeight)
	if self._count % self._lineNum == 0 then
		self:_addNewLine(node)
	else
		self:_addLineTail(node, false)
	end
end


function UIVGrid:_addNewLine(node)
	return self:_addLineTail(node, true)
end

-- todo: this fun has a bug that the _margin is not been added. u can use update to correct the behaviour
function UIVGrid:_addLineTail(node, newLine)
	self:_insertNode(node)

	if not self._autoUpdate then return end

	local oldHeight
	if newLine then
		oldHeight = - self._margin
	else
	--	print("function UIVGrid:_addLineTail(node, newLine)", self:retainCount())
	--	dump(self.getLastLineHeight)
		oldHeight = self:getLastLineHeight()
	end

	local start = self._count
	local newHeight = self:getLastLineHeight()
	local rheight = newHeight - oldHeight
	for i=1,self._count-1 do
		local node = self._nodes[i]
		local y = node:getPositionY()
		node:setPositionY(y+rheight)
	end

	self._height = self._height + rheight
	self._rheight = self._rheight + rheight
	self:setContentSize(CCSize(self._width, self._height))

	local pos = self:_getRPos(node, self._cellWidth, newHeight)
	local idx = (self._count + self._lineNum - 1) % self._lineNum
	node:setPosition(ccp(pos.x+self._padding.left + idx*self._cellWidth, pos.y+self._padding.bottom))
	--print("function UIVGrid:_addLineTail(node, newLine)", node:getPosition())
end

function UIVGrid:_insertNode(node, index)
	if self._nodesindex[node] then
		assert(false, "UIVGrid:insertNode repeat")
		return false
	end

	node:retain()
	self:addChild(node)
	if not index then
		table.insert(self._nodes, node)
	else
		table.insert(self._nodes, index, node)
	end
	self._nodesindex[node] = true
	self._count = #self._nodes
end

function UIVGrid:_getNodeIndex(node)
	if not self._nodesindex[node] then
		return nil
	end
	for i,n in ipairs(self._nodes) do
		if n == node then
			return i
		end
	end
end

function getXXX(tab, param1, param2, param3)
	if not tab or not param1 then return end
	tab = tab[param1]
	if not tab or not param2 then return end
	tab = tab[param2]
	if not tab or not param3 then return end
	return tab[param3]
end


function UIVGrid:_removeNode(node)
	local idx = self:_getNodeIndex(node)
	if not idx then
		return
	end

	return self:_removeNodeByIndex(idx)
end

function UIVGrid:_removeNodeByIndex(idx)
	local node = self._nodes[idx]
	if not node then return end

	node:removeFromParent()
	table.remove(self._nodes, idx)
	self._nodesindex[node] = nil

	if self._autoDispose and node.dispose then
		node:dispose()
	end
	node:release()

	self._count = #self._nodes
	return idx
end

--[[
获取相对格子的pos。
@param node 添加的节点
@param w 节点格子宽
@param h 节点格子高
--]]
function UIVGrid:_getRPos(node, w, h)
	w = w - self._cellinfo.padding.left - self._cellinfo.padding.right
	h = h - self._cellinfo.padding.bottom - self._cellinfo.padding.top
	local anchor = node:getAnchorPoint()
	local siz = node:getContentSize()
	--local x = w*self._anchor.x+siz.width*(anchor.x-self._anchor.x) + self._cellinfo.padding.left
	--local y = h*self._anchor*y+siz.height*(anchor.y-self._anchor.y) + self._cellinfo.padding.bottom
	--print("function UIVGrid:_getRPos(node, w, h)", w, h, siz.width, siz.height, anchor.x, anchor.y)
	local x = w*self._anchor.x + siz.width*(anchor.x-self._anchor.x) + self._cellinfo.padding.left
	local y = h*self._anchor.y + siz.height*(anchor.y-self._anchor.y) + self._cellinfo.padding.bottom
	return ccp(x, y)
end

function UIVGrid:getContentWidth()
	return self._width - self._padding.left - self._padding.right
end

function UIVGrid:setAutoPos(autoPos)
	self._autoUpdate = tobool(autoPos)
end

function UIVGrid:getWidth()
	return self._width
end

function UIVGrid:getHeight()
	return self._height
end

function UIVGrid:setMargin(margin)
	self._margin = margin or self._margin
end

function UIVGrid:setBgImage(bgImage)
	if not self._bgImage then
		self._bgImage = UIImage.new(bgImage, nil, true)
		self:addChild(self._bgImage)
	end

	self._bgImage:setNewImage(bgImage)
end

function UIVGrid:clearBgImage(bgImage)
	if self._bgImage then
		self._bgImage:setSpriteImage(nil)
		self._bgImage:dispose()
		self._bgImage = nil
	end
end

function UIVGrid:updateBgImage(siz, pos, anchor)
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

function UIVGrid:setAutoUpdate(auto)
	self._autoUpdate = tobool(auto)
	self:setAutoPos(auto)
end

function UIVGrid:addCell(cell, idx)
	if not cell then return end
--	print("function UIVGrid:addCell(cell, idx)", cell, idx)
	self:_addRandom(cell, idx)
end

function UIVGrid:removeCell(cell)
	if self:_removeNode(cell) then
		self:update()
	end
end

function UIVGrid:sort(cmp)
	table.sort(self._nodes, cmp)
	self:update()
end

function UIVGrid:find(eq)
	for i,cell in ipairs(self._nodes) do
		if eq(cell) then
			return cell
		end
	end
end

function UIVGrid:getCount()
	return #self._nodes
end

function UIVGrid:getAllCell()
	return self._nodes
end

function UIVGrid:cellAtIndex(index)
	if(index == nil or index < 1 or index > #self._nodes)then
		return nil
	end
	local cell = self._nodes[index];
	return cell;
end

--@desc 设置排列规则
function UIVGrid:setCenter(  )
	local num = self:getCount() % self._lineNum
	if num == 0 then return end
	local width = self:getCellWidth() * num
	local moveX =  math.floor((self._width - width) / 2)
	for i = 0, num - 1 do
		local index = self:getCount() - i
		local cell = self:cellAtIndex(index)
		cell:setPositionX(cell:getPositionX() + moveX)
	end
end

function UIVGrid:clearCell(dispose)
	local d = self._autoDispose or dispose
	if self._nodes then
		for i,v in ipairs(self._nodes) do
			v:removeFromParent()
			if v.dispose and d then
				v:dispose()
			end
			v:release()
		end
		self._nodes = {}
		self._nodesindex = {}
		self._count = 0
		self:update()
	end
end

function UIVGrid:clear(dispose)
	self:clearBgImage()
	self:clearCell(dispose)
end

function UIVGrid:dispose()
	--print(debug.traceback())
	self:clear()
	self:removeFromParent()
	self._padding = nil
	self._nodes = nil
	self._nodesindex = nil
	self._anchor = nil

	self:release()
end


return UIVGrid
