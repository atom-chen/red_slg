reloadRequire("Class");
reloadRequire("Log");
reloadRequire("String");
reloadRequire("Util");
reloadRequire("Table");

-------------------------------------------------------
-- 作用: http脚本重新加载
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:9710/gm?type=func&name=httpScriptReload
function httpScriptReload(args)
	log:info("reload script!");

	local name = "CodeHeader";
	log:info("reload " .. name .. " file");
	allReloadRequireName = {};
	package.loaded[name] = nil;
	require(name);
	return "reload script success!";
end

-------------------------------------------------------
-- 作用: http测试函数
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:7170/gm?type=func&name=httpTest
function httpTest(args)
	local dateString = os.date();
	--genBody = "<head><meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"/></head>";
	genBody = "<body>当前时间 -- ";
	genBody = genBody .. dateString;
	genBody = genBody .. "</br>终于测试成功</body>";
	return genBody;
end

-------------------------------------------------------
-- 作用: http测试函数
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:7170/gm?type=func&name=httpTest2
function httpTest2(args)
	local dateString = os.date();
	--genBody = "<head><meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"/></head>";
	genBody = "<body>当前时间 -- ";
	genBody = genBody .. dateString;
	genBody = genBody .. "</br>终于测试成功</body>";
	return genBody, true;
end

-------------------------------------------------------
-- 作用: http读取脚本文件内容并执行代码
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:7170/gm?type=func&name=httpTest3&fileName=xxx
function httpTest3(args)
	local fileName = args["fileName"]
	local file = io.open(fileName, "rb")
	if nil == file then
		return "无法打开文件: "..fileName, true
	end

	local bytes = file:read("*a")
	if bytes == nil then
		io.close(file)
		return "无法读取文件内容: "..fileName, true
	end

	local fun = load(bytes, fileName, "b")
	if nil ~= fun then
		fun()	
	end

	return "测试脚本执行成功", true
end

-------------------------------------------------------
-- 作用: 生成兑换码
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:7170/gm?type=func&name=httpRedeemGen&channel=xxxx&cdType=x&num=xxxx
function httpRedeemGen(args)
	local channel = args["channel"];
	local cdType = tonumber(args["cdType"])
	local num = tonumber(args["num"]);

	if false == MainServer.exchangeCodeMgr:genCodes(channel, cdType, num) then
		return "<body></br>无法生成兑换码</body>", true
	end

	return string.format("<body></br>生成兑换码成功!!!Channel=%s,CDType=%d,Num=%d</body>", channel,cdType,num), true
end

-------------------------------------------------------
-- 作用: 充值
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:7170/gm?type=func&name=httpRecharge&orderID=11&uid=111&productID=1&count=222&price=333
function httpRecharge(args)
	local roleUID=tonumber(args["uid"]);
	local productID = tonumber(args["productID"])
	local count=tonumber(args["count"]);
	local price=tonumber(args["price"]);
	local orderID = args["orderID"]

	if not MainServer:isShopOrderIDExist(orderID) then
		local record = Role.NewShopRecord(orderID,roleUID,productID,count,price)
		Role.SaveShopRecord(record)

		--! Role
		local role = FindRoleByUID(roleUID);
		if role ~= nil then
			role:shopItem(record, true)
		else
			Role.SaveShopOffline(record);
		end
	else
		logError("Shop order has exist!!!!OrderID={0},RoleUID={1},ProductID={2},Count={3},Price={4}",
			orderID, roleUID, productID, golds, price);
	end

	return "0", true
end

-------------------------------------------------------
-- 作用: 充值
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:7170/gm?type=func&name=httpGetShopItemList&mallType=1
-- 连接参数: mallType=1~3 num=1~$
function httpGetShopItemList(args)
	--local mallType=tonumber(args["mallType"]);

	local items = {}
	Role.GetShopInfo(EMallItemType.GOLD, items)
	Role.GetShopInfo(EMallItemType.CANNON, items)
	Role.GetShopInfo(EMallItemType.GIFTPACK, items)

	return cjson.encode(items), true
