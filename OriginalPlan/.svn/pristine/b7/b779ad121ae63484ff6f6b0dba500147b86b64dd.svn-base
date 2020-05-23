local WMMarchUnits = class("WMMarchUnits", function() return display.newNode(); end)

local MultiAvatar = game_require("view.fight.creature.MultiAvatar")
local WorldMarchSelectMenuPanel = game_require("view.world.worldUI.WorldMarchSelectMenuPanel")

function WMMarchUnits:ctor(map, marchNode, angle, bulletNode)
	--! WorldMap
	self._map = map
	--! WMMarchElemNode
	self._marchNode = marchNode
	self._bulletNode = bulletNode
	self:setPosition(marchNode:getSrcPos())
	marchNode:addChild(self)
	self._avUnits = {}
	self._marchUI = WorldMarchSelectMenuPanel.new(self._map:getPriority(),
		self._map, self, self._marchNode);
	self._marchUI:retain()
	self._marchUI:setScale(0.6)
	--! WorldMarchSelectMenuPanel
	self._menuUI = nil
	self._srcBlockPos = self._marchNode:getSrcBlockPos()
	self._destBlockPos = self._marchNode:getDestBlockPos()

	self._curTime = 0
	self._unitInterval = 20
	self._unitTeamNum = 4
	self._baseSpeed = 20
	self._moveSpeed = self._baseSpeed
	self._addSpeed = self._baseSpeed*0.25
	self._fightFlag = false
	self._angle = angle

	self._clickBtn = UIButton.new({"#tt_5.png","#tt_5.png","#tt_5.png","#tt_5.png"}, self._map:getPriority()-10, false)
	self._clickBtn:addEventListener(Event.MOUSE_UP, {self, self._clickFunc})
	self._clickBtn:setContentSize(CCSize(120,120))
	self._clickBtn:setAnchorPoint(ccp(0.5,0.5))
	self:addChild(self._clickBtn)
	self._selected = false
end

function WMMarchUnits:_clickFunc(event)
	--print("=================success=================")
	self._selected = true
end

function WMMarchUnits:setUnselect()
	self._selected = false;
end

function WMMarchUnits:isSelected()
	return self._selected
end

function WMMarchUnits:updateDirection(direction)

end

function WMMarchUnits:update(dt)
	self:showAnimate(dt)
	if self:isInScreen() then
		self:setVisible(true)
	else
		self:setVisible(false)
	end
end

function WMMarchUnits:hasSelected()
	return self._menuUI ~= nil;
end

function WMMarchUnits:selectAt()
	if self._menuUI == nil then
		self._menuUI = self._marchUI
	end
	if self._menuUI:getParent() == nil then
		self:addChild(self._menuUI);
	end
	self._menuUI:setPosition(self._uiPos)
	self._menuUI:showInfo(self._srcBlockPos, self._destBlockPos, self:isBackToHome())
end

function WMMarchUnits:unSelect()
	if self._menuUI ~= nil then
		self._menuUI:removeFromParent()
		self._menuUI = nil
	end
end

function WMMarchUnits:removeShootEffect(av)
	if av:getChildByTag(11) then
		av:removeChildByTag(11)
	end
end
function WMMarchUnits:removeShootEffectAll()
	for _,av in ipairs(self._avUnits) do
		self:removeShootEffect(av.av)
	end
end

function WMMarchUnits:shoot(av)
	local dirShoot = {461,462,463,464,465}
	local posShoot = {{0,64}, {31,37}, {47,17}, {33,-3}, {-2.3,-8.8}}
	self:removeShootEffect(av)
--	local shootEffect = ParticleMgr:CreateParticleSystem(dirShoot[self._direction%10])
--	av:addChild(shootEffect, 0, 11)
	local node = display.newNode();
--	local bulletEffect = ParticleMgr:CreateParticleSystem(10028)
--	node:addChild(bulletEffect)
	local bulletSpr = display.newSprite("ui/town/putong1.png")
	node:addChild(bulletSpr)
	bulletSpr:setScale(0.3)
	bulletSpr:setPosition(bulletSpr:getPositionX(), bulletSpr:getPositionY())
	local x,y = posShoot[self._direction%10][1], posShoot[self._direction%10][2]
	local pp = av:convertToWorldSpace(ccp(x,y))
	local pz = self._bulletNode:convertToNodeSpace(pp);
	node:setPosition(pz)
	node:setRotation(self._angle)
	node:setScale(0.7)
	self._bulletNode:addChild(node, 0, 12)

	local pp1 = self._map:getblockOriginNode():convertToWorldSpace(self._marchNode:getOrgDestPos());
	local pz1 = self._bulletNode:convertToNodeSpace(pp1);
	local function endFunc()
		node:removeFromParent()
		local key = tonumber(self._destBlockPos.x)*10000+tonumber(self._destBlockPos.y)
		if not self._bulletNode:getChildByTag(key) then
			local pr = ParticleMgr:CreateParticleSystem(20)
			local function prEnd()
				pr:removeFromParent()
			end
			local seqAction = CCSequence:createWithTwoActions(CCDelayTime:create(pr:GetCycleTotalTime()),
				CCCallFunc:create(prEnd))
			pr:stopAllActions()
			pr:runAction(seqAction)
			pr:setPosition(pz1)
			self._bulletNode:addChild(pr, 0, key)
		end
	end

	local seqAction = CCSequence:createWithTwoActions(CCMoveTo:create(0.1,pz1), CCCallFunc:create(endFunc))
	node:stopAllActions()
	node:runAction(seqAction)
