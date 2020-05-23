local Shadow = class("Shadow",function() return display.newXSprite() end)

function Shadow:ctor(res)
	if not res then
		return
	end
	self:initRes(res)
end

function Shadow:initRes(res)
	local arr = {9,5,3}
	local num = {9,5,1}
	self.directionNum = 0
	for i,d in ipairs(arr) do
		if AnimationMgr:getActionInfo(res,"shadow_"..d) then
			self.directionNum = num[i]
			break
		end
	end
	if self.directionNum == 0 then
		self:setSpriteImage("#fight_black.png")
		self:setPositionY(-20)
	else
		-- print("directionNum",self.directionNum,res)
		local aInfo = AnimationMgr:getAnimaInfo(res)
		local len = aInfo:getFrameLength()
		if self.directionNum == 1 then
			self:setSpriteImage("#"..res.."_f"..(len-1))
			self:setContentSize(CCSize(0,0))
		else
			self.res = res
			self.startFrame = len - self.directionNum - 1
		end
	end
end

function Shadow:setDirection(direction,turnD,rotation)
	if self.directionNum == 9 then
		turnD = turnD or direction
		self:setSpriteImage("#"..self.res.."_f"..(self.startFrame + turnD%10))
		self:setContentSize(CCSize(0,0))
		local s = Formula:getDirectionScaleX(turnD)
		self:setScaleX(s)
		if rotation then
			self:setRotation(rotation)
		end
	elseif self.directionNum == 5 then
		self:setSpriteImage("#"..self.res.."_f"..(self.startFrame + direction%10))
		self:setContentSize(CCSize(0,0))
		local s = Formula:getDirectionScaleX(direction)
		self:setScaleX(s)
		if rotation then
			self:setRotation(rotation)
		end
	elseif self.directionNum == 1 then
		turnD = turnD or direction
		local r = -Formula:getAngleByDirection(turnD)
		self:setRotation(r*180/math.pi)
	end
end

return Shadow