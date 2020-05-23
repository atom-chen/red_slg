local MsgType = {}

--[[--
	登录模块  具体消息定义在 启动的launch/gameState里面
]]

MsgType.REQ_GENERAL = 10011	  --请求 一些系统次数
MsgType.RES_GENERAL = 10012  --系统  次数返回



--[[--
  副本模块 4200-4299
]]
MsgType.DUNGEON_INIT = 4201          --初始化副本
MsgType.DUNGEON_FIGHT_BEGIN = 4202   --副本战斗开始 
MsgType.DUNGEON_FIGHT_END = 4203  --副本战斗结束
MsgType.DUNGEON_SWEEP = 4204  --扫荡副本

MsgType.BAG_GET_ALL = 4100          	--获取所有背包信息
MsgType.BAG_CHANGE = 4101   			--背包信息变化



return MsgType