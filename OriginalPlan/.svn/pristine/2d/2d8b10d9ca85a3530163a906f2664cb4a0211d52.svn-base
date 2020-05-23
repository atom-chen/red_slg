local BuildingCreateItem = class("BuildingCreateItem",function() return display.newNode() end)

function BuildingCreateItem:ctor(priority)
	self._priority = priority-1
	self:initUI(self._priority)
	self:retain()
end

function BuildingCreateItem:initUI(priority)
	self.uiNode = UINode.new(priority, false)
    self:addChild(self.uiNode)
    self.uiNode:setUI("building_create_item")

    self._bg = self.uiNode:getNodeByName("bg")
	self._bg_select = self.uiNode:getNodeByName("bg_select")
	--! UIButton
	self._btn = self.uiNode:getNodeByName("btn")
	self._btn:addEventListener(Event.MOUSE_CLICK,{self,self._clickSelect})
    self:setContentSize(self._bg:getContentSize())
end

function BuildingCreateItem:_clickSelect(event)
	NotifyCenter:dispatchEvent({name=Notify.BUILDING_CREATE_ITEM_SELECT, selectItem=self})
end

function BuildingCreateItem:setInfo(info)
	self.info = info
	self.uiNode:getNodeByName("name"):setText(info.name)
	local sprite = display.newSprite("#"..info.icon..".png")
	sprite:setScale(info.scale/100)
	local size = self._bg:getSize()
	sprite:setPosition(size.width/2, size.height/2)
	self.uiNode:addChild(sprite)
end

function BuildingCreateItem:getBuildId()
	return self.info.buildId
end

function BuildingCreateItem:showSelect(flag)
	self._bg_select:setVisible(flag)
end

function BuildingCreateItem:dispose()
	self._btn:removeEventListener(Event.MOUSE_CLICK,{self,self._clickSelect})
	self.uiNode:dispose()
	self:release()
end

return BuildingCreateItem
