--阵亡人口不超过多少

local StarCheckBase = game_require("view.fight.delegate.starCheck.StarCheckBase")

local PopulaceDieStar = class("PopulaceDieStar",StarCheckBase)

function PopulaceDieStar:init(cfg)
	StarCheckBase.init(self,cfg)
	FightTrigger:addEventListener(FightTrigger.CREATURE_DIE, {self,self._onMateDie})
	FightTrigger:addEventListener(FightTrigger.POPULACE_CHANGE, {self,self._onPopulaceChange})
	self._mateDiePopulace = 0
	self._maxPopulace = 0
end

function PopulaceDieStar:_onMateDie(e)
	local team = e.creature._oldTeam or e.creature.cInfo.team
	local cInfo = e.creature.cInfo
	if team == FightCommon.mate and e.creature:isDie() then
		local populace = cInfo.populace or 1
		if cInfo.heroNum then
	 		populace = (populace/cInfo.heroNum)
	  	end
		self._mateDiePopulace = self._mateDiePopulace + populace
	end
end

function PopulaceDieStar:_onPopulaceChange(e)
	if e.team == FightCommon.mate and e.populace > 0 then
		self._maxPopulace = self._maxPopulace + e.populace
	end
end

function PopulaceDieStar:isSuccess()
	local rate = 100
	if self._maxPopulace > 0 then
		rate = 100*self._mateDiePopulace/self._maxPopulace
	end
	return rate <= tonumber(self.cfg.detail)
end

function PopulaceDieStar:dispose()
	FightTrigger:removeEventListener(FightTrigger.CREATURE_DIE, {self,self._onMateDie})
	FightTrigger:removeEventListener(FightTrigger.POPULACE_CHANGE, {self,self._onPopulaceChange})
	StarCheckBase.dispose(self)
end

return PopulaceDieStar