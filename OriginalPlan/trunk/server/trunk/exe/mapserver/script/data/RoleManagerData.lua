require("Role");
require("Log");

-- 角色管理器
roleMgr = {};

roleNum = 0;
function HandleRoleFunc(roleUID, funcName, ...)

	local roleUIDStr = roleUID;
	local role = roleMgr[roleUIDStr];
	if role ~= nil
	then
		if role[funcName] ~= nil and type(role[funcName]) == "function"
		then
			return role[funcName](role, ...);
		end
	end

	return false;

end

function AddRole(role)
	
	local roleUIDStr = role:getRoleUIDString();

	if roleMgr[roleUIDStr] ~= nil
	then
		log:error("Can't add role, exist same role!RoleUID=" .. roleUIDStr);
		assert(false);
	end
	log:info("Add role to role manager!RoleUID=" .. roleUIDStr .. "," .. role:toString());
	local srole = Role:new();
	srole.pRole = role;
	roleMgr[roleUIDStr] = srole;
	roleNum = roleNum+1;
	return true;

end

function FindRole(role)
	local roleUIDStr = role:getRoleUIDString();
	return roleMgr[roleUIDStr];
end

function FindRoleByUID(roleUID)
	return CMServerHelper:LuaGetSpRole(roleUID);
end

function DeleteRole(role)

	local roleUIDStr = role:getRoleUIDString();
	if roleMgr[roleUIDStr] == nil
	then
		log:error("Can't delete role, not exist role!RoleUID=" .. roleUIDStr);
		assert(false);
	end
	log:info("Delete role from role manager!RoleUID=" .. roleUIDStr .. role:toString());
	roleMgr[roleUIDStr] = nil;
	roleNum = roleNum-1;
	return true;

end

function BroadcastPacket(pack)
	for k,v in pairs(roleMgr) do
		v.playerHandler:sendPacket(pack);
	end
end

function RoleManagerUpdateTimer(seconds)
	log:info("Call script " .. seconds .. " timer!RoleNum=" .. roleNum);
	ChatSystemMsg("test1123343");
	return true;
end

function ReloadRoleManagerData()
	local tempMgr = roleMgr;
	
	for k, v in pairs(tempMgr) do
		local oldRole = v;
		local newRole = CRole.new();
		newRole:reload(oldRole);
		roleMgr[k] = newRole;
	end
end