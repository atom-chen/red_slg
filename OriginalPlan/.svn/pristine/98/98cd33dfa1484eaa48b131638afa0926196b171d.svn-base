--静止 站立
local Stand = class("Stand")

function Stand:init( creature )
	self.creature = creature

	local name = Creature.STAND_ACTION

	local info = {}
	self.actionFrameInfo = info

	local aInfo = self.creature:getAnimationInfo(name )  --动作信息
	local aFrame = aInfo:getFrameLength()  --动作总共多少帧
	if aInfo.frequency and aInfo.frequency > 0 then
		info.frameTime = math.floor(1000/aInfo.frequency)
	else
		info.frameTime = FightCommon.animationDefaultTime
	end
	info.totalFrame = aFrame
		-- local a  = AnimationMgr:getActionInfo(self.creature.cInfo.res,name .."_1")
		-- print("动作11111：：： ",name,a:getFrameLength())
		-- a  = AnimationMgr:getActionInfo(self.creature.cInfo.res,name .."_2")
		-- print("动作22222：：： ",name,aFrame)

	self.curTime = 0
	self.creature:showAnimateFrame(0,Creature.STAND_ACTION)
end

function Stand:run(dt)
	self.curTime = self.curTime + dt
	-- if self.creature.isWin and self.creature.cInfo.team == FightCommon.mate then  --胜利了
	-- 	self:_showAnimate(Creature.WIN_ACTION,Creature.RIGHT_DOWN,dt)
	-- else  --正常待机状态
		self:_showAnimate()
	-- end
end


function Stand:_showAnimate(  )

	local info = self.actionFrameInfo
	local newFrame = math.floor(self.curTime/info.frameTime)
	newFrame = newFrame%info.totalFrame


	if self.creature.cInfo.id ==TEST_HEROID_ID then
		print("KKKKKKKKKKKKK11111111111")
		print("播放：",newFrame)
	end
	self.creature:showAnimateFrame(newFrame ,Creature.STAND_ACTION)
	--if action == Creature.STAND_ACTION then
	--	print("待机",self.curTime,totalTime,newFrame)
	--end
end

function Stand:dispose()
	self.creature = nil
end


return Stand