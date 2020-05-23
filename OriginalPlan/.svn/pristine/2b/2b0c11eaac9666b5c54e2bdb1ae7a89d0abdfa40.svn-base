--[[
	class:		WMArmyElemNode
	desc:
	author:		郑智敏
--]]
-- local WMInfoUilt = game_require('model.wilderness.map.WMInfoUilt')
local WMElemBase = game_require('view.world.map.mapElem.WMElemBase')
local WMArmyElemNode = class('WMArmyElemNode', WMElemBase)

-----------------------------------------------

function WMArmyElemNode:ctor( map )
	-- body
	WMElemBase.ctor(self , map)

	self._effectList = {}
	self:_initUI()
	print("aaaaaaaaaaaaa add army")
	self._map:getblockOriginNode(  ):addChild(self,5)
	self:setAnchorPoint(ccp(0.5,0.5))
end

function WMArmyElemNode:_initUI()
	-- body
	self.pic = display.newXSprite()
	self:addChild(self.pic)

	self._nameText = ui.newTTFLabelWithOutline({size=19,text=""})
	self._nameText:setAnchorPoint(ccp(0.5,0))
	self._nameText:setPositionY(65)
	self:addChild(self._nameText)

	self._mineText = ui.newTTFLabelWithOutline({size=19,text=""})
	self._mineText:setAnchorPoint(ccp(0.5,0))
	self._mineText:setPositionY(-10)
	self:addChild(self._mineText)
end

function WMArmyElemNode:updateInfo( info )
	-- body
	self:initInfo(info)
end

function WMArmyElemNode:initInfo( info )
	-- body
	self:_clearEffect()
	self:setVisible(true)

	self._info = info
	local textColorString = nil
	local color = WorldCfg:getColorByRelationShip(info.data.wildernessPlayerInfo.relationShip)
	self._nameText:setColor(color)

	if info.data.wildernessPlayerInfo.relationShip ~= 1 then
		local str = ""
		if info.data.wildernessPlayerInfo.union_name ~= "" then
			str = "["..info.data.wildernessPlayerInfo.union_name.."]\n"
		end
		str = str.."Lv."..info.data.wildernessPlayerInfo.role_level..info.data.wildernessPlayerInfo.name
		self._nameText:setString(str)
	end
	if info.data.wildernessPlayerInfo.relationShip == 3 then
		self.pic:setSpriteImage('#yw_h_r1.png')
	elseif info.data.wildernessPlayerInfo.relationShip == 2 then
		self.pic:setSpriteImage('#yw_h_b1.png')
	else
		self.pic:setSpriteImage('#yw_h_b1.png')
		self._nameText:setString(string.format('部队%d',info.data.index))
		if not self._playMiningTimer then
			self._playMiningTimer = scheduler.scheduleGlobal(function() self:_playMining() end, 1)
		end
	end
	self._nameText:setContentSize(self._nameText:getContentSize())
	if 0 < #(info.data.miningInfoList) then
		local speed = 0
		for _,v in ipairs(info.data.miningInfoList) do
			speed = speed + v.speed
		end
		if speed > 0 then
			self._miningTextIndex = 0
			if not self._showMiningTextTimer then
				self._showMiningTextTimer = scheduler.scheduleGlobal(function() self:_showMiningText() end, 1)
			end
		else
			self._mineText:setString("")
			if self._showMiningTextTimer then
				scheduler.unscheduleGlobal(self._showMiningTextTimer)
				self._showMiningTextTimer = nil
			end
		end
	end

    local hpRate = info.data.now_populace/info.data.max_populace
	if hpRate <= 0.6 then
		if hpRate <= 0.3 then
			self:_showHurtMagic(true,9,0,0)
		else
			self:_showHurtMagic(true,8,0,20)
		end
	else
		self:_showHurtMagic(false)
	end

	self:_setJointEffect()
end

function WMArmyElemNode:_showHurtMagic(flag,mId,x,y)
	if flag then
		if not self._hurtMagic then
			self._hurtMagic = SimpleMagic.new(mId)
			self._hurtMagic:setMagicType(2)
			self._hurtMagic:setPosition(x,y)
			self:addChild(self._hurtMagic)
		end
	else
		if self._hurtMagic then
			self._hurtMagic:dispose()
			self._hurtMagic = nil
		end
	end
end

WMArmyElemNode.MINING_EFFECT_TABLE = {
	[-1] = {
		[-1] = {id = 121, xScale = 1, yScale = 1,},
		[0] = {id = 122, xScale = -1, yScale = -1,},
		[1] = {id = 120, xScale = -1, yScale = 1,},
	},
	[0] = {
		[-1] = {id = 123, xScale = -1, yScale = -1,},
		[1] = {id = 123, xScale = 1, yScale = 1,},
	},
	[1] = {
		[-1] = {id = 120, xScale = 1, yScale = 1,},
		[0] = {id = 122, xScale = 1, yScale = 1,},
		[1] = {id = 121, xScale = 1, yScale = -1,},
	},
}