end

function WMMarchUnits:isInScreen()
	local pos = self._map:getBlockPosAtMidOfMapNode()
	local tpos = self._map:getWorldPosFromBlockPos(pos)
	local wpos = self._map:convertToWorldSpace(tpos)
	local size = CCDirector:sharedDirector():getWinSize()
	local wspos = self:convertToWorldSpace(ccp(0,0))

--	print("=============", wspos.x, wspos.y)

	if wspos.x < 0 or wspos.y < 0 or wspos.x > 1136 or wspos.y > 640 then
		return false
	end

	return true
end

function WMMarchUnits:showAnimate(dt)
	self._curTime = self._curTime + dt*1000
	for _,av in ipairs(self._avUnits) do
		local info = nil
		if self._fightFlag then
			info = av.attackInfo
		else
			info = av.info
		end
		local newFrame = self._curTime/info.frameTime
		newFrame = newFrame%info.totalFrame
		av.av:showAnimateFrame(newFrame,info.actionName,self._direction)
		if self._fightFlag then
			if math.floor(newFrame) <= 1 and self:isInScreen() then
				self:shoot(av.av);
			end
		end
	end
end

function WMMarchUnits:init()
	self._srcPos = self._marchNode:getSrcPos()
	self._destPos = self._marchNode:getDestPos()

	self:forward();
	local poss,midPos = self:getUnitPoss()
	for _,v in ipairs(poss) do
		self:createUnit(v.pz, v.res, v.s)
	end
	self._allUnitPoss = poss
	self._uiPos = midPos
	self._clickBtn:setPosition(midPos)

	self:isInScreen()
end

function WMMarchUnits:getAllUnitPoss()
	return self._allUnitPoss
end

function WMMarchUnits:attackOther()
	local info = WorldMapModel:getAllElemInfoAt(self._destBlockPos)
	if info.base.hasElem then
		info.base.data.attackTime = os.time()
		info.base.data.now_blood = info.base.data.max_blood*0.2
		--! WMBaseElemNode
		local elem = self._map:getElemByPos(WorldMapModel.BASE, self._destBlockPos)
		if elem then
			elem:updateInfo(info.base)
		end
	elseif info.monster.hasElem then
		info.monster.data.attackTime = os.time()
		info.monster.data.now_populace = info.monster.data.max_populace*0.2
		--! WMBaseElemNode
		local elem = self._map:getElemByPos(WorldMapModel.MONSTER, self._destBlockPos)
		if elem then
			elem:updateInfo(info.monster)
		end
	end

	self._fightFlag = true
	self._curTime = 0;
	local function endFunc()
		self._fightFlag = false
		self:removeShootEffectAll()
		self:backToHome()
	end

	local seqAction = CCSequence:createWithTwoActions(CCDelayTime:create(5), CCCallFunc:create(endFunc))
	self:stopAllActions()
	self:runAction(seqAction)
end

function WMMarchUnits:forward()
	self._goFlag = true
	self._hasFinish = false

	local function endFunc()
		if self._goFlag then
			print("attack other!!!")
			self._goFlag = false
			self._moveSpeed = self._baseSpeed
			self:attackOther()
		end
	end

	local x,y = self:getPosition()
	local srcPos = ccp(x,y)
	local dist = cc.pGetDistance(srcPos, self._destPos)
	local destPos = srcPos:lerp(self._destPos, (dist-self._unitInterval*self._unitTeamNum)/dist);
	self:doMoveAction(srcPos, destPos, endFunc);
end

function WMMarchUnits:doMoveAction(srcPos, destPos, callFunc)
	self._direction = Formula:getDirectionBySpeed(destPos.x-srcPos.x, destPos.y-srcPos.y)
	local dist = cc.pGetDistance(srcPos, destPos)
	local moveAction = CCMoveTo:create(dist/self._moveSpeed, destPos)

	local seqAction = CCSequence:createWithTwoActions(moveAction, CCCallFunc:create(callFunc))
	self:stopAllActions()
	self:runAction(seqAction)
end

function WMMarchUnits:accelerate()
	if self._fightFlag then
		return
	end

	self._moveSpeed = self._moveSpeed+self._addSpeed

	if self._goFlag then
		self:forward();
	else
		self:backToHome();
	end
