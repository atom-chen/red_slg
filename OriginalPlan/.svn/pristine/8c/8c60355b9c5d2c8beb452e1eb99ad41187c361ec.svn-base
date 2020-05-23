

local FlyMove = class("FlyMove")

function FlyMove:init( creature )
	self.creature = creature

	-- self.creature.tMx,self.creature.tMy = creature.mx,creature.my

	local name = Creature.MOVE_ACTION

	local info = {}
	self.actionFrameInfo = info

	local aInfo = self.creature:getAnimationInfo(name )  --动作信息
	local aFrame = aInfo:getFrameLength()  --动作总共多少帧
	if aInfo.frequency and aInfo.frequency > 0 then
		info.frameTime = math.floor(1000/aInfo.frequency)
	else
		info.frameTime = FightCommon.animationDefaultTime
	end
	info.totalFrame = aFrame

	self.curTime = 0

	self.speedX = 0
	self.speedY = 0
	self.turnSpeed = math.pi/(self.creature.cInfo.turnSpeed or 600)

	--print("move",self.standTime,self.moveTime)
end

function FlyMove:setTarget(target)
	-- if target == nil then
	-- 	print(debug.traceback())
	-- end
	self.target = target
	if self.target then
		self:_flyTo()
	end
end

function FlyMove:move()
	local target = self.target
	if target  then
		local creature = self.creature
		if not creature:canMove() then  --中了buff 之类的  移动不了
			return true
		end

		return self:_flyTo()
	else  --没有目标
		return false
	end
end

function FlyMove:_flyTo()
	if self.creature.atkRange:isTargetIn(self.creature,self.target,true) then  -- is  in  atk Range
		local x,y = self.creature:getPosition()
		self:setMoveToTargetPos({x=x,y=y})
		self:creatureMoveTo(self.creature.mx,self.creature.my)
		return true
	else
		local mx,my = self:getPathTargetXY(self.creature,self.target)
		if mx or my then
			-- dump(FightDirector:getAir().airData)
			self:setMoveTile(mx,my,self.target.posLength)
			return true
		else
			-- print("no   啊啊啊  ")
			return false
		end
	end
end

function FlyMove:setMoveTile( mx,my,posLength )
	-- print(" 目标位置 ",mx,my,self.creature.id)
	-- print(debug.traceback())
	local x,y = Formula:toScenePos(mx, my)
	x,y = Formula:getOffsetPos(x,y,posLength or 1)
	self:setMoveToTargetPos({x=x,y=y})
	self:creatureMoveTo(mx,my)
end


function FlyMove:setMoveToTargetPos( pos )  --胜利后 跑出界面的   开始的时候跑进来的
	self.targetPos = pos
end

function FlyMove:isInTileCenter()
	if self.target then
		if self.creature.atkRange:isTargetIn(self.creature,self.target,true) and not self.creature:isTurning() then --盘旋
			return true
		end
	end
	if self.lastMx ~= self.creature.mx or self.lastMy ~= self.creature.my then
		self.lastMx = self.creature.mx
		self.lastMy = self.creature.my
		return true
	elseif self.targetPos then
		local x,y = self.creature:getPosition()
		if self.targetPos.x == x and self.targetPos.y == y then
			return true
		end
	elseif not self.target then
		return true
	else
		-- print("怎么回事啊。。。。",self.target and self.target:isDie())
		return false
	end
end

function FlyMove:setNextTile( tile )
end

--返回是否移动了
function FlyMove:run(dt)
	self.curTime = self.curTime + dt

	local targetX,targetY
	if self.targetPos then
		targetX,targetY = self.targetPos.x,self.targetPos.y
		-- print("run",targetX,targetY)
	elseif self.target then
		local mx,my = self:getPathTargetXY(self.creature,self.target)
		if not mx and not my then
			return false
		end
		targetX,targetY = Formula:toScenePosByLength(mx,my,self.creature.posLength)
	end

	if targetX or targetY then
		if self:_moveto(targetX,targetY,dt) then
			self:_showAnimate()
			return true
		else
			return false
		end
	end
	return false
end

function FlyMove:_moveto(targetX,targetY,dt)
	return self:_straightTo(targetX,targetY,dt)
end

function FlyMove:_straightTo(targetX,targetY,dt)
	local x,y = self.creature:getPosition()
	local dx,dy = targetX-x,targetY-y
	if dx == 0 and dy == 0 then
		return false
	end

	local direction = AIMgr:getDirectionBySpeed(dx,dy)

	-- print("又 移动了？？？？",x,y,targetX,targetY,self.creature:getDirection() , direction )
	if self.creature:getDirection() ~= direction then
		self.creature:turnDirection(direction)
		return true
	end

	self.speedX,self.speedY,angle = self:getSpeedXY(dx,dy)

	self.direction = direction

	local newX = x + self.speedX*dt
	local newY = y + self.speedY*dt

	if self.speedX ~= 0 and  math.abs(newX - x) - math.abs( targetX - x) >= 0 then
		self.speedX = 0
		newX = targetX
	end
	if self.speedY ~= 0 and math.abs(newY - y) - math.abs( targetY - y) >= 0 then
		self.speedY = 0
		newY = targetY
	end
	self.creature:setPosition(newX,newY)
	FightDirector:getAir():updateCreaturePos(self.creature)
	if self.speedX == 0 and self.speedY == 0  then
		return false
	else
		return true
	end
