--[[--
class: Window
inherit: CCLayer
desc: 半屏窗口,只有一个实例，通过show()、hide()方法显示
author:	hong
event:	
	
example:

    local rect = Window.getInsetSize(width, height)   --获取窗口内嵌区域,需要传宽高否则使用默认值
    
    Window.show(title, width, height)
    Window.setOpCallback(obj, callback)  --注册关闭按钮回调事件(只保留最新回调) 
]]

local Window = {}

Window.width = 400  
Window.height = 400 

Window.IMAGEBORDER = "#win_border.png"
Window.IMAGECLOSE = "#win_close1u.png"
Window.IMAGECLOSEDOWN = "#win_close1d.png"

function Window.init()
    --窗口窗体
    Window._winBorder = display.newScale9Sprite(Window.IMAGEBORDER)
    Window._winBorder:setCapInsets(CCRect(10, 55, 418, 4))
    
    --窗口关闭按钮    
    Window._closeBtn = Button.new(Window.IMAGECLOSE, Window.IMAGECLOSEDOWN)
        
    local labelParam = {
        text = title or "window",
        size = 30,
        color = ccc3(255, 174, 0),
        align = ui.TEXT_ALIGN_CENTER
    }
    Window._title = ui.newTTFLabel(labelParam)

    Window._titleSprite = display.newSprite()
    Window._titleSprite:setAnchorPoint(ccp(0.5, 0.5))

    Window._mask = nil

    Window._layer = display.newLayer()
    Window._layer:setPosition(display.cx, display.cy)
    Window._layer:addChild(Window._winBorder)
    Window._layer:addChild(Window._closeBtn)
    Window._layer:addChild(Window._title)
    Window._layer:addChild(Window._titleSprite)
    
    Window._layer:retain()

    ViewMgr.setOnMask(Window._layer, Mask.TYPE_UI) -- 修改优先级
end

--[[--
    设置标题
    @param title string 标题
]]
function Window.setTitle(title)
    if string.sub(title, -4, -1) == ".png" then -- png的图片文字
        display.setDisplaySpriteFrame(Window._titleSprite, title)
        Window._title:setString("")
    elseif title ~= nil then
        display.setDisplaySingleImage(Window._titleSprite)
        Window._title:setString(title)
    else
        display.setDisplaySingleImage(Window._titleSprite)
        Window._title:setString("window")
    end
end

--[[--
    获取窗口内嵌区域
    @return {x, y, width, height}
]]
function Window.getInsetSize(w, h)
    local w = w or Window.width
    local h = h or Window.height
    local rect = {
        x = (CONFIG_SCREEN_WIDTH - w) / 2 + 8,
        y = (CONFIG_SCREEN_HEIGHT - h) / 2 + 18,
        width = w - 16,
        height = h - 63
    }

    return rect
end

--[[--
    显示全屏窗口
    @param title string 标题
]]
function Window.show(title, width, height)
    if Window._layer:getParent() == nil then
        Window._mask = ViewMgr.getMask(Mask.TYPE_UI)
        if not Window._mask:getParent() then
            ViewMgr.notifyRoot:addChild(Window._mask)
        end
        
        ViewMgr.notifyRoot:addChild(Window._layer)
    else
        echo("window repeat show")
    end

    Window.setTitle(title)

    Window._resize(width, height)
end

--[[--
    重设窗口大小
]]
function Window._resize(w, h)
    local w = w or Window.width
    local h = h or Window.height

    Window._winBorder:setContentSize(CCSize(w, h))
    Window._closeBtn:setPosition(w/2-42, h/2-40)
    Window._title:setPosition(0, h/2-20)
    Window._titleSprite:setPosition(0, h/2-20)
end

--[[--
    隐藏全屏窗口
]]
function Window.hide()
    if Window._layer:getParent() == ViewMgr.notifyRoot  then
        ViewMgr.notifyRoot:removeChild(Window._layer)

        ViewMgr.notifyRoot:removeChild(Window._mask)
    end

    Window._closeBtn:removeAllEventListeners()    --移除回调方法
end

--[[--
    注册关闭按钮事件
    @param obj object 回调对象
    @param callback function 回调方法
]]
function Window.setOpCallback(obj, callback)
    Window._closeBtn:addEventListener(Event.MOUSE_UP, {obj, callback})
end

return Window