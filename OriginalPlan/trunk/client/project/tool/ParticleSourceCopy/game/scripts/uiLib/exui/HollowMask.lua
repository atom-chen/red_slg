--[[--
class：   HollowMask
inherit:CCClippingNode
desc:   遮罩层，支持中间一个矩形区域挖空，其他部分半透明。镂空部分不会屏蔽事件触摸。
author：HAN Biao(movinghan@foxmail.com)
event:  无
example:
    local mask = HollowMask.new(GameConst.COLOR_MASK,CCRect(100,100,300,300),-1000)
    self:addChild(mask)
]]

local HollowMask = class("HollowMask",function(color,hollowRect,priority)
    local node = CCClippingNode:create()
    CCNodeExtend.extend(node)
    return node
end)

--[[--
    构造函数
  @param color ccc4 遮罩的半透明颜色值
  @param hollowRect CCRect 遮罩中间镂空的矩形区域信息,不能为nil
  @param priority Number 遮罩的触摸监听优先级
]]
function HollowMask:ctor(color,hollowRect,priority)
  self:retain()
  
  
  self._pColor = CCLayerColor:create(color)
  self._pColor:retain()
  self:addChild(self._pColor)
  self._pColor:setTouchEnabled(true)
  self._handler = handler(self,self._onTouch)
  self._pColor:registerScriptTouchHandler(self._handler,false,priority,true)
  
  self._hollowRect = hollowRect

  local w = self._hollowRect.size.width
  local h = self._hollowRect.size.height
  local points = CCPointArray:create(4)
  local lb = ccp(0,0) 
  local lt = ccp(0,h)
  local rt = ccp(w,h)
  local rb = ccp(w,0)
  points:add(lb)
  points:add(lt)
  points:add(rt)
  points:add(rb)
  
  local fillColor = ccc4f(1,1,1,1)
  local borderColor = ccc4f(1,1,1,1)
  local borderWidth = 0
  local drawNode = CCDrawNode:create()
  drawNode:drawPolygon(points:fetchPoints(),points:count(),fillColor,borderWidth,borderColor)
  drawNode:setPosition(self._hollowRect.origin.x,self._hollowRect.origin.y) 
  
  self:setStencil(drawNode)
  self:setInverted(true)
end


--[[--
  空实现，屏蔽优先级更低的点击事件触发
]]
function HollowMask:_onTouch(event,x,y)
  --是否在中间镂空区域,如果是，则不吞并
  if self._hollowRect then
    local pt = ccp(x,y)
    if self._hollowRect:containsPoint(pt) then
        return false
    end
  end
  return true
end

function HollowMask:dispose()
  self._pColor:unregisterScriptTouchHandler()
  self._pColor:release()
  self:release()
end

return HollowMask