--
-- Author: wdx
-- Date: 2014-04-22 16:49:18
--

local FightCfg = class("FightCfg")

function FightCfg:ctor()
    FightCfg.CHARM_PARTICLE = 11
    self.BATI_BUFF = 2  --霸体

    self.left = 1   --左边
    self.right = 2   --右边

    --------------战斗类型----
    self.TEST_FIGHT = -1   --测试战斗
    self.FILM_FIGHT = 0  --播放电影
    self.DUNGEON_FIGHT = 1  --副本战斗
    self.ARENA_DEFEND_FIGHT = 2  -- 竞技场 防守 站位
    self.ARENA_ATTACK_FIGHT = 3  -- 竞技场 进攻 站位
	self.GUILD_DUNGEON_FIGHT = 4--军团副本
    self.WORLD_BOSS_FIGHT = 5  --世界boss
    self.DEFENDER_FIGHT = 6  --防御pve
    self.COIN_FIGHT = 7  --金矿副本
    self.GUILD_TRAIN_FIGHT = 8   --军团训练
    self.BATTLE_FRONT_FIGHT = 9  --战阵前线
    self.SHOW_HERO_FIGHT = 17
    self.WORLD_FIGHT = 20  --野外战斗

	self.ECHELON_AREA_1 = 10  --战场第一梯队
	self.ECHELON_AREA_2 = 20  --战场第二梯队
	self.ECHELON_AREA_3 = 30  --战场第三梯队
	self.ECHELON_AREA_4 = 40  --战场第四梯队
	self.ECHELON_AREA = {
		self.ECHELON_AREA_1,
		self.ECHELON_AREA_2,
		self.ECHELON_AREA_3,
		self.ECHELON_AREA_4,
	}

	self.CITY_WALL_TOTAL_HP = {
		[self.ECHELON_AREA_1] = 15000,
		[self.ECHELON_AREA_2] = 20000,
		[self.ECHELON_AREA_3] = 25000,
		[self.ECHELON_AREA_4] = 30000,
		}

    self.FIGHT_TYPE_CFG = {
        [self.TEST_FIGHT] = {
            fightTime = 180
        },
        [self.FILM_FIGHT] = {
            fightTime = 90
        },
        [self.DUNGEON_FIGHT]={
            isDungeonFight = true,
            mateNum = 6,  --6个格子
            guildTechnologyPopulace = true --公会科技加人口
        },
        [self.COIN_FIGHT] = {
            isDungeonFight = true,
            mateNum = 6,  --6个格子
            guildTechnologyPopulace = true --公会科技加人口
        },
        [self.ARENA_DEFEND_FIGHT] = {
            fightTime = 120,
            mateNum = 6,  --6个格子
        },
        [self.ARENA_ATTACK_FIGHT]={
            useSkill = false,
            fightTime = 120,
            mateNum = 6,  --6个格子
            -- autoProduct = true
        },
        [self.BATTLE_FRONT_FIGHT]={

        },
        [self.GUILD_DUNGEON_FIGHT]={
            isDungeonFight = true,
            mateNum = 6,  --6个格子
            guildTechnologyPopulace = true --公会科技加人口
        },
        [self.WORLD_BOSS_FIGHT]={
            mateNum = 6,  --6个格子
            guildTechnologyPopulace = true --公会科技加人口
        },
        [self.GUILD_TRAIN_FIGHT] = {
            isDungeonFight = true,
            mateNum = 6,  --6个格子
            guildTechnologyPopulace = true --公会科技加人口
        },
        [self.DEFENDER_FIGHT]={
            fightTime = 180,
            guildTechnologyPopulace = true --公会科技加人口
        },
        [self.WORLD_FIGHT]={
            useSkill = false
        },
        [self.SHOW_HERO_FIGHT] = {
            useSkill = false
        }
    }


    local defaultCfg = {
        useSkill = true,
        mateNum = -1,  --无限
        fightTime = 90,
        autoProduct = false  --自动出兵
    }

    for _,cfg in pairs(self.FIGHT_TYPE_CFG) do
        for key,value in pairs(defaultCfg) do
            if cfg[key] == nil then
                cfg[key] = value
            end
        end
    end

