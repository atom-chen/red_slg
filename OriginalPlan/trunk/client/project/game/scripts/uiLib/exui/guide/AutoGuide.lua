--[[
author:changao
date:2015/9/25
sample:
	1)
		local guide = AutoGuide.new({target=self.uiNode, onClick=function() guide:dispose() end})
	2)
		local guide = AutoGuide.new({target=self.uiNode, onClick=function() GuideModel:finishGuide(guideId) guide:dispose() end, guideId=1023, index=1,ccp(113, 31), absolute=true, swallow=true})
--]]

local AutoGuide = class("AutoGuide")
--[[
@param target ccnode
@param onClick function click callback
@param guideId int guideId
@param index  int guideId index text
@param pos ccp position
@param absolute boolean whether pos is absolute -- no use
@param swallow boolean whether swallow event
@param priority int event priority
--]]
function AutoGuide:ctor(params)
	if params and params.target then
		self:setGuide(params)
	end
end

function AutoGuide:setGuideId(guideId)
	self._guideId = guideId
end

function AutoGuide:setGuide(params)
	self._guideCallback = params.onClick or params.onClicked or params.callback
	local layerId = ( (params.layerId == nil) and Panel.PanelLayer.NOTIFY_TOP ) or params.layerId
	local p = params.touchPriority or GameLayer.priority[layerId]
	local guide = self:_getNewGuide(params.swallow,p)
	self._guideIndex = params.index
	guide:setTarget(params.target, params.offsetX,params.offsetY, layerId)

	if params.guideId then
		self:setGuideId(params.guideId)
	end
	if params.index then
		guide:showGuideText(self._guideId, params.index, params.pos.x, params.pos.y, layerId, false)
	end
	local parent = params.target:getParent()
--	parent:reorderChild(params.target,2)

	if params.isDownListener then
		guide:setDownCallBack(function()
			self:_removeGuide()
			if self._guideCallback then
				uihelper.call(self._guideCallback)
			end
		  end)
	else
		params.target:addEventListener(Event.MOUSE_CLICK, {self, self._callback}, params.priority or 0)
	end
end

function AutoGuide:_callback(event)
	local touch = event.target
	touch:removeEventListener(Event.MOUSE_CLICK, {self, self._callback})
	self:_removeGuide()
	if self._guideCallback then
		uihelper.call(self._guideCallback)
	end
end

function AutoGuide:hideHand()
	if self._guide then
		self._guide._hand.handIcon:setVisible(false)
	end
end

function AutoGuide:showHand()
	if self._guide then
		self._guide._hand.handIcon:setVisible(true)
	end
end

function AutoGuide:_removeGuide()
	if self._guide then
		self._guide:dispose()
		self._guide:release()
		self._guide = nil
	end
end

function AutoGuide:_getNewGuide( swallow,p )
	if self._guide == nil then
		self._guide = GuideArrow.new()
		self._guide:retain()
	end
	if swallow == nil then
		swallow = true
	end
	self._guide:swallowTouches(swallow,p)
	return self._guide
end

function AutoGuide:dispose()
	self:_removeGuide()
	self._guideCallback = nil
end

return AutoGuide