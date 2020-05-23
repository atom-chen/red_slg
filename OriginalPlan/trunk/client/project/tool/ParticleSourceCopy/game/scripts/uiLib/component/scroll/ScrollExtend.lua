

-------------------------ScrollTouchExtend---------------------------------
ScrollTouchExtend = class("ScrollTouchExtend")
ScrollTouchExtend.__index = ScrollTouchExtend

function ScrollTouchExtend.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, ScrollTouchExtend)
    return target
end

--点击是否有效
function ScrollTouchExtend:isTouchValid(x,y)
	local parent = self:getParent()
	while parent ~= nil do
		if tolua.isTypeOf(parent,"CCScrollView") then
			parent = tolua.cast(parent,"CCScrollView")
			local rect = parent:getViewRect()
			if rect:containsPoint(ccp(x,y)) then  
				return true  --在可视范围内
			else
				return false
			end
		end
		parent = parent:getParent()
	end 
	return true  
end