
--无依赖组件
UIInfo = game_require("uiLib.container.UIInfo")
UIHorizontalContainer = game_require("uiLib.container.UIHorizontalContainer")
UIVerticalContainer = game_require("uiLib.container.UIVerticalContainer")

--声明组件
--button
ScrollView = game_require("uiLib.component.scroll.ScrollView")
ScrollList = game_require("uiLib.component.scroll.ScrollList") --function ScrollList:ctor(direction,w,h,margin)
ScrollListEx = game_require("uiLib.component.scroll.ScrollListEx")
ScrollPageEx = game_require("uiLib.component.scroll.ScrollPageEx")
TapBar = game_require("view.common.TapBar")
RichText = game_require("uiLib.component.richText.RichText")
-------------------------------------------------------------新组件------------
RichTextContainer = game_require('uiLib.container.RichTextContainer')
UIText = game_require("uiLib.container.UIText")
TouchBase = game_require("uiLib.container.TouchBase")
TouchLayer = game_require("uiLib.container.TouchLayer")
UIEditBox = game_require("uiLib.container.UIEditBox")
UIUserDataProtocol = game_require("uiLib.container.UIUserDataProtocol")
UIAttachText = game_require("uiLib.container.UIAttachText")
UISimpleText = game_require("uiLib.container.UISimpleText")
UIImage = game_require("uiLib.container.UIImage")
UIClipImage = game_require("uiLib.container.UIClipImage")
UIAction = game_require("uiLib.container.UIAction")
UIButton = game_require("uiLib.container.UIButton")
UIProgressBar = game_require("uiLib.container.UIProgressBar")
UIDragedProgressBarExtend = game_require("uiLib.container.UIDragedProgressBarExtend")
UIProgressEx = game_require("uiLib.container.UIProgressEx")
UISimpleProgress = game_require("uiLib.container.UISimpleProgress")
UIBlood = game_require("uiLib.container.UIBlood")
UIGrid = game_require("uiLib.container.UIGrid")
UIItemGrid = game_require("uiLib.container.UIItemGrid")
UIGridLayoutProtocol = game_require("uiLib.container.UIGridLayoutProtocol")
UIGroup = game_require("uiLib.container.UIGroup")
UITabButton = game_require("uiLib.container.UITabButton")
UIFrame = game_require("uiLib.container.UIFrame")
UINode = game_require("uiLib.container.UINode")
UISimpleTimer = game_require("uiLib.container.UISimpleTimer")
UICountDown = game_require("uiLib.container.UICountDown")
UIDelayCall = game_require('uiLib.container.UIDelayCall')
UIVList = game_require("uiLib.container.UIVList")
UIHList = game_require("uiLib.container.UIHList")
UIVGrid = game_require("uiLib.container.UIVGrid")
UIRedPointExtend = game_require("uiLib.container.UIRedPointExtend")
UIText = game_require("uiLib.container.UIText")
UIMap = game_require("uiLib.container.UIMap")

UIFlowText = game_require("uiLib.container.UIFlowText")
UIFloatText = game_require("uiLib.container.UIFloatText")

UIOpacityAction = game_require("uiLib.container.UIOpacityAction")
UIDelegate = game_require("uiLib.container.UIDelegate")

ShowInfoTipExtend = game_require("uiLib.exui.ShowInfoTipExtend")
ChildEffectExtend = game_require("uiLib.exui.ChildEffectExtend")
GuideExtend = game_require('uiLib.exui.guide.GuideExtend')

ArtNumber = game_require("uiLib.component.ArtNumber")

SimpleMagic = game_require("uiLib.exui.SimpleMagic")

GuideArrow = game_require("uiLib.exui.guide.GuideArrow")
GuideTip = game_require("uiLib.exui.guide.GuideTip")
AutoGuide = game_require("uiLib.exui.guide.AutoGuide")
AutoTip = game_require("uiLib.exui.guide.AutoTip")

ComHead = game_require("uiLib.exui.ComHead")

