--[[--
	各个界面的常量，Panel.XXX = 全小写的名字
	Panel.Config 中写明每个界面的：入口、中文名字
]]
local Panel = {}

Panel.OPENING      = "opening"    --开场
Panel.HOME         = "home" --主城
Panel.DUNGEON      = "dungeon" --主线副本
Panel.HUD          = "hud"  --主界面  
Panel.CHAT         = "chat" --聊天
Panel.ROLE         = "role" --角色
Panel.FIGHT        = "fight"  --战斗
Panel.BAG          = "bag"  --背包


Panel.TEST         = "test" --测试面板


--各个系统模块的配置
Panel.Config = {
  [Panel.TEST] = {
    portal = "view.hud.TestPanel",
    name = "测试"
  },

  [Panel.OPENING] = {
    portal = "launch.OpeningPanel",
    name = "开场"
  },
  [Panel.HOME] = {
    portal = "view.home.HomeScene",
    name = "主城"
  },
  [Panel.HUD] = {
    portal = "view.home.HudPanel",
    name = "主界面"
  },
  [Panel.DUNGEON] = {
    portal = "view.dungeon.DungeonPanel",
    name = "主线副本"
  },

  [Panel.CHAT] = {
    portal = "view.chat.ChatPanel",
    name = "聊天"
  },
  [Panel.ROLE] = {
    portal = "view.role.RolePanel",
    name = "角色"
  },
  [Panel.FIGHT] = {
    portal = "view.fight.FightPanel",
    name = "战斗"
  },
  [Panel.BAG] = {
	portal = "view.bag.BagPanel",
	name = "背包"
  }
  
	
}

return Panel