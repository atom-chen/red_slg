
local WorldMap = game_require('view.world.map.WorldMap')
local WorldModel = game_require('model.world.WorldModel')
local WorldPanel = class('WorldPanel', PanelProtocol)

function WorldPanel:_initUI()
	self:_loadResource()
	self:initUINode("world_panel")
end

function WorldPanel:_loadResource()
	if true ~= self._loadFlag then
		ResMgr:loadPvr('ui/town/town.pvr.ccz')
		ResMgr:loadPvr('ui/world/world.pvr.ccz')
		ResMgr:loadPvr('ui/worldMap/worldMap.pvr.ccz')
		ResMgr:loadPvr('ui/worldHero/worldHero.pvr.ccz')
		self._loadFlag = true
	end
end

function WorldPanel:_unloadResource()
	-- body
	if true == self._loadFlag then
		ResMgr:unload('ui/town/town.pvr.ccz')
		ResMgr:unload('ui/world/world.pvr.ccz')
		ResMgr:unload('ui/worldMap/worldMap.pvr.ccz')
		ResMgr:unload('ui/worldHero/worldHero.pvr.ccz')
		self._loadFlag = false
	end
end

function WorldPanel:checkOpen()
    return true
end

function WorldPanel:_initBaseInfo()
	if not self._map then
		self._map = WorldMap.new(ccsize(display.width, display.height), self)
		self._map:setAnchorPoint(ccp(0,0))
		self:addChild(self._map, -1)
		self._map:setMidMapBlockPos(ccp(self._startX, self._startY))
		self._map:initMapData()
	end
end

function WorldPanel:getMapNodePosFromBlockPos(pos)
	return self._map:getMapNodePosFromBlockPos(pos)
end

function WorldPanel:preOpen(params)
	self._startX,self._startY = 114,111
	--self._startX,self._startY = 0,0

	self:_loadResource()
	self:_initBaseInfo()

	self._buttomMenu = ViewMgr:open(Panel.WORLD_BUTTOM_MENU)
end

function WorldPanel:onOpened()
	local info = {}
	info.x = self._startX
	info.y = self._startY
	info.free_transfer = 0
	info.protect_time = 0
	info.transfer_cd = 0
	WorldModel:initBaseInfo(info,{})

	self._buttomMenu:setBasePos(self._startX,self._startY)
end

function WorldPanel:onCloseed()
	ViewMgr:close(Panel.WORLD_BUTTOM_MENU)

    self:_unloadResource()
	self._map:dispose()
	self._map = nil
end

function WorldPanel:isShowMark( )
    return false
end

return WorldPanel