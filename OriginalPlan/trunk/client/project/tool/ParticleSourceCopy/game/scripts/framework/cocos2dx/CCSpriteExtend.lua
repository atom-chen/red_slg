
CCSpriteExtend = class("CCSpriteExtend", CCNodeExtend)
CCSpriteExtend.__index = CCSpriteExtend

function CCSpriteExtend.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, CCSpriteExtend)
    return target
end

function CCSpriteExtend:playAnimationOnce(animation, removeWhenFinished, onComplete, delay)
    return transition.playAnimationOnce(self, animation, removeWhenFinished, onComplete, delay)
end

function CCSpriteExtend:playAnimationForever(animation, delay)
    return transition.playAnimationForever(self, animation, delay)
end

--[[--
	切换一个精灵对象显示成另外一个单独图片的纹理
	@param sprite CCSprite
	@param imageUrl String 如果为nil，则是清除sprite的纹理
]]
function CCSpriteExtend:setSpriteImage(imageUrl)
	if not imageUrl then
		self:setTexture(nil)
        self:setTextureRect(CCRect(0,0,0,0))
		return
	end
    if string.byte(imageUrl) == 35 then -- first char is #
        local frame = display.newSpriteFrame(string.sub(filename, 2))
        if frame then
			self:setDisplayFrame(frame)
        else
        	echoError(imageUrl.." no found")
        end
    else
        local texture = CCTextureCache:sharedTextureCache():addImage(imageUrl)
		self:setTexture(texture)
		if texture then
			local size = texture:getContentSize()
			self:setTextureRect(CCRect(0,0,size.width,size.height))
		end
    end
end
