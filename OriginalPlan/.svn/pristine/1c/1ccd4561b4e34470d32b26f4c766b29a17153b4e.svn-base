--[[
    class RewardTips
    desc 限时特卖
    author 黄锐初
--]]

local RewardTips = class('RewardTips', PanelProtocol)

RewardTips.SHOW_TIME = 3

-- function RewardTips:ctor(  )
    -- PanelProtocol.ctor(self, Panel.PanelLayer.NOTIFY, Panel.REWARD_TIPS, true)
    -- self:init()
-- end

function RewardTips:init(  )
    self:initUINode("com_reward_tips")
    self:setOutsideClose("com_tips1")

    local elemTable = {
        {"tt_21", "_scroll"},
    }
    for i, v in ipairs(elemTable) do
        self[v[2]] = self.uiNode:getNodeByName(v[1])
    end
    self._time = self.SHOW_TIME
end

function RewardTips:setReward( rewardList )
    if not rewardList then
        return
    end

    self:setScrollMidian(#rewardList)

    self._scroll:clear(true)
    local addFunc = self.addItemGrid
    if self._type == "itemInfo" then
        addFunc = self.addItemInfoGrid
    end
    for i, reward in ipairs(rewardList) do
        -- local item = self:addItemGrid(reward)
        local item = addFunc(self, reward)
        self._scroll:addCell(item)
    end
end

function RewardTips:setScrollMidian( num )
    local size = self.uiNode.node['Node_grid']:getContentSize()
    local width = num * size.width
    local maxWidth = self._scroll:getViewSize().width
    if maxWidth <= width then
        self._scroll:setMargin(5)
        return
    end
    local margin = math.floor((maxWidth - width) / (num + 1))
    self._scroll:setMargin(margin)
end

function RewardTips:addItemInfoGrid( reward )
    --[[
    itemInfo={
        {"itemID", "uint16"}
        ,{"itemNum", "int32"}
    },
    --]]
    local siz = self.uiNode.node['Node_grid']:getContentSize()
    local grid = UIItemGrid.new(siz,nil,self:getPriority())
	local itemId = reward.itemID or reward[1]
	local itemNum = reward.itemNum or reward[2]
    grid:setItem(itemId, itemNum)
    --添加提示
    ShowInfoTipExtend.extend(grid)
    grid:setShowTipId(ShowInfoTipExtend.ITEM,itemId)
    return grid
end

function RewardTips:addItemGrid( reward )
    --[[
        type_item = {       -- 不同类型物品
        {"type", "int8"},   -- 1 物品 3 金币 4 钻石
        {"itemID", "int32"}, -- type 为1时 才有效
        {"itemCount","int32"}
    },
    ]]
    local siz = self.uiNode.node['Node_grid']:getContentSize()
    local grid = UIItemGrid.new(siz,nil,self:getPriority())
	local itemId = reward.itemID or reward[1]
	local itemNum = reward.itemNum or reward[2]
    -- if reward.type == 1 then
        -- print("reward.type, reward.num", reward.type, itemNum)
        grid:setItem(itemId, itemNum)
        --添加提示
        ShowInfoTipExtend.extend(grid)
         grid:setShowTipId(ShowInfoTipExtend.ITEM,itemId)
    -- else
        -- grid:setMoney(RewardCfg:itemToMoney(reward), true)
        --添加提示
        -- ShowInfoTipExtend.extend(grid)
        -- grid:setShowTipId(ShowInfoTipExtend.OTHER_ITEM,RewardCfg:itemToMoney(reward))
    -- end
    return grid
end

function RewardTips:timeClose(  )
    if self._time == 0 then
        self:closeSelf()
        self:endTimer()
    end
    self._time = self._time -1
end

--------时间-------------------------------------
function RewardTips:beginTimer()
    self:endTimer()
    self._timer = UISimpleTimer.new(1, {self, self._dispatch}, {self,self.endTimer})
    self._timer:start(true)
end

function RewardTips:_dispatch()
    self:timeClose()
    return true
end

function RewardTips:endTimer()
    if self._timer then
        self._timer:stop()
        self._timer:dispose()
        self._timer = nil
        self._time = self.SHOW_TIME
    end
end
-----------------------------------------------------------------

function RewardTips:clear(  )
    self._scroll:clear(true)
    self:endTimer()
end

function RewardTips:onOpened( param )
    --self:loadResEx()
    self._type = param.type
    self:setReward(param.rewardList)
    self:beginTimer()
end

function RewardTips:onCloseed(  )
    --self:unloadResEx()
    self:clear()
end

return RewardTips
