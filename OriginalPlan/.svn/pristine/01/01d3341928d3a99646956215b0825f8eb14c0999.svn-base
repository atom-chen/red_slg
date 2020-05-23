--
-- Author: zhangzhen
-- Date: 2016-07-02 20:51:57
--

local fGrid = class("fGrid",TouchBase)

function fGrid:ctor(fUI,id,fightHero,priority,w,h)
	-- body
	TouchBase.ctor(self,priority)
	EventProtocol.extend(self)
	self.ui = fUI
	self.fightHero = fightHero
	self.id = fightHero.cInfo.id

	self.container = display.newNode()
	self:addChild(self.container)

	self.frame = display.newXSprite("#fight_txk_b_01.png")
	self.frame:setAnchorPoint(ccp(0,0))
	self.container:addChild(self.frame,-1)
	local size = self.frame:getContentSize()
	self.width = size.width
	self.height = size.height

	self:setContentSize(size)
	self.sp = display.newXClipSprite()

	self.container:addChild(self.sp)
	local res = ResCfg:getRes(self.fightHero.cInfo.head, ".pvr.ccz")
	local size = self:getContentSize()
	self.sp:setSpriteImage(res,"#fight_txk_b_01.png",true)
	self.sp:setPosition(size.width/2+5,size.height/2-5)

	self.blood = UIProgressBar.new("#fight_txk_b_02.png","#fight_txk_dg.png",CCSize(56,50),CCSize(56,63))
	self.blood:setAnchorPoint(ccp(0,0))
	self.blood:setPosition(0,0)
	self.blood:setClipMode(true)
	self.blood:bottomToTop(true)
	self.blood:setBarOpacity(220)
	self.container:addChild(self.blood)

	self.skillCd = UIProgressBar.new("#fight_txk_nlt.png","#fight_txk_nltk.png",CCSize(49,8),CCSize(49,8))
	self.skillCd:setAnchorPoint(ccp(0,0))
	self.skillCd:setPosition(3,3)
	self.skillCd:setClipMode(true)
	self.container:addChild(self.skillCd)

	self.curTime = 0
	EventProtocol.extend(self)
	self:setNodeEventEnabled(true)
	FightEngine:addRunner(self)
end

function fGrid:run(dt)
	self.curTime = self.curTime + dt
	if self.curTime>1000 then
		self.blood:setCurProgress(self.fightHero.cInfo.maxHp-self.fightHero.cInfo.hp,self.fightHero.cInfo.maxHp)
		if self.fightHero and not self.fightHero:isDie() then
			local ai = AIMgr:getAI( self.fightHero )
			self.skillCd:setCurProgress(ai.actionAI:getSkillCd())
		else
			self.skillCd:setProgress(0)
		end
		self.curTime = 0
	end
	-- if self.fightHero:cutdownCD(dt) then
	-- 	self:addStock(1)
	-- 	return true
	-- else
	-- 	local r = math.min(1- self.fightHero:getCD()/self.fightHero:getMaxCD(),1)
	-- 	self.sp:setClipRect(CCRect(0,self.spHeight-self.spHeight*r,self.spWidth,self.spHeight*r))
	-- 	self.frame:setClipRect(CCRect(0,self.height-self.height*r,self.width,self.height*r))
	-- end
end

--鼠标事件，
function fGrid:_onTouch(event,x,y)
	if event == "began" then
		ret = self:_onTouchBegan(event,x,y)
	elseif event == "moved" then
		self:_onTouchMoved(event,x,y)
	elseif event == "ended" then
		self:_onTouchEnded(event,x,y)
	elseif event == "canceled" then
		self:_onTouchEnded(event,x,y)
	end
	return ret
end

function fGrid:_onTouchBegan( e,x,y )
	local pos = self:getParent():convertToNodeSpace(ccp(x,y))
	local rect = self:boundingBox()

	if rect:containsPoint(pos) then
		UIAction.shrink(self)
		self.curX,self.curY = x,y
		self.isMove = false
		return true
	else
		return false
	end
end

function fGrid:_onTouchMoved(e,x,y )
	local newX,newY = x , y

	if not self.isMove and math.abs(newX - self.curX) + math.abs(newY - self.curY) > 60 then
		self.isMove = true
	end
	return true
end

function fGrid:_onTouchEnded( e,x,y )
	UIAction.shrinkRecover(self)
	if not self.isMove then
		if FightDirector.status ~= FightCommon.start then
			return
		end
		--self:product()
		self:dispatchEvent({name = Event.MOUSE_CLICK})
	end
end

function fGrid:dispose()
	self.skillCd:dispose()
	self.blood:dispose()
	TouchBase.dispose(self)
end

return fGrid