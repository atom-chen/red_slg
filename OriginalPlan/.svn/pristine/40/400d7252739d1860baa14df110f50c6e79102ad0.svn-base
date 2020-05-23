local WorldProxy = {}

function WorldProxy:init()
	local msgHandleList = {}
	NetCenter:addMsgHandlerList(self,msgHandleList)
	NetCenter:ignoreError(MsgType.WORLD_MOVE_CAMP,true)
end

--野外信息初始化
function WorldProxy:reqWildernessInfo()
	LoadingControl:show("reqWildernessInfo",true)
	NetCenter:send(MsgType.Notify.WORLD_INIT)
end

function WorldProxy:_onWildernessInit(pack)
	LoadingControl:stopShow("reqWildernessInfo")
	local msg = pack.msg
	if msg.result == 0 then
		local info = {}
		info.x = msg.baseInfo.worldPos.x
		info.y = msg.baseInfo.worldPos.y
		info.free_transfer = msg.baseInfo.free_transfer
		info.protect_time = msg.baseInfo.protect_time
		info.transfer_cd = msg.baseInfo.transfer_cd
		WorldModel:initBaseInfo(info,msg.armyList)
	end
end

function WorldProxy:_onUpdateBaseInfo(pack)
	local msg = pack.msg
	local info = {}
	info.x = msg.baseInfo.worldPos.x
	info.y = msg.baseInfo.worldPos.y
	info.free_transfer = msg.baseInfo.free_transfer
	info.protect_time = msg.baseInfo.protect_time
	info.transfer_cd = msg.baseInfo.transfer_cd
	WildernessModel:updateBaseInfo(info)
end

--主基地迁移
function WorldProxy:reqMoveCamp( pos )
	LoadingControl:show("reqMoveCamp",true)
	NetCenter:send(MsgType.WORLD_MOVE_CAMP,pos)
end

function WorldProxy:_onMoveCamp(pack)
	LoadingControl:stopShow("reqMoveCamp")
	local msg = pack.msg
	if msg.result == 0 then
		floatText("迁移成功")
		WildernessModel:setBasePos( msg.worldPos )
	elseif msg.result == -1483 then
		local info = WildernessModel:getBaseInfo()
		local time = info.transfer_cd - TimeCenter:getTimeStamp()
		if time > 3600 then
	        local h,m = math.modf( time / 3600)
	        timeStr = string.format("<font color=red>迁移处于CD中,剩余%02d时%02d分</font>",h,(math.floor(m*60 + 0.5)))
	    elseif time > 60 then
	        local m,s = math.modf( time / 60)
	        timeStr = string.format("<font color=red>迁移处于CD中,剩余%02d分%02d秒</font>",m,(math.floor(s*60 + 0.5)))
	    else
	        timeStr = string.format("<font color=red>迁移处于CD中,剩余%02d秒</font>",time)
	    end

		floatText(timeStr)
	elseif msg.result == -1484 then
		floatText("军团长附近没有空位")
	end
end

function WorldProxy:reqCoordList()
	NetCenter:send(MsgType.WORLD_COORD_LIST)
end

function WorldProxy:_onCoordList(pack)
	local msg = pack.msg
	WildernessModel:initCoordList(msg.coordList)
end

--收藏坐标
function WorldProxy:reqSaveCoord(x,y)
	local pos = {x = x, y = y}
	NetCenter:send(MsgType.WORLD_SAVE_COORD,pos)
end

function WorldProxy:_onSaveCoord(pack)
	local result = pack.msg.result

	if result == 0 then
		floatText("收藏成功！")
		NotifyCenter:dispatchEvent({name= Notify.WORLD_UPDATE_COLLECTION})
	end
end

