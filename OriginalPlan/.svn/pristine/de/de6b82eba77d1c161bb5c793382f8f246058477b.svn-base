--
-- Author: wdx
-- Date: 2014-06-03 10:43:02
--

local ServerListState = class("ServerListState",StateBase)
local ServerEntry = game_require("launch.gameState.ServerEntry")

function ServerListState:ctor(stateMgr)
	StateBase.ctor(self,stateMgr)
	self.clsType = StateMgr.SERVER_LIST
end


function ServerListState:init()
	-- body

	self:initBg()
	self:initUI()
end

function ServerListState:initUI()
	ResMgr:loadPvr("ui/login/login.pvr.ccz")

	self.uiNode = UINode.new(nil, false)
	self.uiNode:setUI("server_list")
	self:addChild(self.uiNode)
	self.uiNode:setPosition(ccp(display.cx, display.cy))
	self._ranglist = self.uiNode.node['scrollList']

	local myBtn = UIButton.new({"#login_xd2.png"})
	myBtn:setText("我的服务器",22,nil,ccc3(196,217,234),nil,nil,nil,nil,1)  --text, fontSize, fontName, fontColor
	myBtn:setScrollViewCheck(true)
	myBtn:setPositionX(3)
	self._ranglist:addCell(myBtn)
	self._ranglist:setScrollTo(ScrollView.TOP)
	myBtn:addEventListener(Event.MOUSE_CLICK, {self,self.onMyServer})

	self._scrollView = self.uiNode.node["scrollView"]
	self._serverContainer = display.newNode()
	self._scrollView:addChild(self._serverContainer)
	self._scrollWidth = self._scrollView:getContentSize().width

	local size = myBtn:getContentSize()
	self.selectFram = display.newXSprite("#login_xzk.png")
	self.selectFram:setPosition(size.width/2,size.height/2-5)
	self.selectFram:retain()

	self.entryList = {}
end

function ServerListState:show(serverList)
	StateBase.show(self)

	self._serverList = serverList

	if not self._serverList.lastLoginServerList then--没有上次登录的服务器列表  需要请求
		NetCenter:addMsgHandler(MsgType.LAST_LOGIN_SERVER_RET, {self,self._onLastLoginServer})
		NetCenter:send(MsgType.LAST_LOGIN_SERVER)  --请求上次登录过的服务器列表
		LoadingControl:show("LAST_LOGIN_SERVER",true)
		return
	end

	self:initServerRangList()

	self:onMyServer({target=self._ranglist:getCellAt(1)})

--	self:addNetErrorHandler()
--	self:addNetFailHandler()
	--scheduler.performWithDelayGlobal(function() self:changeState(StateBase.UPDATE) end ,1)

	--gamePlatform:showPlatformIcon(true)
end

function ServerListState:_onLastLoginServer(event)
	LoadingControl:stopShow("LAST_LOGIN_SERVER")
	local msg = event.msg
	NetCenter:removeMsgHandler(MsgType.LAST_LOGIN_SERVER_RET, {self,self._onLastLoginServer},1)
	self._serverList.lastLoginServerList = msg.loginLogList
	self:show(self._serverList)
end

function ServerListState:initServerRangList()
	local num = 10
	local flagList = {}
	for i,sInfo in ipairs(self._serverList) do
		local id = sInfo.showIndex or sInfo.serverId
		local index = math.floor( (id-1)/num)
		if not flagList[index] then
			flagList[index] = true
			local rang = UIButton.new({"#login_xd2.png"})
			rang:setPositionX(3)
			rang._serverBegin = (index)* num + 1
			rang._serverEnd = (index+1)*num
			rang:setText(tostring(rang._serverBegin).."—"..tostring(rang._serverEnd).."服"
				,22,nil,ccc3(196,217,234),nil,nil,nil,nil,1)
			self._ranglist:addCell(rang,2)
			rang:addEventListener(Event.MOUSE_CLICK, {self,self.onServerRang})
			rang:setScrollViewCheck(true)
		end
	end
	self._ranglist:setScrollTo(ScrollView.TOP)
end

function ServerListState:_setSelect(rang)
	if self.lastRangRang == rang then
		return false
	end
	if self.lastRangRang then
		self.lastRangRang:setUpImage("#login_xd2.png", true)
	end
	rang:setUpImage("#login_xd1.png", true)
	self.lastRangRang = rang
	self._serverContainer:removeAllChildren()

	self.selectFram:removeFromParent()
	rang:addChild(self.selectFram)
	return true
end

function ServerListState:onServerRang(event)
	local rang = event.target
	if not self:_setSelect(rang) then
		return
	end

	local params = {text = tostring(rang._serverBegin).."—"..tostring(rang._serverEnd).."服：",size = 21,color = ccc3(15,210,254),align = ui.TEXT_ALIGN_LEFT}

	local label = ui.newTTFLabelWithOutline(params)
	label:setPosition(5,-15)
	self._serverContainer:addChild(label)   --文本
	local line = display.newXSprite("#com_fgx.png")
	self._serverContainer:addChild(line)
	line:setAnchorPoint(ccp(0,0.5))
	line:setPosition(5,-30)

	local entry
	local count = 0
	for i = rang._serverBegin,rang._serverEnd do
		local sInfo = self:getServerInfoByShow(i)
		if sInfo then
			entry = self:getServerEntry()
			entry:setServerInfo(sInfo)
			entry:setPosition(5 + (count)%2*290,-40-50*math.floor( (count)/2 ))
			self._serverContainer:addChild(entry)
			count = count + 1
		end
	end
	if entry then
		local height = -entry:getPositionY() + 20
		self._serverContainer:setPositionY(height)
		self._scrollView:setContentSize(CCSize(self._scrollWidth,height))
		self._scrollView:setScrollTo(ScrollView.TOP)
	end
