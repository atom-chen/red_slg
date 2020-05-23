--[[--
class:GuideArrow
inherit:CCSprite
desc: 引导用的箭头类
	构造参数：arrowUrl放在公用资源的箭头url,默认为#win_guideArrow.png
	箭头的位置，要在构造函数中传入
]]
local GuideArrow = class("GuideArrow",function(arrowUrl)
	return display.newSprite(arrowUrl or "#win_guideArrow.png")
end)

function GuideArrow:ctor(arrowUrl)
	self:retain()
	self._orignX = 0
	self._orignY = 0
	--注册节点事件
	self._tweenAnimator = nil
	self:setNodeEventEnabled(true)
end

function GuideArrow:onEnter()
	self:_clearAction()
	--复原箭头的原来位置
	self:setPosition(self._orignX,self._orignY)
	--箭头开始晃动
	local down = CCMoveBy:create(0.6,ccp(0,-8))
	local up = CCMoveBy:create(0.6,ccp(0,8))
	local tweenDown = CCEaseIn:create(down,1)
	local tweenUp = CCEaseIn:create(up,1)
	self._tweenAnimator =  CCRepeatForever:create(CCSequence:createWithTwoActions(tweenDown,tweenUp))
	self._tweenAnimator:retain()
	self:runAction(self._tweenAnimator)
end

function GuideArrow:_clearAction()
	if(not self._tweenAnimator) then return end
	--箭头取消晃动
	self:stopAction(self._tweenAnimator)
	self._tweenAnimator:release()
	self._tweenAnimator = nil
end

function GuideArrow:onExit()
	self:_clearAction()
end

--[[--
 	设置箭头的指示方向，可多次调用此函数，重置箭头的指示方向
	@param String dir 箭头的指示方向,b:指向下,t:指向上
]]
function GuideArrow:setDir(dir,x,y)
	if dir == "b" then
		self:setRotation(0)
	elseif dir == "t" then
		self:setRotation(180)
	end

	if x then self._orignX = x end
	if y then self._orignY = y end

	if self:isRunning() then  --已经在舞台上了
		self:onExit()
		self:onEnter()
	end
end

function GuideArrow:dispose()
	self:_clearAction()
	self:cleanup()
	self:removeFromParentAndCleanup(true)
	self:setNodeEventEnabled(false)
	self:release()
end

return GuideArrow
