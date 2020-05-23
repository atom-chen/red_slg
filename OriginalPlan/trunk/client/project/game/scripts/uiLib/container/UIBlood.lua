--[[
@brief 血条
@
--]]
local UIBlood = class("UIBlood", UIProgressBar)

function UIBlood:ctor(width, height, color, priority, swallowTouches)
	local barImage, bgImage = self:_getColorImage(color)
	local w,h
	local barMaxSize, bgMaxSize
	if not width and not height then
		-- w = nil; h = nil;
	else
		if width and height then
			w = width
			h = height
		else
			local tmpImg = display.newXSprite(bgImage)
			local bgSize = tmpImg:getContentSize()
			if width then
				w = width
				h = math.floor(w/bgSize.width * bgSize.height)
			elseif height then
				h = height
				w = math.floor(h/bgSize.height * bgSize.width)
			end
		end
		bgMaxSize = CCSize(w, h)
		barMaxSize = CCSize(w-6, h-4)
	end

	UIProgressBar.ctor(self, barImage, bgImage, barMaxSize, bgMaxSize, nil, 100, priority, swallowTouches)
end

function UIBlood:_getColorImage(color)
	local bgImage = "#com_blood_B.png"
	local barImages = {red="#com_blood_R.png", green="#com_blood_G.png",tactic="#tactic_3.png"}
	local barImage = barImages.green
	if color == "red" then
		barImage = barImages.red
	elseif color == "green" then
		barImage = barImages.green
	elseif color == "tactic" then
		barImage = barImages.tactic
		bgImage = "#tactic_3a.png"
	elseif color == "fight_mate" then
		barImage = "#fight_blood_1.png"
		bgImage = "#fight_blood_frame.png"
	elseif color == "fight_enemy" then
		barImage = "#fight_blood_1.png"
		bgImage = "#fight_blood_frame.png"
	end
	return barImage, bgImage
end

function UIBlood:setColor(color)
	local img = self:_getColorImage(color)
	self:setBarImage(img, true)
end

function UIBlood:setBlood(blood)
	self:setProgress(blood, true)
end

function UIBlood:setMaxBlood(blood)
	self:setMaxProgress(blood or 100)
end

return UIBlood
