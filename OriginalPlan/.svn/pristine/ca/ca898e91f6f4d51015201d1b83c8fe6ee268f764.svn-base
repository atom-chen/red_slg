

local FightNet = {}

function FightNet:init()
	self.msgHandleList = {[MsgType.FIGHT_REQ_NEW_HERO] = self._onNewHero
					,[MsgType.FIGHT_MOVE] = self._onCreatureMove
					,[MsgType.FIGHT_USE_SKILL] = self._onUseSkill
					,[MsgType.FIGHT_ADD_CREATURE] = self._onAddCreature
					,[MsgType.FIGHT_HURT] = self._onHpChange
					,[MsgType.FIGHT_DIE] = self._onCreatureDie
					,[MsgType.FIGHT_OVER] = self._onFightOver
					,[MsgType.FIGHT_REQ_PLAYER_SKILL] = self._onPlayerSkill
					,[MsgType.FIGHT_CHARM] = self._onCharm
					,[MsgType.FIGHT_BUFF] = self._onAddBuff
					,[MsgType.FIGHT_BOMB_NUM] = self._onBombChange
					,[MsgType.FIGHT_MANNED] = self._onManned
					}
	NetCenter:addMsgHandlerList(self,self.msgHandleList)

	local mateList = FightDirector:getScene():getTeamList(FightCommon.left)
	local enemyList = FightDirector:getScene():getTeamList(FightCommon.right)
	self._creatureList = {}

	local netGlobalId = 1
	local hq = FightDirector:getScene():getHQ(FightCommon.left)
	if hq then
		self:setCreature(netGlobalId,hq)
		netGlobalId = netGlobalId + 1
	end
	hq = FightDirector:getScene():getHQ(FightCommon.right)
	if hq then
		self:setCreature(netGlobalId,hq)
		netGlobalId = netGlobalId + 1
	end
	for i,mate in ipairs(mateList) do
		if not mate.isHQ then
			self:setCreature(netGlobalId,mate)
			netGlobalId = netGlobalId + 1
		end
	end

	for i,enemy in ipairs(enemyList) do
		if not enemy.isHQ then
			self:setCreature(netGlobalId,enemy)
			netGlobalId = netGlobalId + 1
		end
	end

	if FightDirector.fightType == FightCfg.TEST_FIGHT then
		NetCenter:send(MsgType.FIGHT_TEST_BEGIN)
	end

	self.msgList = {}
end

--请求战斗开始
function FightNet:reqFightStart(callback)
	self.callback = callback
	NetCenter:send(MsgType.FIGHT_START)
	NetCenter:addMsgHandler(MsgType.FIGHT_START, {self,self._onFightStart})
end

--战斗正式开始
function FightNet:_onFightStart(pack)
	NetCenter:removeMsgHandler(MsgType.FIGHT_START, {self,self._onFightStart})
	self.callback()
	self.callback = nil
end

--请求上
function FightNet:reqNewHero(id)
	NetCenter:send(MsgType.FIGHT_REQ_NEW_HERO,id)
end

--请求使用大招
function FightNet:reqUsePlayerSKill(skillId,x,y)
	NetCenter:sendMsg(MsgType.FIGHT_REQ_PLAYER_SKILL,{skillId = skillId,pos={x=math.floor(x),y=math.floor(y)}})
end

--大招
function FightNet:_onPlayerSkill(pack)
	local msg = pack.msg
	if msg.result == 0 then
		if msg.team == FightCommon.mate then
			--todo
		end
		local x,y = Formula:toScenePos(msg.pos.x,msg.pos.y)
		local PlayerSkill = game_require("view.fight.skill.PlayerSkill")
		PlayerSkill.playSkill(msg.team,msg.skillId,x,y)
	end
end

--请求上场
function FightNet:_onNewHero(pack)
	local msg = pack.msg
	if msg.result == 0 then
		local panel = ViewMgr:getPanel(Panel.FIGHT)
		panel.ui.fightBottom:setHeroStockNum(msg.heroId,msg.stockNum)
	end
end

--移动
function FightNet:_onCreatureMove(pack)
	local msg = pack.msg
	local creature = self:getCreatureByNetId(msg.uId)
	if creature then
		if msg.time > FightEngine:getCurTime() then
			local ai = AIMgr:getAI(creature)
			ai:setMoveTile(msg.pos.x,msg.pos.y)
		else  -- time pass    set pos at once
			print("move time pass",msg.time,FightEngine:getCurTime())
			local ai = AIMgr:getAI(creature)
			ai:setMoveTile(msg.pos.x,msg.pos.y)
			-- FightDirector:getMap():creatureSetTo(creature,msg.pos.x,msg.pos.y)
		end
	end
end

--使用技能
function FightNet:_onUseSkill(pack)
	local msg = pack.msg
	local creature = self:getCreatureByNetId(msg.uId)
	local target = self:getCreatureByNetId(msg.targetId)
	-- print("creature:getSkillCount()",creature,target)
	-- dump(msg)
	if creature and target then
		local skill = FightCfg:getSkill(msg.skillId)
		if skill.fTime == 0 or creature:getSkillCount() == 0  then
			local direction = AIMgr:getDirection(creature,target:getPosition())
			if not creature:isAtkFaceto(direction) then
				creature:setDirection(direction)
			end
			FightEngine:createSkill(creature, msg.skillId, target)
		end
	end
end

