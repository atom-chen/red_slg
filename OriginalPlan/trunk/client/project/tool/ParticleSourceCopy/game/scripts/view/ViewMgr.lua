local ViewMgrCls = class("ViewMgrCls")

ScreenMask = require("uiLib.exui.ScreenMask")
HollowMask = require("uiLib.exui.HollowMask")


--common
PanelActionMgr = require("view.PanelActionMgr")
PanelProtocol  = require("view.PanelProtocol") 

--exui


GameLayer = require("view.GameLayer")

--[[--
  ViewManager初始化函数
]]

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
		self.mainScene:addChild(gameLayer)
		self._layers[name] = gameLayer
	end
 
end

--[[--
获取某一层
]]
function ViewMgrCls:getGameLayer( name )
	return self._layers[name]
end

--[[--
	打开界面,还没有示例的，会加载对应模块，并创建一个对象
	@param name String 界面的名字，定义在config.common.Panel中
	@param params Table 打开界面时，传给界面的参数
]]
function ViewMgrCls:open(name,params)
	local panel = self._panels[name]
	if not panel then
	  	local sysConfig = Panel.Config[name]
	  	if sysConfig and sysConfig["portal"] then
	    	local panelCls = require(sysConfig["portal"])
      		panel = panelCls.new()
      		self._panels[name] = panel
      		panel:retain()
    	else
      		echo("System not found:"..name)
      		return
	  	end
	end
  
  
	--记录下最近打开的home类型
	if name == Panel.DUNGEON then
		self.homeType = Panel.DUNGEON
	elseif name == Panel.BAG then
		self.homeType = Panel.BAG
	elseif name == Panel.HUD then
		self.homeType = Panel.HUD
	end
	
	panel:open(params)
	self._stagePanels[name] = true
end

--[[--
	界面是否在舞台上
	@param name String 界面的名字，定义在config.common.Panel中
]]
function ViewMgrCls:isOpen(name)
	local panel = self._panels[name]
	if not panel then
		return false
	end

	if panel:getParent() then
		if not self._stagePanels[name] then
			echoError(string.format("[ViewMgr.isOpen]: [%s] has parent,not in ViewMgr._stagePanels",name))
		end
		return true
	end
	return false
end

--[[--
	获取一个界面的引用
	@param name String 界面的名字，定义在config.common.Panel中
]]
function ViewMgrCls:getPanel(name)
 	return self._panels[name]
end

--[[--
	返回到最近所在的Home
]]
function ViewMgrCls:backToHome()
	if self.homeType == Panel.DUNGEON then
		self:open(Panel.DUNGEON)
	elseif name == Panel.BAG then
		self:open(Panel.BAG)
	else	
		self:open(Panel.HUD)
	end
end


function ViewMgrCls:closeAllHome()
	self:close(Panel.HUD)
	self:close(Panel.DUNGEON)
	self:close(Panel.BAG)
end

--[[--
	关闭所有当前显示的界面
]]
function ViewMgrCls:closeAllPanels()
	for k,v in pairs(self._stagePanels) do
		print(" 关闭面板",k)
		self:close(k)
	end
end


--[[--
	关闭界面
	@param name String 界面的名字,定义在config.common.Panel中
]]
function ViewMgrCls:close(name,params)
	local panel = self._panels[name]
	if not panel then
		return
	end
	self._stagePanels[name] = nil
	panel:close(params)
end

--[[--
	移除一个界面的引用,开场、创角、加载界面,进入游戏都不再使用
	需要调用此方法
	@param name String 界面的名字,定义在config.common.Panel中
]]
function ViewMgrCls:remove(name)
	local panel =self._panels[name]
	if panel then
		self._panels[name] = nil
		panel:release()
	end
end

function ViewMgrCls:getMainScene()
	return self.mainScene
end

local ViewMgr = ViewMgrCls.new()
return ViewMgr