reloadRequire("Util");
reloadRequire("Log");

-------------------------------------------------------
-- 作用: 测试
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmTest(role, args)
	log:debug("test gm function");
	-- printObject(args);
	return true;
end

-------------------------------------------------------
-- 作用: 添加物品
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddItem(role, args)
	local marknum = tonumber(args[1])
	local itemnum = 1;
	if args[2] ~= nil then
		itemnum = tonumber(args[2]);
	end
	luaAddItem(role, marknum, itemnum)
	return true;
end

-------------------------------------------------------
-- 作用: 添加物品
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddItemByRoleName(role, args)
	local roleName = args[1];
	local markNum = tonumber(args[2])
	local itemNum = 1;

	if args[3] ~= nil then
		itemNum = tonumber(args[3]);
	end

	local targetRole = luaGetRoleByName(roleName);
	if IsNULL(targetRole) then
		role:sendChat("目标玩家: "..roleName.." 不在线!")
		return true;
	end
	print(markNum, itemNum);
	targetRole:addItem(markNum, itemNum);
	
	role:sendChat("发送物品给玩家: "..roleName.." 成功!")

	return true;
end

-------------------------------------------------------
-- 作用: 删除所有物品
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmCleanItem(role, args)
	luaCleanItem(role)
	return true
end

-------------------------------------------------------
-- 作用: 显示角色所有属性
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmShowAllAttr(role, args)
	log:debug(
		"Role base attr: " ..
		"Exp=" .. role:getExp() .. ", " .. 
		"Level=" .. role:getLevel() .. ", " .. 
		"GameMoney=" .. role:getGameMoney() .. ", " .. 
		"Rmb=" .. role:getRmb() .. ", " .. 
		"BindRmb=" .. role:getBindRmb() .. ", " .. 
		"Hp=" .. role:getHp() .. ", " .. 
		"MaxHp=" .. role:getMaxHp() .. ", " .. 
		"Speed=" .. role:getMoveSpeed() .. ", " .. 
		"Potential=" ..  role:getPotential()
		);
	return true;
end

-------------------------------------------------------
-- 作用: 加经验
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddExp(role, args)
	local num = tonumber(args[1]);
	role:addExp(num, false);
	return true;
end

-------------------------------------------------------
-- 作用: 加金钱
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddMoney(role, args)
	local num = tonumber(args[1]);
	--role:addGameMoney(num, true);
	role:handleAddMoneyPort(EAttributes.ATTR_MONEY, num, EMoneyRecordTouchType.MONEY_GM)
	return true;
end

-------------------------------------------------------
-- 作用: 加元宝
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddRmb(role, args)
	local num = tonumber(args[1]);
	role:chargeRmb(num, true);
	return true;
end

-------------------------------------------------------
-- 作用: 加绑定元宝
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddBindRmb(role, args)
	local num = tonumber(args[1]);
	--role:addBindRmb(num, false);
	role:handleAddMoneyPort(EAttributes.ATTR_BINDRMB, num, EMoneyRecordTouchType.MONEY_GM)
	return true;
end

-------------------------------------------------------
-- 作用: 加速度
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddSpeed(role, args)
	local num = tonumber(args[1]);
	role:addMoveSpeed(num, false);
	return true;
end

-------------------------------------------------------
-- 作用: 加等级
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddLevel(role, args)
	if tableGetSize(args) < 1 then
		return false;
	end

	local num = tonumber(args[1]);
	role:addLevel(num, false);
	return true;
end

-------------------------------------------------------
-- 作用: 加体力
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddStrength(role, args)
	local num = tonumber(args[1]);
	role:addStrength(num, false);
	return true;
end

-------------------------------------------------------
-- 作用: 加潜力
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddPotential(role, args)
	local num = tonumber(args[1]);
	role:addPotential(num, true);
	return true;
end

