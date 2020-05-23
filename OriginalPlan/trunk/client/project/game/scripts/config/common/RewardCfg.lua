local RewardCfg = class("RewardCfg")

function RewardCfg:init()
	self.money_item = {gold=-1,coin=-2,exp=-3,arena=-4,guild=-5,live=-6,reputation=-7}
	local item_money = {}
	for k,v in pairs(self.money_item) do
		item_money[v] = k
	end
	self.item_money = item_money

	self.money_to_item = {coin = 3, gold = 4}
	local item_to_money = {}
	for k,v in pairs(self.money_to_item) do
		item_to_money[v] = k
	end
	self.item_to_money = item_to_money
end
--[[
function RewardCfg:toItems(money, items)
	local rewards = {}
	for name,id in pairs(self.money_item) do
		local val = money[name]
		if type(val) == "number" and val > 0 then
			table.insert(rewards, {id, val})
		end
	end
	if items then
		for i,v in ipairs(items) do
			table.insert(rewards, v)
		end
	end
	return rewards
end
--]]
function RewardCfg:toRewards(money, items)
	local rewards = {}
	for name,id in pairs(self.money_item) do
		local val = money[name]
		if type(val) == "number" and val > 0 then
			table.insert(rewards, {type=id, num=val})
		end
	end
	if items then
		for i,v in ipairs(items) do
			table.insert(rewards, {type=v[1], num=v[2]})
		end
	end
	return rewards
end

function RewardCfg:toMoney(item)
	local id,num = item.type,item.num
	return {[self.item_money[id]]=num}
end

function RewardCfg:itemToMoney( item )
	local id,num = item.type, item.itemCount
	return {[self.item_to_money[id]] = num}
end

function RewardCfg:analyRewardList(list)
	local reward = {}
	reward.itemList = {}
	for i,info in ipairs(list) do
		if info.type == 1 then
			reward.itemList[#reward.itemList+1] = {itemID=info.itemID,itemNum = info.itemCount}
		elseif info.type == 3 then
			reward.coin = info.itemCount
		elseif info.type ==4 then
			reward.gold = info.itemCount
		end
	end
	return reward
end

return RewardCfg
