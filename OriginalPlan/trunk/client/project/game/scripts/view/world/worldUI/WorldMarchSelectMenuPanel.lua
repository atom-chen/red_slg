local WorldMarchSelectMenuPanel = class("WorldMarchSelectMenuPanel", function() return display.newNode() end)

game_require("math.MathUtil")

function WorldMarchSelectMenuPanel:ctor(priority, map, units, marchNode)
	--! WorldMap
	self._map = map
	--! WMMarchUnits
	self._units = units
	--! WMMarchElemNode
	self._marchNode = marchNode
    self.uiNode = UINode.new(priority - 1, true)
    self.uiNode:setUI("world_march_select_menu")
    self._priority = priority-1
	self:setAnchorPoint(ccp(0,0))
    self:addChild(self.uiNode)

	self.status = self.uiNode:getNodeByName("status")
	self.name = self.uiNode:getNodeByName("name")
	self.pos = self.uiNode:getNodeByName("pos")
	self.btnAccelerate = self.uiNode:getNodeByName("accelerate_btn")
	self.btnAccelerate:addEventListener(Event.MOUSE_CLICK, {self,self.clickAccelerate})
	self.btnBackHome = self.uiNode:getNodeByName("backhome_btn")
	self.btnBackHome:addEventListener(Event.MOUSE_CLICK, {self,self.clickBackHome})
    self:retain()
end

function WorldMarchSelectMenuPanel:clickAccelerate(event)
	self._units:accelerate()
end

function WorldMarchSelectMenuPanel:clickBackHome(event)
	self._units:backToHome()
	NotifyCenter:dispatchEvent({name=Notify.WORLD_UNSELECT_CLICK})
end

function WorldMarchSelectMenuPanel:hideBackHome()
	self.btnBackHome:setEnable(false)
	self.btnBackHome:setVisible(false)
end

function WorldMarchSelectMenuPanel:getBlockPos()
	return self.blockPos
end

function WorldMarchSelectMenuPanel:showInfo( blockPos, destBlockPos, isBackHome )
    self.data = WorldMapModel:getAllElemInfoAt( blockPos ).base.data
	self.name:setText(self.data.worldPlayerInfo.name)
	self.pos:setText(string.format("To (%.0f, %.0f)",destBlockPos.x,destBlockPos.y))
	if isBackHome then
		self.status:setText("返回")
	else
		self.status:setText("出征")
	end
	if self.data.worldPlayerInfo.relationShip ~= 1 then
		self.btnAccelerate:setVisible(false)
		self.btnBackHome:setVisible(false)
		self.btnAccelerate:setEnable(false)
		self.btnBackHome:setEnable(false)
	end

	if isBackHome then
		self:hideBackHome()
	end
end

function WorldMarchSelectMenuPanel:dispose()
	self.btnAccelerate:removeEventListener(Event.MOUSE_CLICK,{self,self.clickAccelerate})
	self.btnBackHome:removeEventListener(Event.MOUSE_CLICK,{self,self.clickBackHome})
    self.uiNode:dispose()
    self:release()
end

function WorldMarchSelectMenuPanel:updateInfo( mapNodePos )
    -- body
    self:setPosition(mapNodePos)
end

function WorldMarchSelectMenuPanel:dispose()

end

return WorldMarchSelectMenuPanel
