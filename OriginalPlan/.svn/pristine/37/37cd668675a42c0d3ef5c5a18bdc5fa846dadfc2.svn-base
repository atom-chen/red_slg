-- PanelNodeProtocol
-- changao
-- 2014-07-30

local PanelNodeProtocol = class("PanelNodeProtocol",function() return display.newNode() end)

function PanelNodeProtocol:ctor(panelName)

	self.panelName = panelName   --面板名   在 common/Panel.lua  里面定义
	print("PanelNodeProtocol:ctor",panelName)
    local panelConfig = Panel.Config[panelName]
    self.layerID = panelConfig["layer"]
    self.isLinkPanel = panelConfig["linkPanel"]
	self._loadedRes  = {}
	--! UINode
	self.uiNode = nil

    self:init()
	self:retain()
end

--子类面板重写 进行初始化
function PanelNodeProtocol:init(...)
end

function PanelNodeProtocol:initUINode(layname, pvrPath)
    if pvrPath then
        self:loadRes(pvrPath)
    end
    if self.uiNode then
        self.uiNode:dispose()
    end
    self.uiNode = UINode.new(self:getPriority(),true)
    self.uiNode:setUI(layname)
    self:addChild(self.uiNode)
end

function PanelNodeProtocol:getNodeByName(nodeName)
	return self.uiNode:getNodeByName(nodeName)
end

function PanelNodeProtocol:getPanelName()
	return self.panelName
end

function PanelNodeProtocol:isOpen()
    return ViewMgr:isOpen(self.panelName)
end

--[[--
获取 面板的 事件优先级
]]
function PanelNodeProtocol:getPriority()
    return GameLayer.priority[self.layerID]
end

function PanelNodeProtocol:loadRes(...)
	local pvrList = {...}
	if not self._loadedRes then
		self._loadedRes = {}
	end
	for i,pvrPath in ipairs(pvrList) do
		self._loadedRes[pvrPath] = self._loadedRes[pvrPath] or false
	end
	for pvrPath,loaded in pairs(self._loadedRes) do
		if not loaded then
			ResMgr:loadPvr(pvrPath)
			self._loadedRes[pvrPath] = true
		end
	end
end

function PanelNodeProtocol:unloadRes(...)
	local pvrList = {...}
	if not self._loadedRes then
		self._loadedRes = {}
	end
	for i,pvrPath in ipairs(pvrList) do
		self._loadedRes[pvrPath] = true
	end
	for plist,loaded in pairs(self._loadedRes) do
		if loaded then
			ResMgr:unload(plist)
			self._loadedRes[plist] = false
		end
	end
end

function PanelNodeProtocol:dispose()
	self:unloadRes()
	if self.uiNode then
		self.uiNode:dispose()
		self.uiNode = nil
	end
	self._loadedRes = nil
	self:removeFromParent()
	self:release()
end

return PanelNodeProtocol
