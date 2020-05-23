--
-- Author: wdx
-- Date: 2014-06-13 12:04:10
--

local BagPanel = class("BagPanel", PanelProtocol)

function BagPanel:ctor()
	PanelProtocol.ctor(self,GameLayer.POPUP,Panel.BAG)
	self:init()
end

--初始化
function BagPanel:init()
	self:initUINode("bag","ui/bag/bag.plist")   --uinode ui编辑器

	-- self:getNodeByName("item_detail"):hide()
	local item_all = self:getNodeByName("item_all")
	item_all:addEventListener(Event.MOUSE_CLICK, {item_all, self._item_all_onClick})
	
	local item_equip = self:getNodeByName("item_equip")
	item_equip:addEventListener(Event.MOUSE_CLICK, {item_equip, self._item_equip_onClick})
	
	NotifyCenter:addEventListener(Notify.BAG_GET_ALL, {self, self._onGetAll})
	NotifyCenter:addEventListener(Notify.BAG_CHANGE, {self, self._onGetChanged})
	
	--[[
	self.elemList = {}
	local arr = {"item_all","item_equip","item_detail","item_bg"}
	for i,name in ipairs(arr) do
		local elem = self:getNodeByName(name)   --获取ui编辑器上的按钮
		elem.index = i
		elem:addEventListener(Event.MOUSE_CLICK,{self,self._clickDungeon})  --添加自己的监听
		self.elemList[#self.elemList+1] = elem
	end
	if DungeonModel.curId == 0 then
		DungeonProxy:reqDungeonInfo()
	end
	NotifyCenter:addEventListener(Notify.DUNGEON_INIT, {self,self._initDungeon})   --监听model层的 副本信息变更
	--]]
end

function BagPanel:is_open()
	return true
end

function BagPanel._item_all_onClick(node, event)
	print(node.__cName, " _item_all_onClick")
	if event then dump(event) end
	
	BagProxy:reqBagAll()
end

function BagPanel._item_equip_onClick(node, event)
	print(node.__cName, " _item_equip_onClick")
	if event then dump(event) end
end

function BagPanel:_onGetAll(event)
	print(node.__cName, " _onGetAll")
	if event then dump(event) end
	if not self:is_open() then return end
end

function BagPanel:_onGetChanged(event)
	print(node.__cName, " _onGetChanged")
	if event then dump(event) end
	if not self:is_open() then return end
end

--[[
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
--]]
function BagPanel:onOpened( params )
	print("BagPanel onOpened")
end

return BagPanel