--[[-- wdx
滚动列表
class：     ScrollList
inherit: ScrollView

desc： 继承滚动面板   会根据滚动方向自动 垂直 或者横向 进行排版

@param   direction  滚动方向   ScrollView.VERTICAL 垂直滚动	  或者 ScrollView.HORIZONTAL 横向滚动
@param   w ，h  整个面板的  长宽  也即 可见区域的大小

exp:  local s = ScrollList.new(ScrollView.VERTICAL,100,200)
		s:addCell(node);  --添加内容
		s:addCellAt(node2,10);  --添加内容
		s:removeCell(node);
		s:removeCellAt(1);

		s:cellAtIndex(index);  根据index  获取该排序上的cell
		s:indexOfCell(cell);  获取某个cell排在第几个位置

		s:setScrollPosByIndex(1); 滚动到某个cell的位置上

注意：	添加的每个cell也是以 为锚点（0,0） 进行布局   每个cell必须设置正确的containerSize(w,h);  才能进行自动布局
]]

local ScrollList = class("ScrollList",ScrollView)



--[[--
@param  direction  设置滚动方向
@param   w ，h  整个面板的  长宽  也即 可见区域的大小
@param  priority  优先级
@param  margin 2个cell直接的间隔距离  默认是10
]]
function ScrollList:ctor(direction,w,h,priority,margin)
	ScrollView.ctor(self,direction,w,h,priority)
	if self.direction == kCCScrollViewDirectionVertical then
		self:setContentSize(CCSize(w,0))
	else
		self:setContentSize(CCSize(0,h))
	end

	self.cellArray = {}
	self.margin = margin or 5
	self.sMargin = 0
	self:retain()
end
-- --[[--
-- 	设置 滚动到指定的 index那一个cell位置上
-- ]]
---[[
function ScrollList:setScrollPosByIndex(index, isTween)
 	local cell = self:cellAtIndex(index);
 	if cell then
 		local x,y = cell:getPosition();
		local cellSize = cell:getContentSize()
		local size = self:getViewSize()
 		if self.direction == kCCScrollViewDirectionVertical then
 			self:setScrollTo(ccp(0, -( y-size.height)-cellSize.height ), isTween)
			--self:setScrollTo(ccp(0,0), isTween)
 		else --if self.direction == ScrollView.HORIZONTAL then
 			self:setScrollTo(ccp(size.width-x, 0), isTween)
			--self:setScrollTo(ccp(0,0), isTween)
 		end
	else
		local size = self:getContentSize()
		if self.direction == kCCScrollViewDirectionVertical then
 			self:setScrollTo(ccp(0, -size.height), isTween)
			--self:setScrollTo(ccp(0,0), isTween)
 		else --if self.direction == ScrollView.HORIZONTAL then
 			self:setScrollTo(ccp(-size.width, 0), isTween)
			--self:setScrollTo(ccp(0,0), isTween)
 		end
 	end
 end
 --]]

function ScrollList:setMargin(margin)
	self.margin = margin or self.margin
end

function ScrollList:setStartMargin(sMargin)
	self.sMargin = sMargin
end

--[[
@brief set the rowinfo for addRowCell.
@param count number the number in row
@param anchor ccp anchor in grid
@param padding number or table{left=4,right=1,bottom=1,top=2}

@sample
	scroll = ScrollList.new(kCCScrollViewDirectionVertical, 300, 300)
	scroll:setRowInfo(3, ccp(0,0), {left=3,right=3})
	for i=1,10 do
		local item = UIItemGrid.new(nil, nil, self:getPriority())
		item:setItem(50000+i)
		scroll:addRowCell(item)
	end
	scroll:setScrollTo(scroll.TOP)
--]]
function ScrollList:setRowInfo(count, anchor, padding)
	self._rowInfo = {cnt=count, anchor=anchor or ccp(0.5, 0.5), padding=padding}
end

--[[
@brief add cell
@param cell CCNode
--]]
function ScrollList:addRowCell(cell)
	if not self._lastContainer then
		local viewSize = self:getViewSize()
		if self.direction == kCCScrollViewDirectionVertical then
			self._lastContainer =  UIHorizontalContainer.new(viewSize.width, self._rowInfo.cnt, self._rowInfo.anchor)
			if self._rowInfo.padding then
				self._lastContainer:setPadding(self._rowInfo.padding)
			end
		else
			self._lastContainer =  UIVerticalContainer.new(viewSize.height, self._rowInfo.cnt, self._rowInfo.anchor)
			if self._rowInfo.padding then
				self._lastContainer:setPadding(self._rowInfo.padding)
			end
		end
	end

	self._lastContainer:addCell(cell)

	if not self._lastContainer:getParent() then
		self:addCell(self._lastContainer)
	else
		self._lastContainer:update()
		self:update()
	end

	if self._lastContainer:isFull() then
		self._lastContainer = nil
	end
