-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:requestBagList
-- @description 请求背包列表
-- @return nil: 
-- @usage 
function PlayerSocketHandler:requestBagList()
	local reqPacket = CMBagOperate.new();
	reqPacket.opType = EBagOperateType.BAG_OPERATE_TYPE_REQ_ALL;
	reqPacket.index = 0;
	self:sendPacket(reqPacket);
end

-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:bagDropItem
-- @description 丢弃道具
-- @param number:index 丢弃道具的索引
-- @return nil: 
-- @usage 
function PlayerSocketHandler:bagDropItem(index)
	local reqPacket = CMBagOperate.new();
	reqPacket.opType = EBagOperateType.BAG_OPERATE_TYPE_DROP;
	reqPacket.index = index;
	self:sendPacket(reqPacket);
end

-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:bagPackUp
-- @description 整理背包
-- @return nil: 
-- @usage 
function PlayerSocketHandler:bagPackUp()
	local reqPacket = CMBagOperate.new();
	reqPacket.opType = EBagOperateType.BAG_OPERATE_TYPE_PACK_UP;
	reqPacket.index = 0;
	self:sendPacket(reqPacket);
end

-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:handleAddItems
-- @description 处理道具添加列表
-- @param MCAddItems:pack 
-- @return nil: 
-- @usage 
function PlayerSocketHandler:handleAddItems(pack)
	--[[
	logInfo("Bag add items!!!");
	for k=1,#pack.items,1 do
		local item = pack.items[k];
		printObject(item);
	end
	]]
	return true;
end

-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:handleDelItems
-- @description 删除道具列表
-- @param MCDelItems:pack 
-- @return nil: 
-- @usage 
function PlayerSocketHandler:handleDelItems(pack)
	--logInfo("Bag del items!!!");
	
	--printObject(pack.items);
	return true;
end

-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:handleUpdateItems
-- @description 更新道具列表
-- @param MCUpdateItems:pack 
-- @return nil: 
-- @usage 
function PlayerSocketHandler:handleUpdateItems(pack)
	logInfo("Bag update items!!!");
	
	printObject(pack.items);
end

-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:handleMoveItem
-- @description 移动道具
-- @param MCMoveItems:pack 
-- @return nil: 
-- @usage 
function PlayerSocketHandler:handleMoveItem(pack)
	logInfo("Bag move item!!!");
	
	printObject(pack.items);
end

-------------------------------------------------------
-- @class function
-- @name PlayerSocketHandler:handleExchangeItem
-- @description 交换道具
-- @param MCExchangeItem:pack 
-- @return nil: 
-- @usage 
function PlayerSocketHandler:handleExchangeItem(pack)
	logInfo("Bag exchange item!!!");
	
	printObject(pack);
end

PlayerSocketHandler.Protocols[MCAddItems.PackID] = PlayerSocketHandler.handleAddItems;
PlayerSocketHandler.Protocols[MCDelItems.PackID] = PlayerSocketHandler.handleDelItems;
PlayerSocketHandler.Protocols[MCUpdateItems.PackID] = PlayerSocketHandler.handleUpdateItems;
PlayerSocketHandler.Protocols[MCExchangeItem.PackID] = PlayerSocketHandler.handleExchangeItem;
PlayerSocketHandler.Protocols[MCMoveItems.PackID] = PlayerSocketHandler.handleMoveItem;