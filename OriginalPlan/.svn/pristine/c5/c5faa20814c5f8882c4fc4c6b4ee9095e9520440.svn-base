
local WorldElemController = class('WorldElemController')

-----constants n configs---------------
WorldElemController.CHILD_CONTROLLER_LIST = {
	[WorldMapModel.GROUND] = {
		classPath = 'view.world.map.mapElem.ground.WMGroundController',
	},

	[WorldMapModel.MINE] = {
		classPath = 'view.world.map.mapElem.mine.WMMineController',
	},
	[WorldMapModel.ARMY] = {
		classPath = 'view.world.map.mapElem.army.WMArmyController',
	},
	[WorldMapModel.BASE] = {
		classPath = 'view.world.map.mapElem.base.WMBaseController',
	},
	[WorldMapModel.MONSTER] = {
		classPath = 'view.world.map.mapElem.monster.WMMonsterController',
	},
	[WorldMapModel.SELECT] = {
		classPath = 'view.world.map.mapElem.select.WMSelectController',
	},
}
--------------------------------------

function WorldElemController:ctor(map)
	self._map = map
	self._childControllerTable = {}
	for k,v in pairs(self.CHILD_CONTROLLER_LIST) do
		elem = {}
		elem._controller = game_require(v.classPath).new(self._map)
		self._childControllerTable[k] = elem
	end
	NotifyCenter:addEventListener(Notify.WORLD_GET_MAP_INFO, {self, self._updateElems})
	NotifyCenter:addEventListener(Notify.WORLD_UPDATE_MAP_INFO, {self, self._updateElems})
	--NotifyCenter:addEventListener(Notify.NEW_GUIDE, {self, self._newGuide})
	--self:_initGuide()

	self._lastSelectPos = nil

	NotifyCenter:addEventListener(Notify.WORLD_UNSELECT_CLICK, {self,self.unSelectClick})
end

function WorldElemController:unSelectClick(event)
	self:unselect()
end

function WorldElemController:setElems( moveVector )
	for _,elem in pairs(self._childControllerTable) do
		elem._controller:setElems( moveVector )
	end
end

function WorldElemController:_updateElems(event)
	-- body
	for _,elem in pairs(self._childControllerTable) do
		if event.pos then
			elem._controller:updateElem(event.pos)
		else
			elem._controller:setElems( ccp(0,0),true )
		end
	end
end

function WorldElemController:getElemByPos(elemName, blockPos)
	return self._childControllerTable[elemName]._controller:getElemByPos(blockPos.x,blockPos.y)
end

function WorldElemController:getAllElemByPos(blockPos)
	local elems = {}
	for k,v in pairs(self._childControllerTable) do
		local controller = self._childControllerTable[k]._controller
		if controller.getElemByPos then
			local elem = controller:getElemByPos(blockPos.x,blockPos.y)
			if elem ~= nil then
				table.insert(elems, elem)
			end
		end
	end

	return elems
end

function WorldElemController:selectAt( blockPos )
	-- body
	self._childControllerTable[WorldMapModel.SELECT]._controller:selectAt( blockPos )
	local elems = self:getAllElemByPos(blockPos)
	for k,v in pairs(elems) do
		if v.selected then
			v:selected()
		end
	end
	self._lastSelectPos = blockPos
end

function WorldElemController:unselect()
	-- body
	self._childControllerTable[WorldMapModel.SELECT]._controller:unselect()
	if self._lastSelectPos ~= nil then
		local elems = self:getAllElemByPos(self._lastSelectPos)
		for k,v in pairs(elems) do
			if v.unSelect then
				v:unSelect()
			end
		end
	end

	self._lastSelectPos = nil
end

function WorldElemController:hasSelect( )
	-- body
	return self._childControllerTable[WorldMapModel.SELECT]._controller:hasSelect()
end

function WorldElemController:getChildElemController( elemName )
	-- body
	return self._childControllerTable[elemName]._controller
end

