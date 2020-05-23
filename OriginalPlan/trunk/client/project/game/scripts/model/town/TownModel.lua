local TownModel = class("TownModel")
local BuildingModel = game_require("model.town.BuildingModel")

function TownModel:ctor()
	--! BuildingModel
	self.buildingModel = nil
end

function TownModel:init()
	self.buildingModel = BuildingModel.new()
end

-------------------------------------------------------
-- @class
-- @name
-- @description
-- @return BuildingModel:
-- @usage
function TownModel:getBuildModel()
	return self.buildingModel;
end

return TownModel
