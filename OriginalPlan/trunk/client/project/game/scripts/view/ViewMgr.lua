local ViewMgrCls = class("ViewMgrCls")


--common
PanelActionMgr = game_require("view.PanelActionMgr")
PanelNodeProtocol = game_require("view.PanelNodeProtocol")
PanelProtocol  = game_require("view.PanelProtocol")

--exui

CDTextDelegate = game_require("view.common.CDTextDelegate")
TabList = game_require("view.common.TabList")

GameLayer = game_require("view.GameLayer")

PanelHelper = game_require("view.PanelHelper")
ParticleMgr = game_require("view.ParticleMgr")

LoadingControl = game_require("view.common.LoadingControl")

function ViewMgrCls:init(mainScene)
	--创建主场景
	self.mainScene = mainScene

	--保存 界面名字->界面对象
	self._stagePanels = {}    --正在舞台上的界面列表
  	--多个遮罩层对象
  	self._maskLayers = {}

  	--面板对象列表
  	self._panels = {}

	--初始化界面的容器  各个层
	self._layers = {}
	for i,name in ipairs(GameLayer.layer) do
		local gameLayer = GameLayer.new(name)
		gameLayer:retain()
		self.mainScene:addChild(gameLayer,i)
		self._layers[name] = gameLayer
	end
 	ParticleMgr:init()

 	self._panelStack = {}  --面板链


end

--[[--
获取某一层
]]
function ViewMgrCls:getGameLayer( name )
	return self._layers[name]
end

function ViewMgrCls:onTouchCoverTimer()
	self._layers[Panel.PanelLayer.MASK_LAYER]:setTouchCover(false)
	if nil ~= self._touchCoverHandle then
		scheduler.unscheduleGlobal(self._touchCoverHandle)
		self._touchCoverHandle = nil
	end
	lastCoverTime = 0
end

function ViewMgrCls:cancelTouchCover()
	if nil ~= self._touchCoverHandle then
		scheduler.unscheduleGlobal(self._touchCoverHandle)
		self._touchCoverHandle = nil
	end
	self._layers[Panel.PanelLayer.MASK_LAYER]:setTouchCover(false)
end

local lastCoverTime = 0
function ViewMgrCls:touchCover(coverTime)
	if nil == coverTime then
		coverTime = 0.2
	end
	local t = os.time() + coverTime
	if t <= lastCoverTime then
		return
	end
	lastCoverTime = t
	self._layers[Panel.PanelLayer.MASK_LAYER]:setTouchCover(true)
	if nil ~= self._touchCoverHandle then
		scheduler.unscheduleGlobal(self._touchCoverHandle)
	end
	self._touchCoverHandle = scheduler.performWithDelayGlobal(function() self:onTouchCoverTimer() end, coverTime)
end

--[[--
	打开界面,还没有示例的，会加载对应模块，并创建一个对象
	@param name String 界面的名字，定义在config.common.Panel中
	@param params Table 打开界面时，传给界面的参数
	@panem saveLink  bool  是否把当前面板存储在panellink里面
]]
function ViewMgrCls:open(name,params,saveLink,preParam,childPanel)
	print("打开面板：",name)
	return	self:openEx(name,params,saveLink,preParam,childPanel)
end
--[[
ViewMgr:open(targetPanel, nil, false, )
]]--
function ViewMgrCls:openEx(name,params,saveLink,preParam,childPanel)
	local panel = self._panels[name]
	if not panel then
	  	local panelConfig = Panel.Config[name]
	  	if panelConfig then
	  		local sys = panelConfig["sys"]
	  		if sys and not SysModel:isSysOpen(sys)  then
	  			floatText(SysModel:getSysOpenTip(sys))
	  			return nil
	  		else
		    	local panelCls = game_require(panelConfig["portal"])
	      		panel = panelCls.new(name)
	      		self._panels[name] = panel
	      		panel:retain()
	      	end
    	else
      		print("System not found:"..name)
      		return nil
	  	end
	end

    if not panel:checkOpen(params) then
        return
    end

	if saveLink then
		if nil ~= self._currentPanelInfo then
			local prePanelInfo = self._currentPanelInfo
			if nil ~= preParam then
				prePanelInfo._param = preParam
			end
			if childPanelList then
				prePanelInfo._childPanel = childPanel
			end
			self._currentPanelInfo = nil
			self:close(prePanelInfo._name)
			table.insert(self._panelStack,1,prePanelInfo)
		end
		self._currentPanelInfo = { _name = name, _param = params}
	elseif childPanel then
		local prePanelInfo = {_name = childPanel}
		table.insert(self._panelStack,1,prePanelInfo)
		self._currentPanelInfo = { _name = name, _param = params}
	end

	if not self._currentPanelInfo then
		self._currentPanelInfo = { _name = name, _param = params}
	end

    if not self:isOpen(name) then
        panel:open(params)
    end

    if panel:isShowMark() and panel:isSwallowEvent() then
    	AudioMgr:playEffect("u_slide1")
    end

    self._stagePanels[name] = true
    NotifyCenter:dispatchEvent({ name=Notify.PANEL_OPEN ,panelName = name})

    return panel
end

function ViewMgrCls:removePanelLinkByName(panelName)
	if not self._panelStack then return end
	for i=#self._panelStack,1,-1 do
		local v = self._panelStack[i]
		if v._name == panelName then
			table.remove(self._panelStack, i)
		end
	end
