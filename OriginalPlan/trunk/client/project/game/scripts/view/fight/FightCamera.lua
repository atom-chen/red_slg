--
--
local FightCamera = class("FightCamera")

function FightCamera:ctor()
	--
	self.tileTypeList = {}
	self.tileTypeList["red"] = {}
	self.tileTypeList["bule"] = {}
	self.tileTypeList["gray"] = {}
end

function FightCamera:init()

end


--设置 缩放镜头
function FightCamera:setScale(scale,speed)
	self.targetScale = scale
	self.speed = speed or 1000
end

function FightCamera:start(scene)
	self.scene = scene
	self.isLock = false
	self.auto = true
	if self._lockTime then
		scheduler.unscheduleGlobal(self._lockTime)
		self._lockTime = nil
	end

	if self.node == nil then
		self.node = display.newNode()
		self.node:retain()
		self.scene:addChild(self.node)
	end
	self:removeAllTile()
end

function FightCamera:stop(  )
	self:removeAllTile()
	if self.node then
		self.node:release()
		self.node:removeSelf()
		self.node = nil
	end
	self:cancelFollow()
	self._addScale = nil
	self.scene = nil
end

--设置锁定相机不动
function FightCamera:lockCamera(flag)
	self.isLock = flag
end

function FightCamera:setAuto(flag,delay,delayTime)
	if self._lockTime then
		scheduler.unscheduleGlobal(self._lockTime)
		self._lockTime = nil
	end
	if flag == true and delay and FightDirector.status == FightCommon.start then
		self._lockTime = scheduler.performWithDelayGlobal(function()
						self._lockTime = nil
						 self.auto = true
						end,delayTime or 5)
	else
		self.auto = flag
	end
end

--设置场景缩放大小  和缩放的中心点
function FightCamera:setSceneScale( newScale,x,y,force)
	if not force then
--		if newScale > 1 then
--	        newScale = 1
--	    elseif newScale < 0.75 then
--	    	newScale = 0.75
--	    end
	end
	local oldScale = self.scene:getSceneScale()

	local addScale = newScale - oldScale
	--local minX,minY,maxX,maxY = self.scene:getMaxRect()
	x = x or 0
	y = y or 0
	local dx = (x/oldScale)*newScale
	local dy = (y/oldScale)*newScale

	local panel = ViewMgr:getPanel(Panel.FIGHT)

	panel.sceneContainer:setScale(newScale)
	self.scene:setSceneScale(newScale)

	local curX,curY = self.scene:getPosition()
	print("GGGGGGGGGGGGGGGGG",addScale,oldScale,dx,dy,dx/newScale,dy/newScale)
	local newX,newY = self:moveScene(-dx/newScale,-dy/newScale)
	-- panel.ui:move((newX-curX),(newY-curY))

	-- print("aaa",curX,curY,newX,newY,-dx/newScale,-dy/newScale)
end

--跟踪某个目标
function FightCamera:setFollowTarget(target,speed,toTarget)
	self._followTarget = target
	self._followSpeed = speed
	self._followTo = toTarget
end

--取消跟踪目标
function FightCamera:cancelFollow()
	if self._followSpeed then
		self:cancelSceneMove()
	end
	self._followTarget = nil
	self._followSpeed = nil
	self._followTo = nil
end

--设置缩放大小的点  和缩放的大小
function FightCamera:setTweenScale(scale,scaleSpeed,x,y,retainTime,callback,speedA)
	FightDirector:setSceneTouchEnable(false)
	self._oAddScale = scale
	self._addScale = scale
	self._scaleX = x or display.cx
	self._scaleY = y or display.cy
	self._scaleSpeed = math.abs(scaleSpeed or (self._addScale/10) )
	self._scaleRetainTime = retainTime
	self._scaleCallBack = callback
	self._scaleSpeedA = speedA or 0
end

--获取当前剩余放大的倍数
function FightCamera:getTweenScale()
	return self._addScale
end

--用战斗地图坐标设置场景位置
function FightCamera:setCenterPosByMap(mx, my)
	local x,y = FightDirector:getMap():toScenePos(mx, my)
	self:setSceneCenterPos(x,y)
end

--用战斗地图坐标设置场景位置
function FightCamera:moveCenterPosByMap(mx, my,speed)
	local x,y = FightDirector:getMap():toScenePos(mx, my)
	self:moveSceneToCenter(x,y,speed)
end

--设置场景居中
function FightCamera:setSceneCenter()
	local scene = self.scene
	local scale = scene:getSceneScale()
	local size = scene:getParent():getContentSize()
	local x = (size.width - scene.width*scale)/2--+600
	local y = (size.height - scene.height*scale)/2---200
	--local x,y = FightDirector:getMap():toScenePos(80,88)
	self:setScenePos(x/scale,y/scale)
end

