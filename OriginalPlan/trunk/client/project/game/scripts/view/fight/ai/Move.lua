
--[[--
移动ai
]]
local Move = class("Move")

function Move:init( creature )
	self.creature = creature

	local info = {}
	self.actionFrameInfo = info
	local aInfo = self.creature:getAnimationInfo(Creature.MOVE_ACTION )  --动作信息
	local aFrame = aInfo:getFrameLength()  --动作总共多少帧
	if aInfo.frequency and aInfo.frequency > 0 then
		info.frameTime = math.floor(1000/aInfo.frequency)
	else
		info.frameTime = FightCommon.animationDefaultTime
	end
	info.totalFrame = aFrame
	self.curTime = 0
	self.direction = nil
end

function Move:setTarget(target)
	self.nextTile = nil
	self.target = target
end

function Move:setMoveTile( mx,my )
	local tile = FightDirector:getMap():getTile(mx,my)
	self:setNextTile(tile)
	self:creatureMoveTo(mx,my)
end

function Move:isInTileCenter()
	local flag = FightDirector:getMap():isInTileCenter(self.creature)
	return flag
end

function Move:move(tempTarget)
--	local check = function()
--		local dx,dy = FightDirector:getMap():getPreciseTilePos( self.creature )
--		if math.abs(dx-self.creature.mx) + math.abs(dy-self.creature.my)>=1 then
--			return true
--		end
--		return false
--	end

--	if check() then
--		return true
--	end

	if self.creature.cInfo.id== TEST_HEROID_ID then
		print("AAAAAAAAAAAAAAAAAACCCCCCCCCCCCCCCC11111111")
	end
	local target = tempTarget or self.target
	if target  then
		if self.creature.cInfo.id== TEST_HEROID_ID then
			print("AAAAAAAAAAAAAAAAAACCCCCCCCCCCCCCCC2222222",target.mx,target.my)
		end
		local creature = self.creature
		if not creature:canMove() or (creature.mx == target.mx and creature.my == target.my) then  --中了buff 之类的  移动不了
			return true
		end
		if self.creature.cInfo.id== TEST_HEROID_ID then
			print("AAAAAAAAAAAAAAAAAACCCCCCCCCCCCCCCC33333")
		end
		local path = self:getPath(creature,target)
		if path and #path >= 4 then
			self:setMoveTile(path[3],path[4])
--			local tile = FightDirector:getMap():getTile(path[len-1],path[len])
--			local pos = {x = tile.x,y = tile.y}
--			self:setMoveToTargetPos( pos )

--			if self.creature.cInfo.id== TEST_HEROID_ID then
--				print("AAAAAAAAAAAAAAAAAACCCCCCCCCCCCCCCC444444444",path[3],path[4],tile.mx,tile.my)
--			end
--			self:setNextTile(tile)

		else  --找不到路 移动失败 需要换目标
			return false
		end
		return true
	else  --没有目标
		return false
	end
end

function Move:setNextTile( tile )
	self.lastTile = self.nextTile
	self.nextTile = tile

	local tx,ty = Formula:getOffsetPos(self.nextTile.x,self.nextTile.y,self.creature.posLength)
	self.direction = AIMgr:getDirection(self.creature,tx,ty)
	self.creature:turnDirection(self.direction)
end

function Move:setMoveToTargetPos( pos )  --胜利后 跑出界面的   开始的时候跑进来的
	self.targetPos = pos
	if pos then
		self.direction = AIMgr:getDirection(self.creature,pos.x,pos.y)
		self.creature:turnDirection(self.direction)
	end
	self.target = nil
end


--返回是否移动了
function Move:run(dt)
	self.curTime = self.curTime + dt
	if self.direction and self.creature:getDirection() ~= self.direction then
		self.creature:turnDirection(self.direction)
		return false
	end

	if self.targetPos then  --有一个直接的目标了
		self:_showAnimate()
		local targetX,targetY = self.targetPos.x,self.targetPos.y
		targetX,targetY = Formula:getOffsetPos(targetX,targetY,self.creature.posLength)
		if self:_moveto(targetX,targetY,dt) then
		end
		return true
	end

	if not self.creature:canMove() then
		return false
	end

	local map = FightDirector:getMap()

	if self.nextTile == nil then
		if self:isInTileCenter() == false then
--			local tile = map:getCreatureTile(self.creature)
--			self:setNextTile(tile)
		end
	elseif self.nextTile.mx ~= self.creature.mx or self.nextTile.my ~= self.creature.my then
		local tile = map:getCreatureTile(self.creature)
		self:setNextTile(tile)
	end

	if self.nextTile then
		if self:_movetoTile(self.nextTile,dt) then
			-- local tile = map:getCreatureTile(self.creature)
			-- self.creature:setPosition(tile.x,tile.y)
			self.direction = nil
			self.nextTile = nil

			self:_showAnimate()

			return true   --走到定点了
		else
			self:_showAnimate()
		end
		return true
	end
	return false
end

function Move:_movetoTile(tile,dt)
	local tx,ty = tile:getOffsetPos(self.creature.posLength)
	return self:_moveto(tx,ty,dt)
end

