reloadRequire("Class");
reloadRequire("Log");
reloadRequire("String");
reloadRequire("Util");
reloadRequire("RoleGmFunc");
reloadRequire("RoleGmTest");
reloadRequire("RoleLogic");

CGmHandle=Class("CGmHandle");		-- 定义GM类

-- 构造函数
function CGmHandle:ctor()
	self.funcs = {};
end

-- 注册GM函数
function CGmHandle:registeFunc(name, func, power, paramNum, comment, show)
	assert(self.funcs[name] == nil);
	self.funcs[name] = {};
	self.funcs[name].func = func;
	self.funcs[name].name = name;
	self.funcs[name].comment = comment;
	self.funcs[name].show = show;
	self.funcs[name].paramNum = paramNum;
	self.funcs[name].power = power;
end

-- 处理GM函数
function CGmHandle:handleFunc(role, name, args)
	local func = self.funcs[name];
	if func == nil then
		if role ~= nil then
			logError("Cant find gm func!!!RoleUID="..role:getRoleUIDString());
		else
			logError("Cant find gm func!!!");
		end
		return false;
	end
	
	if role ~= nil and func.power > role:getGmPower() and luaGetServer():getServerConfig():getOpenGmCheck() == true then
		logError("Gm power is lower!RoleUID="..role:getRoleUIDString());
		return false;
	end
	
	if role ~= nil then
		log:info("handle gm " .. name..",RoleUID="..role:getRoleUIDString());
	end
	if tableGetSize(args) < func.paramNum then
		if role ~= nil then
			logError(name .. "gm param need " .. func.paramNum..",RoleUID="..role:getRoleUIDString());
		else
			logError(name .. "gm param need " .. func.paramNum.."!!!");
		end
		return false;
	end

	return func.func(role, args);
end

-- 转换成字符串
function CGmHandle:toString()
	local str = "";
	for k,v in pairs(self.funcs) do
		str = str .. v.comment .. "\n";
	end

	return str;
end

-- GM函数是否存在
function CGmHandle:isFuncExist(name)
	return self.funcs[name] ~= nil;
end

