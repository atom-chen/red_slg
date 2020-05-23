--
-- Author: wdx
-- Date: 2014-06-02 13:57:55
--
XSpriteExtend = class("XSpriteExtend", CCNodeExtend)
XSpriteExtend.__index = XSpriteExtend

function XSpriteExtend.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, XSpriteExtend)
    return target
end

--[[--
	切换一个精灵对象显示成另外一个单独图片的纹理
	@param sprite CCSprite
	@param imageUrl String 如果为nil，则是清除sprite的纹理
]]
function XSpriteExtend:setSpriteImage(imageUrl)
	if not imageUrl then
		self:clearImage()
		return
	end
    if string.byte(imageUrl) == 35 then -- first char is #
		self:setImage(string.sub(imageUrl, 2))
    else
        self:setImageWithPath(imageUrl)
    end
end

function XSpriteExtend:getImgSize()
    return self:getImageSize()
end