local BuildingInfo = class("BuildingInfo")

BuildingInfo.Status = {
	NONE = 1,
	CREATE = 2,
	LEVELUP = 3,
}

function BuildingInfo:ctor()
	-- 数据唯一ID
	self.id = 0
	-- 建筑配置ID
	self.buildingId = 0
	-- 分组ID, 主要用于城墙
	self.groupId = 0
	-- 等级
	self.level = 0
	-- 坐标X
	self.x = 0
	-- 坐标Y
	self.y = 0
	-- 建筑状态
	self.status = BuildingInfo.Status.NONE
	-- 状态结束时间
	self.statusEndTime = 0
end

function BuildingInfo:setStatus(v)
	self.status = v
end

function BuildingInfo:getStatus()
	return self.status
end

function BuildingInfo:setStausEndTime(t)
	self.statusEndTime = t
end

function BuildingInfo:getStatusEndTime()
	return self.statusEndTime
end

function BuildingInfo:getId()
	return self.id;
end

function BuildingInfo:setId(value)
	self.id = value;
end

function BuildingInfo:getGroupId()
	return self.groupId;
end

function BuildingInfo:setGroupId(value)
	self.groupId = value;
end

function BuildingInfo:getLevel()
	return self.level;
end

function BuildingInfo:setLevel(value)
	self.level = value;
end

function BuildingInfo:getX()
	return self.x;
end

function BuildingInfo:setX(value)
	self.x = value;
end

function BuildingInfo:getY()
	return self.y;
end

function BuildingInfo:setY(value)
	self.y = value;
end

return BuildingInfo
