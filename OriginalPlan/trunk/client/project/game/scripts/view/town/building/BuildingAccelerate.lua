local BuildingInfo = game_require('model.town.BuildingInfo')

local BuildingAccelerate = class("BuildingAccelerate", PanelProtocol)

BuildingAccelerate.UIResPath = "ui/building/building_accelerate.pvr.ccz"
BuildingAccelerate.LUA_PATH = "building_accelerate"

function BuildingAccelerate:ctor(panelName)
	PanelProtocol.ctor(self, panelName)
end

function BuildingAccelerate:getBuildStatus()
	local modelInfo = TownModel:getBuildModel():getBuilding(self._buildingDataId);
	if nil == modelInfo then
		return BuildingInfo.Status.NONE
	end

	return modelInfo:getStatus()
end

function BuildingAccelerate:updateTimer(dt)
	if not TownModel:getBuildModel():isStatusRun(self._buildingDataId) then
		local status = self:getBuildStatus();
		self:stopTimer()
		TownModel:getBuildModel():setBuildingStatus(self._buildingDataId, BuildingInfo.Status.NONE, 0)
		self:closeSelf()
		if status == BuildingInfo.Status.CREATE then
			floatText("建筑创建已经完成")
		elseif status == BuildingInfo.Status.LEVELUP then
			floatText("建筑升级已经完成")
		end
		return
	end
	self:updateUI()
end

function BuildingAccelerate:startTimer()
	self:stopTimer()
	self._timerId = scheduler.scheduleUpdateGlobal(function(dt)
		self:updateTimer(dt)
	end)
end

function BuildingAccelerate:stopTimer()
	if self._timerId ~= nil then
		scheduler.unscheduleGlobal(self._timerId)
		self._timerId = nil
	end
end

function BuildingAccelerate:updateUI()
	if TownModel:getBuildModel():isStatusRun(self._buildingDataId) then
		local restTime = TownModel:getBuildModel():getStatusTimeRest(self._buildingDataId)
		self.uiNode:getNodeByName("process2"):setProgress(
				TownModel:getBuildModel():getProcessRate(self._buildingDataId))

		local function setRestTimeText(node, times)
			local h = math.floor(times/3600)
			local m = math.floor((times-h*3600)/60)
			local s = times-h*3600 - m*60
			local str = ""
			if h > 0 then
				str = str .. h .."h "
				if m > 0 then
					str = str .. m .. "m "
				end
			elseif m > 0 then
				str = str .. m .. "m "
			end
			str = str .. s .. "s"

			node:setText(str)
		end

		setRestTimeText(self.uiNode:getNodeByName("worktime2"), restTime)

		local decRestTime = restTime-self:getTotalDecTime()
		if decRestTime < 0 then
			decRestTime = 0
		end

		if decRestTime > 0 then
			setRestTimeText(self.uiNode:getNodeByName("fasttime2"), decRestTime)
		else
			self.uiNode:getNodeByName("fasttime2"):setText("")
			self.uiNode:getNodeByName("fasttime1"):setText("立即完成")
		end
	else
		self.uiNode:getNodeByName("worktime1"):setText("已经完成")
		self.uiNode:getNodeByName("fasttime1"):setText("立即完成")

		self.uiNode:getNodeByName("worktime2"):setText("")
		self.uiNode:getNodeByName("fasttime2"):setText("")
	end

	self.textItemNum:setText(tostring(self._itemCount))
	self.uiNode:getNodeByName("process1"):setProgress(self._itemCount*100/self:getItemMaxCount())

	self:showCanCreateItems()
end

function BuildingAccelerate:initUI(scene)
	self:initUINode(BuildingAccelerate.LUA_PATH)
	self._selectItem = nil;
	self._scene = scene
	self:setCloseBtn("btn_close", self._clickCloseFunc)
	self:setOutsideClose("spr_bg")

	self.btn_accelerate = self.uiNode:getNodeByName("btn_accelerate")
	self.btn_finish = self.uiNode:getNodeByName("btn_finish")
	self.btn_sub = self.uiNode:getNodeByName("btn_sub")
	self.btn_add = self.uiNode:getNodeByName("btn_add")
--	self.btn_slider = self.uiNode:getNodeByName("btn_slider")
	--! UIButton
	self.btn_item1 = self.uiNode:getNodeByName("btn_item1")
	self.btn_item2 = self.uiNode:getNodeByName("btn_item2")
	self.btn_item3 = self.uiNode:getNodeByName("btn_item3")
	self.btn_item4 = self.uiNode:getNodeByName("btn_item4")
	self.btn_item5 = self.uiNode:getNodeByName("btn_item5")
	self.btn_groups = self.uiNode:getGroupByTag(1)
	self.textItemNum = self.uiNode:getNodeByName("txt_selectnumber")
	self._itemCount = 1
	self._selectItem = nil

	self.btn_accelerate:addEventListener(Event.MOUSE_CLICK, {self, self._onAccelerate})
	self.btn_finish:addEventListener(Event.MOUSE_CLICK, {self, self._onFinish})
	self.btn_add:addEventListener(Event.MOUSE_CLICK, {self, self._onAddItemCount})
	self.btn_sub:addEventListener(Event.MOUSE_CLICK, {self, self._onSubItemCount})
