local WMCommonChildElemControllerBase = game_require('view.world.map.mapElem.WMCommonChildElemControllerBase')
local WMMarchElemNode = game_require('view.world.map.mapElem.march.WMMarchElemNode')
local WMMarchElemArrow = game_require('view.world.map.mapElem.march.WMMarchElemArrow')
local WMMarchController = class('WMMarchController', function() return display.newNode() end)

-- relationShip = 1	-- 自己
-- relationShip = 2	-- 盟友
-- relationShip = 3	-- 敌人
local demoAI = {
	{	srcPos={112,111},
		level=2,
		destPos={114,113},
		speed = 20,
		relationShip = 2,	-- 盟友
		name = "盟友城池1",
		color = 1,
	},
	{	srcPos={112,109},
		level=4,
		destPos={116,111},
		speed = 20,
		relationShip = 2,
		name = "盟友城池2",
		color = 1,
	},
	{	srcPos={114,109},
		level=5,
		destPos={112,114},
		speed = 20,
		relationShip = 2,
		name = "盟友城池3",
		color = 1,
	},
	{	srcPos={116,111},
		level=1,
		destPos={114,109},
		speed = 20,
		name = "敌对城池1",
		color = 3,
	},
	{	srcPos={116,109},
		level=3,
		destPos={114,109},
		speed = 20,
		name = "敌对城池2",
		color = 3,
	},
	{	srcPos={113,107},
		level=5,
		destPos={114,109},
		speed = 20,
		name = "敌对城池3",
		color = 3,
	},
	{	srcPos={114,113},
		level=2,
		destPos={119,111},
		speed = 20,
		name = "敌对城池4",
		color = 2,
	},
	{	srcPos={110,111},
		level=4,
		destPos={114,109},
		speed = 20,
		name = "敌对城池5",
		color = 3,
	},
	{	srcPos={112,114},
		level=1,
		destPos={110,111},
		speed = 20,
		name = "敌对城池6",
		color = 2,
	},
	{	srcPos={109,115},
		level=2,
		destPos={114,116},
		speed = 20,
		name = "敌对城池7",
		color = 2,
	},
	{	srcPos={114,116},
		level=3,
		speed = 20,
		name = "敌对城池8",
		color = 2,
	},
	{	srcPos={117,118},
		level=4,
		destPos={112,114},
		speed = 20,
		name = "敌对城池9",
		color = 2,
	},
	{	srcPos={118,115},
		level=5,
		destPos={118,117},
		speed = 20,
		name = "敌对城池10",
		color = 2,
	},
	{	srcPos={120,114},
		level=1,
		destPos={121,112},
		speed = 20,
		name = "敌对城池11",
		color = 2,
	},
	{	srcPos={119,111},
		level=2,
		destPos={117,107},
		speed = 20,
		name = "敌对城池12",
		color = 2,
	},
	{	srcPos={117,107},
		level=3,
		destPos={118,115},
		speed = 20,
		name = "敌对城池13",
		color = 2,
	},
	{	srcPos={110,103},
		level=4,
		destPos={108,106},
		speed = 20,
		name = "敌对城池14",
		color = 2,
	},
	{	srcPos={121,120},
		level=5,
		speed = 20,
		name = "敌对城池15",
		color = 2,
	},
	{	srcPos={123,118},
		level=1,
		destPos={121,120},
		speed = 20,
		name = "敌对城池16",
		color = 2,
	},
	{	srcPos={124,113},
		level=2,
		destPos={120,114},
		speed = 20,
		name = "敌对城池17",
		color = 2,
	},
	{	srcPos={121,107},
		level=3,
		destPos={119,109},
		speed = 20,
		name = "敌对城池18",
		color = 2,
	},
	{	srcPos={119,106},
		level=4,
		speed = 20,
		name = "敌对城池19",
		color = 2,
	},
	{	srcPos={115,102},
		level=5,
		destPos={113,107},
		speed = 20,
		name = "敌对城池20",
		color = 2,
	},
	{	srcPos={113,103},
		level=1,
		destPos={108,106},
		speed = 20,
		name = "敌对城池21",
		color = 2,
	},
	{	srcPos={119,100},
		level=2,
		destPos={116,105},
		speed = 20,
		name = "敌对城池22",
		color = 2,
	},
	{	srcPos={108,99},
		level=3,
		destPos={110,103},
		speed = 20,
		name = "敌对城池23",
		color = 2,
	},
	{	srcPos={108,99},
		level=4,
		destPos={108,106},
		speed = 20,
		name = "敌对城池23",
		color = 2,
	},
	{	srcPos={103,103},
		level=5,
		speed = 20,
		name = "敌对城池24",
		color = 2,
	},
	{	srcPos={106,108},
		level=1,
		destPos={107,110},
		speed = 20,
		name = "敌对城池25",
		color = 2,
	},
	{	srcPos={113,103},
		level=2,
		destPos={108,106},
		speed = 20,
		name = "敌对城池26",
		color = 2,
	},
	{	srcPos={109,109},
		level=3,
		destPos={108,106},
		speed = 20,
		name = "敌对城池27",
		color = 2,
	},
	{	srcPos={106,112},
		level=4,
		speed = 20,
		name = "敌对城池28",
		color = 2,
	},
	{	srcPos={102,108},
		level=5,
		speed = 20,
		name = "敌对城池29",
		color = 2,
	},
	{	srcPos={106,115},
		level=1,
		destPos={106,112},
		speed = 20,
		name = "敌对城池30",
		color = 2,
	},
	{	srcPos={108,119},
		level=2,
		destPos={110,117},
		speed = 20,
		name = "敌对城池31",
		color = 2,
	},
	{	srcPos={114,121},
		level=3,
		speed = 20,
		name = "敌对城池32",
		color = 2,
	},
	{	srcPos={119,123},
		level=4,
		destPos={117,118},
		speed = 20,
		name = "敌对城池33",
		color = 2,
	},
	{	srcPos={126,123},
		level=5,
		destPos={121,120},
		speed = 20,
		name = "敌对城池34",
		color = 2,
	},
	{	srcPos={127,117},
		level=1,
		speed = 20,
		name = "敌对城池35",
		color = 2,
	},
	{	srcPos={126,109},
		level=2,
		destPos={121,107},
		speed = 20,
		name = "敌对城池36",
		color = 2,
	},
	{	srcPos={122,103},
		level=3,
		speed = 20,
		name = "敌对城池37",
		color = 2,
	},
}

