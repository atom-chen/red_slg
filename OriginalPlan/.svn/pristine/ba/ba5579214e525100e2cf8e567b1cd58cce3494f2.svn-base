--[[
	class:		WMMineInfoController
	desc:		野外地图信息控制器
	author:		郑智敏
--]]
local WMInfoUilt = game_require('model.world.map.WMInfoUilt')
local WMMineInfoController = class('WMMineInfoController')

function WMMineInfoController:ctor( model )
	self._model = model
	self._mineTable = {}
end

function WMMineInfoController:init(  )
	-- body
	self:clearInfo()
end

function WMMineInfoController:clearInfo()
	self._mineTable = {}
end

function WMMineInfoController:setInfo(mineInfoList)
	--self:clearInfo()
	for _,wildernessMine in ipairs(mineInfoList) do
		self._mineTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( wildernessMine.wildernessPos ))] = wildernessMine
	end
end

function WMMineInfoController:updateMapElem(mineInfoList)
	for _,wildernessMine in ipairs(mineInfoList) do
		self._mineTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( wildernessMine.wildernessPos ))] = wildernessMine
	end
end

function WMMineInfoController:deleteMapElem( deleteMinePosList )
	-- body
	for _,wildernessPos in ipairs(deleteMinePosList) do
		self._mineTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( wildernessPos ))] = nil
	end
end

--根据部队的挖矿信息进行挖矿处理，更函数每秒都会被调用(如果有部队在开采该矿),根据wildernessMiningInfo的开采速度对矿的储量进行减少
--若减为0，则该矿消失
function WMMineInfoController:armyMining( wildernessMiningInfo )
	-- body
	local mineInfo = self._mineTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( wildernessMiningInfo.wildernessPos ))]
	if nil ~= mineInfo and TimeCenter:getTimeStamp() <= wildernessMiningInfo.endTime then
		mineInfo.stock = mineInfo.stock - wildernessMiningInfo.speed/60
		--矿储量为0， 该矿消失
		if mineInfo.stock <= 0 then
			self._mineTable[WMInfoUilt:serializePos(WMInfoUilt:changeWildernessPosToPos( wildernessMiningInfo.wildernessPos ))] = nil
			return true
		end
	end
	return false
end

function WMMineInfoController:getNearByFreeMine( pos, range )
	-- body
	local nearByMinePosList = {}
	for xadd = -range,range,1 do
		for yadd = -range,range,1 do
			local minePos = ccp(pos.x + xadd, pos.y + yadd)
			local mineKey = WMInfoUilt:serializePos(minePos)
			if nil ~= self._mineTable[mineKey] then
				local allInfo = self._model:getAllElemInfoAt(  minePos )
				if 0 >= #(allInfo[WorldMapModel.ARMY].enemyDefeatList) and 
					0 >= #(allInfo[WorldMapModel.BASE].enemyDefeatList) and
					false == allInfo[WorldMapModel.ARMY].hasElem and
					false == allInfo[WorldMapModel.BASE].hasElem and
					false == allInfo[WorldMapModel.MONSTER].hasElem then
					nearByMinePosList[#nearByMinePosList + 1] = minePos
				end
			end
		end
	end

	return nearByMinePosList
end

function WMMineInfoController:isJoint(pos)
	local info = self:getInfoAt(pos)
	if info.hasElem then
		local armyInfo = WorldMapModel:getElemInfoAt( WorldMapModel.ARMY, info.startPos )
		for _,v in ipairs(info.data.name_list) do
			--print('v ..' .. v)
			--print('armyInfo.data.wildernessPlayerInfo.name ..' .. armyInfo.data.wildernessPlayerInfo.name)
			if false == armyInfo.hasElem or v ~= armyInfo.data.wildernessPlayerInfo.name then
				return true
			end
		end
	end
	return false
end

function WMMineInfoController:getInfoAt(pos)
	local data = self._mineTable[WMInfoUilt:serializePos(pos)]
	if nil == data then
		return {hasElem = false}
	else
		return {hasElem = true, data = data, startPos = pos, endPos = pos}
	end
end

return WMMineInfoController