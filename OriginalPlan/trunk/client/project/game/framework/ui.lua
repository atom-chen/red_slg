
local ui = {}

if device.platform == "ios" then
    ui.DEFAULT_TTF_FONT      = "FZDHTJW"
else
    ui.DEFAULT_TTF_FONT      =  "fonts/FZDHTJW.ttf"
end

ui.DEFAULT_TTF_FONT_SIZE = 24

ui.TEXT_ALIGN_LEFT    = kCCTextAlignmentLeft
ui.TEXT_ALIGN_CENTER  = kCCTextAlignmentCenter
ui.TEXT_ALIGN_RIGHT   = kCCTextAlignmentRight
ui.TEXT_VALIGN_TOP    = kCCVerticalTextAlignmentTop
ui.TEXT_VALIGN_CENTER = kCCVerticalTextAlignmentCenter
ui.TEXT_VALIGN_BOTTOM = kCCVerticalTextAlignmentBottom


function ui.newEditBox(params)
    local imageNormal = params.image
    local imagePressed = params.imagePressed
    local imageDisabled = params.imageDisabled

    if type(imageNormal) == "string" then
        imageNormal = display.newScale9Sprite(imageNormal)
    end
    if type(imagePressed) == "string" then
        imagePressed = display.newScale9Sprite(imagePressed)
    end
    if type(imageDisabled) == "string" then
        imageDisabled = display.newScale9Sprite(imageDisabled)
    end

    local editbox = CCEditBox:create(params.size, imageNormal, imagePressed, imageDisabled)

    if editbox then
        CCNodeExtend.extend(editbox)
        if params.listener then
            editbox:addEditBoxEventListener(params.listener)
        end
        if params.x and params.y then
            editbox:setPosition(params.x, params.y)
        end
    end

    return editbox
end

function ui.translateFontSize(fontSize)
--[[
	local siz = math.floor(fontSize/1.2+0.5)
	return siz%2==0 and siz or siz + 1
--]]
	return fontSize
end

function ui.newMenu(items)
    local menu
    menu = CCNodeExtend.extend(CCMenu:create())

    for k, item in pairs(items) do
        if not tolua.isnull(item) then
            menu:addChild(item, 0, item:getTag())
        end
    end

    menu:setPosition(0, 0)
    return menu
end

function ui.newImageMenuItem(params)
    local imageNormal   = params.image
    local imageSelected = params.imageSelected
    local imageDisabled = params.imageDisabled
    local listener      = params.listener
    local tag           = params.tag
    local x             = params.x
    local y             = params.y
    local sound         = params.sound

    if type(imageNormal) == "string" then
        imageNormal = display.newSprite(imageNormal)
    end
    if type(imageSelected) == "string" then
        imageSelected = display.newSprite(imageSelected)
    end
    if type(imageDisabled) == "string" then
        imageDisabled = display.newSprite(imageDisabled)
    end

    local item = CCMenuItemSprite:create(imageNormal, imageSelected, imageDisabled)
    if item then
        CCNodeExtend.extend(item)
        if type(listener) == "function" then
            item:registerScriptTapHandler(function(tag)
                if sound then audio.playSound(sound) end
                listener(tag)
            end)
        end
        if x and y then item:setPosition(x, y) end
        if tag then item:setTag(tag) end
    end

    return item
end

function ui.newTTFLabelMenuItem(params)
    local p = clone(params)
    p.x, p.y = nil, nil
    local label = ui.newTTFLabel(p)

    local listener = params.listener
    local tag      = params.tag
    local x        = params.x
    local y        = params.y
    local sound    = params.sound

    local item = CCMenuItemLabel:create(label)
    if item then
        CCNodeExtend.extend(item)
        if type(listener) == "function" then
            item:registerScriptTapHandler(function(tag)
                if sound then audio.playSound(sound) end
                listener(tag)
            end)
        end
        if x and y then item:setPosition(x, y) end
        if tag then item:setTag(tag) end
    end

    return item
end

ui.FONT_SIZE = 24

function ui.newBMFontLabel(params)
    assert(type(params) == "table",
           "[framework.ui] newBMFontLabel() invalid params")
    assert(false,"no newBMFontLabel any more")

    local text      = tostring(params.text)
    local font      = params.font or "word.fnt"
    local textAlign = params.align or ui.TEXT_ALIGN_CENTER
    local x, y      = params.x, params.y
    local color     = params.color
    local size      = params.size or ui.FONT_SIZE
    assert(font ~= nil, "ui.newBMFontLabel() - not set font")

    local scale     = size/ui.FONT_SIZE   --导出的fnt的字体大小是ui.FONT_SIZE

    local label = CCLabelBMFont:create(text, font, kCCLabelAutomaticWidth, textAlign)
    if not label then return end
    label:setScale(scale)

    CCNodeExtend.extend(label)
    if type(x) == "number" and type(y) == "number" then
        label:setPosition(x, y)
    end

    if color then
        label:setColor(color)
    end

    if textAlign == ui.TEXT_ALIGN_LEFT then
        label:align(display.LEFT_CENTER)
    elseif textAlign == ui.TEXT_ALIGN_RIGHT then
        label:align(display.RIGHT_CENTER)
    else
        label:align(display.CENTER)
    end


    return label
