--
-- Author: wdx
-- Date: 2014-09-12 20:05:06
--

--简单的 magic   可独立于 fightEngine 单独播放  magic配置的 动画

local SimpleMagic = class("SimpleMagic",function() return display.newNode() end)

-- loop是播放次数   -1表示一直循环   -1的话需要自己手动dispose
function SimpleMagic:ctor( id,loop,mType)
	--mType是特效类型 1:ui magic 2:战斗 magic ,
	self.id = id
	self.loopTime = 0
	if loop == -1 then
		-- self.id = id
		self.mType = mType
		self:setNodeEventEnabled(true)
	else
		-- self:_init(id,loop or 1,mType or 1)
		self:_init(loop or 1,mType or 1)
		self:play()
	end
	self:retain()
end

-- function SimpleMagic:_init(id,loop,mType )
function SimpleMagic:_init(loop,mType )
	-- self.id = id
	self.loop = loop
	if self.loop == 0 then
		return
	end
	local info
	if mType == 1 then  --ui magic
		info = ResCfg:getUIMagic(self.id)
	else  --战斗 magic
		info = FightCfg:getMagic(self.id)
	end
	if not info then
		print("error: with magic id:", self.id.. ' type..' .. mType)
        return
	end
	self.frame = info.frame or 8

	if info.res then
		self.magicEf = Effect:createWithResName(info.res)

		local animaInfo = AnimationMgr:getAnimaInfo(info.res)
		self.actionName = animaInfo:getActionName(0)
		local aInfo = animaInfo:getActionInfo(self.actionName)

		self:addChild(self.magicEf)

		local totalFrame = aInfo:getFrameLength()  --总共多少帧
		self.loopTime = totalFrame*(1000/self.frame)/1000   --每次播放一次需要多少时间
	end

	if info.pId then
		local pId = info.pId
		if type(info.pId) == "table" then
			pId = info.pId[1]
		end
		print("PPPPPPPPPPP")
		dump(info)
		self.particle = ParticleMgr:CreateParticleSystem(pId)
		if self.particle then
		 	self:addChild(self.particle)
		 	self.loopTime = self.particle:GetCycleTotalTime()
		end
	end
end

--设置播放结束后的回调
function SimpleMagic:setEndCallback(callback)
	self.callback = callback
end

--获取特效播放一次所需要的时间
function SimpleMagic:getMagicTime()
	return self.loopTime
end

function SimpleMagic:play(  )
	--print("function SimpleMagic:play(  )", self.id, self.loop,self.magicEf,self.particle)
	if self.loop == 0 then
		return
	end
	if self._showTimer then
		scheduler.unscheduleGlobal(self._showTimer)
		self._showTimer = nil
	end

	if not self.magicEf and not self.particle then
		print(' not self.magicEf and not self.particle')
		return
	end

	if self.magicEf then
		self.magicEf:playAnimate(-1,self.frame)
	end
	if self.particle then
		self.particle:SetSuspend(false)
	end
	if self.loop > 0 then
		local totalTime = self.loopTime*self.loop
		self._showTimer = scheduler.performWithDelayGlobal(handler(self, self._playEnd),totalTime)
	end
end

function SimpleMagic:setMagicType( mType )
	self.mType = mType
end

function SimpleMagic:stop()
	if self.magicEf then
		self.magicEf:stopAnimate()
		self.magicEf:showAnimateFrame(1,self.actionName)
	end
	if self.particle then
		self.particle:MansualUpdate(0.03)
		self.particle:SetSuspend(true)
	end
	if self._showTimer then
		scheduler.unscheduleGlobal(self._showTimer)
		self._showTimer = nil
	end
end

function SimpleMagic:_playEnd()
	self._showTimer = nil
	local callback = self.callback
	self:dispose()
	if callback then   -- 有回调方法
		callback()
	end
end

function SimpleMagic:dispose(  )
	self:stop()
	self:setNodeEventEnabled(false)
	self:removeFromParent()
	self:release()
end

---------------------loop   -1  ----------------
function SimpleMagic:onEnter()
	if (not self.magicEf) and (not self.particle) then
		-- self:_init(id,-1,self.mType)
		self:_init(-1,self.mType)
	end
	self:play()
end

function SimpleMagic:onExit()
	self:stop()
	if self.magicEf then
		self.magicEf:removeFromParent()
		self.magicEf = nil
	end
	if self.particle then
		self.particle:removeFromParent()
		self.particle = nil
	end
end

return SimpleMagic
