--
--
local pairs = pairs
local ipairs = ipairs
local table = table

local FightMap = nil
local isBlockStand = true
if isShowTile then
	FightMap = class("FightMap",function() return display.newNode() end)
else
	FightMap = class("FightMap")
end


FightMap.TILE_W = 64--88--156
FightMap.TILE_H = 32--44--78

FightMap.HALF_TILE_W = FightMap.TILE_W/2
FightMap.HALF_TILE_H = FightMap.TILE_H/2

local r = math.atan2(FightMap.TILE_H,FightMap.TILE_W)
FightMap.COS = math.cos(r)
FightMap.SIN = math.sin(r)
FightMap.TAN = FightMap.TILE_H/FightMap.TILE_W

--FightMap.TILE_F = math.floor(FightMap.TILE_W/(FightMap.COS))   --斜边

-- print("地图",r,FightMap.COS,FightMap.SIN,FightMap.TAN,FightMap.TILE_F)

FightMap.W = FightCfg.MAP_W
FightMap.H = FightCfg.MAP_H

FightMap.NONE = 0   --可走
FightMap.BLOCK = -1  --阻挡

FightMap.TILE_MAX_W = 0
FightMap.TILE_MAX_H = 0
FightMap.OFFSET_X = 0--FightMap.TILE_W    --偏移量x
FightMap.OFFSET_Y = 0--FightMap.TILE_H  --偏移量y

function FightMap:ctor()
	self.astar = AStarPathFinding:new()  --a星

	if isShowTile then
		self:retain()
		--self:setPosition(FightMap.TILE_W/2 ,FightMap.TILE_H/2*(FightMap.H + 1) )
	end
	self.tileSpriteList = {}
end

function FightMap:getSize()
	return (FightMap.W)*FightMap.TILE_W,(FightMap.H)*FightMap.TILE_H
end

function FightMap:initMap(id,bgWidth,bgHeight)
	--self.mapData = ConfigMgrCls:requestConfig("FightMap/"..id)
	self:clear()
	-- bgHeight = bgHeight - 5*FightMap.TILE_H
	self.bgWidth = bgWidth
	self.bgHeight = bgHeight
	FightMap.W = math.floor(bgWidth/FightMap.TILE_W)-1
	FightMap.H = math.floor(bgHeight/FightMap.TILE_H)-1
	FightMap.TILE_MAX_W = math.floor(bgWidth/FightMap.TILE_W*2.3)
	FightMap.TILE_MAX_H = math.floor(bgHeight/FightMap.TILE_H*1.5)
	FightMap.OFFSET_X = self.bgWidth/2
	FightMap.OFFSET_Y = math.floor(-self.bgHeight/3)

	self.margin = 2
	if isShowTile then
		self:initMapDataEx(id)
	else
		self:initMapData(id)
	end
	--self:newInitMapData(id)
	self.bornXList = {[FightCommon.left] = 68,[FightCommon.right]=80}
	self.bornYList = {}
	self.bornYList[FightCommon.left] = {}
	self.bornYList[FightCommon.right] = {}
	for y=0,FightMap.H do
		if self:canOccupy(0,y) then
			table.insert(self.bornYList[FightCommon.left],y)
		end
		if self:canOccupy(FightMap.W,y) then
			table.insert(self.bornYList[FightCommon.right],y)
		end
	end

	--各个职业站位
	self.heroPos = Formula:getCreatureStandRange(FightMap.W,FightMap.H,self.margin)
	-- local path = self:getPath(3,4,6,7)
	-- dump(path)
end

function FightMap:initMapData(id)
	local cfg = FightCfg:getSceneCfg(id)
	local block = cfg.block or {}
	self.astar:setMapDataRange(FightMap.TILE_MAX_W + 1,FightMap.TILE_MAX_H + 1)
	local blocks = {}
	for _,info in ipairs(block) do
		blocks[info[1]..","..info[2]] = true
	end
	self.mapData = {}
	for i = 0 , FightMap.TILE_MAX_W do
		local row = {}
		for j = 0 , FightMap.TILE_MAX_H do
			local content = FightMap.NONE
