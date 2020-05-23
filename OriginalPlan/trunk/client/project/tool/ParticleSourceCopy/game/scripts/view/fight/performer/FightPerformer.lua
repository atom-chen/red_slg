--
-- Author: wdx
-- Date: 2014-04-16 15:41:25
--
--[[--
战斗的 解析执行 类
]]
local FightPerformer = class("FightPerformer")

local RoundPerformer = require("view.fight.performer.RoundPerformer")

function FightPerformer:ctor()
	
end

function FightPerformer:init()
	self._roundData = {}
	
end

function FightPerformer:start()
	self._curRoundIndex = 0
	self:_performNextRound()
end

function FightPerformer:perform(round,data)
	self._roundData[round] = data
	if round == self._curRoundIndex then
		self:_performRound(data)
	end
end

--播放下一回合
function FightPerformer:_performNextRound()
	self._curRoundIndex = self._curRoundIndex + 1
	if self._roundData[self._curRoundIndex] then  --已经有数据了 直接播放
		self:_performRound(self._roundData[self._curRoundIndex])
	else  --请求回合数据
		Netcneter:send()
	end
end

--执行播放回合
function FightPerformer:_performRound(rInfo)
	local rPerformer = RoundPerformer.new(self)
	rPerformer:perform(rInfo)
end

--回合结束
function FightPerformer:performRoundEnd()  
	self:_performNextRound()
end

