local EditMap = class("EditMap")

function EditMap:ctor(parentUI)
	self.ui = parentUI

	local hideBtn = UIButton.new({"#com_gb.png"}, self.ui.priority,true)
	hideBtn:setPosition(0,display.height-50)
	self.ui:addChild(hideBtn,100)
	hideBtn:addEventListener(Event.MOUSE_CLICK, {self,self.onHideBtn})

	self.pText1 = ui.newTTFLabelWithOutline({})
	self.pText1:setPosition(110,display.height - 100)
	self.pText1:retain()

	self.pText2 = ui.newTTFLabelWithOutline({})
	self.pText2:setPosition(display.width-200,display.height - 100)
	self.pText2:retain()


	self.monsterText = UIEditBox.new("#fight_sdcb003.png",CCSize(150,30),self.ui.priority) --
	self.monsterText:setFont("",24)
	self.monsterText:setFontColor(ccc3(255,0,0))
	self.monsterText:setPosition(200,display.height-20)
	self.monsterText:setAnchorPoint(ccp(0,0.72))
	self.monsterText:retain()

	self.addBtn1 = UIButton.new({"#com_btn_jiah.png"}, self.ui.priority,true)
	self.addBtn1:setPosition(340,display.height-50)
	self.addBtn1:setText("己方", 20, nil, ccc3(255, 0, 0), nil, nil, nil, nil, true)
	self.addBtn1:addEventListener(Event.MOUSE_CLICK, {self,self.onAddBtn})

	self.addBtn2 = UIButton.new({"#com_btn_jiah.png"}, self.ui.priority,true)
	self.addBtn2:setPosition(400,display.height-50)
	self.addBtn2:setText("敌方", 20, nil, ccc3(255, 0, 0), nil, nil, nil, nil, true)
	self.addBtn2:addEventListener(Event.MOUSE_CLICK, {self,self.onAddBtn})

	self.addBtn3 = UIButton.new({"#com_btn_jiah.png"}, self.ui.priority,true)
	self.addBtn3:setPosition(550,display.height-50)
	self.addBtn3:setText("换副本", 20, nil, ccc3(255, 0, 0), nil, nil, nil, nil, true)
	self.addBtn3:addEventListener(Event.MOUSE_CLICK, {self,self.onChangeDungeon})

	self.addBtn4 = UIButton.new({"#com_btn_jiah.png"}, self.ui.priority,true)
	self.addBtn4:setPosition(630,display.height-50)
	self.addBtn4:setText("加怪物", 20, nil, ccc3(255, 0, 0), nil, nil, nil, nil, true)
	self.addBtn4:addEventListener(Event.MOUSE_CLICK, {self,self.onAddMonster})

	self.addBtn5 = UIButton.new({"#com_btn_jiah.png"}, self.ui.priority,true)
	self.addBtn5:setPosition(700,display.height-50)
	self.addBtn5:setText("删怪物", 20, nil, ccc3(255, 0, 0), nil, nil, nil, nil, true)
	self.addBtn5:addEventListener(Event.MOUSE_CLICK, {self,self.onDelMonster})

	self.idText = UIEditBox.new("#fight_sdcb003.png",CCSize(50,30),self.ui.priority) --
	self.idText:setFont("",24)
	self.idText:setFontColor(ccc3(255,0,0))
	self.idText:setPosition(460,display.height-20)
	self.idText:setAnchorPoint(ccp(0,0.72))
	self.idText:retain()

	self.scaleText = UIEditBox.new("#fight_sdcb003.png",CCSize(150,30),self.ui.priority) --
	self.scaleText:setFont("",24)
	self.scaleText:setFontColor(ccc3(255,0,0))
	self.scaleText:setPosition(750,display.height-20)
	self.scaleText:setAnchorPoint(ccp(0,0.72))
	self.scaleText:retain()

	self.addBtn6 = UIButton.new({"#com_btn_jiah.png"}, self.ui.priority,true)
	self.addBtn6:setPosition(870,display.height-50)
	self.addBtn6:setText("缩放", 20, nil, ccc3(255, 0, 0), nil, nil, nil, nil, true)
	self.addBtn6:addEventListener(Event.MOUSE_CLICK, {self,self.onSacle})
	self.btnList = {self.addBtn1,self.addBtn2,self.addBtn3,self.addBtn4,self.addBtn5,self.addBtn6}
	FightTrigger:addEventListener(FightTrigger.SELECT_TILE, {self,self.onSelectTile})

	FightTrigger:addEventListener(FightTrigger.POPULACE_CHANGE, {self,self.onPopulaceChange})
end

function EditMap:onPopulaceChange(e)
	self.pText1:setString(FightDirector:getPopulace(FightCommon.mate))
	self.pText2:setString(FightDirector:getPopulace(FightCommon.enemy))
end

