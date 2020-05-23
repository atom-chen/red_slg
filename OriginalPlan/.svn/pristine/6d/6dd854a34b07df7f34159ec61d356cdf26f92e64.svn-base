--
-- Author: Your Name
-- Date: 2014-05-12 15:47:43
--

local Tile = nil
local SELELCT_IMAGE = "#grid02.png"
local NO_SELELCT_IMAGE = "#grid01.png"

if isShowTile then
	Tile = class("Tile",function() return display.newXSprite() end)
else
	Tile = class("Tile")
end

function Tile:ctor(mx,my,content,color)
	self.mx = mx
	self.my = my
	self.content = content
	self.x=(self.mx-self.my)*(FightMap.TILE_W/2) + FightMap.HALF_TILE_W + FightMap.OFFSET_X
	self.y=(self.my+self.mx)*(FightMap.TILE_H/2)+ FightMap.HALF_TILE_H + FightMap.OFFSET_Y

	if isShowTile then
		self:retain()
		self:setPosition(self.x,self.y)
	 		local color = ccc3(255,255,255)
	 		if content == -1 then
	 			self:setSpriteImage(SELELCT_IMAGE)
	 		else
	 			self:setSpriteImage(NO_SELELCT_IMAGE)
	 		end
	 		self:setImageSize(CCSize(FightMap.TILE_W,FightMap.TILE_H))


	    	local label = ui.newTTFLabel({
			text = self.mx.." "..self.my,
			font = "Arial",
			size = 12,
			bold = 1,
			x = FightMap.TILE_W/2 -15,
			y = FightMap.TILE_H/2,
			color = color
			})
			label:setTag(1)
			self:addChild(label)
			self:setOpacity(100)
	end

	--print("精确格子坐标",self.x,self.y,self.mx,self.my, FightDirector:getMap():getPreciseTilePos(self))
end

function Tile:setTileColor(flag)
	if isShowTile then
		if flag then
			self:setSpriteImage(SELELCT_IMAGE)
		else
			self:setSpriteImage(NO_SELELCT_IMAGE)
		end
		self:setImageSize(CCSize(FightMap.TILE_W,FightMap.TILE_H))
	end
end

function Tile:setLabelColor(flag)
	local label = self:getChildByTag(1)
	if flag then
		label:setColor(ccc3(255,0,0))
	else
		label:setColor(ccc3(255,255,255))
	end
end

function Tile:setContent(content)
	self.content = content
end

function Tile:getOffsetPos(posLength)
	return Formula:getOffsetPos(self.x,self.y,posLength)
end

function Tile:getContent()
	return self.content
end

function Tile:canOccupy()
 	return self.content == FightMap.NONE
end

function Tile:canStandCreature(creature)
	return FightDirector:getMap():canStandCreature(self.mx,self.my,creature)
end

function Tile:canOccupyRang(posLength)
	return FightDirector:getMap():canOccupyRang(self.mx,self.my,posLength)
end

function Tile:isCenter( x,y,posLength )
	if posLength and posLength > 1 then
		local px,py = self:getOffsetPos(posLength)
		return MathUtil:isEquality(px,x) and MathUtil:isEquality(py,y)
	else
 		return MathUtil:isEquality(self.x,x) and MathUtil:isEquality(self.y,y)
 	end
end

function Tile:isElemInCenter(elem)
	local x,y = FightDirector:getMap():getElemMapXY(elem)

	return MathUtil:isEquality(self.x,x) and MathUtil:isEquality(self.y,y)
end

return Tile