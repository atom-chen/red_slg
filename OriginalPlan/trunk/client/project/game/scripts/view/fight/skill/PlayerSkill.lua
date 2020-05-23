
--
local PlayerSkill = class("PlayerSkill")

function PlayerSkill:ctor(gId)
	self.gId = gId
	self.isCongealDispose = true
end

function PlayerSkill:init(player,skillId,skillParams )
	self.player = player
	self.skillId = skillId
	self.skillParams = skillParams
	self.callback = skillParams.callback

	self.level = skillParams.level

	local addRate
	self.info = FightCfg:getPlayerSkillByLevel(skillId,self.level,addRate)

	if skillParams.hurtValue then
		local tempSkill = {}
        table.merge(tempSkill,self.info)
        self.info = tempSkill
        self.info.eNum = hurtValue
	end

	 --FightCfg:getSkill(skillId)
	self.skillParams.scope = self.info.scope

	self.fTime = self.info.fTime or FightCommon.animationDefaultTime
end

function PlayerSkill:start()
	print("--玩家技能。。.",self.skillId,FightDirector:isNetFight())
	self.curTime = 0
	FightDirector:getScene():showMaskLayer()

	self.skillParams.x,self.skillParams.y = Formula:globalToScenePos(display.cx,display.cy)

	self.magicTime = 0

	if FightDirector:isNetFight() then
		--self.selectTime = 3000
		FightEngine:addRunner(self)
	else
		local mList = self.info["prepareMagic"]
		if mList then
			for i,mId in ipairs(mList) do
				self.skillParams.x,self.skillParams.y = Formula:globalToScenePos(display.cx,display.cy)
				local magic = FightEngine:createMagic(self.player,mId,nil,self.info,self.skillParams,self.gId)
				magic:setZOrder(10)
				print(" self.magicTime ",mId,self.magicTime,magic.totalTime)
				if self.magicTime < magic.totalTime + 100 then
					self.magicTime = magic.totalTime + 100
				end
				magic.congealTime = magic.totalTime + 10000
				FightEngine:addCongeal(magic)
			end
		end
		FightEngine:addCongeal(self)
	end

	FightDirector:getCamera():setAuto(false)
	FightDirector:touchEnabled(false)
end

function PlayerSkill:run(dt)
	if FightDirector:isNetFight() then
		self:runCongeal(dt)
	end
end

