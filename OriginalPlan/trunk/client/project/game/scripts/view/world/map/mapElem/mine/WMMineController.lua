--[[
	class:		WMMineController
	desc:		野外地图矿产控制器
	author:		郑智敏
--]]

local WMCommonChildElemControllerBase = game_require('view.world.map.mapElem.WMCommonChildElemControllerBase')
local WMMineController = class('WMMineController', WMCommonChildElemControllerBase)

function WMMineController:ctor( map )
	-- body
	WMCommonChildElemControllerBase.ctor(self, map, game_require('view.world.map.mapElem.mine.WMMineElemNode'),
		WorldMapModel.MINE)
	self._lvShowFlag = false
	self._timeAddCount = 3
end

function WMMineController:setMineLvShow( flag )
	-- body
	self._lvShowFlag = flag
	for _,v in pairs(self._elemTable) do
		v:setMineLvShow(flag)
	end
end

function WMMineController:_setElemWithInfo( info )
	-- body
	WMCommonChildElemControllerBase._setElemWithInfo(self, info)
	local elem = self._elemTable[self:_serializeToKeyString(info)]
	elem:setMineLvShow(self._lvShowFlag)
end

return WMMineController