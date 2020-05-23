--[[--
class：     FloatChat
inherit: CCLayer
desc：       聊天框，主界面上用于显现聊天内容
author:  linchm
version: 20131202

event：
	
example：
]]

local FloatChat = class("FloatChat",function()
	return display.newLayer(true)
end)
--[[--
	构造函数
	@param parent  父结点
]]
function FloatChat:ctor()

	self._isRunning = false		--是否在播放聊天信息
	self._isBg = false			--是否显示底图
	self._isDisplay = true		--是否显示聊天框
	self._label = nil
	
	self._pending = {}			--保存聊天信息
	self._floatTime = 2						--显示聊天内容时间
	self._fontSize = 16						--聊天内容字体大小
	
	self._bg = CCLayerColor:create(ccc4(128,128,128,128), display.width, 40)
	self._bg:setPosition(CCPoint(0,100))
	self._bg:setOpacity(50)
	self._bg:retain()
end

--[[--
	设置底框显示Opacity
	@param op  number 0~256
]]
function FloatChat:setOpacity(op)
	self._bg:setOpacity(op)
end

--[[--
	设置底框颜色值
	@param color ccc4 
]]
function FloatChat:setColor(color)
	self._bg:setColor(color)
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
	增加一条聊天信息
	@param msg  String 
]]
function FloatChat:push(msg)
	self._pending[#self._pending + 1] = msg
end

--[[--
	清空聊天内容
]]
function FloatChat:clear()
	for k,v in pairs(self._pending) do
		self._pending[k] = nil 
	end
	self._pending = {}
end

--[[--
	弹出消息内容
]]
function FloatChat:shift()
	if(#self._pending == 0) then
		return nil
	end
	local value = table.remove(self._pending,1)
	return value
end
--[[--
	判断聊天内容是否为空
]]
function FloatChat:isEmpty()
	return #self._pending == 0 or false
end
--[[--
	开始播放聊天内容
]]
function FloatChat:start()
	if not self._isRunning then
		self._isRunning = true
		if not self._isBg then
			self:addChild(self._bg)
			self._isBg = true
		end
		self:_exec()
	end
end

--[[--
	停止动作播放
]]
--[[
function FloatChat:stop()
	if self._sequence then    --如果当前有在播其他动作了，则先清除
		self:stopAction(self._sequence)
		self._sequence:release()
		self._sequence = nil
	end
	
end
]]
--[[--
	执行聊天内容滚动的动作
]]
function FloatChat:_exec()
	if( self:isEmpty() ) then
		echo 'empty'
		self:close()
		return nil
	end
		
	if self._label then
		self:removeChild(self._label, true)
		self._label = nil
	end

	self:_next()
end

--[[--
	滚动下一条信息
]]
function FloatChat:_next()

	local msg = self:pop()
	self._label = ui.newTTFLabel{
        text = msg,
        size = 32,
        x = 10,
        y = 100,
        textValign = ui.TEXT_VALIGN_LEFT,
        dimensions = CCSize(display.width, 200)
    }
   	
	local a2 = CCCallFunc:create(handler(self,self._exec))
	local sequence = transition.sequence({
	    CCMoveBy:create(0.5, CCPoint(0,20)),
	    CCDelayTime:create(self._floatTime),
	    CCFadeOut:create(0.5),
	    a2
	})
	
	self:addChild(self._label)
 	label:runAction(sequence)	
end

--[[--
	关闭聊天
]]
function FloatChat:close()

	self._isRunning = false
	if self._isBg then
		self:removeChild(self._bg)
		self._isBg = false
	end
end

--[[--
  	析构函数：移除事件监听、cleanup定时以及动作、点击监听，析构时调用
]]
function FloatChat:dispose()
	--移除事件监听
	self:close()
	--从父节点移除并清理
	self._bg:removeFromParentAndCleanup(true)
	self._bg:release()
	self._bg = nil
	
	self:removeFromParentAndCleanup(true)
	--移除Touch监听
	
	--移除定时监听

	--移除节点事件监听

	--析构自己持有的计数引用
end

return FloatChat

