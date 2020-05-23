--
-- Author: wdx
-- Date: 2014-04-22 14:52:28
--
local Magic = class("Magic",function()
							return display.newNode()
						end)

Magic.HURT_ID = 1

function Magic:ctor()

	self.curTime = 0
	self.keyframeHandler = nil

	self.magicEf = Effect:create()
	self.magicEf:retain()

	self:addChild(self.magicEf)

	self:retain()
end

function Magic:init(creature,magicId,target )
	self.creature = creature
	self.target = target
	self.info = FightCfg:getMagicCfg(magicId)

	assert(self.info ~= nil,"magic 配置有问题  找不到 魔法特效id ："..magicId)
end

function Magic:addKeyframeListener(keyframe,handler)
	if self.keyframeHandler == nil then
		self.keyframeHandler = {}
	end
	self.keyframeHandler[keyframe] = handler
end

function Magic:triggerKeyFrame(keyFrame)
	if self.keyframeHandler and self.keyframeHandler[keyFrame] then
		self.keyframeHandler[keyFrame](self)
	end
end

function Magic:start()
	self.curFrame = -1
	self.curTime = 0

	self.magicEf:initWithResName(self.info.res)

	self:initPos(self.info.parent)  --根据配置初始化位置
	

	self.loop = self.info.loop or 1
	self.curLoop = 0
	self.fTime = self.info.fTime or FightCommon.animationDefaultTime


	
	local aInfo = ResMgr:getActionInfo(self.info.res,Creature.STAND_ACTION)
	local totalFrame = aInfo:getFrameLength()  --总共多少帧
	
	self.animationTime = totalFrame* self.fTime  -- 乘以每帧时间   可配置

	if self.info.totalTime then
		self.totalTime = self.info.totalTime  --持续时间
	else
		self.totalTime = self.animationTime * self.loop
	end

	--一个动画开始的话   镜头焦点就设置  摄像机   
	--之后策划需求如果有变动   可以在magic配置里面 配置  某个magic是否需要镜头跟随
	--if(self.info.isFollow) then
	--local camera = FightDirector:getCamera()
	--camera:addFollowTarget(self)
end

--初始化位置
function Magic:initPos(posType)
	--添加在不同的地方    需要定位的话  可以在magic 配置添加  x ，y  定位
	-- self:setPostion(self.info.x,self.info.y)


	if posType == 1 then  --初始位置在触发方身上
		assert(self.creature ~= nil,"magic的 initPos属性 配置有问题  初始位置找不到目标。id ："..magicId)
		self.creature:addChild(self)
	elseif posType == 2 then   --初始位置在目标身上
		self.target:addChild(self)
	elseif posType == 3 then  --添加到全屏
		self:setPosition(self.creature:getPosition())
		FightDirector:getScene():addElem(self)
	end

	self.magicEf:setPosition(self.info.x or 0,self.info.y or 0)
end


function Magic:run(dt)
	if self.loop == 0 then
		return
	end

	self.curTime = self.curTime + dt

	local keyframeList = self.info["keyframe"]
	if keyframeList then
		for _,fCfg in ipairs(keyframeList) do    --处理关键帧 的 触发东西
			local time = self.fTime * fCfg.frame
			local keyFrameType = fCfg.keyType
			if time > self.curTime and time <= self.curTime + dt then
				if fCfg.magic then  --播放一个魔法特效
					self:_generateMagic(self.sourceId,fCfg.magic,self.target)
				end

				--比如还可以在 配置 的关键帧 参数里面 添加缩放的配置参数
				--就可以实现 播放到某一帧的时候  镜头聚焦下来 放大到场景上面
				--调用 FightDirector:getCamera():setScale(fCfg.scale,fCfg.speed)  
				--然后在 FightCamera里面稍微实现以下

				--self:triggerKeyFrame(keyFrameType)

				--还可以在配置里面加属性  以实现策划需要的 效果
			end
		end
	end

	if self.curTime >= self.animationTime*(self.curLoop +1 ) then   --大于技能的持续时间了   
		self.curLoop = self.curLoop + 1
	end

	if self.loop == self.curLoop or self.curTime >= self.totalTime then   --循环次数 够了   结束技能
		self:_magicEnd()  --结束了
		return false
	end

	self:_showCurFrame()
	return true
end

function Magic:_showCurFrame()
	local time = self.curTime%self.animationTime
	local newFrame = math.floor(time/self.fTime)
	
	if newFrame ~= self.curFrame then
		self.curFrame = newFrame
		self.magicEf:showAnimateFrame(self.curFrame)
	end
end

function Magic:_generateMagic(create,magicId,target)
	local magic = FightEngine:createMagic(create,magicId,target)
	FightEngine:addMagic(magic)
end

function Magic:_magicEnd()
	FightEngine:removeMagic(self)
	--同时移除镜头跟随自己
	--local camera = FightDirector:getFightCamera()
	--camera:removeFollowTarget(self)
	
end

function Magic:dispose()
	self.magicEf:release()
	if self.info.parent == 3 then
		FightDirector:getScene():removeElem(self)
	else
		self:removeFromParentAndCleanup(true)
	end
	
	self:release()
end

return Magic