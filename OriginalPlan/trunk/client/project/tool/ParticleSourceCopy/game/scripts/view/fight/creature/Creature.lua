--
-- Author: wdx
-- Date: 2014-04-15 10:02:10
--

local CTitle = require("view.fight.creature.CTitle")

local Creature = class("Creature",function()
									return display.newNode()
									end)

Creature.WIDTH = 80
Creature.HEIGHT = 150

Creature.STAND_ACTION = "stand"
Creature.ATTACK_ACTION = "atk"
Creature.MOVE_ACTION = "move"
Creature.HURT_ACTION = "hurt"
Creature.DIE_ACTION = "die"
Creature.MAGIC_ACTION = "magic"
Creature.WIN_ACTION = "win"

Creature.RIGHT_DOWN = 11
Creature.LEFT_DOWN = 12
Creature.RIGHT_UP = 21
Creature.LEFT_UP = 22

Creature.U_ID = 1

function Creature:ctor(info)
	self.av = Avatar:create()
	self.av:retain()
	self:addChild(self.av)

	self.cTitle = CTitle.new()
	self.cTitle:setPosition(0,100)
	self.cTitle:retain()
	self:addChild(self.cTitle)

	self._skillCount = 0
	self.mx = 1
	self.my = 1

	self:setDirection(Creature.RIGHT_UP)

	self:init(info)
	
	self.isWin = false
end

function Creature:init(info)
	self.id = Creature.U_ID
	Creature.U_ID = Creature.U_ID + 1
	
	self.cInfo = info
	self.av:initWithResName(info.res)
	self.buffList = {}  --buff列表

	self.cInfo.speed = Formula:transformSpeed(self.cInfo.speed)  --换算成真正的时间
	self.cInfo.speedX = FightMap.COS * self.cInfo.speed
	self.cInfo.speedY = FightMap.SIN * self.cInfo.speed

	--info.atkRange = {3,3, 4,3}
	self.warnRange = Range.new(info.atkRange)  --警戒范围
	self.atkRange = Range.new(info.atkRange)  --攻击范围

	if info.ai == AI.DEFEND then
		self.searchRange = Range.new(info.atkRange)  --搜索范围
	else
		self.searchRange = Range.new(info.atkRange)  --搜索范围
	end

	info.skills = {1}

	self.cTitle:init(info)
end

function Creature:addSkillCount()
	self._skillCount = self._skillCount + 1
end

function Creature:removeSkillCount()
	self._skillCount = self._skillCount - 1
end

function Creature:getSkillCount()
	return self._skillCount
end

--每帧执行
-- 主要是在没使用技能 的时候  播放待机动作
function Creature:run(dt)
	if self._skillCount == 0 then  --当前没有技能控制  播放默认待机动作

		local status = self:getStatus()

		if status == 1 then  --假如是冰冻状态  或者是什么然角色动不了的状态   不播放待机动画  而且停留在某一帧上
			if self.curFrame ~= 1 then
				self.curFrame = 1
				self:showAnimateFrame(1,Creature.STAND_ACTION)  --停留在某一帧上
			end
			return 
		elseif status == -1 then
			--死亡的时候就不run了

			return
		end
		
		self.curTime = self.curTime + dt

		
	end
end

function Creature:playAnimate(aName,times)
	times = times or 1
	self.av:playAnimate(aName,times)
end

--改变属性
function Creature:changeValue(tType,value)
	if self.isWin then return end
		if tType == "hp" then  --血量变化
			self.cInfo.hp = self.cInfo.hp + value
			self.cTitle:setBlood(self.cInfo.hp,self.cInfo.maxHp)
			--这里要飘血

			if self.cInfo.hp <=0 then  --死了
				self:_die()
			end

		elseif tType == "atk" then  --物攻变化  
			self.cInfo.atk = self.cInfo.atk + value

			--需要什么效果也加在这里

		elseif tType == "add_buff" then  --添加buff
			self:addBuff(value)
		elseif tType == "remove_buff" then  --移除buff
			self:removeBuff(value)

		else  --还有其他一些都加在这里
			
		end
end

function Creature:addBuff( value )
	if self.buffList[value] then
		return
	end
	local bInfo = FightCfg:getBuffCfg(value)
	if bInfo and bInfo.magic then
		--根据buff 配置  是否需要给给玩家  身上添加一个 magic 特效
		local magic = FightEngine:createMagic(self.cInfo.id,bInfo.magic,{})
		FightEngine:addMagic(magic)
		self.buffList[value] = magic
	else
		self.buffList[value] = value
	end
end

function Creature:removeBuff( value )
	local magic = self.buffList[value]
	if magic and type(magic) ~= "number" then
		FightEngine:removeMagic(magic)
	end
	self.buffList[value] = nil
end

-- 这里可以根据 buff 啊  血量啊  返回当前状态  
function Creature:getStatus()
	
	-- if self.cInfo.hp <= 0 then
	-- 	return -1   ---1表示死亡
	-- else
	-- 	for i,bId in ipairs(self.buffList) do   --遍历buff进行一些 状态判断

	-- 	end
	-- end

	return -1
end

function Creature:getAvatar()
	return self.av
end

function Creature:setDirection( direction)
	if self.direction ~= direction then
		self.direction = direction
		if direction%10 == 1 then
			self.av:setScaleX(1)
		else
			self.av:setScaleX(-1)
		end
	end
end

function Creature:getDirection()
	return self.direction
end

function Creature:getVerticalDirection()
	return math.floor(self.direction/10)
end

function Creature:getHorizontalDirection()
	return self.direction%10
end

--直接显示某一动作的某一帧
function Creature:showAnimateFrame( frame,action,direction)
	--direction = 11
	if direction then
		self:setDirection(direction)
	end
	--if action ~= Creature.ATTACK_ACTION then
		--print("creature", action)
	--end
	self.av:showAnimateFrame(frame,action.."_"..self:getVerticalDirection())
end


--获取 某个动作  有多少帧
function Creature:getAnimaFrameCount(action)
	local aInfo = ResMgr:getActionInfo(self.cInfo.res,action .."_1")
	if aInfo then
		return aInfo:getFrameLength()
	else
	 	return 0
	end 
end

function Creature:getSpeed()
	return self.cInfo.speed
end

function Creature:getSpeedXY(  )
	return self.cInfo.speedX,self.cInfo.speedY
end

function Creature:isDie()
	if self.cInfo.hp <= 0 then
		return true
	else
		return false
	end
end

function Creature:_die( )
	self.av:removeFromParent()
	if self._dieImage == nil then
		self._dieImage = display.newSprite("ui/die.png")
		self._dieImage:setAnchorPoint(ccp(0.5,0))
		self:addChild(self._dieImage)
	end
	if FightDirector:getMap():getTileContent(self.mx,self.my) == self.id then
		FightDirector:getMap():setTileContent(self.mx,self.my,FightMap.NONE)
	end
	FightEngine:stopCreatureSkill(self)
	FightDirector:checkFightOver(self)  --检测战斗是否结束了
end

function Creature:win()
	self.isWin = true
end

return Creature