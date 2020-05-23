--[[
@author 常奥
@date 2014/06/20
  玩家所拥有的所有物品信息,包括：
  道具、装备
--]]

local BagModel = class("BagModel")
  
function BagModel:ctor()
	self._items = {} 
end   

function BagModel:init()
	self._items = {}
end   

function BagModel:setAllItem(items)
	self._items = items
	NotifyCenter:dispatchEvent({name=Notify.BAG_GET_ALL})
end
--[[
@brief 获取数目
--]]
function BagModel:getItemCount()
	return #self._items
end

--[[--
    新增一个装备信息
]]
function BagModel:addItemInfo(itemInfo)
	table.insert(self._items, itemInfo)
	NotifyCenter:dispatchEvent({name=Notify.BAG_CHANGE, itemId = itemInfo.itemId,type = Notify.BAG_ITEM_ADD})
end

--[[--
    删除一个 item
]]
function BagModel:removeItemById(itemId)
	for i,v in ipairs(self._items) do
		if v.itemId == itemId then
			table.remove(self._items, i)
			NotifyCenter:dispatchEvent({name=Notify.BAG_CHANGE, itemId = itemInfo.itemId,type = Notify.BAG_ITEM_DEL})
			break
		end
	end
end

--[[--
    更改一个 item
]]
function BagModel:removeItemById(itemInfo)
	for i,v in ipairs(self._items) do
		if v.itemId == itemInfo.itemId then
			table.remove(self._items, i)
			self:addItemInfo(itemInfo)
			NotifyCenter:dispatchEvent({name=Notify.BAG_CHANGE, itemId = itemInfo.itemId,type = Notify.BAG_ITEM_MODIFY})
			break
		end
	end
end
--[[
@brief 获取 item 信息
--]]
function BagModel:getItemById(itemId)
	for i,v in ipairs(self._items) do
		if v.itemId == itemId then
			return v
		end
	end	
end

--[[
@brief 获取某一个类型的所有 item. 结果为 table
--]]
function BagModel:getItemsByType(type)
	local t = {}
	for i,v in ipairs(self._items) do
		if v.cfg.type == type then
			table.insert(t, v)
		end
	end	
	return t
end

--[[
@brief 获取某一个类型的所有 item, 结果为 BagModel
--]]
function BagModel:getBagByType(type)
	local bag = BagModel.new()
	for i,v in ipairs(self._items) do
		if v.cfg.type == type then
			bag:add(v)
		end
	end
	return bag
end

--[[
@brief 清空装备
--]]
function BagModel:clear()
	self._items = {}
end

function BagModel:dispose()
	self._items = nil
end

return BagModel
--[==[
-- type

--[[
@brief 装备。 可变量 数目， 强化
--]]
local EquipInfo = class("EquipInfo")


--[[
@brief 道具。 可变量 数目
--]]
local Prob = class("Prob")


--[[
@brief 消耗品。 可变量 数目
--]]
local Expendable = class("Expendable")
--]==]