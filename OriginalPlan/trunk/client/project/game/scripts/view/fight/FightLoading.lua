--
--战斗加载界面

local FightLoading = class("FightLoading",function() return display.newNode() end)

function FightLoading:ctor()
	self.bg = display.newXSprite("pic/init_bg.w")
	self:addChild(self.bg)
	self.bg:setPosition(display.cx,display.cy)

	self.progress = UIProgressBar.new("#load_bar.png","#load_barBg.png")
	self.progress:setAnchorPoint(ccp(0.5,0.5))
	self.progress:setClipMode(true)
	self:addChild(self.progress)
	self.progress:setPosition(display.cx,55)

	self.tipText = ui.newTTFLabelWithOutline({text="正在努力加载中...", size=19,align=ui.TEXT_ALIGN_CENTER})
    self.tipText:setPosition(display.cx, 53)
    self:addChild(self.tipText)

    self.funnyText = ui.newTTFLabelWithOutline({text="", size=20,align=ui.TEXT_ALIGN_CENTER})
    self.funnyText:setPosition(display.cx, 90)
    self:addChild(self.funnyText)
    self:_showFunnyText()
    if not self.funnyTimeId then
        self.funnyTimeId = scheduler.scheduleGlobal(function()
            self:_showFunnyText()
         end, 3)
    end


	self.animaResMap = {}
	self.pMap = {}
	self.totalNum = 0

	-- self.magic = SimpleMagic.new(35)
	-- self.progress:setProgressPoint(self.magic,5,5)

	self:retain()
end