function FightCamera:setSceneLeft()
	local minX,minY,maxX,maxY = self.scene:getMaxRect()
	self:setScenePos(x,y)
end

function FightCamera:setSceneRight()
	local minX,minY,maxX,maxY = self.scene:getMaxRect()
	self:setScenePos(minX,minY)
end

--设置场景到某个位置

function FightCamera:setScenePos(x,y)
	local minX,minY,maxX,maxY = self.scene:getMaxRect()

	if x < minX then x = minX elseif x > maxX then x = maxX end
	if y < minY then y = minY elseif y > maxY then y = maxY end
	self.scene:setPosition(x,y)
	self.scene:updateElemVisible()
	return x,y
end

function FightCamera:setSceneCenterPos(x,y)
	x,y = self:transformPos(x,y)
	self:setScenePos(x,y)
end

--移动场景
function FightCamera:moveScene(dx,dy)
	local curX,curY = self.scene:getPosition()
	if self.isLock then
		print("PPPPPQQQQQQ2222",newX,newY)
		return curX,curY
	end

	local newX,newY = curX + dx,curY + dy
	print("PPPPPQQQQQQ",newX,newY)
	newX,newY = self:setScenePos(newX,newY)
	return newX,newY
end

--移动场景到某个位置  以场景中心对位
function FightCamera:moveSceneToCenter(x,y,speed)
	x,y = self:transformPos(x,y)
	self:moveSceneTo(x,y,speed)
end

--中心坐标转到左下角坐标
function FightCamera:transformPos(x,y)
	local sceneScale = self.scene:getSceneScale()
	x,y = -x*sceneScale+display.cx,-y*sceneScale+display.cy
	x,y = x/sceneScale,y/sceneScale
	return x,y
end

--移动场景到某个位置
function FightCamera:moveSceneTo(tx,ty,speed)
	local minX,minY,maxX,maxY = self.scene:getMaxRect()

	-- print(debug.traceback())

	if tx < minX then tx = minX elseif tx > maxX then tx = maxX end
	if ty < minY then ty = minY elseif ty > maxY then ty = maxY end
	-- print("--移动到",tx,ty,speed,maxX,maxY)
	self._sceneTargetX = tx
	self._sceneTargetY = ty
	self._sceneSpeed = speed

end

function FightCamera:cancelSceneMove()
	self._sceneTargetX = nil
	self._sceneTargetY = nil
	self._sceneSpeed = nil
end

function FightCamera:cancelSceneScale()
	self._addScale = nil
	FightDirector:setSceneTouchEnable(true)
end

--主要在这里面调整 镜头  跟踪目标
function FightCamera:run( dt )
	if self.isLock then
		return
	end
	if self._addScale then
		local scaleSpeed = self._scaleSpeed * dt
		self._scaleSpeed = self._scaleSpeed + self._scaleSpeedA*dt

		if self._addScale < 0 then  --变小
			local scale = self.scene:getSceneScale()
			if self._addScale > -scaleSpeed then
				scale = scale + self._addScale
				if self._oAddScale then
					self._addScale = 0
				else
					self:cancelSceneScale()
				end
			else
				self._addScale = self._addScale + scaleSpeed
				scale = scale - scaleSpeed
			end
			self:setSceneScale(scale,self._scaleX,self._scaleY,true)
		elseif self._addScale > 0 then---变大
			local scale = self.scene:getSceneScale()
			if self._addScale < scaleSpeed then
				scale = scale + self._addScale
				if self._oAddScale then
					self._addScale = 0
				else
					self:cancelSceneScale()
				end
			else
				self._addScale = self._addScale - scaleSpeed
				scale = scale + scaleSpeed
			end
			self:setSceneScale(scale,self._scaleX,self._scaleY,true)
		elseif self._scaleRetainTime then
			self._scaleRetainTime = self._scaleRetainTime -dt
			if self._scaleRetainTime <= 0 then
				self._addScale = -self._oAddScale
				self._oAddScale = nil
			end
		else
			self:cancelSceneScale()
			if self._scaleCallBack then
				self._scaleCallBack()
			end
		end
	end

	if self._followTarget then
		if self._followSpeed then
			local x,y
			if self._followTo then
				x,y = self._followTarget:getPosition()
				local tx,ty = self._followTo:getPosition()
				x,y = (x+tx)/2,(y+ty)/2
			else
				x,y = FightDirector:getMap():toScenePos(self._followTarget.mx+1, self._followTarget.my-1)
			end
			x,y = self:transformPos(x,y)
			local curX,curY = self.scene:getPosition()
			if x == curX and y == curY then
				self._sceneTargetX = nil
			else
				self._sceneTargetX = x
				self._sceneTargetY = y
				self._sceneSpeed = self._followSpeed
			end
		else
			local x,y = FightDirector:getMap():toScenePos(self._followTarget.mx+1, self._followTarget.my-1)
			x,y = self:transformPos(x,y)
			self:setScenePos(x,y)
		end
	end

	local toX,toY,toSpeed = self._sceneTargetX,self._sceneTargetY,self._sceneSpeed
	if not self._followTarget and not self._addScale and not toX and FightDirector.status == FightCommon.start
		and self.auto then
		if FightDirector.status == FightCommon.start then
			local x1,y1 = self:_getTeamCenterXY(FightCommon.mate)
			local x2,y2 = self:_getTeamCenterXY(FightCommon.enemy)
			local tx = (x1+x2)/2 +10
			local ty = (y1+y2)/2-10
			tx,ty = self:transformPos(tx,ty)
			local curX,curY = self.scene:getPosition()
			if tx == curX then
				toX = nil
			else
				toX = tx
			end

			if ty == curY then
				toY = nil
			else
				toY = ty
			end

			toSpeed = 0.1
		end
	end

	if toX or toY then
		local curX,curY = self.scene:getPosition()
		local dx,dy = Formula:getNextPos(curX,curY,toX or 100,toY or 100,toSpeed,dt)
		self:setScenePos(dx,dy)
		if toX == dx and toY == dy then
			self._sceneTargetX = nil
			self._sceneTargetY = nil
			self._sceneSpeed = nil
		end
	end
