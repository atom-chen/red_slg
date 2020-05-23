local mineInfo = class("mineInfo")

function mineInfo:ctor(id )
    self:init(id)
end

function mineInfo:init( id )
    self.index = index or 0
    self.logID = WildBattleModel.DIG
    self.type = 0       
    self.troops_id = 0
    self.time = 0
    self.x = 0
    self.y = 0
    self.mine_list = {}
    self.is_win = 1
    self.monsterID = 0
    self.monsterLev = 0
end

function mineInfo:setData( info )
    self.index = info.index
    self.type = info.type
    self.troops_id = info.troops_id
    self.time = info.time
    self.x = info.wildernessPos.x
    self.y = info.wildernessPos.y
    self.is_win = info.is_win
    self.monsterID = info.monsterID
    self.monsterLev = info.monsterLev
    for i,v in pairs(info.mine_list) do
        table.insert(self.mine_list,v)
    end
end

return mineInfo