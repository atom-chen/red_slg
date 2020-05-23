--
-- Author: LiangHongJie
-- Date: 2013-12-02 18:20:41
--
--[[--
--"leaf","fire","fireflies","snow","bubble","cloud","system"
class：     Particle
inherit: CCParticleSystemQuad
author:  LiangHongJie
example：
    animStr = "1"
    particle = Particle.new(animStr)

    注意 这个类在构造函数里是调用了retain() 
        销毁需要调用 dispose()
configFile:
    file: 1.json 
    content:
        {
            "image":"leaf", --粒子的图片id
            "type":"leaf",  --粒子的类型"leaf","fire","fireflies","snow","bubble","cloud","system"
            "list":[
                {
                    "num":30           
                    --,"pos":[11,11]   
                    --,"posVar":[0,0]
                    --,"size":20
                    --,"sizeVar":2  
                    ,"spfile":"dd.splite"   --只有type==“system” 才起作用
                }
            ]
        }
]]
local Particle = class("Particle",function()
    return display.newNode()
end)
----粒子类型
Particle.TYPE_LEAF = "leaf"
Particle.TYPE_FIRE = "fire"
Particle.TYPE_FIRE_FLIES = "fireflies"
Particle.TYPE_SNOW = "snow"
Particle.TYPE_BUBBLE = "bubble"
Particle.TYPE_CLOND = "clond"
Particle.YTPE_SYSTEM = "system"

function Particle:ctor(animStr)
    -- body
    self:retain()
    animStr = "" .. animStr
    self._animStr = animStr
    ParticleResMgr.prepare(animStr)
    local emitterMap = self:_createParticleByConfig(animStr)
    if emitterMap then
        self:addChild(emitterMap)
    end
    
end
function Particle:dispose()
    --从父节点移除并清理
    self:cleanup()
    self:removeFromParentAndCleanup(true)
    --清除管粒子理器里的配置文件及纹理缓存
    ParticleResMgr.remove(self._animStr)
    self._animStr = nil
    self:release()
end
--[[--
   创建叶子
   @param imgName 粒子图片名
   @param parNum 粒子的数量
]]
function Particle:_createLeaf(imgName,parNum)
	-- body
	--设置粒子数量
	--self:initWithTotalParticles(parNum)
    local emitter = self:_create(imgName,parNum,4,1)
	emitter:setTexture(CCTextureCache:sharedTextureCache():addImage(imgName))
    local pos_x, pos_y = emitter:getPosition()
    emitter:setPosition(pos_x,pos_y)
    -- gravity
    emitter:setGravity(ccp(-40, -10))
    -- speed of particles
    emitter:setSpeed(100)
    emitter:setSpeedVar(30)

     -- spin of particles 粒子的自转
    emitter:setStartSpin(0)
    emitter:setStartSpinVar(200)
    emitter:setEndSpin(0)
    emitter:setEndSpinVar(200)
   
    return emitter
end
--[[--
	创建雪花
	@param imgName 粒子图片名
    @param parNum 粒子的数量
]]
function Particle:_createSnow(imgName,parNum)
	-- body
	local emitter = self:_create(imgName,parNum,6,1)
	emitter:setSpeed(80)
    emitter:setSpeedVar(20)
  
    local startColor = emitter:getStartColor()
    startColor.r = 0.9
    startColor.g = 0.9
    startColor.b = 0.9
    emitter:setStartColor(startColor)

    local startColorVar = emitter:getStartColorVar()
    startColorVar.b = 0.1
    emitter:setStartColorVar(startColorVar)
	 return emitter
end
--[[--
    创建水泡
    @param imgName 粒子图片名
    @param parNum 粒子的数量
]]
function Particle:_createBubble(imgName,parNum)
	local emitter = self:_create(imgName,parNum,15,0)
    local s = CCDirector:sharedDirector():getWinSize()
	local pos_x, pos_y = emitter:getPosition()
	emitter:setPosition(pos_x,pos_y-s.height)
	emitter:setGravity(ccp(0, 2))
    -- angle 角度
    emitter:setAngle(90)
    --emitter:setAngleVar(360)

    -- speed of particles 速度
    emitter:setSpeed(60)
    emitter:setSpeedVar(0)
    local endColor = emitter:getEndColor()
 	endColor.r = 1.0
 	endColor.g = 1.0
 	endColor.b = 1.0
    endColor.a = 1.0
 	emitter:setEndColor(endColor)
   -- emitter:seten
 	
	return emitter
end
--[[--
    创建火星
    @param imgName 粒子图片名
    @param parNum 粒子的数量
]]
function Particle:_createFire(imgName,parNum)
    local emitter = self:_create(imgName,parNum,15,0)
    --local pos_x, pos_y = emitter:getPosition()
    --print("pos_x:" .. pos_x .. " pos_y:" .. pos_y)
    --print("width:" .. display.width .. " height:" .. display.height/2)
    emitter:setPosition(display.width,display.height/2)
    emitter:setPosVar(ccp(0, display.height*1.5/4))
    emitter:setGravity(ccp(0, -1))
    -- angle 角度
    emitter:setAngle(180)
    --emitter:setAngleVar(360)
    -- speed of particles 速度
    emitter:setSpeed(60)
    emitter:setSpeedVar(5)
    local endColor = emitter:getEndColor()
    endColor.r = 1.0
    endColor.g = 1.0
    endColor.b = 1.0
    endColor.a = 1.0
    emitter:setEndColor(endColor)
   -- emitter:seten
    
    return emitter