--------------------------------------
    self.MAIN_ATTACK = 1   --主武器攻击
    self.MINOR_ATTACK = 2   --副武器攻击
    self.ASSIST = 3     --法术治疗

    self.LAND = 0
    self.FLY = 1
    self.LAND_FLY = 2

    self.GUILD_FIGHT_BUFF = 1  --军团副本buff
    self.GUILD_SUPPORT_BUFF = 1014  --军团膜拜buff

    -----------------

    self.SKILL_LEVEL_LIST = {0,0,0,20,40}   --技能初始化 相当等级

    self.MAP_W = 7
    self.MAP_H = 4


    self.HIDE_BUFF = -253  --隐身buff 2 --全部不可见
    self.FEAR_BUFF = -254  --恐惧 到处跑 buff
    self.BREAK_SKILL_BUFF = -255
    self.SPEED_BUFF = -256  --加速buff
    self.FORBID_MOVE_BUFF = -257  --禁止移动buff
    self.CHARM_BUFF = -258  --魅惑 改变队伍
    self.HIDE_AND_FORBID_MOVE_BUFF = -259  --隐身并且不可移动
    self.PALSY_BUFF = -260  --瘫痪 不能移动 不能攻击

    self.DUNGEON_MATE_BUFF = -400
    self.GUILD_TECHNOLOGY_BUFF = -500

    self.qualityList = {1,1,1.3,1.6,2}
end

function FightCfg:getNextFightArea( curArea )
	if curArea < self.ECHELON_AREA[1] then
		return self.ECHELON_AREA[1]
	end
	local len = #self.ECHELON_AREA
	for k,v in ipairs(self.ECHELON_AREA) do
		if curArea == v and k < len then
			return self.ECHELON_AREA[k+1]
		end
	end

	return self.ECHELON_AREA[len]
end

function FightCfg:init(  )

    self.callMonsterSkillList = {}

  	self._magicCfg = ConfigMgr:requestConfig("magic",nil,true)
  	self._buffCfg = ConfigMgr:requestConfig("buff",nil,true)
    self._stuntCfg = ConfigMgr:requestConfig("stunt",nil,true)

    self._sceneCfg = ConfigMgr:requestConfig("fight_scene",nil,true)

    local cfg = ConfigMgr:requestConfig("titleY",nil,true)
    self._titleYCfg = {}
    for k,v in pairs(cfg) do
        self._titleYCfg["hero/"..k] = v

        if v.dir then
            local dArr = v
            local dInfo = {}
            for i,off in ipairs(v.dir) do
                dInfo[10+i] = off
                dInfo[20+i] = {-off[1],off[2]}
            end
            local offx = v.offx
            for i=1,9 do
                local obj = {}
                local dir = 10 + i
                dArr[dir] = obj
                for j=1,9 do
                    local tDir = 10+j
                    obj[tDir] = {dInfo[tDir][1]-dInfo[dir][1],dInfo[tDir][2]-dInfo[dir][2]}

                    if offx then
                        tDir = 20 + j
                        local dir2 = 20 + i
                        obj[tDir] = {dInfo[tDir][1]-dInfo[dir2][1] - 2*offx[i] ,dInfo[tDir][2]-dInfo[dir2][2]}
                    end
                end
                obj = {}
                dir = 20 + i
                dArr[dir] = obj
                for j=1,9 do
                    local tDir = 20+j
                    obj[tDir] = {dInfo[tDir][1]-dInfo[dir][1],dInfo[tDir][2]-dInfo[dir][2]}

                    if offx then
                        tDir = 10 + j
                        local dir2 = 10 + i
                        obj[tDir] = {dInfo[tDir][1]-dInfo[dir2][1] + 2*offx[i] ,dInfo[tDir][2]-dInfo[dir2][2]}
                    end
                end
            end
            -- dump(v)
        end
        -- if dArr then
        --     dir = dir%10
        --     tDir = tDir%10
        --     -- print(debug.traceback())
        --     return {dArr[tDir][1]-dArr[dir][1],dArr[tDir][2]-dArr[dir][2]}
        -- end

    end

    self._buffCfg[self.HIDE_BUFF] = {hide = 3} --全部不可见
    self._buffCfg[self.FEAR_BUFF] = {fear=1}  --恐惧 到处跑
    self._buffCfg[self.BREAK_SKILL_BUFF] = {breakAll=1}
    self._buffCfg[self.FORBID_MOVE_BUFF] = {noMove=1}
    self._buffCfg[self.CHARM_BUFF] = {charm=1}
    self._buffCfg[self.HIDE_AND_FORBID_MOVE_BUFF] = {noMove=1,hide=3}
    self._buffCfg[self.PALSY_BUFF] = {noMove = 1,noaAttack=1}


    self._buffCfg[self.SPEED_BUFF] = {attrTypes={3},rates={-5000}}

    -- local magic = self:getMagic(12110)
    -- if magic then
    --     self.CHARM_PARTICLE = magic.pId[1]
    -- end
