local BuildingCreateArmyItem = game_require("view.town.building.BuildingCreateArmyItem")
local BuildingCreateArmyPanel = class("BuildingCreateArmyPanel", PanelProtocol)

BuildingCreateArmyPanel.UIResPath = "ui/building/building_create_army.pvr.ccz"
BuildingCreateArmyPanel.LUA_PATH = "building_create_army"

function BuildingCreateArmyPanel:ctor(panelName)
	PanelProtocol.ctor(self, panelName)

	self._canCreateList = {}
end

function BuildingCreateArmyPanel:initUI(scene, buildingName)
	self:initUINode(BuildingCreateArmyPanel.LUA_PATH)
	self._scene = scene
	self._buildingName = buildingName
	self:setCloseBtn("btn_close", self._clickCloseFunc)
	self:setOutsideClose("spr_bg")
	self.btn_fastcreate = self.uiNode:getNodeByName("btn_fastcreate")
	self.btn_create = self.uiNode:getNodeByName("btn_create")
	self.btn_dismiss = self.uiNode:getNodeByName("btn_dismiss")
	self.btn_scroll_up = self.uiNode:getNodeByName("btn_scroll_up")
	self.btn_scroll_down = self.uiNode:getNodeByName("btn_scroll_down")
	self.btn_scroll_up:setEnable(false)
	self.btn_scroll_down:setEnable(false)
	self.btn_scroll_up:setVisible(false)
	self.btn_scroll_down:setVisible(false)
	--! ScrollListEx
	self.scrollList = self.uiNode:getNodeByName("scroll_cont")
	--self.scrollList.margin = 20;
	self._selectItem = nil

	self.btn_fastcreate:addEventListener(Event.MOUSE_CLICK, {self, self._onFastCreate})
	self.btn_create:addEventListener(Event.MOUSE_CLICK, {self, self._onCreate})
	self.btn_dismiss:addEventListener(Event.MOUSE_CLICK, {self, self._onDismiss})
	self.btn_scroll_up:addEventListener(Event.MOUSE_CLICK, {self, self._onScrollUp})
	self.btn_scroll_down:addEventListener(Event.MOUSE_CLICK, {self, self._onScrollDown})

	NotifyCenter:addEventListener(Notify.BUILDING_CREATE_ARMY_ITEM_SELECT, {self,self._onItemSelect})

	self:showCanCreateItems()
end

function BuildingCreateArmyPanel:showCanCreateItems()
	local conf = {
		{name="机械杀手",count=24,opened=true,icon="arm_01",scale=100,armId=1},
		{name="未来坦克",count=13,opened=true,icon="arm_02",scale=80,armId=2},
		{name="尤里",count=10,opened=true,icon="arm_03",scale=100,armId=3},
		{name="直升机",count=12,opened=true,icon="arm_04",scale=100,armId=4},
		{name="医疗兵",count=10,opened=false,icon="arm_05",scale=100,armId=5},
		{name="V3火箭",count=6,opened=false,icon="arm_06",scale=100,armId=6},
	}
	if conf ~= nil then
		for _,v in pairs(conf) do
			local item = BuildingCreateArmyItem.new(self:getPriority()-1);
			self._canCreateList[#self._canCreateList+1] = item
			item:setInfo(v)
			if #self._canCreateList == 1 then
				item:showSelect(true)
				self._selectItem = item;
			else
				item:showSelect(false)
			end
			self.scrollList:addCell(item)
		end
	end
	self.scrollList:setScrollTo(ScrollView.TOP)
	local offset = self.scrollList:getContentOffset();
	print("offset "..offset.x..","..offset.y)

	local size = self.scrollList:getViewSize()
	print("size "..size.width..","..size.height)

	for k,v in pairs(self.scrollList.cellArray) do
		local x,y = v:getPosition()
		print("offset"..k..": "..(offset.x+x)..","..(offset.y+y))
	end
end

function BuildingCreateArmyPanel:_onItemSelect(event)
	if self._selectItem ~= nil then
		self._selectItem:showSelect(false);
	end
	self._selectItem = event.selectItem;
	self._selectItem:showSelect(true)
end

function BuildingCreateArmyPanel:_onFastCreate(event)
	floatText("功能暂未开放")
end

function BuildingCreateArmyPanel:_onCreate(event)
	floatText("功能暂未开放")
end

function BuildingCreateArmyPanel:_onDismiss(event)
	floatText("功能暂未开放")
end

function BuildingCreateArmyPanel:_onScrollUp(event)
	self.scrollList:setScrollPosByIndex(2, true)
end

function BuildingCreateArmyPanel:_onScrollDown(event)
	self.scrollList:setScrollPosByIndex(3, true)
end

function BuildingCreateArmyPanel:updateUI()
	local lv = TownModel:getBuildModel():getBuildingLevel(self._dataId)
	self.uiNode:getNodeByName("level"):setText("Lv. "..lv)
end

function BuildingCreateArmyPanel:_clickCloseFunc()
	self:closeSelf()
end

function BuildingCreateArmyPanel:onOpened(params)
	if not self._loadedRes[BuildingCreateArmyPanel.UIResPath] then
		self:loadRes(BuildingCreateArmyPanel.UIResPath)
	end

	self._buildingId = params.buildingId
	self._dataId = params.dataId
	self._pos = params.pos
	self:initUI(params.scene, params.buildingName)
end

function BuildingCreateArmyPanel:onCloseed(params)
	if self._loadedRes[BuildingCreateArmyPanel.UIResPath] then
		self:unloadRes(BuildingCreateArmyPanel.UIResPath)
	end

	self.btn_fastcreate:removeEventListener(Event.MOUSE_CLICK, {self, self._onFastCreate})
	self.btn_create:removeEventListener(Event.MOUSE_CLICK, {self, self._onCreate})
	self.btn_dismiss:removeEventListener(Event.MOUSE_CLICK, {self, self._onDismiss})
	self.btn_scroll_up:removeEventListener(Event.MOUSE_CLICK, {self, self._onScrollUp})
	self.btn_scroll_down:removeEventListener(Event.MOUSE_CLICK, {self, self._onScrollDown})

	self._canCreateList = {}

	NotifyCenter:removeEventListener(Notify.BUILDING_CREATE_ARMY_ITEM_SELECT, {self,self._onItemSelect})
end

function BuildingCreateArmyPanel:isSwallowEvent()
	return true
end

function BuildingCreateArmyPanel:isShowMark()
    return false
end

return BuildingCreateArmyPanel