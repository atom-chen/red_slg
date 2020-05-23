--[[--
class：     FloatChat
inherit: CCLayer
desc：       聊天框，主界面上用于显现聊天内容
author:  linchm
version: 20131202
event：
example：
	chatLabel = FloatChat.new(msg)
	chatLabel:show(handler(self,self._next))
]]

local FloatChat = class("FloatChat",function()
	return display.newLayer(true)
end)
--[[--
	构造函数
]]
function FloatChat:ctor(text)

	self._floatTime = 2						--显示聊天内容时间
	self._fontSize = 32						--聊天内容字体大小

	self._label = ui.newTTFLabel{
        text = text,
        size = self._fontSize,
        x = 10,
        y = 100,
        textValign = ui.TEXT_VALIGN_LEFT,
        dimensions = CCSize(display.width, 200)
    }
	self._label:retain()
	self:addChild(self._label)
	
end

--[[--
	设置每条信息停留时间
	@param sec  number 时间(s)
]]
function FloatChat:setFloatTime(sec)
	self._floatTime = sec
end

--[[--
	设置聊天字体大小
	@param sec  number 大小
]]
function FloatChat:setFontSize(size)
	self._fontSize = size
end

--[[--
	滚动显示聊天内容
	@param callFunc  function 回调函数
]]
function FloatChat:show(callFunc)
	local seqArr = CCArray:create()
	seqArr:addObject(CCMoveBy:create(0.5, CCPoint(0,20)))
	seqArr:addObject(CCDelayTime:create(self._floatTime))
	seqArr:addObject(CCFadeOut:create(0.5))
	
	if callFunc then
		local call = CCCallFunc:create(callFunc)
		seqArr:addObject(call)
	end
	
	local sequence = CCSequence:create(seqArr)
 	self._label:runAction(sequence)
end

--[[--
  	析构函数：移除事件监听、cleanup定时以及动作、点击监听，析构时调用
]]
function FloatChat:dispose()
	--移除事件监听
	
	--从父节点移除并清理
	
	self:removeFromParentAndCleanup(true)
	--移除Touch监听
	
	--移除定时监听

	--移除节点事件监听

	--析构自己持有的计数引用
	self._label:release()
end

return FloatChat

