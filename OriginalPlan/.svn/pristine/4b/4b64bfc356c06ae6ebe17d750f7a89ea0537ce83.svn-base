--
-- Author: wdx
-- Date: 2014-06-23 21:14:40
--
local LangCfg = class("LangCfg")

--[[--
语言包
]]
function LangCfg:init( )
	self.cfg = ConfigMgr:requestConfig("lang",nil,true)
	self.errorCode = ConfigMgr:requestConfig("error_code",nil,true)
end

--根据id获取
function LangCfg:get( id )
	return self.cfg[id]
end

--根据key 和 id获取
function LangCfg:getString(key,id)
	return self.cfg[key][id]
end


function LangCfg:getErrorString(ec)
	if self.errorCode[ec] then
		return self.errorCode[ec].desc
	end
end

--战斗string
function LangCfg:getFightString( id )
	return self.cfg.fight[id]
end

function LangCfg:getItemInfoType(itemType)
	return self.cfg["iteminfo"]["type"][itemType]
end

function LangCfg:getItemInfoQuality(quality)
	return self.cfg["iteminfo"]["quality"][quality]
end

function LangCfg:getItemInfoUseType(useType)
	return self.cfg["iteminfo"]["useType"][useType]
end

function LangCfg:getCommonInfoById(Id)
	return self.cfg["common"][Id]
end

function LangCfg:getChatInfoById(Id)
	return self.cfg["chat"][Id]
end

function LangCfg:getItemSaleSuccess()
	return self.cfg['bag']['ItemSale'][1]
end

function LangCfg:getItemSaleError()
	return self.cfg['bag']['ItemSale'][2]
end

function LangCfg:getQuickEquipInfoById(id)
	return self.cfg['quickEquip'][id]
end

function LangCfg:getAchieveInfoById(Id)
	return self.cfg["activity"][Id]
end

function LangCfg:getTaskInfoById(Id)
	return self.cfg["task"][Id]
end

function LangCfg:getDungeonText( id )
	return self.cfg["dungeon"][id]
end

function LangCfg:getCheckInInfoById(id)
	return self.cfg['checkIn'][id]
end

function LangCfg:getChallengeInfoById(id)
	return self.cfg['challenge'][id]
end

function LangCfg:getGuildDungeonInfoById(id)
	return self.cfg['guildDungeon'][id]
end

function LangCfg:getRoleInfoById(id)
	return self.cfg['role'][id]
end

function LangCfg:getShopInfoById(id)
	return self.cfg['shop'][id]
end

function LangCfg:getStoneInfoById(id)
	return self.cfg['stone'][id]
end

function LangCfg:getVitInfoById(id)
	return self.cfg['vit'][id]
end

function LangCfg:getTreasureInfoById(id)
	return self.cfg['treasure'][id]
end

function LangCfg:getCoinTypeText(coinType)
	return self.cfg['coinType'][coinType]
end

function LangCfg:getAttrTranslate(str)
	return self:getAttrName(str)
end

function LangCfg:getAttrName(str)
	local translate = self.cfg['attr'][str]
	if not translate then return str end
	return translate
end

function LangCfg:getAttrSpeedString(index)
	return self.cfg['attr']['speedValue'][index]
end

function LangCfg:getArenaCfg( id )
	return self.cfg["arena"][id];
end

function LangCfg:getGuildCfg( id )
	return self.cfg["guild"][id];
end

function LangCfg:getActivationCodeText( id )
	return self.cfg["activationCode"][id];
end

function LangCfg:getNeedCoinText( id )
	return self.cfg["NeedCoin"][id];
end

function LangCfg:getNewSystemTipsText( id )
	return self.cfg["newSystemTips"][id];
end

function LangCfg:getFunActivityText(id)
	return self.cfg['funActivatity'][id]
end

function LangCfg:getFriendText(id)
	return self.cfg["friend"][id]
end

function LangCfg:getWBossText(id)
	return self.cfg['wboss'][id]
end

function LangCfg:getAirShipText( id,... )
	-- body
	return self.cfg['airShip'][id]
end

function LangCfg:getHeroPoetryText( id,... )
	-- body
	return self.cfg['heroPoetry'][id]
end

function LangCfg:getCampNameByType( campType )
	-- body
	return self.cfg['camp'][campType]
end

function LangCfg:getDefenderText( id )
	-- body
	return self.cfg['defender'][id]
end

function LangCfg:getRankText( id )
	return self.cfg['rank'][id]
end

function LangCfg:getBuildingText( id )
	return self.cfg['building'][id]
end

function LangCfg:getWildernessText( id )
	return self.cfg['wilderness'][id]
end

function LangCfg:getWildBattleText( id )
	return self.cfg['wildernessBattle'][id]
end

function LangCfg:getBattlefronText( id )
	return self.cfg['battlefront'][id]
end

function LangCfg:getFlashActivityText( id )
	return self.cfg['flashActivity'][id]
end

function LangCfg:getFoundryText( id )
	return self.cfg['foundry'][id]
end
function LangCfg:getAdjunctText( id )
	return self.cfg['adjunct'][id]
end

function LangCfg:getKingBossText( id )
	return self.cfg['kinBoss'][id]
end

return LangCfg.new()
