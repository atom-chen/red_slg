--玩家小头像
local ComHead = class("ComHead",function() return display.newXClipSprite() end)

function ComHead:ctor(res)
	if res then
		self:setHead(res)
	end
end

function ComHead:setHead(res)
	self:setSpriteImage(res,"#com_xtxzz.png",false)
	self:setAnchorPoint(ccp(30/170,25/156))
	self:setScale(0.65)
end

return ComHead