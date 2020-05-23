local BuildingLevelUpPanel = class("BuildingLevelUpPanel", PanelProtocol)

BuildingLevelUpPanel.UIResPath = "ui/building/building_levelup.pvr.ccz"
BuildingLevelUpPanel.LUA_PATH = "building_levelup"

function BuildingLevelUpPanel:ctor(panelName)
	PanelProtocol.ctor(self, panelName)
end

function BuildingLevelUpPanel:initUI(scene, buildingName)
	self:initUINode(BuildingLevelUpPanel.LUA_PATH)
	self._scene = scene
	self._buildingName = buildingName
	self:setCloseBtn("btn_close", self._clickCloseFunc)
	self:setOutsideClose("spr_bg")
	self.btn_fastfinish = self.uiNode:getNodeByName("btn_fastfinish")
	self.btn_levelup = self.uiNode:getNodeByName("btn_levelup")

	local conf = BuildingCfg:getBuildingInfo(self._buildingId);
	if conf ~= nil then
		local lv = TownModel:getBuildModel():getBuildingLevel(self._dataId);

		self.uiNode:getNodeByName("level"):setText("Lv. "..lv)
		self.uiNode:getNodeByName("name"):setText(" "..conf.cn_name)
		local sprite = display.newSprite("#"..conf.icon..".png")
		sprite:setScale(conf.icon_scale/100)
		local x,y = self:getNodeByName("icon_bg"):getPosition()
		sprite:setPosition(ccp(x,y))
		self.uiNode:addChild(sprite)
	end

	self.btn_fastfinish:addEventListener(Event.MOUSE_CLICK, {self, self._onFastFinish})
	self.btn_levelup:addEventListener(Event.MOUSE_CLICK, {self, self._onLevelUp})
end

function BuildingLevelUpPanel:_onFastFinish(event)
	NotifyCenter:dispatchEvent(
		{
			name = Notify.BUILDING_LEVELUP,
			dataId = self._dataId,
			buildingId = self._buildingId
		}
	)
	NotifyCenter:dispatchEvent(
		{
			name = Notify.BUILDING_FAST_FINISH,
			dataId = self._dataId,
			buildingId = self._buildingId
		}
	)

	self:updateUI()
	self:closeSelf()

--	floatText("建筑升级已完成")
end

function BuildingLevelUpPanel:_onLevelUp(event)
	NotifyCenter:dispatchEvent(
		{
			name = Notify.BUILDING_LEVELUP,
			dataId = self._dataId,
			buildingId = self._buildingId
		}
	)

	self:closeSelf()
	floatText("建筑开始升级")
end

function BuildingLevelUpPanel:updateUI()
	local lv = TownModel:getBuildModel():getBuildingLevel(self._dataId)
	self.uiNode:getNodeByName("level"):setText("Lv. "..lv)
end

function BuildingLevelUpPanel:_clickCloseFunc()
	ViewMgr:close(Panel.BUILDING_LEVELUP)
end

function BuildingLevelUpPanel:onOpened(params)
	if not self._loadedRes[BuildingLevelUpPanel.UIResPath] then
		self:loadRes(BuildingLevelUpPanel.UIResPath)
	end

	self._buildingId = params.buildingId
	self._dataId = params.dataId
	self._pos = params.pos
	self:initUI(params.scene, params.buildingName)
end

function BuildingLevelUpPanel:onCloseed(params)
	if self._loadedRes[BuildingLevelUpPanel.UIResPath] then
		self:unloadRes(BuildingLevelUpPanel.UIResPath)
	end

	self.btn_fastfinish:removeEventListener(Event.MOUSE_CLICK, {self, self._onFastFinish})
	self.btn_levelup:removeEventListener(Event.MOUSE_CLICK, {self, self._onLevelUp})
end

function BuildingLevelUpPanel:isSwallowEvent()
	return true
end

function BuildingLevelUpPanel:isShowMark()
    return false
end

return BuildingLevelUpPanel