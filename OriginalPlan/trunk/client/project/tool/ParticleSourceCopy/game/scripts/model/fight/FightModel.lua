--
-- Author: wdx
-- Date: 2014-06-14 10:09:36
--

local FightModel = class("FightModel")

function FightModel:ctor( )
	
end

function FightModel:init()
	self.fightResult = nil
end

--保存战斗结果   掉落奖励等信息
function FightModel:setFightAward( result )
	self.fightResult = result
end


function FightModel:getFightAward()
	return self.fightResult
end


return FightModel.new()