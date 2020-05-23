reloadRequire("Class");
reloadRequire("Log");
reloadRequire("String");
reloadRequire("Util");
reloadRequire("Table");
reloadRequire("HttpData");

-------------------------------------------------------
-- 作用: 踢掉玩家
-- 参数: 参数
-- 返回: 生成的html消息体
-- 示例: http://127.0.0.1:9710/gm?type=func&name=httpKickRole&roleName=
-- 连接参数: roleName
-- 错误码: 0	:	OK
--	   1002	:	错误参数
function httpKickRole(args)
	local roleName=args["roleName"];
	if not IsNULL(roleName) then
		luaKickRole(roleName);
		return httpJSonErrMsgFmt(HttpErrCode.OK);
	else
		return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
	end
end

-------------------------------------------------------
-- @class function
-- @name httpAddItemToRole
-- @description 给玩家添加道具
-- @param nil:args http参数列表
-- @return string:
-- @usage http://127.0.0.1:7170/gm?type=func&name=httpAddItemToRole&roleUID=1&itemTypeID=1001&itemNum=10
function httpAddItemToRole(args)
	if not httpCheckArgs(args, "roleUID", "itemTypeID", "itemNum") then
		return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
	end

	local roleUID = CMServerHelper:LuaToNum64(args["roleUID"]);
	local itemTypeID = tonumber(args["itemTypeID"]);
	local itemNum = tonumber(args["itemNum"]);
	if IsAllValidPtr(roleUID, itemTypeID, itemNum) then
		--! CRole
		local pRole = CMServerHelper:LuaGetRole(roleUID);
		if IsValidPtr(pRole) then
			--local pItemTbl = CItemTblLoader:GetPtr():findByKey(itemTypeID);
			CItemHelper:AddItemToBag(EItemRecordType.ITEM_RECORD_ITEM_GM, pRole, itemTypeID, itemNum, true);
			return httpJSonErrMsgFmt(HttpErrCode.OK);
		end
	end

	return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
end

-------------------------------------------------------
-- @class function
-- @name httpDelItemFromRole
-- @description 从角色身上删除道具
-- @param nil:args
-- @return nil:
-- @usage
function httpDelItemFromRole(args)
	if not httpCheckArgs(args, "roleUID", "index") then
		return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
	end

	local roleUID = CMServerHelper:LuaToNum64(args["roleUID"]);
	local itemIndex = tonumber(args["index"]);
	if IsAllValidPtr(roleUID, itemIndex) then
		local pRole = CMServerHelper:LuaGetRole(roleUID);
		if IsValidPtr(pRole) then
			local pBag = pRole:getBagMod():getBag();
			if IsValidPtr(pBag:getItemByIndex(itemIndex)) then
				pBag:delItemByIndex(EItemRecordType.ITEM_RECORD_ITEM_GM, itemIndex, true);
				return httpJSonErrMsgFmt(HttpErrCode.OK);
			end
		end
	end

	return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
end

-------------------------------------------------------
-- @class function
-- @name _httpDeleteAllItem
-- @description 删除角色所有道具
-- @return CRole:pRole
-- @usage
local function _httpDeleteAllItem(pRole)
	local pBag = pRole:getBagMod():getBag();
	-- 删除所有的道具
	for k=1, pBag:getRoleContainerSize(), 1 do
	local pItem = pBag:getItemByIndex(k-1);
	if IsValidPtr(pItem) and not pItem:empty() then
		print("Delete item!!!!Index=", k-1);
		pBag:delItemByIndex(EItemRecordType.ITEM_RECORD_ITEM_GM, k-1, true);
		end
	end
end

-------------------------------------------------------
-- @class function
-- @name httpDeleteAllItem
-- @description 删除玩家所有道具
-- @param nil:args
-- @return nil:
-- @usage http://127.0.0.1:7170/gm?type=func&name=httpDeleteAllItem&roleUID=1
function httpDeleteAllItem(args)
	if not httpCheckArgs(args, "roleUID") then
		return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
	end

	local roleUID = CMServerHelper:LuaToNum64(args["roleUID"]);
	if IsValidPtr(roleUID) then
		local pRole = CMServerHelper:LuaGetRole(roleUID);
		if IsValidPtr(pRole) then
			-- 删除所有的道具
			_httpDeleteAllItem(pRole);

			return httpJSonErrMsgFmt(HttpErrCode.OK);
		end
	end

	return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
end

-------------------------------------------------------
-- @class function
-- @name httpTestBag
-- @description 测试背包操作
-- @param nil:args
-- @return nil:
-- @usage http://127.0.0.1:7170/gm?type=func&name=httpTestBag&roleUID=1
function httpTestBag(args)
	if not httpCheckArgs(args, "roleUID") then
		return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
	end

	local roleUID = CMServerHelper:LuaToNum64(args["roleUID"]);
	if IsValidPtr(roleUID) then
		local pRole = CMServerHelper:LuaGetRole(roleUID);
		if IsValidPtr(pRole) then
			local pBag = pRole:getBagMod():getBag();
			-- 删除所有的道具
			_httpDeleteAllItem(pRole);

			-- 添加所有的道具
			for k=1,pBag:getRoleContainerSize(),1 do
				CItemHelper:AddItemToBag(EItemRecordType.ITEM_RECORD_ITEM_GM, pRole, 1001, 50, true);
			end

			-- 删除双数的道具
			for k=2,pBag:getRoleContainerSize(),2 do
				pBag:delItemByIndex(EItemRecordType.TEM_RECORD_ITEM_GM, k-1, true);
			end

			-- 移动道具位置
			for k=1,pBag:getRoleContainerSize(),2 do
				CItemHelper:BagMoveItem(pRole,k-1,k);
			end

			-- 整理背包
			CItemOperator:PackUp(pBag);

			return httpJSonErrMsgFmt(HttpErrCode.OK);
		end
	end

	return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
end

-------------------------------------------------------
-- @class function
-- @name httpShowBagAllItem
-- @description 显示背包所有道具
-- @param nil:args
-- @return nil:
-- @usage http://127.0.0.1:7170/gm?type=func&name=httpShowBagAllItem&roleUID=1&hNum=8
function httpShowBagAllItem(args)
	if not httpCheckArgs(args, "roleUID", "hNum") then
		return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
	end

	local showGrid = ""
	local roleUID = CMServerHelper:LuaToNum64(args["roleUID"]);
	local hNum = tonumber(args["hNum"]);
	local tempHNum = 0;
	if IsAllValidPtr(roleUID, hNum) then
		local pRole = CMServerHelper:LuaGetRole(roleUID);
		if IsValidPtr(pRole) and hNum <= pRole:getHumanBaseData():getbagOpenGridNum() then
			local pBag = pRole:getBagMod():getBag();
			for k=1, pBag:getRoleContainerSize(), 1 do
				local pItem = pBag:getItemByIndex(k-1);
				if IsValidPtr(pItem) and not pItem:empty() then
					showGrid = showGrid..pItem:getTypeID()..":"..pItem:getNum().."&nbsp&nbsp&nbsp&nbsp";
				else
					showGrid = showGrid.."nil "..":".."0&nbsp&nbsp&nbsp&nbsp&nbsp";
				end

				tempHNum = tempHNum+1;
				if tempHNum == hNum then
					tempHNum = 0;
					showGrid = showGrid.."<br>"
				end
			end
		end

		return showGrid;
	end

	return httpJSonErrMsgFmt(HttpErrCode.BAD_PARAMS);
end