MiddleTile = game_require("uiLib.exui.MiddleTile")
ClipPanelUI = game_require("uiLib.component.ClipPanelUI")
SchedulerHandlerExtend  = game_require('uiLib.exui.SchedulerHandlerExtend')
UIMagic = game_require("uiLib.container.UIMagic")
local FloatTip = game_require("uiLib.exui.FloatTip")

local uihelper = {}

uihelper.NetSprite = game_require("uiLib.exui.NetSprite")

function uihelper:init()
    local cfg = ConfigMgr:requestConfig("rect9",nil,true)
    uihelper.Rect9Cfg,uihelper.defaultRect9Size = cfg.rect9,cfg.defaultSize
end

--获取 vip 美术字
function uihelper.getVipArtNum(vip)
	return ArtNumber.new("com_nu_",vip)
end

--飘字
function floatText( text,color,offset )
	--print(debug.traceback())
    if not text then
        return
    end

--	local tip = uihelper.tip
--    if tip == nil then
        tip = FloatTip.new(nil,24,color or white)
        uihelper.tip = tip
--    end
    if tip:getParent() == nil then
        local layer = ViewMgr:getGameLayer(Panel.PanelLayer.ERROR_LAYER)
        layer:addChild(tip,-1)
    end
    tip:setColor(color or UIInfo.color.white)
    tip:startFloat(text,offset)
end

--[[

--]]
function uihelper.floatText2(params)
	local text
	local duration
	local offset
	local magic
	if type(params) == "string" then
		text = params
	else
		text = params.text
		duration = params.duration
		offset = params.offset
		magic = params.magic
	end
	local tip = UIText.new(display.width, display.height, 22, nil, UIInfo.color.white, UIInfo.alignment.center, UIInfo.alignment.center, true)
	local layer = ViewMgr:getGameLayer(Panel.PanelLayer.ERROR_LAYER)
    layer:addChild(tip,-1)
	tip:setText(text)
	local magicNode
	if magic then
		magicNode = SimpleMagic.new(magic)
		magicNode:setParent(tip)
	end
	local pos
	if offset then
		pos = ccp(offset.x or 0, offset.y or 0)
		tip:setPosition(pos)
	else
		tip:setPositionY(display.height/10)
	end
	UIDelayCall.new(duration or 1.2, function()
			if magicNode then
				magicNode:dispose()
				magicNode = nil
			end
			tip:dispose()
			uihelper.call(params.onEnd)
		end, true)
end

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
--获取 资源的 9宫格rect]]
function uihelper.getRect( res )
    local rect = uihelper.Rect9Cfg[res]
	  if not rect then return nil end
    return CCRect(rect[1],rect[2],rect[3],rect[4])
end

function uihelper.setRect9(xsprite, res)
	if not res then return end
	local rect9 = uihelper.getRect(res)
	if rect9 then
		xsprite:setRect9(rect9)
	end
end

function uihelper.getRect9DefaultSize( res )
    local size = uihelper.defaultRect9Size[res]
	if size then
		return CCSize(size[1],size[2])
	else
		return nil
	end
end

--[[
@brief 添加子节点到父节点的指定锚点处
--]]
function uihelper.addChild(parent, child, anchor, zindex)
	if zindex then
		parent:addChild(child, zindex)
	else
		parent:addChild(child)
	end

	local an = anchor or ccp(0.5, 0.5)
	local siz = parent:getContentSize()

	child:setPosition(ccp(siz.width * an.x, siz.height * an.y))
end

function uihelper.addChildCenter(parent, child, zindex)
	if zindex then
		parent:addChild(child, zindex)
	else
		parent:addChild(child)
	end

	local an = anchor or ccp(0.5, 0.5)
	local siz = parent:getContentSize()

	child:setPosition(ccp(siz.width * an.x, siz.height * an.y))
end

--保持原是位置的anchor
function uihelper.setFixedAnchor(node, anchor)
	local an = node:getAnchorPoint()
	if an.x == anchor.x and an.y == anchor.y then
		return
	end

	local x,y = node:getPosition()
	local siz = node:getContentSize()
	x = x+(-an.x+anchor.x)*siz.width
	y = y+(-an.y+anchor.y)*siz.height

	node:setAnchorPoint(anchor)
	node:setPosition(ccp(x,y))
end

