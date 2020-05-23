--自爆
local Action = game_require("view.fight.ai.Action")
local ExplodeAction = class("ExplodeAction",Action)

function ExplodeAction:attack(force)
	self.creature:die()
	return true
end

return ExplodeAction