--[[
	class:		WorldMapProxy
	desc:		野外地图proxy
	author:		郑智敏
--]]

local WorldMapProxy = {}

function WorldMapProxy:init(  )
	-- body
	local msgHandleList = {
					-- [MsgType.WORLD_REQ_MAP_INFO] = self._resGetMapInfo,
					-- [MsgType.WORLD_MAP_ELEM_UPDATE] = self._resMapElemUpdate,
					-- [MsgType.WORLD_MAP_ELEM_DELETE] = self._resMapElemDelete,
					-- [MsgType.WORLD_MAP_ELEM_ADD] = self._resMapElemAdd,
					}
	NetCenter:addMsgHandlerList(self,msgHandleList)
end

function WorldMapProxy:reqMapInfo( pos )
	-- body
	--NetCenter:send(MsgType.WORLD_REQ_MAP_INFO, {x = pos.x, y = pos.y})
	WorldMapProxy:_resGetMapInfo()
end

function WorldMapProxy:_resGetMapInfo( event )
	local baseList = GetDemoTown()
	local monsterList = GetDemoMonster()
	WorldMapModel:setMapInfo({
		baseList = baseList,
		monsterList=monsterList,
	})
end

function WorldMapProxy:_resMapElemUpdate( event )
	-- body
	WorldMapModel:updateMapElem(event.msg)
end

function WorldMapProxy:_resMapElemDelete( event )
	-- body
	WorldMapModel:deleteMapElem(event.msg)
end

function WorldMapProxy:_resMapElemAdd( event )
	-- body
	WorldMapModel:addMapElem(event.msg)
end

function WorldMapProxy:reqCloseMapInfo(  )
	-- body
	--NetCenter:send(MsgType.WORLD_REQ_CLOSE_MAP_INFO)
end


function WorldMapProxy:reqMinMapInfo(  )
	NetCenter:send(MsgType.WORLD_MINI_MAP)
end

return WorldMapProxy
