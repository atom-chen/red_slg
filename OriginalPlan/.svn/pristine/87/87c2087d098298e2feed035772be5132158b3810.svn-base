
local DropBoxDelegate = class("DropBoxDelegate")

function DropBoxDelegate:ctor(panel)
	self.panel = panel
	self:init(panel:getPriority())
	FightTrigger:addEventListener(FightTrigger.ADD_DROP_ITEM,{self,self._onAddDropItem})
end

function DropBoxDelegate:init()
	self.curItemNum = 0
	self.totoalDropNum = 0
	FightTrigger:addEventListener(FightTrigger.CREATURE_DIE, {self,self._onCreatureDie},-1)
	self.boxList={}
end

function DropBoxDelegate:start()
	self.curItemNum = 0
	self.totoalDropNum = 0
	local reward = {}--FightModel:getFightReward()
	if reward and reward.drops then
		for i,dropInfo in ipairs(reward.drops) do
			local itemList = dropInfo.items
			for j,item in ipairs(itemList) do
				self.totoalDropNum = self.totoalDropNum + item.itemNum
			end
		end
	end
	self._isDrop = true
end

function DropBoxDelegate:stopDropBox(totalCoin)
	self._isDrop = false
	self.totalCoin = totalCoin
end

function DropBoxDelegate:_onAddDropItem(event)
	if event.coin then --掉钱
		self:addCoinBox(event.num,event.coin,event.x,event.y)
	else
		self:addNewBox(event.itemList,event.x,event.y)
	end
end

