--region ComTipPanel.lua
--Author : zhangzhen
--点击显示提示信息界面，松开消失
--Date   : 2015/8/17
local ComTipPanel = class("ComTipPanel",PanelProtocol )

function ComTipPanel:ctor(name)
    PanelProtocol.ctor(self,Panel.PanelLayer.POPUP_TOP,name)
	self:initUI()
end

function ComTipPanel:initUI()
    self:initUINode("com_tip")
    self.content = self:getNodeByName("content")
end

function ComTipPanel:onOpened(params)
    self.content:setText( params.content or "") 
end

function ComTipPanel:onCloseed( params )
    self.content:setText("")
end

return ComTipPanel