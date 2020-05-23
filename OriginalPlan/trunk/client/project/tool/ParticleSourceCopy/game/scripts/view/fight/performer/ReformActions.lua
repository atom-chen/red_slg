--
-- Author: wdx
-- Date: 2014-04-17 11:04:13
--

--[[--
重建 actions  
把服务器发过来的action列表数据    重新组建  成为 一个 多个树形结构的 actionTree 
每个action 添加 parent  和children ={}属性
]]
local ReformActions = class("ReformActions")

local Action = require("view.fight.performer.Action")

function ReformActions:ctor()

end

function ReformActions:reform(infoList)
	local actionTrees = {}
	for i,info in ipairs(infoList) do
		if info["parent"] == 0 then
			local action = Action.new(info)
			self:_reformAction(action,infoList,i)
			actionTrees[#actionTrees+1] = action
		end
	end
	return actionTrees
end

function ReformActions:_reformAction(action,infoList,id)
	local hurtActionList = self:_getHurtActionList( infoList,id)
	for i,hurtAction in ipairs(hurtActionList) do
		action:addHurtAction(hurtAction)
	end
	for i,info in ipairs(infoList) do
		if info["parent"] == id and info.opType ~= Action.HURT_OP then
			local child = Action.new(info)
			child.parent = action
			action:addChild(child)
			self:_reformAction(child,infoList,i)
		end
	end
end

function ReformActions:_getHurtActionList(infoList,id)
	local list = {}
	for i,info in infoList do
		if self:_isHurtAction(info) then
			local action = Action.new(info)
			list[#list+1] = action
		end
	end
	return list
end

--判断是不是受伤action   也就是扣血
function ReformActions:_isHurtAction(info)
	if info.opType == Action.HP_CHANGE_OP then
		if info.arg[1] < 0 then  --血量减少
			return true
		end
	end
	return false
end