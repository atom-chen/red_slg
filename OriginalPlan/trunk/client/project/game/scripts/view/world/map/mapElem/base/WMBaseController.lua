--[[
	class:		WMBaseController
	desc:
	author:		郑智敏
--]]
local WMCommonChildElemControllerBase = game_require('view.world.map.mapElem.WMCommonChildElemControllerBase')
local WMBaseController = class('WMBaseController', WMCommonChildElemControllerBase)

function WMBaseController:ctor( map )
	-- body
	WMCommonChildElemControllerBase.ctor(self, map, game_require('view.world.map.mapElem.base.WMBaseElemNode'),
		WorldMapModel.BASE)
end

return WMBaseController