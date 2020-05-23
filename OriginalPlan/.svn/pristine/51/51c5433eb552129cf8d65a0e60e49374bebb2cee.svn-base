--[[
	class:		WMArmyInfoController
	desc:		野外军队信息控制器
	author:		郑智敏
--]]
local WMInfoUilt = game_require('model.world.map.WMInfoUilt')
local WMArmyInfoController = class('WMArmyInfoController')

function WMArmyInfoController:ctor( model )
	-- body
	self._model = model
	self._armyTable = {}
	self._enemyDefeatTable = {}
end

function WMArmyInfoController:init()
	-- body
	self:clearInfo()
end

function WMArmyInfoController:getInfoAt( pos )
	-- body
	local data = self._armyTable[WMInfoUilt:serializePos(pos)]
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

function WMArmyInfoController:getEnemyDefeatRangeListAt( pos )
	-- body
	local posList = {}
	for xadd = -1,1,1 do
		for yadd = -1,1,1 do
			--if xadd ~= 0 or yadd ~= 0 then
			posList[#posList + 1] = ccp(pos.x + xadd, pos.y + yadd)
			--end
		end
	end
	return posList
end

function WMArmyInfoController:setInfo(armyInfoList)
	--self:clearInfo()
	if not self._timer then
		self._timer = scheduler.scheduleGlobal(function() self:_armyAct() end, 1)
	end
	for _,worldArmy in ipairs(armyInfoList) do
		self._armyTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( worldArmy.worldPos ))] = worldArmy
	end
	self:_setEnemyDefeatTable()
end

function WMArmyInfoController:updateMapElem(armyInfoList)
	if not self._timer then
		self._timer = scheduler.scheduleGlobal(function() self:_armyAct() end, 1)
	end
	for _,worldArmy in ipairs(armyInfoList) do
		self._armyTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( worldArmy.worldPos ))] = worldArmy
	end
	self:_setEnemyDefeatTable()
end

function WMArmyInfoController:deleteMapElem( deleteArmyPosList )
	-- body
	for _,worldDelete in ipairs(deleteArmyPosList) do
		local key = WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( worldDelete.worldPos ))
		local info = self._armyTable[key]
		if nil ~= info and info.worldPlayerInfo.roleId == worldDelete.roleId then
			self._armyTable[key] = nil
		end
	end
	self:_setEnemyDefeatTable()
end

function WMArmyInfoController:_setEnemyDefeatTable(  )
	-- body
	self._enemyDefeatTable = {}
	for key,worldArmy in pairs(self._armyTable) do
		if worldArmy.worldPlayerInfo.relationShip == 3 then
			local pos = WMInfoUilt:deserializePos( key )
			for xadd = -1,1,1 do
				for yadd = -1,1,1 do

					local defeatPos = ccp(pos.x + xadd, pos.y + yadd)
					local defeatKey = WMInfoUilt:serializePos(defeatPos)
					if nil == self._enemyDefeatTable[defeatKey] then
						self._enemyDefeatTable[defeatKey] = {}
					end
					self._enemyDefeatTable[defeatKey][#self._enemyDefeatTable[defeatKey] + 1] = pos

				end
			end
		end
	end
end

--[[
function WMArmyInfoController:_setArmyJoint(  )
	-- body
	local jointTable = {}
	for key, worldArmy in pairs(self._armyTable) do
		local armyPos = WMInfoUilt:deserializePos( key )
		for _, worldMiningInfo in ipairs(worldArmy.miningInfoList) do
			local miningPos = WMInfoUilt:changeWildernessPosToPos( worldMiningInfo.worldPos )
			if miningPos.x ~= armyPos.x or miningPos.y ~= armyPos.y then
				local jointKey = WMInfoUilt:serializePos(miningPos)
				if nil == jointTable[jointKey] then
					jointTable[jointKey] = {}
				end
				jointTable[jointKey][#jointTable[jointKey] + 1] = worldArmy
			end
		end
	end

	self._model:getElemInfoController:( WorldMapModel.MINE ):setJointInfo(jointTable)
end
--]]

function WMArmyInfoController:_armyAct()
	--print('armyAct')
	local timeStamp = TimeCenter:getTimeStamp()
	local changeFlag = false
	local deleteKeyList = {}
	for key,v in pairs(self._armyTable) do
		-- print('v.returnTime ..' .. v.returnTime .. ' timeStamp ..' .. timeStamp)
		if timeStamp >= v.returnTime and 0 < v.returnTime then
			deleteKeyList[#deleteKeyList + 1] = key
			changeFlag = true
		end
		for _,miningInfo in ipairs(v.miningInfoList) do
			if true == self._model:getElemInfoController( WorldMapModel.MINE ):armyMining( miningInfo ) then
				changeFlag = true
			end
		end
	end

	for _,key in ipairs(deleteKeyList) do
		self._armyTable[key] = nil
	end
	if true == changeFlag then
		self:_setEnemyDefeatTable()
		NotifyCenter:dispatchEvent({name = Notify.WORLD_UPDATE_MAP_INFO})
	end
end

function WMArmyInfoController:clearInfo(  )
	-- body
	if self._timer then
		scheduler.unscheduleGlobal(self._timer)
		self._timer = nil
	end
	self._armyTable = {}
	self._enemyDefeatTable = {}
end

return WMArmyInfoController