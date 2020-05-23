local StarCheckBase = game_require("view.fight.delegate.starCheck.StarCheckBase")

local KillEnemyStar = class("KillEnemyStar",StarCheckBase)

function KillEnemyStar:init(cfg)
	StarCheckBase.init(self,cfg)
	FightTrigger:addEventListener(FightTrigger.CREATURE_DIE, {self,self._onEnemyDie})
	self._enemyDieNum = 0
end

function KillEnemyStar:_onEnemyDie(e)
	local team = e.creature._oldTeam or e.creature.cInfo.team
	if team == FightCommon.enemy and e.creature:isDie() then
		self._enemyDieNum = self._enemyDieNum + 1
	end
end

function KillEnemyStar:isSuccess()
	return self._enemyDieNum > tonumber(self.cfg.detail)
end

function KillEnemyStar:dispose()
	FightTrigger:removeEventListener(FightTrigger.CREATURE_DIE, {self,self._onEnemyDie})
	StarCheckBase.dispose(self)
end

return KillEnemyStar
