--[[--
class：   ScreenMask
inherit:CCLayerColor
desc:   全屏的遮罩层
author：HAN Biao(movinghan@foxmail.com)
event:  无
example:
    local mask = ScreenMask.new(GameConst.COLOR_MASK,-1000)
    self:addChild(mask)
]]

local ScreenMask = class("ScreenMask",function(color,priority)
	local layer = CCLayerColor:create(color)
	CCLayerExtend.extend(layer)
	--layer:setNodeEventEnabled(true)
	return layer
end)

--[[--
    构造函数
  @param color ccc4 遮罩的半透明颜色值
  @param priority Number 遮罩的触摸监听优先级
]]

function ScreenMask:ctor(color,priority)
	self:retain()
	self:setTouchEnabled(true)
	--self:initWithColor(launchCfg.maskColor)
	self._handler = handler(self,self._onTouch)
	self:registerScriptTouchHandler(self._handler,false,priority or 0,true)
end


--[[--
	空实现，屏蔽优先级更低的点击事件触发
]]
function ScreenMask:_onTouch(event,x,y)
	return true
end

function ScreenMask:dispose()
	self:unregisterScriptTouchHandler()
	self:release()
end

return ScreenMask