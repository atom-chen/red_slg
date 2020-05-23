
local WorldMapCfg = class('WorldMapCfg')

function WorldMapCfg:ctor()
	-- body
end

function WorldMapCfg:init()
	-- body
	self._resourceCfg = ConfigMgr:requestConfig("world_map_resource", nil, true)
	self._worldMapElemCfg = ConfigMgr:requestConfig('world_map_block_elem', nil, true)
	self._worldMapCfg = ConfigMgr:requestConfig('world_map_config',nil,true)
	self:_initMapBlockElemCfg()
end

function WorldMapCfg:_initMapBlockElemCfg()
	-- body
	local originMapBlockElemCfg = ConfigMgr:requestConfig('world_map_block',nil, true)
	self._mapBlockElemCfg = {}
	for index,v in pairs(originMapBlockElemCfg) do
		local cfg = {}
		local data = v.data
		for index,mapElemIndex in ipairs(data) do
			cfg[index] = mapElemIndex
		end
		self._mapBlockElemCfg[index] = cfg
	end
end

function WorldMapCfg:getMapElemOrg(x, y)
	local mapBlockWidthLength = 4*3
	local mapBlockHeigthLength = 4*3

	local widthIndex = math.modf(x/mapBlockWidthLength)
	local heightIndex = math.modf(y/mapBlockHeigthLength)

	return widthIndex*mapBlockWidthLength, heightIndex*mapBlockHeigthLength;
end

function WorldMapCfg:getMapElemCfgAt( x, y )
	-- body
	local mapBlockWidthLength = 12
	local mapBlockHeigthLength = 12
	local mapSize = self:getMapSize()
	local widthMapBlockNum = mapSize.width/ mapBlockWidthLength
	--local heightMapBlockNum = mapSize.height/ mapBlockHeigthLength
	local widthIndex = math.modf(x/mapBlockWidthLength)
	local heightIndex = math.modf(y/mapBlockHeigthLength)
	-- print('heightIndex * widthMapBlockNum + widthIndex + 1 ..' .. heightIndex * widthMapBlockNum + widthIndex + 1)
	-- print('self._worldMapCfg[heightIndex * widthMapBlockNum + widthIndex + 1 ].mapIndex ..' .. self._worldMapCfg[heightIndex * widthMapBlockNum + widthIndex + 1 ].mapIndex)

	local mapBlockElemCfg = self._mapBlockElemCfg[ self._worldMapCfg[heightIndex * widthMapBlockNum + widthIndex + 1 ].mapIndex ]

	-- if not mapBlockElemCfg then
	-- 	mapBlockElemCfg = self._mapBlockElemCfg[1]
	-- end
	--print('(x - widthIndex * mapBlockWidthLength) ..' .. (x - widthIndex * mapBlockWidthLength) )
	--print('(y - heightIndex * mapBlockHeigthLength) ..' .. (y - heightIndex * mapBlockHeigthLength) )
	--print('(x - widthIndex * mapBlockWidthLength) + (y - heightIndex * mapBlockHeigthLength) * mapBlockWidthLength + 1  ..' .. (x - widthIndex * mapBlockWidthLength) + (y - heightIndex * mapBlockHeigthLength) * mapBlockWidthLength + 1 )

	--print('mapBlockElemCfg[(x - widthIndex * mapBlockWidthLength) + (y - heightIndex * mapBlockHeigthLength) * mapBlockWidthLength + 1 ] ..' .. mapBlockElemCfg[(x - widthIndex * mapBlockWidthLength) + (y - heightIndex * mapBlockHeigthLength) * mapBlockWidthLength + 1 ])
	return self._worldMapElemCfg[mapBlockElemCfg[(x - widthIndex * mapBlockWidthLength) + (y - heightIndex * mapBlockHeigthLength) * mapBlockWidthLength + 1 ]]
end

function WorldMapCfg:getWMPicPath( index )
	-- body
	return '#' .. self._resourceCfg[index].picName .. '.png'
end

local MAP_SIZE = ccsize(384,384)
function WorldMapCfg:getMapSize(  )
	-- body
	return MAP_SIZE
end

return WorldMapCfg.new()