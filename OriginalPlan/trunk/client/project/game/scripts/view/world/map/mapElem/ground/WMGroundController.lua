--[[
	class:		WMGroundController
	desc:		野外地表元素控制器
	author:		郑智敏
--]]
local WMCommonChildElemControllerBase = game_require('view.world.map.mapElem.WMCommonChildElemControllerBase')
local WMGroundController = class('WMGroundController', WMCommonChildElemControllerBase)

function WMGroundController:ctor( map )
	WMCommonChildElemControllerBase.ctor(self, map, game_require('view.world.map.mapElem.ground.WMGroundPic'),
		WorldMapModel.GROUND)

--	self.groundBgs = {}
	self.allBgs = {}

	self:initBgs()
end

function WMGroundController:initBgs()
	for k=1,8 do
		local bg = display.newXSprite("ui/worldMap/02.png");
		self.allBgs[k] = {bg=bg,use=false};
		bg:retain()
	end
end

function WMGroundController:getBg()
	for k=1,8 do
		if self.allBgs[k].use == false then
			self.allBgs[k].use = true
			return self.allBgs[k].bg
		end
	end

	return nil;
end

function WMGroundController:unuseAllBgs()
	for k=1,8 do
		if self.allBgs[k].bg:getParent() then
			self.allBgs[k].bg:removeFromParent()
		end
		self.allBgs[k].bg:release()
	end
end

function WMGroundController:setAllunuse()
	for k=1,8 do
		self.allBgs[k].use = false
		if self.allBgs[k].bg:getParent() then
			self.allBgs[k].bg:removeFromParent()
		end
	end
end

function WMGroundController:initBg(res)
	if self.bg == nil then
		self.bg= display.newNode()
	end
	self.bgWidth = 0
	self.bgHeight = 0
	self.bgRes = {}
	local imgH= 0
	local posW = 0
	local posH = 0
	for k1,v1 in ipairs(res) do
		posW = 0
		if not self.bgRes[k1] then
			self.bgRes[k1] = {}
		end
		for k2,v2 in pairs(v1) do
			local img = nil
			if not self.bgRes[k1][k2] then
				img= display.newXSprite()
				self.bgRes[k1][k2]=img
				img:setAnchorPoint(ccp(0,0))
				self.bg:addChild(img)
			else
				img= self.bgRes[k1][k2]
			end
			img:setSpriteImage("fightMap/"..v2..".w")
			img:setPosition(posW,posH)
			local imageSize = img:getContentSize()
			if k1 == 1 then
				self.bgWidth = self.bgWidth + imageSize.width
				imgH = imageSize.height
			end
			posW = posW + imageSize.width
		end
		self.bgHeight = self.bgHeight + imgH
		posH = self.bgHeight
	end
	self.bg:setContentSize(CCSize(self.bgHeight, self.bgHeight))
	self.bg:setAnchorPoint(ccp(0,0))
	self:addChild(self.bg)
end

function WMGroundController:_setInMapNodeElem(moveVector)
	local groundOgrs = {}

	self:setAllunuse()

	local blockLeftDownPos, blockRightUpPos = self._map:getBlockMapRange()
	for y = blockLeftDownPos.y , blockRightUpPos.y, 1 do
		for x = blockLeftDownPos.x , blockRightUpPos.x, 1 do
			local info = WorldMapModel:getElemInfoAt( self._modelElemName, ccp(x,y) )
			if true == info.hasElem then
				self:_setElemWithInfo( info )
			end

			if x >= 0 and y >= 0 then
				local bx, by = WorldMapCfg:getMapElemOrg( x, y )
				groundOgrs[bx..","..by] = {bx,by}
			end
		end
	end

	for k,v in pairs(groundOgrs) do
		--if self.groundBgs[k] == nil then
			--local bg = display.newXSprite("ui/worldMap/02.png");
			--bg:retain()
			local bg = self:getBg();
			if bg ~= nil then
				--self.groundBgs[k] = bg
				bg:setAnchorPoint(ccp(0.5, 1/24))

				local elemLeftDownBlockPos, elemRightUpBlockPos = ccp(v[1],v[2]), ccp(v[1],v[2])
				local midPos = self._map:getMapPosAtMidOfBlockRange(elemLeftDownBlockPos, elemRightUpBlockPos)
				local originNode = self._map:getblockOriginNode()
				local originNodeX, originNodeY = originNode:getPosition()
				midPos.x = midPos.x - originNodeX
				midPos.y = midPos.y - originNodeY

				bg:setPosition(midPos)
				self._map:getblockOriginNode():addChild(bg, -1)
			else
				assert(false)
			end
		--end
	end

