local SimpleMoveMagic = class("SimpleMoveMagic",Magic)

function SimpleMoveMagic:setTargetPos(x,y,speed,team)
	self.team = team
	self._tx = x
	self._ty = y
	self.speed = Formula:transformSpeed(self.info.speed or 300)

	local curX,curY = self:getPosition()
	self.totalTime = Formula:getDistanceByPos( curX,curY,self._tx,self._ty )/self.speed

	-- self.totalTime = 99999
	self._isMoveEnd = false
end

function SimpleMoveMagic:run(dt)
	if Magic.run(self,dt) then
		if not self._isMoveEnd then
			local curX,curY = self:getPosition()
			local nextX,nextY = Formula:getNextPos(curX,curY,self._tx,self._ty,self.speed,dt)
			-- print("移动啊、。。。。。。。。。。",curX,curY,nextX,nextY)
			self:setPosition(nextX,nextY)   --移动位置
			if self._tx == nextX and self._ty == nextY then
				self._isMoveEnd = true
				self:_checkHitKeyFrame()
				self.totalTime = self.curTime + 500
				-- self:_magicEnd()
			end
		end
	end
end

function SimpleMoveMagic:_checkHitKeyFrame()
	local keyframeList = self.info["keyframe"]
	if keyframeList then
		local frameTypeList = self.info["keyType"]
		for i,frame in ipairs(keyframeList) do
			-- print("击中了。。。。",self.magicId,frame,frameTypeList[i],self.info["keyMagic"] and self.info["keyMagic"][i] )
			if frame == -1 then  --  -1表示在  打中人的时候
				local frameType = frameTypeList[i]
				if frameType == Skill.MAGIC_KEY_FRAME then
					-- print("击中了。。。。",frame,frameType,self.info["keyMagic"] and self.info["keyMagic"][i] )
					self:_keyFrameHanlder(i) --播放一个魔法特效
				elseif frameType == Skill.ATTACK_KEY_FRAME then  --检测攻击到的
					self:_checkHitTarget(i)
				end
			end
		end
	end
end

function SimpleMoveMagic:setMaigcOffset(x,y)
	self._magicOffsetX = x
end

function SimpleMoveMagic:_checkShow()
	return true
end

function SimpleMoveMagic:reset()
	Magic.reset(self)
	self:setScale(1)
end

function SimpleMoveMagic:_createMagic(magicId,target)
	local magic = Magic._createMagic(self,magicId,target)
	if magic then
		local x = magic:getPositionX()
		local offX = magic:getOffset()
		if self.team == FightCommon.right then
			magic:setScaleX(-1)
			x = x - offX*2
		else
			magic:setScaleX(1)
		end
		magic.team = self.team
		magic._createMagic = self._createMagic
		if self._magicOffsetX then
			x = x + self._magicOffsetX
		end
		magic:setPositionX(x)
	end
	return magic
end

return SimpleMoveMagic