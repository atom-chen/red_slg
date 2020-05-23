reloadRequire("Log");
reloadRequire("Util");
reloadRequire("Table");

-------------------------------------------------------
-- 作用: 测试
-- 参数: 
-- 返回: 1
function configTest(role, arg1, arg2)
	--printObject(args);
	log:debug("test congfig function" .. "  arg1=" .. arg1 .. "  arg2=" .. arg2);
	-- printObject(args);
	return 1;
end

-------------------------------------------------------
-- 作用: 检查输入的兑换码
-- 参数: 兑换码id
-- 返回: 错误码
function checkExchangeGiftId( id )
	--id = "000100021234567818e9";
	log:debug("input exchange id " .. id );
	
	local platIdList = getExchangePlatIdList();	
	if( platIdList[string.sub(id, 1, 4)]  == nil )
	then		
		return EGameRetCode.RC_EXCHANGE_GET_GIFT_PLAT_ID_ERR;
	end
	
	local actionList = getExchangeActionList();	
	if( actionList[ string.sub(id, 5, 8) ] == nil )
	then
		return EGameRetCode.RC_EXCHANGE_GET_GIFT_ACTION_ERR;
	end
	
	local tmpId = string.sub(id, 1, -5 ) .. getPlatMd5Key();
	local sign = luaMD5(tmpId);	
	if( string.sub(id, -4, -1)~=string.sub(id, -4, -1) or string.len(id)~=20 )
	then
		log:error("md5 sign=" .. sign .. "   string.sub(id, -4, -1)=" .. string.sub(id, -4, -1) .. "   len=" .. string.len(id) );
		return EGameRetCode.RC_EXCHANGE_GET_GIFT_INVALID_ERR;
	end
	
	if( string.len(id) ~= 20 )
	then
		return EGameRetCode.RC_EXCHANGE_GET_GIfT_INVALID_LEN_ERR;
	end
	
	return 0;
end
