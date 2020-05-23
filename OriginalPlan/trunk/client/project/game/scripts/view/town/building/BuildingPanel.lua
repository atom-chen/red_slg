--
-- Author: lyc
-- Date: 2016-05-26 14:51:00
--
local BuildingPanel = class('BuildingPanel', function()
	return display.newNode()
end)

BuildingPanel.UIResPath = "ui/building/building_select.pvr.ccz"
BuildingPanel.LUA_PATH = "building_create_select"

function BuildingPanel:ctor(scene, townPanel)
	self._scene = scene
	self._townPanel = townPanel
	self:retain()
end

function BuildingPanel:_onDelete(event)
	NotifyCenter:dispatchEvent({name=Notify.BUILDING_DELETE, pos=self._buildingObj:getPos()})
end
function BuildingPanel:_onDetail(event)
	ViewMgr:open(Panel.BUILDING_DETAIL, {
		scene=self._scene,
		buildingId=self._buildingObj:getBuildId(),
		buildName=self._buildingObj:getBuildName(),
		dataId=self._buildingObj:getDataId(),
		pos=self._buildingObj:getPos(),
		canDelete = self._buildingObj:canDelete()
	})

	NotifyCenter:dispatchEvent({name=Notify.BUILDING_UNSELECT})
end
function BuildingPanel:_onLevelup(event)
	ViewMgr:open(Panel.BUILDING_LEVELUP, {
		scene=self._scene,
		buildingId=self._buildingObj:getBuildId(),
		buildName=self._buildingObj:getBuildName(),
		dataId=self._buildingObj:getDataId(),
		pos=self._buildingObj:getPos()
	})

	NotifyCenter:dispatchEvent({name=Notify.BUILDING_UNSELECT})
end
function BuildingPanel:_onFunction(event)

	local canOpenBuildName = {
		"jianzhu_bubingying",
		"jianzhu_zhanchegongchang",
		"jianzhu_jichang",
	}

	local canOpenFlag = false
	for k,v in ipairs(canOpenBuildName) do
		if self._buildingObj:getBuildName() == v then
			canOpenFlag = true;
			break;
		end
	end

	if not canOpenFlag then
		floatText("功能暂未开放")
		return
	end

	ViewMgr:open(Panel.BUILDING_CREATE_ARMY,{
		scene=self._scene,
		buildingId=self._buildingObj:getBuildId(),
		buildName=self._buildingObj:getBuildName(),
		dataId=self._buildingObj:getDataId(),
		pos=self._buildingObj:getPos()
	})

	NotifyCenter:dispatchEvent({name=Notify.BUILDING_UNSELECT})
end

function BuildingPanel:init(townPanel)
	self._townPanel = townPanel
	ResMgr:loadPvr(BuildingPanel.UIResPath)
	self._priority = self._scene:getPriority()-1
	self.uiNode = UINode.new(self._priority-1)
	self.uiNode:setUI(BuildingPanel.LUA_PATH)
	self:addChild(self.uiNode)

	self.txtDelete = self.uiNode:getNodeByName("text_delete")
	self.btnDelete = self.uiNode:getNodeByName("btn_delete")
	self.btnDelete:addEventListener(Event.MOUSE_CLICK,{self,self._onDelete})
	self.btnDetail = self.uiNode:getNodeByName("btn_detail")
	self.btnDetail:addEventListener(Event.MOUSE_CLICK,{self,self._onDetail})
	self.btnLevelup = self.uiNode:getNodeByName("btn_levelup")
	self.btnLevelup:addEventListener(Event.MOUSE_CLICK,{self,self._onLevelup})
	self.btnFunction = self.uiNode:getNodeByName("btn_function")
	self.btnFunction:addEventListener(Event.MOUSE_CLICK,{self,self._onFunction})
end

function BuildingPanel:selectAt(buildingObj)
	self:setScale(1.5)
	local pp = buildingObj:getAnchorPoint()
	local x,y = buildingObj:getPosition()
	print("========selectAt========", pp.x, pp.y, x, y)
	local objSize = self:getContentSize()
	self:setPosition(cc.p(x+objSize.width*1.5/2,y+objSize.height*1.5/2))
	self:setAnchorPoint(cc.p(0.5,0.5))
	self._scene:addChild(self, 101)
	self._buildingObj = buildingObj;
	self._priority = self._buildingObj:getPriority()-1
	self.uiNode:setPriority(self._priority)

	self._buildingObj:selected()
	if not buildingObj:canDelete() then
		self.btnDelete:setEnable(false)
		self.btnDelete:setVisible(false)
		self.txtDelete:setVisible(false)
	else
		self.btnDelete:setEnable(true)
		self.btnDelete:setVisible(true)
		self.txtDelete:setVisible(true)
	end
end

function BuildingPanel:unSelect()
	self._buildingObj:unSelected()
	self._scene:removeChild(self, false)
end

function BuildingPanel:dispose()
	ResMgr:unload(BuildingPanel.UIResPath)
	self.btnDelete:removeEventListener(Event.MOUSE_CLICK,{self,self._onDelete})
	self.btnDetail:removeEventListener(Event.MOUSE_CLICK,{self,self._onDetail})
	self.btnLevelup:removeEventListener(Event.MOUSE_CLICK,{self,self._onLevelup})
	self.btnFunction:removeEventListener(Event.MOUSE_CLICK,{self,self._onFunction})

	self.uiNode:dispose()
	self:release()
end

return BuildingPanel
