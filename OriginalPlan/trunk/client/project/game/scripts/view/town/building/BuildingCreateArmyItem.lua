local BuildingCreateArmyItem = class("BuildingCreateArmyItem",function() return display.newNode() end)

function BuildingCreateArmyItem:ctor(priority)
	self._priority = priority-1
	self:initUI(self._priority)
	self:retain()
end

function BuildingCreateArmyItem:initUI(priority)
	self.uiNode = UINode.new(priority, false)
    self:addChild(self.uiNode)
    self.uiNode:setUI("building_create_army_item")

    self._bg = self.uiNode:getNodeByName("bg1")
	self._bg_select = self.uiNode:getNodeByName("bg2")
	self._bg_lock = self.uiNode:getNodeByName("bg_lock")
	--! UIButton
	self._btn = self.uiNode:getNodeByName("btn")
	self._btn:addEventListener(Event.MOUSE_CLICK,{self,self._clickSelect})
    self:setContentSize(self._bg:getContentSize())
end

function BuildingCreateArmyItem:_clickSelect(event)
	NotifyCenter:dispatchEvent({name=Notify.BUILDING_CREATE_ARMY_ITEM_SELECT, selectItem=self})
end

function BuildingCreateArmyItem:setInfo(info)
	self.info = info
	self.uiNode:getNodeByName("name"):setText(info.name)
	local sprite = display.newSprite("#"..info.icon..".png")
	sprite:setScale(info.scale/100)
	local size = self._bg:getSize()
	local x,y = self._bg:getPosition()
	sprite:setPosition(x+size.width/2, y+size.height/2)
	self.uiNode:addChild(sprite)

	if info.opened then
		self.uiNode:getNodeByName("txt_count"):setText("已造 "..info.count)
		self:showLock(false);
	else
		self.uiNode:getNodeByName("txt_count"):setText("未解锁")
		self:showLock(true);
	end
end

function BuildingCreateArmyItem:getBuildId()
	return self.info.buildId
end

function BuildingCreateArmyItem:showSelect(flag)
	self._bg_select:setVisible(flag)
end

function BuildingCreateArmyItem:showLock(flag)
	self._bg:setVisible(not flag);
	self._bg_lock:setVisible(flag);
end

function BuildingCreateArmyItem:dispose()
	self._btn:removeEventListener(Event.MOUSE_CLICK,{self,self._clickSelect})
	self.uiNode:dispose()
	self:release()
end

return BuildingCreateArmyItem
