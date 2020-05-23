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
ps：滚动面板的容器 的锚点左边是  在左上角（0,1）   里面的东西也都是从上到下的  以左上角为锚点（0,1） 进行布局 


注意：	添加的每个cell也是以 左上角为锚点（0,1） 进行布局   每个cell必须设置正确的containerSize(w,h);  才能进行自动布局
]]

local ScrollList = class("ScrollList",ScrollView)



--[[--
@param  direction  设置滚动方向   ScrollView.VERTICAL  或者 ScrollView.HORIZONTAL
@param   w ，h  整个面板的  长宽  也即 可见区域的大小
@param  margin 2个cell直接的间隔距离  默认是10
]]
function ScrollList:ctor(direction,w,h,margin)
	ScrollList.super.ctor(self,direction,w,h)
	self.cellArray = {};
	if(margin == nil)then
		self.margin = 10;
	else
		self.margin = margin
	end
end

--function ScrollList:refresh(w, h)
--	local lastCell = self.cellArray[#self.cellArray]
--	if lastCell then
--		local size = lastCell:getContentSize();
--		w,h = lastCell:getPosition()
--		w = w + size.width;
--		h = -h + size.height
--	end
--	ScrollList.super.refresh(self,w,h)
--end

--[[--
	设置 滚动到指定的 index那一个cell位置上
	
]]
function ScrollList:setScrollPosByIndex(index)
	local cell = self:cellAtIndex(index);
	if(cell)then
		local x,y = cell:getPosition();
		if(self.direction == ScrollView.VERTICAL)then
			self:setScrollPos({y=-y})
		elseif(self.direction == ScrollView.HORIZONTAL)then
			self:setScrollPos({x=-x})
		end
	end
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

--[[--
	添加 cell到底部
	@param (CCNode)  cell
]]
function ScrollList:addCell(cell)
	assert(cell ~= nil,"ScrollList:addCell() ---------- cell == nil")
	local index = #self.cellArray+1;
	self:addCellAt(cell,index);
end

--[[--
	添加 cell到指定的index序号上
	@param (CCNode)  cell
	@param  int
]]
function ScrollList:addCellAt(cell,index)
	assert(cell ~= nil,"ScrollList:addCellAt() ---------- cell == nil")
	cell:setAnchorPoint(ccp(0,1));
	
	cell:retain()
	self:removeCell(cell); --有可能已经在容器里面了
	if(index > #self.cellArray+1 )then
		index = #self.cellArray+1
	end
	local curCell = nil;
	local x,y = cell:getPosition();
	local margin = self.margin;
	if(index == 1)then
		margin = 0;
	end
	if(self.direction == ScrollView.VERTICAL)then
		curCell = self:cellAtIndex(index);
		if(curCell)then
			y = curCell:getPositionY();
		else
			y = -self.containerSize.height - margin;
		end
		cell:setPositionY(0)
	elseif(self.direction == ScrollView.HORIZONTAL)then
		curCell = self:cellAtIndex(index);
		if(curCell)then
			x = curCell:getPosition();
		else
			x = self.containerSize.width + margin;
		end
		cell:setPositionX(0)
--		print("xxxxx",x,y)
	end
	
	
--	print("往下挪1",cell:getPositionY(),cell:getContentSize().height)
	
	local rect = cell:boundingBox();
--	print("往下挪2",rect:getMinY(),rect:getMaxY())
	
	
	
	local rect = self:getContainerRect(cell)
	
	if(self.direction == ScrollView.VERTICAL)then
		local dy = rect:getMinY() - margin;
		for i=index,#self.cellArray,1 do
			local c = self:cellAtIndex(i);
			if(c)then
				local cx,cy = c:getPosition();
				cy = cy+dy ;
				c:setPositionY(cy);
			end
		end
		cell:setPositionY(y);
	elseif(self.direction == ScrollView.HORIZONTAL)then
		local dx = rect:getMaxX() + margin;
		for i=index,#self.cellArray,1 do
			local c = self:cellAtIndex(i);
			local cx,cy = c:getPosition();
			cx = cx+dx;
			c:setPositionX(cx);
		end
		cell:setPositionX(x);
	end
	self.container:addChild(cell);
	table.insert(self.cellArray,index,cell)
	
	self:refresh();
	print("添加cell：",index);
--	self:printCell()
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

--[[--
	移除 index序号上的 cell
]]
function ScrollList:removeCellAt(index,isDispose)
	local cell = self:cellAtIndex(index);
	if(cell == nil)then
		return
	end
	assert(cell:getParent() == self.container,"ScrollList:removeCellAt() ---------- cell not in scrollList")
	local rect = self:getContainerRect(cell);
	if(self.direction == ScrollView.VERTICAL)then
		local dy = rect:getMinY() - self.margin;
		for i=index,#self.cellArray,1 do
			local c = self:cellAtIndex(i);
			local cx,cy = c:getPosition();
			cy = cy-dy;
			c:setPositionY(cy);
		end
	elseif(self.direction == ScrollView.HORIZONTAL)then
		local dx = rect:getMaxX() + self.margin;
		for i=index,#self.cellArray,1 do
			local c = self:cellAtIndex(i);
			local cx,cy = c:getPosition();
			cx = cx-dx;
			c:setPositionX(cx);
		end
	end
	cell:removeFromParent();
	table.remove(self.cellArray,index)
	cell:release()
	self:refresh();
	if(isDispose and cell.dispose)then
		cell:dispose();
	end
	local maxRect = self.container:boundingBox();
	print("移除cell：",index,maxRect:getMinY(),maxRect:getMaxY());
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
	if(cell)then
		return tolua.cast(cell,"CCNode") 
	else
		return nil;
	end
end

--[[--
	@return (table)  返回所有cell   
]]
function ScrollList:getAllCell()
	return self.cellArray 
end


function ScrollList:getContainerRect(container,isOffset)
	local rect = container:boundingBox();
	if( rect:getMinY() >= 0 and rect:getMaxX() <= 0) then
		rect = ScrollList.super.getContainerRect(self,container,isOffset);
--		print("rect1:",rect:getMinY(),rect:getMaxX(),isOffset);
	else
		--print("rect2:",rect:getMinY(),rect:getMaxX());
	end
	return rect;
end

--[[--
	移除所有 cell
]]
function ScrollList:clear(isDispose)
	for i=1,#self.cellArray,1 do
		local cell = self:cellAtIndex(i);
		if(isDispose and cell.dispose)then
			cell:dispose();
		end
		cell:release();
	end
	self.cellArray = {};
	ScrollList.super.clear(self)
end

--[[--
	销毁
]]
function ScrollList:dispose()
	for i=1,#self.cellArray,1 do
		local cell = self:cellAtIndex(i);
		cell:release();
		if cell.dispose then
			cell:dispose();
		end
	end
	self.cellArray = nil;
	ScrollList.super.dispose(self);
end


return ScrollList;
