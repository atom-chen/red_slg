--激光

local LaserMagic = class("LaserMagic",Magic)

function LaserMagic:start()
	local x,y = self.creature:getAtkPosition()
	local offsetX,offsetY = self:getOffset()
	self:setPosition(x+offsetX,y+offsetY)
	self:_updateLaser()
	Magic.start(self)
	-- self._lastHitTime = 0
	-- print(debug.traceback())
end

function LaserMagic:run(dt)
	if self.creature:isDie() or ( self.target:isDie() and self.curTime > 1000 ) then
		self:_magicEnd()
		return
	end

	-- if (self.curTime - self._lastHitTime) >= 1000 then
	-- 	self._lastHitTime = self._lastHitTime + 1000
	-- 	self:_checkHitKeyFrame(self.target)
	-- end
	if self.magicId ==9510 then
		print("KKKKKKKKKKKKKQQQQQQQQQQQQQQQQQ11111")
	end
	if Magic.run(self,dt) then
		self:_updateLaser()
		-- self:_updateLight()
	end
end

function LaserMagic:setDirection(d)
end

function LaserMagic:_getDirection(creature,target)
	return Creature.RIGHT
end

function LaserMagic:getDirection(creature,target)
	return Creature.RIGHT
end

function LaserMagic:getAddIndex()
	if self.info.dirAddIndex then
		local direction = self.creature:getAtkDirection()
		local d = direction%10
		return self.info.dirAddIndex[d] or 0
	else
		return self.info.addIndex or 0
	end
end

function  LaserMagic:getOffset()
	local x,y = 0,0
	local direction = self.creature:getAtkDirection()
	if self.info.x or self.info.y then
	 	x,y = self.info.x or 0, self.info.y or 0
	elseif self.info.dirX then
		local d = direction%10
		x,y = self.info.dirX[d],self.info.dirY[d]
	end
	x = x*Formula:getDirectionScaleX(direction)

	return  x,y
end

function LaserMagic:_updateLaser()
	local sx,sy = self:getPosition()

	local tx,ty = self.target:getTruePosition()
	-- ty = ty + self.target.cTitle:getPositionY()/4
	if self.skillParams.targetOffX then
		tx,ty = tx+self.skillParams.targetOffX,ty+self.skillParams.targetOffY
	end

	local r = math.atan2( ty-sy, tx - sx)
	local cosr = math.cos(r)
	local dx = (tx - sx) -- self.map.tileW/2
	if cosr ~= 0 then
		dx = dx/cosr
	end
	dx = math.abs(dx)
	dx = dx + 20
	r = 180*r/math.pi
	self:setRotation(-r)
	local scaleX = math.abs( (dx)/250 )  --100
	self:setScaleX(scaleX)

	if self.light then
		self.light:setScaleX(5)
	end
end

-- function LaserMagic:_checkHitKeyFrame(target )
-- 	local keyframeList = self.info["keyframe"]
-- 	if keyframeList then
-- 		local frameTypeList = self.info["keyType"]
-- 		for i,frame in ipairs(keyframeList) do
-- 			-- print("击中了。。。。",self.magicId,frame,frameTypeList[i],self.info["keyMagic"] and self.info["keyMagic"][i] )
-- 			if frame == -1 then  --  -1表示在  打中人的时候
-- 				local frameType = frameTypeList[i]
-- 				if frameType == Skill.MAGIC_KEY_FRAME then
-- 					-- print("击中了。。。。",frame,frameType,self.info["keyMagic"] and self.info["keyMagic"][i] )
-- 					self:_keyFrameHanlder(i,target,true) --播放一个魔法特效
-- 				elseif frameType == Skill.ATTACK_KEY_FRAME then  --检测攻击到的
-- 					if self:canHitTarget(target) then
-- 						self:_checkHitTarget(i,{target})
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end

return LaserMagic