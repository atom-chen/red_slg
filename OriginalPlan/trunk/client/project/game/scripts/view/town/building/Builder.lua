--
-- Author: lyc
-- Date: 2016-05-24 15:19:00
--

local BuildNodeCommon = game_require('view.town.building.BuildNodeCommon')
local BuildingGroup = game_require('view.town.building.BuildingGroup')

local BUILDER_UI_FORMAT = 'town_building_node_%s'
local BUILDING_NODE_PARAM_TABLE = {
	['jianzhu_zhujidi'] = {
		buildingId = 1,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_zhujidi',
		disableDelete = true,
	},
	['jianzhu_cangku'] = {
		buildingId = 2,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_cangku',
	},
	['jianzhu_dashiguang'] = {
		buildingId = 3,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_dashiguang',
	},
	['jianzhu_yingxiongjitan'] = {
		buildingId = 4,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_yingxiongjitan',
	},
	['jianzhu_keyanzhongxin'] = {
		buildingId = 5,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_keyanzhongxin',
	},
	['jianzhu_leida'] = {
		buildingId = 6,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_leida',
	},
	['jianzhu_jiangli'] = {
		buildingId = 7,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_jiangli',
	},
	['jianzhu_zhuangbeizhizao'] = {
		buildingId = 8,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_zhuangbeizhizao',
	},
	['jianzhu_yiyuan'] = {
		buildingId = 9,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_yiyuan',
	},
	['jianzhu_shichang'] = {
		buildingId = 10,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_shichang',
	},
	['jianzhu_bubingying'] = {
		buildingId = 11,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_bubingying',
	},
	['jianzhu_zhanchegongchang'] = {
		buildingId = 12,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_zhanchegongchang',
	},
	['jianzhu_jichang'] = {
		buildingId = 13,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'jianzhu_jichang',
	},
	['ta_bingdong'] = {
		buildingId = 14,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'ta_bingdong',
	},
	['ta_fangkong'] = {
		buildingId = 15,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'ta_fangkong',
	},
	['ta_fashi'] = {
		buildingId = 16,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'ta_fashi',
	},
	['ta_gongjian'] = {
		buildingId = 17,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'ta_gongjian',
	},
	['ta_leidian'] = {
		buildingId = 18,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'ta_leidian',
	},
	['ta_toushiche'] = {
		buildingId = 19,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'ta_toushiche',
	},
	['ziyuan_nongchang'] = {
		buildingId = 20,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'ziyuan_nongchang',
	},
	['ziyuan_nongchanga'] = {
		buildingId = 21,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'ziyuan_nongchanga',
	},
	['ziyuan_nongchangb'] = {
		buildingId = 22,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'ziyuan_nongchangb',
	},
	['ziyuan_nongchangc'] = {
		buildingId = 23,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Base',
		name = 'ziyuan_nongchangc',
	},
	['cq'] = {
		buildingId = 24,
		zorder = 1,
		clickFunc = function(buildingNode)
			NotifyCenter:dispatchEvent({name=Notify.BUILDINGGROUP_CLICK, groupId=buildingNode:getGroupId()})
		end,
		buildType = 'Create',
		name = 'cq',
		disable = false,
		disableDelete = true,
	},
	['chengqianga'] = {
		buildingId = 25,
		zorder = 1,
		clickFunc = function(buildingNode)
			NotifyCenter:dispatchEvent({name=Notify.BUILDINGGROUP_CLICK, groupId=buildingNode:getGroupId()})
		end,
		buildType = 'Base',
		name = 'chengqiang',
		disableDelete = true,
	},
	['chengqiangb'] = {
		buildingId = 26,
		zorder = 1,
		clickFunc = function(buildingNode)
			NotifyCenter:dispatchEvent({name=Notify.BUILDINGGROUP_CLICK, groupId=buildingNode:getGroupId()})
		end,
		buildType = 'Base',
		name = 'chengqiang',
		disableDelete = true,
	},
	['chengqiangc'] = {
		buildingId = 27,
		zorder = 1,
		clickFunc = function(buildingNode)
			NotifyCenter:dispatchEvent({name=Notify.BUILDINGGROUP_CLICK, groupId=buildingNode:getGroupId()})
		end,
		buildType = 'Base',
		name = 'chengqiang',
		disableDelete = true,
	},
	['building_create'] = {
		buildingId = 100,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		buildType = 'Create',
		name = 'building_create',
	},
	['arm'] = {
		buildingId = 101,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		disable = false,
		buildType = 'Arm',
		name = 'arm',
	},
	['hero'] = {
		buildingId = 102,
		zorder = 1,
		clickFunc = function(buildingNode)
			buildingNode:showMenu()
		end,
		disable = false,
		buildType = 'Arm',
		name = 'army',
	},
}

