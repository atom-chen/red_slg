reloadRequire("LibHeader");
reloadRequire("PlayerSocketHandler")
reloadRequire("PlayerBag");
reloadRequire("PlayerScene");

MainServer = {}

function MainServer:onBeforeStart()
	print("on before start!!!");
	return true;
end

function MainServer:onAfterStart()
    --if not self.mServer:openClientConnector("192.168.10.201", 7110, 50000, 1, true) then
    if not self.mServer:openClientConnector("127.0.0.1", 7110, 50000, 1, true) then
			logError("Can't open client connect!!!IP={0},Port={1}", "127.0.0.1", 7324);
			return false;
    end

    return true;
end

function MainServer:onConnectSocket(socket, socketHandler, packetHandler, tag)
    logInfo("Socket connect!!!Tag={0}", tag);
    socketHandler:setScriptHandleClassName("NewPlayerSocketHandler");
    return true;
end

function NewMainServer(ptrServer)
    MainServer.mServer = ptrServer;

    return MainServer;
end