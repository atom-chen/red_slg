local ComeOutHQ = class("ComeOutHQ")

function ComeOutHQ:ctor(team)
	local hq = FightDirector:getScene():getHQ(team)
	self.team = team

	if hq then
		hq.cInfo.comeOutRes = "hero/baseCar"
	end

	if hq and hq.cInfo.comeOutRes then
		self.res = hq.cInfo.comeOutRes
		self.av = Avatar:create()
		self.av:initWithResName(self.res)
		self.av:playAnimate(GameConst.STAND_ACTION.."_3",-1)
		-- if team == FightCommon.blue then
		-- 	local color = Avatar:create()
		-- 	color:initWithResName(self.res)
		-- 	color:playAnimate("y"..GameConst.STAND_ACTION.."_3",-1)
		-- 	self.av:addChild(color)
		-- 	self.av.colorAv = color
		-- end

		self.av:retain()
		FightDirector:getScene().elemLayer:addChild(self.av)

		local x,y = hq:getPosition()
		self.targetX = x
		if team == FightCommon.right then
			self.av:setScaleX(-1)
			self.speed = -0.1
			x = FightDirector:getScene().width + 100
		else
			self.speed = 0.1
			x = -100
		end
		self.av:setPosition(x,y)

		hq:removeFromParent()
	end
end

function ComeOutHQ:start(callback)
	if self.av then
		self.callback = callback
		FightEngine:addRunner(self)
	elseif callback then
		callback()
	end
end

function ComeOutHQ:run(dt)
	if self.targetX then
		local lastX = self.av:getPositionX()
		local x = lastX + self.speed*dt
		if (self.targetX - lastX)*(self.targetX-x) <= 0 then
			self.av:setPositionX(self.targetX)
			self.targetX = nil
			local fram = uihelper:getActionFram(self.res,GameConst.ATTACK_ACTION.."_3")
			self.actionTime = uihelper.getActionTime(self.res,GameConst.ATTACK_ACTION.."_3",fram)*1000
			self.av:playAnimate(GameConst.ATTACK_ACTION.."_3",1,fram)
			if self.av.colorAv then
				self.av.colorAv:playAnimate("y"..GameConst.ATTACK_ACTION.."_3",-1,fram)
			end
		else
			self.av:setPositionX(x)
		end
	else
		self.actionTime = self.actionTime - dt
		if self.actionTime <= 0 then
			if self.av then
				self:resetHQ()
				self.actionTime = 400
				return
			end
			local callback = self.callback
			FightEngine:removeRunner(self)
			if callback then
				callback()
			end
		end
	end
end

function ComeOutHQ:resetHQ()
	if self.av then
		self.av:removeFromParent()
		self.av:release()
		self.av = nil
	end
	local hq = FightDirector:getScene():getHQ(self.team)
	if hq and not hq:getParent() then
		FightDirector:getScene().elemLayer:addChild(hq)
	end
end

function ComeOutHQ:dispose()
	self:resetHQ()
	self.callback = nil
end

return ComeOutHQ