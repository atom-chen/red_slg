local RoleModel = {}

RoleModel.MODEL_NAME = 'role_model'

function RoleModel:init()
	self:setRoleInfo({
		[RoleConst.ID] = 12345,
		[RoleConst.NAME] = "SLG-源计划",
		[RoleConst.LEVEL] = 99,
		[RoleConst.GOLD] = 5000,
		[RoleConst.EXP] = 3000,
		[RoleConst.COIN] = 5000,
		[RoleConst.VIPLEV] = 12,
		[RoleConst.CHARGEGOLD] = 3999,
		[RoleConst.VIGOUR] = 5000,
	})
end

function RoleModel:setRoleInfo( info )
	self.roleInfo = {}
	table.encrypt(self.roleInfo) --加密
	table.merge(self.roleInfo,info)

	self.oldRoleInfo = {}
	table.encrypt(self.oldRoleInfo)
	table.merge(self.oldRoleInfo,info)

	NotifyCenter:dispatchEvent({name=Notify.ROLE_INIT})
	NotifyCenter:dispatchEvent({name=Notify.ROLE_UPDATE, list = {},isInit = true})
	self._initFlag = true
end

function RoleModel:isRoleInit()
	if true == self._initFlag then
		return true
	else
		return false
	end
end

function RoleModel:onRoleUpdate(roleAttr)
	if nil == self.roleInfo then
		return
	end
	local changeList = {}
	for i,v in ipairs(roleAttr) do
		local attrName = RoleConst.KeyTable[v.key]
		if nil ~= attrName then
			if self.roleInfo[attrName] ~= v.value then
				self.oldRoleInfo[attrName] = self.roleInfo[attrName]
				self.roleInfo[attrName] = v.value
				changeList[attrName] = true
			end
		end
	end
	if changeList[RoleConst.VIPLEV] then
		TipModel:showUpGoldNumber(self.oldRoleInfo[RoleConst.GOLD], self.roleInfo[RoleConst.GOLD])

		scheduler.performWithDelayGlobal(function()
			ViewMgr:open(Panel.VIP_UPGRADE_TIP,{vip=self.roleInfo[RoleConst.VIPLEV]})
		 end, 2)
	end

	if changeList[RoleConst.GOLD] and not self._ignoreUpGoldPlay then
		TipModel:showUpGoldNumber(self.oldRoleInfo[RoleConst.GOLD], self.roleInfo[RoleConst.GOLD])
	end

	if changeList[RoleConst.LEVEL] then
		FAModel:notifyHeroArmyCheck(  )
	end

	if changeList[RoleConst.FEATS] then
		WildernessModel:checkFeatTip()
	end

	if changeList[RoleConst.MILITARY_RANK] then
		local name = RankCfg:getMilitaryName()
		if name then
			floatText(string.format(LangCfg:getRankText(25), name))
		end
	end

	NotifyCenter:dispatchEvent({name=Notify.ROLE_UPDATE, list = changeList})
end

function RoleModel:getRoleAttrByIndex(key)
	local str = RoleConst.Attribute[key]
	return self.roleInfo[str]
end

function RoleModel:setRoleAttrvalue( key, value )
	self.roleInfo[key] = value
end

function RoleModel:setName(name)
	RoleProxy:reqSetName(name)
end

function RoleModel:setNameResult(result, name)
	if name ~= self.roleInfo[RoleConst.NAME] then
		self.oldRoleInfo[RoleConst.NAME] = self.roleInfo[RoleConst.NAME]
		self.roleInfo[RoleConst.NAME] = name
		NotifyCenter:dispatchEvent({name=Notify.ROLE_UPDATE, list = {[RoleConst.NAME] = true}})
	end
	if 0 == result then
		NotifyCenter:dispatchEvent({name=Notify.ROLE_SET_NAME_RESULT, result = true})
		RoleProxy:reqNextSetNameTime()
	else
		NotifyCenter:dispatchEvent({name=Notify.ROLE_SET_NAME_RESULT, result = false})
	end
end

function RoleModel:getRoleId()
	return self.roleInfo and self.roleInfo[RoleConst.ID] or 0
end

function RoleModel:getCoin()
	return self.roleInfo and self.roleInfo[RoleConst.COIN] or 0
end

function RoleModel:getGold()
	return self.roleInfo and self.roleInfo[RoleConst.GOLD] or 0
end

function RoleModel:getCamp()
	return self.roleInfo and self.roleInfo[RoleConst.CAMP] or 0
end

function RoleModel:getLevel()
	return self.roleInfo and self.roleInfo[RoleConst.LEVEL] or 0
end

function RoleModel:getExp()
	return self.roleInfo and self.roleInfo[RoleConst.EXP] or 0
end

function RoleModel:getName()
	return self.roleInfo and self.roleInfo[RoleConst.NAME] or ""
end

function RoleModel:getVipLevel()
	return self.roleInfo and self.roleInfo[RoleConst.VIPLEV] or 0
end

function RoleModel:getVigour()
	return self.roleInfo and self.roleInfo[RoleConst.VIGOUR] or 0
end

function RoleModel:getChargeGold()
	return self.roleInfo and self.roleInfo[RoleConst.CHARGEGOLD] or 0
end

return RoleModel