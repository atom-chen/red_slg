-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:sendEnterScene
-- @description 发送进入场景消息
-- @return nil: 
-- @usage 
function PlayerSocketHandler:sendEnterScene()
    local pack = CMEnterScene.new();

    self:sendPacket(pack);
end

-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:sendChangeMap
-- @description 发送切换地图消息
-- @return nil: 
-- @usage 
function PlayerSocketHandler:sendChangeMap()
	local pack = CMChangeMap.new();
	pack.mapID = "10001";
	
	self:sendPacket(pack);
end

-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:sendOpenDynamicMap
-- @description 发送开启动态场景消息
-- @return nil: 
-- @usage 
function PlayerSocketHandler:sendOpenDynamicMap()
	local pack = CMOpenDynamicMap.new();
	pack.mapID = 1001;
	self:sendPacket(pack);
end

-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:handleEnterScene
-- @description 处理进入场景协议
-- @param MCEnterScene:pack 
-- @return boolean: 
-- @usage 
function PlayerSocketHandler:handleEnterScene(pack)
	self:sendEnterScene();
	self.enterSceneType = pack.mapType;
	AddLogString("角色开始进入场景: type="..self.enterSceneType);
end

PlayerSocketHandler.Protocols[MCEnterScene.PackID] = PlayerSocketHandler.handleEnterScene;