-- 注册所有的函数
function CGmHandle:registeAllFunc()
	--[[
	-- 测试
	self:registeFunc("cs", gmTest, 1, 0, "测试: gm cs");
	self:registeFunc("ren", gmTestRename, 1, 1, "测试重命名: gm ren xxx");
	self:registeFunc("rn", gmTestRandName, 1, 0, "测试随机名字: gm rn");
	self:registeFunc("testgc", gmTestGC, 1, 0, "测试释放lua内存: gm testgc xxx");
	self:registeFunc("testjson", gmTestJson, 1, 0, "测试Json解析: gm testjson");

	-- 辅助GM命令
	self:registeFunc("xtgg", gmAnnouncement, 0, 3, "系统公告: gm xtgg xxx(内容) xxx(持续时间) xxx(发送间隔)", true);
	self:registeFunc("wp", gmAddItem, 5, 1, "添加物品: gm wp xxx(物品ID) [xxx](物品数目, 默认为1)", true);
	self:registeFunc("wpr", gmAddItemByRoleName, 5, 2, "添加目标角色物品: gm wpr xxx(角色名字) xxx(物品ID) [xxx](物品数目, 默认为1)", true);
	self:registeFunc("cwp", gmCleanItem, 5, 0, "删除物品: gm cwp(注意是清理所有物品)", true);
	self:registeFunc("xssy", gmShowAllAttr, 5, 0, "显示所有的属性:gm xssy", true);
	self:registeFunc("jy", gmAddExp, 5, 1, "加经验:gm jy xxx(数目)", true);
	self:registeFunc("jq", gmAddMoney, 5, 1, "加金钱:gm jq xxx(数目)", true);
	self:registeFunc("yb", gmAddRmb, 5, 1, "加元宝:gm yb xxx(数目)", true);
	self:registeFunc("bdyb", gmAddBindRmb, 5, 1, "加绑定元宝:gm bdyb xxx(数目)", true);
	self:registeFunc("sd", gmAddSpeed, 5, 1, "加速度:gm sd xxx(数目)", true);
	self:registeFunc("dj", gmAddLevel, 5, 1, "加等级:gm dj xxx(数目)", true);
	self:registeFunc("tl", gmAddStrength, 5, 1, "加体力值:gm tl xxx(数目)", true);
	self:registeFunc("ql", gmAddPotential, 5, 1, "加潜力点:gm ql xxx(数目)", true);
	self:registeFunc("sy", gmAddAllAttr, 5, 1, "加金钱,元宝,经验,体力,潜力点:gm sy xxx(数目)", true);
	self:registeFunc("ve", gmAddVipExp, 5, 1, "加vip经验:gm ve xxx(数目)", true);
	self:registeFunc("vl", gmAddVipLevel, 5, 1, "加vip等级:gm vl xxx(数目)", true);
	self:registeFunc("gg", gmBroadcast, 5, 2, "公告:gm gg xxx(公告id) xxx(达成条件)", true);

	--构造兑换礼包id
	self:registeFunc("gzdhid", gmCreatExchangeId, 5, 0, "构造兑换礼包id:gm gzdhid", false);
	self:registeFunc("rgzdhid", gmRandCreatExchangeId, 1, 5, "构造兑换礼包id:gm rgzdhid xxx(平台id) xxx(功能id) xxx(开始版本号) xxx(兑换码表配置表id) xxx（构造个数)", false);
	]]

	self:registeFunc("syschat", gmSystemChat, 0, 1, "System Chat: gm syschat xxx(message)", true);
	self:registeFunc("allroles", gmListOnlineRoles, 0, 0, "List all online roles: gm allroles", true); 
	self:registeFunc("addfriends", gmAddFriend, 0, 0, "Add all other roles to friends: gm addfriends", true); 
	self:registeFunc("privates", gmPrivateChat, 0, 0, "All friends send chat message to role: gm privates", true); 
	self:registeFunc("chathistory", gmPrivateChatHistory, 0, 0, "All friends history chat message to role: gm chathistory", true); 
	self:registeFunc("faction", gmFriendAction, 0, 2, "Rand friends send action message to role: gm faction 0 xxx(0-4)", true);
	self:registeFunc("addscore", gmRankAddScore, 0, 0, "Rand add robot rank score: gm addscore", true);
	self:registeFunc("addselfscore", gmRankAddSelfScore, 0, 0, "Add self rank score: gm addselfscore xxx", true);
	self:registeFunc("rankto", gmRankTo, 0, 0, "Add self rank score to rank level: gm rankto xxx(type) xxx(num)", true);
	self:registeFunc("addrmb", gmAddRmb, 0, 1, "Add self rmb: gm addrmb xxx(num)", true);
	self:registeFunc("addjewel", gmAddJewel, 0, 1, "Add self jewel: gm addjewel xxx(num)", true);
	self:registeFunc("addcharm", gmAddCharm, 0, 1, "Add self charm: gm addcharm xxx(num)", true);
	self:registeFunc("sendmail", gmSendMail, 0, 1, "Send self mail: gm sendmail xxx(num) xxx(num) xxx(num)", true);	
	self:registeFunc("sendallmail", gmSendAllMail, 0, 1, "Send all mail: gm sendallmail xxx(num) xxx(num) xxx(num)", true);	
end

-------------------------------------------------------
-- 作用: 标准化字符串
-- 参数: 源字符串
-- 返回: 标准化后的字符串
function CGmHandle:standGmStr(gmString)
	local tempString = stringSrimCont(gmString, " ");	-- 删除连续空格
	tempString = string.gsub(tempString, "= ", "=");	-- 删除=号后的空格
	tempString = string.gsub(tempString, " =", "=");	-- 删除=号前的空格
	return tempString;
end

