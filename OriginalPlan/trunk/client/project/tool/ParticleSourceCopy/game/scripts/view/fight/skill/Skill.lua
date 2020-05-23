--
-- Author: wdx
-- Date: 2014-04-15 10:08:29
--

--[[--
技能基类 
]] 
local Skill = class("Skill")

Skill.ATTACK_KEY_FRAME = 0
Skill.MAGIC_KEY_FRAME = 1

Skill.END_KEY_FRAME = -100




function Skill:ctor()
	
	self.curTime = 0
	self.keyframeHandler = nil
end

function Skill:init( creature,skillId,target )
	self.creature = creature
	self.creature:retain()
	self.target = target
	self.info = FightCfg:getSkill(skillId)
	self.skillId =skillId
end

function Skill:addKeyframeListener(keyframe,handler)
	if self.keyframeHandler == nil then
		self.keyframeHandler = {}
	end
	self.keyframeHandler[keyframe] = handler
end

function Skill:triggerKeyFrame(keyFrame)
	if self.keyframeHandler and self.keyframeHandler[keyFrame] then
		self.keyframeHandler[keyFrame](self)
	end
end

function Skill:getCreature()
	return creature
end


function Skill:start()
	self.creature:addSkillCount()




	self.loop = self.info.loop or 1  --循环几次
	self.curLoop = 0
	self.fTime = self.info.fTime or FightCommon.animationDefaultTime


	self.action = self.info.action or Creature.ATTACK_ACTION
	local totalFrame = self.creature:getAnimaFrameCount(self.action )  --总共多少帧
	
	self.animationTime = totalFrame* self.fTime  -- 乘以每帧时间   可配置

	if self.info.totalTime then
		self.totalTime = self.info.totalTime  --持续时间
	else
		self.totalTime = self.animationTime * self.loop
	end

	if self.info.range then
		self.atkRange = Range.new(self.info.range)
	end

	if self.info.move then  --移动步数
		self.moveSpeed = (self.info.move * FightMap.TILE)/self.info.moveTime
		self:setMove(self.creature:getDirection(), self.info.move)
	end
end

function Skill:setMove( direction,moveDis)
	self.moveDirection = direction
	self.moveDis = moveDis
	local map = FightDirector:getMap()
	local mx,my = mpa:getPreciseTilePos(self.creature)  --当前玩家精确的格子
	local tile = map:getNextTile(mx,my,direction,self.moveSpeed)  --获取下一个要移动的格子
	if tile and tile:canOccupy() then   --格子可走
		self.nextTile = tile
	else
		self.nextTile = nil
	end
end

function Skill:run(dt)

	self:_checkKeyFrame(dt) --检测关键帧处理

	self:_ckeckMove(dt)  --移动

	self.curTime = self.curTime + dt

	if self.curTime >= self.animationTime*(self.curLoop + 1 ) then   --大于技能的持续时间了   
		self.curLoop = self.curLoop + 1
	end

	if self.loop == self.curLoop or self.curTime >= self.totalTime then   --循环次数 够了   结束技能
		self:_skillEnd()  --结束了
		return false
	end

	self:_showCurFrame()
	return true
end

--显示某一帧
function Skill:_showCurFrame()
	local time = self.curTime%self.animationTime
	local newFrame = math.floor(time/self.fTime)
	
	self.creature:showAnimateFrame(newFrame,self.action)
end

--移动
function Skill:_ckeckMove(dt)
	if self.nextTile then
		local targetX,targetY = self.nextTile.x,self.nextTile.y
		local curX ,curY = self.creature:getPosition()
		local nextX,nextY = Formula:getNextPos(curX,curY,targetX,targetY,dt,self.moveSpeed)  --计算出 时间间隔 所能到达的点
		self.creature:setPosition(nextX,nextY)
		if nextX == targetX and nextY == targetY then  --移动到指定格子了
			self.nextTile = nil
			self.moveDis = self.moveDis - 1
			if self.moveDis > 0 then  --还需要继续移动
				self:setMove(self.moveDirection,self.moveDis)
			end
		end
	end
end

--检测关键帧处理
function Skill:_checkKeyFrame( dt )
	local keyframeList = self.info["keyframe"]
	local frameTypeList = self.info["keyType"]
	local frameAgrList = self.info["keyAgr"]
	if keyframeList then
		for i,frame in ipairs(keyframeList) do   --处理关键帧 的 触发东西
			local time = self.fTime * frame
			if time > self.curTime and time <= self.curTime + dt then
				local frameType = frameTypeList[i]
				local frameAgr = frameAgrList[i]
				if frameType == Skill.MAGIC_KEY_FRAME then
					if frameAgr then
						self:_generateMagic(self.creature,frameAgr,self.target) --播放一个魔法特效
					end
				elseif frameType == Skill.ATTACK_KEY_FRAME then
					if self.atkRange and self.atkRange:isTargetIn(self.creature,self.target,true) then  --检测攻击
						--print("攻击到了")
						local hurtNum = Formula:getHurt(self.creature,self.skillId,self.target)

						self.target:changeValue("hp",hurtNum)
						self:_generateMagic(self.creature,Magic.HURT_ID,self.target)
					end

				elseif frameTyep == Skill.SKILL_KEY_FRAME then

				end
				if fCfg.magic then  
					
				end 
				--self:triggerKeyFrame(keyFrameType)
				--print("技能",self.info.id)
				--dump(self.atkRange)
				if keyFrameType == Skill.ATTACK_KEY_FRAME then 


				--比如还可以在 配置 的关键帧 参数里面 添加缩放的配置参数
				--就可以实现 播放到某一帧的时候  镜头聚焦下来 放大到场景上面
				--调用 FightDirector:getCamera():setScale(fCfg.scale,fCfg.speed)  
				--然后在 FightCamera里面稍微实现以下


				--还可以在配置里面加属性  以实现策划需要的 效果
				end
			end
		end
	end
end

--产生一个 magic
function Skill:_generateMagic(creature,magicId,target)
	local magic = FightEngine:createMagic(creature,magicId,target)
	FightEngine:addMagic(magic)
end

function Skill:_skillEnd()
	self.creature:removeSkillCount()
	FightEngine:removeSkill(self)
end


function Skill:dispose()
	if self.creature then
		self.creature:release()
		self.creature = nil
	end
	
end

return Skill

