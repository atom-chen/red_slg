--[[
	class:		LoadingPanel
	desc:		加载中面板
	author:		郑智敏
]]

local LoadingPanel = class("LoadingPanel", PanelProtocol)

function LoadingPanel:init()
	local bg = display.newXSprite("#com_tips.png")
	self:addChild(bg)

	self._loadingPic = display.newXSprite("#com_loading.png")
	self:addChild(self._loadingPic)

	local params = {}
	params.text = "加载中"
	params.size = 26
	params.color = ccc3(255,246,207)
	params.align = ui.TEXT_ALIGN_LEFT
	params.valign = ui.TEXT_VALIGN_TOP
	local text = ui.newTTFLabelWithOutline(params)
	self:addChild(text)

	self._currRotation = 0

	self:setPosition(display.cx,display.cy)
end

function LoadingPanel:setText(str)
	self._loadingText:setText(str)
end

function LoadingPanel:_rotatePic()
	self._currRotation = (self._currRotation + 22)%360
	self._loadingPic:setRotation(self._currRotation)
end

function LoadingPanel:preOpen()
	if not self.__scheduleTimeId then
		self.__scheduleTimeId = scheduler.scheduleGlobal(function() self:_rotatePic() end, 0.01)
	end
end

function LoadingPanel:onCloseed()
	if self.__scheduleTimeId then
		scheduler.unscheduleGlobal(self.__scheduleTimeId)
		self.__scheduleTimeId = nil
	end
end

function LoadingPanel:isShowMark( )
	return false
end

return LoadingPanel