end

function ui.newBMFontLabelWithShadow(params)
    assert(type(params) == "table",
           "[framework.ui] newBMFontLabel() invalid params")

    local text      = tostring(params.text)
    local font      = params.font or "word.fnt"
    local textAlign = params.align or ui.TEXT_ALIGN_CENTER
    local x, y      = params.x, params.y
    local shadowColor = params.shadowColor or ccc3(50,50,50)--display.COLOR_BLACK
    local color     = params.color
    local size      = params.size or ui.FONT_SIZE

    local g = display.newNode()
    local offset = 1 / (display.widthInPixels / display.width)
    params.color = shadowColor
    params.x, params.y = -offset, -offset
    g.shadow1 = ui.newBMFontLabel(params)
    g:addChild(g.shadow1)

    params.color = color
    params.x, params.y = 0,0
    g.label = ui.newBMFontLabel(params)
    g:addChild(g.label)

    function g:setString(text)
        g.shadow1:setString(text)
        g.label:setString(text)
    end

    function g:getContentSize()
        return g.label:getContentSize()
    end

    function g:getScale()
        return g.label:getScale()
    end

    function g:setScale(s)
        g.label:setScale(s)
        g.shadow1:setScale(s)
    end

    function g:setColor(...)
        g.label:setColor(...)
    end

    function g:setShadowColor(...)
        g.shadow1:setColor(...)
    end

    function g:setOpacity(opacity)
        g.label:setOpacity(opacity)
        g.shadow1:setOpacity(opacity)
    end


    return g
end

function ui.newTTFLabel(params)
    assert(type(params) == "table",
           "[framework.ui] newTTFLabel() invalid params")

    local text       = tostring(params.text)
    local font       = params.font or ui.DEFAULT_TTF_FONT
    local size       = params.size or ui.DEFAULT_TTF_FONT_SIZE
    local color      = params.color or display.COLOR_WHITE
    local textAlign  = params.align or ui.TEXT_ALIGN_LEFT
    local textValign = params.valign or ui.TEXT_VALIGN_CENTER
    local x, y       = params.x, params.y
    local dimensions = params.dimensions

    assert(type(size) == "number",
           "[framework.ui] newTTFLabel() invalid params.size")

	size = ui.translateFontSize(size)
    local label

    if text == '\t' then
        text = '    '
    end
    --text = string.gsub(text,'\t','    ')
    if dimensions then
        label = CCLabelTTF:create(text, font, size, dimensions, textAlign, textValign)
    else
        label = CCLabelTTF:create(text, font, size)
    end

    if label then
        if device.isLowApp then
            CCTTFLabelExtend.extend(label)
        else
            CCNodeExtend.extend(label)
        end
        label:setColor(color)

        function label:realign(x, y)
			local dx=x
			local dy=y
            if textAlign == ui.TEXT_ALIGN_LEFT then
				dx = math.round(x + label:getContentSize().width / 2)
            elseif textAlign == ui.TEXT_ALIGN_RIGHT then
				dx = x - math.round(label:getContentSize().width / 2)
            end

			if textValign == ui.TEXT_VALIGN_BOTTOM then
				dy = math.round(y + label:getContentSize().height / 2)
			elseif textValign == ui.TEXT_VALIGN_TOP then
				dy = math.round(y - label:getContentSize().height / 2)
			end

			label:setPosition(dx, dy)
        end

        if x and y then label:realign(x, y) end
    end
    return label
end

function ui.newTTFLabelWithShadow(params)
    assert(type(params) == "table",
           "[framework.ui] newTTFLabelWithShadow() invalid params")

    local color       = params.color or display.COLOR_WHITE
    local shadowColor = params.shadowColor or display.COLOR_BLACK
    local x, y        = params.x, params.y


    local g = display.newNode()
    params.size = ui.translateFontSize(params.size)
    params.color = shadowColor
    params.x, params.y = 0, 0
    g.shadow1 = ui.newTTFLabel(params)
    local offset = 1 / (display.widthInPixels / display.width)
    g.shadow1:realign(-offset, -offset)
    g:addChild(g.shadow1)

    params.color = color
    g.label = ui.newTTFLabel(params)
    g.label:realign(0, 0)
    g:addChild(g.label)

    function g:setString(text)
        g.shadow1:setString(text)
		g.shadow1:realign(-offset, -offset)
        g.label:setString(text)
		g.label:realign(0, 0)
    end

	function g:getString()
		return g.shadow1:getString()
	end

    function g:realign(x, y)
        g:setPosition(x, y)
    end

    function g:getContentSize()
        local siz = g.label:getContentSize()
		return CCSize(siz.width+1, siz.height+1)
    end

    function g:setColor(...)
        g.label:setColor(...)
    end

    function g:setShadowColor(...)
        g.shadow1:setColor(...)
    end

    function g:setOpacity(opacity)
        g.label:setOpacity(opacity)
        g.shadow1:setOpacity(opacity)
    end

    function g:setAnchorPoint(p)
        g.label:setAnchorPoint(p)
        g.shadow1:setAnchorPoint(p)
    end

    if x and y then
        g:setPosition(x, y)
    end

    return g