--			for _,info in ipairs(block) do
--				if info[1] == i and info[2] == j then
--					content = FightMap.BLOCK
--					break
--				end
--			end
			if blocks[i..","..j] ~= nil then
				content = FightMap.BLOCK
			end
			--local dx,dy=self:toMapPos( x,y )
			self.astar:setMapDataFlag(i,j,content)
			local tile = Tile.new(i,j,content)
			row[j] = tile
		end
		self.mapData[i] = row
	end
end

function FightMap:initMapDataEx(id)
	local cfg = FightCfg:getSceneCfg(id)
	local block = cfg.block or {}
	self.astar:setMapDataRange(FightMap.TILE_MAX_W + 1,FightMap.TILE_MAX_H + 1)
	self.mapData = {}
	local blocks = {}
	for _,info in ipairs(block) do
		blocks[info[1]..","..info[2]] = true
	end
	for i = 0 , FightMap.TILE_MAX_W do
		local row = {}
		for j = 0 , FightMap.TILE_MAX_H do
			-- local content = FightMap.NONE
			-- if math.random(1,8) == 1 then
			-- 	content = 1
			-- end
			local content = FightMap.NONE
--			for _,info in ipairs(block) do
--				if info[1] == i and info[2] == j then
--					content = FightMap.BLOCK
--					break
--				end
--			end
			if blocks[i..","..j] ~= nil then
				content = FightMap.BLOCK
			end
			self.astar:setMapDataFlag(i,j,content)

			local tile = Tile.new(i,j,content)
			row[j] = tile

			if isShowTile then
				self:addChild(tile)
			-- 	tile:setVisible(false)
			end
		end
		self.mapData[i] = row
	end
end

--function FightMap:newInitMapData(id)
--	local cfg = FightCfg:getSceneCfg(id)
--	local block = cfg.block or {}
--	self.astar:setMapDataRange(FightMap.H + 1,FightMap.W + 1)
--	self.mapData = {}

--	local i,j;
--	local midW,midH,maxW,maxH,temp;
--	midW=self.bgWidth/2;
--	maxW=FightMap.W;
--	midH=self.bgHeight/2;
--	maxH=FightMap.W;

--	local addTile = function(i,j,x,y)
--			local content = FightMap.NONE
--			for _,info in ipairs(block) do
--				if info[1] == i and info[2] == j then
--					content = FightMap.BLOCK
--					break
--				end
--			end
--			self.astar:setMapDataFlag(i,j,content)

--			local tile = Tile.new(i,j,content,nil,x,y)
--			if not self.mapData[i] then
--				self.mapData[i] = {}
--			end
--			self.mapData[i][j] = tile

--			if isShowTile then
--				self:addChild(tile)
--			-- 	tile:setVisible(false)
--			end
--		end
--end

function FightMap:addBlock(mx,my)
	local tile = self:getTile(mx,my)
	if tile then
		self:setTileContent(mx,my,FightMap.BLOCK)
		tile:setTileColor(true)
	end
end

function FightMap:removeBlock(mx,my)
	local tile = self:getTile(mx,my)
	if tile and tile:getContent() == FightMap.BLOCK then
		self:setTileContent(mx,my,FightMap.NONE)
		tile:setTileColor(false)
	end
end

function FightMap:getWH(  )
	return FightMap.W,FightMap.H
end

function FightMap:getTileWH()
	return FightMap.TILE_W,FightMap.TILE_H
end

--是否可以占据  某个格子
function FightMap:canOccupy(mx,my)
	local tile = self:getTile(mx,my)
	if tile == nil then
		return false
	end
	return tile:canOccupy()
end

function FightMap:canOccupyRang(mx,my,posLength)
	if posLength > 1 then
		for i=0,posLength-1 do
			local x = mx + i
			for j=0,posLength-1 do
				local y = my +j
				if not self:canOccupy(x,y) then
					return false
				end
			end
		end
		return true
	else
		return self:canOccupy(mx,my)
	end
