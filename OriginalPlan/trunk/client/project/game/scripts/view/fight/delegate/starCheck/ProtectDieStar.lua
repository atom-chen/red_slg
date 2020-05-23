local StarCheckBase = game_require("view.fight.delegate.starCheck.StarCheckBase")

local ProtectDieStar = class("ProtectDieStar",StarCheckBase)

function ProtectDieStar:init(cfg)
	StarCheckBase.init(self,cfg)
	FightTrigger:addEventListener(FightTrigger.CREATURE_DIE, {self,self._onProtectDie})
	self._protectDieNum = 0
end

function ProtectDieStar:_onProtectDie(e)
	local team = e.creature._oldTeam or e.creature.cInfo.team
	if team == FightCommon.mate and e.creature.isProtectd then
		self._protectDieNum = self._protectDieNum + 1
	end
end

function ProtectDieStar:isSuccess()
	return self._protectDieNum <= tonumber(self.cfg.detail)
end

function ProtectDieStar:dispose()
	FightTrigger:removeEventListener(FightTrigger.CREATURE_DIE, {self,self._onProtectDie})
	StarCheckBase.dispose(self)
end

return ProtectDieStar

