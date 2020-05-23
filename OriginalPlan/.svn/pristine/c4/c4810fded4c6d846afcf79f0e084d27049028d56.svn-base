local WorldButtomMenuPanel = class('WorldButtomMenuPanel', PanelProtocol)

local WorldModel = game_require("model.world.WorldModel")

WorldButtomMenuPanel.LUA_PATH = 'world_buttom_menu'
function WorldButtomMenuPanel:ctor()
    PanelProtocol.ctor(self, Panel.WORLD_BUTTOM_MENU)
--    PanelAdjust.extend(self)

--    local PanelShowExtend = game_require("view.PanelShowExtend")
--    PanelShowExtend.extend(self)
end

function WorldButtomMenuPanel:init()
	self:initUINode(self.LUA_PATH)

	self._posText = self:getNodeByName("text_pos")

--	self._goToBtn = self:getNodeByName("tt_21")
--	self._goToBtn:addEventListener(Event.MOUSE_CLICK, {self, self._goToPos})

	self._angleBtn = self:getNodeByName("btn_indicator")
    self._angleBtn:addEventListener(Event.MOUSE_CLICK, {self, self._onBaseCamp})
	local size = self._angleBtn:getContentSize()
	self._angleBtn:addChild(display.newSprite("#town_dtzb_zx.png", -20, size.height/2))
	self._angleBtn:addChild(display.newSprite("#town_dtzb_zx.png", -40, size.height/2))
	self._angleBtn:addChild(display.newSprite("#town_dtzb_zx.png", -60, size.height/2))
	self._text = self:getNodeByName("text_distance");
	self._angleBtn:retain()
	self._angleBtn:setAnchorPoint(ccp(0.5, 0.5))
	self._angleBtn:setVisible(false)
	self._angleBtn:setEnable(false)
	self._text:setVisible(false)
end

function WorldButtomMenuPanel:isSwallowEvent()
    return false
end

function WorldButtomMenuPanel:isShowMark()
    return false
end

function WorldButtomMenuPanel:onOpened(params)
    NotifyCenter:addEventListener(Notify.WORLD_SET_NOWPOS, {self, self._setPos})


end

function WorldButtomMenuPanel:onCloseed()
    NotifyCenter:removeEventListener(Notify.WORLD_SET_NOWPOS, {self, self._setPos})

	self._angleBtn:release()
	if self._text then
		self._text:setText("")
	end
	self._posText:setText("")
end


function WorldButtomMenuPanel:setBasePos(x,y)
	self._posText:setText("X:"..x.." Y:"..y)
end

function WorldButtomMenuPanel:_goToPos( event )
    ViewMgr:open(Panel.WORLD_SET_POS)
end

function WorldButtomMenuPanel:_onBaseCamp(event)
    local base = WorldModel:getBaseInfo()
    if base then
        NotifyCenter:dispatchEvent({name=Notify.WORLD_TO_BLOCK_POS,x = base.x, y = base.y})
    end
end

function WorldButtomMenuPanel:_setPos( event )
    local x,y = math.floor(event.x),math.floor(event.y)
    if self.lastX == x and self.lastY == y then
        return
    end
    self.lastX = x
    self.lastY = y
    self._posText:setText("X:"..x.." Y:"..y)

    local base = WorldModel:getBaseInfo()

    local disX =  x - base.x
    local disY =  y - base.y
    local distance = math.floor( math.sqrt( math.pow(disX,2) + math.pow(disY,2) ) )

    if distance < 4 then
		self._angleBtn:setVisible(false)
		self._angleBtn:setEnable(false)
		if self._text then
			self._text:setVisible(false)
		end
        return
    else
        if self._angleBtn:getParent() then
			self._angleBtn:setVisible(true)
			self._angleBtn:setEnable(true)
        end
    end

--    if not self._text then
--        self._text = UIText.new(200,36,22,ccc3(255,255,255),nil,UIInfo.alignment.CENTER, UIInfo.alignment.CENTER, true, false,true)
--        self._text:setAnchorPoint(ccp(0.5,0.5))

--		local size = self._angleBtn:getContentSize()

--        self._text:setPositionX(size.width/2)
--        self._text:setPositionY(size.height/2)
--		local x,y = self._angleBtn:getPosition()
--		self._text:setPosition(ccp(x,y))
--		self:addChild(self._text,11)
--        --self._angleBtn:addChild(self._text)
--    end
    self._text:setText(distance .. "m")
	self._text:setVisible(true)

    local panel = ViewMgr:getPanel(Panel.WORLD)
    local basePos = panel:getMapNodePosFromBlockPos(base)
    local curPos = panel:getMapNodePosFromBlockPos({x=x,y=y})

    local angle = math.atan2(basePos.y-curPos.y,basePos.x-curPos.x)
    self._angleBtn:setRotation(-angle*180/math.pi + 180)

--    if curPos.x < basePos.x then
--        self._text:setScale(-1)
--    else
--        self._text:setScale(1)
--    end

    local btnX = 0
    local btnY = 0
    local tan = math.tan(angle)
    local rightY = (display.cx) * tan
    local leftY = (-display.cx)*tan

    if (rightY >= display.cy or leftY >= display.cy ) and (basePos.y-curPos.y) > 0 then  --在上面
        btnY = display.cy
        btnX = btnY/tan
    elseif (rightY <= -display.cy or leftY <= -display.cy ) and (basePos.y-curPos.y) < 0 then --在下面
        btnY = -display.cy
        btnX = btnY/tan
    elseif (rightY >= -display.cy and rightY <= display.cy) and (basePos.x-curPos.x) > 0 then  --在右边
        btnX = display.cx
        btnY = btnX*tan
    else
        btnX = -display.cx
        btnY = btnX*tan
    end

--    self._angleBtn:setPosition(btnX,btnY)
end

return WorldButtomMenuPanel;