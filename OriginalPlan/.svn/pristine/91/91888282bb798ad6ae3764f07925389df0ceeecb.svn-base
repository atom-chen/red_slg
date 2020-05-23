--[[
    @class TapBar
    @author hrc
    @inheir ScrollList
    @desc 标签
    接口
        addBtn( btn, isUpdateSize )
        setBtnList( btnList, isUpdateSize )
        getCurrBtn()
        setCurrBtnByIndex( index )
        setCurrBtn(btn)
        getCurrBtn()
        addRedPointByIndex( index )
        removeRedPointIndex( index )
--]]

local TapBar = class("TapBar", ScrollList)

function TapBar:ctor( width, height, priority, margin )
    ScrollList.ctor(self, ScrollView.HORIZONTAL, width, height, priority, margin)
    self:setTouchEnabled(false)
    self._currBtn = nil
end

function TapBar:createTap( node, priority )
    local size = node:getContentSize()
    local tap = TapBar.new(size.width, size.height, priority)
    tap:setPosition(node:getPosition())
    return tap
end

--@desc 添加按钮
--@btn 按钮 (需要提供setSelected方法，addRedPoint可选)
--@isUpdateSize bool 是否需要更新按钮大小
function TapBar:addBtn( btn, isUpdateSize, zorder )
    btn:setImageInfo(nil,false)
    btn:setPosition(0,0)
    btn:removeFromParent()
    self:addCell(btn, nil, zorder)
    -- btn.isUpdateSize = isUpdateSize ~= false and true or isUpdateSize
    btn.isUpdateSize = isUpdateSize
    btn:addEventListener(Event.MOUSE_CLICK, {self, self._onChangeBtn},-1)
    if not self._currBtn then
        self:setCurrBtn(btn)
    end
    self:_updateBtnSize(self._currBtn)
    self:updatePosition()
end

--@desc 设置按钮列表
--@btnList 按钮数组
function TapBar:setBtnList( btnList,isUpdateSize  )
    for i, btn in ipairs(btnList) do
        self:addBtn(btn,isUpdateSize)
    end
end

--@desc 设置当前按钮，通过index
function TapBar:setCurrBtnByIndex( index )
    local btn = self:getCellAt(index)
    if not btn then return end
    self:setCurrBtn(btn)
end

--@desc 设置当前按钮
function TapBar:setCurrBtn( btn )
    if self._currBtn == btn then return false end
    if self._currBtn then
        self._currBtn:setSelected(false)
        self:_updateBtnSize(self._currBtn)
    end
    self._currBtn = btn
    self._currBtn:setSelected(true)
    self:_updateBtnSize(self._currBtn)
    self:updatePosition()
    return true
end

--@desc 获取当前按钮
function TapBar:getCurrBtn(  )
    return self._currBtn
end

function TapBar:addRedPointByIndex( index )
    local btn = self:cellAtIndex(index)
    if btn then
        btn:addRedPoint()
    end
end

function TapBar:removeRedPointIndex( index )
    local btn = self:cellAtIndex(index)
    if btn then
        btn:removeRedPoint()
    end
end

function TapBar:_updateBtnSize( btn )
    if not btn.isUpdateSize then return end
    local size = btn._image:getContentSize()
    btn:setContentSize(size)
    btn._image:setPosition(size.width/2,size.height/2)
    if btn._text then
        if not btn._text:isRichText() then
            btn._text:setAlignInParent(btn._image, btn:getContentSize(), btn._textInfo.align, btn._textInfo.valign)
        end
        if btn._text then
            btn._text:setPadding(btn._textInfo.padding, true)
        end
    end
end

function TapBar:_onChangeBtn( event )
    self:setCurrBtn(event.target)
end

function TapBar:clear( isDispose )
    ScrollList.clear(self, isDispose)
    self._currBtn = nil
end

function TapBar:dispose(  )
    ScrollList.dispose(self)
    self._currBtn = nil
end

return TapBar
