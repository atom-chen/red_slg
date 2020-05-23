local BuildingNode = game_require('view.town.building.BuildingNode')
local NotifyCenter = game_require('launch.NotifyCenter')
local BuildingGroup = class("BuildingGroup", BuildingNode)

function BuildingGroup:ctor(town, enterNum, priority)
	BuildingNode.ctor(self, town, enterNum, priority)

	self.buildName = nil
	--! TownPanel
	self.town = nil
end

function BuildingGroup:init(town)
	NotifyCenter:addEventListener(Notify.BUILDINGGROUP_CLICK,{self, self.onChildClick})
	self.town = town;
	self.town:retain()
end

function BuildingGroup:isGroup()
	return true;
end

function BuildingGroup:dispose()
	NotifyCenter:removeEventListener(Notify.BUILDINGGROUP_CLICK,{self, self.onChildClick})
	self.town:release()
end

function BuildingGroup:setBuildName(value)
	self.buildName = value;
end

function BuildingGroup:getBuildName()
	return self.buildName;
end

function BuildingGroup:onChildClick(event)
	if event.groupId == self:getGroupId() then
		local buildings = self.town:getBuildingByGroupId(event.groupId)

		for _,node in ipairs(buildings) do
			if node:getGroupId() == event.groupId and not node:isGroup() then
				if node ~= nil then
					ViewMgr:touchCover(0.19)
					UIAction.shrinkRecover(node, nil, nil, 1.2)
				end
			end
		end
	end
end

return BuildingGroup