end

function FlyMove:_circleTo( targetX,targetY,dt )
	local x,y = self.creature:getPosition()
	local dx,dy = targetX-x,targetY-y
	local angle
	self.speedX,self.speedY,angle = self:getCircleSpeed(dx,dy,dt)


	self.direction = AIMgr:getDirectionBySpeedEx(self.speedX,self.speedY)

	self.creature:setDirection(self.direction)

	local newX = x + self.speedX*dt
	local newY = y + self.speedY*dt

	self.creature:setPosition(newX,newY)
	FightDirector:getAir():updateCreaturePos(self.creature)
	return true
end

function FlyMove:_showAnimate( )
	local info = self.actionFrameInfo

	local newFrame = self.curTime/info.frameTime
	newFrame = newFrame%info.totalFrame
	self.creature:showAnimateFrame(newFrame ,Creature.MOVE_ACTION)
end

function FlyMove:updateStraightSpeed(targetX,targetY)
	local x,y = self.creature:getPosition()
	local dx,dy = targetX-x,targetY-y
	if dx == 0 and dy == 0 then
		return false
	end
	self.speedX,self.speedY = self:getSpeedXY(dx,dy)
end

function FlyMove:getSpeedXY(dx,dy)
	local r = math.atan2(dy,dx)
	local cos,sin = math.cos(r),math.sin(r)
	local speed = self.creature.cInfo.speed
	local newSpeedX = cos*speed
	local newSpeedY = sin*speed
	return newSpeedX,newSpeedY
end

function FlyMove:getCircleSpeed(dx,dy,dt)
	local xa,ya
	local r = math.atan2(dy,dx)
	local sr = math.atan2(self.speedY,self.speedX)

	local newSpeedX
	local newSpeedY

	local targetR
	local speed = self.creature.cInfo.speed
	if self.speedX == 0 and self.speedY == 0 then
		newSpeedX = math.cos(r)*speed
		newSpeedY = math.sin(r)*speed
		targetR = r
	else
		local tmp = -self.speedY*dx + self.speedX*dy
		local trunR = dt*self.turnSpeed
		if tmp >= 0 then
			targetR = sr + trunR
		elseif tmp < 0 then
			targetR = sr - trunR
		end
		if (targetR-r)*(sr-r) < 0 then
			targetR = r
		end
		local dr = math.abs(targetR-sr)
		speed = speed + 0.8*speed*dr/trunR
		local cos,sin = math.cos(targetR),math.sin(targetR)

		newSpeedX = cos*speed
		newSpeedY = sin*speed
	end

	return newSpeedX,newSpeedY,targetR
end


function FlyMove:creatureMoveTo( mx,my )
	FightDirector:getAir():creatureMoveTo(self.creature,mx,my)
end

function FlyMove:getPathTargetXY(creature,target)
	-- print(creature.cInfo.atkRange,creature.atkRange)
	local maxDis = creature.atkRange.maxDis
	if maxDis > 0 then
		local mx,my,tx,ty = creature.mx,creature.my,target.mx,target.my
		local dx,dy = tx - mx,ty-my
		local curDis = math.abs(dx) + math.abs(dy)*Formula.Y_RATE
		local rate = maxDis/curDis
		dx,dy = math.floor(dx*rate),math.floor(dy*rate)

		local startX,startY = tx - dx, ty -dy

		local r = -math.atan2(dy,dx)
		local cos,sin = math.cos(r),math.sin(r)

		local toGlobal = function(x,y)
			return math.floor(startX + cos*x + sin*y + 0.5), math.floor(startY + cos*y + sin*x+0.5)
		end

	 	for x=0,2*maxDis do
	 		for y=0,x do
	 			local gx,gy = toGlobal(x,y)
	 			if Formula:getDistanceHalfHeight(gx,gy,tx,ty) <= maxDis then
	 				if FightDirector:getAir():canStand(gx,gy,creature) then
	 					return gx,gy
	 				end
	 			end
	 		end
	 	end
	end
	local x,y = FightDirector:getAir():getCreatureRoundGap(target,creature)
	if x or y then
		return x,y
	else
		return target.mx,target.my--FightDirector:getAir():getCreatureRoundGap(target,creature)
	end
end

function FlyMove:dispose()
	self.creature = nil
end

return FlyMove