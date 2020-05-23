local UIFloatText = class("UIFloatText")

function UIFloatText:ctor(parent, duration, fontSize, fontColor, anchor, zindex)
	self:setParent(parent)
	
	self._fontSize = fontSize or 20
	self._fontColor = fontColor or UIInfo.color.green
	self._duration = duration or 1.5
	self._leftTime = self._duration
	self._interval = 0.2
	self._anchor = anchor or ccp(0.5, 0.5)
	self._zindex = zindex
	
	self:setTextInfo(nil, nil)
end

function UIFloatText:setTextInfo(align, valign)
	self.align = align or UIInfo.alignment.LEFT
	self.valign = valign or UIInfo.alignment.BOTTOM
end

function UIFloatText:addDuration(duration)
	self._leftTime = self._leftTime + duration
end

function UIFloatText:setRTF(flag)
	self._rtf = tobool(flag)
end

function UIFloatText:setOutline(flag)
	self._outline = tobool(flag)
end

function UIFloatText:setShadow(flag)
	self._shadow = tobool(flag)
end

function UIFloatText:reset()
	self._leftTime = self._duration
end

function UIFloatText:setParent(parent)
	if type(parent) == "string" then
		self._parent = ViewMgr:getParent(parent)
	else
		self._parent = parent
	end
	
	
	
	if self._textnode then
		self._textnode:removeFromParent()
		uihelper.addChild(self._parent, self._textnode, self._anchor, self._zindex)
		self:start()
	end
end

function UIFloatText:setDuration(duration)
	self._duration = duration or self._duration
end

function UIFloatText:getDuration()
	return self._duration
end

function UIFloatText:getLiftTime()
	return self._leftTime
end

function UIFloatText:setText(text, notResetDuration)
	if not notResetDuration then
		self:setDuration(self._duration)
	end
	self._text = text
	self:start()
end

function UIFloatText:clearTextNode()
	if self._textnode then
		self._textnode:removeFromParent()
		if self._autoDispose and self._textnode.dispose then
			self._textnode:dispose()
		end
		self._textnode:release()
		self._textnode = nil
	end
end

function UIFloatText:setTextNode(textnode, autoDispose)
	if self._textnode == textnode then return end
	self:clearTextNode()
	
	self._textnode = textnode
	self._textnode:retain()
	self._autoDispose = tobool(autoDispose)
	uihelper.addChild(self._parent, self._textnode, self._anchor, self._zindex)
end
	
function UIFloatText:start()
	if self._timer then
		if self._timer:isRunning() then
			--assert(false, "timer should not ")
			self._timer:stop()
		end
	else
		self._timer = UISimpleTimer.new(self._interval, 
			function (event) return self:_addTextAction(); end, 
			function (event) event.this:stop();self:stop() end)
	end
	
	self:reset()
	self._timer:start()
end

function UIFloatText:stop()
	self:clearTimer()
	self:clearTextNode()
end

function UIFloatText:_addTextAction()
	if not self._textnode then
	--	if not self._siz then
			self._siz = self._parent:getContentSize()
	--	end
		local textnode = UIText.new(self._siz.width, self._fontSize, self._fontSize, nil, self._fontColor, self.align, self.valign, self._rtf, self._shadow, self._outline)
		self:setTextNode(textnode, true)
	end
	
	self._textnode:setText(self._text)
	--[[
	local mvAct = CCMoveTo:create(self._duration, self._endPos)
	local rmAct = CCCallFunc:create(function () self:removeChild(node) end)
	local seqAction = CCSequence:createWithTwoActions(mvAct, rmAct)
	
	self._actions[node] = seqAction
	node:runAction(seqAction)
	print(text)
	self._index = self._index + 1
	--]]
	self._leftTime = self._leftTime - self._interval
	if self._leftTime <= 0 then
		return false
	end
	return true
end

function UIFloatText:removeChild(node)
	self._actions[node] = nil
	node:removeFromParent()
	node:dispose()
end

function UIFloatText:clearTimer()
	if self._timer then
		self._timer:stop()
		self._timer:dispose()
		self._timer = nil
	end
end

function UIFloatText:dispose()
	self:stop()
	self._text = nil
	self._parent = nil
	self._fontSize = nil
	self._fontColor = nil
	self._duration = nil
	self._interval = nil
	self._pos = nil
	self._siz = nil
	self._align = nil
end
--[[
local UIAction.flyTo(node, desPos, duration)
	local act = CCAciton:create(duration, desPos)
	
	transimit.execute(node, act)
end
--]]

return UIFloatText