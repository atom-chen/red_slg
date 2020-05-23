local EquipInfo = class("EquipInfo")

function EquipInfo:ctor()
  self.id = 0     --装备的id
  self.type = 0   --装备的类型id
  self.level = 0  --装备强化的等级
end

return EquipInfo