function PlayerSkill:runCongeal(dt)
	if self.info.keyFrame and not FightDirector:isNetFight() then
		for i,frame in ipairs( self.info.keyFrame) do
			local ft = frame*self.fTime
			if self.curTime <= ft and ft < self.curTime+dt then
				local mId = self.info.keyMagic[i]
				self.skillParams.x,self.skillParams.y = Formula:globalToScenePos(display.cx,display.cy)
				local magic = FightEngine:createMagic(self.player,mId,nil,self.info,self.skillParams,self.gId)
				magic:setZOrder(10)
				if magic.setTargetPos then
					local w,h = FightDirector:getMap():getSize()
					magic:setTargetPos(self.skillParams.x,h+200,0.1)
				end
				self.magicTime = magic.totalTime + 200
				magic.congealTime = magic.totalTime + 1000

				if not FightDirector:isNetFight() then
					FightEngine:addCongeal(magic)
				end
			end
			self.curTime = self.curTime + dt
		end
	end

	if self.magicTime then
		self.magicTime = self.magicTime - dt
		if self.magicTime <= 0 then
			FightDirector:touchEnabled(true)

			self.magicTime = nil
			local touchMagic = self.info.touchMagic
			FightDirector:getScene():hideMaskLayer()
			self.skillParams.x,self.skillParams.y = Formula:globalToScenePos(display.cx,display.cy)
			local arrowMagic = FightEngine:createMagic(self.player,touchMagic,nil,self.info,self.skillParams,self.gId)

			self.arrowMagicId = arrowMagic.gId
			if not FightDirector:isNetFight() then
				arrowMagic.congealTime = 10000000
				FightEngine:addCongeal(arrowMagic)
			end

			self.selectTime = 3000
			FightTrigger:addEventListener(FightTrigger.CLICK_SCENE, {self,self.onClickScene})

			self.text = RichText.new(300,0,26,ccc3(0,250,0),3,RichText.ALIGN_CENTER)
			self.text:setPosition(-150,-100)
			arrowMagic:addChild(self.text)
			self.text:setString(string.format(self.info.arrowText,"<font color=rgb(250,0,0)>"..util.formatSecondEx(self.selectTime).."</font>"))
		end
	end
	if self.selectTime then
		self.selectTime = self.selectTime - dt
		if self.selectTime <= 0 then
			FightTrigger:removeEventListener(FightTrigger.CLICK_SCENE, {self,self.onClickScene})
			local x,y = self:_getArrowPos()

			FightEngine:removeMagicById(self.arrowMagicId)
			self.arrowMagicId = nil

			local mx,my = Formula:toMapPos(x, y)
			if FightDirector:isNetFight() then
				FightNet:reqUsePlayerSKill(self.skillId,mx,my)
			elseif self.callback then
				self.callback(mx,my)
			else
				local mId = self.info.effectMagic
				local w,h = FightDirector:getMap():getSize()
				if self.info.magicType == 1 then --核弹 特殊  由程序控制移动
					self.skillParams.x,self.skillParams.y = x,h
				elseif self.info.magicType == 2 then --轰炸机 特殊 有程序控制移动
					self.skillParams.x,self.skillParams.y = x-500,y
				else
					self.skillParams.x,self.skillParams.y = x,y
				end

				local magic = FightEngine:createMagic(self.player,mId,nil,self.info,self.skillParams,self.gId)

				if magic then
					if magic.setTargetPos then
						if self.info.magicType == 1 then  --核弹 特殊  由程序控制移动
							magic:setTargetPos(self.skillParams.x,y)
						elseif self.info.magicType == 2 then  --轰炸机 特殊 有程序控制移动
							magic:setTargetPos(x +500,y)
							magic:setMaigcOffset(-500)
							local x,y = FightDirector:getScene():getPosition()
							FightDirector:getCamera():moveSceneTo(x-200,y,200/2000)
						end
					end
					if self.info.targetBuff and magic.totalTime < self.info.targetBuff then
						magic.totalTime = self.info.targetBuff
					end

				end
			end

			self:_addSkillBuff(mx,my)

			FightDirector:getCamera():setAuto(false)
			FightDirector:getCamera():setAuto(true,true,8)

			FightEngine:removeCongeal(self)
			FightEngine:removeRunner(self)
		else
			self.text:setString(string.format(self.info.arrowText,"<font color=rgb(250,0,0)>"..util.formatSecondEx(self.selectTime).."</font>"))
		end
	end
end