--添加部队单位
function WorldProxy:reqChangeArmyHero(index,heroList)
	local list = {}
	for heroId,info in pairs(heroList) do
		list[#list+1] = {heroId=heroId,max_num = info.max_num ,bad_num = 0}
-- print("WorldProxy:reqChangeArmyHero(index,heroList)",heroId,num)
	end
	NetCenter:send(MsgType.WORLD_CHANGE_ARMY_HERO,index,list)
end

function WorldProxy:reqRefreshArmy()
	NetCenter:send(MsgType.WORLD_REFRESH_ARMY)
end

--部队更新
function WorldProxy:_onUpdateArmy(pack)
	local msg = pack.msg
	for i,armyInfo in ipairs(msg.armyList) do
		WildernessModel:setArmy(armyInfo.id,armyInfo)
	end
end

--派遣部队
function WorldProxy:dispatchArmy(index,x,y)
	LoadingControl:show("dispatchArmy",true)
	NetCenter:send(MsgType.WORLD_DISPATCH_ARMY,index,{x=x,y=y})
end

--派遣部队目的地 没人 直接占领
function WorldProxy:_onDispatchArmy(pack)
	LoadingControl:stopShow("dispatchArmy")
	local msg = pack.msg
	if msg.result == 0 then
	end
end

--派遣部队目的地有敌人 进入战斗
function WorldProxy:_onArmyFight(pack)
	LoadingControl:stopShow("dispatchArmy")
	local msg = pack.msg
	NotifyCenter:dispatchEvent({name=Notify.WORLD_ARMY_FIGHT,msg = msg} )
end

--派遣部队目的地是怪物
function WorldProxy:_onFightMonster(pack)
	LoadingControl:stopShow("dispatchArmy")
	local msg = pack.msg
	msg.isMonster = true
	if #msg.monsterList == 0 then  --没怪物了
		WorldProxy:reqArmyFightEnd(true,msg.index,msg.pos,msg.targetId,{},{},0)
	else
		NotifyCenter:dispatchEvent({name=Notify.WORLD_ARMY_FIGHT,msg = msg} )
	end
end

function WorldProxy:reqArmyFightEnd(win,armyIndex,pos,roleId,myHeroList,enemyList,totalHurt)
	win = (win and 1) or -1
	local list1 = {}
	for heroId, num in pairs(myHeroList) do
		list1[#list1+1] = {heroID = heroId,num = num}
	end
	local list2 = {}
	for heroId, num in pairs(enemyList) do
		list2[#list2+1] = {heroID = heroId,num = num}
	end
	NetCenter:send(MsgType.WORLD_ARMY_FIGHT_END,win,armyIndex,pos,roleId,list1,list2,totalHurt)
end

function WorldProxy:_onArmyFightEnd(pack)
	local msg = pack.msg
	local isWin = (msg.win == 1)
    NotifyCenter:dispatchEvent({name=Notify.NET_FIGHT_END,msg = msg,reward=msg
                                , fightType=FightCfg.WORLD_FIGHT ,win = isWin})
end

--召回
function WorldProxy:callbackArmy(index)
	LoadingControl:show("callbackArmy",true)
	NetCenter:send(MsgType.WORLD_CALL_BACK_ARMY,index)
end

function WorldProxy:_onCallbackArmy(pack)
	LoadingControl:stopShow("callbackArmy")
	local msg = pack.msg

end

function WorldProxy:_onGetResource(pack)
	local msg = pack.msg
	NotifyCenter:dispatchEvent({name=Notify.WORLD_GET_RESOURCE,msg = msg})
end

function WorldProxy:_onAtkNotice(pack)
	local msg = pack.msg
	NotifyCenter:dispatchEvent({name=Notify.WORLD_ATK_NOTICE,msg = msg})
end

function WorldProxy:_onFlyCamp(pack)
	local msg = pack.msg
	NotifyCenter:dispatchEvent({name=Notify.WORLD_CAMP_NOTICE,msg = msg})
end

function WorldProxy:reqMapBuyOre( type )
	print('function WorldProxy:reqMapBuyOre( type )'..type)
	NetCenter:send(MsgType.WORLD_BUY_ORE, type)
end

function WorldProxy:_resMapBuyOre( event )
	WildernessModel:buyOreResult(event.msg)
end

function WorldProxy:reqMapBuyTime(  )
	NetCenter:send(MsgType.WORLD_BUY_TIME)
end

function WorldProxy:_resMapBuyTime( event )
	WildernessModel:setBuyOreTimes(event.msg)
end

function WorldProxy:reqFindPlayer( roleId )
	NetCenter:send(MsgType.WORLD_FIND_PLAYER,roleId)
end

function WorldProxy:_onFindPlayer( event )
	local msg = event.msg
	if msg.result == 0 then
		NotifyCenter:dispatchEvent({name=Notify.WORLD_FIND_POS,pos = msg.worldPos})
	end
end

function WorldProxy:reqMoveHouseToGuild()
	NetCenter:send(MsgType.WORLD_MOVE_HOUSE_TO_GUILD)
end

function WorldProxy:_onInitMessage( event )
	local msg = event.msg
	WildernessModel:initMessage(msg.messageList)
end

function WorldProxy:reqLeaveMessage( roleId , text)
	NetCenter:send(MsgType.WORLD_LEAVE_MESSAGE,roleId,text)
end

function WorldProxy:_onMessage( event )
	local msg = event.msg
	if msg.result == 0 then
		WildernessModel:setMessage(msg.messageInfo)
	end
end

function WorldProxy:reqCallHelp( logType,pos )
	NetCenter:send(MsgType.WORLD_CALL_HELP,logType,pos)
end

function WorldProxy:_onCallHelp( event )
	local msg = event.msg
	if msg.result == 0 then
		floatText("求援成功！")
	end
end

--id : 0为用铁，>0 为item_id
function WorldProxy:reqSpeedUp( index , id )
	NetCenter:send(MsgType.WORLD_SPEED_UP,index , id)
end

function WorldProxy:_onSpeedUp( event )
	local msg = event.msg
	if msg.result == 0 then
		-- floatText("加速成功！")
		NotifyCenter:dispatchEvent({name=Notify.WORLD_USE_ITEM})
	end
end

function WorldProxy:reqBuySpeedUp( index , pos , id )
	NetCenter:send(MsgType.WORLD_BUY_SPEED_UP,index ,ShopModel.WILDNESS_GOODS, pos , id)
end

function WorldProxy:_onBuySpeedUp( event )
	local msg = event.msg
	if msg.result == 0 then
		floatText("购买使用成功！")
	end
end

function WorldProxy:_onMutilMine( event )
	if #event.msg.multi_mine_name > 0 then
		local str = ""
		for i,v in pairs(event.msg.multi_mine_name) do
			str = str .. "["..v.."]"
		end

		floatText(string.format("<font color=rgb(0,255,0)>"..str.."</font>".."与您联合采矿。"))
	else
		floatText("启动联合采矿。")
	end
end

--迁城到公会附近
function WorldProxy:reqMoveHouseToGuild()
	NetCenter:send(MsgType.WORLD_MOVE_HOUSE_TO_GUILD)
end

function WorldProxy:reqDelCoord(x,y)
	LoadingControl:show("callbackArmy",true)
	NetCenter:send(MsgType.WORLD_DEL_COORD,{x = x, y = y})
end

function WorldProxy:_onDelCoord(event)
	LoadingControl:stopShow("callbackArmy")
	local msg = event.msg
	if msg.result == 0 then
		floatText("删除成功")
		WildernessModel:delCoord(msg.worldPos)
	end
end

function WorldProxy:reqFixCamp(num)
	NetCenter:send(MsgType.WORLD_FIX_CAMP,num)
end

function WorldProxy:_onFixCamp(event)
	local msg = event.msg
	if msg.result == 0 then
		floatText("修复成功")
		NotifyCenter:dispatchEvent({name=Notify.WORLD_UPDATE_CAMP})
	end
end

function WorldProxy:_onFeatReward(pack)
	dump(pack.msg.has_draw_index_list)
	WildernessModel:setFeatDrawList( pack.msg.has_draw_index_list )
end

function WorldProxy:reqDrawFeat(index)
	NetCenter:send(MsgType.WORLD_DRAW_FEAT,index)
end

function WorldProxy:_onDrawFeat(pack)
	if pack.msg.result == 0 then
		local num = WorldCfg:getFeatCrystal( pack.msg.index )
		if num then
			floatText("恭喜获得紫晶x"..num)
		end
		NotifyCenter:dispatchEvent({name=Notify.WORLD_DRAW_FEAT,index = pack.msg.index})
	end
end

return WorldProxy
