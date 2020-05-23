-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:handleBagBuyGrid
-- @description 购买背包格子
-- @param CMExtendPack:pack 
-- @return boolean: 
-- @usage 
function MapPlayerHandler:handleBagBuyGrid(pack)
	local pBag = self.pRole:getBagMod():getBag();
	local size = pBag:getRoleContainerSize();
	local retPack = MCBagExtendRet.new();
	if (size+pack.size) > pBag:getContainerSize() then
		retPack.retCode = EGameRetCode.RC_FAILED;
		self:sendPacket(retPack);
		return true;
	end
	
	if not pBag:extendContainer(pack.size, pBag:getRoleContainerSize()) then
		retPack.retCode = EGameRetCode.RC_FAILED;
		self:sendPacket(retPack);
		return true;
	end
	
	local extendPack = MCBagExtend.new();
	extendPack.size = pack.size;
	self:sendPacket(retPack);
	
	retPack.retCode = RC_SUCCESS;
	self:sendPacket(retPack);
	
	return true;
end

-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:handleBagOperate
-- @description 背包操作
-- @param CMBagOperate:pack
-- @return boolean: 
-- @usage 
function MapPlayerHandler:handleBagOperate(pack)
	local pBag = self.pRole:getBagMod():getBag();
	local retPack = MCBagOperateRet.new();
	
	local spRole = self.spRole;
	if pack.opType == EBagOperateType.BAG_OPERATE_TYPE_DROP then
		retPack.retCode = CItemOperator:EraseItem(pBag, pack.index);
	elseif pack.opType == EBagOperateType.BAG_OPERATE_TYPE_PACK_UP then
		retPack.retCode = CItemOperator:PackUp(pBag);
	elseif pack.opType == EBagOperateType.BAG_OPERATE_TYPE_REQ_ALL then
		retPack.retCode = spRole:bagSendItemList(self);
	elseif retPack.opType == EBagOperateType.BAG_OPERATE_TYPE_SELL then
		retPack.retCode = CItemOperator:EraseItem(pBag, pack.index);
	elseif retPack.opType == EBagOperateType.BAG_OPERATE_TYPE_USE then
		retPack.retCode = CItemOperator:UseItem(pBag, pack.index);
	else
		retPack.retCode = RC_FAILED;
	end
	
	self:sendPacket(retPack);
end