--	local rr = {}
--	for k,v in pairs(self.groundBgs) do
--		if groundOgrs[k] == nil then
--			v:removeFromParent()
--			v:release()
--			table.insert(rr, k)
--		end
--	end
--	for k,v in ipairs(rr) do
--		self.groundBgs[v] = nil
--	end
end

--[[
function WMGroundController:ctor( map )
	WMChildElemControllerBase.ctor(self, map)
	self._elemTable = {}
	self._recycleList = {}

	self._elemClass = game_require('view.world.map.mapElem.ground.WMGroundPic')
end

function WMGroundController:setElems( moveVector )
	self:_setInMapNodeElem( moveVector )
	self:_clearOutMapNodeElem()
end

function WMGroundController:_clearOutMapNodeElem(  )
	-- body
	--标记需要回收的elem
	local mapNodeLeftDownPos, mapNodeRightUpPos = self._map:getMapNodeRange()
	local needRecycleList = {}
	for keyString, elem in pairs(self._elemTable) do
		local recycleFlag = false
		local elemX, elemY = elem:getPosition()
		local an = elem:getAnchorPoint()
		local elemSize = elem:getContentSize()
		local elemLeftDownPos = ccp(elemX - an.x * elemSize.width, elemY - an.y * elemSize.height )
		local elemRightUpPos = ccp(elemX + (1 - an.x) * elemSize.width, elemY + (1 - an.y) * elemSize.height )
		if elemLeftDownPos.x >= mapNodeRightUpPos.x or elemLeftDownPos.y >= mapNodeRightUpPos.y
			or elemRightUpPos.x <= mapNodeLeftDownPos.x or elemRightUpPos.y <= mapNodeLeftDownPos.y then

			recycleFlag = true

		end
		local elemLeftDownBlockPos, elemRightUpBlockPos = elem:getBlockPosRange()
		if true == self._map:checkIsOutOfMapNode(elemLeftDownBlockPos, elemRightUpBlockPos) then
			recycleFlag = true
		end

		if true == recycleFlag then
			needRecycleList[#needRecycleList + 1] = keyString
		end
	end
	--标记需回收被标记的elem
	for _,keyString in ipairs(needRecycleList) do
		local elem = self._elemTable[keyString]
		elem:clear()
		--print('recycle ..')
		self._recycleList[#self._recycleList + 1] = elem

		self._elemTable[keyString] = nil
	end
end

function WMGroundController:_setInMapNodeElem( moveVector )
	-- body
	for keyString, elem in pairs(self._elemTable) do
		local elemX , elemY = elem:getPosition()
		elem:setPosition(ccp(elemX + moveVector.x, elemY + moveVector.y))
	end

	local blockLeftDownPos, blockRightUpPos = self._map:getBlockMapRange()
	for y = blockLeftDownPos.y , blockRightUpPos.y, 1 do
		for x = blockLeftDownPos.x , blockRightUpPos.x, 1 do
			self:_setElemAt(ccp(x,y))
		end
	end
end

function WMGroundController:_setElemAt( blockPos )
	-- body
	local elem = self._elemTable[self:_serializeToKeyString(blockPos)]

	if nil == elem then
		self:_createElemAt(blockPos)
	end
end

function WMGroundController:_createElemAt( blockPos )
	-- body
	local keyString = self:_serializeToKeyString(blockPos)
	local elem = nil

	if 0 >= #self._recycleList then
		-------test---------------------------
		if nil == self._newCount then
			self._newCount = 0
		end
		self._newCount = self._newCount + 1
		print('new .. ' .. self._newCount)
		--------------------------------------
	 	elem = self._elemClass.new(self._map)
	else
		elem = self._recycleList[#self._recycleList]
		table.remove(self._recycleList)
	end

	elem:setInfo(blockPos)
	local elemLeftDownBlockPos, elemRightUpBlockPos = elem:getBlockPosRange()
	local midPos = self._map:getMapPosAtMidOfBlockRange(elemLeftDownBlockPos, elemRightUpBlockPos)
	elem:setPosition(midPos)

	assert(nil == self._elemTable[keyString] )
	self._elemTable[keyString] = elem

	return elem
end

function WMGroundController:_serializeToKeyString( blockPos )
	-- body
	local leftDownBlockX = math.floor(blockPos.x/3)*3
	local leftDownBlockY = math.floor(blockPos.y/2)*2

	return leftDownBlockX ..',' .. leftDownBlockY
end

--]]

function WMGroundController:dispose(  )
	-- body
	for k,v in pairs(self._elemTable) do
		v:dispose()
	end
	for k,v in ipairs(self._recycleList) do
		v:dispose()
	end
	self:unuseAllBgs()
end


return WMGroundController