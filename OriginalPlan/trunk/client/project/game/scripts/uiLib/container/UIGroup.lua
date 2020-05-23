--[[
@author: changao
@date: 2014-06-24
@brief 对一组控件的操作。 控件需要有 setSelected 方法。
@inherit none
@event:
	Event.STATE_CHANGE
@sample:
	local btn = UIButton.new({"a.png"})
	local btn1 = UIButton.new({"a1.png"})
	local btn2 = UIButton.new({"a2.png"})

	local group = UIGroup.new()
	group:add(btn)
	group:add(btn1, btn2)


	function onState_Change(event)
		if event.unselectNode then
			print("unselected node sth")
		end

		if event.selectNode then
			print("selected node sth")
		end
	end

	group:addEventListener(Event.STATE_CHANGE, onState_Change)
	group:setSelected(btn)
	group:setSelected(btn1)
	group:setSelected(btn2)
--]]

local UIGroup = class("UIGroup")


function UIGroup:ctor(priority)
	EventProtocol.extend(self)

	self._nodeList = {}
	self._cnt = 0
	self._priority = priority or -255
	self._selectedNode = nil
end

--[[
@brief 添加一系列节点到 group 中
@param UIButton 或者 其他有setSelected函数， 且能响应 Event.MOUSE_CLICK 事件的对象。
--]]
function UIGroup:add(...)
	local arg = {...}
	for i=1, #arg do
		self:addOne(arg[i])
	end
end



--[[
@brief 添加一个节点到 group 中
@param UIButton 或者 其他有setSelected函数， 且能响应 Event.MOUSE_CLICK 事件的对象。
--]]
function UIGroup:addOne(node)
	if self:exists(node) then return end
	self._nodeList[node] = node
	self._cnt = self._cnt + 1
	node:setUnselectedColor(nil, true)
	if not node:hasEventListener(Event.MOUSE_CLICK, {self, UIGroup._onNodeSelected}) then
		node:addEventListener(Event.MOUSE_CLICK, {self, UIGroup._onNodeSelected})
	end
end

--[[
@brief 从UIGroup中移除一个节点
--]]
function UIGroup:remove(node)
	if self:exists(node) then
		node:removeEventListener(Event.MOUSE_CLICK, {self, UIGroup._onNodeSelected})
		node:clearGroup()
		self._nodeList[node] = nil
		self._cnt = self._cnt - 1
	end
end

--[[
@brief 添加一系列节点到 group 中
@param UIButton 或者 其他有setSelected函数， 且能响应 Event.MOUSE_CLICK 事件的对象。
--]]
function UIGroup:addSelectedTriangle()
	self:setSelectedTriangle(true, true)
end

function UIGroup:setSelectedTriangle(add, update)
	self._addedSelectedTriangle = tobool(add)
	if update then
		self:_updateSelectedTriangle()
	end
end

function UIGroup:_updateSelectedTriangle()
	if self._addedSelectedTriangle then
		for k,node in pairs(self._nodeList) do
			if node.clearTriangle and node ~= self._selectedNode then
				node:clearTriangle()
			elseif node.addTriangle and node == self._selectedNode then
				node:addTriangle()
			end
		end
	else
		for k,node in pairs(self._nodeList) do
			if node.clearTriangle then
				node:clearTriangle()
			end
		end
	end
end

function UIGroup:setMoveMode(offset)
	self._moveMode = offset or 20
end

function UIGroup:_onNodeSelected(event)
	self:setSelected(event.target)
end

function UIGroup:exists(node)
	return self._nodeList[node] ~= nil
end

function UIGroup:setSelected(node,noDispatch)
	if not node then return end
	local newSelectedNode = self._nodeList[node]
	if not newSelectedNode then return end
	local oldSelectedNode = self._selectedNode
	if newSelectedNode == oldSelectedNode then return end

	if oldSelectedNode then oldSelectedNode:setSelected(false) end
	newSelectedNode:setSelected(true)
	newSelectedNode:setSelectedColor(true)


	if self._addedSelectedTriangle and newSelectedNode.addTriangle then
		newSelectedNode:addTriangle()
	end

	if self._moveMode then
		if oldSelectedNode then
			oldSelectedNode:setPositionX(oldSelectedNode:getPositionX()-self._moveMode)
		end
		if newSelectedNode then
			newSelectedNode:setPositionX(newSelectedNode:getPositionX()+self._moveMode)
		end
	end

	if oldSelectedNode then
		oldSelectedNode:setUnselectedColor(nil, true)
		if oldSelectedNode.clearTriangle and self._addedSelectedTriangle then
			oldSelectedNode:clearTriangle()
		end
	end
	self._selectedNode = newSelectedNode
	if not noDispatch then
		self:dispatchEvent({name = Event.STATE_CHANGE, unselectNode=oldSelectedNode, selectNode=newSelectedNode})
	end
end

function UIGroup:unselectAll(dispatch)
	local oldSelectedNode = self._selectedNode
	self._selectedNode = nil
	if nil ~= oldSelectedNode then
		oldSelectedNode:setSelected(false)

		if oldSelectedNode then
			oldSelectedNode:setUnselectedColor(nil, true)
			if self._moveMode then
				oldSelectedNode:setPositionX(oldSelectedNode:getPositionX()-self._moveMode)
			end
		end
end
	if dispatch and oldSelectedNode then
		self:dispatchEvent({name = Event.STATE_CHANGE, unselectNode=oldSelectedNode, selectNode=nil})
	end
end

function UIGroup:getSelected()
	return self._selectedNode
end

function UIGroup:getNodes(Pred)
	local nodes = {}
	if not Pred then
		for k,v in pairs(self._nodeList) do
			table.insert(nodes, v)
		end
	else
		for k,v in pairs(self._nodeList) do
			if pred(v) then
				table.insert(nodes, v)
			end
		end
	end
	return nodes
end

function UIGroup:getCount()
	return self._cnt
end

function UIGroup:dispose()
	for k,v in pairs(self._nodeList) do
		self:remove(v)
	end

	self:removeAllEventListeners()
	self._selectedNode = nil
	self._nodeList = nil
end

return UIGroup