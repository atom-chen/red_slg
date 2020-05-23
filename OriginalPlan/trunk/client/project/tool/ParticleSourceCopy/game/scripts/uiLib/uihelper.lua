--[[--
显示方面的实用、辅助函数库,后续添加的函数，也都按编号将函数签名添加在此，
方便其他人查看:
1.setDisplaySingleImage(sprite,imageUrl)
2.setDisplaySpriteFrame(sprite,imageUrl)
3.scaleToWH(sprite, width, height)
4.newMaskedSprite(__mask, __pic)
5.FRAME_INFO 
6.newScaleFrame(resType,w,h)
7.newTTFLabelWithOutline(params)
8.newShadowTTF(value,size,color,dim,align,valign)
]]

--声明组件
--button
EmptyButton = require("uiLib.component.button.EmptyButton")
Button = require("uiLib.component.button.Button")
LabelButton = require("uiLib.component.button.LabelButton")
BubbleButton = require("uiLib.component.button.BubbleButton")
ProgressBar = require("uiLib.component.progress.ProgressBar")


ScrollList = require("uiLib.component.scroll.ScrollList") --function ScrollList:ctor(direction,w,h,margin)

ScrollView = require("uiLib.component.scroll.ScrollView")
RichText = require("uiLib.component.text.RichText")
-------------------------------------------------------------新组件------------

TouchBase = require("uiLib.container.TouchBase")
UIInfo = require("uiLib.container.UIInfo")
UIAttachText = require("uiLib.container.UIAttachText")
UIImage = require("uiLib.container.UIImage")
UIAction = require("uiLib.container.UIAction")
UIButton = require("uiLib.container.UIButton")
UIProgressBar = require("uiLib.container.UIProgressBar")
UIGrid = require("uiLib.container.UIGrid")
UINode = require("uiLib.container.UINode")
FloatTip = require("uiLib.exui.FloatTip")

Rect9Cfg = ConfigMgr:requestConfig("rect9",nil,true)



local uihelper = {}

--[[--
    通过缩放设置精灵大小
  @param node CCSprite 节点
  @param width Number 宽
  @param height Number 高
]]
function uihelper.scaleToWH(sprite, width, height)
    local contentSize = sprite:getContentSize()
    local oldW = contentSize.width
    local oldH = contentSize.height
    sprite:setScaleX(width/oldW)
    sprite:setScaleY(height/oldH)
end

--[[
  通过lay的宁子和plist路径名来加载资源
]]
function uihelper.loadUIResurce( layname, plistPath )
  ResMgr:loadPvr(plistPath)
  local uiData = UIData:getUIData(layname)
  local uiNode = UINode.new()
  uiNode:setUIData(uiData)
  return uiNode
end

--[[
获取 资源的 9宫格rect]]
function uihelper.getRect( res )
    local rect = Rect9Cfg[res]
	if not rect then return nil end
    return CCRect(rect[1],rect[2],rect[3],rect[4])
end

--[[--
      实现一个图片的遮罩效果
  @param __mask String 遮罩精灵纹理名称,以#开头
  @param __pic String 被遮罩精灵纹理名称,以#开头
]]
function uihelper.newMaskedSprite(__mask, __pic)
  local __mb = ccBlendFunc:new()
  __mb.src = GL_ONE
  __mb.dst = GL_ZERO

  local __pb = ccBlendFunc:new()
  __pb.src = GL_DST_ALPHA
  __pb.dst = GL_ZERO

  local __maskSprite = display.newSprite(__mask):align(display.LEFT_BOTTOM, 0, 0)
  __maskSprite:setBlendFunc(__mb)

  local __picSprite = display.newSprite(__pic):align(display.LEFT_BOTTOM, 0, 0)
  __picSprite:setBlendFunc(__pb)

  local __maskSize = __maskSprite:getContentSize()
  local __canva = CCRenderTexture:create(__maskSize.width,__maskSize.height)
  __canva:begin()
  __maskSprite:visit()
  __picSprite:visit()
  __canva:endToLua()

  local __resultSprite = CCSpriteExtend.extend(
    CCSprite:createWithTexture(
      __canva:getSprite():getTexture()
    ))
    :flipY(true)
  return __resultSprite
end


--[[
  九宫拉伸 的 框  
  资源名   对应   rect
]]
uihelper.FRAME_INFO = {
  {--类型1：      透明黑
    res = "#frame_opacity_black.png"
    ,rect = CCRect(5,5,40,40) 
  }
  ,{--类型2：  透明蓝
    res ="#frame_opacity_blue.png"
    ,rect = CCRect(5,5,40,40)
  }
  ,{--类型3：  灰黄色
    res ="#frame_gray.png"
    ,rect = CCRect(1,1,28,28)
  }
  ,{--类型4：  深蓝色
    res ="#frame_dark_blue.png"
    ,rect = CCRect(4,4,32,32)
  }
  ,{--类型5：  透明 标题框
    res ="#frame_title1.png"
    ,rect = CCRect(0,2,102,30)
  }
  ,{--类型6：  透明 标题框
    res ="#frame_title0.png"
    ,rect = CCRect(0,2,413,30)
  }
  ,{--类型7：  弧形 文字底
    res ="#frame_ellipse_bg.png"
    ,rect = CCRect(10, 0, 20, 20)
  }
  ,{--类型8 活动蓝色条框
    res = "#frame_activity_blue.png"
    ,rect = CCRect(20, 20, 390, 166)
  }
  ,{--类型9：  黄金四角
    res ="#frame_golden_horn.png"
    ,rect = CCRect(23, 23, 3, 3)
  }
  ,{--类型10：  转盘下部分提示
    res ="#frame_bottom_desc.png"
    ,rect = CCRect(23, 23, 3, 3)
  }
}