end

function WMMarchUnits:isFinish()
	return self._hasFinish
end

function WMMarchUnits:isBackToHome()
	return self._goFlag == false
end

function WMMarchUnits:backToHome()
	if self._menuUI ~= nil then
		self._menuUI:showInfo(self._srcBlockPos, self._destBlockPos, self:isBackToHome())
	end

	self._goFlag = false
	local x,y  = self:getPosition();
	local srcPos = ccp(x,y)
	local destPos = self._marchNode:getSrcPos()

	local function backHome()
		self._hasFinish = true
	end

	self:doMoveAction(srcPos, destPos, backHome)
end

function WMMarchUnits:createUnit(pos, res, s)
	local av = MultiAvatar.new("", function(d) self:updateDirection(d) end)

	local info = {}
	local aInfo = AnimationMgr:getActionInfo(res, "move_1")  --动作信息
	local aFrame = aInfo:getFrameLength()  --动作总共多少帧
	if aInfo.frequency and aInfo.frequency > 0 then
		info.frameTime = math.floor(1000/aInfo.frequency)
	else
		info.frameTime = 30
	end
	info.actionName = "move"
	info.totalFrame = aFrame

	local attackInfo = {}
	aInfo = AnimationMgr:getActionInfo(res, "atk_1")  --动作信息
	aFrame = aInfo:getFrameLength()  --动作总共多少帧
	if aInfo.frequency and aInfo.frequency > 0 then
		attackInfo.frameTime = math.floor(1000/aInfo.frequency)
	else
		attackInfo.frameTime = 30
	end
	attackInfo.actionName = "atk"
	attackInfo.totalFrame = aFrame

	av:initWithResName(res)
	local node = display.newNode()
	node:addChild(av)
	node:setScale(s)
	node:setPosition(pos)
	self:addChild(node)
	av:showAnimateFrame(0, "move", self._direction)
	--av:setPosition(pos)
	table.insert(self._avUnits, {av=av, info=info, attackInfo = attackInfo})
end

function WMMarchUnits:getUnitPoss()
	local poss = {}
	local dist = cc.pGetDistance(self._srcPos, self._destPos)
	local count = dist/self._unitInterval

	local pt = cc.pSub(self._srcPos,self._destPos):normalize()
	local midPos = nil;
	local midIndex = math.floor(self._unitTeamNum/2)
	if self._unitTeamNum%2 ~= 0 then
		midIndex = midIndex+1;
	end

	for k=1, count do
		local p1 = self._srcPos:lerp(self._destPos, (self._unitInterval*k)/dist)
		local pl = self:getParent():convertToWorldSpace(p1)
		local pz= self:convertToNodeSpace(pl);
		if midIndex == k then
			midPos = pz;
		end
--		if k == 4 then
--			table.insert(poss, {pz=pz, res="hero/King", s = 0.3})
--		else
			local pp = ccp(pz.x,pz.y+10)
			local ps = {}
			ps.pz = pp:rotateByAngle(pz, pt:getAngle())
			if k == 4 then
				ps.res = "hero/Natasha"
				ps.s = 0.7
			elseif k == 3 then
				ps.res = "hero/Natasha"
				ps.s = 0.7
			elseif k == 2 then
--				ps.res = "hero/fashi"
--				ps.s = 0.5
				ps.res = "hero/Natasha"
				ps.s = 0.7
			elseif k == 1 then
--				ps.s = 0.4
--				ps.res = "hero/V3rocket"
				ps.res = "hero/Natasha"
				ps.s = 0.7
			end
			table.insert(poss, ps)
			ps = {}
			pp = ccp(pz.x,pz.y-10)
			ps.pz = pp:rotateByAngle(pz, pt:getAngle())
			if k == 4 then
				ps.res = "hero/Natasha"
				ps.s = 0.7
			elseif k == 3 then
				ps.res = "hero/Natasha"
				ps.s = 0.7
			elseif k == 2 then
--				ps.res = "hero/fashi"
--				ps.s = 0.5
				ps.res = "hero/Natasha"
				ps.s = 0.7
			elseif k == 1 then
--				ps.res = "hero/V3rocket"
--				ps.s = 0.4
				ps.res = "hero/Natasha"
				ps.s = 0.7
			end
			table.insert(poss, ps)
--		end
		if k >= self._unitTeamNum then
			break;
		end
	end

	return poss, midPos;
end

function WMMarchUnits:dispose()
	self._clickBtn:removeEventListener(Event.MOUSE_CLICK, {self, self._clickFunc})
	if self._menuUI ~= nil then
		self._menuUI:removeFromParent()
		self._menuUI = nil
	end
	self._marchUI:release()
	self._marchUI = nil;
	self:removeFromParent()
end

return WMMarchUnits