function DropBoxDelegate:_onCreatureDie(event)
	if not self._isDrop then
		return
	end
	local creature = event.creature
	-- print("  死亡",creature.cInfo.name)
	if creature.cInfo.team == FightCommon.enemy then
		local reward = {}--FightModel:getFightReward()
		if not reward then
			return
		end
		local curRate = self:_getCurDieRate()

		local dropList = {}
		if self.totoalDropNum > 0 then
			local newItemNum = math.floor(self.totoalDropNum*curRate)
			local dropNum = newItemNum - self.curItemNum
			if dropNum > 0 and reward then
				dropList = self:_getDropItemList(reward,dropNum)
			end
			self.curItemNum = newItemNum
		end
		local drop = {}--FightModel:getMonsterDrop(creature.cInfo.id)
		if drop then  --有掉落
			if FightDirector.fightInfo.info and FightDirector.fightInfo.info.id then
				DungeonProxy:repKillMonster(FightDirector.fightInfo.info.id,creature.cInfo.id)  --通知服务杀死怪物了
			end
			for i,item in ipairs(drop) do
				dropList[#dropList + 1] = item.itemID
			end
		end
		self:addNewBox(dropList,creature:getPosition())

		if reward.coin then
			local curCoin = math.floor(reward.coin*curRate)
			print("--多少。。。",curCoin)
			self.panel.ui.title:setCoin(curCoin)
		end

	end
end

function DropBoxDelegate:_getDropItemList(reward,dropNum)
	local dropList = {}
	local num = self.curItemNum
	for i,dropInfo in ipairs(reward.drops) do
		local itemList = dropInfo.items
		for j,item in ipairs(itemList) do
			num = num - item.itemNum
			if num < 0 then
				local addNum = math.min(math.abs(num),dropNum)
				for i=1, addNum do
					dropList[#dropList + 1] = item.itemID
					dropNum = dropNum - 1
				end
				num = 0
				if dropNum <= 0 then
					return dropList
				end
			end
		end
	end
	return dropList
end

function DropBoxDelegate:_getCurDieRate()
	local enemyList = FightDirector:getScene():getTeamList(FightCommon.enemy)
	local total = 0
	local dieNum = 0
	for i,enemy in ipairs(enemyList) do
		if enemy.cInfo.heroyTpe ~= 1 or enemy.cInfo.skillTurn or enemy.isHQ  then
			total = total + 1
			if enemy:isDie(true) then
				dieNum = dieNum + 1
			end
		end
	end
	if total == 0 then return 1 end
	return dieNum/total
end

function DropBoxDelegate:addCoinBox(num,coin,x,y)
	for i=1,num do
		local box = display.newXSprite("#fight_img_hj.png")
		box:retain()
		box:setPosition(x,y)
		FightDirector:getScene():addChild(box)
		box.coin = coin
		self:_boxTween(box,x,y)
	end
end

function DropBoxDelegate:addNewBox(itemList,x,y)
	for i,itemId in ipairs(itemList) do
		if not ItemCfg:getCfg(itemId) then
			if device.platform == "windows" then
				StatSender:sendBug( "no item cfg  itemId:  "..(itemId or "nil"))
			end
			return
		end

		local resList = {"#com_lbaox.png","#com_hbaox.png","#com_zbaox.png"}
		local box = UIItemGrid.new()
		box:setItem(itemId,false)
		box.itemId = itemId
		box:setScale(0.5)
		local size = box:getContentSize()
		box:retain()
		box:setPosition(x,y)
		FightDirector:getScene():addChild(box)

		self:_boxTween(box,x,y)
	end
end

function DropBoxDelegate:_boxTween(box,x,y)
	self.boxList[#self.boxList+1] = box

	transition.moveTo(box, {x=x+math.random(-150,150),y = y,time=0.4 })

	local action = CCMoveTo:create(0.2, CCPoint(x, y+math.random(80,120)))
	action = transition.create(action,{easing="SINEOUT" })
	local action2 = CCMoveTo:create(0.2, CCPoint(x, y+math.random(-80,30)))
	action2 = transition.create(action,{easing="SINEIN" })
 	local q = transition.sequence({action,action2})

 	transition.execute(box,q)

	scheduler.performWithDelayGlobal(function()
									if table.indexOf(self.boxList,box) > 0 then
										self:pickup(box)
									end
								end,3)
end

function DropBoxDelegate:startMoveCreature(box,x,y)

end

--
function DropBoxDelegate:moveCreature(box,x,y)

end

function DropBoxDelegate:endMoveCreature(box,x,y)

end

function DropBoxDelegate:clickCreature(box,x,y)
	self:pickup(box)
end

function DropBoxDelegate:pickup( box)
	-- box:removeAllChildren()
	local flyBox
	local tweenX
	if box.itemId then
		local itemId = box.itemId
		flyBox = UIItemGrid.new()
		flyBox:setScale(0.5)
		flyBox:setItem(itemId,false)
		tweenX = display.width - 180
	else
		flyBox = display.newXSprite("#fight_img_hj.png")
		tweenX = display.width - 280
	end
	local p  = box:convertToWorldSpace(ccp(0,0))
	flyBox:retain()
	flyBox:setPosition(p.x,p.y)
	self.panel:addChild(flyBox)
	UIAction.setMoveTo(flyBox ,tweenX, display.height - 30, 0.8,function() flyBox:removeFromParent() end)

	local coin = box.coin
	scheduler.performWithDelayGlobal(function()
		if flyBox.dispose then
			flyBox:dispose()
		end
		flyBox:release()
		self:onBoxMoveEnd(1,coin)
	end, 0.8)

	self:_removeBox(box)
end

function DropBoxDelegate:onBoxMoveEnd(boxNum,coin)
	-- self:_removeBox(box)
	if self.panel:isRunning() then
		if coin then
			local cur = self.panel.ui.title:getCoin()
			if coin + cur > self.totalCoin then
				coin = self.totalCoin - cur
			end
			self.panel.ui.title:addCoin(coin)
		else
			self.panel.ui.title:addBox(boxNum)
		end
	end
end

function DropBoxDelegate:pickupAll()
	for i,box in ipairs(self.boxList) do
		if box:getParent() ~= self.panel then
			self:pickup(box)
		end
	end
end

function DropBoxDelegate:_removeBox(box)
	for i,b in ipairs(self.boxList) do
		if b == box then
			table.remove(self.boxList,i)
			box:removeFromParent()
			if box.dispose then
				box:dispose()
			end
			box:release()
		end
	end
end

function DropBoxDelegate:clear()
	for i,box in ipairs(self.boxList) do
		box:removeFromParent()
		box:dispose()
		box:release()
	end
	self.boxList={}
	self.curItemNum = 0
end

return DropBoxDelegate