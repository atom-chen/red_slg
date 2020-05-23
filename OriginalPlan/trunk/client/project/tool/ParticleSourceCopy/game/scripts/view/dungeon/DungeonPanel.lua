--
-- Author: wdx
-- Date: 2014-06-13 12:04:10
--

local DungeonPanel = class("DungeonPanel",PanelProtocol)

function DungeonPanel:ctor()
	PanelProtocol.ctor(self,GameLayer.POPUP,Panel.DUNGEON)
	self:init()
end

--初始化
function DungeonPanel:init()
	self:initUINode("dungeon","ui/dungeon/dungeon.plist")   --uinode ui编辑器

	self.elemList = {}
	local arr = {"911","941","791","761","851","881"}
	for i,name in ipairs(arr) do
		local elem = self:getNodeByName("stage-"..name)   --获取ui编辑器上的按钮
		elem.index = i
		elem:addEventListener(Event.MOUSE_CLICK,{self,self._clickDungeon})  --添加自己的监听
		self.elemList[#self.elemList+1] = elem
	end
	if DungeonModel.curId == 0 then
		DungeonProxy:reqDungeonInfo()
	end
	NotifyCenter:addEventListener(Notify.DUNGEON_INIT, {self,self._initDungeon})   --监听model层的 副本信息变更
end


function DungeonPanel:_initDungeon()
	for i,elem in ipairs(self.elemList) do
		local dInfo = elem.dInfo
		if dInfo then 
			local status = DungeonModel:getDungeonStatus(dInfo.id)
			local color
			if status == 0 then
				color = GameConst.COLOR_GRAY
			elseif status == 1 then
				color = GameConst.COLOR_RED
			else
				color = GameConst.COLOR_GREEN
			end
			elem:setText(dInfo.name, 18, nil, color)
		end
	end
end

--初始化章节
function DungeonPanel:setChapther( cId,dId )
	local list = DungeonCfg:getChaptherDungeon(cId)  --获取章节的副本
	for i,dInfo in ipairs(list) do
		local elem = self.elemList[i]
		if elem then
			elem.dInfo = dInfo
			local status = DungeonModel:getDungeonStatus(dInfo.id)
			local color
			if status == 0 then
				color = GameConst.COLOR_GREEN
			elseif status == 1 then
				color = GameConst.COLOR_RED
			else
				color = GameConst.COLOR_GRAY
			end
			elem:setText(dInfo.name, 18, nil, color)
		end
	end
end

function DungeonPanel:_clickDungeon(event)
	local elem = event.target
	local dInfo = elem.dInfo
	if dInfo.id == self.curId then
		DungeonProxy:reqDungeonFightEnd(dInfo.id,3)
	else
		self.curId = dInfo.id
		DungeonProxy:reqDungeonFight(dInfo.id)
	end

end

function DungeonPanel:onOpened( params )
	params = {chaptherId=1}
	local cId = params.chaptherId
	local dId = params.dId
	self:setChapther(cId,dId)
end

return DungeonPanel