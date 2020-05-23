--[[
	class:		WMMonsterInfoController
	desc:
	author:		郑智敏
--]]
local WMInfoUilt = game_require('model.world.map.WMInfoUilt')
local WMMonsterInfoController = class('WMMonsterInfoController')

function WMMonsterInfoController:ctor( model )
	self._model = model
	self._monsterTable = {}
	self._monsterDefeatTable = {}
end

function WMMonsterInfoController:init()
	-- body
	self:clearInfo()
end

function WMMonsterInfoController:getInfoAt( pos )
	-- body
	local data = self._monsterTable[WMInfoUilt:serializePos(pos)]
	local enemyDefeatList = self._monsterDefeatTable[WMInfoUilt:serializePos(pos)]
	if nil == enemyDefeatList then
		enemyDefeatList = {}
	end
	if nil == data then
		return {hasElem = false, enemyDefeatList = enemyDefeatList}
	else
		return {hasElem = true, data = data, startPos = pos, endPos = pos, enemyDefeatList = enemyDefeatList}
	end
end

function WMMonsterInfoController:getEnemyDefeatRangeListAt( pos )
	-- body
	local posList = {}
	for xadd = -1,1,1 do
		for yadd = -1,1,1 do
			if xadd ~= 0 or yadd ~= 0 then
				posList[#posList + 1] = ccp(pos.x + xadd, pos.y + yadd)
			end
		end
	end
	return posList
end

function WMMonsterInfoController:setInfo( monsterInfoList )
	for _,worldMonster in ipairs(monsterInfoList) do
		self._monsterTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( worldMonster.worldPos ))] = worldMonster
	end
	self:_setMonsterDefeatTable()
end

function WMMonsterInfoController:updateMapElem( monsterInfoList )
	for _,worldMonster in ipairs(monsterInfoList) do
		self._monsterTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( worldMonster.worldPos ))] = worldMonster
	end
	self:_setMonsterDefeatTable()
end

function WMMonsterInfoController:deleteMapElem( deleteMonsterPosList )
	-- body
	for _,worldDelete in ipairs(deleteMonsterPosList) do
		local key = WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( worldDelete.worldPos ))
		local info = self._monsterTable[key]
		if nil ~= info and info.monsterID == worldDelete.roleId then
			self._monsterTable[key] = nil
		end
	end
	self:_setMonsterDefeatTable()
end

function WMMonsterInfoController:_setMonsterDefeatTable(  )
	-- body
	do return end

	self._monsterDefeatTable = {}
	for key,worldMonster in pairs(self._monsterTable) do
		local pos = WMInfoUilt:deserializePos( key )
		for xadd = -1,1,1 do
			for yadd = -1,1,1 do

				local defeatPos = ccp(pos.x + xadd, pos.y + yadd)
				local defeatKey = WMInfoUilt:serializePos(defeatPos)
				if nil == self._monsterDefeatTable[defeatKey] then
					self._monsterDefeatTable[defeatKey] = {}
				end
				self._monsterDefeatTable[defeatKey][#self._monsterDefeatTable[defeatKey] + 1] = pos
			end
		end
	end
end

function WMMonsterInfoController:clearInfo()
	-- body
	self._monsterTable = {}
end

return WMMonsterInfoController