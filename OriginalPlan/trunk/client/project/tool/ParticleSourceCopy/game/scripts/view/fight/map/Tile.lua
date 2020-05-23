--
-- Author: Your Name
-- Date: 2014-05-12 15:47:43
--

local Tile 

if isShowTile then
	Tile = class("Tile",function() return CCDrawNode:create() end)
else
	Tile = class("Tile")
end

function Tile:ctor(mx,my,content,color)
	self.mx = mx
	self.my = my
	self.content = content

	self.x = (self.mx ) * FightMap.TILE_W/2  + (self.my ) * FightMap.TILE_W/2 + FightMap.OFFSET_X
	self.y = (self.mx ) * FightMap.TILE_H/2 - (self.my ) * FightMap.TILE_H/2 + FightMap.OFFSET_Y


	if isShowTile then
		local lColor = color or ccc4f(0,1,0,0.5)
		local from = ccp(-FightMap.TILE_W/2,0)
		local to = ccp(0,FightMap.TILE_H/2)
	    self:drawSegment( from,to, 1, lColor)

	    from = ccp(0,FightMap.TILE_H/2)
	    to = ccp(FightMap.TILE_W/2,0)
	    self:drawSegment( from,to, 1, lColor)

	    from = ccp(FightMap.TILE_W/2,0)
	    to = ccp(0,-FightMap.TILE_H/2)
	    self:drawSegment( from,to, 1, lColor)

	    from = ccp(0,-FightMap.TILE_H/2)
	    to = ccp(-FightMap.TILE_W/2,0)
	    self:drawSegment( from,to, 1, lColor)

	    self:setPosition(self.x,self.y)

	    if color == nil then
	    	local label = ui.newTTFLabelWithOutline({
			text = self.mx..""..self.my,
			font = "Arial",
			size = 17,
			bold = 1,
			x = 0,
			y = 0,
			align = ui.TEXT_ALIGN_CENTER,
			outlineColor = ccc3(0,0,0),
			dimensions = CCSize(250, 47)
			})
			self:addChild(label)
	    end
	    

	end

	--print("精确格子坐标",self.x,self.y,self.mx,self.my, FightDirector:getMap():getPreciseTilePos(self))
end

function Tile:setContent(content)
	self.content = content

	-- if isShowTile then
	-- 	self:clear()
	-- 	local point = ccp(0,0)
	-- 	if content == FightMap.NONE then
	--     	self:drawDot( point, 4, ccc4f(0,1,0,0.5))
	-- 	else
	-- 		self:drawDot( point, 4, ccc4f(1,0,0,0.5))
	-- 	end
	    
	-- end
end

function Tile:getContent()
	return self.content
end

function Tile:canOccupy(  )
 	if self.content == FightMap.NONE then
 		return true
 	else
 		return false
 	end
end 

function Tile:isCenter( x,y )
 	return (self.x == x and self.y == y)
end



return Tile