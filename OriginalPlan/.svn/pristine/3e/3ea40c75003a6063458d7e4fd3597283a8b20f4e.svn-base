--[[
    @class TipAddItem
    @author hrc
    @desc 新增物品弹窗
--]]

local TipAddItem = class("TipAddItem", PanelProtocol)

function TipAddItem:init(  )
    self:initUINode('common_add_item_panel')
    local func = function (  )
        self:_onCloseSelf()
    end
    self:setOutsideClose("bg", func)
    local elemTable = {
        {"Scroll", "_scroll"},
    }
    for i, v in ipairs(elemTable) do
        self[v[2]] = self.uiNode:getNodeByName(v[1])
        if v[3] then
            self[v[2]]:addEventListener(Event.MOUSE_CLICK, {self, self[v[3]]})
        end
    end
    self._columnNum = 5
    self._showMax = 10
    self._nextIndex = 1
    self._infoList = {}
end

function TipAddItem:_onCloseSelf( event )
    if #self._infoList >= self._nextIndex then
        self:initScroll(self._infoList, self._nextIndex)
        return
    end
    self:closeSelf(self.isLinkPanel)
end

function TipAddItem:_cloneInfoList(  )
    local infoList = {}
    for i = self._showMax + 1, #self._infoList do
        table.insert(infoList, self._infoList[i])
    end
    return infoList
end

function TipAddItem:initScroll( infoList, index )
    index = index or 1
    if not self._scrollGrid then
        self._scrollGrid = UIVGrid.new(self._scroll:getViewSize().width, self._columnNum, ccp(0, 0), nil, false)
        self._scroll:addCell(self._scrollGrid)
    end
    self._scrollGrid:clearCell(true)
    local itemNum = 1
    local size = self.uiNode.node['Node_grid']:getContentSize()
    for i = index, #infoList do
        local info = infoList[index]
        local item = UIItemGrid.new(size, nil, self:getPriority(), true, true)
        item:setItem(info)
        self._scrollGrid:addCell(item)
        itemNum = itemNum + 1
        index = index + 1
        if itemNum > self._showMax then
            break
        end
    end
    self._scrollGrid:update()
    self._scrollGrid:setCenter()
    self._scroll:update()
    self._scroll:setScrollTo(self._scroll.TOP)
    self._infoList = infoList
    self._nextIndex = index
end

function TipAddItem:setScrollMidian( num )
    local x = 0
    if num < self._columnNum then
        local size = self.uiNode.node['Node_grid']:getContentSize()
        local width = num * size.width
        local maxWidth = self._scroll:getViewSize().width
        x = math.floor((maxWidth - width) / (num + 1))
    end
    self._scrollGrid:setPositionX(x)
end

function TipAddItem:clear(  )
    if self._scrollGrid then
        self._scrollGrid:clearCell(true)
        self._scrollGrid:dispose()
        self._scrollGrid = nil
    end
    self._scroll:clear(true)
end

function TipAddItem:onOpened( param )
    self:initScroll(param.iteminfos)
end

function TipAddItem:onCloseed(  )

end

return TipAddItem
