--
-- Author: wdx
-- Date: 2014-04-15 10:08:29
--
--[[--
 通用技能   读取 配置进行播放的
]]

local CommonSkill = class("CommonSkill",Skill)


function CommonSkill:ctor()
	Skill.ctor(self)
end

function CommonSkill:start()
	Skill.start(self)

	self.curFrame = -1

	if self.info and self.creature then
		self.action = self.info.action or Creature.ATTACK_ACTION
		local totalFrame = self.creature:getAnimaFrameCount(self.action )  --总共多少帧
		
		self.fTime = self.info.fTime or FightEngine.animationDefaultTime

		--总的持续时间
		self.durationTime = totalFrame* self.fTime -- 乘以每帧时间   可配置

		self.loop = self.info.loop or 1   --循环几次

		self.atkRange = Range.new(self.info.atkRange)
	end
end

function CommonSkill:run(dt)
	if self.loop == 0 then
		return
	end

	local keyframeList = self.info["keyframe"]
	if keyframeList then
		for _,fCfg in pairs(keyframeList) do   --处理关键帧 的 触发东西
			local time = self.fTime * fCfg.frame
			local keyFrameType = fCfg.keyType
			if time > self.curTime and time <= self.curTime + dt then
				if fCfg.magic then  --播放一个魔法特效
					self:_generateMagic(self.creature,fCfg.magic,self.target)
				end 
				self:triggerKeyFrame(keyFrameType)
				if keyFrameType == Skill.ATTACK_KEY_FRAME and self.atkRange:isTargetIn(self.creature,self.target,true) then  --检测攻击
					print("攻击到了")
					local hurtNum = Formula:getHurt(self.creature,self.info,self.target)

					self.target:changeValue("hp",hurtNum)
					self:_generateMagic(self.creature,Magic.HURT_ID,self.target)
				end


				--比如还可以在 配置 的关键帧 参数里面 添加缩放的配置参数
				--就可以实现 播放到某一帧的时候  镜头聚焦下来 放大到场景上面
				--调用 FightDirector:getCamera():setScale(fCfg.scale,fCfg.speed)  
				--然后在 FightCamera里面稍微实现以下


				--还可以在配置里面加属性  以实现策划需要的 效果

			end
		end
	end



	self.curTime = self.curTime + dt

	
	
	if self.curTime >= self.durationTime then   --大于技能的持续时间了   
		self.loop = self.loop - 1
		if self.loop == 0 then   --循环次数 够了   结束技能
			self:_skillEnd()
			return
		end
		self.curTime = 0
	end

	local newFrame = math.floor(self.curTime/self.fTime)
	--print("atk ", newFrame,self.action)
	self.creature:showAnimateFrame(newFrame,self.action)
end

function CommonSkill:dispose()
	Skill.dispose(self)
end

return CommonSkill