end

function ScrollList:getNowContentSize()
	local size = CCSize(0, 0)
	local item

	if self.direction == kCCScrollViewDirectionHorizontal then
		size.height = self:getContentSize().height
		item = "width"
	else
		size.width = self:getContentSize().width
		item = "height"
	end

	for i, cell in ipairs(self.cellArray) do
		local cellSize = cell:getContentSize()
		size[item] = size[item] + cellSize[item] + self.margin
	end

	return size
end

function ScrollList:updateContentSize()
	local siz = self:getContentSize()
	local nowSize = self:getNowContentSize()
	--[[
	if siz.width == nowSize.width and siz.height == nowSize.height then
	--if nowSize:equals(siz) then
		return
	end--]]
	local min1 = self:minContainerOffset()
--	local max1 = self:maxContainerOffset()
	local offset = self:getContentOffset()
--	self:printContentOffset()
	--print('nowSize', nowSize.width, nowSize.height, 'siz', siz.width, siz.height)
	local width,height = siz.width,siz.height
	self:setContentSize(nowSize)
	self:updatePosition()
	--self:printContentOffset()
	--self:update()
	--print('nowSize 1', nowSize.width, nowSize.height, 'siz', siz.width, siz.height)
	if nowSize.height < height or nowSize.width < width then

		local min2 = self:minContainerOffset()
		if self.direction == self.HORIZONTAL then
			print('set x', offset.x-min1.x+min2.x)
			self:setContentOffset(ccp(offset.x-min1.x+min2.x, 0))
		else
			print('set y', offset.y-min1.y+min2.y)
			self:setContentOffset(ccp(0, offset.y-min1.y+min2.y))
		end
	end
end

function ScrollList:update()
	self:updateContentSize()
end

function ScrollList:printContentOffset()
	--print(debug.traceback())
	local minp = self:minContainerOffset()
	local p = self:getContentOffset()
	local maxp = self:maxContainerOffset()
	local arr = {min=minp,cur=p,max=maxp}
	print(string.format("printContentOffset -- contentSize(w:%s h:%s)", self:getContentSize().width, self:getContentSize().height))
	for name,pos in pairs(arr) do
		print(name, '     --',pos.x,pos.y)
	end
end

function ScrollList:storeTop()
	local min1 = self:minContainerOffset()
	local offset = self:getContentOffset()
	local y1 = offset.y - min1.y
	self._topRY = y1
end

function ScrollList:recoverTop()
	if not self._topRY then
		self:setScrollTo(self.TOP)
	else
		local min2 = self:minContainerOffset()
		self:setContentOffset(ccp(0, min2.y+self._topRY))
	end
end

--[[
	scrollView.TOP
--]]
function ScrollList:updateTop()
--	print("function ScrollList:updateTop()", self.direction, self.HORIZONTAL)
	if self.direction == self.HORIZONTAL then return end
	local min1 = self:minContainerOffset()
	local offset = self:getContentOffset()
	local y1 = offset.y - min1.y
	--self:printContentOffset()
	self:update()

	local min2 = self:minContainerOffset()
	print("y", y1)
	self:setContentOffset(ccp(0, min2.y+y1))

	--self:printContentOffset()
end

function ScrollList:getRelativeTop()
	local min1 = self:minContainerOffset()
	local offset = self:getContentOffset()
	local y1 = offset.y - min1.y
--	print("ScrollList:getRelativeTop()", y1)
--	self:printContentOffset()
	return y1
end

function ScrollList:addRelativeTop(y1)
	if y1 == nil then return end
--	print("function ScrollList:addRelativeTop(y1)", y1)
	local min2 = self:minContainerOffset()
	self:setContentOffset(ccp(0, min2.y+y1))
end

function ScrollList:getVTopRelativity(cell, yoffset)
	yoffset = yoffset or 0
	local y = self:getContentSize().height - cell:getPositionY() - cell:getContentSize().height + yoffset
	return y
end

