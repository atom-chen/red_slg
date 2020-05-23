local UIDelegate = class("UIDelegate", function () return display.newNode() end)

function UIDelegate:ctor(calls, info)
	self:retain()
	
	self._new = calls.new
	self._dispose = calls.dispose
	self._set = calls.set
	if not info then return end
	if info.size then
		self:setContentSize(info.size)
	end
	if self.anchor then
		self:setAnchorPoint(info.anchor)
	end
end

function UIDelegate:set(params)
	self._params = params
end

function UIDelegate:get()
	return self._params
end

function UIDelegate:getNode()
	return self._node
end

function UIDelegate:clear()
	self._params = nil
end

function UIDelegate:onShow()
	print("function UIDelegate:onShow()", tobool(self._node), self._params.heroId)
	if self._node then 
		
		return 
	end
	if not self._node then
		self._node = uihelper.call(self._new, self)
	end
	self:addChild(self._node)
	uihelper.call(self._set, self._node, self)
end

function UIDelegate:onHide()
	if not self._node then return end
	self._node:removeFromParent()
	uihelper.call(self._dispose, self._node, self)
	self._node = nil
end

function UIDelegate:dispose()
	self:onHide()
	self._new = nil
	self._dispose = nil
	self._set = nil
	self:clear()
	self:release()
end


--[[
self._showList = {}

curShowList = {}
for i=first,last do
	local item = ...
	curShowList[item] = true
end

continueShow = {}
for item,exist pairs (self._showList) do
	if not curShowList[item] then
		item:onHide()
	else
		continueShow[item] = true
	end
end

for item,exist in pairs(curShowList) do
	if not continueShow[item] do
		item:onShow()
	end
end

self._showList = curShowList
--]]

return UIDelegate