end
--[[--
    创建飘云
    @param imgName 粒子图片名
    @param parNum 粒子的数量
]]
function Particle:_createCloud(imgName,parNum)
    -- body
    local emitter = self:_createFire(imgName,parNum)
    emitter:setGravity(ccp(0, 0))
    emitter:setPosition(display.width,display.height*5/6)
    emitter:setPosVar(ccp(0, 0))
    emitter:setStartSize(200)
    emitter:setStartSizeVar(0)
    emitter:setGravity(ccp(0, 0))
    return emitter;
end
--[[--
    创建萤火虫
    @param imgName 粒子图片名
    @param parNum 粒子的数量
]]
function Particle:_createFireFlies(imgName,parNum)
    -- body
    local emitter = self:_create(imgName,parNum,0.8,0.2)
    -- angle 角度
    emitter:setAngle(0)
    emitter:setAngleVar(360)
    emitter:setPosition(display.width/2,display.height*5/6)
    emitter:setPosVar(ccp(60, 4))
    
    local startColor = emitter:getStartColor()
    startColor.a = 0.8
    emitter:setStartColor(startColor)
    local startColorVar = emitter:getStartColorVar()
    startColorVar.a = 0.2
    emitter:setStartColorVar(startColorVar)

    local endColor = emitter:getEndColor()
    endColor.a = 0.4
    emitter:setEndColor(endColor)

    local endColorVar = emitter:getEndColorVar()
    endColorVar.a=0.3
    emitter:setEndColorVar(endColorVar)
    return emitter
end
--[[--
    创建粒子
    @param imgName 粒子图片名
    @param parNum 粒子的数量
    @param life 生命周期
    @param lifeVar 生命周期的增减范围
]]
function Particle:_create(imgName,parNum,life,lifeVar)
	local emitter = CCParticleSnow:createWithTotalParticles(parNum)
    --emitter:autorelease()
	emitter:setTexture(CCTextureCache:sharedTextureCache():addImage(imgName))
    local pos_x, pos_y = emitter:getPosition()
    emitter:setPosition(pos_x,pos_y)
    emitter:setSpeed(100)
    emitter:setSpeedVar(30)
    emitter:setLife(life)
    emitter:setLifeVar(lifeVar)
    emitter:setEmissionRate(emitter:getTotalParticles() / emitter:getLife())
    return emitter
end
--[[--
    根据.split文件 配置创建粒子
    @param filename 粒子配置.split文件
]]
function Particle:_createParticleFromFile(filename,parNum)
	local emitter = CCParticleSystemQuad:new()
	--emitter:autorelease()
    emitter:initWithFile(filename)
    if parNum or parNum>0 then emitter:setTotalParticles(parNum) end
    return emitter
end

function Particle:_createParticleByConfig( animStr )
    if not animStr then return end
    animStr = "" .. animStr
    local cfgObj = ParticleResMgr.getConfig(animStr)
    if not cfgObj then return end

    local imagePath = cfgObj["image"]
    local list = cfgObj["list"]
    local ptype = cfgObj["type"]
    local particleMap = display.newNode()
    for k,v in pairs(list) do 
        local parCfg = v
        local parNum = parCfg["num"]
        if ptype == Particle.TYPE_SYSTEM then
            imagePath = parCfg["spfile"]
        end
        local emitter = self:_getCreateByType(ptype,imagePath,parNum)
        if emitter then
            local pos = parCfg["pos"]
            if pos then
                emitter:setPosition(pos[1]/100*display.width,pos[2]/100*display.height)  --出现的点
            end
            local posVar = parCfg["posVar"]
            if posVal then
                emitter:setPosVar(ccp(posVar[1]/100*display.width, posVar[2]/100*display.height))    -- 出现点的坐标增减范围
            end
            if parCfg.size then
                emitter:setStartSize(parCfg.size)
            end
            if parCfg.sizeVar then
                emitter:setStartSizeVar(parCfg.sizeVar)
            end
            particleMap:addChild(emitter)
        else
            echoError("can not find the particle type ",ptype)
        end
        
    end
    return particleMap
end
--[[--
    选择创建粒子的方法
    @param ptype 粒子的类型
        Particle.TYPE_LEAF 
        Particle.TYPE_FIRE 
        Particle.TYPE_FIRE_FLIES
        Particle.TYPE_SNOW 
        Particle.TYPE_BUBBLE 
        Particle.TYPE_CLOND 
        Particle.YTPE_SYSTEM 
]]
function Particle:_getCreateByType(ptype,imgName,parNum)
    ptype = "" .. ptype
    if ptype == Particle.TYPE_LEAF then
        return self:_createLeaf(imgName,parNum)

    elseif ptype == Particle.TYPE_SNOW then
        return self:_createSnow(imgName,parNum)
    elseif ptype == Particle.TYPE_FIRE then
        return self:_createFire(imgName,parNum)
    elseif ptype == Particle.TYPE_FIRE_FLIES then
        return self:_createFireFlies(imgName,parNum)
    elseif ptype == Particle.TYPE_CLOND then
        return self:_createCloud(imgName,parNum)
    elseif ptype == Particle.TYPE_BUBBLE then
        return self:_createBubble(imgName,parNum)
    elseif ptype == Particle.TPYE_SYSTEM then
        return self:_createParticleFromFile(imgName,parNum)
    end
end


return Particle