end

function FightMap:setTileContent(mx,my,content,posLength)
	-- print("设置地图信息。。",mx,my,content,posLength)
	if posLength and posLength > 1 then
		self:setTileSquareContent(mx,my,content,posLength)
	else
		local tile = self.mapData[mx][my]
		tile:setContent(content)
		self.astar:setMapDataFlag(mx,my,content)
	end
end

function FightMap:setTileSquareContent(mx,my,content,posLength)
	for i=0,posLength-1 do
		local tx = mx + i
		for j=0,posLength-1 do
			local ty = my + j
			if self:isLegal(tx,ty) then
				local title = self.mapData[tx][ty]
				title:setContent(content)
				self.astar:setMapDataFlag(tx,ty,content)
			end
		end
	end
end

--寻路
function FightMap:getPath(startX,startY,endX,endY,posLength)
	local isFind = false
	if posLength > 1 then
		isFind = self.astar:findRange(startX,startY,endX,endY,posLength)
	else
		isFind = self.astar:find(startX,startY,endX,endY)
	end

	if isFind then
		return self.astar:getPathLua()
	else
		print("找不到路：",startX,startY,endX,endY)
	end
	return nil
end

--寻路  无视不可走点
function FightMap:getPathEx( startX,startY,endX,endY )
	local path = {}
	if startX == endX and startY == endY then
		return path
	end
	local dx = endX-startX
	if dx < 0 then
		dx = -1
	elseif dx > 0 then
		dx = 1
	else
		dx = 0
	end
	local dy = endY-startY
	if dy < 0 then
		dy = -1
	elseif dy > 0 then
		dy = 1
	else
		dy = 0
	end

	while true do
		if startX ~= endX then
			startX = startX + dx
		end
		if startY ~= endY then
			startY = startY + dy
		end
		path[#path+1] = startX
		path[#path+1] = startY
		if startX == endX and startY == endY then
			return path
		end
	end
end

function FightMap:getTilePos(mx,my)
	local tile = self:getTile(mx,my)
	if tile then
		return tile.x,tile.y
	else
		return nil
	end
end

function FightMap:getTile(mx,my)
	if not self:isLegal( mx,my ) then
		print("is not legal",mx,my )
		return nil
	end
	return self.mapData[mx][my]
end

function FightMap:getTileOffsetPos(mx,my,posLength)
	local tile = self:getTile(mx,my)
	if tile then
		return tile:getOffsetPos(posLength)
	end
	return nil
end

function FightMap:isNear( creature,target )
	return Formula:isIntersect(creature.mx,creature.my,creature.posLength,target.mx,target.my,target.posLength)
end

function FightMap:isCreatureTile(creature)
	return self:getTileContent(creature.mx,creature.my) == creature.id
end

function FightMap:setTileContentByCreature(creature,content)
	content = content or creature.id
	self:setTileContent(creature.mx,creature.my,content ,creature.posLength)
end

function FightMap:removeTileContent(creature)
	if self:isCreatureTile(creature) then
		self:setTileContentByCreature(creature,FightMap.NONE)
	end
end

function FightMap:creatureMoveTo( creature,mx,my)
	self:removeTileContent(creature)
	creature.mx = mx
	creature.my = my
	if isBlockStand then
		self:setTileContentByCreature(creature)
	else
		self:setTileContentByCreature(creature,FightMap.NONE)
	end
	-- body
end

function FightMap:creatureSetTo(creature,mx,my)
	self:creatureMoveTo(creature,mx, my)
	local x,y = self:getTileOffsetPos(mx,my,creature.posLength)
	if x then
		creature:setPosition(x,y)
	end
end

function FightMap:canStandCreature(mx,my,creature)
	if isBlockStand then
		local posLength = creature.posLength
		if posLength > 1 then
			for i=0,posLength-1 do
				local x = mx + i
				for j=0,posLength-1 do
					local y = my +j
					local content = self:getTileContent( x,y )
					if content ~= FightMap.NONE then
						return false
					end
				end
			end
			return true
		else
			return self:canOccupy(mx,my)
		end
	else
		return self:canOccupy(mx,my)
	end

end

--获取 creature当前所在 格子
function FightMap:getCreatureTile(creature)
	return self:getTile(creature.mx,creature.my)
end

function FightMap:isInTileCenter( creature )
	local tile = self:getTile(creature.mx,creature.my)
	return (tile and tile:isElemInCenter(creature))
end

--获取creature的左下角格子的  x，y
function FightMap:getElemMapXY(elem)
	local x,y = elem:getPosition()
	if elem.posLength > 1 then
		x = x - FightMap.HALF_TILE_W*(elem.posLength-1)
		y = y - FightMap.HALF_TILE_H*(elem.posLength-1)
	end

	return x,y
end

--获取精确的  格子坐标
function FightMap:getPreciseTilePos( creature )
	return self:toMapPos(self:getElemMapXY(creature))
end

--实际坐标 转化到 地图坐标
function FightMap:toMapPos( x,y )
	x = x - FightMap.HALF_TILE_W - FightMap.OFFSET_X
	y = y - FightMap.HALF_TILE_H - FightMap.OFFSET_Y
	local dx,dy = math.floor( x/FightMap.TILE_W+y/FightMap.TILE_H+0.5),math.floor( y/FightMap.TILE_H-x/FightMap.TILE_W+0.5)
	return dx,dy
end

--根据格子坐标 转换到场景坐标
function FightMap:toScenePos( mx,my )
	local x=(mx-my)*(FightMap.TILE_W/2) + FightMap.HALF_TILE_W + FightMap.OFFSET_X
	local y=(my+mx)*(FightMap.TILE_H/2)+ FightMap.HALF_TILE_H + FightMap.OFFSET_Y
	return x,y
end

function FightMap:getTileContent( mx,my )
	local tile = self:getTile(mx,my)
	if tile then
		return tile:getContent()
	end
	return -1000
end

function FightMap:getRandomBorn(team,scope)
	if scope == FightCfg.FLY then
		local min,max = math.floor(FightMap.H/2)+1 , FightMap.H-1
		return self.bornXList[team],math.floor(math.random(min,max))
	else
		return self.bornXList[team],self.bornYList[team][math.random(1,#self.bornYList[team])]
	end
end

--获取2个人之间的距离
function FightMap:getDistance( creature,target )
	local mx,my,tx,ty = creature.mx,creature.my,target.mx,target.my
	local dx,dy = tx - mx,ty-my

	if creature.posLength and creature.posLength > 1 then
		if dx > 0 then
			dx = math.max(dx-creature.posLength,0)
		end
		if dy > 0 then
			dy = math.max(dy-creature.posLength,0)
		end
	end
	if target.posLength and target.posLength > 1 then
		if dx < 0 then
			dx = math.max(-dx-target.posLength,0)
		end
		if dy < 0 then
			dy = math.max(-dy-target.posLength,0)
		end
	end
	return math.sqrt(math.pow(math.abs(dx),2) + math.pow(math.abs(dy),2))
end

--合法的地图坐标
function FightMap:isLegal( mx,my )
	return mx >= 0 and mx <= FightMap.TILE_MAX_W and my >= 0 and my <= FightMap.TILE_MAX_H
end

--根据 位置  方向 速度  获取下一个tile
function FightMap:getNextTile( mx,my,direction,speed )
	local dx = (speed > 0 and 1 )  or (speed < 0 and -1) or 0
	local tileX,tileY = self:getNextMxMy(mx,my,direction,dx)
	if not self:isLegal(tileX,tileY) then
		return nil
	end
	return self:getTile(tileX,tileY)
end

--根据方向获取下一个位置
function FightMap:getNextMxMy( mx,my,direction,dx )
	local dy = dx
	local tileX,tileY
	if direction == Creature.LEFT then
		tileX,tileY = mx-dx, my
	elseif direction == Creature.RIGHT then
		tileX,tileY = mx-dx, my
	elseif direction == Creature.UP then
		tileX,tileY = mx, my-dy
	elseif direction == Creature.DOWN then
		tileX,tileY = mx, my+dy
	elseif direction == Creature.RIGHT_DOWN or direction == Creature.RIGHT_DOWN_1 or direction == Creature.RIGHT_DOWN_2 then
		tileX,tileY = mx+dx, my + dy
	elseif direction == Creature.LEFT_DOWN or direction == Creature.LEFT_DOWN_1 or direction == Creature.LEFT_DOWN_2 then
		tileX,tileY = mx - dx, my + dy
	elseif direction == Creature.RIGHT_UP or direction == Creature.RIGHT_UP_1 or direction == Creature.RIGHT_UP_2 then
		tileX,tileY = mx + dx, my - dy
	elseif direction == Creature.LEFT_UP or direction == Creature.LEFT_UP_1 or direction == Creature.LEFT_UP_2 then
		tileX,tileY = mx -dx, my - dy
	end
	return tileX,tileY
end

--获取2个格子的距离
function FightMap:getDisByMxMy( mx,my,tx,ty )
	local tx,ty = self:toScenePos(tx,ty)
	local sx,sy = self:toScenePos(mx, my)
	return tx-sx,ty-sy
end

--带有方向的获取周围4个点
function FightMap:getNearTilesWithDirection(creature,dx,dy)
	local mx,my = creature.mx,creature.my
	local list = {}
	if dx > 0 then
		dx = 1
	elseif dx < 0 then
		dx = -1
	end
	if dy > 0 then
		dy = 1
	elseif dy < 0 then
		dy = -1
	end
	local tileList = {}
	local tile = self:getTile(mx+dx,my+dy)
	if tile then
		tileList[#tileList+1] = tile
	end
	local arr
	if dx == 0 then
		arr = { {x=-1,y=dy},{x=1,y=dy},{x=-1,y=0},{x=1,y=0},{x=-1,y=-dy},{x=1,y=-dy},{x=-dx,y=-dy}}
	elseif dy == 0 then
		arr = { {x=dx ,y=1},{x=dx,y=-1} ,{x=0,y=-1},{x=0,y=1},{x=-dx,y=-1},{x=dx,y=1},{x=-dx,y=-dy}}
	else
		arr = { {x=dx,y=0},{x=0,y=dy},{x=dx,y=-dy},{x=-dx,y=dy},{x=-dx,y=0},{x=0,y=-dy},{x=-dx,y=-dy}}
	end
	for i,pos in ipairs(arr) do
		tile = self:getTile(mx+pos.x,my+pos.y)
		if tile then
			tileList[#tileList+1] = tile
		end
	end
	return tileList
end

--获取周围8个格子
function FightMap:getNearTiles( mx,my )
	local list = {}
	list[#list+1] = self:getTile(mx+1,my)
	list[#list+1] = self:getTile(mx,my+1)
	list[#list+1] = self:getTile(mx-1,my)
	list[#list+1] = self:getTile(mx,my-1)
	list[#list+1] = self:getTile(mx-1,my-1)
	list[#list+1] = self:getTile(mx+1,my-1)
	list[#list+1] = self:getTile(mx+1,my+1)
	list[#list+1] = self:getTile(mx-1,my+1)
	return list
end

function FightMap:getCreatureRoundGap(creature,target)
	local mx,my = creature.mx,creature.my
	local d = AIMgr:getDirection( target,creature:getPosition() )
	local arr
	if d == Creature.LEFT_UP or d == Creature.LEFT then
		-- arr = [{x=1,y=0},{x=0,y=-1},{x=0,y=1},{x=-1,y=0}]
		arr = {{x=creature.posLength,y=0},{x=0,y=-target.posLength},{x=0,y=creature.posLength},{x=-target.posLength,y=0}}
	elseif d == Creature.LEFT_DOWN then
		-- arr = [{x=1,y=0},{x=0,y=1},{x=0,y=-1},{x=-1,y=0}]
		arr = {{x=creature.posLength,y=0},{x=0,y=creature.posLength},{x=0,y=-target.posLength},{x=-target.posLength,y=0}}
	elseif d == Creature.RIGHT_UP or d == Creature.RIGHT  then
		-- arr = [{x=-1,y=0},{x=0,y=-1},{x=0,y=1},{x=1,y=0}]
		arr = {{x=-target.posLength,y=0},{x=0,y=-target.posLength},{x=0,y=creature.posLength},{x=creature.posLength,y=0}}
	elseif d == Creature.RIGHT_DOWN then
		-- arr = [{x=-1,y=0},{x=0,y=1},{x=0,y=-1},{x=1,y=0}]
		arr = {{x=-target.posLength,y=0},{x=0,y=creature.posLength},{x=0,y=-target.posLength},{x=creature.posLength,y=0}}
	elseif d == Creature.UP then
		-- arr = [{x=0,y=-1},{x=1,y=0},{x=-1,y=0},{x=0,y=1}]
		arr = {{x=0,y=-target.posLength},{x=creature.posLength,y=0},{x=-target.posLength,y=0},{x=0,y=creature.posLength}}
	else
		-- arr = [{x=0,y=1},{x=1,y=0},{x=-1,y=0},{x=0,y=-1}]
		arr = {{x=0,y=creature.posLength},{x=creature.posLength,y=0},{x=-target.posLength,y=0},{x=0,y=-target.posLength}}
	end
	for i,pos in ipairs(arr) do
		local x,y = pos.x,pos.y
		if x == 0 then
			for px = 0,creature.posLength -1 do
				if self:canStandCreature(mx + px,my+ y,target) then
					return mx+px,my+y
				end
			end
		end
		if y == 0 then
			for py = 0,creature.posLength -1 do
				if self:canStandCreature(mx + x,my+ py,target) then
					return mx+x,my+py
				end
			end
		end
	end
	return target.mx,target.my
end

--获取附近的可走点列表
function FightMap:getNearGapList(mx, my)
	local tile = self:getTile(mx,my)
	if tile and tile:canOccupy() then
		return {tile}
	end
	local startX,startY = mx,my
	local openList = {}
	local closeList = {}
	local curIndex = 1
	local tileList = {}
	local curDis = 999999
	while true do
		local list = self:getNearTiles(startX,startY)
		for i,tile in ipairs(list) do
			if tile then
				if tile:canOccupy() then
					local dis = Formula:getDistance(mx,my,tile.mx,tile.my)
					if dis > curDis then
						break
					else
						curDis = dis
						tileList[#tileList+1] = tile
					end
				elseif not closeList[tile] then
				 	openList[#openList+1] = tile
				 	closeList[tile] = true
				end
			end
		end
		if #tileList > 0 then
			return tileList
		end
		local tile = openList[curIndex]
		if not tile then
			return nil
		end
		startX,startY = tile.mx,tile.my
		curIndex = curIndex + 1
	end
	return nil
end

--获取最近的一个可走点
function FightMap:getNearGap(mx,my,creature)
    local tile = self:getTile(mx,my)
	if tile and tile:canStandCreature(creature) then
		return tile
	end
	local startX,startY = mx,my
	local openList = {}
	local closeList = {}
	local curIndex = 1
	while true do
		local list = self:getNearTiles(startX,startY)
		for i,tile in ipairs(list) do
			if tile then
				if tile:canStandCreature(creature) then
					return tile
				elseif not closeList[tile] then
				 	openList[#openList+1] = tile
				 	closeList[tile] = true
				end
			end
		end
		local tile = openList[curIndex]
		if not tile then
			return nil
		end
		startX,startY = tile.mx,tile.my
		curIndex = curIndex + 1
	end
	return nil
end

function FightMap:getNearGapInRect( mx,my,beginPos,endPos,creature)

	local tile = self:getTile(mx,my)
	if tile and tile:canStandCreature(creature) then
		return tile
	end
	local startX,startY = mx,my
	local openList = {}
	local closeList = {}
	local curIndex = 1
	while true do
		local list = self:getNearTiles(startX,startY)
		for i,tile in ipairs(list) do
			-- print("进来啊啊。。。",tile,tile.mx,tile.my,beginPos.x,beginPos.y)
			if tile and tile.mx >= beginPos.x and tile.mx <= endPos.x and tile.my >= beginPos.y and tile.my <= endPos.y then
				if not closeList[tile] then
					if tile:canStandCreature(creature) then
						return tile
					else
					 	openList[#openList + 1] = tile
					 	closeList[tile] = true
					end
				end
			end
		end
		local tile = openList[curIndex]
		if not tile then
			print("no   tile...",curIndex,mx,my,#list)
			return nil
		end
		startX,startY = tile.mx,tile.my
		curIndex = curIndex + 1
	end
	return nil
end

function FightMap:getGapListByTargetDis(mx,my,tx,ty,dis)
	local startX,startY = mx,my
	local minDis = 100000
	local list = {}
	local addList = function(dx,dy)
						local tile = self:getTile(mx+dx,my+dy)
						if tile and tile:canOccupy() then
							local d = math.abs(mx+dx - tx) + math.abs(my+dy - ty)
							if d < minDis then
								minDis = d
								table.insert(list,1,tile)
							else
								table[#list+1]=tile
							end
						end
					end
	for curDis=1,dis,1 do
		for dx = -curDis,curDis,1 do
			local dy = curDis - math.abs(dx)
			addList(dx,dy)
			dy = -dy
			addList(dx,dy)
		end
	end
	return list
end

--显示英雄可站立的格子
function FightMap:showHeroStandGrid( hero )
	-- local now = os.clock()
	local beginPos,endPos = self:getHeroStandPos(hero)
	for i=beginPos.x,endPos.x do
		for j = beginPos.y,endPos.y do
			local tile = FightCache:getTileSprite(i,j,"gray")--TileSprite.new(i,j,nil,"gray")
			self:addChild(tile)
			self.tileSpriteList[#self.tileSpriteList + 1] = tile
		end
	end

	-- print("stand。。。time" ,os.clock()-now)
	return beginPos,endPos
end

--隐藏格子
function FightMap:removeHeroStandGrid( hero )
	if #self.tileSpriteList > 0 then
		for _,tile in ipairs(self.tileSpriteList) do
			FightCache:setTileSprite(tile)
		end
		self.tileSpriteList = {}
	end
end

--获取可站立的范围
function FightMap:getHeroStandPos( hero,team )
	local team = hero.team or team or FightCommon.enemy
	local standPos = self.heroPos[team][1]
	return standPos.beginPos,standPos.endPos
end

--是否在范围内
function FightMap:isPosInRect(x,y,beginPos,endPos )
	return x >= beginPos.x and x <= endPos.x and y >= beginPos.y and y <= endPos.y
end

function FightMap:isPosLengthInRect(x,y,beginPos,endPos,posLength)
	return self:isPosInRect(x, y, beginPos, endPos) and self:isPosInRect(x+posLength-1, y+posLength-1, beginPos, endPos)
end

--范围内是否有空位
function FightMap:hasGapInRect( beginPos,endPos,posLength )
	for i=beginPos.x,endPos.x do
		for j=beginPos.y,endPos.y do
			if self:canOccupyRang(i,j,posLength) then
				return true
			end
		end
	end
	return false
end

--重置地图数据
function FightMap:reset(  )
	self:removeHeroStandGrid()
	for i = 0 , FightMap.W do
		local row = {}
		for j = 0 , FightMap.H do
			local tile = self.mapData[i][j]
			tile:setContent(FightMap.NONE)
		end
	end
	self.astar:setMapDataRange(FightMap.H + 1,FightMap.W + 1)
end

function FightMap:clear(  )
	self:removeHeroStandGrid()
	if isShowTile then
		self:removeAllChildren()
	end
	--self:initMap()
end


function FightMap:dispose()
	self.astar:delete()
	self.mapData = nil

	if isShowTile then
		self:release()
	end
end

return FightMap

