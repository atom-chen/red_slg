local BuildingDetailPanel = class("BuildingDetailPanel", PanelProtocol)

BuildingDetailPanel.UIResPath = "ui/building/building_detail.pvr.ccz"
BuildingDetailPanel.LUA_PATH = "building_detail"

function BuildingDetailPanel:ctor(panelName)
	PanelProtocol.ctor(self, panelName)
end

function BuildingDetailPanel:initUI(scene, buildingName)
	self:initUINode(BuildingDetailPanel.LUA_PATH)
	self._scene = scene
	self._buildingName = buildingName
	self:setCloseBtn("btn_close", self._clickCloseFunc)
	self:setOutsideClose("spr_bg")
	self.btn_delete = self.uiNode:getNodeByName("btn_delete")
	self.btn_more = self.uiNode:getNodeByName("btn_more")

	local conf = BuildingCfg:getBuildingInfo(self._buildingId);
	if conf ~= nil then
		local lv = TownModel:getBuildModel():getBuildingLevel(self._dataId);

		self.uiNode:getNodeByName("name"):setText("Lv. "..lv.." "..conf.cn_name)
		local sprite = display.newSprite("#"..conf.icon..".png")
		sprite:setScale(conf.icon_scale/100)
		local x,y = self:getNodeByName("icon_bg"):getPosition()
		sprite:setPosition(ccp(x,y))
		self.uiNode:addChild(sprite)

		self.txt_instruction = self.uiNode:getNodeByName("txt_instruction_content")
		self.txt_instruction:setText(conf.illustration)
	end

	self.btn_delete:addEventListener(Event.MOUSE_CLICK, {self, self._onDelete})
	self.btn_more:addEventListener(Event.MOUSE_CLICK, {self, self._onMore})

	if not self._canDelete then
		self.btn_delete:setVisible(false)
		self.btn_delete:setEnable(false)
	end
end

function BuildingDetailPanel:_onDelete(event)
	NotifyCenter:dispatchEvent({name=Notify.BUILDING_DELETE, pos=self._pos})
	self:closeSelf()
	floatText("建筑拆除成功")
end

function BuildingDetailPanel:_onMore(event)
	floatText("功能暂未开放")
end

function BuildingDetailPanel:_clickCloseFunc()
	self:closeSelf()
end

function BuildingDetailPanel:onOpened(params)
	if not self._loadedRes[BuildingDetailPanel.UIResPath] then
		self:loadRes(BuildingDetailPanel.UIResPath)
	end

	self._buildingId = params.buildingId
	self._dataId = params.dataId
	self._pos = params.pos
	self._canDelete = params.canDelete
	self:initUI(params.scene, params.buildingName)
end

function BuildingDetailPanel:onCloseed(params)
	if self._loadedRes[BuildingDetailPanel.UIResPath] then
		self:unloadRes(BuildingDetailPanel.UIResPath)
	end

	self.btn_delete:removeEventListener(Event.MOUSE_CLICK, {self, self._onDelete})
	self.btn_more:removeEventListener(Event.MOUSE_CLICK, {self, self._onMore})
end

function BuildingDetailPanel:isSwallowEvent()
	return true
end

function BuildingDetailPanel:isShowMark()
    return false
end

return BuildingDetailPanel