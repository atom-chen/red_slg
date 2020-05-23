--
-- Author: wdx
-- Date: 2014-04-14 22:24:23
--
local Card = class("Card",function()
							  return display.newNode()
						  end)


Card.WIDTH = 80
Card.HEIGHT = 150


function Card:ctor(w,h)
	-- body
	self.width = w or Card.WIDTH
	self.height = h or Card.WIDTH
	self:setContentSize(CCSize(Card.WIDTH,Card.HEIGHT))
end

function Card:init(id,level )
	self.id = id
	self.img = display.newsprite("card/"..id..".png")
	self.img:setAnchorPoint(ccp(0,0))
	local size = self.img:getContentSize()
	self.img:setscale(self.width/size.width)
	self:addChild(self.img);

	local params = {}
		params.text = id.."-->Lv."..level;
	    params.size = 22
		params.color = display.COLOR_RED
	    params.align = ui.TEXT_ALIGN_CENTER
	    params.valign = ui.TEXT_VALIGN_TOP
	   	params.dimensions = CCSize(Card.WIDTH,30)
	   	params.outlineColor = ccc3(0,0,0)

	self.name = ui.newTTFLabel(params)
	--self.name:setPosition(ccp(15,15));
	self.name:setAnchorPoint(ccp(0,0.5));
	self:addChild(self.name);   --文本
end


function Card:dispose()
	
end


return Card

