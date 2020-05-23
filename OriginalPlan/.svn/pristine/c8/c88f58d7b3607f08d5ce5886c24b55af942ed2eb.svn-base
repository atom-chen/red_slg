reloadRequire("Role");
reloadRequire("Log");

-------------------------------------------------------
-- @class function
-- @name Role:commonCtor
-- @description 角色通用模块的构造函数
-- @return nil:
-- @usage
function Role:commonCtor()
end

-------------------------------------------------------
-- @class function
-- @name Role:onAfterDBLoad
-- @description 数据加载后事件
-- @return boolean:
-- @usage
function Role:onAfterDBLoad()
	-- 添加测试道具
	return true;
end

-------------------------------------------------------
-- @class function
-- @name Role:onFiveSecondTimer
-- @description 五秒定时器
-- @return nil:
-- @usage
function Role:onFiveSecondTimer()
	--log:info("Script five second timer!" .. self.pRole:toString());
	return 0;
end

-------------------------------------------------------
-- @class function
-- @name Role:doChargeRmb
-- @description 玩家充值
-- @param nil:val 充值的数目
-- @param nil:logFlag 是否打印日志标记
-- @return number:返回当前的元宝数
-- @usage
function Role:doChargeRmb(val, golds, logFlag)
	if logFlag then
 		logInfo("Charge RMB!OldRmb={0},NewRmb={1},RoleUID={2},AccountID={3},ObjectUID={4}",
			0, val, self.ptrSelf:getRoleUID(), self.ptrSelf:getAccountID(), self.ptrSelf:getObjUID());
 	end
	self:onRechargeGoldsAdd(val, golds);
	self:onChargeRmb(0, 0, val);
 	return newRmb;
end

-------------------------------------------------------
-- @class function
-- @name Role:onChargeRmb
-- @description 玩家充值成功事件
-- @param nil:oldRmb 旧的元宝数
-- @param nil:newRmb 充值后的元宝数
-- @param nil:addVal 增加的元宝数
-- @return nil:
-- @usage
function Role:onChargeRmb(oldRmb, newRmb, addVal)
	self.totalChargeRmb = self.totalChargeRmb+addVal;
end

-------------------------------------------------------
-- @class function
-- @name Role:onRechargeGoldsAdd
-- @description 玩家充值金币增加事件
-- @param nil:val 当前值
-- @param nil:addVal 增加的元宝数
-- @return nil:
-- @usage
function Role:onRechargeGoldsAdd(val, addVal)
end

-------------------------------------------------------
-- @class function
-- @name Role:getRoleReadyLastTime
-- @description 获取角色在准备队列中等待的时间
-- @return number:持续时间
-- @usage
function Role:getRoleReadyLastTime()
	return 10*60;
end

-------------------------------------------------------
-- @class function
-- @name Role:refreshFast
-- @description 快速刷新角色属性
-- @return nil:
-- @usage
--function Role:refreshFast()
--	if not self._attrBackup:isEqual(EAttributes.ATTR_EXP, self.ptrSelf:getExp()) then
--		self._attrBackup:setValue(EAttributes.ATTR_EXP, sself.ptrSelf:getExp());
--	end
--end

-------------------------------------------------------
-- @class function
-- @name Role:sendAllData
-- @description 登陆后发送所有数据
-- @return nil:
-- @usage
function Role:sendAllData()

end

-------------------------------------------------------
-- @class function
-- @name Role:getRoleDetailData
-- @description 获取玩家数据
-- @param TRoleDetail:detailData
-- @return nil:
-- @usage
--function Role:getRoleDetailData(detailData)
--
--end

-------------------------------------------------------
-- @class function
-- @name Role:commonDBLoad
-- @description 角色数据加载
-- @param nil:dbData
-- @param boolean:firstLogin
-- @return boolean:
-- @usage
function Role:commonDBLoad(dbData, firstLogin)
	return true;
end

-------------------------------------------------------
-- @class function
-- @name Role:commonDBSave
-- @description 角色数据保存
-- @param table:dbData 角色数据
-- @return boolean:
-- @usage
function Role:commonDBSave(dbData, offlineFlag)
	return true;
end

-------------------------------------------------------
-- @class function
-- @name Role:commonOnline
-- @description 角色上线事件
-- @return boolean:
-- @usage
function Role:commonOnline()

end

-------------------------------------------------------
-- @class function
-- @name Role:addExp
-- @description 角色增加经验
-- @param nil:exp 增加的经验
-- @usage
function Role:addExp(exp)
	self.exp = self.exp+exp;
	local lvlChange = false
	while true do
		local lvlInfo = Config.levels[self.playerData.level];
		if nil ~= lvlInfo then
			if self.exp >= lvlInfo.exp then
				self.playerData.level = self.playerData.level+1;
				self.exp = self.exp-lvlInfo.exp;
				self:onLevelUp(self.playerData.level);
				lvlChange = true
			else
				break;
			end
		else
			break;
		end
	end

	if lvlChange then
		self:refreshFast()
	end
end

-------------------------------------------------------
-- @class function
-- @name Role:addExp
-- @description 等级升级事件
-- @param nil:lvl 当前等级
-- @usage
function Role:onLevelUp(lvl)

end

-------------------------------------------------------
-- @class function
-- @name Role:commonNewLogin
-- @description 新角色登陆
-- @return nil:
-- @usage
function Role:commonNewLogin()
end

-------------------------------------------------------
-- @class function
-- @name Role:onLoadDataOk
-- @description 角色数据加载成功
-- @return boolean:
-- @usage
function Role:onLoadDataOk(roleData, playerHandler)
	playerHandler.pRole = self.ptrSelf;
	playerHandler.spRole = self;
	self.playerHandler = playerHandler;

	self:onOnline();
	
	local loadRet = MCLoginGameServerRet.new()
	loadRet.retCode = EGameRetCode.RC_SUCCESS
	self:sendPacket(loadRet);

	local readyOk = MCGameServerReady.new();
	self:sendPacket(readyOk, true);

	return true;
end
