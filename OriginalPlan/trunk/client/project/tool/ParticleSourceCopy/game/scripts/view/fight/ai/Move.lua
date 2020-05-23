--
-- Author: wdx
-- Date: 2014-05-05 15:34:16
--

--[[--
移动ai
]]
local Move = class("Move")

function Move:ctor()
	-- body
end


function Move:init( creature )
	self.creature = creature
	
	self.actionFrameInfo = {}

	local actions = {Creature.STAND_ACTION,Creature.MOVE_ACTION,Creature.WIN_ACTION}

	for i,name in ipairs(actions) do
		local info = {}
		self.actionFrameInfo[name] = info

		local frame = creature:getAnimaFrameCount(name)  --动作总共多少帧

		info.frameTime = FightCommon.animationDefaultTime
		info.totalTime = frame*info.frameTime
	end

	self.curTime = 0

	--print("move",self.standTime,self.moveTime)
end

function Move:setTarget(target)
	self.nextTile = nil
	--target = nil
	if target  then
		local map = FightDirector:getMap()
		
		if map:isNear(self.creature,target) then   --已经在目标旁边了 
			local direction = AIMgr:getDirection(self.creature,target:getPosition())
			self.creature:setDirection(direction)
			return
		end
		
		local path = map:getPath(self.creature.mx,self.creature.my,target.mx,target.my)
		--print("move",self.creature.mx,self.creature.my,target.mx,target.my)
		if path and #path >= 4 then

			self.nextTile = map:getTile(path[3],path[4])
			
			self.direction = AIMgr:getDirection(self.creature,self.nextTile.x,self.nextTile.y)
			
			local curPosX,curPosY = self.creature:getPosition()

			self.speedX,self.speedY = self.creature:getSpeedXY() 

			local dx = (self.nextTile.x - curPosX)
			local dy = (self.nextTile.y - curPosY)
			self.speedX = ( dx > 0 and self.speedX) or ( dx < 0 and -self.speedX) or 0
			self.speedY = ( dy > 0 and self.speedY) or ( dy < 0 and -self.speedY) or 0
			
			FightDirector:getMap():creatureMoveTo(self.creature,self.nextTile.mx,self.nextTile.my)

		end
	end
end

function Move:isInTileCenter()
	return FightDirector:getMap():isInTileCenter(self.creature)
end

function Move:run(dt)
	self.curTime = self.curTime + dt

	if self.nextTile then
		
		local map = FightDirector:getMap()
		
		local x,y = self.creature:getPosition()

		local newX = x + self.speedX*dt
		local newY = y + self.speedY*dt

		--local mx,my = map:getCurTilePos(self.creature)
		--print("当前：",mx,my,x,y," 目标： ",self.nextTile.mx,self.nextTile.my,self.nextTile.x,self.nextTile.y)


		if math.abs(newX - x) - math.abs( self.nextTile.x - x) > 0 then
			local tile = map:getCreatureTile(self.creature)
			self.creature:setPosition(tile.x,tile.y)
			self.nextTile = nil
			print("走完了",self.creature:getPosition())
		else
			self.creature:setPosition(newX,newY)
		end

		self:_showAnimate(Creature.MOVE_ACTION,self.direction)
	elseif self.creature.isWin then  --胜利了
		self:_showAnimate(Creature.WIN_ACTION,Creature.RIGHT_DOWN)
	else  --正常待机状态
		self:_showAnimate(Creature.STAND_ACTION)
	end
end

function Move:_showAnimate( ation,direction )
	local info = self.actionFrameInfo[ation] 
	local totalTime = info.totalTime
	while self.curTime > totalTime do
		self.curTime = self.curTime - totalTime
	end


	local newFrame = math.floor(self.curTime/info.frameTime)
	--print("播放：",ation,newFrame)
	self.creature:showAnimateFrame(newFrame ,ation,direction)


	--if ation == Creature.STAND_ACTION then
	--	print("待机",self.curTime,totalTime,newFrame)
	--end
end

return Move