--有随机弧线的

local CircleTrackMagic = class("CircleTrackMagic",Magic)

function CircleTrackMagic:start(root)
	self.speed = Formula:transformSpeed(self.info.speed)--

	local randomRange = 40
	if self.info.type == 8 then
		randomRange = 20
	end
	if self.info.speedA then
		self.speedA = self.info.speedA[1]/1000
		self.speedAStartTime = self.info.speedA[2]
		self.speedATime = self.info.speedA[3]
	end

	local posLength = self.target.posLength
	local w,h = FightMap.HALF_TILE_W*posLength*0.8,FightMap.HALF_TILE_H*posLength*0.8
	self.tOffX,self.tOffY = math.random(-w,w),math.random(-h,h)

	local tx,ty = self.target:getTruePosition()
	tx = tx + self.tOffX
	ty = ty + self.tOffY

	local sx,sy = self:getPosition()
	local dx,dy = tx-sx,ty-sy
	-- local r = math.atan2(dy, dx)
	local r = Formula:getAngleByDirection(self.creature:getDirection())
	-- if self.creature.cInfo.team == FightCommon.enemy then
	-- 	print(" 角度。。。。1111",r*180/math.pi,self.creature:getDirection())
	-- end

	r = r + math.random(-randomRange,randomRange)*math.pi/180

	-- if self.creature.cInfo.team == FightCommon.enemy then
	-- 	print(" 角度。。。。2222222",r*180/math.pi)
	-- end

	self:setRotation(-r*180/math.pi)


	self.speedX = math.cos(r)*self.speed
	self.speedY = math.sin(r)*self.speed

	local t = (math.abs(dx)+math.abs(dy) )/self.speed
	self.turnSpeed = math.pi/(t)


	self.totalTime = 9099999999

	Magic.start(self,root)

	self._isHit = false
	-- print("self.tOffX,self.tOffY",self.tOffX,self.tOffY)
end

function CircleTrackMagic:getDirection()
	return Creature.RIGHT
end

function CircleTrackMagic:_getDirection(creature,target)
	return Creature.RIGHT
end


function CircleTrackMagic:run(dt)
	if self._isHit then
		-- if not self.target:isDie() then
		self:_checkHitKeyFrame(self.target)
		-- end
		self:_magicEnd()
		return
	end
	if Magic.run(self,dt) == false then
		return
	end



	local tx,ty = self.target:getTruePosition()
	tx = tx + self.tOffX
	ty = ty + self.tOffY
	local sx,sy = self:getPosition()
	local dx,dy = tx-sx,ty-sy

	local nextX,nextY,r
	if dx*dx + dy*dy <= self.speed*dt*self.speed*dt then
		self:setPosition(tx,ty)
		self._isHit = true
	else
		self.speedX,self.speedY,r = self:getCircleSpeed(dx,dy,dt)
		nextX = sx + self.speedX*dt
		nextY = sy + self.speedY*dt
		self:setRotation(-r*180/math.pi)
		self:setPosition(nextX,nextY)
	end

end

function CircleTrackMagic:getCircleSpeed(dx,dy,dt)
	local xa,ya
	local r = math.atan2(dy,dx)
	local sr = math.atan2(self.speedY,self.speedX)

	local targetR
	local speed = self.speed

	local tmp = -self.speedY*dx + self.speedX*dy
	local trunR = dt*self.turnSpeed

	if self.curTime > 200 then
		self.turnSpeed = self.turnSpeed + self.turnSpeed*0.003*dt
	end

	if self.curTime >= self.speedAStartTime then
		if self.speedATime > 0 then
			self.speedATime = self.speedATime - dt
			self.speed = self.speed + self.speedA*dt
		end
	end

	if tmp >= 0 then
		targetR = sr + trunR
	elseif tmp < 0 then
		targetR = sr - trunR
	end
	if (targetR-r)*(sr-r) < 0 then
		targetR = r
	end

	return math.cos(targetR)*speed,math.sin(targetR)*speed,targetR
end


function CircleTrackMagic:_checkHitKeyFrame(target )
	local keyframeList = self.info["keyframe"]
	if keyframeList then
		local frameTypeList = self.info["keyType"]
		for i,frame in ipairs(keyframeList) do
			-- print("击中了。。。。",self.magicId,frame,frameTypeList[i],self.info["keyMagic"] and self.info["keyMagic"][i] )
			if frame == -1 then  --  -1表示在  打中人的时候
				local fType = frameTypeList[i]
				local frameType = frameTypeList[i]

				if frameType == Skill.MAGIC_KEY_FRAME then
					-- print("击中了。。。。",frame,frameType,self.info["keyMagic"] and self.info["keyMagic"][i] )
					self:_keyFrameHanlder(i,target,true) --播放一个魔法特效
				elseif frameType == Skill.ATTACK_KEY_FRAME then  --检测攻击到的
					if self:canHitTarget(target) then
						self:_checkHitTarget(i,{target})
					end
				end
			end
		end
	end
end

return CircleTrackMagic