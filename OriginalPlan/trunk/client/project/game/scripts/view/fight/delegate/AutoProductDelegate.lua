local AutoProductDelegate = class("AutoProductDelegate")
local AutoProduct = game_require("view.fight.fightUI.AutoProduct")
local FightHeroInfo = game_require("view.fight.fightUI.FightHeroInfo")
local NewHandle = game_require("view.fight.handle.NewHandle")

function AutoProductDelegate:ctor(heroList,team,stockNumList)
	self.team = team
	local fightHeroList = {}
	for i,hero in ipairs(heroList) do
		local stockNum
		if stockNumList then
			stockNum = stockNumList[i]
		else
		 	stockNum = hero:getStockNum()
		end
		fightHeroList[i] = FightHeroInfo.new(hero,team,stockNum)
	end

	self.autoProduct = AutoProduct.new(team)
	self.autoProduct:initHero(fightHeroList)
end

function AutoProductDelegate:start()
	self.curTime = 0
	FightEngine:addRunner(self)
end

function AutoProductDelegate:run(dt)
	if FightDirector.status == FightCommon.start then
		self.autoProduct:cutdownCD(dt)
		self.curTime = self.curTime - dt
		if self.curTime < 0 then
			if self.curHero then
				-- print("  --出兵。22222222。。",self.curHero,self.curHero:canProduct())
				if self.curHero:canProduct() then
					-- self.curTime = 100
					if self.curHero:isMonster() then
						if NewHandle:createMonsterEx(self.curHero:getHero(),nil,nil,self.team) then
							self.curHero:addStock(-1)
						end
					else
						if NewHandle:createHeroEx(self.curHero:getHero(),nil,nil,self.team) then
							self.curHero:addStock(-1)
						end
					end
					self.curHero = nil
				end
			else
				self.curHero = self.autoProduct:product()
				-- print("  --出兵。。。",self.curHero)
				if not self.curHero then
					self.curTime = 100
				end
			end
		end
	end
end

function AutoProductDelegate:getFightHeroList()
	return self.autoProduct.heroList
end

function AutoProductDelegate:isRefreshEnd()
	return not self.autoProduct:hasHeroStock()
end

function AutoProductDelegate:dispose()

end

return AutoProductDelegate