-------------------------------------------------------
-- 作用: 增加vip等级
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddVipLevel(role, args)
	local num = tonumber(args[1]);
	role:addVipLevel(num, true);
	return true;
end

-------------------------------------------------------
-- 作用: 增加vip经验
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddVipExp(role, args)
	local num = tonumber(args[1]);
	role:addVipExp(num, true);
	return true;
end

-------------------------------------------------------
-- 作用: 加所有属性
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddAllAttr(role, args)
	local num = tonumber(args[1]);

	role:addGameMoney(num, true);
	role:addHp(num, true);
	role:addMaxHp(num, true);
	role:addBindRmb(num, true);
	role:addExp(num, true);
	role:addStrength(num, true);
	role:addPotential(num, true);

	return true;
end

-------------------------------------------------------
-- 作用: 公告
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function getRoleName(role)
	return tostring(EAnnouncement.ANNOUNCEMENT_ROLE) .. "|" .. role:getRoleNameStr()
end
function gmBroadcast(srole, args)
	-- 参数 公告ID
	
	local role = srole;
	local aid = tonumber(args[1]);
	local cond = tonumber(args[2]);
	local atype = luaGetAnnouncementEventType(aid);
	local systype = luaGetAnnouncementSysType(aid);
	if aid == 3 then  -- 恭喜玩家%s达到%d级！
		local lvlStr = tostring(role:getLevel());
		local roleNameStr=getRoleName(role);
		local lvl=role:getLevel();
		BroadToAll(atype, lvl, roleNameStr, GetNumber(lvl));
	elseif aid == 4 then -- 恭喜玩家%s达到VIP%d！特此公告！
		BroadToAll(atype, role:getVipLevel(), getRoleName(role), GetNumber(role:getVipLevel()));
		print();
	elseif aid == 5  then -- 恭喜玩家%s获得英雄%d！
		BroadToAll(atype, cond, getRoleName(role), GetCommanderName(cond));
	elseif aid == 6 then -- 恭喜%s通关精英关卡获得%d！
		BroadToAll(atype, cond, getRoleName(role), GetItemName(cond));
	elseif aid == 7 then -- 恭喜%s在无尽长廊活动中获得%d！
		BroadToAll(atype, cond, getRoleName(role), GetItemName(cond));
	elseif aid == 8 then -- 恭喜%s在商城购买获得%d！
		BroadToAll(atype, cond, getRoleName(role), GetItemName(cond));
	elseif aid == 9 then -- 恭喜玩家获得战灵%d！
		BroadToAll(atype, cond, getRoleName(role), GetElfName(cond));
	elseif aid == 10 then -- 玩家%s在竞技场有如神助，连胜10场，威风凛凛！
		BroadToAll(atype, cond, getRoleName(role));
	elseif aid == 11 then -- 玩家%s在竞技场连战连胜，连胜20场，所向披靡！
		BroadToAll(atype, cond, getRoleName(role));
	elseif aid == 12 then -- 玩家%s在竞技场大发神威，连胜30场，前无古人后无来者！
		BroadToAll(atype, cond, getRoleName(role));
	elseif aid == 13 then -- 玩家%s在竞技场遇神杀神，遇佛杀佛，连胜40场，独孤求败！
		BroadToAll(atype, cond, getRoleName(role));
	end

	return true;
end

-------------------------------------------------------
-- 作用: 发送系统公告
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAnnouncement(role, args)
	local msg = args[1];
	local last = tonumber(args[2]);
	local interval = tonumber(args[3]);

	luaAllAnnouncement(msg, 2, 1);
	luaAllAnnouncement(msg, last, interval);

	return true;
end

