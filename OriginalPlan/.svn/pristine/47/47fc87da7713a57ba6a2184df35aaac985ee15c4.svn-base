-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:handleFightChapter
-- @description 进入关卡消息
-- @param CMFightOpenChapter:pack 
-- @return 
-- @usage
function MapPlayerHandler:handleFightChapter(pack)
	local spRole = self.spRole;
	local retCode = spRole:fightOpenChapter(pack.chapterTypeID, self.pRole:getLastMapID());
	local retPack = MCFightOpenChapterRet.new();
	
	retPack.chapterTypeID = pack.chapterTypeID;
	retPack.retCode = retCode;
	
	self:sendPacket(retPack)
end

-------------------------------------------------------
-- @class function
-- @name MapPlayerHandler:handleFightFinish
-- @description 战斗结束消息
-- @param CMFightFinish:pack 
-- @return 
-- @usage 
function MapPlayerHandler:handleFightFinish(pack)
	local spRole = self.spRole;
	local retCode = spRole:fightOnFinish(pack.victoryFlag);
	local retPack = MCFightFinishRet.new();
	retPack.retCode = retCode;
	self:sendPacket(retPack);
end
