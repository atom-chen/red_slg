reloadRequire("Class");
reloadRequire("Log");

-------------------------------------------------------
-- @class class
-- @name Role
-- @description 角色类
-- @usage
Role = Class("Role");

-------------------------------------------------------
-- @class function
-- @name NewRole
-- @description 创建新的角色对象
-- @param CRole:ptrSelf
-- @return Role:
-- @usage
function NewRole(ptrSelf)
    return Role.new(ptrSelf);
end

-------------------------------------------------------
-- @class function
-- @name Role:ctor
-- @description 角色构造函数
-- @param CRole:ptrSelf
-- @return nil:
-- @usage
function Role:ctor(ptrSelf)
	--! CRole
	self.ptrSelf = ptrSelf;
	self.playerHandler = nil;

	self:commonCtor();
end

-------------------------------------------------------
-- @class function
-- @name Role:test
-- @description 角色测试
-- @return nil:
-- @usage
function Role:test()
	print("do role test!!!");
end

-------------------------------------------------------
-- @class function
-- @name Role:reload
-- @description 重新加载脚本
-- @param Role:role
-- @return nil:
-- @usage
function Role:reload(role)
	self.ptrSelf = role.ptrSelf;
	log:debug("Reload upgrade role!RoleUID=" .. role.ptrSelf:getRoleUIDString());
end

-------------------------------------------------------
-- @class function
-- @name Role:onDBLoad
-- @description 角色数据加载
-- @param nil:dbData 角色数据(json格式)
-- @return boolean:
-- @usage
function Role:onDBLoad(jsonData, firstLogin)
	local dbData = {}
	if jsonData ~= "" then
		dbData = cjson.decode(jsonData)
	end

	if not self:commonDBLoad(dbData, firstLogin) then
		logError("Cant do common dbdata load!!!RoleUID={0}", self.roleUID);
		return false;
	end

	return true;
end

-------------------------------------------------------
-- @class function
-- @name Role:onDBSave
-- @description 角色数据保存
-- @param nil:dbData 角色数据(json格式)
-- @return boolean:
-- @usage
function Role:onDBSave(offlineFlag)
	local dbData = {}
	if not self:commonDBSave(dbData, offlineFlag) then
		logError("Cant do common dbdata save!!!RoleUID={0}", self.roleUID);
		return false;
	end

	return true;
end

-------------------------------------------------------
-- @class function
-- @name Role:onNewLogin
-- @description 新角色登陆
-- @return nil:
-- @usage
function Role:onNewLogin()
	self:commonNewLogin();
end

-------------------------------------------------------
-- @class function
-- @name Role:onOnline
-- @description 角色上线
-- @return nil:
-- @usage
function Role:onOnline()
	self:commonOnline();
end

-------------------------------------------------------
-- @class function
-- @name Role:sendAllData
-- @description 发送角色所有数据
-- @return nil:
-- @usage
function Role:sendAllData()
end

-------------------------------------------------------
-- @class function
-- @name Role:sendPacket
-- @description 发送消息
-- @return nil:
-- @usage
function Role:sendPacket(pack, unRetCode)
	self.playerHandler:sendPacket(pack, unRetCode);
end