local BuildingNode = game_require('view.town.building.BuildingNode')
local BuildingInfo = game_require('model.town.BuildingInfo')
local Builder = {}

-------------------------------------------------------
-- @class
-- @name
-- @description
-- @return BuildingNode:
-- @usage
function Builder.createNode(buildName, buildSpriteName, pos,
	size, buildingNodePos, townPanel, buildModel)
	local buildNode = BUILDING_NODE_PARAM_TABLE[buildName]
	if buildNode ~= nil then

		local buildInfo = BuildingInfo.new()
		buildInfo.buildingId = buildNode.buildingId	-- 建筑配置ID
		buildInfo.level = 1
		buildInfo.x = buildingNodePos.x
		buildInfo.y = buildingNodePos.y
		buildInfo.groupId = 0
		if not (groupName == nil or groupName == "") then
			buildInfo.groupId = tonumber(groupName)
		end

		--设置参数
		local cls = buildNode.cls or BuildingNode
		--! BuildingNode
		local buildingNode = cls.new(townPanel, townPanel:getNodeCount(),
			townPanel:getMapScene():getPriority())
		buildingNode:setLuaInfo(buildSpriteName, buildName, buildName,
			buildNode.buildType, buildNode.name, size, buildNode, pos)
		if buildNode.clickFunc then
			buildingNode:setClickFunc(buildNode.clickFunc)
		end
		buildingNode:setNodePos(buildingNodePos)
		buildingNode:setBuildId(buildNode.buildingId)
		if buildNode.disable then
			buildingNode:setEnable(false)
		end
		local nodeSize= buildingNode:getNodeSize()

		local id = buildModel:addBuilding(buildInfo)
		buildingNode:setDataId(id);
		buildingNode:setGroupId(buildInfo.groupId)
		buildingNode:setPosition(ccp(buildingNodePos.x, buildingNodePos.y))
		buildingNode:setAnchorPoint(cc.p(0.5,0.5))
		return buildingNode;
	end
end

function Builder.getBuildNodeInfo(id)
	for k,v in pairs(BUILDING_NODE_PARAM_TABLE) do
		if v.buildingId == id then
			return v;
		end
	end

	return nil
end

-------------------------------------------------------
-- @class
-- @name
-- @description
-- @param TownPanel:townPanel
-- @param UINode:townMapLayout
-- @return nil:
-- @usage
function Builder.buildNode( townPanel, townMapLayout )
	local buildModel = TownModel:getBuildModel()
	local basePosList = {};
	local createPosList = {}
	for k = 1, #townMapLayout._uiList do
 	--for k = #townMapLayout._uiList, 1, -1 do
		local v = townMapLayout._uiList[k]
		local ccName = v.__cName
		local buildName, pos, groupName = string.match(ccName, "^([a-zA-Z_]+)_([0-9]+)_*([0-9]*)$")
		pos = tonumber(pos)	-- 在地图上的位置(所有建筑必须唯一)

		if buildName ~= nil then
			print(buildName)
			local buildNode = BUILDING_NODE_PARAM_TABLE[buildName]
			if buildNode ~= nil then
				if buildNode.buildType == 'Base' then
					if basePosList[pos] == true then
						print(pos)
						assert(false)
					end
					if not basePosList[pos] then
						basePosList[pos] = true
					end
				elseif buildNode.buildType == 'Create' then
					if createPosList[pos] == true then
						print(pos)
						assert(false)
					end
					if not createPosList[pos] then
						createPosList[pos] = true
					end
				end
			end

			-- 计算位置
			local sprite = nil
			local conf = BuildingCfg:getBuildingInfo(buildNode.buildingId)
			if conf == nil then
				sprite = v:getImageUrl()
			else
				sprite = "#"..conf.icon..".png"
			end
			local buildingNodePos = BuildNodeCommon.getCenterPosOfNode(townMapLayout, ccName)
			local buildingNode = Builder.createNode(buildName, sprite, pos,
				v:getSize(), buildingNodePos, townPanel, buildModel)
			townPanel:addBuildingNode(buildingNode)
			buildingNode:updateUI();
		end
 	end
end

return Builder