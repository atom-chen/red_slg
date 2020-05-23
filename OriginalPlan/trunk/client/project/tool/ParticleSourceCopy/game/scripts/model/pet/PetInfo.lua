--[[--
     宠物的实例属性
]]

local PetInfo = class("PetInfo")

function PetInfo:ctor()
    self.id = 0
    self.type = 0      --宠物的类型的id 
    self.level = 0     --当前等级
    self.gender = GameConst.MALE  -- 宠物的性别
    self.isVariation = false    --是否变异
    self.speed = 0      --当前出手速度
    self.exp = 0        --当前经验值
    self.growthRate = 0 --宠物的成长率
    --self.isDeployed = false --是否上阵
    self.warpos = 0     --站位，未上针的战位为0，否则为大于0的对应号位
    
    --装备信息，部位索引->装备id
    self.equipInfos = {}  
     
    --战斗属性
    self.hp = 0      --当前血量
    self.thp = 0     --当前血量总量
    self.mp = 0      --当前魔法值
    self.tmp = 0     --当前魔法值总值
    self.phyAtk = 0  --物理攻击力
    self.phyDef = 0  --物理防御力
    self.magicAtk = 0 --魔法攻击力
    self.magicDef = 0  --魔法防御力
    self.hitRate = 0   --命中率
    self.dodgeRate = 0 --闪避率
    self.killRate = 0  --必杀率
end

return PetInfo