function WMArmyElemNode:_setJointEffect()
	local idAdd = 0
	if self._info.data.wildernessPlayerInfo.relationShip ~= 3 then
		idAdd = 4
	end

	local miniList = self._info.data.miningInfoList
	if #miniList > 1 then
		local curPos = self._info.startPos
		for i,mini in ipairs(miniList) do
			if mini.beginTime > 0 then
				local pos =  mini.wildernessPos
				local xAdd,yAdd = pos.x - curPos.x, pos.y - curPos.y
				if (xAdd ~= 0 or yAdd ~= 0) and math.abs(xAdd) < 2 and math.abs(yAdd) < 2 then
					local effect = SimpleMagic.new(self.MINING_EFFECT_TABLE[xAdd][yAdd].id + idAdd,-1,nil,false)
					effect:setScaleX(self.MINING_EFFECT_TABLE[xAdd][yAdd].xScale)
					effect:setScaleY(self.MINING_EFFECT_TABLE[xAdd][yAdd].yScale)
					self:addChild(effect)

					self._effectList[#self._effectList + 1] = effect
				end
			end
		end
	end
	-- self.checkEffectX()
	-- self.checkEffectY()
end

function WMArmyElemNode:_clearEffect()
	-- body
	for _,v in ipairs(self._effectList) do
		v:dispose()
	end
	self._effectList = {}
end

WMArmyElemNode.TYPE_PIC_PATH_TABLE = {
	[1] = '<img src=#yw_icon_sj.png></img>',
	[2] = '<img src=#yw_icon_t.png></img>',
	[3] = '<img src=#yw_icon_y.png></img>',
}

function WMArmyElemNode:_playMining(  )
	-- body
	-- print('_playMining')
	local info = self._info
	if 0 < #(info.data.miningInfoList) then
		--[[
		local miningCount = 0
		for _,v in ipairs(info.data.miningInfoList) do
			print('v.speed ..' .. v.speed)
			miningCount = miningCount + v.speed / 60
		end
		------neend changed-----------
		local picStr = nil
		local mineInfo = WorldMapModel:getElemInfoAt( WorldMapModel.MINE, WMInfoUilt:changeWildernessPosToPos( info.data.wildernessPos ) )
		if false == mineInfo.hasElem then
			return
		end
		if 1 == mineInfo.data.type then
			picStr = '<img src=#yw_icon_sj.png></img>'
		elseif 2 == mineInfo.data.type then
			picStr = '<img src=#yw_icon_t.png></img>'
		else
			picStr = '<img src=#yw_icon_y.png></img>'
		end
		------------------------------
		--]]

		local textContent = ''
		local typeCountList = {[1] = 0, [2] = 0, [3] = 0}
		for _,v in ipairs(info.data.miningInfoList) do
			if TimeCenter:getTimeStamp() <= v.endTime then
				typeCountList[v.mine_type] = typeCountList[v.mine_type]	+ v.speed/60
			end
		end
		for i,v in ipairs(typeCountList) do
			if v > 0 and v < 1 then
				v = 1
			end
			if v >= 1 then
				textContent = textContent .. ' +' .. math.floor(v) .. self.TYPE_PIC_PATH_TABLE[i]
			end
		end

		local text = self:_getFloatText()
		text:setPositionY(20)
		text:setText(textContent)
		if not text:getParent() then
			self:addChild(text,3)
		end

		local moveByAction = CCMoveBy:create(0.6, ccp(0,80))
		local blankAction = CCDelayTime:create(0.4)
		text:runAction(transition.sequence({moveByAction, blankAction, nil}))
	end
end

function WMArmyElemNode:_getFloatText()
	if not self._floatText then
		self._floatText = RichText.new(300,18,18,ccc3(53,191,255),nil,RichText.ALIGN_CENTER,RichText.ALIGN_CENTER,nil,UIInfo.outline.black)
		self._floatText:setAnchorPoint(ccp(0.5,0.5))
	end
	return self._floatText
end

function WMArmyElemNode:_clearFloatText(  )
	if self._floatText then
		self._floatText:dispose()
		self._floatText = nil
	end
end

function WMArmyElemNode:_showMiningText(  )
	-- body
	local text = '开采中'
	for i = 1,self._miningTextIndex,1 do
		text = text .. '.'
	end
	self._mineText:setString(text)
	self._mineText:setContentSize(self._mineText:getContentSize())
	self._miningTextIndex = (self._miningTextIndex + 1)%4
end

function WMArmyElemNode:getBlockPosRange(  )
	-- body
	return ccp(self._info.startPos.x, self._info.startPos.y), ccp(self._info.endPos.x , self._info.endPos.y)
end

function WMArmyElemNode:clear(  )
	-- body
	self:setVisible(false)
	self:_showHurtMagic(false)
	self:_clearEffect()
	self:_clearFloatText()
	if self._playMiningTimer then
		scheduler.unscheduleGlobal(self._playMiningTimer)
		self._playMiningTimer = nil
	end
	if self._showMiningTextTimer then
		scheduler.unscheduleGlobal(self._showMiningTextTimer)
		self._showMiningTextTimer = nil
	end
end

function WMArmyElemNode:dispose()
	self:_clearFloatText()
	self:_clearEffect()
	self:_showHurtMagic(false)
	if self._playMiningTimer then
		scheduler.unscheduleGlobal(self._playMiningTimer)
		self._playMiningTimer = nil
	end
	if self._showMiningTextTimer then
		scheduler.unscheduleGlobal(self._showMiningTextTimer)
		self._showMiningTextTimer = nil
	end
	WMElemBase.dispose(self)
end

return WMArmyElemNode