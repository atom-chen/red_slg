--region UIEditBox.lua
--Author : zhangzhen
--Date   : 2014/6/26
--此文件由[BabeLua]插件自动生成

local UIEditBox = class("UIEditBox", TouchBase)
UIAction = game_require("uiLib.container.UIAction")
UIUserDataProtocol = game_require("uiLib.container.UIUserDataProtocol")
function UIEditBox:ctor(images,_size, priority,swallowTouches)
	TouchBase.ctor(self,priority,swallowTouches)
	UIUserDataProtocol.extend(self)

    self.body =  ui.newEditBox({image = images, size=_size})
    self.body:setPosition(ccp(0,0))
    self.body:setAnchorPoint(ccp(0,0))
    self:setContentSize( _size )
    self:touchEnabled(true)
    self:addChild(self.body)
end

function UIEditBox:setInputFlag(eType)
    self.body:setInputFlag(eType)
end

 function UIEditBox:setFont(name,size)
    self.body:setFont(name,size)
 end

 function UIEditBox:getBody()
    return self.body
 end

 function UIEditBox:setFontColor(color)
    self.body:setFontColor( color)
 end

 function UIEditBox:setColor(color)
    self.body:setFontColor(color)
 end

 function UIEditBox:setText( text)
    self.body:setText( text)
 end

 function UIEditBox:getText()
    return self.body:getText()
 end

function UIEditBox:_onTouch(event,x,y)
	local ret
	if event == "began" then
		ret = self:_onTouchBegin(x,y)
	elseif event == "moved" then
		self:_onTouchMove(x,y)
	elseif event == "ended" then
		self:_onTouchEnd(x,y)
	elseif event == "canceled" then
		self:onTouchCanceled(x,y)
	end
	return ret
end

function UIEditBox:onTouchDown(x,y)

	--print("image up down", self._imageInfo.imageUp, self._imageInfo.imageDown)
    if not self.Ignore then
        self.body:touchDownAction(self,CCControlEventTouchDown )
        return true
    else
        return false
    end

end
return UIEditBox
--endregion
