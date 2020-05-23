package.path = package.path..";?.lua;lib/?.lua;server/?.lua;"

require "core"

allReloadRequireName = {};

function reloadRequire(name)
	if allReloadRequireName[name]
	then
		return;
	end

	package.loaded[name] = nil;
	require(name);
	allReloadRequireName[name] = true;

	if log then
		log:info("reload require " .. name .. " file");
	end
end

local server = NewServer("Server", "server/MainServer.lua", "NewMainServer");

if not server:setSystemEnvironment() then
    print("can't set system environment!!!");
    return;
end

if not server:load("server.ini") then
	print("can't load server config!!!");
	return;
end
print("server load config success!!!\n");

if not server:init() then
	print("can't init server!!!");
	return;
end
print("server init success!!!\n");

if not server:start() then
	print("can't start server!!!");
	return;
end
print("server start success!!!\n");

server:loop(-1);

print("service stop!\n");