--
-- Author: wdx
-- Date: 2014-08-07 17:08:59
--
local HeroEquipControl = game_require('view.common.HeroEquipControl')

local ComInfoTips = game_require("view.common.ComInfoTips")
local ComInfoTips_1 = game_require("view.common.ComInfoTips_1")
local SimpleTips = game_require('view.common.SimpleTips')
ShowInfoTipExtend = {}


--有需求可以自己在类型    然后在 下面的 _onShowTipView 方法中加
ShowInfoTipExtend.ITEM = "item"
ShowInfoTipExtend.MONTER = "monster"
ShowInfoTipExtend.HERO = "HERO"
ShowInfoTipExtend.ITEM_WITH_HERO = 'item_with_hero'
ShowInfoTipExtend.GOLD = "gold"
ShowInfoTipExtend.COIN = "coin"
ShowInfoTipExtend.ROLE_SKILL_POINT = "role_skill_point"
ShowInfoTipExtend.SIMPLETIP = "SIMPLETIP"
ShowInfoTipExtend.OTHER_ITEM = "other_item"
ShowInfoTipExtend.COINFIG_ITEM = "config_item"
ShowInfoTipExtend.TEXT_CONTENT = "text_content"
ShowInfoTipExtend.WILD_ITEM = "wild_item"
ShowInfoTipExtend.FUNC = "func"
ShowInfoTipExtend.DRAG = "drag"

