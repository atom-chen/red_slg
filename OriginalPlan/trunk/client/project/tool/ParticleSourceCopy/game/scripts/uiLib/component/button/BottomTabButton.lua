--[[--
class: BottomTabButton
inherit: CCLayer
desc:	底部标签按钮
author:	hong
event:	
	
example:
	local bottomButton = BottomTabButton.new({"PARTNER", "ROLE", "RECRUIT"}, "RECRUIT")
	

	bottomButton:showBackground()	--显示蓝色占位块，供布局使用
	bottomButton:trigger(index)		--手动切换标签

	tabButton:addEventListener(Event.TAB_CHANGE,{self, self._change})
	function Panel:_change(event)	--回调方法例子
		echo("index:" .. event.index)
	end
]]

local BottomTabButton = class("BottomTabButton", function()
		return display.newLayer(false)
	end)


BottomTabButton.ICON_RES = { -- panel => res
	PARTNER = "partner",
	ROLE = "role",
	RECRUIT = "recruit",
	BAG = "bag",
	FORGE = "forge",
	NOURISH = "nourish",
	TALENT = "talent",
	HUNT_MAIN = "hunt",
	HUNT_SHOW = "star",
	HUNT_SHOP = "exchange",
	SEAT = "deploy"
}



BottomTabButton.WIDTH = 94
BottomTabButton.HEIGHT = 94

BottomTabButton.IMAGEBACKGROUND3 = "tabs_bg.png"
BottomTabButton.IMAGEBACKGROUND2 = "tabs_bg2.png"
BottomTabButton.IMAGEMASK = "#tabs_mask.png"

BottomTabButton.DISTANCE = {
	{0},
	{-BottomTabButton.WIDTH/2, BottomTabButton.WIDTH/2},
	{-BottomTabButton.WIDTH, 0, BottomTabButton.WIDTH},
}

--[[--
	构造函数
	@param panelList table 标题名列表
	@param curPanel String 当前面板
]]
function BottomTabButton:ctor(panelList, curPanel)
	self:retain()
	EventProtocol.extend(self)

	self._curPanel = curPanel 	--当前面板
	
	self.panelList = panelList	--面板名字列表
	self._maskList = {}		--遮罩对象列表
	self._buttonList = {}	--按钮对象列表
	self._onlyClickIndex = nil -- 唯一能点击的下标
	self._togglePanel = true

	--背景
	self._background = CCSprite:createWithSpriteFrameName(BottomTabButton.IMAGEBACKGROUND3)	--底部图片
	self._background:setAnchorPoint(ccp(0.5, 0))

	self._layer = display.newLayer()
	self._layer:addChild(self._background)
	self._layer:setPosition(ccp(display.cx, 0))
	self:addChild(self._layer)

	if panelList then
		self:setButtonList(panelList, curPanel)
	end

	self:setAnchorPoint(ccp(0, 0))
	self:ignoreAnchorPointForPosition(false)
end

