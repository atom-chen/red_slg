local StarCheckBase = game_require("view.fight.delegate.starCheck.StarCheckBase")

local TimeStar = class("TimeStar",StarCheckBase)

function TimeStar:isSuccess()
	return FightEngine:getCurTime() <= tonumber(self.cfg.detail)*1000
end

return TimeStar