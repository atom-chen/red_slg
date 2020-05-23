--[[
@sample

	self._attrFlowText = UIFlowText.new(self.uiNode.node['Node_flow'], 0.2, 1, 20, UIInfo.color.cyan, callback)
	self._attrFlowText:addText(texts)
	self._attrFlowText:start()

	if self._attrFlowText then
		self._attrFlowText:stop()
		self._attrFlowText:dispose()
		self._attrFlowText = nil
	end
--]]

local UIFlowText = class("UIFlowText")

--[[
@brief 执行飘动的文字
@param callback 当且仅当有一个以上的文字飘动之后， 并且最后一个添加的文字结束之后执行回调。 当被移除的时候， 不执行
--]]
function UIFlowText:ctor(parent, interval, duration, fontSize, fontColor, callback)
	self._parent = parent
	self._fontSize = fontSize or 20
	self._fontColor = fontColor or UIInfo.color.green
	self._duration = duration or 1.5
	self._interval = interval or 0.2
	self:setFlowInfo(nil, nil, nil)
	self:setCallback(callback)
end

function UIFlowText:getDuration()
	return self._duration
end

function UIFlowText:getTotalTime()
	local n = 0
	local t = 0
	if self._texts then
		n = #self._texts
		if self._index then
			n = n - self._index
		end
	end
	if n > 0 then
		t = self._duration*n + self._interval*(n-1)
	end
	return t
end

function UIFlowText:setZOrder(zorder)
	self._zorder = zorder
end

function UIFlowText:setCallback(callback)
	self._callback = callback
end

function UIFlowText:setFlowInfo(pos, siz, align)
	self._pos = pos or ccp(0,0)
	self._siz = siz or self._parent:getContentSize()
	self._align = align or UIInfo.alignment.CENTER
end

function UIFlowText:setTextType(richtext, shadow, outline)
	if richtext then
		self._richtext = tobool(richtext)
	end
	if shadow then
		self._shadow = tobool(shadow)
	end
	if outline then
		self._outline = outline
	end
end

function UIFlowText:addText(texts)
	if not self._texts then
		self._texts = {}
	end

	if type(texts) == "table" then
		for i,text in ipairs(texts) do
			table.insert(self._texts, text)
		end
	else
		table.insert(self._texts, texts)
	end
end

function UIFlowText:setText(texts)
	self._texts = texts
end


function UIFlowText:start()
	self._index = 1
	self._actions = {}
	self._endPos = ccp(self._pos.x, self._pos.y + self._siz.height - self._fontSize)
	self._timer = UISimpleTimer.new(self._interval,
		function (event) return self:_addTextAction(); end,
		function (event) event.this:stop() end)

	self._timer:start()
end

function UIFlowText:stop()
	for node, action in pairs(self._actions) do
		node:stopAllActions()
		self:removeChild(node)
	end
end

function UIFlowText:isRunning()
	for node, action in pairs(self._actions) do
		return true
	end
	return false
end

function UIFlowText:_addTextAction()
	--print("function UIFlowText:_addTextAction()", self._index)
	if self._index > #self._texts then return false end
	local text = self._texts[self._index]
	local node = UIText.new(self._siz.width, self._fontSize, self._fontSize, nil, self._fontColor, self._align, nil, self._richtext, self._shadow, self._outline)
	if self._zorder then
		self._parent:addChild(node, self._zorder)
	else
		self._parent:addChild(node)
	end
	node:setPosition(self._pos)
	node:setText(text)
	local mvAct = CCMoveTo:create(self._duration, self._endPos)
	local rmAct
	if self._index == #self._texts then
		rmAct = CCCallFunc:create(function ()
			self:removeChild(node)
			uihelper.call(self._callback)
		end)
	else
		rmAct = CCCallFunc:create(function () self:removeChild(node) end)
	end
	local seqAction = CCSequence:createWithTwoActions(mvAct, rmAct)

	self._actions[node] = seqAction
	node:runAction(seqAction)

	self._index = self._index + 1
	return true
end

function UIFlowText:removeChild(node)
	--print("function UIFlowText:removeChild(node)")
	if self._actions[node] then
		self._actions[node] = nil
		node:removeFromParent()
		node:dispose()
	end
end

function UIFlowText:clearTimer()
	if self._timer then
		self._timer:stop()
		self._timer:dispose()
		self._timer = nil
		self._index = nil
		self._endPos = nil
	end
end

function UIFlowText.flow(parent, text, duration, fontSize, fontColor, callback)

	local node = parent
	local onExit = node.onExit
	local clear = false
	local t = {callback=nil}
	local flowText = UIFlowText.new(node, 0.3, duration or 0.5, fontSize or 20, fontColor or UIInfo.color.cyan, t.callback)
	t.callback = function()
		if not clear then
			clear = true
			flowText:stop()
			flowText:dispose()
			uihelper.call(callback)
		end
	end

	flowText:addText(text)
	local tim = flowText:getTotalTime()
	UIDelayCall.new(tim, t.callback, true)
	flowText:start()
end


function UIFlowText.flowEx(params)
	local parent, text, duration, fontSize, fontColor, callback = params.parent, params.text, params.duration, params.fontSize, params.fontColor or params.color, params.callback
	local richtext, shadow, outline = params.richtext, params.shadow, params.outline
	local pos, siz, align = params.pos, params.size, params.align
	local zorder = params.zorder
	local node = parent or ViewMgr:getGameLayer(Panel.PanelLayer.ERROR_LAYER)
	local clear = false
	local flowText = nil
	local callback = function()
		if not clear then
			clear = true
			flowText:stop()
			flowText:dispose()
			uihelper.call(callback)
		end
	end
	
	flowText = UIFlowText.new(node, params.interval or 0.3, duration or 0.5, fontSize or 20, fontColor or UIInfo.color.cyan, callback)
	flowText:setZOrder(zorder)
	flowText:setTextType(richtext, shadow, outline)
	flowText:setFlowInfo(pos, siz, align)

	

	flowText:addText(text)
	local tim = flowText:getTotalTime()
	UIDelayCall.new(tim, callback, true)
	flowText:start()
	return flowText
end



function UIFlowText:dispose()
	--print("function UIFlowText:dispose()")
	self:stop()
	self:clearTimer()
	self._texts = nil
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

return UIFlowText
