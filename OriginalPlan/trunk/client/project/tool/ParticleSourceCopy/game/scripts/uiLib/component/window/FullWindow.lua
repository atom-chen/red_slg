--[[--
class: FullWindow
inherit: CCLayer
desc: 全屏窗口,只有一个实例，通过show()、hide()方法显示
author:	hong
event:

example:

    --[=[--注意方法调用是用"."]=]

    local rect = FullWindow.getInsetSize(hasTab)    --获取窗口内嵌区域

    FullWindow.show(title)     --显示全屏窗口或者plist图片，注意不用加“#”
    FullWindow.showTop()   --只显示框体和返回按钮

    FullWindow.showButton(panelList, curPanel)  --显示底部标签按钮

    FullWindow.setOpCallback(obj, callback)    --注册关闭按钮回调事件(只保留最新回调)
]]

local FullWindow = {}

FullWindow.IMAGETITLE = "#win_title.png"
FullWindow.IMAGEBACKGROUND = "ui/fullBg.jpg"
FullWindow.IMAGEBACKGROUND2 = "ui/fullBg2.jpg"
FullWindow.IMAGEBACKGROUND3 = "ui/fullBg3.jpg"
FullWindow.IMAGEBORDER = "#full_win_border.png"

FullWindow.IMAGEBACK = "#tabs_back0.png"
FullWindow.IMAGEBACKDOWN = "#tabs_back1.png"

function FullWindow.init()
    local width = CONFIG_SCREEN_WIDTH
    local height = CONFIG_SCREEN_HEIGHT

    --第一层：标题背景、标题文字

    --标题背景
    local titleBg = display.newSprite(FullWindow.IMAGETITLE)
    local titleW = titleBg:getContentSize().width
    local titleH = titleBg:getContentSize().height
    titleBg:setPosition(display.cx, display.cy-30)
    titleBg:setAnchorPoint(CCPoint(1,1))

    local labelParam = {
        text = "full window",
        size = 30,
        color = ccc3(255, 174, 0),
        x = titleW / 2,
        y = titleH / 2,
        dimensions = CCSize(titleW, titleH),
        align = ui.TEXT_ALIGN_CENTER
    }
    FullWindow._title = ui.newTTFLabel(labelParam)
    titleBg:addChild(FullWindow._title)

    FullWindow._titleSprite = display.newSprite()
    FullWindow._titleSprite:setPosition(ccp(titleW / 2, titleH / 2))
    titleBg:addChild(FullWindow._titleSprite)

    --默认背景
    FullWindow._background = ResImage.new(FullWindow.IMAGEBACKGROUND)
    FullWindow._background:setAnchorPoint(ccp(0, 0))
    FullWindow._background:setPosition(-display.cx, -display.cy)

    FullWindow._layerBottom = display.newLayer()
    FullWindow._layerBottom:setPosition(display.cx, display.cy)
    FullWindow._layerBottom:addChild(FullWindow._background)
    FullWindow._layerBottom:addChild(titleBg)

    --第二层：边框、关闭按钮
    FullWindow.bottomBtn = BottomTabButton.new()
    FullWindow.bottomBtn:setZOrder(1)
    FullWindow.bottomBtn:retain()
    FullWindow.bottomBtn:addEventListener(Event.TAB_CHANGE, FullWindow._change)
    FullWindow.bottomBtn:setButtonList({"PARTNER", "ROLE", "RECRUIT"})

    --边框
    local winBorder = display.newScale9Sprite(FullWindow.IMAGEBORDER)
    winBorder:setCapInsets(CCRect(69, 77, 2, 2))
    winBorder:setContentSize(CCSize(width, height))
    winBorder:setAnchorPoint(CCPoint(0, 0))
    winBorder:setZOrder(2)

    FullWindow._closeBtn = Button.new(FullWindow.IMAGEBACK, FullWindow.IMAGEBACKDOWN)
    FullWindow._closeBtn:setAnchorPoint(CCPoint(1,1))
    FullWindow._closeBtn:setPosition(display.width-9, display.height-13)
    FullWindow._closeBtn:setZOrder(3)
    FullWindow._closeBtn:setSwallowTouches(true)

    FullWindow._layerTop = display.newLayer()
    FullWindow._layerTop:addChild(winBorder)
    FullWindow._layerTop:addChild(FullWindow._closeBtn)

    FullWindow._layerBottom:retain()
    FullWindow._layerTop:retain()

