local CheckStarDelegate = class("CheckStarDelegate")

local Star_Type_Class = {
	[1] = game_require("view.fight.delegate.starCheck.TimeStar")
	,[2] = game_require("view.fight.delegate.starCheck.MateDieStar")
	,[3] = game_require("view.fight.delegate.starCheck.ProtectDieStar")
	,[4] = game_require("view.fight.delegate.starCheck.ProtectDieStar")
	,[5] = game_require("view.fight.delegate.starCheck.KillAllEnemyStar")
	,[6] = game_require("view.fight.delegate.starCheck.PopulaceStar")
	,[7] = game_require("view.fight.delegate.starCheck.PopulaceStar")
	,[8] = game_require("view.fight.delegate.starCheck.KillEnemyStar")
	,[9] = game_require("view.fight.delegate.starCheck.KillEnemyStar")
	,[10] = game_require("view.fight.delegate.starCheck.HQStar")
	,[11] = game_require("view.fight.delegate.starCheck.ProtectHpStar")
	,[12] = game_require("view.fight.delegate.starCheck.PopulaceDieStar")
}

function CheckStarDelegate:start(starRequest)
	self.starList = {}
	for i,star in ipairs(starRequest) do
		local starCfg = DungeonCfg:getStarRequestCfg(star)
		self.starList[i] = Star_Type_Class[starCfg.type].new()
		self.starList[i]:init(starCfg)
	end
	FightEngine:addRunner(self)
end

function CheckStarDelegate:run(dt)
	for i,star in ipairs(self.starList) do
		star:run(dt)
	end
end

function CheckStarDelegate:getStar()
	local list = {}
	for i,star in ipairs(self.starList) do
		if star:isSuccess() then
			list[#list+1] = 1
		end
	end
	for i = #list+1, #self.starList do   --后面的补0
		list[i] = 0
	end
	return list
end

function CheckStarDelegate:dispose()
	for i,star in ipairs(self.starList) do
		star:dispose()
	end
	self.starList = nil
end

return CheckStarDelegate