end

function FightCfg:addBuff(id,buff)
    self._buffCfg[id] = buff
end

function FightCfg:getTitleY(res)
    return (self._titleYCfg[res] and self._titleYCfg[res].y) or 0
end

function FightCfg:getResDirectionOffset(res,dir,tDir)
    if self._titleYCfg[res] and self._titleYCfg[res][dir] then
        return self._titleYCfg[res][dir][tDir]
    end
    return nil
end

function FightCfg:getSkill(id)
	local skill = SkillCfg:getSkill(id)
    if skill == nil then
        if id ~= 0 then
            print("技能没找到。。。。。   ",id)
        end
    else
        skill.id = id
    end
    return skill
end

function FightCfg:getMagic(id)
    local magic = self._magicCfg[id]
     if magic == nil then
        print("没有找到magic",id)
    end
	return magic
end

function FightCfg:isHasCareer( magicCfg,career )
	if not magicCfg or  not magicCfg.hitCareers then
		return false
	end
	local index = table.indexOf(magicCfg.hitCareers,career)
	return index>0
end

function FightCfg:getBuff(id)
    local buff = self._buffCfg[id]
    if buff == nil then
        print("没有找到buff",id)
    end
 	return buff
end

function FightCfg:getStunt( id )
    local stunt = self._stuntCfg[id]
     if stunt == nil then
        print("没有找到stunt",id)
    end
    return stunt
end

--标记技能为召唤技能
function FightCfg:setCallMonsterSkillId( skillId,buffId )
    self.callMonsterSkillList[skillId] = buffId
end

--根据技能id获取召唤的怪物的buffId
function FightCfg:getCallMonsterBuffId( skillId )
    return self.callMonsterSkillList[skillId]
end

--怪物信息转换为 战斗中的怪物信息
function FightCfg:getFightMonster(id,team)
    local mInfo = MonsterCfg:getMonster(id)  --怪物信息
    if not mInfo then
        print("--怪物没找到。。。   ",id)
        return nil
    end
    local cInfo = {}
    cInfo._origin = mInfo

    table.merge(cInfo,mInfo)
    cInfo.maxHp = mInfo.hp

    cInfo.hit = 0
    cInfo.dodge = 0

    cInfo.team = team

    cInfo.posLength = cInfo.posLength or 1

    local skillObj = {}
    if mInfo.skills then
        for i,skillId in ipairs(mInfo.skills) do
            skillObj[skillId] = {level=1}
        end
    end

    if mInfo.skills_1 then
        for i,skillId in ipairs(mInfo.skills_1) do
            skillObj[skillId] = {level=1}
        end
    end

    cInfo.skillObj = skillObj

    -- cInfo.atkCD = cInfo.atkCD - (cInfo.Reduce_Atk_CD or 0)

    cInfo.id = id
    -- cInfo.isMonster = true
    -- dump(cInfo)
    return cInfo
