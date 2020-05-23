--[[
	class:		WMCommonChildElemControllerBase
	desc:
	author:		郑智敏
--]]

local WMChildElemControllerBase = game_require('view.world.map.mapElem.WMChildElemControllerBase')
local WMCommonChildElemControllerBase = class('WMCommonChildElemControllerBase', WMChildElemControllerBase)

function WMCommonChildElemControllerBase:ctor(map, elemClass, modelElemName)
	WMChildElemControllerBase.ctor(self, map)
	self._elemTable = {}
	self._recycleList = {}

	self._elemClass = elemClass
	self._modelElemName = modelElemName
	self.blockLeftDownPos = {x=-100,y=-100}
	self._timeAddCount = 1
end

function WMCommonChildElemControllerBase:setElems( moveVector,force )
	local blockLeftDownPos = self._map:getBlockMapRange()
	if not force then
		if math.abs(self.blockLeftDownPos.x - blockLeftDownPos.x) <= 1 and math.abs(self.blockLeftDownPos.y - blockLeftDownPos.y) <= 1 then
			return
		end
	end
	self.blockLeftDownPos = blockLeftDownPos
	self:_clearOutMapNodeElem()
	self:_setInMapNodeElem( moveVector )
end

function WMCommonChildElemControllerBase:updateElem(pos)
	local elem = self:getElemByPos(pos.x,pos.y)
	if elem then
		local info = WorldMapModel:getElemInfoAt( self._modelElemName, pos )
		if true == info.hasElem then
			elem:updateInfo(info)
		end
	end
end

function WMCommonChildElemControllerBase:_clearOutMapNodeElem()
	-- body
	--标记需要回收的elem
	-- local mapNodeLeftDownPos, mapNodeRightUpPos = self._map:getMapNodeRange()
	local needRecycleList = {}
	for keyString, elem in pairs(self._elemTable) do
		local recycleFlag = false
		--[[
		elemLeftDownPos,elemRightUpPos = elem:getRangePosAtMapNode(  )
		if elemLeftDownPos.x > mapNodeRightUpPos.x or elemLeftDownPos.y > mapNodeRightUpPos.y
			or elemRightUpPos.x < mapNodeLeftDownPos.x or elemRightUpPos.y < mapNodeLeftDownPos.y then
			recycleFlag = true
		end
		--]]
		local elemLeftDownBlockPos, elemRightUpBlockPos = elem:getBlockPosRange()
		if true == self._map:checkIsOutOfMapNode(elemLeftDownBlockPos, elemRightUpBlockPos) then
			recycleFlag = true
		else
			local info = self:_getInfoFromKeyString(keyString)
			if false == info.hasElem then
				recycleFlag = true
			end
		end

		if true == recycleFlag then
			needRecycleList[#needRecycleList + 1] = keyString
		end
	end

	-- local blockLeftDownPos, blockRightUpPos = self._map:getBlockMapRange()

	--标记需回收被标记的elem
	for _,keyString in ipairs(needRecycleList) do
		local elem = self._elemTable[keyString]
		elem:clear()
		--print('recycle ..')
		self._recycleList[#self._recycleList + 1] = elem

		self._elemTable[keyString] = nil
	end
end

function WMCommonChildElemControllerBase:_setInMapNodeElem(moveVector)

	self._addElemList = {}
	local blockLeftDownPos, blockRightUpPos = self._map:getBlockMapRange()
	for y = blockLeftDownPos.y , blockRightUpPos.y, 1 do
		for x = blockLeftDownPos.x , blockRightUpPos.x, 1 do
			local info = WorldMapModel:getElemInfoAt( self._modelElemName, ccp(x,y) )
			if true == info.hasElem then
				self._addElemList[#self._addElemList+1] = info
			end
		end
	end

	if not self._addTimer then
		self._addTimer = scheduler.scheduleGlobal(function()
			self:_timerAddElem()
		 end, 0.01)
	end
end

function WMCommonChildElemControllerBase:_timerAddElem()
	for i=1,self._timeAddCount do
		local info = table.remove(self._addElemList, #self._addElemList )
		if info then
			self:_setElemWithInfo( info )
		else
			if self._addTimer then
				scheduler.unscheduleGlobal(self._addTimer)
				self._addTimer = nil
				return
			end
		end
	end
end

function WMCommonChildElemControllerBase:addAllElemAtOnce()
	if self._addTimer then
		scheduler.unscheduleGlobal(self._addTimer)
		self._addTimer = nil
	end
	for i,info in ipairs(self._addElemList) do
		self:_setElemWithInfo( info )
	end
	self._addElemList = {}
end

function WMCommonChildElemControllerBase:_setElemWithInfo( info )
	-- body
	local elem = self._elemTable[self:_serializeToKeyString(info)]

	if nil == elem then
		--print('_createElemWithInfo')
		self:_createElemWithInfo(info)
	else
		--print('updateInfo')
		elem:updateInfo(info)
	end
end

function WMCommonChildElemControllerBase:_createElemWithInfo( info )
	-- body
	local keyString = self:_serializeToKeyString(info)
	local elem = nil

	if 0 >= #self._recycleList then
	 	elem = self._elemClass.new(self._map)
	else
		elem = self._recycleList[#self._recycleList]
		table.remove(self._recycleList)
	end

	elem:initInfo(info)
	local elemLeftDownBlockPos, elemRightUpBlockPos = elem:getBlockPosRange()
	local midPos = self._map:getMapPosAtMidOfBlockRange(elemLeftDownBlockPos, elemRightUpBlockPos)
	elem:setMapPosAtMidOfBlockRange(midPos)

	assert(nil == self._elemTable[keyString] )
	self._elemTable[keyString] = elem

	return elem
end

function WMCommonChildElemControllerBase:getElemTable()
	return self._elemTable
end

function WMCommonChildElemControllerBase:getElemByPos(x,y)
	local key = self:_toKeyString(x,y)
	return self._elemTable[key]
end

function WMCommonChildElemControllerBase:_toKeyString(x,y)
	return x ..',' .. y
end

function WMCommonChildElemControllerBase:_serializeToKeyString( info )
	-- body
	return self:_toKeyString(info.startPos.x,info.startPos.y)
end

function WMCommonChildElemControllerBase:_getInfoFromKeyString( key )
	-- body
	local commaIndex = string.find(key,',')
	local x = tonumber(string.sub(key,1,commaIndex - 1))
	local y = tonumber(string.sub(key,commaIndex + 1))
	return WorldMapModel:getElemInfoAt( self._modelElemName, ccp(x,y) )
end

function WMCommonChildElemControllerBase:dispose()
	-- body
	if self._addTimer then
		scheduler.unscheduleGlobal(self._addTimer)
		self._addTimer = nil
	end
	---print('midelname ..',self._modelElemName)
	for k,v in pairs(self._elemTable) do
		v:dispose()
	end
	for k,v in ipairs(self._recycleList) do
		v:dispose()
	end
end

return WMCommonChildElemControllerBase