function PlayerSkill:_getArrowPos()
	if FightDirector.fightInfo.fightType == FightCfg.FILM_FIGHT then
		local enemyList = FightDirector:getScene():getTeamList(FightCommon.enemy)
		local x,y = 0,0
		local w,h = FightDirector:getMap():getSize()
		for i,enemy in ipairs(enemyList) do
			x = x + enemy:getPositionX()
			y = y + enemy:getPositionY()
		end
		if x == 0 then
			x = 999999
			y = h/2
		else
			x = x /(math.max(1,#enemyList))
			y = y /(math.max(1,#enemyList))
		end
		FightDirector:getCamera():setScenePos( -(x-display.width/2), -100)

		return x,y
	else
		local arrowMagic = FightEngine:getMagicById(self.arrowMagicId)
		return arrowMagic:getPosition()
	end
end

function PlayerSkill:onClickScene(event)
	if not self.arrowMagicId then
		if DEBUG == 2 then
			assert(false,"PlayerSkill  self.arrowMagicId  nil")
		else
			FightTrigger:removeEventListener(FightTrigger.CLICK_SCENE, {self,self.onClickScene})
		end
		return
	end
	local arrowMagic = FightEngine:getMagicById(self.arrowMagicId)
	if not arrowMagic then
		if DEBUG == 2 then
			assert(false,"PlayerSkill  arrowMagic  nil")
		else
			FightTrigger:removeEventListener(FightTrigger.CLICK_SCENE, {self,self.onClickScene})
		end
		return
	else
		local x,y = Formula:globalToScenePos(event.x,event.y)
		if y > 110 then
			arrowMagic:setPosition(x,y)
			FightDirector:getCamera():setScenePos( -(x-display.width/2), -100)
		end
	end
end

function PlayerSkill:breakLastSkill(  )
	return false
end

--添加大招buff
function PlayerSkill:_addSkillBuff(mx,my)
	local targetBuff = self.info.targetBuff
	if targetBuff then
		local range = self.info.skill_rage
		local cList = self.player:getMagicTarget(self.info,self.info.targetType)
		-- print(" 添加buff ",#cList,targetBuff,self.info.buffHeroTypem)
		for i,c in pairs(cList) do
			if Formula:isScopeContain(self.info.scope,c.cInfo.scope) then
				if not self.info.buffHeroType or (table.indexOf(self.info.buffHeroType,c.cInfo.heroType) > 0) then
					local x,y = c.mx - mx, c.my - my
					for i,pos in ipairs(range) do
						if pos[1] == x and pos[2] == y then
							-- print("位置： ",x,y,pos.x,pos.y)
							FightEngine:createBuff(c,targetBuff, self.info.tBuffTime, nil, self.info)
							break
						end
					end
				end
			end
		end
	end
end

function PlayerSkill:dispose()
	-- print("---wtf")
	-- print(debug.traceback())
	if self.text then
		self.text:dispose()
	end
	FightTrigger:removeEventListener(FightTrigger.CLICK_SCENE, {self,self.onClickScene})
end


function PlayerSkill.playSkill(team,skillId,x,y,skillParams)
	local skillInfo = FightCfg:getSkill(skillId)
	local mId = skillInfo.effectMagic
	local w,h = FightDirector:getMap():getSize()
	skillParams = skillParams or {}

	if skillParams.hurtValue or skillParams.hurtRate then
		local tempSkill = {}
        table.merge(tempSkill,skillInfo)
        skillInfo = tempSkill
        skillInfo.eNum = skillParams.hurtValue or skillInfo.eNum
        skillInfo.hurtRate = skillParams.hurtRate
        skillInfo.hitAll = true
        skillInfo.skillLevel = 1
        --skillInfo.atkRate = {10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000}
	end

	skillParams.scope = skillParams.scope or skillInfo.scope
	local teamX = (team == FightCommon.left and 500) or -500
	if skillInfo.magicType == 1 then
		skillParams.x,skillParams.y = x,h
	elseif skillInfo.magicType == 2 then
		skillParams.x,skillParams.y = x - teamX,y
	else
		skillParams.x,skillParams.y = x,y
	end

	local magic = FightEngine:createMagic(FightDirector:getPlayer(team),mId,nil,skillInfo,skillParams)
	if magic.setTargetPos then
		if skillInfo.magicType == 1 then
			magic:setTargetPos(skillParams.x,y,nil,team)
		elseif skillInfo.magicType == 2 then
			if team == FightCommon.left then
				magic:setScaleX(1)
			else
				magic:setScaleX(-1)
			end
			magic:setTargetPos(x + teamX,y,nil,team)
			magic:setMaigcOffset(-teamX)
			local x,y = FightDirector:getScene():getPosition()
			FightDirector:getCamera():moveSceneTo(x-teamX/2.5,y,math.abs(teamX/2.5)/2000)
		end
	end
end

return PlayerSkill