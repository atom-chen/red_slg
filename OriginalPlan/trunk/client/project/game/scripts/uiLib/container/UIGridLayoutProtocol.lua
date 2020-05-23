--[[
class: UIGridLayoutProtocol
desc: 布局协议
author：changao
date: 2014-06-03
example：
	local btn = UIImage.new("#button.png")
	local btn1 = UIImage.new("#button.png")
	UIGridLayoutProtocol.extend(btn)
	btn.layoutAdd(btn)
--]]

local UIGridLayoutProtocol = {}
--[[
@brief 扩展
@param size CCSize 如果为nil, 则从border， image和background-image 选择最大的 width 和 height 作为 size。若都没设置， 则选择 CCSize(82,82)作为size
@param bgimage bgground
--]]
function UIGridLayoutProtocol.extend(object, size, itemSize)
	object._layoutPadding = {left=0, right=0, bottom=0, top=0}
	
	object._layoutItems = {}
	object._layoutItemSize = itemSize or CCSize(82, 82)
	local ox, oy = object:getPosition()
	local worldpos = object:convertToWorldSpace(ccp(ox, oy))
	--print("object world pos:", ox, oy)
	object._layoutSize = size
	function object:setNodeSize(nodeSize, update)
		self._layoutItemSize = nodeSize
		if update then
			self:layoutUpdate()
		end
	end
	
	function object:layoutSetPadding(left, right, bottom, top)
		if left then object._layoutPadding.left = tonumber(left) end
		if right then object._layoutPadding.right = tonumber(right) end
		if bottom then object._layoutPadding.bottom = tonumber(bottom) end
		if top then object._layoutPadding.top = tonumber(top) end
	end

	function object:layoutUpdate()
		local cnt = #self._layoutItems
		if cnt < 1 then return end
		
		local size = self._layoutSize or self:getContentSize()
		local w,h = size.width-self._layoutPadding.left-self._layoutPadding.right
		local wcount = math.floor(w/self._layoutItemSize.width)
		local wstep = w/wcount
		local hstep = self._layoutItemSize.height
		local x_begin = self._layoutPadding.left + wstep/2
		local y = size.height - self._layoutPadding.top - hstep/2
		
		x = x_begin
		for i=1, cnt do
			self:_layoutSetCenter(self._layoutItems[i].node, x, y)
			x = x + wstep
			if (i%wcount == 0) then
				y = y - hstep
				x = x_begin
			end
		end
	end
	
	function object:layoutAdd(node, data)
		self:addChild(node)
		local size = self._layoutSize or self:getContentSize()
		
		local w = size.width-self._layoutPadding.left-self._layoutPadding.right
		
		print("layoutAdd", size, w, self._layoutItemSize.width)
		local wcount = math.floor(w/self._layoutItemSize.width)
		local wstep = w/wcount
		local hstep = self._layoutItemSize.height
		local x = self._layoutPadding.left - wstep/2
		local y = size.height - self._layoutPadding.top - hstep/2
		local cnt = #self._layoutItems
		self._layoutItems[cnt+1] = {node = node, data = data}
		x = x + (((cnt) % wcount) + 1) * wstep
		y = y - math.floor((cnt)/wcount) * hstep
		print("layout add count", cnt, "x,y",  x, y, wcount)
		self:_layoutSetCenter(node, x, y)
	end

	function object:layoutFindNodeByData(data, eq_comp)
		for i,v in ipairs(self._layoutItems) do
			if eq_comp then
				if (eq_comp(data, v.data)) then
					return v.node, v.data
				end
			else
				if data == v.data then
					return v.node, v.data
				end
			end
		end
	end
	
	function object:layoutGetNodeData(node)
		for i,v in ipairs(self._layoutItems) do
			if node == v.node then
				return v.data
			end
		end
	end
	
	function object:layoutRemoveByData(data, eq_comp)
		for i=#self._layoutItems,1,-1 do
			if eq_comp then
				if (eq_comp(data, v.data)) then
					self:removeChild(self._layoutItems[i].node)
					self._layoutItems[i].node:dispose()
					table.remove(self._layoutItems, i)
				end
			else
				if data == v.data then
					self:removeChild(self._layoutItems[i].node)
					self._layoutItems[i].node:dispose()
					table.remove(self._layoutItems, i)
				end
			end
		end
	end
	
	function object:_layoutSetCenter(node, x, y)
		local anchor = node:getAnchorPoint()
		local size = node:getContentSize()
		local w = size.width * (anchor.x - 0.5)
		local h = size.height * (anchor.y - 0.5)
		--print("_layoutSetCenter(", x + w, y + h, ")  anchor(", anchor.x, anchor.y, ")  w:", size.width, " h:", size.height)
		node:setPosition(ccp(x + w, y + h))
		if (y + h - size.height * 0/5 < 0) then
			local cs = self:getContentSize()
			self._layoutSize.height = self._layoutSize.height + self._layoutItemSize.height
			self:setContentSize(self._layoutSize)
			for i=#self._layoutItems,1,-1 do
				local n = self._layoutItems[i].node
				local oldy = n:getPositionY()
				n:setPositionY(oldy + self._layoutItemSize.height)
			end
		end
	end

	function object:layoutClear()
		for i=#self._layoutItems,1,-1  do
			self._layoutItems[i].node:removeFromParent()
			self._layoutItems[i].node:dispose()
			self._layoutItems[i] = nil
		end
		
		self._layoutItems = {}
	end
	
	return object
end

return UIGridLayoutProtocol