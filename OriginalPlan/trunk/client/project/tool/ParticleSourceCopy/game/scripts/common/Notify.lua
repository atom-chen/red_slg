local Notify = {}

 
 ----------系统相关-----------------------------
	Notify.DAILY_REFRESH = "daily_refresh" --每日刷新到了，发出此通知




-------------副本相关----------------------
	Notify.DUNGEON_INIT = "dungeon_init"  --副本初始化
	Notify.DUNGEON_PROGRESS = "dungeon_progress"  -- 副本进度变化
	Notify.DUNGEON_INFO = "dungeon_info"  --副本信息变化
	

-----战斗相关-------
	Notify.FIGHT_END = "fight_end"   --战斗结束

	Notify.BAG_GET_ALL = "bag_get_all"			--获取所有背包信息
	Notify.BAG_CHANGE = "bag_change"			--背包变化 （包含物品 添加修改删除）
	
	Notify.BAG_ITEM_ADD = "bag_item_add"				--背包内添加物品
	Notify.BAG_ITEM_DEL = "bag_item_del"				--背包内删除物品
	Notify.BAG_ITEM_MODIFY = "bag_item_modify"			--背包物品信息修改
	



return Notify