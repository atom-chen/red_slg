-------------------------------------------------------
-- 作用: 得到向管理服务器注册的数据
-- 参数: 无
-- 返回: 注册数据
function GetWorldRegisteMsg()

	local cjson = require "cjson";
	local registePacket = {};
	config = luaGetWorldServerConfig();
	if IsNULL(config) then
		log:error("Cant get world server config!");
		return "";
	end

	registePacket.zoneID = config:getWorldServerID();			-- 区ID
	registePacket.id = config:getWorldServerID();				-- 服务器ID
	registePacket.type=EServerType.SERVER_TYPE_WORLD;			-- 服务器类型
	registePacket.recvType={};						-- 有服务器注册, 需要通知的服务器类型
	registePacket.recvZone={};						-- 可接哪些区的服务器
	registePacket.msg={};
	registePacket.msg.chargingListenIP = config:getBillListenIP();		-- 充值服务器监听IP
	registePacket.msg.chargingListenPort = config:getBillListenPort();	-- 充值服务器监听端口
	registePacket.msg.loginListenIP = config:getLoginServerIP();		-- 登陆服务器监听IP
	registePacket.msg.loginListenPort = config:getLoginServerPort();	-- 登陆服务器监听端口

	local result = cjson.encode(registePacket);
	return result;

end

-------------------------------------------------------
-- 作用: 其他游戏服务器向管理服务器注册
-- 参数: 其他服务器的注册数据
-- 返回: true或false
function OtherServerRegiste(handler, msg)
	local cjson = require "cjson";
	
	local serverData = cjson.decode(msg);
	if serverData.type == EServerType.SERVER_TYPE_LOGIN then
		-- 登陆服务器

		if not handler:connectToLoginServer(serverData.msg.worldListenIP, serverData.msg.worldListenPort) then
			log:error("Cant connect to login server!ServerID="..serverData.id);
			return false;
		end
		
		log:info("Connect to login server!ServerID="..serverData.id..",WorldListenIP="..serverData.msg.worldListenIP..",WorldListenPort="..serverData.msg.worldListenPort);
		return true;
	end
	
	return true;
end

-------------------------------------------------------
-- 作用: 玩家JSON数据解析
-- 参数: JSON数据
-- 返回: 参数Map
function ParsePlayerData(msg)
	local cjson = require "cjson";
	local playerData = cjson.decode(msg);
	return playerData;
end

-------------------------------------------------------
-- 作用: 停止服务器事件
-- 参数: 停止时间, 保存数据时间
-- 返回: true
function StopService(lastStopTime, saveTime)
	if lastStopTime == nil then
		lastStopTime = 15;
	end

	if saveTime == nil then
		saveTime = 8;
	end
	
	stopTimer = luaGetServer():getStopTimer();
	if not stopTimer:isStop() then
		log:info("Start stop service!");
		stopTimer:onStop(lastStopTime, saveTime);
	else
		log:error("Start stop service, has stop!");
	end

	return true;
end

-------------------------------------------------------
-- 作用: 停止服务器保存事件
-- 参数: 无
-- 返回: true
function StopServiceSave()
	log:info("Stop service save!");
	return true;
end