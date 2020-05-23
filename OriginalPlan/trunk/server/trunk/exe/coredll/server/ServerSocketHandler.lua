reloadRequire("LibHeader");
reloadRequire("ProtocolBase");
reloadRequire("ProtocolSerial");

ServerSocketHandler = Class("ServerSocketHandler")

function NewServerSocketHandler(ptr)
    return ServerSocketHandler.new(ptr);
end

function ServerSocketHandler:ctor(ptrServer)
    self.ptrSelf = ptrServer;
end

function ServerSocketHandler:start(socketIndex)
    logInfo("Socket start!!!SocketIndex={0}", socketIndex);
    self.socketIndex = socketIndex;

    return true;
end

function ServerSocketHandler:handle(stream)

    local _ = stream:readUInt16();	-- 总长度
    local _ = stream:readUInt8();	-- 标记位
    local packId = stream:readUInt16();	-- 协议ID
	
	logDebug("Receive packet!!!PacketID={0}", packId);

    if packId == 100 then
        local pack = CMVarideTest.new();
        pack:Read(stream)

		local retPack = MCVarideTestRet.new();
		retPack.retCode = 0;
		retPack.testFlag = 1;
		retPack.testNumber = 123;
		self:sendPacket(retPack);
	elseif packId == 36 then
		local pack = CMUserPlayerInfo.new();
        pack:Read(stream)
		logDebug("request player id: {0}", pack.objUID);

		----[[
		local retPack = MCUserPlayerInfoRet.new();
		retPack.retCode = 1;
		retPack.errorMsgFlag = 1
		retPack.errorMsg = "";
		retPack.playerDataFlag = 1;
		retPack.charms = 10;
		retPack.constellationFlag = 1;
		retPack.constellation = "处女座";
		retPack.dataId = pack.objUID;
		retPack.golds = 100000;
		retPack.jewels = 3929;
		retPack.level = 5;
		retPack.locationFlag = 1;
		retPack.location = "天河区上社";
		retPack.mobileNumFlag = 1;
		retPack.mobileNum = "13822222222";
		retPack.nickNameFlag = 1;
		retPack.nickName = "测试玩家";
		retPack.selfIconUrlFlag = 1;
		retPack.selfIconUrl = ""
		retPack.signatureFlag = 1;
		retPack.signature = "测试用的";
		retPack.systemIcon = 3;
		retPack.titleFlag = 1;
		retPack.title = "船长";
		retPack.male = 1;
		retPack.online = 1;
		retPack.vipLevel = 7;
		retPack.giftsFlag = 1;
		retPack.gifts = {}
		local gift = Gift.new();
		gift.existFlag = 1;
		gift.count = 10;
		gift.giftId = 1;
		gift.iconFlag = 1;
		gift.icon = "";
		table.insert(retPack.gifts, gift);
		
		gift = Gift.new();
		gift.existFlag = 1;
		gift.count = 210;
		gift.giftId = 2;
		gift.iconFlag = 1;
		gift.icon = "";
		table.insert(retPack.gifts, gift);

		gift = Gift.new();
		gift.existFlag = 1;
		gift.count = 130;
		gift.giftId = 3;
		gift.iconFlag = 1;
		gift.icon = "";
		table.insert(retPack.gifts, gift);

		gift = Gift.new();
		gift.existFlag = 1;
		gift.count = 110;
		gift.giftId = 4;
		gift.iconFlag = 1;
		gift.icon = "";
		table.insert(retPack.gifts, gift);

		gift = Gift.new();
		gift.existFlag = 1;
		gift.count = 100;
		gift.giftId = 5;
		gift.iconFlag = 1;
		gift.icon = "";
		table.insert(retPack.gifts, gift);

		self:sendPacket(retPack);
		--]]
	elseif packId == 22 then
		local pack = CMSendGift.new();
		pack:Read(stream)

		local retPack = MCSendGiftRet.new();
		retPack.retCode = 1;
		retPack.errorFlag = 1;
		retPack.errorMsg = "发送礼物";
		self:sendPacket(retPack);

		local eventPack = MCSendGiftEvent.new();
		eventPack.fromPos = 1;
		eventPack.giftID = pack.giftID;
		eventPack.num = pack.num;
		eventPack.toPos = 2;
		self:sendPacket(eventPack);
    end

    return true;
end

function ServerSocketHandler:sendPacket(pack)
    logInfo("Send packet!!!PackName={0}", pack.__cname);
    
    local stream = self.ptrSelf:getBufferStream();
    local pos = stream:getCurrentPos();
    SerialPacketHeader(stream, pack.PackID, 0, pack.retCode);
    pack:Write(stream);
    SerialPacketHeaderLen(stream, stream:getCurrentPos()-pos, pos);
end

function ServerSocketHandler:close()
    logInfo("Socket close!!!SocketIndex={0}", self.socketIndex);
end
