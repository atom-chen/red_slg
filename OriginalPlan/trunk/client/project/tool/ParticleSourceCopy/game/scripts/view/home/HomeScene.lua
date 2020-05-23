--
-- Author: wdx
-- Date: 2014-06-07 10:19:44
--
local HomeElem = require("view.home.HomeElem")
local HomeScene = class("HomeScene",PanelProtocol)

function HomeScene:ctor()
	PanelProtocol.ctor(self,GameLayer.SCENE,Panel.HOME)

	self:initScene()
end

function HomeScene:initScene()
	ResMgr:loadPvr("ui/home/home.plist")
	self.isLoad = true

	self.bgList = {}
	for i=1,3 do
		local bg = display.newXSprite("#home_bg_"..i..".png")
		bg:setAnchorPoint(ccp(0,0))
		local size = bg:getContentSize()
		bg:setPosition( (display.width - size.width)/2, (display.height - size.height )/2)
		self.bgList[#self.bgList + 1] = bg
		self:addChild(bg)
		if i == 3 then
			self.bgWidth = size.width
			self.bgHeight = size.height
		end
	end

	local priority  = self:getPriority()

	self.touchNode = display.newLayer()
	self.touchNode:setTouchEnabled(true)
	self.touchNode:addTouchEventListener(handler(self,self._onTouch),false,priority,true)
	self:addChild(self.touchNode)

	local sys = {Panel.DUNGEON, Panel.FIGHT, Panel.BAG, Panel.ROLE}
	local images = {"#main_pvp_button.png","#main_shop_button.png","#unlock_skillupgrade.png","#unlock_specialshop.png"}
	local posList = {1000,100,  500,150,  800,20, 800,200}
	local addIndex = {3,3,3,2,3,3,3,3,3}


	self.elemList = {}
	for i,sName in ipairs(sys) do
		local elem = HomeElem.new(sName,images[i],priority-1)
		elem:setPosition(posList[2*i-1], posList[2*i] )
		self.bgList[addIndex[i]]:addChild(elem)
		self.elemList[#self.elemList + 1] = elem
	end


end

function HomeScene:_onTouch(event,x,y)
	local ret
	if event == "began" then
		ret = self:_onTouchBegin(x,y)
	elseif event == "moved" then
		self:_onTouchMoved(x,y)
	elseif event == "ended" then
		self:_onTouchEnd(x,y)
	elseif event == "canceled" then
		self:_onTouchEnd(x,y)
	end
	return ret
end

function HomeScene:_onTouchBegin( x,y )
	self.mouseX = x
	self.mouseY = y
	return true
end

function HomeScene:_onTouchMoved(x,y )
	local dx = x - self.mouseX
	local dy = y - self.mouseY
	self.mouseX = x
	self.mouseY = y


	local curX,curY = self.bgList[#self.bgList]:getPosition()
	local newX,newY = curX+dx,curY+dy

	local minX,maxX = display.width - self.bgWidth , 0
	-- local minY,maxY = (display.height - self.bgheight) - 80, 0

	if newX < minX then
		newX = minX
		dx = newX - curX
	elseif newX > maxX then
		newX = maxX
		dx = newX - curX
	end
	-- if newY < minY then newY = minY elseif newY > maxY then newY = maxY end

	for i=1,#self.bgList do
		local bg = self.bgList[i]
		local curX,curY = bg:getPosition()
		local addX = dx/(#self.bgList+1-i)
		local newX = curX + addX
		bg:setPositionX(newX)
	end
end

function HomeScene:_onTouchEnd( e,x,y )

end

function HomeScene:onOpened()
	if not self.isLoad then
		ResMgr:loadPvr("ui/home/home.plist")
		self.isLoad = true
	end
end


function HomeScene:onClosed(params)
	if params and params.unload then
		ResMgr:unload("ui/home/home.plist")
		self.isLoad = false
	end
end

return HomeScene