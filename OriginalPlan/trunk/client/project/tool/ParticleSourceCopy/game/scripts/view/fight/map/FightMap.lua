--
-- Author: wdx
-- Date: 2014-05-05 11:32:51
--


local FightMap = nil

if isShowTile then
	FightMap = class("FightMap",function() return display.newNode() end)
else
	FightMap = class("FightMap")
end
 

FightMap.TILE_W = 140
FightMap.TILE_H = 60

local r = math.atan2(FightMap.TILE_H,FightMap.TILE_W)
FightMap.COS = math.cos(r)
FightMap.SIN = math.sin(r)
FightMap.TAN = math.tan(r)

FightMap.TILE_F = math.floor(FightMap.TILE_W/(FightMap.COS*2))   --斜边

--print("地图",r,FightMap.COS,FightMap.SIN,FightMap.TAN)

FightMap.W = 12
FightMap.H = 7

FightMap.NONE = 0   --可走
FightMap.BLOCK = -1  --阻挡

FightMap.OFFSET_X = FightMap.TILE_W/2    --偏移量x
FightMap.OFFSET_Y = FightMap.TILE_H/2*(FightMap.H + 1)  --偏移量y

function FightMap:ctor()
	self.astar = AStarPathFinding:new()  --a星

	if isShowTile then
		self:retain()
		--self:setPosition(FightMap.TILE_W/2 ,FightMap.TILE_H/2*(FightMap.H + 1) )
	end
end

function FightMap:initMap(id)
	--self.mapData = ConfigMgrCls:requestConfig("FightMap/"..id)
	

	self.astar:setMapDataRange(FightMap.H + 1,FightMap.W + 1)
	self.mapData = {}
	for i = 0 , FightMap.W do
		local row = {}
		for j = 0 , FightMap.H do
			--self.astar:setMapDataFlag(i  ,j  ,FightMap.NONE)
			local tile = Tile.new(i,j,FightMap.NONE)
			row[j] = tile

			if isShowTile then
				self:addChild(tile)
			end
		end
		self.mapData[i] = row
	end 

	-- local path = self:getPath(3,4,6,7)
	-- dump(path)
end

--是否可以占据  某个格子
function FightMap:canOccupy(w,h)
	local content = self.mapData[w][h]
	return title:canOccupy()
end

function FightMap:setTileContent(w,h,content)
	local title = self.mapData[w][h]
	title:setContent(content)
	self.astar:setMapDataFlag(w,h,content)
end

function FightMap:getPath(startX,startY,endX,endY)
	if self.astar:find(startX,startY,endX,endY) then
		return self.astar:getPathLua()
	else
		print("找不到路：",startX,startY,endX,endY)
	end
	return nil
end

function FightMap:getTilePos(mx,my)
	local tile = self.mapData[mx][my]
	if tile == nil then
		print(mx,my,"nil data")
	end
	return tile.x,tile.y
end

function FightMap:getTile(mx,my)

	local tile = self.mapData[mx][my]
	if tile == nil then
		print(mx,my,"nil data")
	end
	return tile
end

function FightMap:getSize()
	local startX =  self:getTilePos(0,0)
	local endX = self:getTilePos(FightMap.W ,FightMap.H)


	local x,startY = self:getTilePos(FightMap.W,0)
	local x,endY = self:getTilePos(0,FightMap.H)


	return (endX - startX + FightMap.TILE_W) , ( startY - endY + FightMap.TILE_H)
end

function FightMap:isNear( creature,target )
	if math.abs(creature.mx - target.mx) + math.abs(creature.my - target.my) <= 1 then
		return true
	else
		return false 
	end
end

function FightMap:creatureMoveTo( creature,mx,my)
	self:setTileContent(creature.mx,creature.my,FightMap.NONE)
	creature.mx = mx
	creature.my = my
	self:setTileContent(creature.mx,creature.my,creature.id)
	-- body
end

--获取 creature当前所在 格子
function FightMap:getCreatureTile(creature)
	return self:getTile(creature.mx,creature.my)
end

function FightMap:isInTileCenter( creature )
	local tile = self:getCreatureTile(creature)
	return tile:isCenter(creature:getPosition())
end

--获取精确的  格子坐标
function FightMap:getPreciseTilePos( creature )
	local x,y = creature:getPosition()   --根据当前坐标计算
	return self:toMapPos(x,y)
end

--实际坐标 转化到 地图坐标
function FightMap:toMapPos( x,y )
	x = x - FightMap.OFFSET_X + FightMap.TILE_W/2
	y = y - FightMap.OFFSET_Y --- FightMap.TILE_H/2
	
	local mx = math.floor( x/FightMap.TILE_W + y/FightMap.TILE_H)
	local my = math.floor( x/FightMap.TILE_W - y/FightMap.TILE_H)
	return mx,my
end

function FightMap:getTileContent( mx,my )
	local tile = self:getTile(mx,my)
	return tile:getContent()
end

--获取2个人之间的距离
function FightMap:getDistance( creature,target )
	return math.abs(creature.mx - target.mx) + math.abs(creature.my - target.my)
end

function FightMap:isLegal( mx,my )
	return mx >= 0 and mx <= FightMap.W and my >= 0 and my <= FightMap.H
end

--根据 位置  方向 速度  获取下一个tile
function FightMap:getNextTile( mx,my,direction,speed )
	local dx = (speed > 0 and 1 ) or (speed == 0 and 0) or (speed < 0 and -1)
	local dy = dx
	local tileX,tileY
	if direction == Creature.RIGHT_DOWN then
		tileX,tileY = mx, my + dy
	elseif direction == Creature.LEFT_DOWN then
		tileX,tileY = mx - dx, my
	elseif direction == Creature.RIGHT_UP then
		tileX,tileY = mx +dx, my
	elseif direction == Creature.LEFT_UP then
		tileX,tileY = mx, my - dy
	end
	return self:getTile(tileX,tileY)
end


function FightMap:dispose()
	self.astar:delete()
	self.mapData = nil

	if isShowTile then
		self:release()
	end
end

return FightMap

