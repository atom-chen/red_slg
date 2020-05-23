--[[
	class:		HeroEquipControl
	desc:		英雄装备控制器，用于获取当前有哪些英雄可以穿戴一个特定装备
	author:		郑智敏
]]

local HeroEquipControl = class('HeroEquipControl')

function HeroEquipControl:ctor()

end

function HeroEquipControl:getHeroListForItem(itemId, sortFlag)
	local heroList = HeroModel:getHeroList()
	local resultHeroList = {}
	--[[
	local itemInfo = BagModel:getItemInfoById(itemId)
	if nil == itemInfo or 0 >= itemInfo.num then
		return resultHeroList
	end
	--]]
	--print('itemId ..' .. itemId)
	for k,v in pairs(heroList) do
		local heroInfo = HeroModel:getHeroInfo(v.heroId)
		local itemInfo = ItemInfo.new(itemId)
		equipStat = heroInfo:currentEquipStat()
		for _,y in ipairs(equipStat) do
			--print('y.itemId ..' .. y.itemId)
			if y.itemId == itemId and heroInfo.level >= itemInfo.equip.need_hero_lev and y.stat ~= HeroInfo.HAS_EQUIPED then
				resultHeroList[#resultHeroList + 1] = {heroInfo = heroInfo, fightNumber = heroInfo:getFightNumber()} 
				break	
			end
		end
	end
	
	if true == sortFlag then
		local sortFunc = function(a,b)
			return a.fightNumber > b.fightNumber
		end
		
		table.sort(resultHeroList, sortFunc)
	end
	return resultHeroList
end

return HeroEquipControl.new()