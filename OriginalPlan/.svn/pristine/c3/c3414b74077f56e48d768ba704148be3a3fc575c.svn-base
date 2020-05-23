local BuildingInfo = game_require("model.town.BuildingInfo")

local BuildingModel = class("BuildingModel")

function BuildingModel:ctor()
	--! BuildingInfo
	self.buildingList = {}
end

function BuildingModel:init()

end

function BuildingModel:getPopulation()
	return 10
end

function BuildingModel:getBuildingLevel(id)
	local buildInfo = self.buildingList[id]
	if buildInfo ~= nil then
		return buildInfo.level;
	end

	return 1;
end

function BuildingModel:getStatusTimeRest(buildId)
	local buildInfo = self.buildingList[buildId]
	if buildInfo == nil then
		return 0
	end

	if buildInfo.statusEndTime <= 0 or buildInfo.statusEndTime < os.time() then
		return 0
	end

	return buildInfo.statusEndTime-os.time()
end

function BuildingModel:isStatusRun(id)
	local buildInfo = self.buildingList[id]
	if buildInfo ~= nil then
		if buildInfo.status == BuildingInfo.Status.NONE then
			return false
		end
		if buildInfo.statusEndTime ~= 0 and buildInfo.statusEndTime < os.time() then
			return false
		end

		return true
	end

	return false;
end

function BuildingModel:getProcessRate(buildId)
	local levelUpConf = BuildingCfg:getLevelUp()
	local maxTime = levelUpConf[TownModel:getBuildModel():getBuildingLevel(buildId)].need_time
	if self:isStatusRun(buildId) then
		local diff = self:getStatusTimeRest(buildId)
		return (maxTime-diff)*100/maxTime
	end

	return 100
end

function BuildingModel:genBuildingId()
	local maxId = 0
	for k,v in pairs(self.buildingList) do
		if maxId < k then
			maxId = k
		end
	end

	return maxId+1
end

-------------------------------------------------------
-- @class
-- @name
-- @param BuildingInfo:buildInfo
-- @description
-- @return nil:
-- @usage
function BuildingModel:addBuilding(buildInfo)
	local buildingId = self:genBuildingId()
	buildInfo.id = buildingId
	self.buildingList[buildInfo.id] = buildInfo;
	return buildingId
end

-------------------------------------------------------
-- @class
-- @name
-- @description
-- @param nil:buildId 建筑ID
-- @return nil:
-- @usage
function BuildingModel:delBuilding(buildId)
	self.buildingList[buildId] = nil
end
function BuildingModel:fastFinish(id)
	local buildInfo = self.buildingList[id]
	if buildInfo ~= nil then
		buildInfo.statusEndTime = os.time();
	end
end
function BuildingModel:accelerate(id, decTime)
	local buildInfo = self.buildingList[id]
	if buildInfo ~= nil then
		buildInfo.statusEndTime = buildInfo.statusEndTime-decTime;
	end
end
function BuildingModel:setBuildingStatus(id, status, lastTime)
	local buildInfo = self.buildingList[id]
	if buildInfo ~= nil then
		buildInfo.status = status
		if status ~= BuildingInfo.Status.NONE then
			buildInfo.statusEndTime = os.time()+lastTime
		else
			buildInfo.statusEndTime = 0
		end
	end
end

function BuildingModel:getBuildingStatus(buildId)
	local buildInfo = self.buildingList[buildId]
	if buildInfo ~= nil then
		return buildInfo.status;
	end

	return nil
end

function BuildingModel:getBuilding(buildId)
	return self.buildingList[buildId];
end

-------------------------------------------------------
-- @class
-- @name
-- @description
-- @return nil:
-- @usage
function BuildingModel:levelUp(id)
	local buildInfo = self.buildingList[id]
	if nil ~= buildInfo then
		buildInfo.level = buildInfo.level+1;
	end
end

return BuildingModel