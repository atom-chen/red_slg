-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:onRoleEnterScene
-- @description 角色进入场景
-- @param CRole:role 角色指针
-- @param Role:spRole 角色脚本对象
-- @return nil:
-- @usage 
function MapPlayerHandler:onRoleEnterScene(role, spRole)
	self.pRole = role;
	self.spRole = spRole;
	spRole:test();
	assert(self.spRole ~= nil);
end

-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:handleOpenDynamicMap
-- @description 开启动动态场景
-- @param CMOpenDynamicMap:pack 
-- @return boolean: 
-- @usage 
function MapPlayerHandler:handleOpenDynamicMap(pack)
	local retCode = EGameRetCode.RC_FAILED;
	if pack.mapID ~= 0 then
		retCode = self.pRole:openDynamicMap(pack.mapID);
	end
	
	local retPack = MCOpenDynamicMapRet.new();
	retPack.mapID = pack.mapID;
	retPack.retCode = retCode;
	self:sendPacket(retPack);
	
	return true;
end

-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:handleChangeMap
-- @description 切换地图
-- @param CMChangeMap:pack 
-- @return boolean: 
-- @usage 
function MapPlayerHandler:handleChangeMap(pack)
	local retPack = MCChangeMapRet.new();
	retPack.retCode = self.pRole:changeMap(pack.mapID, self.pRole:getAxisPos(),
		ETeleportType.TELEPORT_TYPE_TRANSMIT);
	retPack.mapID = pack.mapID;
	self:sendPacket(retPack);
	
	return true;
end
