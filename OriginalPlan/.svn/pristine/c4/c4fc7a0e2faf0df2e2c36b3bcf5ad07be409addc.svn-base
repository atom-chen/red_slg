local StarCheckBase = game_require("view.fight.delegate.starCheck.StarCheckBase")

local KillAllEnemyStar = class("KillAllEnemyStar",StarCheckBase)

function KillAllEnemyStar:isSuccess()
	return #FightDirector:getScene():getTeamList(FightCommon.enemy) == 0
end

return KillAllEnemyStar

