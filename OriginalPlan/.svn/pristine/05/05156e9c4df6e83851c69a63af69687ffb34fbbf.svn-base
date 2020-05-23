local Action = game_require("view.fight.ai.Action")
local FlyAction = class("FlyAction",Action)

function FlyAction:startSkill(skill)
--	if self.creature:getBombNumType() ~= 2 then
--		self.creature:reduceBomb()
--	end
end

function FlyAction:minorAttack()

--	if self.creature:getBombNumType() == 2 then
--		local bomb = self.creature:getBombNum()
--		if bomb > 0 and Action.minorAttack(self) then
--			self.creature:reduceBomb()
--		end
--	else
		return Action.minorAttack(self)
--	end
end

return FlyAction