-- 1050909 冷冻直升机
-- 1060203 恐怖机器人
-- 1080808 未来坦克
local demoMonsterAI = {
	{
		monsterID = 1060203,
		level = 1,
		srcPos={119,117},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={120,116},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={118,117},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={116,114},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={112,116},
	},
	{
		monsterID = 1060203,
		level = 1,
		srcPos={116,113},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={117,113},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={121,112},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={119,109},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={110,117},
	},
	{
		monsterID = 1060203,
		level = 1,
		srcPos={118,109},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={108,113},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={115,107},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={108,110},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={116,105},
	},
	{
		monsterID = 1060203,
		level = 1,
		srcPos={111,107},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={114,105},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={103,105},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={113,105},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={107,110},
	},
	{
		monsterID = 1060203,
		level = 1,
		srcPos={108,117},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={110,118},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={112,118},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={111,121},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={116,120},
	},
	{
		monsterID = 1060203,
		level = 1,
		srcPos={117,121},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={119,120},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={122,123},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={124,122},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={125,121},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={128,122},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={128,120},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={126,120},
	},
	{
		monsterID = 1060203,
		level = 1,
		srcPos={125,117},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={122,115},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={123,111},
	},
	{
		monsterID = 1060203,
		level = 1,
		srcPos={124,111},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={126,112},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={129,114},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={123,106},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={125,106},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={125,105},
	},
	{
		monsterID = 1060203,
		level = 1,
		srcPos={120,104},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={117,102},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={120,102},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={116,100},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={115,99},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={111,98},
	},
	{
		monsterID = 1060203,
		level = 1,
		srcPos={112,98},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={110,100},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={107,101},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={106,103},
	},
	{
		monsterID = 1060203,
		level = 4,
		srcPos={104,101},
	},
	{
		monsterID = 1060203,
		level = 1,
		srcPos={104,106},
	},
	{
		monsterID = 1060203,
		level = 3,
		srcPos={104,110},
	},
	{
		monsterID = 1060203,
		level = 2,
		srcPos={104,111},
	},
	{
		monsterID = 1060203,
		level = 5,
		srcPos={103,110},
	},
	{
		monsterID = 9999996,
		level = 30,
		srcPos={108,106},
	}
}