--将node的position转换为newParent对应的坐标
function uihelper.convertPosition(node, newParent)
	local wsrcPos = node:getParent():convertToWorldSpace(ccp(node:getPosition()))
	local lsrcPos = newParent:convertToNodeSpace(wsrcPos)
	return lsrcPos
end

function uihelper.getPositionWorldSpace(node)
	return node:getParent():convertToWorldSpace(ccp(node:getPosition()))
end

function uihelper.setWorldPosition(node, pos)
	local parent = node:getParent()
	if parent then
		local p = parent:convertToNodeSpace(pos)
		node:setPosition(p)
	end
end

--[[
@brief 调用
--]]
function uihelper.call(func, ...)
	local funcstr = type(func)
	if funcstr == "function" then
		return func(...)
	elseif funcstr == "table" then
		local t = func[1]
		local fun = func[2]
		return fun(t, ...)
	end
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

--判定一个 在 scrollView 内的 点击是否有效
function uihelper.isTouchInView(node,x,y)
  local parent = node:getParent()
  while parent ~= nil do
    if tolua.isTypeOf(parent,"CCScrollView") then
      parent = tolua.cast(parent,"CCScrollView")
      local rect = parent:getViewRect()
      if rect:containsPoint(ccp(x,y)) then
        -- return true  --在可视范围内
      else
        return false   --在看不到的地方
      end
    end
    parent = parent:getParent()
  end
  return true
end

function uihelper:getIntersectsRect( rect1, rect2 )
    function max(a,b)
        if a>b then
         return a else return b end
    end
    function min(a,b)
        if a<b then
         return a else return b end
    end

    local x = max(rect1.origin.x, rect2.origin.x);
	local y = max(rect1.origin.y, rect2.origin.y);
	local r = min(rect1.origin.x + rect1.size.width, rect2.origin.x + rect2.size.width);
	local t = min(rect1.origin.y + rect1.size.height, rect2.origin.y + rect2.size.height);
	local w = max(r-x, 0);
	local h = max(t-y, 0);
    return CCRect(x, y, w, h)
end

function uihelper:zzlog( ... )
  --print( "zhangzhen:",...)
  local t = {...}
  local str = ""
  for i,v in ipairs(t) do
	str = str .. tostring(v)
  end
  CCLuaLog(str)
end


-- 将原来有序的列表中的1项变化， 而导致列表可能无序。
-- 对这一项重新排序使之再次有序
-- comp <语义。 不能是<=
function uihelper.reSort(list, pos, comp)
	if pos > #list then
		pos = #list
	end
	if pos < 1 then
		pos = 1
	end
	for i=pos, #list-1 do
		if comp(list[i], list[i+1]) then
			break;
		else
			if not comp(list[i+1], list[i]) then
				break;
			end
			local tmp = list[i]
			list[i] = list[i+1]
			list[i+1] = tmp
		end
	end

	for i=pos, 2, -1 do
		if comp(list[i-1], list[i]) then
			break;
		else
			if not comp(list[i], list[i-1]) then
				break;
			end
			local tmp = list[i]
			list[i] = list[i-1]
			list[i-1] = tmp
		end
	end
end

--[[--
  设置 ccnode 透明度  对所有孩子有效
  @param  node   CCNode  容器
  @param  opacity   透明度
]]
function uihelper.setOpacity(node,opacity)
  node:setOpacity(opacity)
  local children = node:getChildren();
  if children then
    for i=0,children:count()-1 do
      local child = children:objectAtIndex(i);
      child = tolua.cast(child,"CCNode")
      uihelper.setOpacity(child,opacity);
    end
  end
end

--[[--
  设置 ccnode 颜色  对所有孩子有效
  @param  node   CCNode  容器
  @param  color   透明度
]]
function uihelper.setColor(node,color)
  node:setColor(color)
  local children = node:getChildren();
  if children then
    for i=0,children:count()-1 do
      local child = children:objectAtIndex(i);
      child = tolua.cast(child,"CCNode")
      uihelper.setColor(child,color);
    end
  end
end