end

function ui.newTTFLabelWithOutline(params)
    assert(type(params) == "table",
           "[framework.ui] newTTFLabelWithOutline() invalid params")

    local color        = params.color or display.COLOR_WHITE
    local outlineColor = params.outlineColor or display.COLOR_BLACK
    local x, y         = params.x, params.y

    local g = display.newNode()
    params.size  = ui.translateFontSize(params.size)
    params.color = outlineColor
    params.x, params.y = 0, 0
	--[[
    g.shadow1 = ui.newTTFLabel(params)
    g.shadow1:realign(1, 0)
    g:addChild(g.shadow1)
    g.shadow2 = ui.newTTFLabel(params)
    g.shadow2:realign(-1, 0)
    g:addChild(g.shadow2)
    g.shadow3 = ui.newTTFLabel(params)
    g.shadow3:realign(0, -1)
    g:addChild(g.shadow3)
    g.shadow4 = ui.newTTFLabel(params)
    g.shadow4:realign(0, 1)
    g:addChild(g.shadow4)

    params.color = color
    g.label = ui.newTTFLabel(params)
    g.label:realign(0, 0)
    g:addChild(g.label)

    function g:setString(text)
        g.shadow1:setString(text)
		g.shadow1:realign(1, 0)

        g.shadow2:setString(text)
		g.shadow2:realign(-1, 0)

        g.shadow3:setString(text)
		g.shadow3:realign(0, -1)

        g.shadow4:setString(text)
		g.shadow4:realign(0, 1)

        g.label:setString(text)
		g.label:realign(0, 0)
    end

	function g:getString()
		return g.shadow1:getString()
	end

    function g:getContentSize()
        return g.label:getContentSize()
    end

    function g:setColor(...)
        g.label:setColor(...)
    end

    function g:setOutlineColor(...)
        g.shadow1:setColor(...)
        g.shadow2:setColor(...)
        g.shadow3:setColor(...)
        g.shadow4:setColor(...)
    end

    function g:setOpacity(opacity)
        g.label:setOpacity(opacity)
        g.shadow1:setOpacity(opacity)
        g.shadow2:setOpacity(opacity)
        g.shadow3:setOpacity(opacity)
        g.shadow4:setOpacity(opacity)
    end
--]]
	g.shadows = {}--{1,0},{-1,0},{0,-1},{0,1},
	local pos = {{1,0},{-1,0},{0,-1},{0,1}}
	for i=1,#pos do
		g.shadows[i] = ui.newTTFLabel(params)
		g.shadows[i]:realign(pos[i][1], pos[i][2])
		g:addChild(g.shadows[i])
	end

    params.color = color
    g.label = ui.newTTFLabel(params)
    g.label:realign(0, 0)
    g:addChild(g.label)

    function g:setString(text)
		for i=1,#g.shadows do
			g.shadows[i]:setString(text)
			g.shadows[i]:realign(pos[i][1], pos[i][2])
		end

        g.label:setString(text)
		g.label:realign(0, 0)
    end

	function g:getString()
		return g.label:getString()
	end
	--[[
    function g:getContentSize()
        return g.label:getContentSize()
    end
--]]
    function g:setAnchorPoint(p)
        g.label:setAnchorPoint(p)
        for i=1,#g.shadows do
            g.shadows[i]:setAnchorPoint(p)
        end
    end

    function g:getContentSize()
        local siz = g.label:getContentSize()
		return CCSize(siz.width+1, siz.height+1)
    end

    function g:setColor(...)
        g.label:setColor(...)
    end

    function g:setOutlineColor(...)
		for i=1,#g.shadows do
			g.shadows[i]:setColor(...)
		end
    end

    function g:setOpacity(opacity)
        g.label:setOpacity(opacity)
		for i=1,#g.shadows do
			g.shadows[i]:setOpacity(opacity)
		end
    end
    if x and y then
        g:setPosition(x, y)
    end

    return g
end

return ui
