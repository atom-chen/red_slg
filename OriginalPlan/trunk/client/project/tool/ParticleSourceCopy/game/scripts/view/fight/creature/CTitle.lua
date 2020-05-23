--
-- Author: wdx
-- Date: 2014-04-21 21:24:16
--


--[[--
玩家上的  血量 名字 什么的  信息   暂时  todo
]]

local CTitle = class("CTitle",function()
								return display.newNode()
								end)

function CTitle:ctor()
	self.blood = uihelper.newProgressBar(3,110,19)
	self.blood:setAnchorPoint(ccp(0.5,0.5))
	self.blood:setProgress(100)
	self.blood:retain()
	self:addChild(self.blood)
end

function CTitle:init(info)
	self.name = display.newNode()
	local c
	if info.team == 1 then
		c = ccc3(0,255,0)
	else
		c = ccc3(255,0,0)
	end
	local label = ui.newTTFLabelWithOutline({
			text = info.id,
			font = "Arial",
			size = 20,
			bold = 1,
			x = 0,
			y = 0,
			align = ui.TEXT_ALIGN_CENTER,
			color = c,
			outlineColor = ccc3(0,0,0),
			dimensions = CCSize(250, 47)
		})
		self:addChild(label)
end

function CTitle:setBlood( cur,max )
	self.blood:setProgress(cur*100/max)
end



return CTitle
