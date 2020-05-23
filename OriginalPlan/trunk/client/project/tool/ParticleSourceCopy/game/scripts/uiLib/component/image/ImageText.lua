--[[--
class：     ImageText
inherit: ResImage
desc：       
author:  ao chang
event：
example：
	local imgText = ImageText.new("img.png","i am the text")

]]


--local ImageText = class("ImageText", function (width, height, img, text)  end)
local ImageText = class("ImageText", function()
	return display.newLayer(false)
end)
RichText = require("uiLib.component.text.RichText")
function ImageText:ctor(width, height, img, text)
	
	self._img = XSprite:createWithImage(img);
	self._img:setImageSize(CCSize(width,height))
	self._img:setAnchorPoint(ccp(0.5, 0.5))
	self._img:retain()
	
	
	local fontSize = 18 
	self._richTxt = RichText.new(width,
					height,
					fontSize,
					ccc3(255,255,255),
					0,
					RichText.ALIGN_CENTER)

	self._richTxt:setString(text)
	self._richTxt:setAnchorPoint(ccp(0.5, 0.5))
	self._richTxt:retain()
	self._richTxt:setPosition(width/2, height/2)
	self._img:addChild(self._richTxt, 1)
	self:addChild(self._img, 1)
end

function ImageText:dispose()

	self._richTxt:dispose()
	self._richTxt:release()
	self._richTxt = nil
	
	self._img.release()
	self._img = nil
	
	self:release()
end

return ImageText


