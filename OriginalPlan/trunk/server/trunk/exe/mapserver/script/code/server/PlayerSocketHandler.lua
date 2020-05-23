reloadRequire("LibHeader");

-------------------------------------------------------
-- @class class
-- @name MapPlayerHandler
-- @description 地图服务器对应的Socket处理对象
-- @usage
MapPlayerHandler = Class("MapPlayerHandler")
MapPlayerHandler.Protocls = {}

-------------------------------------------------------
-- @class function
-- @name NewMapPlayerHandler
-- @description 生成一个新的处理对象
-- @param nil:ptr
-- @return
-- @usage
function NewMapPlayerHandler(ptr)
    return MapPlayerHandler.new(ptr);
end

-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:ctor
-- @description 构造函数
-- @param MapPlayerHandler:ptrHandler 地图服务器处理对象指针
-- @return
-- @usage
function MapPlayerHandler:ctor(ptrHandler)
	--! MapPlayerHandler
	self.ptrSelf = ptrHandler;
	--! CRole
	self.pRole = nil;
	--! Role
	self.spRole = nil;
end

-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:start
-- @description 启动事件
-- @param nil:socketIndex Socket索引
-- @return bool
-- @usage
function MapPlayerHandler:start(socketIndex)
    logInfo("Socket start!!!SocketIndex={0}", socketIndex);
    self.socketIndex = socketIndex;

    return true;
end

-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:handle
-- @description 消息接收处理
-- @param CMemInputStream:stream 消息流
-- @return bool
-- @usage
function MapPlayerHandler:handle(stream)
	--assert(self.pRole ~= nil);

	local totalLen = stream:readUInt16();
	local flag = stream:readUInt8();
	local packId = stream:readUInt16();
	--logInfo("Recv packet!!!PackId={0},Flag={1},TotalLen={2}", packId, flag, totalLen);

	local func = self.Protocls[packId];
	if nil == func then
		logError("Cant find packet handler function!!!PackID={0}", packId);
		return false;
	end

	local protocolName = _G.Protocol[packId];
	--logDebug("ProtocolName={0}", protocolName);
	if nil == protocolName then
		logError("Cant find protocal name!!!PackID={0}", packId);
		return false;
	end

	local packetObject = _G[protocolName].new();
	packetObject:Read(stream);
	func(self, packetObject);

	return true;
end

-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:sendPacket
-- @description 发送消息
-- @param nil:pack 消息对象
-- @return
-- @usage
function MapPlayerHandler:sendPacket(pack, unRetCode)
	--logInfo("Send packet!!!PackName={0}", pack.__cname);

	local stream = self.ptrSelf:getBufferStream();
	local pos = stream:getCurrentPos();
	if unRetCode then
		SerialPacketHeader(stream, pack.PackID, 0);
	else
		SerialResPacketHeader(stream, pack.PackID, 0, pack.retCode);
	end
	pack:Write(stream);
	SerialPacketHeaderLen(stream, stream:getCurrentPos()-pos, pos);
end

-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:close
-- @description 关闭事件
-- @return
-- @usage
function MapPlayerHandler:close()
	logInfo("Socket close!!!SocketIndex={0}", self.socketIndex);
end

-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:RegisterAllHandle
-- @description 注册所有的协议处理函数
-- @return
-- @usage
function MapPlayerHandler.RegisterAllHandle()
	--[[
		MapPlayerHandler.Protocls[CMFightOpenChapter.PackID] = MapPlayerHandler.handleFightChapter;
		MapPlayerHandler.Protocls[CMFightFinish.PackID] = MapPlayerHandler.handleFightFinish;
		MapPlayerHandler.Protocls[CMBagOperate.PackID] = MapPlayerHandler.handleBagOperate;
		MapPlayerHandler.Protocls[CMBagExtend.PackID] = MapPlayerHandler.handleBagBuyGrid;
		MapPlayerHandler.Protocls[CMOpenDynamicMap.PackID] = MapPlayerHandler.handleOpenDynamicMap;
		MapPlayerHandler.Protocls[CMChangeMap.PackID] = MapPlayerHandler.handleChangeMap;
		MapPlayerHandler.Protocls[CMEnterGame.PackID] = MapPlayerHandler.handleEnterGame; -- Cpp
		MapPlayerHandler.Protocls[CMUserLogin.PackID] = MapPlayerHandler.handleUserLogin; -- Cpp
	--]]
end
