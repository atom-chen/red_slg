local fightInfo = class("fightInfo")

function fightInfo:ctor(id )
    self:init(id)
end

function fightInfo:init( id )
    self.index = index or 0
    self.logID = WildBattleModel.FIGHT
    self.type = 1
    self.x = 0
    self.y = 0
    self.is_win = 0
    self.atk_titile = ""
    self.def_titile = ""
    self.atk_name = ""
    self.def_name = ""
    self.atk_union_name = ""
    self.def_union_name = ""
    self.time = 0
end

function fightInfo:setData( info )
    self.index = info.index
    self.type = info.type
    self.x = info.wildernessPos.x
    self.y = info.wildernessPos.y
    self.is_win = info.is_win
    self.atk_titile = info.atk_titile
    self.def_titile = info.def_titile
    self.atk_name = info.atk_name
    self.def_name = info.def_name
    self.atk_union_name = info.atk_union_name
    self.def_union_name = info.def_union_name
    self.time = info.time
end

return fightInfo