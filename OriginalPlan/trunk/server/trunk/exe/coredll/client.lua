package.path = package.path..";?.lua;lib/?.lua;client/?.lua"

allReloadRequireName = {};

function reloadRequire(name)
	if allReloadRequireName[name]
	then
		return;
	end

	package.loaded[name] = nil;
	require(name);
	allReloadRequireName[name] = true;

	if log 
	then
		log:info("reload require " .. name .. " file");
	end
end

require "core"

server = NewServer("Client", "client/MainClient.lua", "NewMainServer");

if not server:setSystemEnvironment() then
    print("can't set system environment!!!");
    return;
end

if not server:load("client.ini") then
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