function ScrollList:getVTop(cell, yoffset)
	local minp = self:minContainerOffset()
	yoffset = yoffset or 0
	local y = self:getContentSize().height - cell:getPositionY() - cell:getContentSize().height + yoffset
	for i,cell in ipairs(self.cellArray) do
		print(cell:getPosition())
	end
	--print('function ScrollList:setVTop(cell)', minp.y, y, cell:getPositionY(), yoffset)
	--self:printContentOffset()
	return ccp(0,minp.y+y)
end

function ScrollList:setVTop(cell, yoffset)
--[[
	local minp = self:minContainerOffset()
	yoffset = yoffset or 0
	local y = self:getContentSize().height - cell:getPositionY() - cell:getContentSize().height + yoffset
	for i,cell in ipairs(self.cellArray) do
		print(cell:getPosition())
	end
	print('function ScrollList:setVTop(cell)', minp.y, y, cell:getPositionY(), yoffset)
	self:printContentOffset()
	--]]
	self:setContentOffset(self:getVTop(cell, yoffset))
end

function ScrollList:updatePosition()
	local pos
	if self.direction == kCCScrollViewDirectionHorizontal then
		pos = ccp(self.margin, 0)

		for i = 1,#self.cellArray, 1 do
			local cell = self.cellArray[i]
			local cellSize = cell:getContentSize()
			cell:setPositionX(pos.x + self.sMargin)
			pos.x = pos.x + cellSize.width + self.margin
		end
	else
		pos = ccp(0, 0)
	--	print("function ScrollList:update()", self:getContentSize().height)
	--	print("function ScrollList:update()", self:getContentSize().height)
		for i = #self.cellArray, 1, -1 do
			local cell = self.cellArray[i]
			local cellSize = cell:getContentSize()
			cell:setPositionY(pos.y + self.sMargin)
		--	print("function ScrollList:update()", pos.y, cellSize.width, cellSize.height)
			pos.y = pos.y + cellSize.height + self.margin
		end
	end
end

function ScrollList:sort(comp)
	table.sort(self.cellArray, comp)
	self:updatePosition()
end

--[[
@brief one node make the list not sortable
@param (CCNode or index) node
@param function comp
@return none
--]]
function ScrollList:reSort(node, comp)
	local index = node
	if type(node) ~= "number" then
		index = self:indexOfCell(node)
	end

	uihelper.reSort(self.cellArray, index, comp)
	self:updatePosition()
end

--[[--
	@param (table) arr
	 还没优化
]]
function ScrollList:addCellArray(arr)
	for i=1,#arr,1 do
		local cell = arr[i];
		self:addCell(cell)
	end
end

function ScrollList:addCellList(params)
	local items = params.list
	local step = params.step or 1;
	local first = 1
	local last = step --#items

	if self._timer then
		self._timer:dispose()
		self._timer = nil
	end

	local add = params.add
	local beforeAddedSome = params.beforeAddedSome
	local onAddedSome = params.onAddedSome
	if params.top then
		if not beforeAddedSome then
			beforeAddedSome = {self, self.getRelativeTop}
		end
		if not onAddedSome then
			onAddedSome = {self, self.addRelativeTop}
		end
	end
	function callback()
		local cnt = 0
		local l = last
		local ret = true
		if l > #items then
			l = #items
			ret = false
		end

		local before = uihelper.call(beforeAddedSome)
		local container
		for i=first,l do
			local v = items[i]
			add(self, v)
		end

		--print("timer create:", cnt, first, l, last)
		uihelper.call(onAddedSome, before)

		first = l + 1
		last = last + step

		return ret
	end

	self._timer = UISimpleTimer.new(params.interval or 0.1, callback, params.onComplete)
	self._timer:start(true)
end

--[[--
	添加 cell到底部
	@param (CCNode)  cell
]]
function ScrollList:addCell(cell,index,zorder)
	index = index or #self.cellArray+1;
	self:addCellAt(cell,index,zorder);
end


--添加到 index 之后， 并不改变 index 之前的 contentOffset
function ScrollList:addCellStabe(cell, index, zorder)
	local min1 = self:minContainerOffset()
	local offset = self:getContentOffset()
	local y1 = offset.y - min1.y
	local x1 = offset.x - min1.x

	self:addCell(cell,index,zorder)

	local min2 = self:minContainerOffset()
	local max2 = self:maxContainerOffset()

	if self.direction == kCCScrollViewDirectionVertical then
		self:setContentOffset(ccp(max2.x, min2.y+y1))
	else
		self:setContentOffset(ccp(min2.x+x1, max2.y))
	end
