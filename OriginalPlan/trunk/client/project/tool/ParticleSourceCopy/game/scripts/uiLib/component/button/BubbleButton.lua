--[[--
class：     BubbleButton
inherit: Button
desc：        主界面上用的缩放效果按钮类
author:  HAN Biao
event：
	Event.MOUSE_DOWN:鼠标按下时，发出此事件
	Event.MOUSE_UP：   鼠标松开时，发出此事件
example：
	local bubblebtn = BubbleButton.new("chuzhan.png")
	bubblebtn:setPosition(ccp(400,300))
	self:addChild(bubblebtn)
	bubblebtn:addEventListener(Event.MOUSE_UP,{self,self.onClickBtn})
]]

local BubbleButton = class("BubbleButton",Button)

--构造函数，同Button类说明
function BubbleButton:ctor(imageUp,imageDown,imageDisabled)
	BubbleButton.super.ctor(self,imageUp,imageDown,imageDisabled)
end

--鼠标正常弹起时
function BubbleButton:_onTouchEnded(event,x,y)
	self._state = Button.STATE_UP
	self:_updateImage()
	if self._disabled and (not self._mouseWhenDisabled) then  --如果禁用按钮，同时设置不继续发出事件
		return
	end
	if self._isMoved then    --如果按下按钮后，有移动
		if self._mhtDistance > GameConst.MHT_DISTANCE then
			self:dispatchEvent({name = Event.MOUSE_CANCEL})
			return
		end
	end
--	AudioMgr.playEffect(GameConst.EFFECT_CLICK)
	self:dispatchEvent({name = Event.MOUSE_BUBBLE})

	--先禁掉触摸
	self:setTouchEnabled(false)
	self:_zoom1(40, 0.08, function()
            self:_zoom2(40, 0.09, function()
                self:_zoom1(20, 0.10, function()
                    self:_zoom2(20, 0.11, function()
                        self:setTouchEnabled(true)
                       	self:dispatchEvent({name = Event.MOUSE_UP})
                    end)
                end)
            end)
        end)
end

function BubbleButton:_zoom1(offset, time, onComplete)
	local upImage = self:_getImage(1)
    local x, y = upImage:getPosition()
    local size = upImage:getContentSize()

    local scaleX = upImage:getScaleX() * (size.width + offset) / size.width
    local scaleY = upImage:getScaleY() * (size.height - offset) / size.height

    transition.moveTo(upImage, {y = y - offset, time = time})
    transition.scaleTo(upImage, {
        scaleX     = scaleX,
        scaleY     = scaleY,
        time       = time,
        onComplete = onComplete,
    })
end

function BubbleButton:_zoom2(offset, time, onComplete)
	local upImage = self:_getImage(1)
    local x, y = upImage:getPosition()
    local size = upImage:getContentSize()

    transition.moveTo(upImage, {y = y + offset, time = time / 2})
    transition.scaleTo(upImage, {
        scaleX     = 1.0,
        scaleY     = 1.0,
        time       = time,
        onComplete = onComplete,
    })
end

function BubbleButton:dispose()
	BubbleButton.super.dispose(self)
end

return BubbleButton

