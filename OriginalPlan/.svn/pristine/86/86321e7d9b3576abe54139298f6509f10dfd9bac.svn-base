--
-- Author: zhangzhen
-- Date: 2016-07-07 20:30:53
--

local FightResultPanel = class("FightResultPanel",PanelProtocol)

function FightResultPanel:init()
	self.resultPics = {"#fight_lose_icon.png","#fight_win_icon.png"}
	self.resultBgs = {"#fight_tj_ht_03.png","#fight_tj_ht_01.png"}
	self:initUI()
end

function FightResultPanel:initUI()
	self:initUINode("battle_result_UI","ui/fightResult/fightResult.pvr.ccz")
	self:getNodeByName("fight_bg_01"):setScaleX(-1)
	self.btnList = {}
	for i=1,3 do
		local btn = self:getNodeByName("btn"..i)
		btn:addEventListener(Event.MOUSE_CLICK, {self,self.onBtn})
		self.btnList[#self.btnList+1] = btn
		btn:setZOrder(10)
	end
end

function FightResultPanel:onBtn(e)
	local index = table.indexOf(self.btnList,e.target)
	if index == 3 then
		ViewMgr:close(self.panelName)
		ViewMgr:close(Panel.FIGHT)
		ViewMgr:backToHome()

	elseif index == 2 then   --back home
		floatText("敬请期待")
	elseif index == 1 then
		floatText("敬请期待")
	end
end

function FightResultPanel:onOpened(params)
	self.params = params
	self:loadRes()
	self:refresh()
end

function FightResultPanel:refresh()
	if self.params.isWin then
		self:getNodeByName("winPic"):setNewImage(self.resultPics[2])
		self:getNodeByName("winBg"):setNewImage(self.resultBgs[2])

	else
		self:getNodeByName("winPic"):setNewImage(self.resultPics[1])
		self:getNodeByName("winBg"):setNewImage(self.resultBgs[1])
	end
end

function FightResultPanel:onCloseed()
	self:unloadRes()
end


function FightResultPanel:getOpenActionType()
  	return 1
end

return FightResultPanel