function GetDemoMonster()
	local towns = {}
	for k,v in ipairs(demoMonsterAI) do
		local tt = {
			monsterID = 1030505,
			max_populace = 2000,
			is_boss = 0,
			lev = 11,
			now_populace        = 2000,
			power               = 55,
			worldPos = {
				x = 116,
				y = 112
			}
		}

		tt.monsterID = v.monsterID
		tt.worldPos.x = v.srcPos[1]
		tt.worldPos.y = v.srcPos[2]
		if v.level ~= nil then
			tt.lev = v.level
		end
		table.insert(towns, tt)
	end

	return towns;
end

function GetDemoTown()
	local repeats = {}
	repeats["114"..",111"] = true
	local towns = {}
	table.insert(towns, {
		  max_blood           = 2000,
		  mine_list = {
			  {
				  num         = 733,
				  resources_id = 1
			  },
			  {
				  num          = 600,
				  resources_id = 2
			  },
			  {
				  num          = 666,
				  resources_id = 3
			  }
		  },
		  now_blood            = 2000,
		  now_populace        = 2,
		  power               = 55,
		  protect_time        = 0,
		  worldPlayerInfo = {
			  name         = "SLG-源计划",
			  relationShip = 1,
			  roleId      = 4.3989484543543e+014,
			  role_level   = 5,
			  union_name   = "",
		  },
		  worldPos = {
			  x = 114,
			  y = 111
		  }
	  })

	for k,v in ipairs(demoAI) do
		local tt = {
		  max_blood	= 2000,
		  mine_list = {
			  {
				  num          = 0,
				  resources_id = 3
			  },
			  {
				  num         = 0,
				  resources_id = 2
			  },
			  {
				  num         = 0,
				  resources_id = 1
			  },
		  },
		  now_blood            = 2000,
		  now_populace         = 2,
		  power               = 55,
		  protect_time         = 1458358516,
		  worldPlayerInfo = {
			  name         = "SLG-源计划",
			  relationShip = 3,
			  roleId       = 4.3989484543541e+014,
			  role_level   = 1,
			  union_name   = "",
		  },
			worldPos = {
			  x = 116,
			  y = 107
			},
		}

		if repeats[v.srcPos[1]..","..v.srcPos[2]] == nil then
			tt.worldPos.x = v.srcPos[1]
			tt.worldPos.y = v.srcPos[2]
			tt.worldPlayerInfo.name = v.name
			tt.worldPlayerInfo.role_level = v.level
			if v.relationShip ~= nil then
				tt.worldPlayerInfo.relationShip = v.relationShip
			end
			table.insert(towns, tt)
		end
	end

	return towns
end

function WMMarchController:ctor(map)
	self._map = map
	--! WMMarchElemNode
	self._marchs = {}
	--! WMMarchElemArrow
	self._arrows = {}
	self._bulletNode = display.newNode()
	self._bulletNode:retain()
	self._marchNode = display.newNode()
	self._marchNode:retain()
	self._lastAddMarchTime = os.time()
--	self._allAddMarchs = {}

	NotifyCenter:addEventListener(Notify.ADD_MARCH, {self,self.addMarch})
	NotifyCenter:addEventListener(Notify.DEL_MARCH, {self,self.removeMarch})
end

function WMMarchController:start()
	self._timerId = scheduler.scheduleUpdateGlobal(function(dt)
		self:update(dt)
	end)
end

function WMMarchController:updateDemoAI(dt)
	if os.time() == self._lastAddMarchTime then
		return
	end

	for k,v in pairs(demoAI) do
		if v.destPos ~= nil then
			local srcBlockPos = ccp(v.srcPos[1],v.srcPos[2])
			local destBlockPos = ccp(v.destPos[1],v.destPos[2])
			if self._marchs[self:genMarchKey(srcBlockPos, destBlockPos)] == nil then
				if v.attackTime == nil then
					v.attackTime = os.time()
					v.attackFlag = false
				else
					if v.attackFlag == true then
						v.attackTime = os.time()
						v.attackFlag = false
					elseif os.time() - v.attackTime > 3 then
						v.attackTime = os.time()
						v.attackFlag = true
						self:attack(srcBlockPos, destBlockPos, v.color)
						break;
					end
				end
			end
		end
	end
end

function WMMarchController:getBulletNode()
	return self._bulletNode
end

