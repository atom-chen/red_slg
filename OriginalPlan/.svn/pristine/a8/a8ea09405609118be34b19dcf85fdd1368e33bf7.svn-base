local HeroBottomList = class("HeroBottomList",ScrollList)

function HeroBottomList:setGridList(gridList,length)
	self.gridList = gridList
	self.length = length
	self.curPage = 0
end

function HeroBottomList:setNextPage(num)
	self.curPage = self.curPage + num
	local allNum = #self.gridList - 1
	if self.curPage > allNum/self.length then
		self.curPage = 0
	elseif self.curPage < 0 then
		self.curPage = math.floor(allNum/self.length)
	end
	self:refreshPage()
end

function HeroBottomList:refreshPage()
	ScrollList.clear(self)
	for i=self.curPage*self.length+1,(self.curPage+1)*self.length,1 do
		local grid = self.gridList[i]
		if grid then
			self:addCell(grid)
		end
	end
end

function HeroBottomList:_sortDelay()
	self._sortTime = nil
	self:sortEx()
end

function HeroBottomList:sortEx()
	if #self.gridList <= self.length then
		self:refreshPage()
		return --不排序了，少的话
	end
	table.sort(self.gridList, function(a,b)
					if a.fightHero:getStock() <= 0 then
						return false
					elseif b.fightHero:getStock() <= 0 then
						return true
					end
					local v1,v2 = a.fightHero:getWeight(),b.fightHero:getWeight()
					if v1 == v2 then
						return a.fightHero.heroId > a.fightHero.heroId
					else
						return v1 > v2
					end
				end)

	self:refreshPage()
end

function HeroBottomList:setEnd(grid)
	local index = table.indexOf(self.gridList,grid)
	if index > 0 then
		table.remove(self.gridList,index)
		self.gridList[#self.gridList+1] = grid
	end
	self:refreshPage()
end

function HeroBottomList:sort(isDelay)

	-- if isDelay then
	-- 	if not self._sortTime then
	-- 		self._sortTime = scheduler.performWithDelayGlobal(function() self:_sortDelay() end, 0.5)
	-- 	end
	-- else
	-- 	if self._sortTime then
	-- 		scheduler.unscheduleGlobal(self._sortTime)
	-- 		self._sortTime = nil
	-- 	end
	-- 	self:_sortDelay()
	-- end
end

function HeroBottomList:clear(isDispose)
	self.gridList = nil

	ScrollList.clear(self,isDispose)
end

return HeroBottomList