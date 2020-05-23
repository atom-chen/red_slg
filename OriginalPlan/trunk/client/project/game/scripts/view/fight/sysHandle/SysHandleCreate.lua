local SysHandleCreate = {}

local sysHandleClass = {
	[FightCfg.TEST_FIGHT] = game_require("view.fight.sysHandle.TestFightHandle")
}

function SysHandleCreate:createSysHandle(fightInfo)
	return sysHandleClass[fightInfo.fightType].new(fightInfo)
end

return SysHandleCreate