function WMMarchController:getMarchNode()
	return self._marchNode
end

function WMMarchController:hasMarchSelected()
	for k,v in pairs(self._marchs) do
		--! WMMarchElemNode
		local march = v
		if march:hasSelected() then
			return true;
		end
	end

	return false
end

function WMMarchController:unSelectMarch()
	for k,v in pairs(self._marchs) do
		--! WMMarchElemNode
		local march = v
		if march:hasSelected() then
			march:unSelect()
		end
	end
end

function WMMarchController:selectMarch(name)
	local march = self._marchs[name]
	local count = 0
	for _,v in pairs(self._marchs) do
		count = count+1
		v:setZOrder(count)
	end
	if nil ~= march then
		march:selectAt()
		march:setZOrder(count+1)
	end
end

function WMMarchController:genMarchKey(srcBlockPos, destBlockPos)
	return destBlockPos.x..","..destBlockPos.y..","..srcBlockPos.x..","..srcBlockPos.y
end

function WMMarchController:attack(srcBlockPos, destBlockPos, color)
	self._lastAddMarchTime = os.time()
	if self._marchNode:getParent() == nil then
		self._map:getblockOriginNode():addChild(self._marchNode, 5)
		self._map:getblockOriginNode():addChild(self._bulletNode, 5)
	end
	local keyStr = self:genMarchKey(srcBlockPos, destBlockPos)
	local march = self._marchs[keyStr];
	if march == nil then
		self._arrows[keyStr] = WMMarchElemArrow.new(self._map, self)
		self._arrows[keyStr]:createArrows(srcBlockPos, destBlockPos, color)
		self._marchs[keyStr] = WMMarchElemNode.new(self._map, self)
		self._marchs[keyStr]:createArrows(srcBlockPos, destBlockPos)
	end
end

function WMMarchController:getMarchHasSelected()
	for k,v in pairs(self._marchs) do
		--! WMMarchElemNode
		local march = v
		if march:isSelected() then
			return k;
		end
	end

	return nil
end

function WMMarchController:getMarchInBlockPos(blockPos)
	for k,v in pairs(self._marchs) do
		--! WMMarchElemNode
		local march = v
		if march:isInBlockPos(blockPos) then
			return k;
		end
	end

	return nil
end

function WMMarchController:addMarch(event)
	self:attack(event.srcBlockPos, event.destBlockPos, 1)
end

function WMMarchController:removeMarch(event)
	local srcBlockPos = event.srcBlockPos
	local destBlockPos = event.destBlockPos
	local keyStr = destBlockPos.x..","..destBlockPos.y..","..srcBlockPos.x..","..srcBlockPos.y
	local march = self._marchs[keyStr];
	if march ~= nil then
		march:dispose()
		self._marchs[keyStr] = nil
	end
	local arrow = self._arrows[keyStr];
	if arrow ~= nil then
		arrow:dispose()
		self._arrows[keyStr] = nil
	end
end

--function WMMarchController:addMarchTimer()
--	for k,v in pairs(self._allAddMarchs) do
--		self:attack(v.srcBlockPos, v.destBlockPos, v.color)
--		break;
--	end
--end

function WMMarchController:update(dt)
	local keys = {}
	for k,march in pairs(self._marchs) do
		march:update(dt)
		table.insert(keys, k)
	end
	for k,arrow in pairs(self._arrows) do
		arrow:update(dt)
	end
	for k,v in ipairs(keys) do
		local march = self._marchs[v]
		if march:isFinish() then
			march:dispose()
			self._marchs[v] = nil
			local arrow = self._arrows[v]
			arrow:dispose()
			self._arrows[v] = nil
		end
	end

	for k,v in pairs(self._marchs) do
		--! WMMarchElemNode
		local march = v
		march:setUnselect()
	end

	self:updateDemoAI()
	--self:addMarchTimer()
end

function WMMarchController:dispose()
	scheduler.unscheduleGlobal(self._timerId)

	for k,v in pairs(self._marchs) do
		v:dispose()
	end
	for k,v in pairs(self._arrows) do
		v:dispose()
	end
	self._bulletNode:release()
	self._marchNode:release()
	NotifyCenter:removeEventListener(Notify.ADD_MARCH, {self,self.addMarch})
	NotifyCenter:removeEventListener(Notify.DEL_MARCH, {self,self.removeMarch})
	self:removeFromParent()
end

return WMMarchController