function Move:_moveto( targetX,targetY,dt )
	local speedX,speedY = self:getSpeedXY(targetX,targetY)
	local x,y = self.creature:getPosition()
	-- if self.creature.posLength > 1 then
	-- 	print("移动。。。",x,y,targetX,targetY,speedX,speedY,self.creature.cInfo.name)
	-- end
	local newX = x + speedX*dt
	local newY = y + speedY*dt

	local mx,my = self.creature.mx,self.creature.my
	print("当前：",mx,my,x,y," 目标： ",targetX,targetY,speedX,speedY )
	if speedX ~= 0 and  math.abs(newX - x) - math.abs( targetX - x) >= 0 then
		speedX = 0
		newX = targetX
	end
	if speedY ~= 0 and math.abs(newY - y) - math.abs( targetY - y) >= 0 then
		speedY = 0
		newY = targetY
	end
	self.creature:setPosition(newX,newY)
	if speedX == 0 and speedY == 0  then
		return true
	else
		return false
	end
end

function Move:_showAnimate()
	local info = self.actionFrameInfo

	local newFrame = self.curTime/info.frameTime
	newFrame = newFrame%info.totalFrame
	self.creature:showAnimateFrame(newFrame ,Creature.MOVE_ACTION)
end

function Move:creatureMoveTo( mx,my )
	FightDirector:getMap():creatureMoveTo(self.creature,mx,my)
end

function Move:getSpeedXY(tx,ty)

	local curPosX,curPosY = self.creature:getPosition()
	local dx,dy = tx - curPosX, ty - curPosY
	local speedX,speedY

	if dx == 0 then
		speedX = 0
		speedY = self.creature.cInfo.speed
	elseif dy == 0 then
		speedX = self.creature.cInfo.speed
		speedY = 0
	elseif math.abs(dx/dy) == FightMap.TILE_W/FightMap.TILE_H then
		speedX = self.creature.cInfo.speedX
		speedY = self.creature.cInfo.speedY
	else
		local r = math.atan2(dy,dx)
		speedX = math.abs(self.creature.cInfo.speed * math.cos(r))
		speedY = math.abs(self.creature.cInfo.speed * math.sin(r))
	end
	speedX = ( dx > 0 and speedX) or ( dx < 0 and -speedX) or 0
	speedY = ( dy > 0 and speedY) or ( dy < 0 and -speedY) or 0
	return speedX,speedY
end

function Move:_getTargetXY(  )
	if self.targetPos then
		return self.targetPos.x,self.targetPos.y
	end
	return self.nextTile.x,self.nextTile.y
end

function Move:getPath( creature,target )
	-- local t = XUtil:getCurTime()
	local tx,ty = self:getPathTargetXY(creature,target)

	local path
	if tx then
		path = FightDirector:getMap():getPath(creature.mx,creature.my,tx,ty,creature.posLength)
	end

	if path == nil then  --找不到路 尝试往目标方向靠近
		local nextX,nextY = self:getNextToTarget(creature, target.mx, target.my,target.posLength)
		if nextX then
			path = {creature.mx,creature.my,nextX,nextY}
		end
	end

	return path
end

function Move:getPathTargetXY(creature,target)
	local maxDis = creature.atkRange.maxDis
	if not maxDis or  maxDis == 1 then
		return target.mx,target.my  --FightDirector:getMap():getCreatureRoundGap(target,creature)
	end

	local mx,my,tx,ty = creature.mx,creature.my,target.mx,target.my
	local dx,dy = tx - mx,(ty-my)

	local curDis = math.abs(dx) + math.abs(dy)*FightMap.TAN
	local rate = maxDis/curDis
	if dx < 0 then
		dx = math.ceil(dx*rate)
	else
		dx = math.floor(dx*rate)
	end
	if dy < 0 then
		dy = math.ceil(dy*rate)
	else
		dy = math.floor(dy*rate)
	end
	if rate >= 1 then
		return nil
	end

	local startX,startY = tx - dx, ty -dy
	local r = -math.atan2(dy,dx)
	local cos,sin = math.cos(r),math.sin(r)

	local toGlobal = function(x,y)
		return math.floor(startX + cos*x + sin*y + 0.5), math.floor(startY + cos*y + sin*x+0.5)
	end

 	local count = 0
 	for x=0,2*maxDis do
 		for y=0,x do
 			local gx,gy = toGlobal(x,y)
 			if Formula:getDistanceHalfHeight(gx,gy,tx,ty) <= maxDis then
 				if FightDirector:getMap():canStandCreature(gx,gy,creature) then
 					return gx,gy
 				end
 				count = count + 1
 				if count > 10 then
 					return target.mx,target.my
 				end
 			end
 		end
 	end
 	return target.mx,target.my
end

function Move:getNextToTarget(creature,tx,ty,posLength)
	local mx,my = creature.mx,creature.my
	local dx,dy = tx - mx , ty - my
	if dx > 0 then
		dx = 1
	elseif dx < 0 then
		dx = -1
	end
	if dy > 0 then
		dy = 1
	elseif dy < 0 then
		dy = -1
	end
	local map = FightDirector:getMap()
	local tile = map:getTile(mx+dx,my+dy)
	if tile and tile:canStandCreature(creature) then
		return tile.mx,tile.my
	end
	local arr
	if dx == 0 then
		arr = { {x=-1,y=dy},{x=1,y=dy},{x=1,y=0},{x=-1,y=0}}
	elseif dy == 0 then
		arr = { {x=dx ,y=1},{x=dx,y=-1},{x=0,y=1},{x=0,y=1}}
	else
		arr = { {x=dx,y=0},{x=0,y=dy},{x=dx,y=-dy},{x=-dx,y=dy}}
	end
	for i,pos in ipairs(arr) do
		tile = map:getTile(mx+pos.x,my+pos.y)
		if tile and tile:canStandCreature(creature)  then  --and self.lastTile ~= tile
			return tile.mx,tile.my
		end
	end
	return nil
end

function Move:dispose()
	self.creature = nil
end

return Move