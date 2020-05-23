--
-- Author:lyc
-- Date: 2016-05-23 15:53:00
--

local BuildingUIController = game_require("view.town.BuildingUIController")
local TownMap = game_require("view.town.map.TownMap")

local TownScene = class("TownScene",function() return display.newLayer() end)

function TownScene:ctor(priority, townPanel)
	self._priority = priority
	self._townPanel = townPanel
	self._buildingController = BuildingUIController.new(self, self._townPanel)
	self:setSceneScale(1)

	self._sceneCfg = ConfigMgr:requestConfig("fight_scene", nil, true)
end

function TownScene:getBuildingController()
	return self._buildingController;
end

function TownScene:getPriority()
	return self._priority
end

function TownScene:initBg(res)
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
	self:addChild(self.bg)
end

function TownScene:dispose()
	self.bg:removeFromParent()
	self.bg = nil
	self._buildingController:dispose()
	self:removeTouchEventListener()
end

function TownScene:getBgOriginPos()
	return self.bgOffsetX,self.bgOffsetY
end

function TownScene:hasSelect()
	return self._buildingController:hasSelect()
end

function TownScene:unSelect()
	self._buildingController:unSelect()
end

function TownScene:initMap(id)
--	if self.map == nil then
--		self.map = TownMap.new()
--	end
--
--	self.map:initMap(id,self.bgWidth,self.bgHeight)
--	self.width,self.height = self.map:getSize()
--	self.bgOffsetX = (self.bgWidth-self.width)/2
--	self.bgOffsetY = (self.bgHeight-self.height)/2
--	self.bg:setPosition(0-self.bgOffsetX,0-self.bgOffsetY)
end

--鼠标事件
function TownScene:_onTouchScene(event,x,y)
	local ret
	if event == "began" then
		ret = self:_onTouchBegan(event,x,y)
	elseif event == "moved" then
		self:_onTouchMoved(event,x,y)
	elseif event == "ended" then
		self:_onTouchEnded(event,x,y)
	elseif event == "canceled" then
		self:_onTouchEnded(event,x,y)
	end
	return ret
end

function TownScene:_onTouchBegan( e,x,y )
--	if self._buildingController:hasSelect() then
--		return true
--	end

	self._lastX,self._lastY = x,y
	self.mouseX,self.mouseY = x,y

	return true
end

function TownScene:getMaxPoint()
	return self:getParent():convertToNodeSpace(cc.p(-256,0))
end

function TownScene:getMinPoint()
	return self:getParent():convertToNodeSpace(cc.p(-3465,-3290))
end

function TownScene:setMaxRect(minX,minY,maxX,maxY)
	self.minX = minX;
	self.minY = minY;
	self.maxX = maxX;
	self.maxY = maxY;
end

function TownScene:getMaxRect()
	return -2826,-2227,0,0
end

function TownScene:setScenePos(x,y)
	local minX,minY,maxX,maxY = self:getMaxRect()

	if x < minX then
		x = minX
	elseif x > maxX then
		x = maxX
	end
	if y < minY then
		y = minY
	elseif y > maxY then
		y = maxY
	end
	self:setPosition(x,y)

	print(x,y)
	return x,y
end

function TownScene:move(dx,dy)
	local curX,curY = self:getPosition()
	if self.isLock then
		return curX,curY
	end
	local newX,newY = curX + dx,curY + dy
	newX,newY = self:setScenePos(newX,newY)

	print(newX, newY)
	return newX,newY
end

function TownScene:_onTouchMoved(e,x,y)
	if self._buildingController:hasSelect() then
		if math.abs(self._lastX-x) + math.abs(self._lastY-y) > 10 then
			self._buildingController:unSelect()
		else
			return true
		end
	end

	local dx = x - self.mouseX
	local dy = y - self.mouseY
	self.mouseX = x
	self.mouseY = y

--	if math.abs(self._lastX-x) + math.abs(self._lastY-y) > 50 then
--		self.isMove = true

--		local map = FightDirector:getMap()
--		if isShowTile and map:getParent() then
--			x,y = Formula:globalToScenePos(x,y)

