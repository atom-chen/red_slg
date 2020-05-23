--[[
	class:		WMGroundInfoController
	desc:
	author:		郑智敏
--]]

local WMGroundInfoController = class('WMGroundInfoController')

function WMGroundInfoController:ctor( model )
	-- body
	self._model = model
end

function WMGroundInfoController:init(  )
	-- body
	self:clearInfo()
end

function WMGroundInfoController:clearInfo()

end

function WMGroundInfoController:getInfoAt(pos)
	--local startPos = ccp(math.floor(pos.x/3)*3, math.floor(pos.y/2)*2)
	--local endPos = ccp(startPos.x + 2, startPos.y + 1)
	local startPos = pos
	local endPos = pos
	local mapSize = WorldMapCfg:getMapSize(  )
	if endPos.y < 0 or endPos.x < 0 or startPos.x >= mapSize.width or startPos.y >= mapSize.height then
		--print('endPos.y < 0 or endPos.x < 0 or startPos.x >= mapSize.width or startPos.y >= mapSize.height')
		return {hasElem = false}
	else
		--print('not endPos.y < 0 or endPos.x < 0 or startPos.x >= mapSize.width or startPos.y >= mapSize.height')
		return {hasElem = true, data = WorldMapCfg:getMapElemCfgAt( pos.x, pos.y ), startPos = startPos, endPos = endPos}
	end
end

return WMGroundInfoController