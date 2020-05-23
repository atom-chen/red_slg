local FogRunner = class("FogRunner")

function FogRunner:init( )
--	self.fog = display.newXSprite("#fightFog.png")
--	self.fog:setImageSize(CCSize(display.width,display.height+10))
--	self.fog:setAnchorPoint(ccp(0.5,0))
--	self.fog:setOpacity(150)

--	local panel = ViewMgr:getPanel(Panel.FIGHT)
--	panel.sceneContainer:addChild(self.fog)

--	if FightCommon.mate == FightCommon.right then
--		self.fog:setScaleX(-1)
--		self.fog:setPosition(display.cx - 110,-5)
--	else
--		self.fog:setPosition(display.cx + 110,-5)
--	end
	--self.fog:setPosition(0,0)
--	self._turnCreature = {}
--	for i,c in pairs(FightDirector:getScene():getCreatureList()) do
--		self._turnCreature[c] = c:getDirection()
--		if c.cInfo.heroType ~= 1 then
--			local arr = {}
--			if c.cInfo.team == FightCommon.left then
--				arr[#arr+1] = Creature.RIGHT_UP
--				arr[#arr+1] = Creature.RIGHT_DOWN
--			else
--				arr[#arr+1] = Creature.LEFT_UP
--				arr[#arr+1] = Creature.LEFT_DOWN
--			end
--			if not c.atkAv then
--				c:setDirection(arr[math.random(1,#arr)])
--			elseif c.atkAv then
--				c.atkAv:setDirection(arr[math.random(1,#arr)])
--			end
--		end
--	end
end

function FogRunner:_getTeamPos(team)
	local map = FightDirector:getMap()
	if team == FightCommon.left then
		local x,y = map:toScenePos(20,46)
		return x,y
	else
		local x,y = map:toScenePos(58,46)
		return x,y
	end
end

function FogRunner:start(callback,forwardTime)
	self.callback = callback
	self.forwardTime = forwardTime

	--local magicId = 30
	self.totalTime = 2000
	local speed = Formula:transformSpeed( 150 )
	self.speedX = FightMap.COS * speed
	self.speedY = FightMap.SIN * speed
	local x,y = self:_getTeamPos(FightCommon.mate)
	local w,h = FightDirector:getMap():getSize()
--	self.magic = FightEngine:createMagic(nil, magicId,nil,nil,{x = x,y = y})
--	if self.magic and self.magic.setTargetPos then
--		local tx,ty = self:_getTeamPos(FightCommon.enemy)
--		self.magic:setTargetPos(tx,ty)
--		self.magic:retain()
--		self.totalTime = self.magic.totalTime
--	end

--	if self.magic and FightCommon.mate == FightCommon.right then
--		self.magic:setScaleX(-1)
--	end

--	self.gridList = {}

--	local scene = FightDirector:getScene()
--	for i=1,80 do
--		local grid = display.newXSprite("#fogGrid.png")
--		local size= grid:getContentSize()
--		local x = (i-10)*size.width -- 200
--		grid:setPosition(x,h/2+30)
--		grid:setAnchorPoint(ccp(0.5,1))

--		self.gridList[i] = grid
--		grid:retain()

--		local grid2 = display.newXSprite("#fogGrid.png")
--		grid2:setScaleY(-1)
--		grid2:setPositionY(size.height)
--		grid2:setAnchorPoint(ccp(0,1))
--		grid:addChild(grid2)
--		grid.grid2 = grid2

--		scene.elemLayer:addChild(grid,-1)
--	end

--	self.count = 0
	self.curX,self.curY= x,y
	self:_refreshFog()
	--FightDirector:getCamera():moveScene(self.desX,self.desY)
	FightEngine:addRunner(self)

end

function FogRunner:_refreshFog()
--	do
--		return
--	end
--	local scaleX = self.fog:getScaleX()
--	local scaleY = self.fog:getScaleY()
	local x = self.curX
	local y = self.curY
	FightDirector:getCamera():setScenePos(x,y)
--	if self.magic then
--		self.magic:getPositionX()
--	end
--	local size = self.gridList[1]:getContentSize()


--	while x > self.gridList[math.floor(#self.gridList/2)]:getPositionX() do
--		local grid = table.remove(self.gridList,1)
--		grid:setPositionX(self.gridList[#self.gridList]:getPositionX()+size.width)
--		self.gridList[#self.gridList+1] = grid
--	end

--	while y > self.gridList[math.floor(#self.gridList/2)]:getPositionY() do
--		local grid = table.remove(self.gridList,1)
--		grid:setPositionY(self.gridList[#self.gridList]:getPositionY()+size.height)
--		self.gridList[#self.gridList+1] = grid
--	end


--	local daX = 1.5*255/(size.width*#self.gridList)
--	local daY = 1.5*255/(size.height*#self.gridList)
--	for i,grid in ipairs(self.gridList) do
--		local gx,gy = grid:getPosition()
--		local apx = 255-math.abs(x-gx)*daX
--		local apy = 255-math.abs(y-gy)*daY
--		-- if gx -x > 70  then
--		-- 	ap = ap*0.9
--		-- end
--		if apx < 0 then
--			apx = 0
--		end

--		if apy < 0 then
--			apy = 0
--		end
--		local ap = (apx+apy)/2
--		grid:setOpacity(ap)
--		grid.grid2:setOpacity(ap)
--	end

--	if self.count <= 0 then
--		for c,d in pairs(self._turnCreature) do
--			if  (c:getPositionX() < x + 300) or (c:getPositionY() < y + 300) then
--				c:turnDirection(d)
--				self._turnCreature[c] = nil
--				-- self.count = 2
--				break
--			end
--		end
--	end
--	self.count = self.count - 1

	local gx,gy = Formula:sceneToGlobalPos(x,y)

--	if (scaleX > 0 and gx < 0 ) or (scaleX < 0 and gx > display.width) then
--		gx = 0
--	end
--	local fogX
--	if scaleX < 0 then
--		fogX = (gx) - ( display.cx ) - 110
--	else
--		fogX = gx + display.cx + 110
--	end

	if ( gx > display.width*0.3) or (gx < display.width*0.7) then
		x = -x + display.width*0.2
	end

--	if (scaleY > 0 and gy < 0 ) or (scaleY < 0 and gy > display.height) then
--		gy = 0
--	end
--	local fogY
--	if scaleY < 0 then
--		fogY = (gy) - ( display.cy ) - 110
--	else
--		fogY = gy + display.cy + 110
--	end
--	self.fog:setPosition(fogX,fogY)

	if ( gy > display.height*0.3) or ( gy < display.height*0.7) then
		y = -y + display.height*0.2
	end
	FightDirector:getCamera():setScenePos(x,y)
end

function FogRunner:run(dt)
	self.totalTime = self.totalTime - dt
	if self.totalTime <= self.forwardTime and self.callback then
		self.callback()
		self.callback = nil
	end
	self.curX = self.curX + self.speedX*dt
	self.curY = self.curY + self.speedY*dt

	if self.totalTime <= 0 then
		FightEngine:removeRunner(self)
	else
		self:_refreshFog()
	end
end

function FogRunner:dispose()
	self.callback = nil
	--self.fog:removeFromParent()
--	if self.magic then
--		self.magic:release()
--		self.magic = nil
--	end
--	for i,grid in ipairs(self.gridList) do
--		grid:removeFromParent()
--		grid:release()
--	end
--	self.gridList = nil
end


return FogRunner