function FightLoading:_showFunnyText()
    local tipCfg = require("update.load_tip_cfg")
    local str = tipCfg[math.random(1,#tipCfg)]
    self.funnyText:setString(str.tip)
end

function FightLoading:startLoad(callBack)
	self.callBack = callBack
	-- LoadingControl:show("fightPreLoad",true)
	-- scheduler.performWithDelayGlobal(function() self:_toLoad() end ,0.01)
	self:_reqFight()

	self:_toLoad()
end

function FightLoading:_reqFight()
	self._isResFight = false
	FightDirector:getSysHandle():reqFightBegin(handler(self,self._resFightBegin))
end

function FightLoading:_resFightBegin()
	self._isResFight = true
	if self.isLoadOk then
		self.callBack()
	end
end

function FightLoading:_toLoad()
	self.isLoadOk = false
	self.totalNum = 0

	self.animaResMap = {}
	self.pMap = {}
	self.musicList = {}

	local cList,teamList = FightDirector:getSysHandle():getHeroResList()


	local sceneId = FightDirector.fightInfo.sceneId
	local mList = FightCfg:getSceneMagic(sceneId)  --预加载场景特效
	self:addMagicListRes(mList)

	self:addCreatureListRes(cList,teamList)

	if self.loadTimer then
		scheduler.unscheduleGlobal(self.loadTimer)
		self.loadTimer = nil
	end

	self.maxNum = 0
	for res,_ in pairs(self.animaResMap) do
		self.maxNum = self.maxNum + 1
	end
	for pId,_ in pairs(self.pMap) do
		self.maxNum = self.maxNum + 0.5
	end
	-- for mId,_ in pairs(self.musicList) do
	-- 	self.maxNum = self.maxNum + 0.2
	-- end

	self.curNum = 0
	self.progress:setMaxProgress(self.maxNum)

	--self.mapRes = FightCfg:getSceneBg(FightDirector.fightInfo.sceneId)
	self.mapRes = FightCfg:getSceneBg(FightDirector.fightInfo.sceneId)

	self.loadTimer = scheduler.scheduleGlobal(function() self:_loadNext(1) end, 0.001)
end

function FightLoading:_loadNext(num)
	self.curNum = self.curNum + num
	self.progress:setProgress(self.curNum)

	local cur = 0

	-- if self.curNum%2 == 1 and self:_loadLittle(cur,num) then
	-- 	return
	-- else
	-- 	for res,_ in pairs(self.animaResMap) do
	-- 		self.animaResMap[res] = nil
	-- 		cur = cur + 1
	-- 		FightCache:retainAnima(res)  --缓存资源
	-- 		if cur >= num then
	-- 			return
	-- 		end
	-- 	end
	-- end

	if self:_loadLittle(cur,num) then
		return
	end

	for res,_ in pairs(self.animaResMap) do
		self.animaResMap[res] = nil
		cur = cur + 1
		FightCache:retainAnima(res)  --缓存资源
		if cur >= num then
			return
		end
	end

--	if self.mapRes then
--		FightCache:retainImage(self.mapRes)
--		self.mapRes = nil
--		return
--	end

	self:_loadEnd()
end

function FightLoading:_loadLittle(cur,max)

	-- for mId,_ in pairs(self.musicList) do
	-- 	cur = cur + 0.2
	-- 	self.musicList[mId] = nil
	-- 	AudioMgr:preloadEffect(mId)
	-- 	if cur >= max then
	-- 		return true
	-- 	end
	-- end


	for pId,_ in pairs(self.pMap) do
		self.pMap[pId] = nil
		cur = cur + 0.5
		local p = ParticleMgr:CreateParticleSystem(pId,true)
		if p then
			ParticleMgr:DestroyParticle(p)
		end
		if cur >= max then
			return true
		end
	end
	return false
end

function FightLoading:_loadEnd()
	if self.loadTimer then
		scheduler.unscheduleGlobal(self.loadTimer)
		self.loadTimer = nil
	end
	self.isLoadOk = true


	-- if not self._timerMusice then
	-- 	self._timerMusice = scheduler.scheduleGlobal(function() self:_loadMusice() end, 0.05)
	-- end

	if self._isResFight then
		self.callBack()
	else
		self.tipText:setString("请求进入战斗...")
	end
end

function FightLoading:getMusicList()
	return self.musicList
end

function FightLoading:addCreatureListRes(cList,teamList)
	teamList = teamList or {}
	for i,cInfo in pairs(cList) do
		local team = teamList[i] or FightCommon.mate
		if cInfo.cfg then
			cInfo = cInfo.cfg
		end
		self:addCreatureSkillRes(cInfo.skills)
		self:addCreatureSkillRes(cInfo.skills_1)

		if cInfo.dieSkill then
			local sList
			if #cInfo.dieSkill > 1 then
				if team == FightCommon.mate then
					sList = {cInfo.dieSkill[1]}
				else
					sList = {cInfo.dieSkill[2]}
				end
			else
				sList = cInfo.dieSkill
			end
			self:addCreatureSkillRes(sList)
		end

		if cInfo.heroMagic then
			self:addMagicListRes(cInfo.heroMagic)
		end
		if cInfo.moveMagic then
			self:addMagicListRes(cInfo.moveMagic)
		end
		if cInfo.standMagic then
			self:addMagicListRes(cInfo.standMagic)
		end
		if cInfo.dieMagic then
			local mList
			if #cInfo.dieMagic > 1 then
				if team == FightCommon.mate then
					mList = {cInfo.dieMagic[1]}
				else
					mList = {cInfo.dieMagic[2]}
				end
			else
				mList = cInfo.dieMagic
			end
			self:addMagicListRes(mList)
		end

		self:addRes(cInfo.res)
	end
end

function FightLoading:addCreatureSkillRes(skills)
	if skills then
		for i,skillId in ipairs(skills) do
			local sInfo = FightCfg:getSkill(skillId)
			if sInfo then
				local magicList = sInfo.keyMagic
				if magicList then
					self:addMagicListRes(magicList)
				end
			end
		end
	end
end

function FightLoading:addMagicListRes(magicList,team)
	for i,mId in ipairs(magicList) do
		if mId > 0 then
			local mInfo = FightCfg:getMagic(mId)
			if mInfo then
				if mInfo.res then  --动画资源
					self:addRes(mInfo.res)
				end
				if mInfo.pId then  --粒子
					self:addParticle(mInfo.pId[1])
					if mInfo.pId[2] then
						self:addParticle(mInfo.pId[2])
					end
				end
				-- if mInfo.skillMusic then
				-- 	self:addMusic(mInfo.skillMusic)
				-- end
				local mList = mInfo.keyMagic
				if mList then
					self:addMagicListRes(mList)
				end

			end
		end
	end
end

function FightLoading:addRes(resName)
	if not self.animaResMap[resName] then
		self.animaResMap[resName] = true
		self.totalNum = self.totalNum + 1
	end
end

function FightLoading:addParticle(pId)
	if not self.pMap[pId] then
		self.pMap[pId] = true
		self.totalNum = self.totalNum + 1
	end
end

function FightLoading:addMusic(musicList)
	for i,m in ipairs(musicList) do
		self.musicList[m] = true
	end
end

function FightLoading:dispose()
	self.bg:setSpriteImage(nil)
	self:removeFromParent()
	if self.loadTimer then
		scheduler.unscheduleGlobal(self.loadTimer)
		self.loadTimer = nil
	end
	if self._timerMusice then
		scheduler.unscheduleGlobal(self._timerMusice)
		self._timerMusice = nil
	end
	self.animaResMap = nil
	self.pMap = nil
	self.callBack = nil

	if self.funnyTimeId then
        scheduler.unscheduleGlobal(self.funnyTimeId)
        self.funnyTimeId = nil
    end

	self:release()
end

return FightLoading

