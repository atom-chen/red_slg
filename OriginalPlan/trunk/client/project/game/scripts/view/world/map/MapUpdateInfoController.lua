
local MapUpdateInfoController = class('MapUpdateInfoController')

function MapUpdateInfoController:ctor( map )
	-- body
	self._map = map
	self._midPosChangeFlag = false
end

function MapUpdateInfoController:setMidPos( pos )
	-- body
	self._midPos = pos
	WorldMapModel:reqMapInfo( self._midPos )
end

function MapUpdateInfoController:move( moveVector )
	-- body
	local leftDownPos, rightUpPos = self._map:getMapNodeRange(  )
	local mapMidPos = ccp(leftDownPos.x + (rightUpPos.x - leftDownPos.x)/2, leftDownPos.y + (rightUpPos.y - leftDownPos.y)/2)
	local blockMidPos = self._map:getBlockPosFromMapNodePos( mapMidPos , true )
	local mapSize = WorldMapCfg:getMapSize(  )
	if ( self._midPos.x ~= blockMidPos.x or self._midPos.y ~= blockMidPos.y )
		and  (blockMidPos.y >= 0 and blockMidPos.x >= 0 and blockMidPos.x < mapSize.width and blockMidPos.y < mapSize.height ) then
		self._midPosChangeFlag = true
		self._midPos = blockMidPos

	end

	NotifyCenter:dispatchEvent({name = Notify.WORLD_SET_NOWPOS, x = blockMidPos.x, y=blockMidPos.y})
end

function MapUpdateInfoController:getMidPos()
	-- body
	return self._midPos
end

function MapUpdateInfoController:moveEnd(  )
	-- body
	if true == self._midPosChangeFlag then
		-- WorldMapProxy:reqMapInfo( self._midPos )
		self._midPosChangeFlag = false
	end
end

function MapUpdateInfoController:dispose(  )
	-- body
end

return MapUpdateInfoController