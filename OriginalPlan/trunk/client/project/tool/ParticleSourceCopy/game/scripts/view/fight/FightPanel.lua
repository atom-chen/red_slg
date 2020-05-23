--
-- Author: wdx
-- Date: 2014-04-25 11:14:39
--

FightDirector = require("view.fight.FightDirector")

local FightScene = require("view.fight.FightScene")

FightUi = require("view.fight.FightUi")

local FightPanel = class("FightPanel",PanelProtocol)


function FightPanel:ctor()
	PanelProtocol.ctor(self)
	self:initUI()

	FightDirector:addEventListener(FightCommon.RESULT,{self,self.onFightEnd})
end

function FightPanel:initUI()
	self.scene = FightScene.new()
	self:addChild(self.scene)
	self.scene:setTouchEnabled(true)
	self.scene:addTouchEventListener(handler(self,self._onTouchScene),false,0,true)

	self.ui = FightUi.new()
	self:addChild(self.ui)
end

--鼠标事件，
function FightPanel:_onTouchScene(event,x,y)
	local ret
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

function FightPanel:_onTouchBegan( e,x,y )
	self.mouseX = x
	self.mouseY = y
	return true
end

function FightPanel:_onTouchMoved(e,x,y )
	local dx = x - self.mouseX
	local dy = y - self.mouseY
	self.mouseX = x
	self.mouseY = y
	local curX,curY = self.scene:getPosition()
	local newX,newY = curX + dx,curY + dy

	local minX,maxX = display.width - self.scene.width - 20 , 0 + 20
	local minY,maxY = (display.height - self.scene.height) - 20, 0 + 20

	if newX < minX then newX = minX elseif newX > maxX then newX = maxX end
	if newY < minY then newY = minY elseif newY > maxY then newY = maxY end

	self.scene:setPosition(newX,newY)

	self.ui:move(newX-curX,newY-curY)
end

function FightPanel:_onTouchEnded( e,x,y )
	x,y = Formula:toScenePos(x,y)
	local mx,my = Formula:toMapPos(x, y)
	local tile = FightDirector:getMap():getTile(mx,my)
	if tile then
		local id = tile:getContent()
		print("pos",id)
		local creature = FightDirector:getScene():getCreature(id)
		if creature then

			FightDirector:getCamera():setFollowTarget(creature)
		end
	end
	return true
end

function FightPanel:start()

	FightDirector:start()
end


function FightPanel:onTestBegin( list)
	local info = {}
	local team1 = {}
	local team2 = {}

	info.team1 = team1
	info.team2 = team2

	for i,grid in ipairs(list) do
		if grid.mx < 6 then
			local hero = HeroCfg:getCloneHero(grid.id)
			hero.mx = grid.mx
			hero.my = grid.my
			hero.id = i
			hero.team = 1
			team1[#team1+1] = hero
		elseif grid.mx > 6 then
			local hero = HeroCfg:getCloneHero(grid.id)
			hero.mx = grid.mx
			hero.my = grid.my
			hero.id = i
			hero.team = 2
			team2[#team2 + 1] = hero
		end
		grid:dispose()
	end
	FightDirector:start(info)

	self.ui:removeFromParent()
end

function FightPanel:onFightEnd(event)
	scheduler.performWithDelayGlobal(handler(self,self.resetUI),3)
end

function FightPanel:resetUI()
	FightDirector:stop()
	self.scene:clearElem()
	self:addChild(self.ui)
end

function FightPanel:getRoot()
	return ViewMgr.sceneRoot
end

function FightPanel:onEnter()
	FightDirector:initScene(self.scene)
end

function FightPanel:onExit()

end

return FightPanel