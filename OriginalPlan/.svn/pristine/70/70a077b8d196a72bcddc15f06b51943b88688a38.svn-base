--
--

local TimeImage = game_require("view.fight.runner.TimeImage")
--战斗缓存    资源之类的
local FightCache = {}

function FightCache:init(  )
	self.animCount = 0
	self.animaList = {}
	self.imageList = {}
	self.tileSpriteList = {}
	self.timeImageList = {}
end

function FightCache:retainAnima(res)
	if self.animaList[res] == nil and self.animCount < 20 then
		self.animCount = self.animCount + 1
		AnimationMgr:retain(res)
		self.animaList[res] = true
	end
end

function FightCache:releaseAnima(res)
	if self.animaList[res] then
		self.animCount = self.animCount - 1
		AnimationMgr:release(res)
		self.animaList[res] = nil
	end
end

function FightCache:releaseAllAnima()
	for res,_ in pairs(self.animaList) do
		AnimationMgr:release(res)
	end
	self.animCount = 0
	self.animaList = {}
end


function FightCache:releaseAnimWithoutList(list)
	for res,_ in pairs(self.animaList) do
		if list[res] then
			self:releaseAnima(res)
		end
	end
end

function FightCache:retainImage(res)
	if self.imageList[res] == nil then
		ResMgr:loadImage(res)
		self.imageList[res] = true
	end
end

function FightCache:releaseImage(res)
	if self.imageList[res] then
		self.imageList[res] = nil
		ResMgr:unload(res)
	end
end

function FightCache:releaseAll(  )
	self.animCount = 0
	self:releaseAllAnima()

	self:removeAllTile()

	for res,_ in pairs(self.imageList) do
		ResMgr:unload(res)
	end
	self.imageList = {}

	ParticleMgr:AllReRegisterParticle()

	ArtNumber.clearCache()

	for i,image in ipairs(self.timeImageList) do
		image:release()
	end
	self.timeImageList = {}


	for mId,_ in pairs(FightAudio.audioList) do
		AudioMgr:unloadEffect(mId)
	end
end

function FightCache:getTimeImage()
	local image = table.remove(self.timeImageList,#self.timeImageList)
	if not image then
		image = TimeImage.new()
		image:retain()
	else
		image:reset()
	end
	return image
end

function FightCache:saveTimeImage(image)
	self.timeImageList[#self.timeImageList+1] = image
end

function FightCache:getTileSprite(mx,my,color)
	local list = self.tileSpriteList[color]
	if list and #list >0 then
		local tile = list[1]
		table.remove(list,1)
		tile:setPos(mx,my)
		return tile
	end
	local tile = TileSprite.new(mx,my,nil,color)
	tile:retain()
	return tile
end

function FightCache:setTileSprite( tile )
	local color = tile.color
	local list = self.tileSpriteList[color]
	if list == nil then
		list = {}
		self.tileSpriteList[color] = list
	end
	tile:removeFromParent()
	list[#list+1] = tile
end


function FightCache:removeAllTile()
	for _,list in pairs(self.tileSpriteList) do
		for _,tile in ipairs(list) do
			tile:removeFromParent()
			tile:dispose()
			tile:release()
		end
	end
	self.tileSpriteList = {}
end

return FightCache