function WorldElemController:dispose(  )
	NotifyCenter:removeEventListener(Notify.WORLD_UNSELECT_CLICK, {self,self.unSelectClick})
	-- body
	for _,elem in pairs(self._childControllerTable) do
		elem._controller:dispose()
	end
	NotifyCenter:removeEventListener(Notify.WORLD_GET_MAP_INFO, {self, self._updateElems})
	NotifyCenter:removeEventListener(Notify.WORLD_UPDATE_MAP_INFO, {self, self._updateElems})
	-- NotifyCenter:removeEventListener(Notify.NEW_GUIDE, {self, self._newGuide})
	self:_endGuide()
end

----------------------------新手-------------------
function WorldElemController:_initGuide()
	self._guideList = {}
end

function WorldElemController:_newGuide()
	self:_toGuideConnect(GuideModel.WORLD_MINE,1)
end

function WorldElemController:_checkGuide()
	if not self._guide then
		if GuideModel:isGuideActive(GuideModel.WORLD_GUIDE) then
			self:_toGuide(GuideModel.WORLD_GUIDE,2)
		elseif GuideModel:isGuideActive(GuideModel.WORLD_MINE) then
			self:_toGuideConnect(GuideModel.WORLD_MINE,1)
		end
	end
end

function WorldElemController:_toGuideConnect(guideId,step)
	if self._guideList[guideId] or not GuideModel:isGuideActive(guideId) then
		return
	end
	if self._connectMinePos then
		GuideExtend.extend(self)
		local mineController = self._childControllerTable[WorldMapModel.MINE]._controller
		local mine = mineController:getElemByPos(self._connectMinePos.x,self._connectMinePos.y)
		if mine then
			self._connectMinePos = nil
			self:_addGuideArrow(guideId,stpe,mine)
			return
		end
	end
	local baseInfo = worldModel:getBaseInfo()
	if not baseInfo then
		return
	end
	local controller = WorldMapProxy:getElemInfoController(WorldMapProxy.MINE)
	local minePosList = controller:getNearByFreeMine(baseInfo,1)
	local minePos = minePosList[1]
	if not minePos then
		minePos = controller:getNearByFreeMine(baseInfo,2)[1]
	end
	if not minePos then
		minePos = controller:getNearByFreeMine(baseInfo,3)[1]
	end
	if minePos then
		local mineController = self._childControllerTable[WorldMapModel.MINE]._controller
		local mine = mineController:getElemByPos(minePos.x,minePos.y)
		if mine then
			self:_addGuideArrow(guideId,stpe,mine)
		end
		return
	end
	-- GuideModel:finishGuide(guideId)
end

function WorldElemController:_changeArmyHero(heroId)
	if heroId then
		local heroInfo = HeroModel:getHeroInfo(heroId)
		if heroInfo then
			worldModel:setArmyHero(1,{[heroId]={max_num=1}}) --第一个部队换上采矿车
			if heroInfo.num > 1 then
				WorldModel:setArmyHero(2,{[heroId]={max_num=1}}) --第二个部队换上采矿车
			end
		end
	end
end

