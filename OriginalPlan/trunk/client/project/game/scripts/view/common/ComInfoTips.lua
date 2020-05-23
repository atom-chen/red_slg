--wdx
--2015 9 22

local ComInfoTips = class("ComInfoTips",function() return display.newNode()  end)

function ComInfoTips:ctor()
	self:retain()
	self:init()
end

function ComInfoTips:init(  )
	-- body
	self.uiNode = UINode.new()
	self.uiNode:setUI("com_info_tips")
	self:addChild(self.uiNode)
end

function ComInfoTips:setTipsPosition(x, y, height)
--[[
	if x > display.width - 400 then
		x = x - 400
	end

	y = y + height
	if y > height then
		y = y - height
	end
--]]
	self:setPosition(x,y+height-160)
end

function ComInfoTips:setBgSize( w, h )
	local bg = self.uiNode:getNodeByName("bg")
	bg:setAnchorPoint(ccp(0,1))
	local bgSize = bg:getContentSize()
	bg:setPosition(0,0)
	bgSize.height = h + 170
	bgSize.height = math.max(bgSize.height,170)
	bg:updateSize(bgSize)
end

function ComInfoTips:setItem(item,x,y)
	-- id = 43036

	if type(item) == 'number' then
		item = ItemInfo.new(item)
	end
	local grid = self.uiNode:getNodeByName("grid")
	grid:setItem(item,false)
	local cfg = ItemCfg:getCfg(item.itemId)
	local colorStr = "white"
	local name = cfg.name
	if item:isEquip() then
		colorStr = item:getQualityColorStr()
		name = string.format("<font color=%s>%s</font>", colorStr, name)
	end
	
	self.uiNode:getNodeByName("name"):setText(name)

	self.uiNode:getNodeByName("level"):setText(item:getOwner())
--ItemCfg:getEquipArmName(itemId)
	local suitName = item:getSuitName()
	local desc = self.uiNode:getNodeByName("desc")
	local str = cfg.desc or ""
	
	if suitName then
		desc:setText(string.format("<font color=white>所属套装：</font><font color=%s>%s</font>\n%s", colorStr, suitName, str))
	else
		desc:setText(str)
	end
	local w,h = desc:getTextContentSize()
--53 191 255 
	-- self:setBgSize(w,h)
	local bg = self.uiNode:getNodeByName("bg")
	bg:setAnchorPoint(ccp(0,1))
	local bgSize = bg:getContentSize()
	bg:setPosition(0,0)
	bgSize.height = h + 170
	bgSize.height = math.max(bgSize.height,170)
	bg:updateSize(bgSize)



	local layer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY_TOP)
	layer:addChild(self)
	self:setTipsPosition(x,y,bgSize.height)

end

--[[
	money= { coin = 10}
]]
function ComInfoTips:setMoney(money, x,y)
	local imgs = {coin= { image = 50002, name = '黄金', desc = 21},
		gold = {image = 50001, name = '宝石',desc = 20},
		arena = {image = 50004, name = '对抗币',desc = 17},
		renown = {image = 50009, name = '声望值',desc = 19},
		reputation = {image = 50007, name = '功勋值',desc = 18},
	}
		--gold=50001,exp=50003,arena=50004,guild=50005,live=50006,reputation=50009}
	local img
	local num = 0
	local key
	for k,v in pairs(money) do
		if imgs[k] and v > 0 then
			img = ResCfg:getRes(imgs[k].image, ".w")
			num = v
			key = k
			break
		end
	end
	if key then
		-- self.uiNode = UINode.new()
		-- self.uiNode:setUI("com_info_tips")
		-- self:addChild(self.uiNode)

		local grid = self.uiNode:getNodeByName("grid")
		grid:setImage(img, 1)
		grid:setBorder("#hero_wp_dik.png")
		self.uiNode:getNodeByName("name"):setText(imgs[key].name)
		local desc = self.uiNode:getNodeByName("desc")
		desc:setText(LangCfg:getCommonInfoById(imgs[key].desc))
		-- self.uiNode


		local w,h = desc:getTextContentSize()
		-- self:setBgSize(w,h)
		local bg = self.uiNode:getNodeByName("bg")
		bg:setAnchorPoint(ccp(0,1))
		local bgSize = bg:getContentSize()
		bg:setPosition(0,0)
		bgSize.height = h + 170
		bgSize.height = math.max(bgSize.height,170)
		bg:updateSize(bgSize)

		local layer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY_TOP)
		layer:addChild(self)

		self:setTipsPosition(x,y,bgSize.height)
	end
end

function ComInfoTips:setConfig(config,x,y)
	local grid = self.uiNode:getNodeByName("grid")
	if config.border then
		grid:setBorder(config.border)
	end
	if config.bg then
		grid:setBgImage(config.bg)
	end
	if config.icon then
		grid:setImage(config.icon)
	end
	
	self.uiNode:getNodeByName("name"):setText(config.name)

	local desc = self.uiNode:getNodeByName("desc")
	local str = config.desc
	desc:setText(str)

	local w,h = desc:getTextContentSize()

	-- self:setBgSize(w,h)
	local bg = self.uiNode:getNodeByName("bg")
	bg:setAnchorPoint(ccp(0,1))
	local bgSize = bg:getContentSize()
	bg:setPosition(0,0)
	bgSize.height = h + 170
	bgSize.height = math.max(bgSize.height,170)
	bg:updateSize(bgSize)
	local layer = ViewMgr:getGameLayer(Panel.PanelLayer.NOTIFY_TOP)
	layer:addChild(self)
	self:setTipsPosition(x,y,bgSize.height)
end

function ComInfoTips:dispose()
	if self.uiNode then
		self.uiNode:dispose()
		self.uiNode = nil
	end

	self:removeFromParent()
	self:release()
end

return ComInfoTips
