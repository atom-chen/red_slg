--[[--
class：     Button
inherit: TouchBase
desc：       空白区域，只用来监听事件用
author:  HAN Biao
event：
	Event.MOUSE_DOWN:鼠标按下时，发出此事件
	Event.MOUSE_UP：   鼠标松开时，发出此事件
	Event.MOUSE_CANCEL:按下时，移动等，发出此事件
example：
	local mybtn = EmptyButton.new(CCSize(100,100))
	self:addChild(mybtn)
	mybtn:addEventListener(Event.MOUSE_UP, function()
		echo("mouse up")
	end)
]]

local EmptyButton = class("Button",TouchBase)

function EmptyButton:ctor(size)
	--基类构造函数
	EmptyButton.super.ctor(self)
	--构造本类
	EventProtocol.extend(self)

	--处理触摸时移动的变量
	self._isMoved = false
	self._beforeMovePoint = nil
	self._mhtDistance = 0

	self._hitRect = CCRect(0,0,size.width,size.height)
	self:setContentSize(size)
	self:changeTouchEnabled(true)     --CCLayer启用触摸
end

--鼠标按下时
function EmptyButton:_onTouchBegan(event,x,y)
	local pos = self:convertToNodeSpace(ccp(x,y))
	local rect = self._hitRect
	if(rect:containsPoint(pos)) then
		self:_onTouchDown(x,y)
		self:dispatchEvent({name = Event.MOUSE_DOWN})
		return true
	end
end

--鼠标移动时
function EmptyButton:_onTouchMoved(event,x,y)
	self:_onTouchMove(x,y)
end

--鼠标正常弹起时
function EmptyButton:_onTouchEnded(event,x,y)
	local posObj = ccp(x,y)
	local isValid = self:_isTouchValid()
	if isValid then
	  AudioMgr:playEffect(GameConst.EFFECT_CLICK)
    self:dispatchEvent({name = Event.MOUSE_UP,pos=posObj})
  else 
    self:dispatchEvent({name = Event.MOUSE_CANCEL})
	end
	self:_onTouchUp()
end

--鼠标取消时
function EmptyButton:_onTouchCanceled(event,x,y)
	self:dispatchEvent({name = Event.MOUSE_CANCEL})
	self:_onTouchUp()
end

--鼠标事件，统一接收函数，再根据类型，交由对应函数处理
function EmptyButton:_onTouch(event,x,y)
	local ret
	if event == "began" then
		ret = self:_onTouchBegan(event,x,y)
	elseif event == "moved" then
		self:_onTouchMoved(event,x,y)
	elseif event == "ended" then
		self:_onTouchEnded(event,x,y)
	elseif event == "canceled" then
		self:_onTouchCanceled(event,x,y)
	end
	return ret
end

--[[--
  	析构函数：移除事件监听、cleanup定时以及动作、点击监听，析构时调用
]]
function EmptyButton:dispose()
	--移除事件监听
	self:removeAllEventListeners()

	--从父节点移除并清理
	self:cleanup()
	self:removeFromParentAndCleanup(true)

	--移除Touch监听
	self:removeTouchEventListener()

	self._hitRect = nil

	--基类析构函数
	EmptyButton.super.dispose(self)
end

return EmptyButton