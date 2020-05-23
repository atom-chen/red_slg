local RocketMagic = class("RocketMagic",Magic)
--火箭炮 上升后 再往下


local upHeight = 100
local maxMiddleHeight = 300

function RocketMagic:start(root)
	Magic.start(self,root)

	self:setRotation(-90)

	self.speed = Formula:transformSpeed(self.info.speed or 300)--

	local curY = self:getPositionY()
	self.maxY = curY + upHeight

	self.srcPos = {}
	self.srcPos.x,self.srcPos.y = self:getPositionX() ,self.maxY
	local offsetX,offsetY = self:getOffset()

	-- self.srcPos.x = self.srcPos.x + offsetX

	self.targetPos = {}
	self.targetPos.x,self.targetPos.y = self.target:getTruePosition()
	self.middle = {x = self.srcPos.x + (self.targetPos.x - self.srcPos.x)/50, y = curY + maxMiddleHeight}
	self.arcTime = (math.abs(self.targetPos.x-self.srcPos.x)+math.abs(self.targetPos.y-self.srcPos.y))/self.speed
	self.curArcTime = 0

	self.totalTime = 9999999999
end

local function bezier(a,b,c,t)
    -- /// t为0到1的小数。
    local n = 1-t
    local np2 = n*n
    local nt = n*t
    local tp2 = t*t
    local x = np2*a.x+2*nt*b.x+tp2*c.x
    local y = np2*a.y+2*nt*b.y+tp2*c.y
    return x,y
end

function RocketMagic:run(dt)
	if Magic.run(self,dt) then
		if self.maxY then
			local curY = self:getPositionY() + dt*self.speed/4
			if curY >= self.maxY then
				self:setPositionY(self.maxY)
				self.maxY = nil
			else
				local scale = 1.3 - (self.middle.y - curY)/(maxMiddleHeight)*0.5
				if scale > 1.3 then
					scale = 1.3
				end
				self:setScale(scale)
				self:setPositionY(curY)
			end
		else
			self.curArcTime = self.curArcTime + dt
			local lastTime = self.curArcTime
			if lastTime > self.arcTime then
				lastTime = self.arcTime
			end
			local lastX,lastY = self:getPosition()

			local r = lastTime/self.arcTime
			local x,y = bezier(self.srcPos,self.middle,self.targetPos,r)

			self:setPosition(x,y)

			local r = math.atan2( y- lastY, x - lastX)
			r = -180*r/math.pi
			self:setRotation(r)

			local scale = 1.3 - (self.middle.y - y)/(maxMiddleHeight)*0.5
			scale = math.max(0.9,scale)
			self:setScale(scale)

			if self.curArcTime > self.arcTime then
				self:_checkHitKeyFrame(self.target)
				self:_magicEnd()
			end
		end
	end
end

function RocketMagic:_checkHitKeyFrame(target )
	local keyframeList = self.info["keyframe"]
	if keyframeList then
		local frameTypeList = self.info["keyType"]
		for i,frame in ipairs(keyframeList) do
			-- print("击中了。。。。",self.magicId,frame,frameTypeList[i],self.info["keyMagic"] and self.info["keyMagic"][i] )
			if frame == -1 then  --  -1表示在  打中人的时候
				local fType = frameTypeList[i]
				local frameType = frameTypeList[i]
				if frameType == Skill.MAGIC_KEY_FRAME then
					self:_keyFrameHanlder(i,target,true) --播放一个魔法特效
				elseif frameType == Skill.ATTACK_KEY_FRAME then  --检测攻击到的
					self:_checkHitTarget(i)
				end
			end
		end
	end
end

function RocketMagic:_getDirection(creature,target)
	return Creature.RIGHT
end

return RocketMagic