function WorldElemController:_toGuide(guideId,step)
	if self._guideList[guideId] or not GuideModel:isGuideActive(guideId) then
		return
	end
	--先把矿车换上去
	local heroId = GuideModel:getGuideHero(guideId)
	self:_changeArmyHero(heroId)

	GuideExtend.extend(self)

	local baseInfo = worldModel:getBaseInfo()
	local pos = self._map:getBlockPosAtMidOfMapNode()
	if not baseInfo then
		return
	end
	if baseInfo.x ~= pos.x or baseInfo.y ~= pos.y then
		NotifyCenter:dispatchEvent({name=Notify.WORLD_TO_BLOCK_POS,x = baseInfo.x, y = baseInfo.y})
	end
	local mineController = self._childControllerTable[WorldMapModel.MINE]._controller
	mineController:addAllElemAtOnce()

	local controller = WorldMapProxy:getElemInfoController(WorldMapProxy.MINE)
	local minePosList = controller:getNearByFreeMine(baseInfo,1)
	local elem1,elem2 = self:_getConnectMine(minePosList)

	local onlyMine = minePosList[1]  --先保存只有一个矿的
	if not elem1 then
		minePosList = controller:getNearByFreeMine(baseInfo,2)
		elem1,elem2 = self:_getConnectMine(minePosList)
	end

	if not elem1 then
		minePosList = controller:getNearByFreeMine(baseInfo,3)
		elem1,elem2 = self:_getConnectMine(minePosList)
	end

	if elem1 then
		self._connectMinePos = elem2:getBlockPosRange()  --记录下连矿的
		self:_addGuideArrow(guideId,stpe,elem1)
	elseif onlyMine then
		local elem = self._childControllerTable[WorldMapModel.MINE]._controller:getElemByPos(onlyMine.x,onlyMine.y)
		if elem then
			self:_addGuideArrow(guideId,stpe,elem)
		end
	else
		-- GuideModel:finishGuide(guideId)
	end
	--
end

function WorldElemController:_addGuideArrow(guideId,stpe,elem)
	self._guideList[guideId] = true
	local baseInfo = worldModel:getBaseInfo()
	local pos = elem:getBlockPosRange()
	if pos.x > baseInfo.x or pos.y > baseInfo.y then
		local scene = self._map:getblockOriginNode()
		local off = ccp(pos.x - baseInfo.x , pos.y - baseInfo.y)
		-- if pos.x < baseInfo.x then
		-- 	off = ccp(0,1)
		-- else
		-- 	off = ccp(1,1)
		-- end
		-- print("移动。。。。")
		self._map:setMidMapBlockPos({x=baseInfo.x+off.x,y=baseInfo.y+off.y})
	end
	local layerId = Panel.PanelLayer.NOTIFY_TOP
	local gameLayer = ViewMgr:getGameLayer(layerId)
	local guide = self:_getNewGuide(false,gameLayer:getPriority())
	guide:setTarget(elem)

	guide:showGuideText(guideId, step, 100, -320, layerId, false)

	NotifyCenter:addEventListener(Notify.WORLD_SELECT, {self, self._onMenuOpen})
end

function WorldElemController:_getConnectMine(mineList)
	if #mineList < 3 then return nil end

	local mineController = self._childControllerTable[WorldMapModel.MINE]._controller
	local function checkConnect(pos,key)
		local cPos
		local flag = true
		for i=1,2 do
			cPos = {x=pos.x,y=pos.y}
			cPos[key] = cPos[key] + i
			if not mineController:getElemByPos(cPos.x,cPos.y) then
				flag = false
				break
			end
		end
		if flag then
			return cPos
		end
		for i=-1,-2,-1 do
			cPos = {x=pos.x,y=pos.y}
			cPos[key] = cPos[key] + i
			if not mineController:getElemByPos(cPos.x,cPos.y) then
				return nil
			end
		end
		return cPos
	end

	for i,pos in ipairs(mineList) do
		local elem = mineController:getElemByPos(pos.x,pos.y)
		if elem then
			local connectPos = checkConnect(pos,"x")
			if connectPos then
				return elem,mineController:getElemByPos(connectPos.x,connectPos.y)
			end
			local connectPos = checkConnect(pos,"y")
			if connectPos then
				return elem,mineController:getElemByPos(connectPos.x,connectPos.y)
			end
		end
	end
	return nil
end

function WorldElemController:_onMenuOpen()
	if self._removeGuide then
		self:_removeGuide()
	end
end

function WorldElemController:_endGuide()
	if self._removeGuide then
		self:_removeGuide()
	end
--	if GuideModel:isGuideActive(GuideModel.WORLD_MINE) then
--		GuideModel:finishGuide(GuideModel.WORLD_MINE)
--	end
--	if GuideModel:isGuideActive(GuideModel.WORLD_GUIDE) then
--		GuideModel:finishGuide(GuideModel.WORLD_GUIDE)
--	end
end

return WorldElemController