end

function BuildingAccelerate:_onAccelerate(event)
	NotifyCenter:dispatchEvent(
		{
			name = Notify.BUILDING_ACCELERATE,
			dataId = self._buildingDataId,
			buildingId = self._buildingId,
			decTime = self:getTotalDecTime(),
		}
	)

	self._itemCount = 1;
	self:updateUI()
end

function BuildingAccelerate:_onFinish(event)
	if TownModel:getBuildModel():getBuildingStatus(self._buildingDataId) == BuildingInfo.Status.CREATE then
		floatText("建筑创建已完成")
	elseif TownModel:getBuildModel():getBuildingStatus(self._buildingDataId) == BuildingInfo.Status.LEVELUP then
		floatText("建筑升级已完成")
	end

	NotifyCenter:dispatchEvent(
		{
			name = Notify.BUILDING_FAST_FINISH,
			dataId = self._buildingDataId,
			buildingId = self._buildingId
		}
	)

	self:closeSelf()
end

function BuildingAccelerate:getTotalDecTime()
	return self._itemCount*self:getSelectItemTime()
end

function BuildingAccelerate:getSelectItemTime()
	if self._selectItem == nil then
		return 0
	end

	local conf = BuildingCfg:getAccelerate()
	if conf == nil then
		return 0
	end

	if self._selectItem == self.btn_item1 then
		return conf[1].last
	end
	if self._selectItem == self.btn_item2 then
		return conf[2].last
	end
	if self._selectItem == self.btn_item3 then
		return conf[3].last
	end
	if self._selectItem == self.btn_item4 then
		return conf[4].last
	end
	if self._selectItem == self.btn_item5 then
		return conf[5].last
	end
end

function BuildingAccelerate:getItemMaxCount()
	return 4;
end

function BuildingAccelerate:_onAddItemCount(event)
	if self:getTotalDecTime() >= TownModel:getBuildModel():getStatusTimeRest(self._buildingDataId) then
		floatText("加速时间已经达到上限")
		return
	end

	if self._itemCount >= self:getItemMaxCount() then
		floatText("可用的加速道具不足")
		return
	end

	self._itemCount = self._itemCount+1;

	self:updateUI()
end

function BuildingAccelerate:_onSubItemCount(event)
	self._itemCount = self._itemCount-1;
	if self._itemCount < 1 then
		self._itemCount = 1;
	end

	self:updateUI()
end

function BuildingAccelerate:_onItemSelect(event)
	self._selectItem = event.selectNode
	self._itemCount = 1;
	self:updateUI()
end

function BuildingAccelerate:showCanCreateItems()
	local conf = BuildingCfg:getAccelerate()
	if conf ~= nil then
		self.uiNode:getNodeByName("fast1"):setText(conf[1].cn_name)
		self.uiNode:getNodeByName("fast2"):setText(conf[2].cn_name)
		self.uiNode:getNodeByName("fast3"):setText(conf[3].cn_name)
		self.uiNode:getNodeByName("fast4"):setText(conf[4].cn_name)
		self.uiNode:getNodeByName("fast5"):setText(conf[5].cn_name)

		self.uiNode:getNodeByName("itemnumber1"):setText(self:getItemMaxCount())
		self.uiNode:getNodeByName("itemnumber2"):setText(self:getItemMaxCount())
		self.uiNode:getNodeByName("itemnumber3"):setText(self:getItemMaxCount())
		self.uiNode:getNodeByName("itemnumber4"):setText(self:getItemMaxCount())
		self.uiNode:getNodeByName("itemnumber5"):setText(self:getItemMaxCount())
	end
end

function BuildingAccelerate:_clickCloseFunc()
	ViewMgr:close(Panel.BUILDING_ACCELERATE)
end

function BuildingAccelerate:onOpened(params)
	if not self._loadedRes[BuildingAccelerate.UIResPath] then
		self:loadRes(BuildingAccelerate.UIResPath)
	end

	self:initUI(params.scene)
	self._buildingId = params.buildingId
	self._buildingDataId = params.dataId

	self:updateUI()
	self:startTimer()
	self.btn_groups:addEventListener(Event.STATE_CHANGE, {self,self._onItemSelect})
	self.btn_groups:setSelected(self.btn_item1)
end

function BuildingAccelerate:onCloseed(params)
	if self._loadedRes[BuildingAccelerate.UIResPath] then
		self:unloadRes(BuildingAccelerate.UIResPath)
	end

	self.btn_groups:removeEventListener(Event.STATE_CHANGE, {self,self._onItemSelect})
	self.btn_accelerate:removeEventListener(Event.MOUSE_CLICK, {self, self._onAccelerate})
	self.btn_finish:removeEventListener(Event.MOUSE_CLICK, {self, self._onFinish})
	self.btn_add:removeEventListener(Event.MOUSE_CLICK, {self, self._onAddItemCount})
	self.btn_sub:removeEventListener(Event.MOUSE_CLICK, {self, self._onSubItemCount})
	self:stopTimer()
end

function BuildingAccelerate:isSwallowEvent()
	return true
end

function BuildingAccelerate:isShowMark()
    return false
end

return BuildingAccelerate
