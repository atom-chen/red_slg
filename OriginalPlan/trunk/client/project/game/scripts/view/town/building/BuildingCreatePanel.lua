local BuildingCreateItem = game_require("view.town.building.BuildingCreateItem")
local BuildingCreatePanel = class("BuildingCreatePanel", PanelProtocol)

BuildingCreatePanel.UIResPath = "ui/building/building_create.pvr.ccz"
BuildingCreatePanel.LUA_PATH = "building_create"

function BuildingCreatePanel:ctor(panelName)
	PanelProtocol.ctor(self, panelName)

	self._canCreateList = {}
end

function BuildingCreatePanel:initUI(scene, buildingName)
	self:initUINode(self.LUA_PATH)
	--! BuildingCreateItem
	self._selectItem = nil;
	self._scene = scene
	self._buildingName = buildingName
	self:setCloseBtn("btn_close", self._clickCloseFunc)
	self:setOutsideClose("spr_bg")
	--! ScrollListEx
	self.scrollList = self.uiNode:getNodeByName("scroll_cont")
	self.btn_create = self.uiNode:getNodeByName("btn_create")
	self:showCanCreateItems()

	self.btn_create:addEventListener(Event.MOUSE_CLICK, {self, self._onCreateItem})
	NotifyCenter:addEventListener(Notify.BUILDING_CREATE_ITEM_SELECT, {self,self._onItemSelect})
end

function BuildingCreatePanel:_onCreateItem(event)
	NotifyCenter:dispatchEvent(
		{
			name=Notify.BUILDING_CREATE,
			nodePos=self._nodePos,
			buildId=self._selectItem:getBuildId(),
			pos = self._pos,
		}
	)
end

function BuildingCreatePanel:_onItemSelect(event)
	if self._selectItem ~= nil then
		self._selectItem:showSelect(false);
	end
	self._selectItem = event.selectItem;
	self._selectItem:showSelect(true)

	self:updateUI()
end

function BuildingCreatePanel:updateUI()
	if self._selectItem ~= nil then
		local conf = BuildingCfg:getBuildingInfo(self._selectItem:getBuildId())
		if nil ~= conf then
			self.uiNode:getNodeByName("txt_tips"):setText(conf.illustration)
		end
	end
end

function BuildingCreatePanel:showCanCreateItems()
	local conf = BuildingCfg:getCanCreateListByName(self._buildingName)
	if conf ~= nil then
		for _,v in pairs(conf) do
			local item = BuildingCreateItem.new(self:getPriority()-1);
			self._canCreateList[#self._canCreateList+1] = item
			local info = BuildingCfg:getBuildingInfo(v)
			item:setInfo({name=info.cn_name, icon=info.icon, scale=info.icon_scale, buildId=v})
			if #self._canCreateList == 1 then
				item:showSelect(true)
				self._selectItem = item;

				self:updateUI()
			else
				item:showSelect(false)
			end
			self.scrollList:addCell(item)
		end
	end
	self.scrollList:setScrollTo(ScrollView.LEFT)
end

function BuildingCreatePanel:_clickCloseFunc()
	ViewMgr:close(Panel.BUILDING_CREATE)
end

function BuildingCreatePanel:onOpened(params)
	if not self._loadedRes[BuildingCreatePanel.UIResPath] then
		self:loadRes(BuildingCreatePanel.UIResPath)
	end

	self:initUI(params.scene, params.buildingName)
	self._nodePos = params.nodePos
	self._pos = params.pos
end

function BuildingCreatePanel:onCloseed(params)
	if self._loadedRes[BuildingCreatePanel.UIResPath] then
		self:unloadRes(BuildingCreatePanel.UIResPath)
	end
	self._canCreateList = {}
	NotifyCenter:removeEventListener(Notify.BUILDING_CREATE_ITEM_SELECT, {self,self._onItemSelect})
	self.btn_create:removeEventListener(Event.MOUSE_CLICK, {self, self._onCreateItem})
end

function BuildingCreatePanel:isSwallowEvent()
	return true
end

function BuildingCreatePanel:isShowMark()
    return false
end

return BuildingCreatePanel
