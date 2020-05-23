local RegisterContainer = class("RegisterContainer",function() return display.newNode() end)

function RegisterContainer:ctor()
	local bg = display.newXSprite("#login_di1.png")
    bg:setScale(0.95)
    self:addChild(bg)

    local size = bg:getContentSize()

    self.content = display.newNode()
    self:addChild(self.content)
    self.content:setAnchorPoint(ccp(0.5,0.5))
    self.content:setContentSize(bg:getContentSize())


    local textX = 110
    local textY = 300

	local params = {}
	params.text = "账   号："
	params.size = 26
	params.color = ccc3(255,246,207)
	params.align = ui.TEXT_ALIGN_LEFT
	params.valign = ui.TEXT_VALIGN_TOP

	local nameLabel = ui.newTTFLabelWithOutline(params)
	nameLabel:setPosition(textX,textY+4)
	self.content:addChild(nameLabel)   --文本

    params.text = "密   码："
	local pwdLabel = ui.newTTFLabelWithOutline(params)
	pwdLabel:setPosition(textX,textY-67+4)
	self.content:addChild(pwdLabel)   --文本

	params.text = "确认密码："
	local pwdLabel = ui.newTTFLabelWithOutline(params)
	pwdLabel:setPosition(textX-30,textY-67*2+4)
	self.content:addChild(pwdLabel)   --文本

	local size = CCSize(259,50)
	local sp = display.newXSprite("#com_xd3.png")
	sp:setImageSize(size)
	sp:setPosition(textX+100,textY)
	sp:setAnchorPoint(ccp(0,0.72))
	self.content:addChild(sp)

	sp = display.newXSprite("#com_xd3.png")
	sp:setImageSize(size)
	sp:setPosition(textX+100,textY-67)
	sp:setAnchorPoint(ccp(0,0.72))
	self.content:addChild(sp)

	sp = display.newXSprite("#com_xd3.png")
	sp:setImageSize(size)
	sp:setPosition(textX+100,textY-67*2)
	sp:setAnchorPoint(ccp(0,0.72))
	self.content:addChild(sp)

	self.nameText =  UIEditBox.new("#tt_5.png",CCSize(250,50), -1) --
	self.nameText:setFont("",30);
	self.nameText:setFontColor(ccc3(255,246,207));
	self.nameText:setPosition(textX+120,textY)
	self.nameText:setAnchorPoint(ccp(0,0.72))
	self.content:addChild(self.nameText)

	self.passText =  UIEditBox.new("#tt_5.png",CCSize(250,50), -1) --
	self.passText:setFont("",26)
	self.passText:setFontColor(ccc3(255,246,207))
	self.passText:setPosition(textX+120,textY-67)
	self.passText:setAnchorPoint(ccp(0,0.72))
    self.passText:setInputFlag(kEditBoxInputFlagPassword);
	self.content:addChild(self.passText)

	self.passText2 =  UIEditBox.new("#tt_5.png",CCSize(250,50), -1) --
	self.passText2:setFont("",26)
	self.passText2:setFontColor(ccc3(255,246,207))
	self.passText2:setPosition(textX+120,textY-67*2)
	self.passText2:setAnchorPoint(ccp(0,0.72))
    self.passText2:setInputFlag(kEditBoxInputFlagPassword);
	self.content:addChild(self.passText2)

	self.backBtn = UIButton.new({"#com_btn_2.png"})
	self.backBtn:setText("返回",30,"",ccc3(255,243,218),nil,nil,nil,nil,1)
    self.backBtn:setScale(0.76)
	self.backBtn:setPosition(120,50)
	self.content:addChild(self.backBtn)

	self.okBtn = UIButton.new({"#com_btn_2.png"})
	self.okBtn:setText("确定",30,"",ccc3(255,243,218),nil,nil,nil,nil,1)  --fontSize, fontName, fontColor, align, valign
    self.okBtn:setScale(0.76)
	self.okBtn:setPosition(320,50)
	self.content:addChild(self.okBtn)
end

function RegisterContainer:dispose()
	self.okBtn:dispose()
	self.backBtn:dispose()
	self.passText:dispose()
	self.nameText:dispose()
	self.passText2:dispose()
end

return RegisterContainer