local clickNum = 0
function EditMap:onHideBtn(e)
	FightDirector:getCamera():setAuto(false)
	-- clickNum = clickNum + 1
	-- if clickNum > 4 then
		FightDirector:pause()
	-- end
	self:onPopulaceChange()
	local map = FightDirector:getMap()
	if map:getParent() then
		map:removeFromParent()
		local str = ""
		for i=0,FightMap.TILE_MAX_W do
			local row = map.mapData[i]
			for j=0,FightMap.TILE_MAX_H do
				local tile = row[j]
				if tile:getContent() == FightMap.BLOCK then
					str = str .."{"..i..","..j.."},"
				end
			end
		end
		self:writeFile("mapData.txt", "\n\n\n\n地图不可走区域数据：\n"..str)

		str = ""
		local mateList = FightDirector:getScene():getTeamList(FightCommon.mate)
		for i,c in ipairs(mateList) do
			if c.forbidMove and not c.isHQ then
				str = str .. "{"..c.cInfo.id..","..c.mx..","..c.my
				if c.cInfo.cfgGlobalId then
					str = str .. ","..c.cInfo.cfgGlobalId
				end
				str = str.."},"
			end
		end
		self:writeFile("mapData.txt", "\n 初始化己方怪物配置：\n"..str)


		str = ""
		local enemyList = FightDirector:getScene():getTeamList(FightCommon.enemy)
		for i,c in ipairs(enemyList) do
			if c.forbidMove and not c.isHQ  then
				str = str .. "{"..c.cInfo.id..","..c.mx..","..c.my
				if c.cInfo.cfgGlobalId then
					str = str .. ","..c.cInfo.cfgGlobalId
				end
				str = str.."},"
			end
		end
		self:writeFile("mapData.txt", "\n 初始化敌人怪物配置：\n"..str)

		self.monsterText:removeFromParent()
		self.idText:removeFromParent()
		self.pText1:removeFromParent()
		self.pText2:removeFromParent()
		self.scaleText:removeFromParent()

		for i,btn in ipairs(self.btnList) do
			btn:removeFromParent()
		end
	else
		FightDirector:getScene():addChild(map,0)
		-- self.ui.supportBtn:removeFromParent()

		self.ui:addChild(self.monsterText,100)
		self.ui:addChild(self.idText,200)

		self.ui:addChild(self.pText1)   --文本
		self.ui:addChild(self.pText2)   --文本
		self.ui:addChild(self.scaleText)

		for i,btn in ipairs(self.btnList) do
			self.ui:addChild(btn,200)
		end

--		local panel = ViewMgr:getPanel(Panel.FIGHT)
--		panel.ui.title:removeFromParent()
		--panel.ui.fightBottom:removeFromParent()
	end
end

function EditMap:writeFile(path, content, mode)
    mode = mode or "a+b+"
    local file,err = io.open(path, mode)
    if file then
        local flag,err = file:write(content)
        io.close(file)
        return flag,err
    else
        return false,err
    end
end

function EditMap:onSacle()
	local str = self.scaleText:getText()
	local scale = tonumber(str)
	if not scale then
		print("please in put num !")
		return
	end
	self.last_scale = FightDirector:getScene():getSceneScale()
	FightDirector:getCamera():setSceneCenter()
	local minX,minY,maxX,maxY = FightDirector:getScene():getMaxRect()
	local centerX,centerY=(maxX+minX)/2,(maxY+minY)/2
	FightDirector:getCamera():setSceneScale( scale,centerX,centerY,true)
	FightDirector:getScene():updateElemVisible( true )
end

