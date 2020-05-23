-------------------------------------------------------
-- @class function
-- @name GetRoleManagerUpdateTime
-- @description 获取玩家对象管理器更新时间间隔
-- @return
-- @usage
function GetRoleManagerUpdateTime()
	return 20;
end

-------------------------------------------------------
-- @class function
-- @name GetServerTimerInterval
-- @description 获取服务器定时器间隔
-- @return
function GetServerTimerInterval()
	return 5000;
end

-------------------------------------------------------
-- @class function
-- @name GetRoleManagerRoleHeartTime
-- @description 获取玩家对象管理器心跳时间间隔
-- @return
-- @usage
function GetRoleManagerRoleHeartTime()
	return 10;
end

-------------------------------------------------------
-- @class function
-- @name GetRoleLoadSaveFlag
-- @description 获取玩家加载完就立即保存标记
-- @return
-- @usage
function GetRoleLoadSaveFlag()
	return 0;
end

-------------------------------------------------------
-- @class function
-- @name IsServerRandName
-- @description 是否为服务器随机生成的玩家名字
-- @return
-- @usage
function IsServerRandName()
	if name[1] == 'G' and name[2] == 'M' and name[3] == 'R' then
		return true;
	end
end

-------------------------------------------------------
-- @class function
-- @name ChangeRoleName
-- @description 获取服务器随机生成的名字在客户端对应的显示名
-- @param nil|name 玩家名字
-- @return
-- @usage
function ChangeRoleName(name)
	if name[1] == 'G' and name[2] == 'M' and name[3] == 'R' then
		return "英雄"
	end

	return name;
end


-------------------------------------------------------
-- @class function
-- @name GetStopAnnouncement
-- @description 获取停止服务器公告
-- @return 公告内容
-- @usage
function GetStopAnnouncement()
	return "^0xffff^游戏服务器即将停机维护，请玩家准备下线!!!";
end


-------------------------------------------------------
-- @class function
-- @name StopService
-- @description 停止服务器事件
-- @param nil|lastStopTime  停止时间
-- @param nil|saveTime 保存数据时间
-- @return true
-- @usage
function StopService(lastStopTime, saveTime)
	if lastStopTime == nil then
		lastStopTime = 30;
	end

	if saveTime == nil then
		saveTime = 20;
	end

	stopTimer = luaGetServer():getStopTimer();
	if not stopTimer:isStop() then
		log:info("Start stop service!");
		stopTimer:onStop(lastStopTime, saveTime);
		luaGetServer():addManagerBoard(GetStopAnnouncement(), 5);
	else
		log:error("Start stop service, has stop!");
	end

	return true;
end

-------------------------------------------------------
-- @class function
-- @name StopServiceSave
-- @description 停止服务器保存事件
-- @return true
-- @usage
function StopServiceSave()
	log:info("Stop service save!");
	luaGetRoleManager():kickAllRole();
	return true;
end