end

function ServerListState:getServerInfoByShow(index)
	if self._serverList then
		for i,serverInfo in ipairs(self._serverList) do
			if serverInfo.showIndex then
				if serverInfo.showIndex == index then
					return serverInfo
				end
			elseif serverInfo.serverId == index then
				return serverInfo
			end
		end
	end
end

function ServerListState:onMyServer(event)
	local rang = event.target
	if not self:_setSelect(rang) then
		return
	end

	local height = 0
	local textX = 5
	local sInfo = self:_getLastLoginServer()
	if sInfo then
		local params = {text = "上次登录：",size = 21,color = ccc3(15,210,254),align = ui.TEXT_ALIGN_LEFT}

		local label = ui.newTTFLabelWithOutline(params)
		label:setPosition(textX,-height-15)
		self._serverContainer:addChild(label)   --文本
		local line = display.newXSprite("#com_fgx.png")
		self._serverContainer:addChild(line)
		line:setAnchorPoint(ccp(0,0.5))
		line:setPosition(textX,-height-30)
		local entry = self:getServerEntry()
		entry:setPosition(textX ,-height-40)
		self._serverContainer:addChild(entry)
		entry:setServerInfo(sInfo)

		textX = textX + 290
	end

	sInfo = self:_getRecommendServer()
	if sInfo then
		local params = {text = "推荐登录：",size = 21,color = ccc3(15,210,254),align = ui.TEXT_ALIGN_LEFT}
		local label = ui.newTTFLabelWithOutline(params)
		label:setPosition(textX,-height-15)
		self._serverContainer:addChild(label)   --文本
		local line = display.newXSprite("#com_fgx.png")
		self._serverContainer:addChild(line)
		line:setPosition(textX,-height-30)
		line:setAnchorPoint(ccp(0,0.5))

		local entry = self:getServerEntry()
		entry:setPosition(textX,-height-40)
		self._serverContainer:addChild(entry)
		entry:setServerInfo(sInfo)
		height = 120
	end

	textX = 5
	local sList = self:_getLastLoginServerList()
	if sList and #sList > 0 then
		local params = {text = "拥有指挥官的服务器：",size = 21,color = ccc3(15,210,254),align = ui.TEXT_ALIGN_LEFT}
		local label = ui.newTTFLabelWithOutline(params)
		label:setPosition(textX,-height)
		self._serverContainer:addChild(label)   --文本

		height = height + 15

		local line = display.newXSprite("#com_fgx.png")
		self._serverContainer:addChild(line)
		line:setPosition(textX,-height)
		line:setAnchorPoint(ccp(0,0.5))

		height = height + 10

		local count = 0
		for i,loginInfo in ipairs(sList) do
			local sInfo = self:getServerInfo(loginInfo.serverId)
			if sInfo then
				local entry = self:getServerEntry()
				entry:setServerInfo(sInfo)
				entry:setPosition(5 + (count)%2*290,-height-50*math.floor( (count)/2 ))
				self._serverContainer:addChild(entry)
				count = count + 1
			end

		end
	end

	self._serverContainer:setPositionY(height)
	self._scrollView:setContentSize(CCSize(self._scrollWidth,height))
	self._scrollView:setScrollTo(ScrollView.TOP)
end

function ServerListState:getServerEntry()
	for i,entry in ipairs(self.entryList) do
		if not entry:getParent() then
			return entry
		end
	end
	local entry = ServerEntry.new({"#login_di2.png"})
	entry:setAnchorPoint(ccp(0,1))
	entry:setScrollViewCheck(true)
	self.entryList[#self.entryList+1] = entry
	entry:addEventListener(Event.MOUSE_CLICK, {self,self._onServerClick})
	return entry
end


function ServerListState:_getLastLoginServer()
	if self._serverList.lastLoginServerList then  --上次登录的服务器
		for i,loginInfo in ipairs(self._serverList.lastLoginServerList) do
			local sInfo = self:getServerInfo(loginInfo.serverId)
			if sInfo then
				return sInfo
			end
		end
	end
	return nil
end

function ServerListState:_getRecommendServer()
	for i = #self._serverList,1,-1 do
		local sInfo = self._serverList[i]
		if sInfo.status ~= 0 then
			return sInfo
		end
	end
	return self._serverList[#self._serverList]
end

function ServerListState:_getLastLoginServerList()
	return self._serverList.lastLoginServerList
end

function ServerListState:_onServerClick(event)
	local entry = event.target
	local sInfo = entry.sInfo
	self:changeState(StateMgr.SELECT_SERVER, self._serverList, sInfo.serverId)
end

function ServerListState:getServerInfo(serverId)
	if self._serverList then
		for i,serverInfo in ipairs(self._serverList) do
			if serverId == serverInfo.serverId then
				return serverInfo
			end
		end
	end
	return nil
end


function ServerListState:dispose()

	self._ranglist:clear(true)
	self.uiNode:dispose()
	for i,entry in ipairs(self.entryList) do
		entry:dispose()
	end
	self.entryList = nil

	ResMgr:unload("ui/login/login.pvr.ccz")
	StateBase.dispose(self)
end

return ServerListState