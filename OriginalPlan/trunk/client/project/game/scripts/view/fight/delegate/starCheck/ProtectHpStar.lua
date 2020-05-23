local StarCheckBase = game_require("view.fight.delegate.starCheck.StarCheckBase")

local ProtectHpStar = class("ProtectHpStar",StarCheckBase)

function ProtectHpStar:isSuccess()
	local mateList = FightDirector:getScene():getTeamList(FightCommon.mate)
	for i,mate in ipairs(mateList) do
		if mate.isProtectd and mate.cInfo.hp < mate.cInfo.maxHp then
			return false
		end
	end
	return true
end

return ProtectHpStar