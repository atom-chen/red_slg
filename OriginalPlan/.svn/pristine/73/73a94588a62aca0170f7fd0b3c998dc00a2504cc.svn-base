--
local pairs = pairs
local ipairs = ipairs
local table = table

if DEBUG ~= 0 then
	isShowTile = true
else
	isShowTile = false
end

FightMap = game_require("view.fight.map.FightMap")
FightAir = game_require("view.fight.map.FightAir")
Creature = game_require("view.fight.creature.Creature")
local BiontCreature = game_require("view.fight.creature.BiontCreature")
local FlyCreature = game_require("view.fight.creature.FlyCreature")
local BuildCreature = game_require("view.fight.creature.BuildCreature")

Tile = game_require("view.fight.map.Tile")
Range = game_require("view.fight.map.Range")
TileSprite = game_require("view.fight.map.TileSprite")
local SplitCreature = game_require("view.fight.creature.SplitCreature")
local FightScene = class("FightScene",function() return display.newLayer() end)

function FightScene:ctor()
	self.creatureList = {}

	self.elemList = {}

	self.bottomLayrer = display.newNode()
	self:addChild(self.bottomLayrer,1)

	self.elemLayer = display.newNode()
	self:addChild(self.elemLayer,1)

	self:setAnchorPoint(ccp(0,0))

	self.topLayer = display.newNode()
	self:addChild(self.topLayer,2)

	self:setSceneScale(1)
end

function FightScene:initBg(res)
	if self.bg == nil then
		self.bg= display.newNode()
	end
	self.bgWidth = 0
	self.bgHeight = 0
	self.bgRes = {}
	local imgH= 0
	local posW = 0
	local posH = 0
	for k1,v1 in ipairs(res) do
		posW = 0
		if not self.bgRes[k1] then
			self.bgRes[k1] = {}
		end
		for k2,v2 in pairs(v1) do
			local img = nil
			if not self.bgRes[k1][k2] then
				img= display.newXSprite()
				self.bgRes[k1][k2]=img
				img:setAnchorPoint(ccp(0,0))
				self.bg:addChild(img)
			else
				img= self.bgRes[k1][k2]
			end
			img:setSpriteImage("fightMap/"..v2..".w")
			img:setPosition(posW,posH)
			local imageSize = img:getContentSize()
			if k1 == 1 then
				self.bgWidth = self.bgWidth + imageSize.width
				imgH = imageSize.height
			end
			posW = posW + imageSize.width
		end
		self.bgHeight = self.bgHeight + imgH
		posH = self.bgHeight
	end
	self.bg:setContentSize(CCSize(self.bgHeight, self.bgHeight))
	self.bg:setAnchorPoint(ccp(0,0))
	--self.bg:setScale(0.7)
end

-- function FightScene:setBgRes(res)
-- 	self.bg:setSpriteImage(res)
-- end

function FightScene:getBgOriginPos()
	return self.bgOffsetX,self.bgOffsetY
end

function FightScene:initMap(id)
	if self.map == nil then
		self.map = FightMap.new()
		self.air = FightAir.new()
	end
	print("FightScene:initMap",self.bgWidth,self.bgHeight)
	self.map:initMap(id,self.bgWidth,self.bgHeight)
	self.air:init()
	self.width,self.height = self.map:getSize()

	self.bgOffsetX = (self.bgWidth-self.width)/2
	self.bgOffsetY = (self.bgHeight-self.height)/2
	self.bg:setPosition(0-self.bgOffsetX,0-self.bgOffsetY)

	-- local sp = display.newXSprite("#tt_2.png")
	-- sp:setAnchorPoint(ccp(0,0))
	-- sp:setImageSize(CCSize(self.width,self.height))
	-- self:addChild(sp,10)
end

