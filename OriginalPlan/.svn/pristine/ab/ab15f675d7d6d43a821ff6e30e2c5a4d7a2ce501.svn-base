reloadRequire("LibHeader");
reloadRequire("ProtocolBase");
reloadRequire("ProtocolSerial");
reloadRequire("EnumDefines");

PlayerSocketHandler = Class("PlayerSocketHandler")
PlayerSocketHandler.Protocols = {}

function NewPlayerSocketHandler(ptrSelf)
    return PlayerSocketHandler.new(ptrSelf);
end

--! PlayerSocketHandler
ClientPlayer = nil;
function PlayerSocketHandler:ctor(_ptrSelf)
    self.ptrSelf = _ptrSelf;
		ClientPlayer = self;
end

function PlayerSocketHandler:sendLocalLoginGame()
  local pack = CMLocalLoginGame.new();

  if #arg > 0 then
		pack.roleUID = arg[1];
  else
		pack.roleUID = 1;
  end

  self:sendPacket(pack);
end

function PlayerSocketHandler:sendEnterGame(roleUID)
  local pack = CMEnterGame.new();

  pack.roleUID = roleUID;

  self:sendPacket(pack);
end

function PlayerSocketHandler:sendMove()
    local pack = CMMove.new();
		pack.moveType = ERoleMoveType.ROLE_MOVE_TYPE_MOVE;
    local pos = AxisPos.new();
    pos.x = 12;
    pos.y = 32;
    table.insert(pack.posList, pos);
    pos = AxisPos.new();
    pos.x = 33;
    pos.y = 21;
    table.insert(pack.posList, pos);
    pos = AxisPos.new();
    pos.x = 55;
    pos.y = 43;
    table.insert(pack.posList, pos);

    self:sendPacket(pack);
end

function PlayerSocketHandler:handle(stream)
    local _ = stream:readUInt16();		-- 总长度
    local _ = stream:readUInt8();	-- 标记位
    local packId = stream:readUInt16();
    local retCode = stream:readUInt16();

    if packId ~= MCPlayerHeart.PackID then
		--	logInfo("Recv packet!!!PackId={0},{1},retCode={2}", packId, MCLocalLoginGameRet.PackID, retCode);
    end
    if packId == MCLocalLoginGameRet.PackID then
        local localLoginRet = MCLocalLoginGameRet.new();
        localLoginRet:Read(stream);
        if retCode == 0 then
            logInfo("Role local login game success!!!RoleUID={0}", localLoginRet.roleUID);
            self:sendEnterGame(localLoginRet.roleUID);
        else
            logError("Role local login game failed!!!RoleUID={0},ErrorCode={1}", localLoginRet.roleUID, retCode);
        end
    elseif packId == MCEnterGameRet.PackID then
        local enterGameRet = MCEnterGameRet.new();
        enterGameRet:Read(stream);
        if retCode == 0 then
            logInfo("Role enter game success!!!RoleUID={0}", enterGameRet.detailData.roleUID);
            self:sendEnterScene();
						self.enterSceneType = ESceneType.SCENE_TYPE_NORMAL;
						AddLogString("角色开始进入场景: "..tostring(enterGameRet.detailData.roleUID));
						--AddLogString("角色登陆成功:"..enterGameRet.detailData.roleUID);
        else
            logError("Role enter game failed!!!RoleUID={0},ErrorCode={1}", enterGameRet.detailData.roleUID, retCode);
        end
    elseif packId == MCEnterSceneRet.PackID then
        local enterSceneRet = MCEnterSceneRet.new();
        enterSceneRet:Read(stream);
        if retCode == 0 then
            logInfo("Role enter scene success!!!");
            self:sendMove();
						AddLogString("角色进入场景成功");
        else
            logError("Role enter scene failed!!!ErrorCode={1}", retCode);
        end
    elseif packId == MCMoveBroad.PackID then
        local moveBroad = MCMoveBroad.new();
        moveBroad:Read(stream);
        logInfo("Role move!!!ObjectUID={0}", moveBroad.objUID);
    elseif packId == MCEnterView.PackID then
        local enterView = MCEnterView.new();
        enterView:Read(stream);
        for _,v in pairs(enterView.roleList) do
          logInfo("========Role enter view========!!!ObjectUID={0}", v.objUID);
					printObject(v);
        end
    elseif packId == MCLeaveView.PackID then
        local leaveView = MCLeaveView.new();
        leaveView:Read(stream);
        for _,v in pairs(leaveView.objAry) do
            logInfo("Role leave view!!!ObjectUID={0}", v);
        end
		else
			local pfunc = PlayerSocketHandler.Protocols[packId];
			local packName = _G.Protocol[packId];
			local packObj = _G[packName];
			if packId == MCUpdateItems.PackID then
				logDebug("HandleFunc={0},PackName={1},PackObject={2}", pfunc, packName, packObj);
			end
			if nil ~= pfunc and packName and packObj then
				local pack = packObj.new();
				pack:Read(stream)
				pfunc(self, pack);
			end
    end

    return true;
end

function PlayerSocketHandler:start(socketIndex)
    
    logInfo("Socket start!!!SocketIndex={0}", socketIndex);
    self.socketIndex = socketIndex;
    self:sendLocalLoginGame();

    return true;
end

function PlayerSocketHandler:sendPacket(pack)
    logInfo("Send packet!!!PackName={0}", pack.__cname);
    
    local stream = self.ptrSelf:getBufferStream();
    local pos = stream:getCurrentPos();
    SerialPacketHeader(stream, pack.PackID, 0);
    pack:Write(stream);
    SerialPacketHeaderLen(stream, stream:getCurrentPos()-pos, pos);
end

function PlayerSocketHandler:close()
    logInfo("Socket close!!!SocketIndex={0}", self.socketIndex);
end