function uihelper.setPadding(padding, newPadding)
	if not padding then
		padding = {}
	end

	local tmpPadding
	if newPadding == nil then
		newPadding = 0
	end
	if type(newPadding) == "number" then
		local pad
		if newPadding < 0 then
			pad = 0
		else
			pad = newPadding
		end
		tmpPadding = {left=pad, right=pad, bottom=pad, top=pad}
	else
		tmpPadding = newPadding
	end
	padding.left = tmpPadding.left or padding.left
	padding.right = tmpPadding.right or padding.right
	padding.bottom = tmpPadding.bottom or padding.bottom
	padding.top = tmpPadding.top or padding.top

	return padding
end

function uihelper.setPaddingScale(padding, scaleX, scaleY)
	if not padding then return end
	local scale
	if not scaleY then
		scale = scaleX
		for k,v in pairs(padding) do
			padding[k] = math.floor(v*scale)
		end
	else
		if padding.left then
			padding.left = math.floor(padding.left*scaleX)
		end
		if padding.right then
			padding.right = math.floor(padding.right*scaleX)
		end
		if padding.bottom then
			padding.bottom = math.floor(padding.bottom*scaleY)
		end
		if padding.top then
			padding.top = math.floor(padding.top*scaleY)
		end
	end

	return padding
end

--按钮在某节点下方的时候，点击到该节点之上的时候， 不响应时间
function uihelper.touchContainsFunc(node)
	function contains(self, x, y)
		--[[
		local parent = self:getParent()
		local pos = parent:convertToNodeSpace(ccp(x,y))
		local rect = self:getTouchRect()
		if rect:containsPoint(pos) then
		--]]
		if TouchBase.touchContains(self, x, y) then
			local npos = node:getParent():convertToNodeSpace(ccp(x,y))
			local nrect = node:boundingBox()
			return not tobool(nrect:containsPoint(npos))
		else
			return false
		end
	end
	return contains
end

--从资源表直接获取一个 xsprite出来   有剪切的话也会加上剪切
function uihelper.newXSpriteByRes(id, suffix)
    local resInfo = ResCfg:getRes(id, suffix)
    local rect = ResCfg:getClipRect(id)
    local sp = display.newXSprite(res)
    if rect then
        sp:setClipRect(rect)
    end
    return sp
end

function uihelper.setScaleStable(node, scaleX, scaleY)
	local pos = ccp(node:getPosition())
	local size = node:getContentSize()
	if scaleX and scaleX == scaleY then
		node:setScale(scaleX)
		if scaleX < 0 then
			local p = ccp(pos.x-scaleX*size.width, pos.y-scaleY*size.height)
			node:setPosition(p)
		end
	elseif scaleX and scaleY then
		node:setScaleX(scaleX)
		node:setScaleY(scaleY)
		if scaleX < 0 then
			local nx = pos.x-scaleX*size.width
			node:setPositionX(nx)
		end

		if scaleY < 0 then
			local ny = pos.y-scaleY*size.height
			node:setPositionY(ny)
		end
	elseif scaleX then
		node:setScaleX(scaleX)
		if scaleX < 0 then
			local nx = pos.x-scaleX*size.width
			node:setPositionX(nx)
		end
	elseif scaleY then
		node:setScaleY(scaleY)
		if scaleY < 0 then
			local ny = pos.y-scaleY*size.height
			node:setPositionY(ny)
		end
	end
end

function uihelper.setClipImage(url, parent, node)
	if not node then
		node = display.newXClipSprite()
		parent:addChild(node)
	end
	node:setSpriteImage(url, "#com_renwu_activity_4_a.png", true)
	node:setAnchorPoint(ccp(0.5, 0.5))
	local siz = node:getContentSize()
	local parentSize = parent:getContentSize()
	node:setPosition(ccp(parentSize.width/2, parentSize.height/2))
	node:setScale(parentSize.width/siz.width)

	return node
end

function uihelper.getActionTime(res,actionName,frequency)
    local aInfo = AnimationMgr:getActionInfo(res,actionName)
    return aInfo:getFrameLength()/(frequency or aInfo.frequency)  --总共多少帧
end

function uihelper:getActionFram(res,actionName)
	local aInfo = AnimationMgr:getActionInfo(res,actionName)
	return aInfo.frequency