--[[--
初始化场景   背景  双方玩家
]]
function FightScene:initScene(id)
	-- local mapInfo = MapCfg:getMap(id)
	self.sceneId = id

	self:initBg(FightCfg:getSceneBg(id))

	self:initMap(id)

	if not self.bg:getParent() then
		self:addChild(self.bg)
	end

	--print(self.width,self.height)

	-- local a = display.newXSprite("#tt_2.png")
	-- self:addChild(a,100)
	-- a:setAnchorPoint(ccp(0,0));
	-- a:setImageSize(CCSize(self.width,self.height))

	self.offsetX = 0
	self.offsetY = 0

	local sceneScale = self:getSceneScale()

	local x = (display.width - self.width*sceneScale)/2
	local y = (display.height - self.height*sceneScale)/2

	self:setPosition(x/sceneScale,y/sceneScale)

	-- local p = self:getParent()
	-- print("scenex。。。",x,y,sceneScale,self.bgOffsetX,self.bgOffsetY,self.width,self.height,p:getPosition())

	self.teamList = {}
	self.teamList[1] = {}
	self.teamList[2] = {}

	self.hqList = {}

	self.tempList = {}

	self.topLayerElemList = {}

	self._sortTimeCount = 0

end

function FightScene:getHQ(team)
	return self.hqList[team]
end

function FightScene:setHQ(creature)
	creature.isHQ = true
	creature.cInfo.isHQ = true
	self.hqList[creature.cInfo.team] = creature
end

-- function FightScene:setPosition(x,y)
-- 	local lastX,lastY = self:getPosition()
-- 	CCNode.setPosition(self,x,y)
	-- local dx,dy = x - lastX,y - lastY
	-- for i,m in pairs(FightEngine.magicList) do
	-- 	if m.trail then
	-- 		m.trail:setParticleOffsetPos(dx,dy,0)
	-- 	end
	-- end
-- end

function FightScene:removeMap()
	-- if isShowTile then
	-- 	self.map:setPosition(0,0)
	-- 	self.map:removeFromParent()
	-- end
end

--正式开始
function FightScene:start()
	for _,c in pairs(self.creatureList) do
		c:start()
	end
end

--手动缩放后的大小
function FightScene:setSceneScale( scale )
	self.sceneScale = scale
end

--获取缩放后的大小
function FightScene:getSceneScale()
	return self.sceneScale
end

function FightScene:getMaxRect()
	local sceneScale = self:getSceneScale()
	local parent = self:getParent()
	local size = parent:getContentSize()

	local minX,maxX = -( (self.width - display.width))*sceneScale - FightMap.HALF_TILE_W,FightMap.HALF_TILE_W
	local minY,maxY =  -( (self.height - display.height))*sceneScale -FightMap.HALF_TILE_H, FightMap.HALF_TILE_H --(display.height - self.height*sceneScale)/2--

	if minY > maxY then minY = maxY end
	if minX > maxX then minX = maxX end

	-- print(" 范围。。",maxX,minX)
	return minX,minY,maxX,maxY
end

function FightScene:getScaleWH()
	local minX,minY,maxX,maxY = self:getMaxRect()
	return maxX - minX,maxY-minY
end