end

function FullWindow._change(event)
    local index = event.index
    local panelName = FullWindow.bottomBtn.panelList[index]
    ViewMgr.closeAllPanels()
    ViewMgr.open(Panel[panelName])  
end

--[[--
    设置标题
    @param title string 标题
]]
function FullWindow.setTitle(title)
    if string.sub(title, -4, -1) == ".png" then -- png的图片文字
        display.setDisplaySpriteFrame(FullWindow._titleSprite, title)
        FullWindow._title:setString("")
    elseif title ~= nil then
        display.setDisplaySingleImage(FullWindow._titleSprite)
        FullWindow._title:setString(title)
    else
        display.setDisplaySingleImage(FullWindow._titleSprite)
        FullWindow._title:setString("full window")
    end
end

function FullWindow.setBackground(image)
    display.setDisplaySingleImage(FullWindow._background, image)
end

--[[--
    获取窗口内嵌区域
    @param hasTab Boolean 是否有底部按钮
    @return {x, y, width, height}
]]
function FullWindow.getInsetSize(hasTab)
    local tabHeight = 0
    if hasTab then
        tabHeight = BottomTabButton.HEIGHT
    end
    local rect = {
        x = 4,
        y = 4 + tabHeight,
        width = CONFIG_SCREEN_WIDTH - 8,
        height = CONFIG_SCREEN_HEIGHT - 92 - tabHeight
    }

    return rect
end

--[[--
    获取标题按钮位置
    @param hasTab Boolean 是否有底部按钮
    @return {x, y} CCPoint
]]
function FullWindow.getButtonPoint()
    local x = 18
    local y = CONFIG_SCREEN_HEIGHT - 78
    return ccp(x,y)
end

--[[--
    显示底部页面按钮，详细用法查看BottomTabButton
]]
function  FullWindow.showButton(panelList, curPanel)
    FullWindow.bottomBtn:setButtonList(panelList, curPanel)
    if not FullWindow.bottomBtn:getParent() then
       FullWindow._layerTop:addChild(FullWindow.bottomBtn)
    end
end

--[[--
    隐藏底部页面按钮
]]
function  FullWindow.hideButton()
    if FullWindow.bottomBtn:getParent() == FullWindow._layerTop then
        FullWindow._layerTop:removeChild(FullWindow.bottomBtn)
    end
end

--[[--
    显示全屏窗口
    @param title string 标题
]]
function FullWindow.show(title)
    FullWindow.showTop()

    if FullWindow._layerBottom:getParent() == nil then
        ViewMgr.hudTopRoot:addChild(FullWindow._layerBottom)
    else
        echo("full window repeat show")
    end

	--关掉所有场景界面
	ViewMgr.closeAllHome()

    FullWindow.setTitle(title)
end

--[[--
    显示边框和返回按钮
]]
function FullWindow.showTop()
    if FullWindow._layerBottom:getParent() == nil and FullWindow._layerTop:getParent() == nil then
        ViewMgr.popupTopRoot:addChild(FullWindow._layerTop)
    end
end

--[[--
    隐藏全屏窗口
]]
function FullWindow.hide()
    if FullWindow._layerBottom:getParent() == ViewMgr.hudTopRoot  then
        ViewMgr.hudTopRoot:removeChild(FullWindow._layerBottom)
    end

    if FullWindow._layerTop:getParent() == ViewMgr.popupTopRoot then
        ViewMgr.popupTopRoot:removeChild(FullWindow._layerTop)
    end

    FullWindow.hideButton() --隐藏底部按钮
    display.setDisplaySpriteFrame(FullWindow._titleSprite) --清空标题纹理
end

--[[--
    注册关闭按钮事件
    @param obj object 回调对象
    @param callback function 回调方法
]]
function FullWindow.setOpCallback(obj, callback)
    FullWindow._closeBtn:removeAllEventListeners()    --移除回调方法
    FullWindow._closeBtn:addEventListener(Event.MOUSE_UP, {obj, callback})
end

function FullWindow.changeTouchPriority(priority)
    -- ViewMgr.setOnMask(FullWindow._layerTop, priority)
    FullWindow._closeBtn:changeTouchPriority(priority-1)
    FullWindow.bottomBtn:changeTouchPriority(priority-1)
end

return FullWindow