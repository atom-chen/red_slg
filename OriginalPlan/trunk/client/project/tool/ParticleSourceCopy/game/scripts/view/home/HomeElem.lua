--
-- Author: wdx
-- Date: 2014-06-08 19:09:28
--

local HomeElem = class("HomeElem",TouchBase)

function HomeElem:ctor(sysName,image,priority)
	TouchBase.ctor(self,priority,false)
	
	self.sysName = sysName
	self.image = image
	
	self:touchEnabled(true)

	self:init()
end

function HomeElem:init()
	--print(self.eName)
	self.sp = display.newXSprite(self.image)
	self.sp:setAnchorPoint(ccp(0,0))
	self:addChild(self.sp)

	self:setContentSize(self.sp:getImgSize())
end

function HomeElem:onTouchDown(x,y)
	return true
end

--点击到了
function HomeElem:onTouchUp(x,y)
	--ViewMgr:close(Panel.HOME)
	ViewMgr:open(self.sysName)
end

function HomeElem:onTouchCanceled(x, y)
	--self.sp:setSpriteImage(self.eName)
end

function HomeElem:dispose()
	self.sp:setSpriteImage(nil)
	TouchBase.dispose(self)
end

return HomeElem