--[[--
@param  type  根据 uihelper.FRAME_INFO 配置的资源    返回九宫拉伸 的 框  
@param   w   h 长宽
]]
function uihelper.newScaleFrame(resType,w,h)
  local info = uihelper.FRAME_INFO[resType];
  local frame = display.newScale9Sprite(info.res);
  frame.isScaleSprite = true
  frame:setCapInsets(info.rect);
  frame:setContentSize(CCSize(w,h));
  return frame
end

-- 修改原方法挂载的父节点为sprite,透明度等动画效果
function uihelper.newTTFLabelWithOutline(params)
    assert(type(params) == "table",
           "[framework.client.ui] newTTFLabelWithShadow() invalid params")

    local color        = params.color or display.COLOR_WHITE
    local outlineColor = params.outlineColor or display.COLOR_BLACK
    local x, y         = params.x, params.y

    local g = display.newSprite();
    params.size  = params.size
    params.color = outlineColor
    params.x, params.y = 0, 0
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
        g.shadow2:setString(text)
        g.shadow3:setString(text)
        g.shadow4:setString(text)
        g.label:setString(text)
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

    if x and y then
        g:setPosition(x, y)
        g:pixels()
    end

    return g
end

-- 描边文字简单创建方法
function uihelper.newShadowTTF( value,size,color,dim,align,valign )
    -- body
    local params = {}
    params.text = value;
    params.align = ui.TEXT_ALIGN_CENTER
    params.align = align or ui.TEXT_ALIGN_CENTER
    params.valign = valign or ui.TEXT_VALIGN_CENTER
    params.dimensions = dim or CCSize(100,23)
    params.size = size or 16
    params.color = color or display.COLOR_WHITE
    -- print(size.width, size.height) -- 输出 200, 100
    -- 容错
    if tonumber(params.dimensions.height)<=tonumber(size)+3 then
      params.dimensions.height=tonumber(size)+3;
    end
    return uihelper.newTTFLabelWithOutline(params);
end

--[[
  不同的进度条类型    ProgressBar
]]
uihelper.PROGRESSBAR_INFO = {
  {--类型1：角色经验条
    "#progress_type_1.png", --进度条资源
    "#progress_type_1bg.png", --背景资源
    CCRect(3, 3, 2, 2),--进度条矩形
    CCRect(0, 0, 12, 12),--背景矩形
    2,  --上、下间距
    2,  --左、右间距
    12  --默认高度
  },
  {--类型2：主界面体力
    "#progress_vitfg.png",  --进度条资源
    "#progress_vitbg.png",  --背景资源
    CCRect(8, 0, 34, 14),    --进度条矩形
    CCRect(8, 0, 44, 18),    --背景矩形
    2,  --上、下间距,
    2,   --左、右间距,
    18   --默认高度
  },
  {--类型3：主线副本 进度
    "#progress_dungeonfg.png",  --进度条资源
    "#progress_dungeonbg.png",  --背景资源
    CCRect(8,0,65,0),    --进度条矩形
    CCRect(9,0,25,0),    --背景矩形
    4,  --上、下间距,
    0,   --左、右间距,
    18   --默认高度
  }
}
--[[--
@param type  类型
@param width 进度条总长度
@param height 进度条高度，可不传有默认值
]]
function uihelper.newProgressBar(type, width, height)
  local marginTop = uihelper.PROGRESSBAR_INFO[type][5]
  local marginLeft = uihelper.PROGRESSBAR_INFO[type][6]
  local height = height or uihelper.PROGRESSBAR_INFO[type][7]
  local exp = ProgressBar.new(uihelper.PROGRESSBAR_INFO[type][1],
                uihelper.PROGRESSBAR_INFO[type][3],
                uihelper.PROGRESSBAR_INFO[type][2],
                uihelper.PROGRESSBAR_INFO[type][4],
                CCSize(width - marginLeft*2, height - marginTop*2),
                CCSize(width, height))
  exp:setContentSize(CCSize(width, height))
  return exp
end

--[[
  不同的按钮类型    Button
]]
uihelper.BUTTON_INFO = {
    login = {
            images={"#loginBtn.png"}
        }
}

--[[--
@param  type  根据 uihelper.BUTTON_INFO 配置的资源返回  对应的按钮
]]
function uihelper.newButton(text,type,priority,swol,fontSize,fontColor)
    local info = uihelper.BUTTON_INFO[type]
    local btn = UIButton.new(info.images,priority,swol)
    if text then
        btn:setText(text,fontSize or 25,"",fontColor or ccc3(255,255,255))
    end
    return btn
end


function uihelper.setDisplaySingleImage(sprite,imageUrl)
end
function uihelper.setDisplaySpriteFrame(sprite,imageUrl)
end
function uihelper.scaleToWH(sprite, width, height)
end
function uihelper.newMaskedSprite(__mask, __pic)
end

function uihelper.newScaleFrame(resType,w,h)
end
function uihelper.newTTFLabelWithOutline(params)
end
function uihelper.newShadowTTF(value,size,color,dim,align,valign)
end








return uihelper