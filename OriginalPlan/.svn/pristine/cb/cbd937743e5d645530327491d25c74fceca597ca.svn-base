reloadRequire("Util");
reloadRequire("Log");

function gmGetOnlineRole()
	local roles = CMServerHelper:LuaGetAllRole();

	if #roles > 0 then
		for k,v in pairs(roles) do
			return v:getScriptObject();
		end
	end

	return nil;
end

-------------------------------------------------------
-- 作用: 广播系统消息
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmSystemChat(role, args)
	ChatSystemMsg(args[1]);
	return true;
end

-------------------------------------------------------
-- 作用: 世界聊天
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmWorldChat(role, args)
	ChatWorldMsg(args[1]);
	return true;
end

-------------------------------------------------------
-- 作用: 房间聊天
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmRoomChat(role, args)
	return true;
end

-------------------------------------------------------
-- 作用: 发送留言
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmPrivateChatHistory(role, args)
	local role = nil;
	if #args > 0 then
		role = CMServerHelper:LuaGetSpRole(tonumber(args[1]));
	end
	if role == nil then
		role = gmGetOnlineRole();
	end

	if role == nil then
		logError("Excute gm cmd: cant find role!!!");
		return true;
	end

	logInfo("===============GM[private chat history]===============");
	logInfo("===============Role: [Account={0},GameID={1}]", role.account, role.roleUID);
	local msgs = MainServer.chatMgr:loadMsgList(role.roleUID);
	for _,v in pairs(msgs) do
		logInfo("===roleUID:{0}, msg:{1}, dateTime:{2} ", v.dataId, v.msg, v.dateTime);
	end
	logInfo("=====================End=====================");

	role:sendChatHistory();

	return true;
end

-------------------------------------------------------
-- 作用: 赠送礼物消息
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmFriendAction(role, args)
	local role = nil;
	if #args > 0 then
		role = CMServerHelper:LuaGetSpRole(tonumber(args[1]));
	end
	if role == nil then
		role = gmGetOnlineRole();
	end

	if role == nil then
		logError("Excute gm cmd: cant find role!!!");
		return true;
	end
	local type = tonumber(args[2]);
	logInfo("===============GM[friend send gift]===============");
	logInfo("===============Role: [Account={0},GameID={1}]", role.account, role.roleUID);
	for k,v in pairs(role.friends) do
		local friend = MainServer.playerInfoMgr:getInfo(k);
		if nil ~= friend then
			logInfo("Friend[Account={0},GameID={1}]", friend.account, friend.player.dataId);
			if type == 0 then
				local id = role:friendAddAction(EMsgType.FRIEND_GIFT_MSG, {type=EMsgType.FRIEND_GIFT_MSG,roleUID=friend.player.dataId,item=2, num=10})
				role:sendFriendGiveGiftUpdate(friend.player, id, 2, 10);
				logInfo("giftId=2, num=10", friend.account, friend.player.dataId);
			elseif type == 1 then
				role:friendAddAction(EMsgType.FRIEND_ADD_REQ, {roleUID=friend.player.dataId});
				role:sendFriendApply(friend.player);
			elseif type == 2 then
				role:friendAddAction(EMsgType.FRIEND_DEL_MSG, {roleUID=friend.player.dataId});
				role:sendFriendRemove(friend.player);
			elseif type == 3 then
				role:friendAddAction(EMsgType.FRIEND_ADD_MSG, {roleUID=friend.player.dataId});
				role:sendFriendApplyResult(friend.player, 1);
			else
				role:friendAddAction(EMsgType.FRIEND_REFUSE_MSG, {roleUID=friend.player.dataId});
				role:sendFriendApplyResult(friend.player, 0);
			end
			break;
		end
	end
	logInfo("=====================End=====================");
	return true;
end

-------------------------------------------------------
-- 作用: 私聊
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmPrivateChat(role, args)
	local role = nil;
	if #args > 0 then
		role = CMServerHelper:LuaGetSpRole(tonumber(args[1]));
	end
	if role == nil then
		role = gmGetOnlineRole();
	end

	if role == nil then
		logError("Excute gm cmd: cant find role!!!");
		return true;
	end

	local unsendFlag = true;
	if args[2] ~= nil then
		unsendFlag = false;
	end

	logInfo("===============GM[friend send chat]===============");
	logInfo("===============Role: [Account={0},GameID={1}]", role.account, role.roleUID);
	for k,v in pairs(role.friends) do
		local friend = MainServer.playerInfoMgr:getInfo(k);
		if nil ~= friend then
			local msg = RandNumString(10);
			ChatPrivateMsg(friend.player, role.roleUID, msg, unsendFlag);

			logInfo("Friend[Account={0},GameID={1}]: {2}",
				friend.account, friend.player.dataId, msg);
		end
	end
	logInfo("=====================End=====================");
	return true;
end

-------------------------------------------------------
-- 作用: 添加好友
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmAddFriend(role, args)
	local role = gmGetOnlineRole();
	if nil ~= role then
		for k,v in pairs(MainServer.playerInfoMgr.players) do
			if v.player.dataId ~= role.roleUID and not role:friendIsExist(v.player.dataId) then
				role:friendAdd(v.player.dataId);
				logInfo("Add friend!!!Account={0},DataId={1}", v.account, v.player.dataId);

				ServerAddMsg(v.player.dataId,{type=EMsgType.FRIEND_ADD,roleUID=role.roleUID});
			end
		end
	end

	return true;
