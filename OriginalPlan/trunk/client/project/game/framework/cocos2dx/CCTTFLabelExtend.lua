CCTTFLabelExtend = class("CCTTFLabelExtend", CCNodeExtend)
CCTTFLabelExtend.__index = CCTTFLabelExtend

function CCTTFLabelExtend.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, CCTTFLabelExtend)
    target:setPosition(0,0)
    return target
end

function CCTTFLabelExtend:setPosition(x,y)
	if y then
		y = y + 3
		CCNode.setPosition(self,x,y)
	else 
		local ccp = ccp(x.x,x.y)
		ccp.y = ccp.y + 3
		CCNode.setPosition(self,ccp)
	end
end

function CCTTFLabelExtend:getPosition()
	local x,y = CCNode.getPosition(self)
	return x,y-3
end

function CCTTFLabelExtend:getPositionY()
	local y = CCNode.getPositionY(self)
	return y-3
end