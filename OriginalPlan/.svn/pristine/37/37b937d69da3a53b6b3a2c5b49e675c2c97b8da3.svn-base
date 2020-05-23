--
-- Author: Your Name
-- Date: 2014-07-20 21:22:14
--
XClipSpriteExtend = class("XClipSpriteExtend", CCNodeExtend)
XClipSpriteExtend.__index = XClipSpriteExtend

local unloadTimer = nil

function XClipSpriteExtend.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, XClipSpriteExtend)
    return target
end
--[[--
	切换一个精灵对象显示成另外一个单独图片的纹理
	@param sprite CCSprite
	@param imageUrl String 如果为nil，则是清除sprite的纹理
    #
]]
function XClipSpriteExtend:setSpriteImage(imageUrl,maskUrl,isAll,rect)
	if not imageUrl or not maskUrl then
		self:setImageMask(nil,nil,"")
		return
	end
	if isAll ~= false then
		isAll = true
	end

	local name = imageUrl
	if string.byte(imageUrl) == 35 then
		name = string.sub(imageUrl, 2)
	end
	name = name.."[]"..maskUrl

	if ResMgr:isResReady(name) then
		self:setImageWithPath(name)
	else
		if string.byte(imageUrl) ~= 35 then   --是路径图片的   切图完之后要卸载资源
			ResMgr:loadImage(imageUrl)
		end
		local img = display.newSprite(imageUrl)
		if rect then
			img:setTextureRect(rect)
		end
	    local mask = display.newSprite(maskUrl)
	    mask:setAnchorPoint(ccp(0,0))
		if isAll then
			local size = mask:getContentSize()
			local imgSize = img:getContentSize()

			img:setScaleX(size.width/imgSize.width)
			img:setScaleY(size.height/imgSize.height)
		end
	    self:setImageMask(img,mask,name)
	    if string.byte(imageUrl) ~= 35 then   --是路径图片的   切图完之后要卸载资源
			ResMgr:unload(imageUrl)
		end
	end
end

function XClipSpriteExtend:setClipRect(rect)
	local size = self:getContentSize()
    local sourceRect = CCRect(0,0,size.width,size.height)
    sourceRect.size = rect.size
    sourceRect.origin.x = sourceRect.origin.x + rect.origin.x
    sourceRect.origin.y = sourceRect.origin.y + rect.origin.y
    self:setTextureRect( sourceRect)
end
