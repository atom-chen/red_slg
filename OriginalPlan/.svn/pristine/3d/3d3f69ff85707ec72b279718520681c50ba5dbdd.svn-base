--[[
	class:		WMElemBase
	desc:
	author:		郑智敏
--]]

local WMElemBase = class('WMElemBase', function() return display.newNode() end)

function WMElemBase:ctor(map)
	self._map = map
	self.tip = UIText.new(150, 50, 16, nil, UIInfo.color.green, UIInfo.alignment.center, UIInfo.alignment.center, true, false, true)
	self.tip:setAnchorPoint(ccp(0.5,0.5))
	self:addChild(self.tip,100)
	self:retain()
end

function WMElemBase:updateInfo( info )
	-- body
end

function WMElemBase:initInfo( info )
	if self.tip then
		self.tip:setText(string.format("(%.0f,%.0f)",info.startPos.x,info.startPos.y))
	end
end

function WMElemBase:getBlockPosRange(  )
	-- body
	return ccp(0,0), ccp(0,0)
end

function WMElemBase:clear()
end

function WMElemBase:getRangePosAtMapNode()
	-- body
	local selfX, selfY = self:getPosition()
	local an = self:getAnchorPoint()
	local selfSize = self:getContentSize()
	local selfLeftDownPos = ccp(selfX - an.x * selfSize.width, selfY - an.y * selfSize.height )
	local selfRightUpPos = ccp(selfX + (1 - an.x) * selfSize.width, selfY + (1 - an.y) * selfSize.height )

	local originNode = self._map:getblockOriginNode()
	local originNodeX, originNodeY = originNode:getPosition()
	selfLeftDownPos.x = selfLeftDownPos.x + originNodeX
	selfLeftDownPos.y = selfLeftDownPos.y + originNodeY
	selfRightUpPos.x = selfRightUpPos.x + originNodeX
	selfRightUpPos.y = selfRightUpPos.y + originNodeY

	return selfLeftDownPos, selfRightUpPos
end

function WMElemBase:setMapPosAtMidOfBlockRange( midPos )
	-- body
	local originNode = self._map:getblockOriginNode()
	local originNodeX, originNodeY = originNode:getPosition()
	midPos.x = midPos.x - originNodeX
	midPos.y = midPos.y - originNodeY

	self:setPosition(midPos)
end

function WMElemBase:dispose()
	-- body
	if self.tip then
		self.tip:dispose()
	end
	self:removeFromParent()
	self:release()
end

return WMElemBase