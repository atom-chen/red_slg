local SplitCreature = class("SplitCreature",Creature)

local SplitExtend = game_require("view.fight.creature.SplitExtend")
--local PassengerExtend = game_require("view.fight.creature.PassengerExtend")

function SplitCreature:ctor(info)
	SplitExtend.extend(self)
	Creature.ctor(self,info)
	self:_initAtkAV()
	-- self.shadow:setZOrder(10)
end

function SplitCreature:getAtkPosition()
	local x,y = self:getPosition()
	return x+self._atkOffX,y+self._atkOffY
end

function SplitCreature:setDieEnd()
	Creature.setDieEnd(self)
	SplitExtend.setDieEnd(self)
end

-- function SplitCreature:canMove()
-- 	if self._testTime == nil then
-- 		local dir = 11
-- 		local dir2 = 11
-- 		self._testTime = scheduler.scheduleGlobal(
-- 			function()
-- 				Creature.setDirection(self,dir2)
-- 				self:setAtkDirection(dir)
-- 				local off = FightCfg:getResDirectionOffset(self._curAvRes,dir2,dir)
-- 				if off then
-- 					self.atkAv:setPosition(self._atkOffX+off[1],self._atkOffY+off[2])
-- 				end
-- 				dir = dir + 1
-- 				if dir == 19 then
-- 					dir = 22
-- 				elseif dir == 29 then
-- 					dir = 11
-- 					dir2  = dir2 + 1
-- 					if dir2 == 19 then
-- 						dir2 = 22
-- 					elseif dir2 == 29 then
-- 						dir2 = 11
-- 					elseif dir2 == 25 then
-- 						dir2 = 26
-- 					end
-- 				elseif dir == 25 then
-- 					dir = 26
-- 				end
-- 			end

-- 			, 2)
-- 	end
-- 	return false
-- end



return SplitCreature