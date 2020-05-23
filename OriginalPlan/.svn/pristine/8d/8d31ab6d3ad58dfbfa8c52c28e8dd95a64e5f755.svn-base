local BuildingCfg = {}

function BuildingCfg:init()
  	self._buildCreateCfg = ConfigMgr:requestConfig("building_create", nil, true)
	self._buildInfoCfg = ConfigMgr:requestConfig("building_info", nil, true)
	self._buildAccelerate = ConfigMgr:requestConfig("building_accelerate_item", nil, true)
	self._buildLevelUp = ConfigMgr:requestConfig("building_levelup", nil, true)

	self._maxBuildLevel = 0
	for k,v in pairs(self._buildLevelUp) do
		self._maxBuildLevel = self._maxBuildLevel+1
	end
end

function BuildingCfg:getBuildingCreate(id)
	return self._buildCreateCfg[id];
end

function BuildingCfg:getCanCreateList(id)
	return self._buildCreateCfg[id].can_list
end

function BuildingCfg:getCanCreateListByName(name)
	for _,v in pairs(self._buildCreateCfg) do
		if v.name == name then
			return v.can_list
		end
	end

	return nil
end

function BuildingCfg:getBuildingInfo(id)
	return self._buildInfoCfg[id]
end

function BuildingCfg:getAccelerate()
	return self._buildAccelerate
end

function BuildingCfg:getLevelUp()
	return self._buildLevelUp
end

function BuildingCfg:getMaxBuildLevel()
	return self._maxBuildLevel
end

return BuildingCfg