function FightScene:initCreature(cInfo,autoTactic)

	local creature = self:_newCreature(cInfo)
	self:_setCreatureAt(creature,cInfo.mx,cInfo.my)
	self.creatureList[creature.id] = creature
	local index = cInfo.scope == FightCfg.FLY and 1 or nil
	self:addElem(creature,index)
	local tList = self.teamList[cInfo.team]
	tList[#tList + 1] = creature

	FightEngine:addCreature(creature)
	AIMgr:initAI(creature)

	FightDirector:addPopulace(cInfo.team,cInfo)

	if cInfo.heroMagic then
		for _,mId in ipairs(cInfo.heroMagic) do
			FightEngine:createMagic(creature, mId)
		end
	end

	-- if cInfo.team == FightCommon.mate then
	-- 	local arr = {11,12,13,14,15,22,23,24}
	-- 	scheduler.scheduleGlobal(function() creature:setDirection(arr[math.random(1,#arr)]) end, 3)
	-- end

	-- collectgarbage("collect")
	FightTrigger:dispatchEvent({name = FightTrigger.ADD_CREATURE, creature = creature})
	return creature
end

function FightScene:removeCreature( creature )
	local tList = self.teamList[creature.cInfo.team]
	for i,c in ipairs(tList) do
		if c == creature then
			table.remove(tList,i)
			break
		end
	end
	local index = table.indexOf(self.tempList,creature)
	if index > 0 then
		print("fuck ,...error:",creature.cInfo.name,index)
		table.remove(self.tempList,index)
		local str = debug.traceback() or ""
		StatSender:sendBug( "  self.tempList removeCreature  creature  " ..str )
	end
	self.map:removeTileContent(creature)
	FightEngine:stopCreatureSkill(creature)
	FightEngine:removeCreature(creature)
	FightEngine:removeAllCreatureMagic(creature)
	FightTrigger:dispatchEvent({name = FightTrigger.REMOVE_CREATURE, creature = creature})
	AIMgr:removeAI(creature)
	self:_disposeCreature(creature)
	-- collectgarbage("collect")
end

function FightScene:_newCreature(info)
	local creature
	if info.heroType == 1 then
		creature = BuildCreature.new(info)
	elseif info.atkRes then
		creature = SplitCreature.new(info)
	elseif info.scope == FightCfg.FLY then
		creature = FlyCreature.new(info)
	elseif info.heroType == 2 then
		creature = BiontCreature.new(info)
	else
		creature = Creature.new(info)
	end
	return creature
end

function FightScene:_disposeCreature(creature)
	self.creatureList[creature.id] = nil
	self:removeElem(creature)
	creature:dispose()
end

--先把creature 放到temp列表里面   之后再删除
function FightScene:setCreatureTemp(creature)
	if table.indexOf(self.tempList,creature) > 0 then
		local str = debug.traceback() or ""
		StatSender:sendBug( "  self.tempList repeat  creature  " ..str )
		if DEBUG == 2 then
			assert("   self.tempList has ")
		end
		return
	end

	FightEngine:stopCreatureSkill(creature)
	FightEngine:removeCreatureMagic(creature)
	FightEngine:removeCreatureBuff(creature)
	local mList = creature:getMagicList()
	if #mList > 0 then
		for i=#mList,1 -1 do
			FightEngine:removeMagic(mList[i])
		end
	end
	creature:setHp(0)

	self:removeCreatureReference(creature)
	FightDirector:getScene():removeTopLayer(creature,true)
	self.map:removeTileContent(creature)

	--FightEngine:removeAllCreatureMagic(creature)

	FightEngine:removeCreature(creature)
	self:removeElem(creature)

	-- local index = table.indexOf(self.teamList,creature)
	-- assert(index == -1,"fuck。。。。。index "..index.. "  name"..creature.cInfo.name)

	self.tempList[#self.tempList+1] = creature

	-- print(" setCreatureTemp ",#self.tempList,creature.cInfo.name,creature.id)
	-- print(debug.traceback())
	FightTrigger:dispatchEvent({name = FightTrigger.REMOVE_CREATURE, creature = creature})
	AIMgr:removeAI(creature)
	-- creature:removeAllEventListeners()
	-- print("creature    :",creature:retainCount())
end

function FightScene:clearTempCreature()
	for i,creature in ipairs(self.tempList) do
		FightEngine:removeAllCreatureMagic(creature)
		creature:dispose()
	end
	self.tempList = {}
end

function FightScene:removeCreatureReference(creature)
	if self.creatureList[creature.id] then
		self.creatureList[creature.id] = nil
		local tList = self.teamList[creature.cInfo.team]
		for i,c in ipairs(tList) do
			if c == creature then
				table.remove(tList,i)
				break
			end
		end
		return true
	end
	return false
end

function FightScene:getMap()
	return self.map
end

function FightScene:_setCreatureAt(creature,mx,my)
	local x,y = self.map:getTilePos(mx,my)
	if not x then
		print("creature wrong pos :",creature.cInfo.id,mx,my)
		mx = 1
		my = 2
		x,y = self.map:getTilePos(mx,my)
	end
	creature.mx = mx
	creature.my = my
	x,y = Formula:getOffsetPos(x,y,creature.posLength)
	creature:setPosition(x,y)
	if creature.cInfo.scope == FightCfg.FLY then
		creature.tMx,creature.tMy = creature.mx,creature.my
		self.air:setTileContentByCreature(creature,creature.id)
	else
		self.map:setTileContentByCreature(creature)
	end
	if creature.cInfo.occupy then
		for i,point in ipairs(creature.cInfo.occupy) do
			self.map:setTileContent(mx+point[1],my+point[2],FightMap.BLOCK)
		end
	end
end

function FightScene:getCreatureList()
	return self.creatureList
end

function FightScene:getCreature(id)
	return self.creatureList[id]
end

function FightScene:getCreatureByHeroId(heroId,team)
	local cList = self:getTeamList(team or FightCommon.mate)
	for i,c in ipairs(cList) do
		if c.cInfo.heroId == heroId then
			return c
		end
	end
	return nil
end

function FightScene:addElem( elem,index,zorder)
	if index == 1 then
		self:addToTopLayer(elem,false,zorder)
	elseif index == -1 then
		self.bottomLayrer:addChild(elem,1)
	else
		elem:retain()

		-- local t = XUtil:getCurTime()
		local y = elem:getPositionY()
		local index
		for i,e in ipairs(self.elemList) do
			if y >= e:getPositionY() then
				table.insert(self.elemList,i,elem)
				self.elemLayer:addChild(elem,i)
				index = i
				break
			end
		end

		if not index then
			table.insert(self.elemList,elem)
			self.elemLayer:addChild(elem,#self.elemList)
		elseif index < #self.elemList then
			for i=index+1,#self.elemList do
				self.elemLayer:reorderChild(self.elemList[i],i)
			end
		end
		-- print("插入花费了多少时间。。。。",XUtil:getCurTime() - t)
	end
end

function FightScene:removeElem( elem,index )
	if index == 1 then
		self:removeTopLayer(elem)
	elseif index == -1 then
		elem:removeFromParent()
	else
		elem:removeFromParent()
		local eIndex = table.indexOf(self.elemList, elem)
		if eIndex ~= -1 then
			table.remove(self.elemList,eIndex)
			elem:release()
			for i=eIndex,#self.elemList do
				self.elemLayer:reorderChild(self.elemList[i],i)
			end
		end
	end
end

function FightScene:addToTopLayer(elem,showMask,zorder)

	if showMask then
		if table.indexOf(self.topLayerElemList,elem) > 0 then
			return   --已经添加过了i
		end
		self:showMaskLayer()
		local index = 2
		local y = elem:getPositionY()
		for i = #self.topLayerElemList,1,-1 do
			local tElem = self.topLayerElemList[i]
			local ty = tElem:getPositionY()
			-- print("比较y",ty,y)
			if ty < y then
				self.topLayerElemList[i+1]=tElem
				self.topLayer:reorderChild(tElem,i+1+2)
			else
				self.topLayerElemList[i+1]=elem
				index = i+1+2
				break
			end
		end
		if index == 2 then
			self.topLayerElemList[1] = elem
		end
		-- print("最后index",index)
		elem:removeFromParent()
		self.topLayer:addChild(elem,index)
	else
		elem:removeFromParent()
		zorder = zorder or 0
		self.topLayer:addChild(elem,zorder)
	end
end

function FightScene:showMaskLayer()
	if self.topLayer.maskCount == nil then
		if self.topLayer.msp == nil then
			self.topLayer.msp = display.newXSprite("#tt_4.png")
			self.topLayer.msp:setOpacity(210)
			self.topLayer.msp:setImageSize(CCSize(self.bgWidth+100,self.bgHeight+20))
			local x,y = self.bg:getPosition()
			self.topLayer.msp:setPosition(x-50,y-10)
			self.topLayer.msp:setAnchorPoint(ccp(0,0))
			self.topLayer:addChild(self.topLayer.msp,1)
		end
		self.topLayer.maskCount = 0
	end
	self.topLayer.maskCount = self.topLayer.maskCount + 1
end

function FightScene:hideMaskLayer()
	if self.topLayer.maskCount then
		self.topLayer.maskCount = self.topLayer.maskCount - 1
	end
	if self.topLayer.maskCount == 0 then
		self.topLayer.maskCount = nil
		if self.topLayer.msp then
			self.topLayer.msp:removeFromParent()
			self.topLayer.msp = nil
		end
	end
end

function FightScene:removeTopLayer(elem,hideMask,reAddToElemLayer)
	if elem:getParent() == self.topLayer then
		elem:removeFromParent()
		if hideMask then
			self:hideMaskLayer()
		end
		if reAddToElemLayer then
			local index = table.indexOf(self.elemList,elem)
			if index > 0 then
				self.elemLayer:addChild(elem,index)
			else
				self:addElem(elem)
			end
		end
	end
	for i,tElem in ipairs(self.topLayerElemList) do
		if tElem == elem then
			table.remove(self.topLayerElemList,i)
			break
		end
	end
end

function FightScene:removeTopMask()
	self.topLayer.maskCount = nil
	if self.topLayer.msp then
		self.topLayer.msp:removeFromParent()
		self.topLayer.msp = nil
	end
end

--获取敌方  队伍
function FightScene:getEnemyList(creature)
	if creature.cInfo.team == FightCommon.mate then
		return self.teamList[FightCommon.enemy]
	else
		return self.teamList[FightCommon.mate]
	end
end

--获取同队  队伍
function FightScene:getMateList(creature)
	return self.teamList[creature.cInfo.team]
end

--获取指定队伍
function FightScene:getTeamList( team )
	return self.teamList[team]
end

--获取队伍人数
function FightScene:getTeamNum(team,pure,alive)
	local num = 0
	local cList = self:getTeamList(team)
	if not pure then
		return #cList
	end
	for i,c in ipairs(cList) do
		if (not alive or not c:isDie(true)) then
			num = num + 1
		end
	end
	return num
end

function FightScene:run(dt)
	self._sortTimeCount = self._sortTimeCount + 1
	if self._sortTimeCount >= 3  then
		self._sortTimeCount = self._sortTimeCount - 3
		self:sortElem()
	end

	self:updateElemVisible()
end

function FightScene:updateElemVisible( force )
	local x = self:getPositionX()
	local range = display.width*3/5
	local min,max = -x - range ,  display.width + range - x
	for _,c in pairs(self.creatureList) do
		local cx = c:getPositionX()
		local offX = (c.posLength-1)*range
		if (not force) and (cx < min - offX or cx > max + offX) then
			c:setVisible(false)
		else
			c:setVisible(true)
		end
	end
end

function FightScene:sortElem()
	if #self.elemList > 1 then
		local lastY = self.elemList[#self.elemList]:getPositionY()
		for i = #self.elemList -1 , 1,-1  do
			local curY = self.elemList[i]:getPositionY()
			if lastY > curY then
				local temp = self.elemList[i]
				self.elemList[i] = self.elemList[i+1]
				self.elemList[i+1] = temp
				self.elemLayer:reorderChild(temp,i+1)
				self.elemLayer:reorderChild(self.elemList[i],i)
			else
				lastY = curY
			end
		end
	end
end

--排序toplayer的
function FightScene:sortTopLayer()
	if #self.topLayerElemList > 1 then
		local lastY = self.topLayerElemList[1]:getPositionY()
		for i = 2 , #self.topLayerElemList do
			local curY = self.topLayerElemList[i]:getPositionY()
			if lastY < curY then
				local temp = self.topLayerElemList[i]
				self.topLayerElemList[i] = self.topLayerElemList[i-1]
				self.topLayerElemList[i-1] = temp
				self.topLayer:reorderChild(temp,i+2-1)
				self.topLayer:reorderChild(self.elemList[i],i+2)
			else
				lastY = curY
			end
		end
	end
end

function FightScene:clear()
	if self.sceneId then
		self:clearElem()
		self.map:clear()
		self.air:clear()
		for k,v in ipairs(self.bgRes) do
			for k1,v1 in ipairs(v) do
				v1:setSpriteImage(nil)
			end
		end
		self.sceneId = nil
	end
end

function FightScene:clearElem()
	for i,creature in pairs(self.creatureList) do
		self:removeCreature(creature)
	end
	for i,elem in ipairs(self.elemList) do
		elem:removeFromParent()
		elem:release()
	end

	for i,elem in ipairs(self.tempList) do
		elem:dispose()
	end

	self.tempList = {}
	self.elemList = {}

	self.creatureList = {}
	self.topLayerElemList = {}

	self.hqList = {}

	self.topLayer:removeAllChildren()
	-- body
end

return FightScene