--添加buff
function FightNet:_onAddBuff(pack)
	local msg = pack.msg
	local creature = self:getCreatureByNetId(msg.uId)
	if creature then
		local curTime = FightEngine:getCurTime()
		local time = msg.endTime - curTime
		if time > 0 then
			FightEngine:createBuff(creature, msg.buffId, time)
		end
	end
end

--添加单位
function FightNet:_onAddCreature(pack)
	local msg = pack.msg
	-- if msg.team == FightCommon.mate then
	-- 	msg.monsterId = 2006
	-- end
	local creature = self:getCreatureByNetId(msg.uId)
	if not creature then
		local hero
		if MonsterCfg:hasMonster(msg.monsterId) then
			hero = FightCfg:getFightMonster(msg.monsterId,msg.team)
		else
			hero = HeroInfo.newFromProtocol({heroID=msg.monsterId,lev=1,exp=1,quality=1
						,eqmList={},attrList={ }},false)
			FightCfg:setDefaultAttr(hero)    --网络过来的不需要什么属性
			hero = FightCfg:getFightHero(hero, msg.team)
		end
		hero.maxHp = msg.max_hp
		hero.hp = msg.max_hp
		hero.mx = msg.pos.x
		hero.my = msg.pos.y
		creature= FightDirector:getScene():initCreature(hero)
		print("--网络的：")
		self:setCreature(msg.uId,creature)
	else
		creature.cInfo.hp = msg.max_hp
		creature.cInfo.maxHp = msg.max_hp
	end
	assert(msg.max_hp > 0, " hp  <= 0 ")
end

--血量变更
function FightNet:_onHpChange(pack)
	local msg = pack.msg
	local creature = self:getCreatureByNetId(msg.uId)
	if creature then
		if msg.hp <= 0 then
			msg.hp = 1
		end
		if msg.time > FightEngine:getCurTime() - 1000 then
			msg.aType = "hurt"
			msg.time = FightEngine:getCurTime() + 1000
			self.msgList[#self.msgList+1]=msg
		else
			creature:setHp(msg.hp)
		end
	end
end

--死亡
function FightNet:_onCreatureDie(pack)
	local msg = pack.msg
	local creature = self:getCreatureByNetId(msg.uId)
	if creature then
		if msg.time > FightEngine:getCurTime() - 1000 then
			msg.aType = "die"
			msg.time = FightEngine:getCurTime() + 1000
			self.msgList[#self.msgList+1]=msg
		else  -- time pass    set pos at once
			self._creatureList[msg.uId] = nil
			creature:die(nil,msg.type)
		end
	end
end

--心灵控制
function FightNet:_onCharm(pack)
	local msg = pack.msg
	if msg.srcId == 0 then  --玩家大招控制
		local target = self:getCreatureByNetId(msg.targetId)
		if target then
			local CharmHandle = game_require("view.fight.handle.CharmHandle")
			if msg.control == 1 then
				CharmHandle:changeTeam(target)
			else
				CharmHandle:recoverTeam(target)
			end
		end
	else
		local creature = self:getCreatureByNetId(msg.srcId)
		local target = self:getCreatureByNetId(msg.targetId)
		if creature and target then
			local ai = AIMgr:getAI(creature)
			if ai.actionAI.setCharmTraget then
				if msg.control == 1 then
					ai.actionAI:setCharmTraget(target)
				else
					ai.actionAI:removeCharmTraget(target)
				end
			end
		end
	end
end

function FightNet:_onBombChange(pack)
	local msg = pack.msg
	local creature = self:getCreatureByNetId(msg.uId)
	if creature and creature.setBomb then
		creature:setBomb(msg.bombNum)
	end
end

function FightNet:_onManned(pack)
	local msg = pack.msg
	local creature = self:getCreatureByNetId(msg.UId)
	local target = self:getCreatureByNetId(msg.passengerId)
	if creature and target then
		local ai = AIMgr:getAI(creature)
		if ai.addBiont then
			target.cInfo.netId = msg.passengerId
			ai:addBiont(target)
		end
	end
end

--战斗结束
function FightNet:_onFightOver(pack)
	for i,msg in ipairs(self.msgList) do
		self:doMsgAction(msg)
	end
	self.msgList = {}

	local msg = pack.msg
	HurtHandler:setHurtData(msg.teamDps1,msg.teamDps2)

	local win = msg.fightOver == 1
	local isTimeOut = msg.isTimeOut == 1
	FightDirector:fightOver(win,false,isTimeOut)
end

function FightNet:run()
	local curTime = FightEngine:getCurTime()
	local index = 1
	for i=1,#self.msgList,1 do
		local action = self.msgList[index]
		if not action then
			break
		end
		if action.time >= curTime then
			self:doMsgAction(action)
			table.remove(self.msgList,index)
		else
			index = index + 1
		end
	end
end

function FightNet:doMsgAction(msg)
	local creature = self:getCreatureByNetId(msg.uId)
	if creature then
		if msg.aType == "hurt" then
			creature:setHp(msg.hp)
		elseif msg.aType == "die" then
			self._creatureList[msg.uId] = nil
			creature:die(nil,msg.type)
		end
	end
end

function FightNet:setCreature(uId,creature)
	print("--设置新怪物：",uId,creature.cInfo.id,creature.cInfo.name,creature.cInfo.speciaAI)
	self._creatureList[uId] = creature
end

function FightNet:getCreatureByNetId( uId )
	return self._creatureList[uId]
end

function FightNet:stop()
	NetCenter:removeMsgHandlerList(self,self.msgHandleList)
	self.msgList = {}
end

return FightNet

