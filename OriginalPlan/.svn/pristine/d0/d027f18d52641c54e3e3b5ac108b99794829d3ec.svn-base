
local WorldMapModel = class('WorldMapModel')

-----constants n configs----------------
WorldMapModel.GROUND = 'ground'
WorldMapModel.MINE = 'mine'
WorldMapModel.ARMY = 'army'
WorldMapModel.BASE = 'base'
WorldMapModel.MONSTER = 'monster'
WorldMapModel.MARCH = 'march'
WorldMapModel.SELECT = 'select'

WorldMapModel.ELEM_CONTROLLER_PATH_PREFIX = 'model.world.map.mapElemInfoControl.'
WorldMapModel.ELEM_CONTROLLER_PATH_TABLE = {
	[WorldMapModel.GROUND] = 'WMGroundInfoController',
	[WorldMapModel.MINE] = 'WMMineInfoController',
	[WorldMapModel.ARMY] = 'WMArmyInfoController',
	[WorldMapModel.BASE] = 'WMBaseInfoController',
	[WorldMapModel.MONSTER] = 'WMMonsterInfoController',
}
---------------------------------------

function WorldMapModel:ctor()
	-- body
	self._elemControllerTable = {}
	for name,path in pairs(self.ELEM_CONTROLLER_PATH_TABLE) do
		self._elemControllerTable[name] = game_require(self.ELEM_CONTROLLER_PATH_PREFIX .. path).new(self)
	end
end

function WorldMapModel:init()
	-- body
	for _,controller in pairs(self._elemControllerTable) do
		controller:init()
	end

	-- self.oreImage = {[1] = '#yw_icon_sj.png', [2]='#yw_icon_t.png',[3]='#yw_icon_y.png'}
	self:clearMapInfo()
end

function WorldMapModel:getMapSize(  )
	-- body
	return WildernessMapCfg:getMapSize(  )
end

function WorldMapModel:reqMapInfo( midPos )
	-- body
	WorldMapProxy:reqMapInfo(midPos)
end

function WorldMapModel:setMapInfo( msg )
	-- body
	print('WorldMapModel:setMapInfo')
	-- self._elemControllerTable[self.MINE]:setInfo(msg.mineList)
	-- self._elemControllerTable[self.ARMY]:setInfo(msg.armyList)
	self._elemControllerTable[self.BASE]:setInfo(msg.baseList)
	self._elemControllerTable[self.MONSTER]:setInfo(msg.monsterList)
	self._hasInfoFlag = true
	print('dispatchEvent Notify.WORLD_GET_MAP_INFO ..' .. Notify.WORLD_GET_MAP_INFO)
	NotifyCenter:dispatchEvent({name=Notify.WORLD_GET_MAP_INFO})
end

function WorldMapModel:updateMapElem( msg )
	-- body
	print('WorldMapModel:updateMapElem ..')
	NotifyCenter:dispatchEvent({name = Notify.WORLD_NEED_UPDATE_MAP_ELEM, msg = msg})
	self._elemControllerTable[self.MINE]:updateMapElem(msg.mineList)
	self._elemControllerTable[self.ARMY]:updateMapElem(msg.armyList)
	self._elemControllerTable[self.BASE]:updateMapElem(msg.baseList)
	self._elemControllerTable[self.MONSTER]:updateMapElem(msg.monsterList)
	NotifyCenter:dispatchEvent({name = Notify.WORLD_UPDATE_MAP_INFO})
end

function WorldMapModel:deleteMapElem( msg )
	-- body
	NotifyCenter:dispatchEvent({name = Notify.WORLD_NEED_DELETE_MAP_ELEM, msg = msg})
	self._elemControllerTable[self.MINE]:deleteMapElem(msg.deleteMinePosList)
	self._elemControllerTable[self.ARMY]:deleteMapElem(msg.deleteArmyPosList)
	self._elemControllerTable[self.BASE]:deleteMapElem(msg.deleteBasePosList)
	self._elemControllerTable[self.MONSTER]:deleteMapElem(msg.deleteMonsterPosList)
	NotifyCenter:dispatchEvent({name = Notify.WORLD_UPDATE_MAP_INFO})
end

function WorldMapModel:addMapElem( msg )
	-- body
	NotifyCenter:dispatchEvent({name = Notify.WORLD_NEED_ADD_MAP_ELEM, msg = msg})
	self._elemControllerTable[self.MINE]:updateMapElem(msg.mineList)
	self._elemControllerTable[self.ARMY]:updateMapElem(msg.armyList)
	self._elemControllerTable[self.BASE]:updateMapElem(msg.baseList)
	self._elemControllerTable[self.MONSTER]:updateMapElem(msg.monsterList)
	NotifyCenter:dispatchEvent({name = Notify.WORLD_UPDATE_MAP_INFO})
end

function WorldMapModel:getElemInfoAt( elemName, pos )
	-- body
	return self._elemControllerTable[elemName]:getInfoAt(pos)
end

function WorldMapModel:getAllElemInfoAt( pos )
	-- body
	local totalInfo = {}
	for elemName,controller in pairs(self._elemControllerTable) do
		totalInfo[elemName] = self._elemControllerTable[elemName]:getInfoAt(pos)
	end

	return totalInfo
end

function WorldMapModel:getElemInfoController( elemName )
	-- body
	return self._elemControllerTable[elemName]
end

function WorldMapModel:isElemInfoEmpty(pos)
	local allInfo = self:getAllElemInfoAt(pos)
	if allInfo then
		if 0 >= #(allInfo[WorldMapModel.ARMY].enemyDefeatList) and
					0 >= #(allInfo[WorldMapModel.BASE].enemyDefeatList) and
					false == allInfo[WorldMapModel.ARMY].hasElem and
					false == allInfo[WorldMapModel.BASE].hasElem and
					false == allInfo[WorldMapModel.MONSTER].hasElem and
					false == allInfo[WorldMapModel.MINE].hasElem then
			return true
		end
	end
	return false
end

function WorldMapModel:clearMapInfo(  )
	-- body
	self._hasInfoFlag = false
	WorldMapProxy:reqCloseMapInfo(  )
	for _,controller in pairs(self._elemControllerTable) do
		controller:clearInfo()
	end
end

return WorldMapModel.new()
