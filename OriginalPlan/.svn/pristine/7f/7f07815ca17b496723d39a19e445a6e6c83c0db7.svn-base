local StarCheckBase = game_require("view.fight.delegate.starCheck.StarCheckBase")

local MateDieStar = class("MateDieStar",StarCheckBase)

function MateDieStar:init(cfg)
	StarCheckBase.init(self,cfg)
	FightTrigger:addEventListener(FightTrigger.CREATURE_DIE, {self,self._onMateDie})
	self._mateDieNum = 0
end

function MateDieStar:_onMateDie(e)
	local team = e.creature._oldTeam or e.creature.cInfo.team
	if team == FightCommon.mate and e.creature:isDie() then
		self._mateDieNum = self._mateDieNum + 1
	end
end

function MateDieStar:isSuccess()
	return self._mateDieNum <= tonumber(self.cfg.detail)
end

function MateDieStar:dispose()
	FightTrigger:removeEventListener(FightTrigger.CREATURE_DIE, {self,self._onMateDie})
	StarCheckBase.dispose(self)
end

return MateDieStar