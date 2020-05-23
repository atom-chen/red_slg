local SplitExtend = {}
local MultiAvatar = game_require("view.fight.creature.MultiAvatar")

function SplitExtend.extend(creature)
	creature.atkAv = MultiAvatar.new("x",function(d) creature:updateAtkDirection(d) end)
	creature.atkAv:retain()
	creature._atkOffX = 0
	creature._atkOffY = 0


	function creature:_initAtkAV(turnTime)
		self.turnTime = turnTime or 1000
		self.avContainer:addChild(self.atkAv)
		self.atkAv:initWithResName(self.cInfo.res)

		self._isAtkOff = FightCfg:getResDirectionOffset(self._curAvRes,Creature.UP,Creature.UP)
		if self._isAtkOff then
			self.atkAv:addTurnListener(function(d) self:updateAtkTurn(d) end)
			self.av:addTurnListener(function(d) self:updateTurn(d) end)
		end

		if self.cInfo.team == FightCommon.blue then
			self.atkAv:addColorAv(self.cInfo.res)
		end
		local aInfo = AnimationMgr:getAnimaInfo(self.cInfo.res)
		self._atkOffX = -aInfo.offPaoX
		self._atkOffY = -aInfo.offPaoY
		self.atkAv:setPosition(self._atkOffX,self._atkOffY)
		-- print("位置啊。。。111。",aInfo.offPaoX,-aInfo.offPaoY)

		local arr = {Creature.UP,Creature.DOWN}
		local d
		if self.cInfo.team == FightCommon.left then
			-- arr[#arr+1] = Creature.RIGHT_UP
			-- arr[#arr+1] = Creature.RIGHT_DOWN
			d = Creature.RIGHT_UP
		else
			-- arr[#arr+1] = Creature.LEFT_UP
			-- arr[#arr+1] = Creature.LEFT_DOWN
			d = Creature.LEFT_DOWN
		end
		-- self.atkAv:setDirection(arr[math.random(1,#arr)])
		self.atkAv:turnDirection(d)
	end

	function creature:changeColor()
		Creature.changeColor(self)
		if self.atkAv:hasColor() then
			self.atkAv:removeColorAv()
		else
			self.atkAv:addColorAv(self._curAvRes)
		end
	end

	function creature:run(dt)
		Creature.run(self,dt)
		self.atkAv:turnRun(dt)
		-- if isTurn
	end

	function creature:updateDirection(direction)
		-- print(debug.traceback())
		Creature.updateDirection(self,direction)
		self:updateAtkOffset()
	end

	function creature:updateAtkDirection(direction)
		for i,magic in ipairs(self._magicList) do
			-- print("改变方向了。。。。。    ",magic:getDirectionType())
			if magic.getDirectionType and magic:getDirectionType() == 1 then
				magic:setDirection(direction)
			end
		end
		self:updateAtkOffset()
	end

	function creature:updateTurn(direction)
		self:updateAtkOffset()
	end

	function creature:updateAtkTurn(direction)
		self:updateAtkOffset()
	end

	function creature:updateAtkOffset()
		-- print(debug.traceback())
		-- print(self.av:getTurnDirection(),self.atkAv:getTurnDirection())
		if self._isAtkOff then
			local off = self:getCurAtkOffsetPos()
			if off then
				-- print(self.av:getTurnDirection(),self.atkAv:getTurnDirection(),off[1],off[2])
				self.atkAv:setPosition(self._atkOffX+off[1],self._atkOffY+off[2])
			end
		end
	end

	function creature:getCurAtkOffsetPos()
		return FightCfg:getResDirectionOffset(self._curAvRes,self.av:getTurnDirection(),self.atkAv:getTurnDirection())
	end

	function creature:turnDirection(direction)
		Creature.turnDirection(self,direction)
		self.atkAv:turnDirection(direction,self.turnTime)
	end

	function creature:turnAtkDirection(direction)
		self.atkAv:turnDirection(direction)
		local curDirection = self:getDirection()
		local d = Formula:turnDirection(curDirection,direction)
		-- print(debug.traceback())
		-- print("从。。",curDirection,d,direction)
		if d ~= curDirection and d ~= direction then
			Creature.turnDirection(self,d,self.turnTime)
		else
			Creature.setDirection(self,curDirection)
		end
	end

	function creature:setDirection(direction)
		Creature.setDirection(self,direction)
		self.atkAv:setDirection(direction)
	end

	function creature:setAtkDirection(direction)
		self.atkAv:setDirection(direction)
	end

	function creature:getAtkDirection()
		return self.atkAv:getDirection()
	end

	function creature:showAnimateFrame( frame,action,direction)
		if Creature.showAnimateFrame(self,frame,action,direction) then
			self.atkAv:showAnimateFrame(frame,action,direction)
		end
	end

	function creature:setDieEnd()
		Creature.setDieEnd(self)
		self.atkAv:clear()
		self.atkAv:removeFromParent()
	end

	function creature:dispose()
		self.atkAv:release()
		Creature.dispose(self)
	end
end

return SplitExtend