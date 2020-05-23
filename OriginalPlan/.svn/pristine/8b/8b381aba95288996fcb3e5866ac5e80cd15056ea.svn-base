local MsgType = {}

--[[--
	登录模块
]]
MsgType.ALL = "all"
MsgType.LOGIN_IN_MSG = 2001    --登录 服务器
MsgType.LOGIN_IN_MSG_RET = 20011    --登录 服务器 返回

MsgType.REGISTER_MSG = 2004    --注册

MsgType.SERVER_LIST_MSG = 20021    -- 接收服务器列表

MsgType.AOUNTER_BIND_MSG = 2005   --账号绑定、游客注册
MsgType.AOUNTER_BIND_MSG = 2005   --账号绑定、游客注册
MsgType.JUNHAI_LOGIN_MAG = 2006   --君海登录返回
MsgType.SELECT_SERVER_MSG = 2003   --选择服务器
MsgType.SELECT_SERVER_MSG_RET = 20031   --选择服务器
MsgType.LAST_LOGIN_SERVER = 2010   --获取 之前登录过的服务器
MsgType.LAST_LOGIN_SERVER_RET = 20101   --获取 之前登录过的服务器
MsgType.WORLD_MOVE_CAMP = 21014 --主基地迁移

MsgType.LOGIN_GAME_SERVER_MSG = 2011  --登录游戏服务器
MsgType.LOGIN_GAME_SERVER_MSG_RET = 20111  --登录游戏服务器

MsgType.CREATE_ROLE = 3002  --创建角色
MsgType.GAME_SERVER_READY_MSG = 1105

MsgType.ENTER_GAME = 1103  --客户端初始化完了  进入游戏
MsgType.ENTER_GAME_RET = 1104  --客户端初始化完了  进入游戏

MsgType.NET_BE_BREAK = 3006   --被服务器断开
MsgType.TO_EXIT_GAME = 3007  --客户端请求退出游戏
MsgType.LIVE_PACK = 3009   --心跳包
MsgType.PAY_URL = 3011   ---充值回调地址

MsgType.SHOULD_SELECT_GROUP = 3015
MsgType.SELECT_GROUP = 3016

--[-------------------战斗协议-----------------------]

----时间管理-------------
MsgType.NET_TIME_REQ = 3005

-------------------------------

if DEBUG == 2 then
	MsgType.debug = {}
	for k,v in pairs(MsgType) do
		if type(v) == "number" then
			MsgType.debug[v] = k
		end
	end
end

return MsgType
