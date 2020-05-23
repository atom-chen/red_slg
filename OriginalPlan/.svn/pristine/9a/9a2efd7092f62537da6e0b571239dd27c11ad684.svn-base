--
-- Author: lyc
-- Date: 2016-05-24 14:47:00
--

local TownNodeBase = game_require('view.town.TownNodeBase')
local BuildingInfo = game_require('model.town.BuildingInfo')
local BuildingNode = class('BuildingNode', TownNodeBase)

BuildingNode.UIResPath = "ui/building/building_select.pvr.ccz"
BuildingNode.LUA_PATH = "building_title"
BuildingNode.STATUS_LUA_PATH = "building_status"

function BuildingNode:ctor( town , enterNum, priority)
	TownNodeBase.ctor(self, town , enterNum)
	EventProtocol.extend(self)

	self._clickFunc = nil			-- 点击函数
	self._nodeBg = nil				-- 背景图片
	self._groupId = 0				-- 组ID
	self._dataId = 0				-- 数据ID
	self._buildingId = 0			-- 建筑配置ID
	self._priority = priority-1;	-- 优先级
	self._enable = true				-- 是否可点击
end

function BuildingNode:setDataId(id)
	self._dataId = id
end
function BuildingNode:getDataId()
	return self._dataId
end
function BuildingNode:setBuildId(id)
	self._buildingId = id
end

function BuildingNode:getBuildId()
	return self._buildingId
end

function BuildingNode:isGroup()
	return false
end

function BuildingNode:setGroupId(id)
	self._groupId = id;
end

function BuildingNode:getGroupId()
	return self._groupId;
end

function BuildingNode:getNode()
	return self._node
end

function BuildingNode:canDelete()
	return not self._buildInfo.disableDelete
end

function BuildingNode:setEnable(flag)
	self._enable = flag
end
function BuildingNode:getEnable()
	return self._enable
end

function BuildingNode:getPriority()
	return self._priority
end

function BuildingNode:isBaseBuilding()
	return self._buildType == "Base"
end

function BuildingNode:getBuildType()
	return self._buildType
end

function BuildingNode:getPos()
	return self._pos
end

function BuildingNode:getNodeSize()
	return self:getContentSize()
end

function BuildingNode:setNodePos(pos)
	self._nodePos = pos
end

function BuildingNode:getNodePos()
	return self._nodePos
end

function BuildingNode:getCreateNodePos()
	return ccp(self._nodePos.x, self._nodePos.y)
end

function BuildingNode:getBuildName()
	return self._buildName
end
function BuildingNode:getBuildNameExt()
	return self._buildName.."_"..self._pos
end

function BuildingNode:levelUp()
	if TownModel:getBuildModel():getBuildingLevel(self._dataId) >= BuildingCfg:getMaxBuildLevel() then
		floatText("建筑等级已达上限")
		return
	end

	TownModel:getBuildModel():levelUp(self._dataId);
	local levelUpConf = BuildingCfg:getLevelUp()
	TownModel:getBuildModel():setBuildingStatus(
		self._dataId, BuildingInfo.Status.LEVELUP,
		levelUpConf[TownModel:getBuildModel():getBuildingLevel(self._dataId)].need_time)
	self:updateUI()
	self:startTimer()

	NotifyCenter:dispatchEvent({name = Notify.BUILDING_UNSELECT})
end

function BuildingNode:clickMenu(event)

end

function BuildingNode:clickMenuMask()

end

function BuildingNode:showMenu()

end

function BuildingNode:selected()
	if self._titleNode then
		self._titleNode:getNodeByName("txt_lv"):setColor(ccc3(64,204,255))
		self._titleNode:getNodeByName("txt_name"):setColor(ccc3(64,204,255))
	end
end

function BuildingNode:unSelected()
	if self._titleNode then
		self._titleNode:getNodeByName("txt_lv"):setColor(ccc3(255,255,255))
		self._titleNode:getNodeByName("txt_name"):setColor(ccc3(255,255,255))
	end
end

function BuildingNode:updateTimer(dt)
	if not TownModel:getBuildModel():isStatusRun(self._dataId) then
		self:stopTimer()
		TownModel:getBuildModel():setBuildingStatus(self._dataId, BuildingInfo.Status.NONE, 0)
	end
	self:updateUI()
end

function BuildingNode:startTimer()
	self:stopTimer()
	self._timerId = scheduler.scheduleUpdateGlobal(function(dt)
		self:updateTimer(dt)
	end)
end

function BuildingNode:stopTimer()
	if self._timerId ~= nil then
		scheduler.unscheduleGlobal(self._timerId)
		self._timerId = nil
	end
end