function ShowInfoTipExtend.extend(target)
	target:touchEnabled(true)

    function target:setShowTipId(type,value)
		--dump(type)
		--dump(value)
		self._showTipType = type
		self._showTipValue = value
	end



	function target:onTouchDown(x,y)
		self._downX,self._downY = x,y
	    if self._showTipTimer == nil then
	  	  	self._showTipTimer = scheduler.performWithDelayGlobal(function() self:_onShowTipView() end,0.1)
	    end
	    return true
	end

	function target:_onShowTipView()
		self._showTipTimer = nil
		local size = self:getContentSize()
		local pos = self:convertToWorldSpace(ccp(0,0))
		print(pos.x, pos.y)
		local sw,sh = 430,200-- tips width,height
		local x,y = pos.x + size.width/2-100,pos.y+size.height+sh -- 400 200
		-- print("target:_onShowTipView()", x,y, self._showTipType,display.width)
		-- print("x + sw=:",x + sw)
		if x + sw > display.width then
			x = display.width - sw
		elseif x <= 0 then
			x = 10
		end
		-- [[
		if y > display.height then
			y = pos.y
			  x = pos.x - sw
			  if x <= 0 then
			  	x = pos.x + size.width
			  end
		end
		--]]
		if self._showTipType == ShowInfoTipExtend.ITEM then
			self._simpleTips = ComInfoTips.new()
			self._simpleTips:setItem(self._showTipValue,x,y)
			-- ElemInfoControl:showItemInfo(self._showTipValue,x,y)

		elseif self._showTipType == ShowInfoTipExtend.MONSTER then
			ElemInfoControl:showMonsterInfo(self._showTipValue,x,y)
		elseif self._showTipType == ShowInfoTipExtend.HERO then
			ElemInfoControl:showHeroInfo(self._showTipValue,x,y)
		elseif self._showTipType == ShowInfoTipExtend.ITEM_WITH_HERO then
			self._heroEquipList = HeroEquipControl:getHeroListForItem(self._showTipValue, false)
			if 0 == #self._heroEquipList then
				self._heroEquipList = nil
			end

			ElemInfoControl:showItemInfo(self._showTipValue,x,y,self._heroEquipList)
		elseif self._showTipType == ShowInfoTipExtend.GOLD then
			self._simpleTips = SimpleTips.new(nil, 330)
			self._simpleTips:addText(LangCfg:getCommonInfoById(11))
			local gamlayer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY)
			gamlayer:addChild(self._simpleTips)
			self._simpleTips:setPosition(gamlayer:convertToNodeSpace(ccp(x-self._simpleTips:getContentWidth()/2,y)))
		elseif self._showTipType == ShowInfoTipExtend.COIN then
			self._simpleTips = SimpleTips.new(nil, 330)
			self._simpleTips:addText(LangCfg:getCommonInfoById(12))
			local gamlayer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY)
			gamlayer:addChild(self._simpleTips)
			self._simpleTips:setPosition(gamlayer:convertToNodeSpace(ccp(x-self._simpleTips:getContentWidth()/2,y)))
		elseif self._showTipType == ShowInfoTipExtend.ROLE_SKILL_POINT then
			self._simpleTips = SimpleTips.new(nil, 330)
			self._simpleTips:addText(LangCfg:getCommonInfoById(13))
			local gamlayer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY)
			gamlayer:addChild(self._simpleTips)
			self._simpleTips:setPosition(gamlayer:convertToNodeSpace(ccp(x-self._simpleTips:getContentWidth()/2,y)))
		elseif self._showTipType == ShowInfoTipExtend.SIMPLETIP then
			self._simpleTips = SimpleTips.new(nil, 330)
			self._simpleTips:addText(LangCfg:getCommonInfoById(self._showTipValue))
			local gamlayer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY)
			gamlayer:addChild(self._simpleTips)
			self._simpleTips:setPosition(gamlayer:convertToNodeSpace(ccp(x-self._simpleTips:getContentWidth()/2,y)))
		elseif self._showTipType == ShowInfoTipExtend.OTHER_ITEM then
			self._simpleTips = ComInfoTips.new()
			self._simpleTips:setMoney(self._showTipValue,x,y)
		elseif self._showTipType == ShowInfoTipExtend.COINFIG_ITEM then
			self._simpleTips = ComInfoTips.new()
			self._simpleTips:setConfig(self._showTipValue,x,y)
		elseif self._showTipType == ShowInfoTipExtend.TEXT_CONTENT then
			self._simpleTips = ComInfoTips_1.new()
			self._simpleTips:setContent(self._showTipValue,x,y)
			-- local gamlayer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY)
			-- gamlayer:addChild(self._simpleTips)
			-- self._simpleTips:setPosition(gamlayer:convertToNodeSpace(ccp(x-self._simpleTips:getContentWidth()/2,y)))
		elseif self._showTipType == ShowInfoTipExtend.WILD_ITEM then
			self._simpleTips = SimpleTips.new(nil, 330)
			self._simpleTips:addText(LangCfg:getWildernessText( -self._showTipValue ))
			local gamlayer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY)
			gamlayer:addChild(self._simpleTips)
			self._simpleTips:setPosition(gamlayer:convertToNodeSpace(ccp(x,y-80)))
		elseif self._showTipType == ShowInfoTipExtend.FUNC then
			self._showTipValue(self, true)
		elseif self._showTipType == ShowInfoTipExtend.DRAG then
			self._showTipValue(self, "begin", self._downX,self._downY)
		else
			--todo    --有需求可以自己在类型
		end
	end

	function target:onTouchMove(x,y)
		if self._showTipType == ShowInfoTipExtend.DRAG then
			self._showTipValue(self, "move", x, y)
			return
		end
		if math.abs(self._downX-x) + math.abs(self._downY -y) > 30 then
			ElemInfoControl:stopShow()
			if self._simpleTips then
				self._simpleTips:dispose()
				self._simpleTips = nil
			end
		end
	end

	function target:onTouchUp(x, y)
		if self._showTipTimer then
			scheduler.unscheduleGlobal(self._showTipTimer)
			self._showTipTimer = nil
		end
		if ElemInfoControl then
			ElemInfoControl:stopShow()
		end
		if self._simpleTips then
			self._simpleTips:dispose()
			self._simpleTips = nil
		end
		if self._showTipType == ShowInfoTipExtend.FUNC then
			self._showTipValue(target, false)
		end
		if self._showTipType == ShowInfoTipExtend.DRAG then
			self._showTipValue(self, "end", x, y)
		end
	end

	function target:onTouchCanceled()
	    self:onTouchUp()
	end

	-- function target:touchContains(x, y)
	-- 	local parent = self:getParent()
	-- 	while parent ~= nil do
	-- 		if tolua.isTypeOf(parent,"CCScrollView") then
	-- 			parent = tolua.cast(parent,"CCScrollView")
	-- 			local rect = parent:getViewRect()
	-- 			if rect:containsPoint(ccp(x,y)) then
	-- 				return true  --在可视范围内
	-- 			else
	-- 				return false   --在看不到的地方
	-- 			end
	-- 		end
	-- 		parent = parent:getParent()
	-- 	end
	-- 	local pos = parent:convertToNodeSpace(ccp(x,y))
	-- 	local rect = self:getTouchRect()
	-- 	if rect:containsPoint(pos) then
	-- 		return true
	-- 	else
	-- 		return false
	-- 	end
	-- end
end



return ShowInfoTipExtend
