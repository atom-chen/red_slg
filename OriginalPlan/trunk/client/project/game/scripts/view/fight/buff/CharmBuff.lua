local CharmBuff = class("CharmBuff",Buff)
local CharmHandle = game_require("view.fight.handle.CharmHandle")

function CharmBuff:start()
	Buff.start(self)
	if CharmHandle:canBeCharm(self.creature) then
		CharmHandle:changeTeam(self.creature)
		self._isCharm = true
	end
end

function CharmBuff:dispose()
	if self._isCharm and not self.creature:isDie() then
		CharmHandle:recoverTeam(self.creature)
	end
	Buff.dispose(self)
end

return CharmBuff