-------------------------------------------------------
-- 作用: GM字符串是否合法, 以/gm xxx开头, 并且参数为" "隔开或"="号隔开, 但"="号和" "隔开符只能存在一种
--       类似/gm xxx aaa bbb ccc 或 /gm xxx aaa=1 bbb=2 ccc=3
-- 参数: GM字符串头, GM字符串
-- 返回: true|false
function CGmHandle:isGmStringValid(headStr, gmString)
	local strs = stringSplit(gmString, " ");

	if #strs < 2
	then
		return false;
	end
	if string.lower(strs[1]) ~= headStr
	then
		return false;
	end
	if not xstr:isalnum(string.lower(strs[2]))
	then
		return false;
	end

	local eqSpliteStr = false;
	local spSpliteStr = false;
	for k,v in pairs(strs) do
		if k >= 3 then
			if stringIsExist(v, "=")
			then
				eqSpliteStr = true;	-- 有=号分割
			else
				spSpliteStr = true;	-- 无=号分割
			end
			if eqSpliteStr and spSpliteStr
			then
				return false;
			end
		end
	end

	return true;
end

-------------------------------------------------------
-- 作用: 解析GM字符串
-- 参数: GM字符串
-- 返回: GM头,GM指令名字,GM参数表
function CGmHandle:parseGm(gmString)
	local strs=stringSplit(gmString, " ");
	local gmHead = string.lower(strs[1]);
	local gmNameStr = string.lower(strs[2]);
	local gmParams = {};
	for k,v in pairs(strs) do
		if k >= 3 then
			if stringIsExist(v, "=")
			then
				local sp1,sp2=stringSplite1(v,"=");
				gmParams[string.lower(sp1)]=sp2;
			else
				table.insert(gmParams, v);
			end
		end
	end

	return gmHead,gmNameStr,gmParams;
end

-- =========================== GM模块 ===========================
--

-- 重新加载所有脚本文件
function reloadScript(role, args)
	local name = "CodeHeader";
	log:info("reload " .. name .. " file");
	allReloadRequireName = {};
	package.loaded[name] = nil;
	require(name);
	return true;
end

-- 处理GM函数
function HandleGm(role, name, args)
	return gmFuncMgr:handleFunc(role, name, args);
end

-------------------------------------------------------
-- 作用: 解析GM字符串并处理对应的回调函数
-- 参数: GM字符串
-- 返回: true|false
function HandleGmString(role, gmString)
	local tempString = gmFuncMgr:standGmStr(gmString);
	if not gmFuncMgr:isGmStringValid("gm", tempString)
	then
		log:error("Gm is invalid string!"..gmString);
		return false;
	end
	local gmHead,gmNameStr,gmParams=gmFuncMgr:parseGm(tempString);
	return gmFuncMgr:handleFunc(role, gmNameStr, gmParams);
end

-------------------------------------------------------
-- 作用: 解析GM字符串并处理对应的回调函数
-- 参数: GM字符串
-- 返回: true|false
function HandleGmString2(gmString)
	local tempString = gmFuncMgr:standGmStr(gmString);
	if not gmFuncMgr:isGmStringValid("gm", tempString)
	then
		log:error("Gm is invalid string!"..gmString);
		return false;
	end
	local gmHead,gmNameStr,gmParams=gmFuncMgr:parseGm(tempString);
	return gmFuncMgr:handleFunc(nil, gmNameStr, gmParams);
end

-- 检测GM函数是否存在
function IsGmExist(name)
	return gmFuncMgr:isFuncExist(name);
end

-- 新建GM管理对象并注册重加载脚本函数
gmFuncMgr = CGmHandle.new();		-- GM命令管理
gmFuncMgr:registeFunc("rl", reloadScript, 0, 0, "gm reloadscript");

function Help(role, args)
	for k,v in pairs(gmFuncMgr.funcs) do
		if v.show then
			role:sendChat(v.comment);
		end
	end

	return true;
end
function Help2(role, args)
	for k,v in pairs(gmFuncMgr.funcs) do
		if v.show then
			logInfo(v.comment);
		end
	end

	return true;
end

gmFuncMgr:registeFunc("bz2", Help, 0, 0, "帮助: gm bz2");
gmFuncMgr:registeFunc("bz", Help2, 0, 0, "帮助: gm bz");

gmFuncMgr:registeAllFunc();

--
-- =========================== GM模块 ===========================
