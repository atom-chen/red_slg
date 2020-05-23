--[[
	class:		WMBaseInfoController
	desc:
	author:		郑智敏
--]]
local WMInfoUilt = game_require('model.world.map.WMInfoUilt')
local WMBaseInfoController = class('WMBaseInfoController')

function WMBaseInfoController:ctor( model )
	-- body
	SchedulerHandlerExtend.extend( self )
	self._model = model
	self._baseTable = {}
	self._enemyDefeatTable = {}
end

function WMBaseInfoController:init(  )
	-- body
	self:clearInfo()
end

function WMBaseInfoController:getInfoAt( pos )
	-- body
	local data = self._baseTable[WMInfoUilt:serializePos(pos)]
	local enemyDefeatList = self._enemyDefeatTable[WMInfoUilt:serializePos(pos)]
	if nil == enemyDefeatList then
		enemyDefeatList = {}
	end
	if nil == data then
		return {hasElem = false, enemyDefeatList = enemyDefeatList}
	else
		return {hasElem = true, data = data, startPos = pos, endPos = pos, enemyDefeatList = enemyDefeatList}
	end
end

function WMBaseInfoController:getEnemyDefeatRangeListAt( pos )
	-- body
	local posList = {ccp(pos.x,pos.y)}
	-- for xadd = -1,1,1 do
	-- 	for yadd = -1,1,1 do
	-- 		--if xadd ~= 0 or yadd ~= 0 then
	-- 		posList[#posList + 1] = ccp(pos.x + xadd, pos.y + yadd)
	-- 		--end
	-- 	end
	-- end
	return posList
end

function WMBaseInfoController:setInfo(baseInfoList)
	--self:clearInfo()
	for _,worldBase in ipairs(baseInfoList) do
		print("XXXXXXXXXXX")
		dump(worldBase)
		self._baseTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( worldBase.worldPos ))] = worldBase
	end
	self:_setEnemyDefeatTable()
end

function WMBaseInfoController:updateMapElem(baseInfoList)
	for _,worldBase in ipairs(baseInfoList) do
		self._baseTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( worldBase.worldPos ))] = worldBase
	end
	self:_setEnemyDefeatTable()
end

function WMBaseInfoController:deleteMapElem( deleteBasePosList )
	-- body
	for _,worldDelete in ipairs(deleteBasePosList) do
		local key = WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( worldDelete.worldPos ))
		local info = self._baseTable[key]
		if nil ~= info and info.worldPlayerInfo.roleId == worldDelete.roleId then
			self._baseTable[key] = nil
		end
	end
	self:_setEnemyDefeatTable()
end

function WMBaseInfoController:_setEnemyDefeatTable(  )
	-- body
	do return end
	-- self._enemyDefeatTable = {}
	-- for key,worldBase in pairs(self._baseTable) do
	-- 	if worldBase.worldPlayerInfo.relationShip == 3 then
	-- 		local pos = WMInfoUilt:deserializePos( key )
	-- 		-- for xadd = -1,1,1 do
	-- 		-- 	for yadd = -1,1,1 do

	-- 				local defeatPos = ccp(pos.x, pos.y)--ccp(pos.x + xadd, pos.y + yadd)
	-- 				local defeatKey = WMInfoUilt:serializePos(defeatPos)
	-- 				if nil == self._enemyDefeatTable[defeatKey] then
	-- 					self._enemyDefeatTable[defeatKey] = {}
	-- 				end
	-- 				self._enemyDefeatTable[defeatKey][#self._enemyDefeatTable[defeatKey] + 1] = pos

	-- 		-- 	end
	-- 		-- end
	-- 	end
	-- end
end

function WMBaseInfoController:clearInfo(  )
	-- body
	self._baseTable = {}
	self._enemyDefeatTable = {}
end

return WMBaseInfoController