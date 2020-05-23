local ModelMgr = {}

--加对应的模块直接在里面加就够了
local Model_List = {
	{"TimeCenter",			"model.center.TimeCenter"}
	,{"TipCenter",			"model.center.TipCenter"}
	,{"SysModel",			"model.SysModel"}
	,{"WorldMapModel",		"model.world.map.WorldMapModel"}
	,{"WorldMapProxy",		"model.world.map.WorldMapProxy"}
	,{"WorldModel",			"model.world.WorldModel"}
	,{"WorldProxy",			"model.world.WorldProxy"}
	,{"TownModel",			"model.town.TownModel"}
	,{"BuildingModel",		"model.town.BuildingModel"}
	,{"RoleModel",			"model.role.RoleModel"}
}

for i,model in ipairs(Model_List) do
	_G[model[1]] = game_require(model[2])
end

function ModelMgr:init()
    self._isInit = true
    for i,model in ipairs(Model_List) do
		_G[model[1]]:init()
	end
end

function ModelMgr:isInit()
	return self._isInit
end

function ModelMgr:reset()
	if self._isInit then
		self._isInit = false
		--重登的时候 有需要reset model  proxy
		TimerCenter:clear()
	end
end

return ModelMgr