function BuildingNode:updateUI()
	if self._buildType == "Base" then
		local nodeSize = self._nodeBg:getContentSize()
		if self._titleNode == nil then
			self._titleNode = UINode.new()
			self._titleNode:setUI(BuildingNode.LUA_PATH)
			self._titleNode:setAnchorPoint(ccp(0.5,0.5))

			self._titleNode:getNodeByName("txt_name"):setText(
				BuildingCfg:getBuildingInfo(self._buildInfo.buildingId).cn_name)

			local pos = ccp(nodeSize.width/2,nodeSize.height+20)
			local wpos = self:convertToWorldSpace(pos)
			self._titleNode:setPosition(self._town:getMapScene():convertToNodeSpace(wpos))
			self._town:getMapScene():addChild(self._titleNode, 100)
		end

		if self._statusUINode == nil then
			self._statusUINode = UINode.new()
			self._statusUINode:setUI(BuildingNode.STATUS_LUA_PATH)
			self._statusUINode:setAnchorPoint(ccp(0.5,0.5))
			self._statusUINode:setScale(1.5)
			local pos = ccp(nodeSize.width/2, 0)
			local wpos = self:convertToWorldSpace(pos)
			self._statusUINode:setPosition(self._town:getMapScene():convertToNodeSpace(wpos))
			self._town:getMapScene():addChild(self._statusUINode, 100)
		end
	end

	if self._titleNode then
		local lv = TownModel:getBuildModel():getBuildingLevel(self._dataId);
		if self:getBuildStatus() == BuildingInfo.Status.LEVELUP then
			lv = lv-1
		end
		local txt = "Lv."..lv;
		if lv >= 10 then
			txt = txt.." "
		end
		self._titleNode:getNodeByName("txt_lv"):setText(txt)
	end

	if self._statusUINode then
		if TownModel:getBuildModel():isStatusRun(self._dataId) then
			local status = self:getBuildStatus()
			self._statusUINode:setVisible(true)
			local restTime = TownModel:getBuildModel():getStatusTimeRest(self._dataId)
			if status == BuildingInfo.Status.CREATE then
				self._statusUINode:getNodeByName("process"):setProgress(
					TownModel:getBuildModel():getProcessRate(self._dataId))
				self._statusUINode:getNodeByName("txt_status"):setText("创建")
				local h = math.floor(restTime/3600)
				local m = math.floor((restTime-h*3600)/60)
				local s = restTime-h*3600 - m*60
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
				self._statusUINode:getNodeByName("txt_time"):setText(str)
			elseif status == BuildingInfo.Status.LEVELUP then
				self._statusUINode:getNodeByName("process"):setProgress(
					TownModel:getBuildModel():getProcessRate(self._dataId))
				self._statusUINode:getNodeByName("txt_status"):setText("升级")
				local h = math.floor(restTime/3600)
				local m = math.floor((restTime-h*3600)/60)
				local s = restTime-h*3600 - m*60

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
				self._statusUINode:getNodeByName("txt_time"):setText(str)
			else
				self._statusUINode:setVisible(false)
			end
		else
			self._statusUINode:setVisible(false)
		end
	end
end

function BuildingNode:getBuildStatus()
	local modelInfo = TownModel:getBuildModel():getBuilding(self._dataId);
	if nil == modelInfo then
		return BuildingInfo.Status.NONE
	end

	return modelInfo:getStatus()
end

function BuildingNode:isStatusRun()
	return TownModel:getBuildModel():isStatusRun(self._dataId)
end

function BuildingNode:setLuaInfo(luaPath, bgName, touchName,
	buildType, buildName, size, info, pos)

	ResMgr:loadPvr(BuildingNode.UIResPath)

	if buildType == "Base" then
		self._priority = self._priority-1
		self._town:setCreateNodeVisible(pos, false)
	end
	if size == nil then
		self._node = UIImage.new(luaPath)
	else
		self._node = UIImage.new(luaPath, size)
	end
	self:addChild(self._node)
	self._nodeBg = self._node
	self._nodeBg:setAnchorPoint(ccp(0.5,0.5))
	local nodeSize = self._nodeBg:getContentSize()
	self:setContentSize(nodeSize)
	self._nodeBg:setPosition(ccp(nodeSize.width/2,nodeSize.height/2))
	self._buildType = buildType;
	self._buildName = buildName;
	self._buildInfo = info
	self._pos = pos	-- 建筑在地图上的空地位置
end

function BuildingNode:contain(x, y)
	if self._nodeBg and self._nodeBg:touchContains(x, y) then
		return true
	end

	return false
end

function BuildingNode:onMouseClick()
	self:_onClick()
end

---------点击事件处理------------------------------------
function BuildingNode:setClickFunc( func )
	self._clickFunc = func
end

function BuildingNode:_onClick()
	self:_clickFunc()
	local buildType = nil
	if self:isStatusRun() then
		buildType = "Status"
	else
		buildType = self._buildType
	end
	NotifyCenter:dispatchEvent({name = Notify.BUILDING_SELECT,
		buildType=buildType, buildingObj=self, buildName = self._buildName.."_"..self._pos})
end

---------ui资源加载与卸载---------
function BuildingNode:startLoading()

end

function BuildingNode:startUnloading()

end

function BuildingNode:dispose()
	ResMgr:unload(BuildingNode.UIResPath)
	if self._titleNode then
		self._town:getMapScene():removeChild(self._titleNode)
		self._titleNode:dispose()
	end
	if self._statusUINode then
		self._town:getMapScene():removeChild(self._statusUINode)
		self._statusUINode:dispose()
	end
	self._node:dispose()
	self:stopTimer()
end

return BuildingNode
