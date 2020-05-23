--[[
	class:	WMMonsterController
	desc
	author:	郑智敏
--]]
local WMCommonChildElemControllerBase = game_require('view.world.map.mapElem.WMCommonChildElemControllerBase')
local WMMonsterController = class('WMMonsterController', WMCommonChildElemControllerBase)

function WMMonsterController:ctor( map )
	-- body
	WMCommonChildElemControllerBase.ctor(self, map, game_require('view.world.map.mapElem.monster.WMMonsterElemNode'),
		WorldMapModel.MONSTER)
end

return WMMonsterController