--			local mx,my = map:toMapPos(x,y)
--			local tile = map:getTile(mx,my)
--			if tile and not self._curTouchTileList[tile] then
--				self._curTouchTileList[tile] = true
--				if map:getTileContent(mx, my) == FightMap.BLOCK then
--					map:removeBlock(mx,my)
--				else
--					map:setTileContent(mx, my, FightMap.NONE)
--					map:addBlock(mx,my)
--				end
--			end
--			if tile then
--				return
--			end
--		end

--	end

--	local curX,curY = self.panel.scene:getPosition()
--	local newX,newY = FightDirector:getCamera():moveScene(dx,dy)

--	local scale = self.panel.scene:getSceneScale()

--	local px,py = self:getPosition()
--	self:setPosition(px+dx,py+dy)
--	print(px+dx,py+dy)

	self:move(dx*1.8, dy*1.8)
end

function TownScene:_onTouchEnded( e,x,y )
--	if self._buildingController:hasSelect() then
--		self._buildingController:unSelect()
--		return
--	end

	self.mouseX = nil
	local isDelay = true
--	if DEBUG == 2 then
--	 	if FightDirector.status ~= FightCommon.pause and FightDirector.status ~= FightCommon.start then
--	 		return false
--	 	end
--	elseif FightDirector.status ~= FightCommon.start then
--		isDelay = false
--	end
--	FightDirector:getCamera():setAuto(true,isDelay)

--	if not self.isMove then
--		FightTrigger:dispatchEvent({name=FightTrigger.CLICK_SCENE,x=x,y=y})
--		local map = FightDirector:getMap()
--		if isShowTile and map:getParent() then
--			x,y = Formula:globalToScenePos(x,y)
--			local mx,my = map:toMapPos(x,y)
--			if map:getTile(mx,my) then
--				FightTrigger:dispatchEvent({name = FightTrigger.SELECT_TILE,tile = map:getTile(mx,my)})
--			end
--		end
--	end
end

--[[
	初始化场景 背景
--]]
function TownScene:initScene(id)
	self.sceneId = id

	self:setTouchEnabled(true)
	-- scene:setTouchMode(kCCTouchesAllAtOnce)
	self:addTouchEventListener(handler(self,self._onTouchScene),false,-257,false)  --多点触摸

	self:initBg(self._sceneCfg[19].res)

	self:initMap(id)

	--print(self.width,self.height)

	-- local a = display.newXSprite("#tt_2.png")
	-- self:addChild(a,100)
	-- a:setAnchorPoint(ccp(0,0));
	-- a:setImageSize(CCSize(self.width,self.height))

	self.offsetX = 0
	self.offsetY = 0

	local sceneScale = self:getSceneScale()

--	local x = (display.width - self.width*sceneScale)/2
--	local y = (display.height - self.height*sceneScale)/2

--	self:setPosition(x/sceneScale,y/sceneScale)

	self:setPosition(0,0)
end

--手动缩放后的大小
function TownScene:setSceneScale( scale )
	self.sceneScale = scale
end

--获取缩放后的大小
function TownScene:getSceneScale()
	return self.sceneScale
end

--function TownScene:getMaxRect()
--	local sceneScale = self:getSceneScale()
--	local parent = self:getParent()
--	local size = parent:getContentSize()

--	local minX,maxX = -( (self.width - display.width))*sceneScale - FightMap.HALF_TILE_W,FightMap.HALF_TILE_W
--	local minY,maxY =  -( (self.height - display.height))*sceneScale -FightMap.HALF_TILE_H, (display.height - self.height*sceneScale)/2--FightMap.HALF_TILE_H

--	if minY > maxY then minY = maxY end
--	if minX > maxX then minX = maxX end

--	-- print(" 范围。。",maxX,minX)
--	return minX,5,maxX,5
--end

function TownScene:getScaleWH()
	local minX,minY,maxX,maxY = self:getMaxRect()
	return maxX - minX,maxY-minY
end

function TownScene:addToTopLayer(elem,showMask,zorder)

end

function TownScene:showMaskLayer()
	return false
end

function TownScene:hideMaskLayer()

end

function TownScene:removeTopLayer(elem,hideMask,reAddToElemLayer)
end

function TownScene:removeTopMask()

end

function TownScene:sortTopLayer()

end

return TownScene