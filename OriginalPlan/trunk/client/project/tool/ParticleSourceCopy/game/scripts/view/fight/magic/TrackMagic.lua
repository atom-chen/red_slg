--
-- Author: wdx
-- Date: 2014-04-22 15:50:31
--
--[[--
 弹道 轨迹 的 magic
]]

local TrackMagic = class("TrackMagic",Magic)

function TrackMagic:ctor()
	Magic.ctor(self)
end

function TrackMagic:start(root)
	Magic.start(self,root)
	self.loop = 1000000 --一直循环播放   直到 导弹 移动到目标
	
	self.speed = Formula:transformSpeed(self.info.speed)

end

function TrackMagic:run(dt)
	if Magic.run(self,dt) == false then
		return
	end

	local curX,curY = self:getPosition()

	local targetX, targetY = self.target:getPosition()

	local nextX,nextY = Formula:getNextPos(curX,curY,targetX,targetY,dt,self.speed)  --计算出 时间间隔 所能到达的点

	local r = math.atan2( targetY-curY, targetX - curX)
	self.magicEf:setRotation( 180*r/math.pi)
	
	if nextX == targetX and nextY == targetY   then  --移动到目标了

		if not self.target:isDie() then
			local fCfg =  FightCfg:getKeyFrameCfg(self.info,Skill.ATTACK_KEY_FRAME)
			if fCfg then
				if fCfg.maigc then  --再产生一个动画
					self._generateMagic(self.creature,fCfg.magic,self.target)
				end
				--print("魔法攻击！！！")
				local hurtNum = Formula:getHurt(self.creature,self.info,self.target)

				self.target:changeValue("hp",hurtNum)
				self:_generateMagic(self.creature,Magic.HURT_ID,self.target)
			end
		end
		self:_magicEnd()  --先移除自己的魔法特效
	else
		self:setPosition(nextX,nextY)   --移动位置
	end
end


return TrackMagic