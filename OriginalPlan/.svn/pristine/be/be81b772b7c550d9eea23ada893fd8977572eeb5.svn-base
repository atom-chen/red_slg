local AutoTip = class("AutoTip")

--[[
--]]
function AutoTip:ctor(params)
	self._callback = params.callback
	self._guideTip = GuideTip.new(params.picType)--, {self, self._guideEnd}
	local gLayer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY_TOP)
	gLayer:addChild(self._guideTip)
	self._guideTip:setPosition(params.x or display.cx-100, params.y or display.cy - 100)
	if params.text then
		self._guideTip:setText(params.text, {self, self._showEnd})
	else
		self._guideTip:setGuideText(params.guideId, params.index, {self, self._showEnd})
	end
	--self._delayCall = UIDelayCall.new(params.duration or 2, {self, self._guideEnd}, true)
	self._duration = params.duration
	self._textShowEndCall = params.textEndCall

	if params.swallow then
		ViewMgr:touchCover(self._duration + 2)
	end
end

function AutoTip:_showEnd()
	self._delayCall = UIDelayCall.new(self._duration, {self, self._guideEnd}, true)
	if self._textShowEndCall then
		self._textShowEndCall()
	end
end

function AutoTip:_guideEnd()
	if self._guideTip then
		self._guideTip:dispose()
		self._guideTip = nil
	end
	if self._delayCall then
		self._delayCall:dispose()
		self._delayCall = nil
	end
	uihelper.call(self._callback)
	self._callback = nil
end


function AutoTip:dispose()
	self:_guideEnd()
	self._callback = nil
	self._duration = nil
end

return AutoTip