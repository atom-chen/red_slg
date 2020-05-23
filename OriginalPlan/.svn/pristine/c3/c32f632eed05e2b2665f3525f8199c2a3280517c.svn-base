require "mapserver"

local server = NewMapServer("MapServer");

if not server:setSystemEnvironment() then
    print("can't set system environment!!!");
    return;
end

if not server:load("MapServer.ini") then
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
