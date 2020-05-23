local MagicCache = {}

function MagicCache:init()
	self.list = {}
end

function MagicCache:getMagic(id,creature,target)
	local mList = self.list[id]
	if mList then
		local m = mList[-1]
		local d = m:_getDirection(creature,target)
		-- print("获取 maigc",id,d)
		if mList[d] and #mList[d] > 0 then
			local m = table.remove(mList[d])
			m:reset()
			return m
		end
	end
	return nil
end

function MagicCache:setMagic(magic)
	local mList = self.list[magic.magicId]
	if not mList then
		mList = {}
		mList[-1] = magic
		self.list[magic.magicId] = mList
	end
	local d = magic:getDirection()
	if not mList[d] then
		mList[d] = {}
	end
	-- print("存放 maigc",magic.magicId,d)
	table.insert(mList[d],magic)
end

function MagicCache:clear()
	for id,mList in pairs(self.list) do
		for d,m in pairs(mList) do
			m:disposeEx()
		end
	end
	self.list = {}
end

return MagicCache