end

function FightCamera:_getTeamCenterXY( team )
	local mateList = FightDirector:getScene():getTeamList(team)
	local tx,ty,num = 0,0,0
	if team == FightCommon.left  then
		for _,c in ipairs(mateList) do
			if not c:isDie() and c.cInfo.heroType ~= 1 then  --不是建筑
				tx = tx+c:getPositionX()
				ty = ty+c:getPositionY()
				num = num +1
			end
		end
	else
			local curArea = FightDirector:getFightArea()
			local curCityWallBoss = FightEngine:getCityWallBoss( curArea )
			if curCityWallBoss and not curCityWallBoss:isDie() then
				ty = curCityWallBoss:getPositionX()
				ty = curCityWallBoss:getPositionY()
			else
				local baseBuild = FightDirector:getScene():getHQ(FightCommon.enemy)
				if baseBuild and not baseBuild:isDie() then
					ty = baseBuild:getPositionX()
					ty = baseBuild:getPositionY()
				end
			end
			num = num+1
	end

	if num == 0 then
		local map = FightDirector:getMap()
		if team == FightCommon.left then
			local x,y = map:toScenePos(20,46)
			return x,y
		else
			local x,y = map:toScenePos(58,46)
			return x,y
		end
	end
	return tx/num,ty/num
end

function FightCamera:showTile(list,tType)
	self:removeTiles(tType)
	local tList = self.tileTypeList[tType]
	for i,pos in ipairs(list) do
		local tile = FightCache:getTileSprite(pos.mx,pos.my,tType) --TileSprite.new(pos.mx,pos.my,-1,color)
		self.node:addChild(tile)
		tList[#tList + 1] = tile
	end
end

function FightCamera:removeTiles(tType)
	local tList = self.tileTypeList[tType]
	for i,tile in ipairs(tList) do
		FightCache:setTileSprite(tile)
	end
	self.tileTypeList[tType] = {}
end

--显示英雄可站立的格子
function FightCamera:showStandTile( beginPos,endPos,tType )
	self:removeTiles(tType)
	local tList = self.tileTypeList[tType]
	local index = 1
	for i=beginPos.x,endPos.x do
		for j = beginPos.y,endPos.y do
			local tile = FightCache:getTileSprite(i,j,tType)
			self.node:addChild(tile)
			tList[#tList + 1] = tile
		end
	end
end

-- function FightCamera:showRange( target,range,color )
-- 	-- local now = os.clock()
-- 	for i = 0,range.w-1 do
-- 		for j = 0,range.h-1 do
-- 			local index = range:getIndex(i,j)
-- 			if range:indexInRange(index) then
-- 				local pos = range:getScenePosByIndex(index,target,target:getDirection())
-- 				if FightDirector:getMap():isLegal(pos.mx,pos.my) then
-- 					local tile = FightCache:getTileSprite(pos.mx,pos.my,color) --TileSprite.new(pos.mx,pos.my,-1,color)
-- 					self.node:addChild(tile)
-- 					self.tileList[#self.tileList+1] = tile
-- 				end
-- 			end
-- 		end
-- 	end
-- 	-- print("show range  time ..",os.clock()-now)
-- end

function FightCamera:removeAllTile(  )
	if self.tileList then
		for _,tile in ipairs(self.tileList) do
			 FightCache:setTileSprite(tile)
		end
	end
	self.tileList = {}
	for tType,tList in pairs(self.tileTypeList) do
		self:removeTiles(tType)
	end
end


return FightCamera.new()