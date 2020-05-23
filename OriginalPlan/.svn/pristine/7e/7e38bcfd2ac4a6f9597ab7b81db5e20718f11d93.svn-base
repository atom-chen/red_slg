local LoginContainer = class("LoginContainer",function() return display.newNode() end)

function LoginContainer:ctor()
	local bg = display.newXSprite("#login_di1.png")
    bg:setScale(0.78)
    self:addChild(bg)

    local size = bg:getContentSize()

    self.content = display.newNode()
    self:addChild(self.content)
    self.content:setAnchorPoint(ccp(0.5,0.5))
    self.content:setContentSize(bg:getContentSize())

    local textX = 115
    local textY = 260

	local params = {}
	params.text = "账  号："
	params.size = 26
	params.color = ccc3(255,246,207)
	params.align = ui.TEXT_ALIGN_LEFT
	params.valign = ui.TEXT_VALIGN_TOP

	local nameLabel = ui.newTTFLabelWithOutline(params)
	nameLabel:setPosition(textX,textY+2)
	self.content:addChild(nameLabel)   --文本

    params.text = "密  码："
	local pwdLabel = ui.newTTFLabelWithOutline(params)
	pwdLabel:setPosition(textX,textY-70+2)
	self.content:addChild(pwdLabel)   --文本

	local size = CCSize(259,50)
	local sp = display.newXSprite("#com_xd3.png")
	sp:setImageSize(size)
	sp:setPosition(textX+90,textY)
	sp:setAnchorPoint(ccp(0,0.72))
	self.content:addChild(sp)

	local sp = display.newXSprite("#com_xd3.png")
	sp:setImageSize(size)
	sp:setPosition(textX+90,textY-70)
	sp:setAnchorPoint(ccp(0,0.72))
	self.content:addChild(sp)

	self.nameText = UIEditBox.new("#tt_5.png",CCSize(250,50), -1) --
	self.nameText:setFont("",30)
	self.nameText:setFontColor(ccc3(255,246,207))
	self.nameText:setPosition(textX+110,textY)
	self.nameText:setAnchorPoint(ccp(0,0.72))
	self.content:addChild(self.nameText)

	local name = CCUserDefault:sharedUserDefault():getStringForKey("gameUserName")
	if name and name ~= "" then
		self.nameText:setText(name)
	else
		self.nameText:setText(ACCOUNT_ID)
	end
	self.passText =  UIEditBox.new("#tt_5.png",CCSize(250,50), -1) --
	self.passText:setFont("",26)
	self.passText:setFontColor(ccc3(255,246,207))
	self.passText:setPosition(textX+110,textY-70)
	self.passText:setAnchorPoint(ccp(0,0.72))
    self.passText:setInputFlag(kEditBoxInputFlagPassword)
	self.content:addChild(self.passText)

	self.loginBtn = UIButton.new({"#com_btn_2.png"})
	self.loginBtn:setText("登录",30,"",ccc3(67,19,0),nil,nil,nil,nil)
    self.loginBtn:setScale(0.76)
	self.loginBtn:setPosition(310,80)
	self.content:addChild(self.loginBtn)

	self.registerBtn = UIButton.new({"#com_btn_2.png"})
	self.registerBtn:setText("注册",30,"",ccc3(67,19,0),nil,nil,nil,nil)  --fontSize, fontName, fontColor, align, valign
    self.registerBtn:setScale(0.76)
	self.registerBtn:setPosition(130,80)
	self.content:addChild(self.registerBtn)
end

function LoginContainer:dispose()
	self.loginBtn:dispose()
	self.registerBtn:dispose()
	self.passText:dispose()
	self.nameText:dispose()
end

return LoginContainer