end

function ViewMgrCls:removeLastPanelLink()
	table.remove(self._panelStack, 1)
end

function ViewMgrCls:getPanelList()
	return self._panels
end

function ViewMgrCls:addPanelToLink(panelName,params)
	table.insert(self._panelStack,1,{_name = panelName,_param=params})
end

function ViewMgrCls:cleanPanelLink()
	self._currentPanelInfo = nil
	self._panelStack = {}
end
--[[--
	关闭界面
	@param name String 界面的名字,定义在config.common.Panel中
]]
function ViewMgrCls:close(name,params)
	print("--关闭面板",name)
	local panel = self._panels[name]
	if not panel or self._stagePanels[name] == nil then
		return
	end

	self._stagePanels[name] = nil
	panel:close(params)
	NotifyCenter:dispatchEvent({ name=Notify.PANEL_CLOSE, panelName = name})

	if nil ~= self._currentPanelInfo and self._currentPanelInfo._name == name then
		self._currentPanelInfo = nil
		if #self._panelStack > 0 then
			local panelInfo = self._panelStack[1]
			table.remove(self._panelStack, 1)
			ViewMgr:open(panelInfo._name, panelInfo._param,false)
			self._currentPanelInfo = panelInfo
			if panelInfo._childPanel then
				ViewMgr:open(panelInfo._childPanel)
			end
		end
	end
end

--[[--
	清楚面板链并返回主界面
]]
function ViewMgrCls:backToHome()
	if nil ~= self._currentPanelInfo then
		local panelInfo = self._currentPanelInfo
		self:cleanPanelLink()
		ViewMgr:close(panelInfo._name)
	end
	ViewMgr:open(Panel.MAIN_UI)
--	local panel = ViewMgr:getPanel(Panel.MAIN_UI)
--	if panel then
--		panel:backToScene()
--	end
end

function ViewMgrCls:dumpLinkPanel()
	dump(self._panelStack)
end

--[[--
	界面是否在舞台上
	@param name String 界面的名字，定义在config.common.Panel中
]]
function ViewMgrCls:isOpen(name)
	-- print('ViewMgrCls:isOpen(name) ,, '..name)
	local panel = self._panels[name]
	if not panel then
		return false
	end
	if not self._stagePanels[name] then
		-- print('not self._stagePanels[name] ,, '..name)
		return false
	else
		return true
	end
end

--[[--
	获取一个界面的引用
	@param name String 界面的名字，定义在config.common.Panel中
]]
function ViewMgrCls:getPanel(name)
 	return self._panels[name]
end


--[[--
	关闭所有当前显示的界面
]]
function ViewMgrCls:closeAllPanels()
	self:cleanPanelLink()
	for k,v in pairs(self._stagePanels) do
		print("--关闭面板",k)
		self:close(k)
	end
end

--[[--
关闭某个 层的面板
]]
function ViewMgrCls:closeLayerPanel( layerName )
	local gameLayer = self:getGameLayer(layerName)
	gameLayer:closeAllPanel()
end

--[[--
	移除一个界面的引用,开场、创角、加载界面,进入游戏都不再使用
	需要调用此方法
	@param name String 界面的名字,定义在config.common.Panel中
]]
function ViewMgrCls:remove(name)
	local panel =self._panels[name]
	if panel then
		if self:isOpen(name) then
        	panel:closeSelf()
		end
		self._panels[name] = nil
        panel:dispose()
		panel:release()
	end
end

function ViewMgrCls:getMainScene()
	return self.mainScene
end


--错误提示
function errorTip( id )
	local text = LangCfg:getErrorString(id)
	if text then
		floatText( text , ccc3(239,0,0))
	elseif DEBUG == 2 then
		floatText("操作错误："..id)
	end
end


--打开tippanel
--[[--
	btnList = {}   --放置一些btn info    可以放1个  2个  3个

	btnInfo = {}
	btnInfo.text -- 按钮文本
	btnInfo.obj   --回调对象
    btnInfo callfun = info.callfun   --回调方法
    btnInfo param = info.param   --回调参数
]]

function openTipPanel(text,btnList,title, textAlign,textVAlign, p)
	local params = {title=title, text=text,panType = 2, align=textAlign, valign=textVAlign}
	if p then
		for k,v in pairs(p) do params[k] = v end
	end
	local btnNum = (btnList and #btnList) or 0
	if btnNum == 0 then
		params.centerBtn = {}
	elseif btnNum == 1 then
		params.centerBtn = btnList[1]
	else
		params.leftBtn = btnList[2]
		params.rightBtn = btnList[1]
		params.centerBtn = btnList[3]
	end
	ViewMgr:open(Panel.TOOLTIP,params)
end

--最上的  错误提示面板   断线等
function openErrorPanel(text,btnList,title)
	if not ViewMgr:isOpen(Panel.ERROR_TIP_PANEL) then
		local params = {title=title, text=text,panType = 2}
		local btnNum = (btnList and #btnList) or 0
		if btnNum == 0 then
			params.centerBtn = {}
		elseif btnNum == 1 then
			params.centerBtn = btnList[1]
		else
			params.leftBtn = btnList[2]
			params.rightBtn = btnList[1]
			params.centerBtn = btnList[3]
		end
		ViewMgr:open(Panel.ERROR_TIP_PANEL,params)
	end
end


local ViewMgr = ViewMgrCls.new()
return ViewMgr