end

-- 由 HeroInfo  --转换成 战斗中的英雄 info
function FightCfg:getFightHero( info,team )
	print("KKKKKKKKKKDDDDDDDDDDDDDDDDDDD")
    local nInfo = {}
    -- table.encrypt(nInfo)  --不加密 这个了

    table.merge(nInfo,info.cfg)
    for k,v in pairs(info) do
        if type(v) ~= "function" then
            nInfo[k] = v
        end
    end
    table.merge(nInfo,info.attr)

    nInfo.hit = 0
    nInfo.dodge = 0

    -- dump(info.attr)
    -- print("--血量啊。。。。,",nInfo.hp,rawget(info.attr,"hp"),info.cfg.hp)
    nInfo.maxHp = nInfo.hp
    nInfo.atkRate = {}
    for attrId = 8,18 do  --攻击对不同装甲加成
        local attrName = AttrCfg:getAttrName(attrId)
        nInfo.atkRate[#nInfo.atkRate+1] = info.attr[attrName] or 0
        -- print("--确定是加上了。。。",attrName,info.attr[attrName])
    end

    nInfo.posLength = nInfo.posLength or 1
    local skillObj = {}
    if nInfo.skills then
        for i,skillId in ipairs(nInfo.skills) do  --获取技能 等级
            skillObj[skillId] = {level=1}
        end
    end
    if nInfo.skills_1 then
        for i,skillId in ipairs(nInfo.skills_1) do
            skillObj[skillId] = {level=1}
        end
    end

    nInfo.id = info.heroId
    nInfo.team = team

    nInfo.skillObj = skillObj
    nInfo.stockNum = math.max(info:getStockNum(),1)

    nInfo.isHero = true

    nInfo._origin = info
    return nInfo
end

function FightCfg:setDefaultAttr(hero)
    if hero.attr and not rawget(hero.attr,"hp") then
        local defaultAttr = {hp=1000,def=10,main_atk=1000,minor_atk=100}
        for k,v in pairs(defaultAttr) do
            rawset(hero.attr,k,v)
        end
        -- dump(hero.attr)
    end
end

--玩家技能 有等级的
function FightCfg:getPlayerSkillByLevel(id,level,addRate)
    local skill = self:getSkill(id)
    do
        return skill
    end
    --leader no use
    local leader = RoleModel:getFightingLeader()
    if not leader then
        return skill
    end
    if (level and level > 1) or (addeNum and addRate>0) then
        local tempSkill = {}
        table.merge(tempSkill,skill)
        if skill.eNum then
            if skill.LVadd then
                tempSkill.eNum = leader:getWeaponHurt()
            end
            if addRate then
                tempSkill.eNum = tempSkill.eNum + tempSkill.eNum*addRate
            end
        end
        if skill.tBuffTime and skill.Bbufftime then
            tempSkill.tBuffTime = leader:getBuffTime()
        end
        tempSkill.skillLevel = level
        return tempSkill
    end
    return skill
end

function FightCfg:getSkillByLevel(id,level)
    if SkillCfg:isPlayerSkill( id ) then
        return self:getPlayerSkillByLevel(id,level)
    else
        local skill = self:getSkill(id)
        return skill
    end
    -- if skill.lvAttr and level then
    --     local tempSkill = {}
    --     table.merge(tempSkill,skill)
    --     for i,attr in ipairs(skill.lvAttr) do
    --         local key = attr[1]
    --         if type(skill[key]) == "table" then
    --             tempSkill[key] = {}
    --             table.merge(tempSkill[key],skill[key])
    --             for i,value in ipairs(tempSkill[key]) do
    --                 if attr[i+1] then
    --                     tempSkill[key][i] = (tempSkill[key][i] ) + math.floor((level-1)*attr[i+1])
    --                 else
    --                     break
    --                 end
    --             end
    --         else
    --             local lvValue = attr[2]
    --             tempSkill[key] = (tempSkill[key] ) + math.floor((level-1)*lvValue)
    --         end
    --     end
    --     tempSkill.skillLevel = level
    --     skill = tempSkill
    -- end
    -- return skill
end

function FightCfg:getBuffByLevel(id,level)
    local buff = self:getBuff(id)
    if buff.lvAttr and level then
        local tempBuff = {}
        table.merge(tempBuff,buff)
        for i,attr in ipairs(buff.lvAttr) do
            local key = attr[1]
            if type(buff[key]) == "table" then
                tempBuff[key] = {}
                table.merge(tempBuff[key],buff[key])
                for i,value in ipairs(tempBuff[key]) do
                    if attr[i+1] then
                        tempBuff[key][i] = (tempBuff[key][i] ) + math.floor((level-1)*attr[i+1])
                    else
                        break
                    end
                end
            else
                local lvValue = attr[2]
                tempBuff[key] = (tempBuff[key] ) + math.floor((level-1)*lvValue)
            end
        end
        tempBuff.buffLevel = level
        buff = tempBuff
    end
    return buff
end

--最大上阵数量
function FightCfg:getMaxMateNum(fType)
    local typeCfg = self.FIGHT_TYPE_CFG[fType]
    return typeCfg.mateNum
end

--最大人口
function FightCfg:getMaxPopulation(fType)

    return 30
end

function FightCfg:canUseSkill(fType)
    local typeCfg = self.FIGHT_TYPE_CFG[fType]
    return typeCfg.useSkill
end

function FightCfg:isAutoProduct(fType)
    return self.FIGHT_TYPE_CFG[fType].autoProduct
end

--不同类型不同时间
function FightCfg:getFightTime(fightType)
    local typeCfg = self.FIGHT_TYPE_CFG[fightType]
    return typeCfg.fightTime
end

function FightCfg:isDungeonFight(fType)
    return self.FIGHT_TYPE_CFG[fType].isDungeonFight
end

function FightCfg:getSceneBg(sceneId)
    local cfg = self:getSceneCfg(sceneId)
    -- local res = cfg.res
    -- if device.isLowApp then
    --     local arr = {"fightMap1","fightMap2"}
    --     if table.indexOf(arr,res) == -1  then
    --         res = arr[math.random(1,2)]
    --     end
    -- end
    return cfg.res
end

function FightCfg:getRefreshTotalPop(cfg)
    local pop = 0
    local addPop = function(id,num)
        local monster = MonsterCfg:getMonster(id)
        if monster then
            pop = pop + monster.populace * (num or 1)
        end
    end
    if cfg.initMonster then
        for i,info in ipairs(cfg.initMonster) do
            addPop(info[1],1)
        end
    end
    if cfg.refreshMonster then
        for i,info in ipairs(cfg.refreshMonster) do
            addPop(info[2],info[3])
        end
    end
    if cfg.posRefreshMonster then
        for i,info in ipairs(cfg.posRefreshMonster) do
            if info[5] then
                for i,mInfo in ipairs(info[5]) do
                    addPop(mInfo[2],mInfo[3])
                end
            end
        end
    end
    if cfg.roundRefreshMonster then
        for i,info in ipairs(cfg.roundRefreshMonster) do
            for i,mInfo in ipairs(info) do
                addPop(mInfo[1],mInfo[2])
            end
        end
    end
    if cfg.protectEnemyMonster then
        for i,info in ipairs(cfg.protectEnemyMonster) do
            addPop(info[1],1)
        end
    end
    return pop
end

function FightCfg:getMonsterByRefreshCfg(cfg,noBuild)
    local monsterList = {}
    local numList = {}
    local function addMonster(mId,num)
        if not numList[mId] then
            local mInfo = MonsterCfg:getMonster(mId)
            if noBuild and (mInfo.heroType == 1 or not mInfo.head) then
                return
            end
            monsterList[#monsterList+1] = MonsterCfg:getMonster(mId)
            numList[mId] = num
        else
            numList[mId] = numList[mId] + num
        end
    end
    if cfg.initMonster then
        for i,info in ipairs(cfg.initMonster) do
            addMonster(info[1],1)
        end
    end
    if cfg.refreshMonster then
        for i,info in ipairs(cfg.refreshMonster) do
            addMonster(info[2],info[3])
        end
    end
    if cfg.posRefreshMonster then
        for i,info in ipairs(cfg.posRefreshMonster) do
            if info[5] then
                for i,mInfo in ipairs(info[5]) do
                    addMonster(mInfo[2],mInfo[3])
                end
            end
        end
    end
    if cfg.roundRefreshMonster then
        for i,info in ipairs(cfg.roundRefreshMonster) do
            for i,mInfo in ipairs(info) do
                addMonster(mInfo[1],mInfo[2])
            end
        end
    end
    if cfg.protectEnemyMonster then
        for i,info in ipairs(cfg.protectEnemyMonster) do
            addMonster(info[1],1)
        end
    end
    return monsterList,numList
end

function FightCfg:isServerFight(fType)
    local typeCfg = self.FIGHT_TYPE_CFG[fType]
    return typeCfg.isServerFight
end

function FightCfg:getSceneGlobalMagic(sceneId)
    local cfg = self:getSceneCfg(sceneId)
    return cfg.globalMagic
end

function FightCfg:getSceneLocalMagic(sceneId)
    local cfg = self:getSceneCfg(sceneId)
    return cfg.localMagic
end

function FightCfg:getSceneCfg(id)
    return self._sceneCfg[id]
end

function FightCfg:getSceneMagic(id)
    local mList = {}
    local globalMagic = self:getSceneGlobalMagic(id)
    if globalMagic then
        mList[#mList+1] = globalMagic
    end
    local localMagic = self:getSceneLocalMagic(id)
    if localMagic then
        for i,info in ipairs(localMagic) do
            mList[#mList+1] = info[1]
        end
    end
    return mList
end

function FightCfg:getAvatarSize(res)
    local aInfo = AnimationMgr:getAnimaInfo(res)
    local action = AnimationMgr:getActionInfo(res,GameConst.STAND_ACTION.."_"..1)
    local size = aInfo:getFrameSize(action.startFrame)
    return size
end

function FightCfg:getLightRes(res)
    return "light/"..res..".pvr.ccz"
end

function FightCfg:getSkillBaseLevel(index)
    return self.SKILL_LEVEL_LIST[index] or 0
end

function FightCfg:getFightModeCfg(id)
    return DungeonCfg:getFightTypeCfg(id)
end

--获取佣兵的唯一id
function FightCfg:getMercUID(roleId,heroId)
    return util.toFloatString(roleId).."a"..heroId
end

--获取 地图背景音乐
function FightCfg:getBgSound(sId)
    -- local cfg = self:getSceneCfg(sId)
    -- if cfg and cfg.sound then
    --     return cfg.sound
    -- end
    return AudioConst.FIGHT_ID
end

function FightCfg:getDungeonFightType(dungeonId)
    local dungeonType = DungeonCfg:getDungeonType( dungeonId )
    if dungeonType == DungeonCfg.GUILD_DUNGEON then
        return self.GUILD_DUNGEON_FIGHT
    else
        return self.DUNGEON_FIGHT
    end
end

return FightCfg.new()