end

function uihelper.contains(node, x, y)
	local parent = node:getParent()
	local pos = parent:convertToNodeSpace(ccp(x,y))
	return node:boundingBox():containsPoint(pos)
end

function uihelper.setVisible(uiNode, names, visible, enable)
	local uiNode = uiNode.node
	visible = tobool(visible)
	if enable ~= nil then
		enable = tobool(enable)
		for i,name in ipairs(names) do
			local node = uiNode[name]
			node:setVisible(visible)
			if node.setEnable then
				node:setEnable(enable)
			end
		end
	else
		for i,name in ipairs(names) do
			local node = uiNode[name]
			node:setVisible(visible)
		end
	end
end

function uihelper.newLabel(text, fontSize, fontColor, shadow, outline)
	local uitext
	if shadow then
		uitext = ui.newTTFLabelWithShadow({
			valign = ui.TEXT_VALIGN_BOTTOM, size=fontSize, color=fontColor, text=text})
	elseif outline then
		local outlineColor = UIInfo.getOutlineColor(outline)
		uitext = ui.newTTFLabelWithOutline({
			valign = ui.TEXT_VALIGN_BOTTOM, size=fontSize, color=fontColor,outlineColor=outlineColor, text=text})
	else
		uitext = ui.newTTFLabel({
			valign = ui.TEXT_VALIGN_BOTTOM, size=fontSize, color=fontColor, text=text})
	end
	uitext:setAnchorPoint(ccp(0,0))
	return uitext
end

