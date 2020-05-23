local StarCheckBase = game_require("view.fight.delegate.starCheck.StarCheckBase")

local HQStar = class("HQStar",StarCheckBase)

function HQStar:isSuccess()
	local hq = FightDirector:getScene():getHQ(FightCommon.mate)
	return hq.cInfo.hp/hq.cInfo.maxHp >= tonumber(self.cfg.detail)/100
end

return HQStar