function EditMap:onAddMonster()
	print("EditMap:onAddMonster,00000")
	local str = self.monsterText:getText()
	local idArr = string.split(str, ",")
	if self.scrollList == nil then
		self.scrollList = ScrollList.new(ScrollView.HORIZONTAL,display.width,80,-100001,0)
		self.ui:addChild(self.scrollList)
		self.selectFrame = display.newXSprite("#task_hd.png")
		self.selectFrame:setAnchorPoint(ccp(0,0))
		self.selectFrame:retain()
	else
		self.scrollList:clear(true)
	end
	print("EditMap:onAddMonster,11111",#idArr)
	if #idArr == 2 then
		local beginId = tonumber(idArr[1])
		local endId = tonumber(idArr[2])
		print("EditMap:onAddMonster,22222",beginId,endId)
		for i=beginId,endId do
			if MonsterCfg:hasMonster(i) then
				local mInfo = MonsterCfg:getMonster(i)
				local headId = mInfo.head or 101001
				local res = ResCfg:getRes(headId, ".pvr.ccz")
				print("EditMap:onAddMonster,3333",headId,res)
				local btn = UIButton.new({res},-100000)
				btn:setSize(CCSize(100,80))
				btn.mId = i
				btn:setText(mInfo.name)
				btn:addEventListener(Event.MOUSE_CLICK, {self,self._onClickMonster})
				self.scrollList:addCell(btn)
			end
		end
	end
end

function EditMap:onDelMonster()
	if self.curEditTile then
		local mx,my = self.curEditTile.mx,self.curEditTile.my
		local gId = FightDirector:getMap():getTileContent(mx,my)
		local c = FightDirector:getScene():getCreature(gId)
		if c then
			self:removeCreature(c)
		end
	end
end

function EditMap:_onClickMonster(event)
	local btn = event.target
	self.curBtn = btn
	self.selectFrame:removeFromParent()
	btn:addChild(self.selectFrame)
end

function EditMap:unSelectBtn()
	self.curBtn = nil
	self.selectFrame:removeFromParent()
end

function EditMap:onChangeDungeon(event)
	local curId = tonumber(self.monsterText:getText())
	local dInfo = DungeonCfg:getDungeon(curId)
	if dInfo then
		local cList = FightDirector:getScene():getCreatureList()
		for id,c in pairs(cList) do
			FightDirector:getScene():removeCreature(c)
		end
		local refInfo = DungeonCfg:getRefreshMonster(dInfo.monsterProduct)
		FightDirector:getScene():initScene(refInfo.sceneId)

		FightDirector:resetPopulace()

		local Delegate = game_require("view.fight.delegate.RefreshMonsterDelegate")
		local d = Delegate.new()
		d:start(refInfo)
	end
end

function EditMap:onAddBtn(event)
	if self.curEditTile then
		local id = self.curEditTile:getContent()
		local curId = tonumber(self.monsterText:getText())
		local creature = FightDirector:getScene():getCreature(id)
		if creature then
			if curId ~= creature.cInfo.id then
				if curId == 0 or not curId then
					self:removeCreature(creature)
					self.idText:setText("")
					return
				end
			end
		end
		local monster = MonsterCfg:getMonster(curId)
		if not monster then
			floatText("找不到这个怪物:"..curId)
		else
			if creature and monster.scope ~= FightCfg.FLY then
				self:removeCreature(creature)
			end

			local team
			if event.target == self.addBtn1 then
				team = FightCommon.mate
			else
				team = FightCommon.enemy
			end

			local mx = self.curEditTile.mx
			local my = self.curEditTile.my
			if self:newCreature(mx,my,monster,team) then

			else

			end
		end
	end
end

function EditMap:newCreature(mx,my,monster,team)

	local map = FightDirector:getMap()
	if monster.scope ~= FightCfg.FLY then
		if map:getTileContent(mx, my) == FightMap.BLOCK then
			map:removeBlock(mx,my)
		end

		local beginPos,endPos = FightDirector:getMap():getHeroStandPos(monster,FightCommon.enemy)
		if not map:canOccupyRang(mx,my,monster.posLength) then
			mx = nil
		end
	end
	if mx then
		local monster = FightCfg:getFightMonster(monster.id)
		monster.mx = mx
		monster.my = my
		monster.team = team

		local gId = self.idText:getText()
		if gId ~= "" then
			monster.cfgGlobalId = gId
		end

		local creature = FightDirector:getScene():initCreature(monster)
		creature.forbidMove = true
		return creature
	else
		floatText("无法放置怪物  空位不够:")
		return nil
	end
end

function EditMap:removeCreature(creature)
	if creature.cInfo.occupy then
		local mx,my = creature.mx,creature.my
		for i,point in ipairs(creature.cInfo.occupy) do
			-- if FightDirector:getMap():getTileContent(mx+point[1],my+point[2]) == creature.id then
				FightDirector:getMap():setTileContent(mx+point[1],my+point[2],FightMap.NONE)
			-- end
		end
	end
	FightDirector:reducePopulace(creature.cInfo.team,creature.cInfo)
	FightDirector:getScene():removeCreature(creature)
end


function EditMap:onSelectTile(event)
	if self.curEditTile then
		self.curEditTile:setLabelColor(false)
	end
	self.curEditTile = event.tile

	if self.curEditTile then
		local mx, my = self.curEditTile.mx,self.curEditTile.my
		local map = FightDirector:getMap()
		if map:getTileContent(mx, my) == FightMap.BLOCK then
			map:removeBlock(mx,my)
		elseif map:getTile(mx,my) and map:getTileContent(mx, my) == FightMap.NONE then
			if self.curBtn then
				local mId = self.curBtn.mId
				local mInfo = FightCfg:getFightMonster(mId,FightCommon.enemy)
				self:unSelectBtn()
				if self:newCreature(mx,my,mInfo,FightCommon.enemy) then
					return
				end
			end
			map:addBlock(mx,my)
		elseif map:getTile(mx,my) and self.curBtn then
			floatText("--先删除怪物")
			return
		end

		self.curEditTile:setLabelColor(true)
		local id = self.curEditTile:getContent()
		local creature = FightDirector:getScene():getCreature(id)
		if creature then
			self.monsterText:setText(tostring(creature.cInfo.id))

			-- local list = FightDirector:getScene().elemList
			-- local index = table.indexOf(list,creature)
			-- self.idText:setText(index..creature:getZOrder())

			if creature.cInfo.cfgGlobalId then
				self.idText:setText(tostring(creature.cInfo.cfgGlobalId))
			else
				self.idText:setText("")
			end
		else
			--self.monsterText:setText("")
			self.idText:setText("")
		end
	else
		--self.monsterText:setText("")
		self.idText:setText("")
		self:unSelectBtn()
	end
end

return EditMap