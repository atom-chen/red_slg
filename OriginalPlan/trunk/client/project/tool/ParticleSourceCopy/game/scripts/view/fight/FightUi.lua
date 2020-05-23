--
-- Author: wdx
-- Date: 2014-04-25 11:30:45
--


local FightUi = class("FightUi",function()
								return display.newLayer()
								end)
local fGrid = require("view.fight.deom.fGrid")

function FightUi:ctor()
	self:retain()
	self.row = 5
	self.gridList = {}

	self.gridW = 70
	self.gridX = display.width - self.gridW*5
	for i = 1, 13 do
		self:newGrid(i)
	end

	self.moveGridList = {}
    --self.bottomBtn

    self.btn = uihelper.newLabelButton("开始",1)
	self.btn:retain()
	self.btn:setAnchorPoint(ccp(0.5, 0.5))
	self.btn:setPosition(display.width/2, 50)
	self.btn:addEventListener(Event.MOUSE_DOWN,{self, self._onOkBtn})
	self:addChild(self.btn)
end


function FightUi:onGirdMoveEnd( grid,x,y)
	local px,py = FightDirector:getScene():getPosition()
	x = x - px
	y = y - py

	local map = FightDirector:getMap()
	local mx,my = map:toMapPos(x,y)

	local index = table.indexOf(self.gridList, grid)
	if index > 0 then
		self:newGrid(index)
	end

	if map:isLegal(mx,my) and not self:isOverlap(mx,my,grid) then
		local x,y = map:getTilePos(mx,my)
		x = x + px - grid.width/2
		y = y + py - grid.height/2
		grid:setPosition(x,y)
		grid.mx = mx
		grid.my = my
		local index = table.indexOf(self.moveGridList, grid)
		if index == -1 then
			self.moveGridList[#self.moveGridList+1] = grid
		end
	else
		local index = table.indexOf(self.moveGridList, grid)
		if index > 0 then
			table.remove(self.moveGridList,index)
		end
		grid:dispose()
	end
end

function FightUi:isOverlap(mx,my,curGird)
	for i,grid in ipairs(self.moveGridList) do
		if grid.mx == mx and grid.my == my and curGird ~= grid then
			return true
		end
	end
	return false
end

function FightUi:move( dx,dy )
	for i,grid in ipairs(self.moveGridList) do
		local x, y = grid:getPosition()
		grid:setPosition(x+dx,y+dy)
	end
end

function FightUi:newGrid( index )
	local grid = fGrid.new(index)
	local mx = (index -1)%self.row
	local my = math.floor( (index -1 )/self.row)
	local x,y = self.gridX + mx*self.gridW , my*self.gridW
	grid:setPosition(x,y)
	self:addChild(grid)
	self.gridList[index] = grid
end

function FightUi:_onOkBtn(e)
	self:getParent():onTestBegin(self.moveGridList)
	self.moveGridList = {}
end

-- --鼠标事件，
-- function FightPanel:_onTouchScene(event,x,y)
-- 	local ret
-- 	if event == "began" then
-- 		ret = self:_onTouchBegan(event,x,y)
-- 	elseif event == "moved" then
-- 		self:_onTouchMoved(event,x,y)
-- 	elseif event == "ended" then
-- 		self:_onTouchEnded(event,x,y)
-- 	elseif event == "canceled" then
-- 		self:_onTouchEnded(event,x,y)
-- 	end
-- 	return ret
-- end

-- function FightPanel:_onTouchBegan( e,x,y )
-- 	local pos = self:convertToNodeSpace(ccp(x,y))
-- 	if pos.x > self.gridX and pos.y < self.gridW*3 then
-- 		local index = math.floor((pos.x - self.gridX)/self.gridW) + math.floor(pos.y/self.gridW)*self.row
-- 		local grid = self.gridList[index]
-- 		grid:setPosition(pos)
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end

-- function FightPanel:_onTouchMoved(e,x,y )
-- 	local dx = x - self.mouseX
-- 	local dy = y - self.mouseY
-- 	self.mouseX = x
-- 	self.mouseY = y
-- 	local curX,curY = self.scene:getPosition()
-- 	local newX,newY = curX + dx,curY + dy

-- 	local minX,maxX = display.width - self.scene.width,0
-- 	local minY,maxY = (display.height - self.scene.height),0
	
-- 	if newX < minX then newX = minX elseif newX > maxX then newX = maxX end
-- 	if newY < minY then newY = minY elseif newY > maxY then newY = maxY end

-- 	self.scene:setPosition(newX,newY)
-- end


function FightUi:dispose()
	self:release()
end



return FightUi