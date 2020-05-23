--
-- Author: lyc
-- Date: 2016-05-26 14:51:00
--

local BuildingCreate = class('BuildingCreate', function()
	return display.newNode()
end)

function BuildingCreate:ctor(scene, townPanel)
	self._scene = scene
	self._townPanel = townPanel
	self:retain()
end

function BuildingCreate:init(townPanel)
	self._townPanel = townPanel
end

-------------------------------------------------------
-- @class
-- @name
-- @description
-- @param buildingObj:BuildingNode
-- @return nil:
-- @usage
function BuildingCreate:selectAt(buildingObj)
	ViewMgr:open(Panel.BUILDING_CREATE,
		{
			scene=self._scene,
			buildingName=buildingObj:getBuildNameExt(),
			nodePos = buildingObj:getCreateNodePos(),
			pos= buildingObj:getPos()
		}
	)
end

function BuildingCreate:unSelect()
	ViewMgr:close(Panel.BUILDING_CREATE)
end

function BuildingCreate:needCloseAfterSelect()
	return true;
end

function BuildingCreate:dispose()
	self:release()
end

return BuildingCreate