-------------------------------------------------------
-- 作用: 构造兑换码礼包id
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmCreatExchangeId(role, args)
	log:debug("test gm creatExchangeId function");
	local gift_key_id="exchange_gift_id";
	os.remove("creat_gift_id_sql.txt");
	local srcFile = io.open("creat_gift_id_sql.txt", "w");

	local plat_id          = "ppzs";
	local action_id        = "1001";
	local start            = 10000000;
	local exchange_item_id = 0001;
	for var=0, 10, 1
	do
		local sign = luaMD5( plat_id .. action_id .. string.format("%d", start+var) );
		local exchange_id = plat_id .. action_id .. string.format("%d", start+var) .. string.sub( sign, -4, -1 );
		--print(exchange_id);
		local line = "insert into ExchangeGiftTbl (exchange_gift_id,exchange_item_id) values(\'" .. exchange_id .. "\',\'".. string.format("%d", exchange_item_id) .."');\n";
		srcFile:write(line);
	end
	io.close(srcFile);
	
	return true;
end

-------------------------------------------------------
-- 作用: 构造6位随机字符串，且不重复
-- 参数: （开始字符碼ascall码，结束字符碼ascall码, 需要得到的随机字符串长度）
-- 返回: 随机字符串字典
function makeString1( st, en , len)
	--范围产生的总个数
	--70 - 100   1947792
	
	local result={};
	if( st < 70 or en>100 )
	then
		log:error( "st<70 or en>100 wrong !!!" );
		return result;
	end

	local sum =0;
	for i=st, en, 1
	do
		for j=i, en, 1
		do
			for k=j, en, 1
			do
				for h=k, en, 1
				do
					for p=h, en, 1
					do
						for q=p, en, 1
						do
							local tmpString = string.char(i)..string.char(j)..string.char(k)..string.char(h)..string.char(p)..string.char(q);
							table.insert(result, tmpString);
							sum = sum+ 1;
						end
					end

				end
			end
		end
	end

	math.randomseed( os.time() );
	for var=1, len, 1
	do
		local tmpPos = math.random(sum);
		local tmp    = result[tmpPos];
		result[tmpPos]= result[var];
		result[var]   = tmp;
	end
	--print(sum);
	--print(#(result));

	local endResult={};
	for var=1, len, 1
	do
		table.insert( endResult, result[var] );
	end

	return endResult;
end

-------------------------------------------------------
-- 作用: 随机构造兑换码礼包id
-- 参数: 角色指针,平台id(4位）， 功能id(4位）, 版本开始号(2位）, 兑换礼包表兑换id， 构造兑换码个数 
-- 返回: true或false
function gmRandCreatExchangeId(role, args)
	log:debug("test gm randCreatExchangeId function");
	
	local plat_id   = args[1];
	local action_id = args[2];
	local start     = args[3];
	local exchange_item_id = tonumber(args[4]);
	local giftlen   = tonumber(args[5]);
	
	if( #(plat_id)~=4 or #(action_id)~=4 or #(start)~=2)
	then
		log:error("length is wrong !!! platlen=" .. #(plat_id) .. "  actionlen=" .. #(action_id) .. " startlen=" .. #(start)  );
		return false;
	end
	if( tonumber(args[3]) < 10 )
	then
		log:error("start less 10 wrong!!! start=" .. start );
		return false;
	end
	
	
	local gift_key_id="exchange_gift_id";
	os.remove("creat_gift_id_sql.txt");
	local srcFile = io.open("creat_gift_id_sql.txt", "w");
	
	local result = makeString1( 70, 100, giftlen );
	--log:debug("make length=" .. #(result) );	
	
	for var=1, giftlen, 1
	do
		local sign = luaMD5( plat_id .. action_id .. start .. result[var] );
		local exchange_id = plat_id .. action_id .. start .. result[var] .. string.sub( sign, -4, -1 );
		
		local line = "insert into ExchangeGiftTbl (exchange_gift_id,exchange_item_id) values(\'" .. exchange_id .. "\',\'".. string.format("%d", exchange_item_id) .."');\n";
		srcFile:write(line);
	end
	io.close(srcFile);
	log:debug("gzdhid end !!!");
	
	return true;
end