--[[--
	设置按钮列表
	@param panelList table 标题名列表
	@param curPanel String 当前面板
]]
function BottomTabButton:setButtonList(panelList, curPanel)
	local mask = nil
	local button = nil
	local index = nil
	self.panelList = panelList

	self._curPanel = curPanel

	for k,v in ipairs(self.panelList) do
		if self._curPanel == v then 
			index = k
		end 

		if not self._buttonList[k] then --不存在,创建按钮和遮罩
			mask = display.newSprite(BottomTabButton.IMAGEMASK)
			mask:setPosition(BottomTabButton.WIDTH/2, BottomTabButton.HEIGHT/2)
			mask:setZOrder(1)
			self._maskList[k] = mask

			button = self:_initButton(v)
			button.index = k
			button:retain()
			button:addChild(mask)
			button:addEventListener(Event.MOUSE_UP,{self, self._onTouch})
			self._buttonList[k] = button
			self._layer:addChild(self._buttonList[k])
		else --已存在
			local fileName = self:_getButtonFileName(v)
			self._buttonList[k]:setButtonImages(fileName)

			if not self._buttonList[k]:getParent() then 	--重新插入已创建按钮
				self._layer:addChild(self._buttonList[k])
			end
		end

		self._buttonList[k]:setPosition(BottomTabButton.DISTANCE[#self.panelList][k], 3)
	end

	--移除多余按钮
	for i=#self.panelList + 1,#self._buttonList do
		self._layer:removeChild(self._buttonList[i])
	end

	--更换背景
	if #self.panelList == 2 then
		local frame = display.newSpriteFrame(BottomTabButton.IMAGEBACKGROUND2)
    	self._background:setDisplayFrame(frame)
	else
		local frame = display.newSpriteFrame(BottomTabButton.IMAGEBACKGROUND3)
    	self._background:setDisplayFrame(frame)
	end

	if index == nil then --没有当前面板时，移除遮罩
		for k,v in pairs(self._buttonList) do 
			self._maskList[k]:setOpacity(0)
			self._buttonList[k]:setScale(0.9)
		end
	else
		self:_refButtonList()
	end
end

--[[--
	根据下标获取底部按钮
	@param index Number 按钮下标
]]
function BottomTabButton:getButton(index)
	return self._buttonList[index]
end

--[[--
	根据面板名获取按钮资源名字
	@param panelName string 标题面板名
]]
function BottomTabButton:_getButtonFileName(panelName)
	local filename = "#tabs_" .. BottomTabButton.ICON_RES[panelName] .. "1.png"
	return filename
end

--[[--
	按钮触击判断
]]
function BottomTabButton:_onTouch(event)
	self:trigger(event.target.index)
end

--[[--
	根据面板名创建按钮
	@param panelName string 标题面板名
]]
function BottomTabButton:_initButton(panelName)
	local filename = self:_getButtonFileName(panelName)

	local button = Button.new(filename)
	button:setAnchorPoint(ccp(0.5, 0))
	button:setSwallowTouches(true)
	
	return button
end

--[[--
	刷新底部按钮
]]
function BottomTabButton:_refButtonList()
	for k,v in pairs(self._buttonList) do 
		if self.panelList[k] == self._curPanel then
			v:setScale(1)
			self._maskList[k]:setOpacity(0)
		else
			v:setScale(0.9)
			self._maskList[k]:setOpacity(255)
		end
	end
end

--[[--
	按钮切换事件
	@param index Number 下标
]]
function BottomTabButton:trigger(index)
	local panelName = self.panelList[index]
	if self._curPanel == panelName then 	--相同位置不触发
		return
	elseif not ModelMgr.isSysOpen(Panel[panelName]) then -- 系统未开放
    	float(ModelMgr.sysNotOpenTips(Panel[panelName]))
    	return
	else
		self._curPanel = panelName
	end

	self:_refButtonList()
	AudioMgr.playEffect(GameConst.EFFECT_CLICK)
	self:dispatchEvent({name = Event.TAB_CHANGE, index = index})
end

--[[--
	显示蓝色占位块，供布局使用
]]
function BottomTabButton:showBackground()
	local colorBg = CCLayerColor:create(GameConst.COLOR_PLACEHOLDER, 480, 58)
	self._layer:addChild(colorBg)
end

--[[--
	改变触摸优先级
	@param priority Number
]]
function BottomTabButton:changeTouchPriority(priority)
	for index,button in ipairs(self._buttonList) do
		button:changeTouchPriority(priority)
	end
end

function BottomTabButton:dispose()

	--从父节点移除并清理
	self:removeFromParentAndCleanup(true)

	--移除Touch监听
	self._layer:removeTouchEventListener()

	self._layer:removeAllChildren()

	self._buttonList = nil
	self._maskList = nil
	self._layer = nil

	self._curPanel = nil
	self.panelList = nil
	self._buttonList = nil

	self:release()
end

return BottomTabButton