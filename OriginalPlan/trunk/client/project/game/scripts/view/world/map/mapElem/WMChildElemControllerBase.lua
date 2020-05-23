--[[
	class:		WMChildElemControllerBase
	desc:
	author:		郑智敏
--]]

local WMChildElemControllerBase = class('WMChildElemControllerBase')

function WMChildElemControllerBase:ctor( map )
	self._map = map
end

function WMChildElemControllerBase:setElems( moveVector,force )

end

function WMChildElemControllerBase:updateElem(pos)

end

function WMChildElemControllerBase:dispose(  )
	-- body
end

return WMChildElemControllerBase