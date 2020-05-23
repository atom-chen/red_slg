reloadRequire("Class");
reloadRequire("Log");
reloadRequire("String");
reloadRequire("Util");
reloadRequire("Table");

-------------------------------------------------------
-- 作用: http脚本重新加载
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:9080/gm?type=func&name=httpScriptReload
function httpScriptReload(args)
	print("reload script!");

	local name = "CodeHeader";
	log:info("reload " .. name .. " file");
	allReloadRequireName = {};
	package.loaded[name] = nil;
	require(name);
	return "加载脚本成功";
end

-------------------------------------------------------
-- 作用: 停止游戏服务器
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:9080/gm?type=func&name=httpStopService&stopTime=50&saveTime=30
-- 连接参数: roleUID
function httpStopService(args)
	local stopTime = tonumber(args["stopTime"]);
	local saveTime = tonumber(args["saveTime"]);
	
	if stopTime < 0 or stopTime == 0 then
		stopTime = 50;
	end
	
	if saveTime < 0 or saveTime == 0 then
		saveTime = math.fmod(stopTime/2);
	end

	StopService(stopTime, saveTime);

	return "开始关闭游戏服务器!!!";
end

-------------------------------------------------------
-- 作用: 发送公告
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:9080/gm?type=func&name=httpAnnouncement&msg=xxx&internal=5&lastTime=50
-- 连接参数: roleUID
function httpAnnouncement(args)
	local stopTime = tonumber(args["msg"]);
	local saveTime = tonumber(args["internal"]);
	
	if stopTime < 0 or stopTime == 0 then
		stopTime = 50;
	end
	
	if saveTime < 0 or saveTime == 0 then
		saveTime = math.fmod(stopTime/2);
	end

	StopService(stopTime, saveTime);

	return "开始关闭游戏服务器!!!";
end

-------------------------------------------------------
-- 作用: 发送所有玩家后台奖励绑定元宝
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:9080/gm?type=func&name=httpAllAwardBindRmb&rmb=xxx&gameMoney=xxx
-- 连接参数: roleUID
function httpAllAwardBindRmb(args)
	local bindRmb = tonumber(args["rmb"]);
	local gameMoney = tonumber(args["gameMoney"]);
	luaAwardBindRmb(bindRmb, gameMoney, "");

	return "发送所有玩家: "..bindRmb.." 钻石"..","..gameMoney.." 游戏币";
end

-------------------------------------------------------
-- 作用: 发送玩家后台奖励绑定元宝
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:9080/gm?type=func&name=httpAwardBindRmb&rmb=xxx&gameMoney=xxx&roleUID=0
-- 连接参数: roleUID
function httpAwardBindRmb(args)
	local bindRmb = tonumber(args["rmb"]);
	local gameMoney = tonumber(args["gameMoney"]);
	local roleUID = args["roleUID"];
	luaAwardBindRmb(bindRmb, gameMoney, roleUID);

	return "发送玩家: "..bindRmb.." 钻石"..","..gameMoney.." 游戏币"..",玩家RoleUID="..roleUID;
end