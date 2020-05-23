local UITabButton = {}

--[[
@author: changao
@date: 2016-1-11
@brief 对一组控件的操作。 控件需要有 setSelected 方法。 
@inherit none
@event:
	Event.STATE_CHANGE
@sample:
	local btn = UIButton.new({"a.png"})
	local btn1 = UIButton.new({"a1.png"})
	local btn2 = UIButton.new({"a2.png"})
	
	local group = UITabButton.new(priority)
	group:setTabList({[btn1]=creater1, [btn2]=XXClass, parent=xxNode})
	function canSwitch(event)
		return true
	end
	onstateChange = function(event)
		...
	end
	
	group:setCallback(onstateChange, canSwitch)
	group:setSelected(btn1)
	group:clear()
--]]

local UITabButton = class("UITabButton")


function UITabButton:ctor(priority)
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
function UITabButton:add(...)
	local arg = {...}
	for i=1, #arg do
		self:addOne(arg[i])
	end
end



--[[
@brief 添加一个节点到 group 中
@param UIButton 或者 其他有setSelected函数， 且能响应 Event.MOUSE_CLICK 事件的对象。
--]]
function UITabButton:addOne(node)
	if self:exists(node) then return end
	self._nodeList[node] = node
	self._cnt = self._cnt + 1
	node:setUnselectedColor(nil, true)
	if not node:hasEventListener(Event.MOUSE_CLICK, {self, UITabButton._onNodeSelected}) then
		node:addEventListener(Event.MOUSE_CLICK, {self, UITabButton._onNodeSelected})
	end
end

--[[
@brief 从UITabButton中移除一个节点
--]]
function UITabButton:remove(node)
	if self:exists(node) then
		node:removeEventListener(Event.MOUSE_CLICK, {self, UITabButton._onNodeSelected})
		node:clearGroup()
		self._nodeList[node] = nil
		self._cnt = self._cnt - 1
	end
end

--[[
@brief 添加一系列节点到 group 中
@param UIButton 或者 其他有setSelected函数， 且能响应 Event.MOUSE_CLICK 事件的对象。
--]]
function UITabButton:addSelectedTriangle()
	self:setSelectedTriangle(true, true)
end

function UITabButton:setSelectedTriangle(add, update)
	self._addedSelectedTriangle = tobool(add)
	if update then
		self:_updateSelectedTriangle()
	end
end

function UITabButton:_updateSelectedTriangle()
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

function UITabButton:setMoveMode(offset)
	self._moveMode = offset or 20
end

function UITabButton:_onNodeSelected(event)
	self:setSelected(event.target)
end

function UITabButton:exists(node)
	return self._nodeList[node] ~= nil
end

--[[
list={[btn]=cls,}
--]]
function UITabButton:setTabList(tabList, add)
	self._tabList = tabList
	if add == nil or add then
		if tabList then
			for btn,_ in pairs(self._tabList) do
				if type(btn) ~= "string" then--userdata or table
					self:addOne(btn)
				end
			end
		end
	end
end

function UITabButton:newContent(tab)
	if not self._contents then
		self._contents = {}
	end
	local content = self._contents[tab]
	if content then
		return content
	end
	local creater = self._tabList[tab]

	if type(creater) == "function" then
		content = creater()
	elseif type(creater) == "table" and  not creater.new then
		content = uihelper.call(creater)
	elseif creater then
		content = creater.new()
	else
		return nil
	end
	self._contents[tab] = content
	return content
end

function UITabButton:getCurrentContent()
	return self._currentContent
end

function UITabButton:switchContent(content)
	local old = self._currentContent
	if old == content then
		return
	end
	if old then
		if old.onRemoved then
			old:onRemoved()
		end
		old:removeFromParent()
	end
	
	self._currentContent = content
	if content then
		local parent = self._tabList.parent
		if type(parent) == "function" then
			parent(content)
		elseif parent then
			self._tabList.parent:addChild(content)
		end
		if content.onAdded then
			content:onAdded()
		end
	end
end

function UITabButton:clearAllContents()
	if self._contents then
		for btn, content in pairs(self._contents) do
			content:removeFromParent()
			if content.dispose then
				content:dispose()
			end
		end
		self._currentContent = nil
		self._contents = nil
	end
end

function UITabButton:removeContent(content)
	for btn, c in pairs(self._contents) do
		if c == content then
			self._contents[btn] = nil
			break
		end
	end
	return content
end

function UITabButton:clear(clearTabState)
	if clearTabState or clearTabState == nil then
		self:unselectAll(false)
	end
	self:clearAllContents()
end

function UITabButton:clearCurrentContent()
	if self._currentContent then
		self._currentContent:removeFromParent()
		if self._currentContent.onRemoved then
			self._currentContent:onRemoved()
		end
		self._currentContent = nil
	end
end

function UITabButton:setCallback(onStateChange, preChange)
	self._preChange = preChange
	self._onStateChange = onStateChange
	self:_addCallBack()
end

function UITabButton:_clearCallBack()
	self:removeEventListener(Event.STATE_CHANGE, {self, self._statChange})
end

function UITabButton:_addCallBack()
	self:addEventListener(Event.STATE_CHANGE, {self, self._statChange})
end

function UITabButton:_statChange(event)
	print("function UITabButton:_statChange(event)")
	local change = true
	if self._preChange then
		change = uihelper.call(self._preChange, event)
	end
	if not change then
		if event.unselectNode then
			self:setSelected(event.unselectNode)
		end
	else
		local content = self:newContent(event.selectNode)
		if content then
			self:switchContent(content)
		end
		uihelper.call(self._onStateChange, event)
	end
end

function UITabButton:setSelected(node,noDispatch)
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

function UITabButton:unselectAll(dispatch)
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

function UITabButton:getSelected()
	return self._selectedNode
end

function UITabButton:getNodes(Pred)
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

function UITabButton:getCount()
	return self._cnt
end

function UITabButton:removeAllNodes(clearNodeEvents)
	if clearNodeEvents == nil or clearNodeEvents then
		for k,v in pairs(self._nodeList) do
			self:remove(v)
		end
	end
	self._nodeList = {}
	self._cnt = 0
end

function UITabButton:dispose()
	for k,v in pairs(self._nodeList) do
		self:remove(v)
	end
	self:clear(true)
	
	self:removeAllEventListeners()
	self._selectedNode = nil
	self._nodeList = nil
end



return UITabButton