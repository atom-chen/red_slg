reloadRequire("LibHeader");
reloadRequire("ServerSocketHandler")

MainServer = {}

function MainServer:onBeforeStart()
	logInfo("Before start!!!");
	return true;
end

function MainServer:onAcceptSocket(socket, socketHandler, packetHandler, tag)
    logInfo("Socket accept!!!Tag={0}", tag);
    socketHandler:setScriptHandleClassName("NewServerSocketHandler");
    return true;
end

function MainServer:onAfterStart()

    if not self.mServer:openClientListener("127.0.0.1", 7324, 1) then
		logError("Open client listener failed!!!IP={0},Port={1}", "127.0.0.1", 7324);
		return false;
    else
		logInfo("Open client listener success!!!IP={0},Port={1}", "127.0.0.1", 7324);
    end

    return true;
end

function NewMainServer(ptrServer)
    MainServer.mServer = ptrServer;

    return MainServer;
end