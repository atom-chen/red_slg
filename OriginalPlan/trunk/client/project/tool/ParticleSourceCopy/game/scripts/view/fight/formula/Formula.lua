--
-- Author: wdx
-- Date: 2014-05-12 22:58:37
--

--[[--
	战斗计算 公式 相关
]]

local Formula = class("Formula")

function Formula:ctor()
	-- body
end


--计算 敌人 权重
function Formula:getEnemyWeight(creature, target )
	return 100
end

--计算 队友 权重
function Formula:getMateWeight(creature, target )
	if creature.ai == AI.ASSIST then
		return 1 - target.cInfo.hp/target.cInfo.maxHp
	else
		return 200
	end
	
end

--获取随机使用的技能
function Formula:getRandomSkill( creature )
	return creature.cInfo.skills[1]
end

--获取技能伤害数值
function Formula:getHurt( creature,skillInfo,target )
	return skillInfo.eNum
end

---------------------------------------------------------------------------------------------------------------------

--从配置的速度  转换成 每毫秒移动的距离
function Formula:transformSpeed( speed )
	return FightMap.TILE_F/speed
end

--根据速度  方向  返回 x ，y 速度
function Formula:getSpeedXY(speed,direction )
	if direction == Creature.RIGHT_DOWN then
		return FightMap.COS*speed, -FightMap.SIN*speed
	elseif direction == Creature.LEFT_DOWN then
		return -FightMap.COS*speed, -FightMap.SIN*speed
	elseif direction == Creature.RIGHT_UP then
		return FightMap.COS*speed, FightMap.SIN*speed
	elseif direction == Creature.LEFT_UP then
		return -FightMap.COS*speed, FightMap.SIN*speed
	end 
end

--根据当前点 目标点  速度    计算出 时间间隔 所能到达的点
function Formula:getNextPos(curX,curY,targetX,targetY,speed,dt)
	local r = math.atan2(targetY-curY,targetX-curX)
	local speedX = speed * math.cos(r)
	local speedY = speed * math.sin(r)
	
	local dx = speedX*dt
	local dy = speedY*dt

	local nextX,nextY
	if math.abs(targetX - curX) <= math.abs(dx) then
		nextX = targetX
	else
		nextX = curX + dx
	end
	if math.abs(targetY - curY) <= math.abs(dy) then
		nextY = targetY
	else
		nextY = curY + dy
	end
	return nextX,nextY
end

--全局坐标转换到 场景坐标
function Formula:toScenePos(x,y)
	local sx,sy = FightDirector:getScene():getPosition()
	return x - sx, y - sy
end

--把场景坐标 转换到地图坐标
function Formula:toMapPos( x,y )
	return FightDirector:getMap():toMapPos(x, y)
end

return Formula.new()