--region ToolTipPanel.lua
--Author : zhangzhen
--Date   : 2014/7/9
--此文件由[BabeLua]插件自动生成

local ToolTipPanel = class("ToolTipPanel",PanelProtocol )

--[[
function ToolTipPanel:ctor(panelName)
	PanelProtocol.ctor(self,nil,panelName,nil)
	self:init()
end
--]]
function ToolTipPanel:init( )
    self:initUINode("sysmsg")
  	local parent = self:getNodeByName("com_content_text")
  	local psiz = parent:getContentSize()
  	self.content = UIText.new(psiz.width, psiz.height, 22, nil, UIInfo.color.white, UIInfo.alignment.center, UIInfo.alignment.center, true, false, true)
  	parent:addChild(self.content)
	local node = self.uiNode.node
    self.title = node.title_text
    self.btnLeft = node.btn_2
    self.btnCenter = node.btn_1
    self.btnRight = node.btn_3
	--self.notice = node.notice

    self.btnLeft:addEventListener(Event.MOUSE_CLICK, {self, self.LeftClick})
    self.btnCenter:addEventListener(Event.MOUSE_CLICK, {self, self.CenterClick})
    self.btnRight:addEventListener(Event.MOUSE_CLICK, {self, self.RightClick})
end

--[[
    title:标题  ，不需要就设为nil
    content_text, 内容

   以下是提示框的三个按钮，统一格式为
   一个table，结构如下：
   { text = "确定", obj = self, callfun = fun，param = {} }
    leftBtnInfo,
    centerBtnInfo,
    rightBtnInfo

]]--

function ToolTipPanel:setInfo( params )
      if params.title then
          self.title:setVisible(true)
          self.title:setText( title )
      else
          self.title:setVisible(false)
      end

      self.content:setText(params.text)

      self.leftBtnInfo = params.leftBtn
      self.centerBtnInfo = params.centerBtn
      self.rightBtnInfo = params.rightBtn

      if self.leftBtnInfo then
          if not self.btnLeft:getParent() then
              self:addChild(self.btnLeft)
          end
          self.btnLeft:setText( self.leftBtnInfo.text or "确定")
      else
          self.btnLeft:removeFromParent()
      end

      if self.centerBtnInfo then
          if not self.btnCenter:getParent() then
              self:addChild(self.btnCenter)
          end
          self.btnCenter:setText( self.centerBtnInfo.text or "确定")
      else
          self.btnCenter:removeFromParent()
      end

      if self.rightBtnInfo then
          if not self.btnRight:getParent() then
              self:addChild(self.btnRight)
          end
          self.btnRight:setText( self.rightBtnInfo.text or "取消")
      else
          self.btnRight:removeFromParent()
      end
	  if params.notice then
		--self.notice:setText(params.notice)
	  end
end

function ToolTipPanel:LeftClick( event )
    self:handler( self.leftBtnInfo )
end

function ToolTipPanel:CenterClick( event )
    self:handler( self.centerBtnInfo )
end

function ToolTipPanel:RightClick( event )
    self:handler( self.rightBtnInfo )
end

function ToolTipPanel:handler( info )
    self:closeSelf()
    local obj = info.obj
    local fun = info.callfun
    local param = info.param

    if not fun then
        return
    end

    if obj then
        fun( obj,param )
    else
        fun( param )
    end

    if info.clickText then
        floatText(info.clickText, UIInfo.red)
    end
end

--[[
    params.title, params.text, params.leftBtn, params.centerBtn, params.rightBtn
--]]

function ToolTipPanel:onOpened(params)
    self:setInfo( params )
end

function ToolTipPanel:onCloseed(params)
    self.title:setText( "" )
    self.btnLeft:setText("")
    self.btnCenter:setText("")
    self.btnRight:setText("")
	--self.notice:setText("")
end

return ToolTipPanel
--endregion