end

function ScrollList.contentSizeChangeStable(scroll, callback)
	local min1 = scroll:minContainerOffset()
	local offset = scroll:getContentOffset()
	local y1 = offset.y - min1.y
	local x1 = offset.x - min1.x
	--scroll:printContentOffset()
	--scroll:addCell(cell,index,zorder)
	uihelper.call(callback)

	local min2 = scroll:minContainerOffset()
	local max2 = scroll:maxContainerOffset()
	--scroll:printContentOffset()
	if scroll.direction == kCCScrollViewDirectionVertical then
		scroll:setContentOffset(ccp(max2.x, min2.y+y1))
	else
		scroll:setContentOffset(ccp(min2.x+x1, max2.y))
	end
end

--
function ScrollList:addCellAfter(cell, newcell, stable, zorder)
	local idx = self:indexOfCell(cell)
	idx = idx + 1
	if stable then
		self:addCellStabe(newcell, idx, zorder)
	else
		self:addCell(newcell, idx, zorder)
	end
end

--[[--
	添加 cell到指定的index序号上
	@param (CCNode)  cell
	@param  int
]]
function ScrollList:addCellAt(cell, index, zorder)
	cell:setAnchorPoint(ccp(0,0))
	if cell.setScrollViewCheck then
		cell:setScrollViewCheck(true)
	end
	cell:retain()

	-- self:removeCell(cell); --有可能已经在容器里面了
	if(index > #self.cellArray+1 )then
		index = #self.cellArray+1
	end

	local x,y;
	local margin = self.margin
	-- if self.direction == kCCScrollViewDirectionHorizontal and index == 1 then
	-- 	margin = 0
	-- end

--垂直滚动 kCCScrollViewDirectionVertical
--水平 kCCScrollViewDirectionHorizontal

	local size = self.container:getContentSize()

	local curW,curH = size.width, size.height
	--print("function ScrollList:addCellAt(cell, index, zorder)", index, zorder, curW, curH)
	local cellSize = cell:getContentSize()
	if self.direction == kCCScrollViewDirectionVertical then
		local curCell = self:cellAtIndex(index )
		if curCell then
			y = curCell:getPositionY() + curCell:getContentSize().height + margin
		elseif index == #self.cellArray + 1 then
			y = margin --size.height - margin
		else
			y = margin + size.height
		end
		cell:setPositionY(y)
		-- cell:setPositionX(cellSize.width/2)
		size.height = size.height + cellSize.height + margin
	elseif self.direction == kCCScrollViewDirectionHorizontal then
		local curCell = self:cellAtIndex(index);
		if curCell then
			x = curCell:getPosition()
		else
			x = size.width + margin
		end
		cell:setPositionX(x)
		-- cell:setPositionY(cellSize.height/2)

		size.width = size.width + cellSize.width + margin
--		print("xxxxx",x,y)
	end

	if curW < size.width or curH < size.height then
		self:setContentSize(size)
	end


	if self.direction == kCCScrollViewDirectionVertical then

		local dy = cellSize.height + margin
		for i=index-1,1,-1 do
			local c = self:cellAtIndex(i)
			if c then
				local cx,cy = c:getPosition()
				cy = cy + dy
				c:setPositionY(cy)
			end
		end
		--cell:setPositionY(y);
	elseif self.direction == kCCScrollViewDirectionHorizontal then
		local dx = cellSize.width + margin
		for i=index,#self.cellArray,1 do
			local c = self:cellAtIndex(i);
			local cx,cy = c:getPosition();
			cx = cx+dx;
			c:setPositionX(cx);
		end
		--cell:setPositionX(x);
	end

	if zorder then
		self:addChild(cell, zorder);
	else
		self:addChild(cell);
	end
	table.insert(self.cellArray,index,cell)



	--print("添加cell：",index,size.height);
	--self:printCell()
end


function ScrollList:printCell()
	print("*************************")
	for i=1,#self.cellArray,1 do
		local c = self:cellAtIndex(i);
		local cx,cy = c:getPosition();
		print(i,cy);
	end
	print("*************************")
end

--[[--
	移除 cell
	@param (CCNode)  cell
]]
function ScrollList:removeCell(cell,isDispose)
	local index = self:indexOfCell(cell);
	if(index >=1)then
		self:removeCellAt(index,isDispose);
	end
end

function ScrollList:setMoveMode(flag)
	self._moveAfter = tobool(flag)
end

--[[--
	移除 index序号上的 cell
]]
function ScrollList:removeCellAt(index,isDispose)
	local cell = self:cellAtIndex(index);
	if(cell == nil)then
		return
	end
	assert(cell:getParent() == self.container,"ScrollList:removeCellAt() ---------- cell not in scrollList")

	local cellSize = cell:getContentSize()

	local size = self.container:getContentSize()

	if self._moveAfter then
		self:storeTop()
	end
	if self.direction == kCCScrollViewDirectionVertical then
		local dy = cellSize.height + self.margin;
		for i=index - 1,1,-1 do
			local c = self:cellAtIndex(i);
			local cx,cy = c:getPosition();
			cy = cy-dy;
			c:setPositionY(cy);
		end
		size.height = size.height - cellSize.height - self.margin
	elseif self.direction == kCCScrollViewDirectionHorizontal then
		local dx = cellSize.width + self.margin;
		for i=index,#self.cellArray,1 do
			local c = self:cellAtIndex(i);
			local cx,cy = c:getPosition();
			cx = cx-dx;
			c:setPositionX(cx)
		end
		size.width = size.width - cellSize.width - self.margin
	end

	self:setContentSize(size)

	--[[
	for i=1,#self.cellArray do
		local cell = self.cellArray[i]
		local pos = cell:getContentOffset()
		print('content offset ', i, pos.y)
	end
	--]]

	cell:removeFromParent()
	table.remove(self.cellArray,index)
	if isDispose and cell.dispose then
		cell:dispose()
	end
	cell:release()

	if self._moveAfter then
		self:recoverTop()
	else
		self:checkOutSize()
	end
	-- local maxRect = self.container:boundingBox();
	-- print("移除cell：",index,maxRect:getMinY(),maxRect:getMaxY());
end

--[[--
	根据用户自定义数据  获取第一个符合的cell
	@param (data) val
	@param function(cell, val) eq   相等的判别函数
	@param cell, index
]]
function ScrollList:find(val, eq)
	for i, cell in ipairs(self.cellArray) do
		if eq(cell, val) then
			return cell, i
		end
	end
end


--[[--
	根据cell  获取 index
	@param (CCNode)  cell
]]
function ScrollList:indexOfCell(cell)
	for i, value in ipairs(self.cellArray) do
	   if value == cell then
	      return i
	    end
	end
	return 0
end

--[[--
	根据index 获取cell
]]
function ScrollList:cellAtIndex(index)
	if(index == nil or index < 1 or index > #self.cellArray)then
		return nil
	end
	local cell = self.cellArray[index];
	return cell;
end

--[[
	@desc中间显示
	@author hrc
	@data 2016-4-21
--]]
function ScrollList:setMidian(  )
	local num = #self.cellArray
	-- if num < 1 then return end
	local size = self:getCellAt(1):getContentSize()
	local width = num * size.width
	local maxWidth = self:getViewSize().width
	local margin = math.floor((maxWidth - width) / (num + 1))
	self:setMargin(margin)
	self:updatePosition()
end

function ScrollList:getCellAt(index)
	return self:cellAtIndex(index)
end

--[[--
	@return (table)  返回所有cell
]]
function ScrollList:getAllCell()
	return self.cellArray
end

function ScrollList:getCount()
	return #self.cellArray
end

function ScrollList:clearTimer()
	if self._timer then
		self._timer:dispose()
		self._timer = nil
	end
end

--[[--
	移除所有 cell
]]
function ScrollList:clear(isDispose)
	if not self.cellArray then return end
	self:clearTimer()
	for i=1,#self.cellArray,1 do
		local cell = self:cellAtIndex(i);
		cell:removeFromParent()
		if isDispose and cell.dispose then
			cell:dispose();
		end
		cell:release();
	end
	self.cellArray = {};
	self:setContentSize(CCSize(0,0))
end

--[[--
	销毁
]]
function ScrollList:dispose()
	if not self.cellArray then return end -- temporary forbidden bugs

	for i=1,#self.cellArray,1 do
		local cell = self:cellAtIndex(i);
		cell:removeFromParent()
		if cell.dispose then
			cell:dispose()
		end
		cell:release()
	end
	self.cellArray = nil;
	self:release()
end


return ScrollList;
