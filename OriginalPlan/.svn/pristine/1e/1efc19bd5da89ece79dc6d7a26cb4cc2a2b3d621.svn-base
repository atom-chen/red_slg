reloadRequire("Class");
reloadRequire("Log");

-------------------------------------------------------
-- @class class
-- @name MapServer
-- @description 地图服务器
-- @usage
MapServer = Class("MapServer");

-- 服务器对象
MainServer = nil

-------------------------------------------------------
-- @class function
-- @name NewMainServer
-- @description 创建新的服务器对象
-- @param CMapServer|ptrServer 服务器对象指针
-- @return MainServer|服务器对象
-- @usage
function NewMainServer(ptrServer)
    MainServer = MapServer.new(ptrServer);
    return MainServer;
end

-------------------------------------------------------
-- @class function
-- @name MapServer:ctor
-- @description 构造函数
-- @param CMapServer:ptrServer 服务器对象指针
-- @return
-- @usage
function MapServer:ctor(ptrServer)
	math.randomseed(os.time()%100000000);
	self.ptrSelf = tolua.cast(ptrServer, "CMapServer");
	--logDebug("Mapserver pointer!!!{0},{1}", self.ptrSelf, ptrServer);


	self.lastMinuteEventSecond = 0;
	self.lastUpdateMin = os.time()
end

-------------------------------------------------------
-- @class function
-- @name MapServer:onBeforeStart
-- @description 启动前事件
-- @return bool:是否成功
-- @usage
function MapServer:onBeforeStart()
	logInfo("on before start!!!");

	self:test();

	return true;
end

-------------------------------------------------------
-- @class function
-- @name MapServer:test
-- @description 启动测试
-- @usage
function MapServer:test()

end

-------------------------------------------------------
-- @class function
-- @name MapServer:onAcceptSocket
-- @description 接收到Socket事件
-- @param CSocket:socket socket对象
-- @param CSocketHandler:socketHandler 消息处理对象
-- @param ISocketPacketHandler:packetHandler 包处理对象
-- @param nil:tag 网络对象标记ID
-- @return boolean:是否处理成功
-- @usage
function MapServer:onAcceptSocket(socket, socketHandler, packetHandler, tag)
	logInfo("Socket accept!!!Tag={0}", tag);
	if tag == 1 then
		socketHandler:setScriptHandleClassName("NewMapPlayerHandler");
	end

	return true;
end

-------------------------------------------------------
-- @class function
-- @name MapServer:onTimer
-- @description 定时器
-- @param nil:sec 当前秒数
-- @usage
function MapServer:onTimer(sec)
	if os.time()-self.lastUpdateMin >= 60 then
		self:onInMinute();
		self.lastUpdateMin = os.time();
	end
end

-------------------------------------------------------
-- @class function
-- @name MapServer:onInMinute
-- @description 一分钟定时器
-- @usage
function MapServer:onInMinute()

end

-------------------------------------------------------
-- @class function
-- @name MapServer:onInMinute
-- @description 一小时定时器
-- @usage
function MapServer:onInHour()

end