end

-------------------------------------------------------
-- 作用: 列出在线玩家
-- 参数: 角色指针,GM命令参数
-- 返回: true或false
function gmListOnlineRoles(role, args)
	local roles = CMServerHelper:LuaGetAllRole();

	if #roles > 0 then
		logInfo("===============List online roles===============");

		for k,v in pairs(roles) do
			local role = v:getScriptObject();
			logInfo("Account={0},GameID={1}", role.account, role.playerData.dataId);
		end

		logInfo("======================End======================");
	else
		logInfo("None role online!!!");
	end

	return true;
end

function gmRankAddScore(role, args)
	for k,v in pairs(MainServer.playerInfoMgr.players) do
		if PlayerInfoManager.IsRobot(v) then
			local num = math.random(100000);
			for t,r in ipairs(v.rankDatas) do
				MainServer.rankMgr:addScore(k, t, num);
				r.score = r.score+num;
			end
		end
	end

	MainServer.rankMgr:doSort();

	return true;
end

function gmRankAddSelfScore(role, args)
	local num = 0;
	if #args > 0 then
		num = tonumber(args[1]);
	else
		num = math.random(100000);
	end
	local role = gmGetOnlineRole();
	if nil ~= role then
		for k=ERankType.BEGIN,ERankType.END do
			role:addRankScore(k, num);
		end
	end

	MainServer.rankMgr:doSort();

	logDebug("Add online role score!!!Score={0}", num);

	return true;
end

function gmRankTo(role, args)
	local role = gmGetOnlineRole();
	if nil == role then
		return true;
	end

	local rank = 0;
	local type = ERankType.GOLD;
	if #args > 0 then
		type = tonumber(args[1]);
	end
	if type < ERankType.BEGIN then
		type = ERankType.BEGIN;
	elseif type > ERankType.END then
		type = ERankType.END;
	end
	if #args > 1 then
		rank = tonumber(args[2]);
	end
	if rank < 1 then
		rank = 1;
	elseif rank > 10 then
		rank = 10;
	end
	local ranker = MainServer.rankMgr:getRankBean(type, rank);
	if ranker ~= nil and ranker.score > role.rankDatas[type].score then
		local score = ranker.score-role.rankDatas[type].score+1;
		role:addRankScore(type, score);
		logDebug("Add role score!!!Score={0}", score)
	end

	MainServer.rankMgr:doSort();

	return true;
end

function gmRankReset(role, args)
	
end

function gmAddRmb(role, args)
	local role = gmGetOnlineRole();
	if nil == role then
		logError("role need online!!!");
		return true;
	end

	local golds = tonumber(args[1]);
	role:doChargeRmb(golds, golds*10, true);
end

function gmAddJewel(role, args)
	local role = gmGetOnlineRole();
	if nil == role then
		logError("role need online!!!");
		return true;
	end

	local jewels = tonumber(args[1]);
	role:addJewels("GM命令", jewels);
end

function gmAddCharm(role, args)
	local role = gmGetOnlineRole();
	if nil == role then
		logError("role need online!!!");
		return true;
	end

	local charms = tonumber(args[1]);
	role:addCharms(charms);
end

function gmSendMail(role, args)
	local role = gmGetOnlineRole();
	if nil == role then
		logError("role need online!!!");
		return true;
	end

	local golds = nil
	if #args > 0 then
	   golds = tonumber(args[1]);
	end
	local jewels = nil
	if #args > 1 then
		jewels = tonumber(args[2]);
	end
	local item = nil
	if #args > 2 then
		item = tonumber(args[3]);
	end
	local items = {}
	if golds ~= nil then
		table.insert(items, {type=Mail.EItemType.GOLD,num=golds});
	end
	if jewels ~= nil then
		table.insert(items, {type=Mail.EItemType.JEWEL,num=jewels});
	end
	if item ~= nil then
		table.insert(items, {type=Mail.EItemType.ITEM,num=item});
	end
	MainServer.mailMgr:sendPrivateMail("Test", os.time(), MailManager.SystemUID, "System", "Test Mail", items, role.roleUID);
end

function gmSendAllMail(role, args)
	local golds = nil
	if #args > 0 then
	   golds = tonumber(args[1]);
	end
	local jewels = nil
	if #args > 1 then
		jewels = tonumber(args[2]);
	end
	local item = nil
	if #args > 2 then
		item = tonumber(args[3]);
	end
	local items = {}
	if golds ~= nil then
		table.insert(items, {type=Mail.EItemType.GOLD,num=golds});
	end
	if jewels ~= nil then
		table.insert(items, {type=Mail.EItemType.JEWEL,num=jewels});
	end
	if item ~= nil then
		table.insert(items, {type=Mail.EItemType.ITEM,num=item});
	end
	MainServer.mailMgr:sendAllMail("Test", os.time(), "System", "Test Mail", items);
end

function gmLoadRedeemCode(role, args)
	local fileName = args[1];
end