--[[
@parent
@zorder
@star
@zorder
@size
@starImage
--]]
function uihelper.addStar(params)
	dump(params)
	local star = params.star
	local maxStar = params.maxStar
	local count = star
	if maxStar then
		count = maxStar
	end
	local scale = tobool(params.fit)


	local parent = params.parent
	local siz = params.size or parent:getContentSize()
	local width = siz.width
	local step = siz.width/(count+1)
	local maxWidth = width/(count-1)+1--CCSize(width/4+1, width/4+1)
	local estars = {}
	local x = 0
	local y = siz.height/2
	local zorder = params.zorder or 1
	for i=1,star do
		local node = UIImage.new(params.starImage or '#leader_xx.png')
		x = x + step
		node:setPosition(x, y)
		table.insert(estars, node)
	end
	if maxStar then
		for i=star+1,maxStar do
			local node = UIImage.new(params.darkStarImage)
			x = x + step
			node:setPosition(x, y)
			table.insert(estars, node)
		end
	end
	--[[[
	local siz = parent:getContentSize()
	local step = siz.width/(count+1)
	local x = 0
	local y = siz.height/2
	for i = 1, count do
		self._stars[i] = UIImage.new('#hero_xing1.png')
		self._stars[i]:setAnchorPoint(ccp(0.5, 0.5))
		self.uiNode.node['Node_star']:addChild(self._stars[i])
		x = x + step
		self._stars[i]:setPosition(ccp(x,y))
	end
	--]]
	-- [[
	print(#estars)
	for i,node in ipairs(estars) do
		node:setAnchorPoint(ccp(0.5, 0.5))
		if scale then
			local isiz = node:getContentSize()
			if isiz.width > maxWidth then
			--	isiz = maxSize
			--	node:updateSize(isiz)
				node:setScale(maxWidth/isiz.width)
			end
		end

		if zorder then
			parent:addChild(node, zorder)
		else
			parent:addChild(node)
		end
	end
	print(parent:getChildrenCount())
	--]]
	return estars
end

function uihelper.clearChildren(chidren)
	if not chidren then return end
	for i,child in ipairs(chidren) do
		if child.dispose then
			child:dispose()
		else
			child:removeFromParent()
		end
	end
end

function uihelper.getOriginalSize(res)
    if string.byte(res) == 35 then -- first char is #
       res = string.sub(res, 2)
	end
	local frame = display.newSpriteFrame(res)
	if frame then
		return frame:getOriginalSize()
	end
end


function uihelper.relativePosition(node, parent, offset)
	local pos = node:convertToNodeSpace(parent.pos)
	local psiz = parent.size
	dump(node)
	print('function uihelper.calcPosition(node, parent, offset)', parent.pos.x, parent.pos.y, pos.x, pos.y, psiz.width, psiz.height)
	local siz = node:getContentSize()

	if pos.x + offset.x + psiz.width + siz.width > display.width/2 then
		pos.x = pos.x - offset.x - siz.width
		pos.y = pos.y + offset.y
	else
		pos.x = pos.x + offset.x + psiz.width
		pos.y = pos.y + offset.y
	end

	if pos.y + offset.y + psiz.height > display.height/2 then
		pos.y = display.height/2 - psiz.height - offset.y
	elseif pos.y + offset.y < -display.height/2 then
		pos.y = 0 + offset.y
	else
		pos.y = pos.y + offset.y
	end

	return pos
end

--[[
itemId
panelName=
pos worldSpace
size
x
y

--]]
function uihelper.openDungeon(params)
	print("function RAHeroQualityD:openDungeon(dungeon)")
	local func = function (dungeon,panelName)
		local panel = ViewMgr:getPanel(panelName)
		local params
		if panel then
			params = panel:summary()
		end
		if params.closeSelf and panel then
			panel:closeSelf()
		end
		ViewMgr:open(Panel.DUNGEON_ENTRY, {controlParam = {name = 'CLASSIC_DUNGEON_DUNGEON_SELECT',param = {dungeonId=dungeon}}},tobool(params), params)
	end

	ViewMgr:open(Panel.HERO_QUALITY_TIPS, {parent={pos=params.pos, size=params.size},
			x=params.x, y=params.y, itemId=params.itemId, panelName=params.panelName, dungeonCallback=func})
end

--[[
callback
close closePanelNames
--]]
function uihelper.openOre(params)
    local newParams
    if params then
        local panels = params.close
        local callback = nil
        if panels then
            local func = params.callback
            callback = function(...)
            print("local callback = function(...) uihelper.openOre")
            if type(panels) == "string" then
                ViewMgr:close(panels)
                elseif type(panels) == "table" then
                    for i,name in ipairs(panels) do
                        ViewMgr:close(name)
                    end
                end
                uihelper.call(func, ...)
            end
        end
		local t = params.type
		if type(t) == "string" then
			local typeIndex = {crystal=1,iron=2,Uranium=3}
			if typeIndex[t] then
				t = typeIndex[t]
			end
		end
        newParams = {callback=callback, type = t}
    else
        newParams = {type = 1}
    end
    dump(newParams)
    ViewMgr:open(Panel.LACK_ORE_PANEL, newParams,false)
end

function uihelper.openVip( params )
	local btnList = {{text=LangCfg:getString('common', 2)
		,callfun=function() ViewMgr:open(Panel.VIP,{panel = Panel.VIP_CHARGE_SHOP}) end}
	, {text=LangCfg:getString('common', 6)}}
	openTipPanel(LangCfg:getCommonInfoById(101), btnList, title)
end

function uihelper.openGold( params )
	local btnList = {{text=LangCfg:getString('common', 2)
		,callfun=function() ViewMgr:open(Panel.VIP,{panel = Panel.VIP_CHARGE_SHOP}) end}
	, {text=LangCfg:getString('common', 6)}}
	openTipPanel(LangCfg:getCommonInfoById(100), btnList, title)
end

function uihelper.openCoin( params )
    local newParams
    if params then
        local panels = params.close
        local func = params.callback
        local callback = function(...)
            print("local callback = function(...) uihelper.openCoin")
            if type(panels) == "string" then
                ViewMgr:close(panels)
            elseif type(panels) == "table" then
                for i,name in ipairs(panels) do
                    ViewMgr:close(name)
                end
            end
            uihelper.call(func, ...)
        end
        newParams = {callback=callback}
    else
        newParams = nil
    end
    ViewMgr:open(Panel.COIN_LACK, newParams,false)
end

function uihelper.costCoin(coin)
	local coinColor
	if coin > RoleModel:getCoin() then
		coinColor = UIInfo.color_string.red
	else
		coinColor = UIInfo.color_string.white
	end
	return string.format(LangCfg:getString('common', 'costCoin'), UIInfo.color_string.blue, coinColor, coin)
end

function uihelper.costCoin1(coin)
	local coinColor
	if coin > RoleModel:getCoin() then
		coinColor = UIInfo.color_string.red
	else
		coinColor = UIInfo.color_string.white
	end
	return string.format("<font color=%s>%s</font><img src=#com_jb.png></img>", coinColor, coin)
end

function uihelper.costGold(gold)
	local goldColor
	if gold > RoleModel:getGold() then
		goldColor = UIInfo.color_string.red
	else
		goldColor = UIInfo.color_string.white
	end
	return string.format(LangCfg:getString('common', 'costGold'), UIInfo.color_string.blue, goldColor, gold)
end

function MsgBox(params)
	local btnList
	if params.style ~=  "OK" then
		btnList = {{text=params.okText or LangCfg:getString('common', 2), obj=nil, callfun=params.onOK, param=nil}, {text=params.cancelText or LangCfg:getString('common', 6), callfun=params.onCancel}}
	else
		btnList = {{text=params.okText or LangCfg:getString('common', 2), obj=nil, callfun=params.onOK, param=nil}}
	end

	local params = {title=params.title, text=params.text,panType = 2, align=params.align, valign=params.valign, notice=params.notice}
	local btnNum = (btnList and #btnList) or 0
	if btnNum == 0 then
		params.centerBtn = {}
	elseif btnNum == 1 then
		params.centerBtn = btnList[1]
	else
		params.leftBtn = btnList[2]
		params.rightBtn = btnList[1]
		params.centerBtn = btnList[3]
	end
	ViewMgr:open(Panel.TOOLTIP,params)
end

function msgbox(params)
	MsgBox(params)
end

function msgBox(params)
	MsgBox(params)
end

function uihelper.typeItemToRich(typ_item_list)
	local str = ""
	for i,v in ipairs(typ_item_list) do
		if v.type == 1 then
			--table.insert(items, {v.itemID, v.itemCount})
			str = str .. string.format("<grid src=#hero_wp_di.png itemId=%s num=%s tip=true></grid>", v.itemID, v.itemCount)
		elseif v.type == 3 then
			--table.insert(moneys, {coin=v.itemCount})
			str = str .. string.format("<money src=#hero_wp_di.png coin=%s tip=true></money>", v.itemCount)
		elseif v.type == 4 then
			str = str .. string.format("<money src=#hero_wp_di.png gold=%s tip=true></money>", v.itemCount)
		end
	end
	return str
end

-- assume the direction is right&top
function uihelper.convertCoodinate(src, src_co, target_co)
	local x = (src_co[1] + src[1] - target_co[1])
	local y = (src_co[2] + src[2] - target_co[2])
	return x,y
end

--not assume the direction
function uihelper.convertCoodinateEx(src, src_co, target_co)
	local x = (src_co[1] + src[1]*src_co[3] - target_co[1])/target_co[3]
	local y = (src_co[2] + src[2]*src_co[4] - target_co[2])/target_co[4]
	return x,y
end

function uihelper.getFunc( target, funcName, attrName, value )
    target[attrName] = value
    target[funcName] = function (  )
        return target[attrName]
    end
end



function uihelper.sort( list, compareFunc )
    --插入排序
    for i = 1, #list do
        local tem = list[i]
        local j = i
        while j > 1 and compareFunc(tem, list[j - 1]) do
            list[j] = list[j - 1]
            j = j - 1
        end
        list[j] = tem
    end
end

function openTipPanel(text,btnList,title, textAlign,textVAlign)
	local params = {title=title, text=text,panType = 2, align=textAlign, valign=textVAlign}
	local btnNum = (btnList and #btnList) or 0
	if btnNum == 0 then
		params.centerBtn = {}
	elseif btnNum == 1 then
		params.centerBtn = btnList[1]
	else
		params.leftBtn = btnList[2]
		params.rightBtn = btnList[1]
		params.centerBtn = btnList[3]
	end
	ViewMgr:open(Panel.TOOLTIP,params)
end
return uihelper