end

-------------------------------------------------------
-- 作用: 得到所有玩家信息
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:7170/gm?type=func&name=httpGetAllRoleInfo
-- 连接参数: state=[1,2,4,3,5,6,7] num=1~$
function httpGetAllRoleInfo(args)
	local dateString = os.date();
	genBody = "<body>当前时间 -- " .. dateString .. "</br></br>";
	local roles = luaGetAllRole();
	local types = {};
	local state = 7;
	if args["state"] ~= nil then
		state=tonumber(args["state"]);
	end
	print(state);
	local num = 10000000;
	if args["num"] ~= nil then
		num = tonumber(args["num"]);
	end
	-- 登陆队列中的玩家
	if state == 1 or state == 3 or state == 5 or state == 7 then
		types["1"] = true;
	end
	-- 游戏队列中的玩家
	if state == 2 or state == 3 or state == 6 or state == 7 then
		types["2"] = true;
	end
	-- 登出队列中的玩家
	if state == 4 or state == 5 or state == 6 or state == 7 then
		types["4"] = true;
	end
	local readyNum = 0;
	local enterNum = 0;
	local logoutNum = 0;
	local totalRoleNum = 0;
	for k,v in pairs(roles) do
		if v:isReady() and types["1"]==true then
			readyNum = readyNum+1;
		end
		if v:isEnter() and types["2"]==true then
			enterNum = enterNum+1;
		end
		if v:isLogout() and types["4"]==true then
			logoutNum = logoutNum+1;
		end
	end

	genBody = genBody .. "ReadyNum = " .. readyNum .. ",";
	genBody = genBody .. "EnterNum = " .. enterNum .. ",";
	genBody = genBody .. "LogoutNum = " .. logoutNum .. ",";
	genBody = genBody .. "</br></br>";

	for k,v in pairs(roles) do
		if (v:isReady() and types["1"]==true) or (v:isEnter() and types["2"]==true) or (v:isLogout() and types["4"]==true) then
			totalRoleNum = totalRoleNum+1;
			if totalRoleNum > num then
				break;
			end
			genBody = genBody .. v:toRoleString() .. "</br>";
		end
	end

	return genBody;
end

-------------------------------------------------------
-- 作用: 检测玩家任务指定的任务是否存在
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:9710/gm?type=func&name=httpGetMission
-- 连接参数: roleUID,missionID
function httpGetMission(args)
	local genBody = "";
	local roleUID = args["roleUID"];
	local missionID = args["missionID"];
	local pRole = luaGetRole(roleUID);
	if nil == pRole then
		genBody = genBody .. "</br>玩家不存在</body>";
		return genBody;
	end
	local missionMod = pRole:getMissionMod();
	if missionMod:isExist(missionID) then
		genBody = genBody .. "</br>终于测试成功</body>";
		return genBody;
	else
		genBody = genBody .. "玩家任务存在";
	end

	return genBody;
end

-------------------------------------------------------
-- 作用: 显示玩家身上的已接任务列表
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:9710/gm?type=func&name=httpGetAcceptMissions
-- 连接参数: roleUID
function httpGetAcceptMissions(args)
	local genBody = "任务列表 <br>";
	local roleUID = tonumu64(args["roleUID"]);
	local pRole = luaGetRole(roleUID);
	if nil == pRole then
		genBody = genBody .. "</br>玩家不存在</body>";
		return genBody;
	end
	local missionMod = pRole:getMissionMod();
	local accepts = missionMod:getAccepts();
	for k,v in pairs(accepts) do
		genBody = genBody .. "</br> ";
		genBody = genBody .. v:toString();
	end

	return genBody;
end

-------------------------------------------------------
-- 作用: 停止游戏服务器
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:9170/gm?type=func&name=httpStopService&stopTime=50&saveTime=30
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
