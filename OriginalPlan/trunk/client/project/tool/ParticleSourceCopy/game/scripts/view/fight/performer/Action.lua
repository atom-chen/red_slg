--
-- Author: wdx
-- Date: 2014-04-17 16:04:14
--
local Action = class("Action")



Action.BEFORE = 1  --在前面先播放的
Action.SIMUL= 2  --同时开始播放的
Action.INSERT = 3  --中间插入播放的
Action.AFTER = 4  --播放后播放的


Action.USE_SKILL_OP = 1   --使用技能 [SkillId, Target1, Target2,...TargetN]
Action.BUFF_ADD_OP = 3  --添加buff [BuffId]
Action.BUFF_REMOVE_OP = 4  --移除buff [BuffId]

Action.HP_CHANGE_OP = 5  --血量变化 [DeltaHp]

Action.ATK_CHANGE_OP = 6  --物攻变化 [DeltaAtk]


Action.DODGE_OP = 13  --闪避 []

Action.ATK_CRITICAL = 14  --暴击 []


function Action:ctor(info)
	--info 消息协议  00_entry.lua   里面的 fight_action
	-- {"id","uint32"} --id
	-- 	,{"order","uint16"}  
	-- 	,{"opType","uint16"}
	-- 	,{"arg","array","int32"}

	self.id = info.id
	self.order = info.order
	if info.opType == Action.USE_SKILL_OP then
		self.skillId = info.arg[1]
		self.target = table.remove(info.arg,1)
	else
		self.skillId = info.opType
		self.target = {}
	end
	self.children = {}
	self.hurtList = {}

end

function Action:addChild(child)
	if self.hurtList[child.source] then  --已经有受伤aciton的   加在受伤action里面	
											--因为一般都是要先播放受伤action  后再播放接下去的anction
		self.hurtList[child.source]:addChild(child)
	else
	    self.children[#self.children+1] = child
	end 
	
end

function Action:getTarget()
	if self.opType == Action.USE_SKILL_OP then
		return 
	end
end

function Action:getActionList(pos)
	local list = {}
	for i,action in ipairs(self.children) do
		local cfg = self:getCfg()
		if cfg and cfg.pos == pos then
			list[#list+1] = action
		end
	end
	return list
end

function Action:getCfg()
	if self.opType == 1 then
		return FightCfg:getSkillCfg(self.opType)
	else
		return FightCfg:getSkillCfg(self.opType)
	end
	
end



function Action:addHurtAction(hurtAction)
	self.children[#self.children+1] = hurtAction
	self.hurtList[hurtAction.id] = hurtAction
	return nil
end