--[[
	class:		WMArmyController
	desc:
	author:		郑智敏
--]]

local WMCommonChildElemControllerBase = game_require('view.world.map.mapElem.WMCommonChildElemControllerBase')
local WMArmyController = class('WMArmyController', WMCommonChildElemControllerBase)

function WMArmyController:ctor( map )
	-- body
	WMCommonChildElemControllerBase.ctor(self, map, game_require('view.world.map.mapElem.army.WMArmyElemNode'),
		WorldMapModel.ARMY)
end

return WMArmyController