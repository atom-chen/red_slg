--
-- Author: wdx
-- Date: 2014-08-25 11:04:17
--
--系统 开放 系统控制

local SysModel = {}


function SysModel:init()
	self.cfg = ConfigMgr:requestConfig("system_open",nil,true)
	-- NotifyCenter:addEventListener(Notify.ROLE_UPDATE, {self,self._onRoleUpdate},10)
	-- NotifyCenter:addEventListener(Notify.DUNGEON_INIT, {self,self._dungeonInit}, 10)
	-- NotifyCenter:addEventListener(Notify.DUNGEON_PROGRESS, {self,self._dungeonPass}, 10)
	self._sysList = {}
	self._isDungeonInit = false
	self._isRoleInit = false
end

--玩家等级变化
function SysModel:_onRoleUpdate(event)
	local changeList = event.list
	--判断关注的属性是否变动
	if event.isInit then  --初始化的时候
		self._isRoleInit = true
		self:_checkAllSys()
	elseif changeList[RoleConst.LEVEL] then
		for sys,info in pairs(self.cfg) do
			if not self._sysList[sys] and self:isSysOpen(sys) then --系统开放了
				self._sysList[sys] = true
				NotifyCenter:dispatchEvent({name=Notify.SYS_OPEN,sys=sys})   --通知xx系统开放了
			end
		end
	end
end

--副本初始化
function SysModel:_dungeonInit(event)
	self._isDungeonInit = true
	NotifyCenter:removeEventListener(Notify.DUNGEON_INIT, {self,self._dungeonInit})
	self:_checkAllSys()
end

function SysModel:_dungeonPass(event)
	if self._isDungeonInit and self._isDungeonInit then
		for sys,info in pairs(self.cfg) do
			if not self._sysList[sys] and self:isSysOpen(sys) then --系统开放了
				self._sysList[sys] = true
				NotifyCenter:dispatchEvent({name=Notify.SYS_OPEN,sys=sys})   --通知xx系统开放了
			end
		end
	end
end


function SysModel:_checkAllSys()
	if self._isRoleInit and self._isDungeonInit then
		for sys,info in pairs(self.cfg) do
			local isOpen = self:isSysOpen(sys)
			if isOpen then  --系统开放了
				self._sysList[sys] = true
				NotifyCenter:dispatchEvent({name=Notify.SYS_OPEN,sys=sys, isInit = true})   --通知xx系统开放了
			end
		end
	end
end

--sys :系统产量   定义在common/SysConst 里面
function SysModel:isSysOpen(sys)
	if not sys then
		return true
	end
	-- do  return true end
	if nil == RoleModel.roleInfo then
		return false
	end
	local info = self.cfg[sys]
	if not info then
		return true
	end
	if info.isClose then
		return false
	elseif info.level and info.level > RoleModel.roleInfo.lev then
		return false
	-- elseif info.dungeon and not DungeonModel:isDungeonFinish( self:getDungeon(info.dungeon) ) then
	-- 	return false
	end
	return true
end

function SysModel:getDungeon(dungeonId)
	local dungeonType = DungeonModel:getNormalDungeonType()
	local startId = DungeonCfg:getDungeonStartId(dungeonType)
	if dungeonId < startId then
		dungeonId = startId + dungeonId
	end
	return dungeonId
end

--获取系统未开放时候的提示文本
function SysModel:getSysOpenTip(sys)
	local info = self.cfg[sys]
	if info.isClose then
		return "敬请期待"
	elseif info.level and info.level > RoleModel.roleInfo.lev then
		return "指挥官"..info.level.."级开启"..info.name
	elseif info.dungeon then
		local dId = self:getDungeon(info.dungeon)
		local dInfo = DungeonCfg:getDungeon(dId)
		local cId = math.floor(info.dungeon/100)
		local desc = string.format("通关战役<font color=rgb(250,250,10)>%s(%d-%d)</font>开启%s",dInfo.name,cId,info.dungeon%100,info.name)
		return desc
	end
	return ""
end

function SysModel:getSysOpenCfg()
	return self.cfg
end

function SysModel:getSysOpenById(id)
	return self.cfg[id]
end

return SysModel