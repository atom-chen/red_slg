--

local FightNum = class("FightNum")

function FightNum:init(text,x,y,parent,res,scale)
	if res then
		self.numNode = display.newXSprite(res)
	else
		self.numNode = ArtNumber.new("com_sz",text,0,true)
	end
	self.numNode:retain()
	self.numNode:setAnchorPoint(ccp(0.5,0))
	self.numNode:setScale(0.1)
	self.targetScale = scale or 1.1

	self.numNode:setPosition(x,y)
	parent:addChild(self.numNode,10)
	self.totalTime = 1000
	self.curTime = 0

	self.scaleSpeed = 0
	self.ySpeed = 0.25--math.random(10,30) * 0.02

	self.opacitySpeed = 0
	self.waitTime = 200
end

function FightNum:start()
	FightEngine:addRunner(self)
end

function FightNum:run(dt)
	if self.opacitySpeed == 0 then
		local addScale = self.scaleSpeed*dt
		local scale = self.numNode:getScale()
		self.scaleSpeed = self.scaleSpeed + 0.000055*dt
		if scale + addScale >= self.targetScale then
			self.numNode:setScale(self.targetScale)
			self.opacitySpeed = -0.2
			self.ySpeed = 0.01
		else
			self.numNode:setScale(scale+addScale)
		end
	else
		self.waitTime = self.waitTime - dt
		if self.waitTime > 0 then
			return
		end
		local opacity = self.numNode:getOpacity()
		opacity = opacity + self.opacitySpeed
		uihelper.setOpacity(self.numNode,opacity)

		self.opacitySpeed = self.opacitySpeed - 0.02*dt
		self.ySpeed = self.ySpeed + 0.0002*dt
	end
	local y = self.numNode:getPositionY()
	y = y + self.ySpeed*dt
	self.numNode:setPositionY(y)

	self.curTime = self.curTime + dt
	if self.totalTime <= self.curTime then
		self:_endFightNum()
	end
end

function FightNum:_endFightNum()
	FightEngine:removeRunner(self)
end


function FightNum:dispose(  )
	self.numNode:removeFromParent()
	if self.numNode.dispose then
		self.numNode:dispose()
	end
	self.numNode:release()
end

return FightNum
