--
-- Author: wdx
-- Date: 2014-06-13 14:38:32
--

local DungeonProxy = class("DungeonProxy")

function DungeonProxy:ctor()
	
end

function DungeonProxy:init()
	NetCenter:addMsgHandler(MsgType.DUNGEON_INIT, {self,self._resDungeonInfo}, -1)
	
end

--请求初始化副本信息
function DungeonProxy:reqDungeonInfo()
	NetCenter:send(MsgType.DUNGEON_INIT)
end

--副本信息返回
function DungeonProxy:_resDungeonInfo( pack )
	local msg = pack.msg
	DungeonModel:initDungeon(msg.dungeonId,msg.eliteId,msg.finishedDungeon)
end

--进入副本战斗
function DungeonProxy:reqDungeonFight( id )
	NetCenter:send(MsgType.DUNGEON_FIGHT_BEGIN,id)
end

--副本战斗返回
function DungeonProxy.resDungeonFight( pack )
	local msg = pack.msg
	if msg.result == 0 then --成功进入
		FightModel:setFightAward(msg.award)
	else  --其他情况  体力不足等

	end
end

--保存 战斗结果 到服务器
function DungeonProxy:reqDungeonFightEnd( id,star )
	NetCenter:send(MsgType.DUNGEON_FIGHT_END,id,star)
end

function DungeonProxy:resDungeonFightEnd( pack )
	local msg = pack.msg
	if msg.result == 0 then  --战斗结束

	else  --有作弊等特殊情况？
		
	end
	Netcenter:dispatchEvent({name=Notify.FIGHT_END,result = msg.result})
end

return DungeonProxy.new()