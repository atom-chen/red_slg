--[[
	class:		WMGroundPic
	desc:		野外地表图片
	author:		郑智敏
--]]
local WMElemBase = game_require('view.world.map.mapElem.WMElemBase')
local WMGroundPic = class('WMGroundPic', WMElemBase)

function WMGroundPic:ctor(map)
	WMElemBase.ctor(self, map)
	self._map = map

	map:getblockOriginNode():addChild(self,0)
	-- self:setAnchorPoint(ccp(0.5,0.5))
	print("aaaaaaaaaaaaa add ground")
	self._pic = display.newXSprite()
	self:addChild(self._pic)
	-- local size = self._map:getBlockSize()
	-- self:setContentSize(size)
	-- self._pic:setPosition(ccp(size.width/2 , size.height/2))

end

function WMGroundPic:updateInfo( info )
	-- body
	self:initInfo(info)
end

function WMGroundPic:initInfo( info )
	-- body

	self._pic:setVisible(true )
	self._info = info
	--self._pic:setSpriteImage(WorldMapCfg:getWMPicPath( self._info.data.resource ))
	if 1 == self._info.data.isSclaeX then
		self._pic:setScaleX(1)
	else
		self._pic:setScaleX(-1)
	end
	if 1 == self._info.data.isScaleY then
		self._pic:setScaleY(-1)
	else
		self._pic:setScaleY(1)
	end
	--[[
	self._pic:setRotation(90)
	local blockSize = self._map:getBlockSize()
	self._pic:setImageSize(ccsize(blockSize.height, blockSize.width))
	--]]

--	WMElemBase.initInfo(self, info)
end

function WMGroundPic:getBlockPosRange(  )
	-- body
	return ccp(self._info.startPos.x, self._info.startPos.y), ccp(self._info.endPos.x , self._info.endPos.y)
end

function WMGroundPic:clear()
	self._pic:setVisible(false)
end

function WMGroundPic:dispose(  )
	-- body
	-- print('WMGroundPic:dispose')
	WMElemBase.dispose(self)
end

return WMGroundPic