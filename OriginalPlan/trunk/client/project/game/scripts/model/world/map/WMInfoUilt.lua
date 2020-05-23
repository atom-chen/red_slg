--[[
	class:		WMInfoUilt
	desc:		野外地图信息处理通用类
	author:		郑智敏
--]]

local WMInfoUilt = {}

function WMInfoUilt:serializePos( pos )
	-- body
	return pos.x .. ',' .. pos.y
end

function WMInfoUilt:deserializePos( key )
	-- body
	local commaIndex = string.find(key,',')
	local x = tonumber(string.sub(key,1,commaIndex - 1))
	local y = tonumber(string.sub(key,commaIndex + 1))
	return ccp(x,y)
end

function WMInfoUilt:changeWildernessPosToPos( wildernessPos )
	-- body
	return ccp(wildernessPos.x, wildernessPos.y)
end

return WMInfoUilt