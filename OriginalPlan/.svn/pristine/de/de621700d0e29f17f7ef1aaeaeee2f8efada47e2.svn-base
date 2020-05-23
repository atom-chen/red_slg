local BuildingUIController = class('BuildingUIController')

BuildingUIController.BuildMenus = {
	['Base'] = {
		entry = 'view.town.building.BuildingPanel'
	},
	['Create'] = {
		entry = 'view.town.building.BuildingCreate'
	},
	['Status'] = {
		entry = 'view.town.building.BuildingStatusSelect'
	}
}

function BuildingUIController:ctor(scene, townPanel)
	self._scene = scene
	self._townPanel = townPanel
	self._buildingEntrys = {}
	for k,v in pairs(BuildingUIController.BuildMenus) do
		local elem = {}
		elem.controller = game_require(v.entry).new(scene, self._townPanel)
		elem.controller:init(self._townPanel);
		elem.buildName = k;
		self._buildingEntrys[k] = elem
	end

	NotifyCenter:addEventListener(Notify.BUILDING_SELECT, {self, self._buildingSelect})
	NotifyCenter:addEventListener(Notify.BUILDING_UNSELECT, {self, self._buildingUnselect})
end

function BuildingUIController:_buildingSelect(event)
	if self:hasSelect() then
		self:unSelect()
		return
	end

	self:selectAt(event.buildType, event.buildingObj)
end

function BuildingUIController:_buildingUnselect(event)
	self:unSelect()
end

function BuildingUIController:selectAt(buildName, buildingObj)
	self._buildSelector = self._buildingEntrys[buildName]
	if self._buildSelector then
		self._buildSelector.controller:selectAt(buildingObj)
	end
--	if self._buildSelector.controller.needCloseAfterSelect and
--		self._buildSelector.controller:needCloseAfterSelect() then
--		self._buildSelector = nil
--	end
end

function BuildingUIController:unSelect()
	if self._buildSelector then
		self._buildSelector.controller:unSelect()
		self._buildSelector = nil
	end
end

function BuildingUIController:hasSelect()
	return self._buildSelector ~= nil;
end

function BuildingUIController:dispose()
	for k,v in pairs(self._buildingEntrys) do
		v.controller:dispose()
	end

	NotifyCenter:removeEventListener(Notify.BUILDING_SELECT, {self, self._buildingSelect})
	NotifyCenter:removeEventListener(Notify.BUILDING_UNSELECT, {self, self._buildingUnselect})

	self._scene = nil
end

return BuildingUIController
