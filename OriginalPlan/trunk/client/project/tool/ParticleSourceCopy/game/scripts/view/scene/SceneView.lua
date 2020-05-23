--[[--
  主城
]]
local SceneView = class("SceneView",function()
    return display.newSprite(false)
end)

function SceneView:ctor()

 
end

function SceneView:show()    
    self.an = Avatar:createWithResName("skill");
    self.an:setAnchorPoint(ccp(0,0))
    self:addChild(self.an)
    self.an:playAnimate("atk",3);
    self.an:addEventScriptFunc("stop",function(eventName,animateName) 
                                        self:stopCallback(eventName,animateName) 
                                         end
                                         );
--    scheduler.scheduleGlobal(function() self:stopCallback("aaa","atk") end,5)
    
    
--    local animCache = CCAnimationCache:sharedAnimationCache()
--    local animation = animCache:animationByName("skill_atk")
--    animation:setLoops(100000)
--    local animate = CCAnimate:create(animation)
   
    --an:runAction(animate)
    
end


function SceneView:stopCallback(eventName,animateName)
    print("播放完了。。。",eventName,animateName)
    if(animateName == "atk")then
        print("确实是等于啊")
        self.an:playAnimate("hurt",5);
    elseif animateName == "hurt" then
        self.an:playAnimate("atk",5);
    end
    
    
end



return SceneView
