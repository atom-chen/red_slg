local StarCheckBase = game_require("view.fight.delegate.starCheck.StarCheckBase")

local PopulaceStar = class("PopulaceStar",StarCheckBase)

function PopulaceStar:init(cfg)
	StarCheckBase.init(self,cfg)
	FightTrigger:addEventListener(FightTrigger.POPULACE_CHANGE, {self,self._onPopulaceChange})
	self.isSuccess = true
end

function PopulaceStar:_onPopulaceChange(e)
	if e.team == FightCommon.mate then
		if FightDirector:getPopulace(FightCommon.mate) > tonumber(self.cfg.detail) then
			self.isSuccess = false
		end
	end
end

function PopulaceStar:isSuccess()
	return self.isSuccess
end

function PopulaceStar:dispose()
	FightTrigger:removeEventListener(FightTrigger.POPULACE_CHANGE, {self,self._onPopulaceChange})
	StarCheckBase.dispose(self)
end

return PopulaceStar

