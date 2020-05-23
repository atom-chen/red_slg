local FightCountDown = class("FightCountDown")

function FightCountDown:ctor( )
	self.pic = display.newXSprite("#com_sz3.png")
	--self.pic:setImageSize(CCSize(display.width+10,display.height+10))
	self.pic:setAnchorPoint(ccp(0.5,0.5))
	self.pic:setPosition(display.width/2,display.height/2)
	--self.pic:setOpacity(150)

	local panel = ViewMgr:getPanel(Panel.FIGHT)
	panel.sceneContainer:addChild(self.pic)
	self.pics = {"#com_sz3.png","#com_sz2.png","#com_sz1.png"}
end

function FightCountDown:start(callback)
	self.callback = callback
	self.totalTime = 1000*3
	self.curTime = 0
	FightEngine:addRunner(self)
	self.ketTime = {1,1000,2000}
end

function FightCountDown:run(dt)
	self.last = self.curTime
	self.curTime = self.curTime +dt
	self:_refreshPic()
	if self.curTime >= self.totalTime  then
		if  self.callback then
			self.callback()
			self.callback = nil
		end
		FightEngine:removeRunner(self)
	end

end

function FightCountDown:_refreshPic()
	for k,v in pairs( self.ketTime ) do
		if v>=self.last and v<self.curTime then
			self.pic:setSpriteImage(self.pics[k])
			self.pic:setScale(5)
			transition.scaleTo(self.pic, {time=0.5, scale=2})
			--self:runAction(seqAction)

		end
	end
end

function FightCountDown:dispose()
	if self.pic then
		self.pic:removeFromParent()
	end
end

return FightCountDown