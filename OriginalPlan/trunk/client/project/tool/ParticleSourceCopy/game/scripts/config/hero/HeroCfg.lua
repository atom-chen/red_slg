local HeroCfg = class("HeroCfg")

function HeroCfg:init()
  --英雄配置
  self._cfgObj = nil
  
  --向ConfigMgr请求配置
  self._cfgObj = ConfigMgr:requestConfig("hero",nil,true)
  
end

function HeroCfg:getHero(id)
    local hero = self._cfgObj[id]
    hero.hp = hero.maxHp
    return hero
end

function HeroCfg:getCloneHero( id )
    local hero = self:getHero(id)
    return clone(hero)
end



return HeroCfg.new()