--
--
--战斗的触发器
local FightTrigger = {}

FightTrigger.FIGHT_ENTER = "fight_enter"  --战斗 人员进场
FightTrigger.FIGHT_START = "fight_start"  --战斗开始  交战

FightTrigger.CREATURE_DIE = "creature_die"  --creature die
FightTrigger.CREATURE_REBORN = "creature_reborn"  --复活

FightTrigger.USE_PLAYER_SKILL = "use_player_skill" --  使用玩家技能

FightTrigger.ADD_CREATURE = "add_creature"  --添加某个英雄 或者怪物
FightTrigger.REMOVE_CREATURE = "remove_creature"  --移除某个英雄 或者怪物

FightTrigger.CREATURE_CHANGE_HP = "creature_change_hp"  --血量变化

FightTrigger.ADD_DROP_ITEM = "add_drop_item"  --add drop item

FightTrigger.FILM_END = "film_end" --电影播放结束
FightTrigger.FILM_STEP_END = "film_step_end"  --电影步骤结束

FightTrigger.CLICK_SCENE = "click_scene"  --点击到场景

FightTrigger.RESULT = "fight_result"

FightTrigger.TIME_TICK = "fight_tick"
FightTrigger.TIME_TICK_FIRST = "fight_tick_first"

FightTrigger.ADD_CRATER = "add_crater"  --添加弹坑

FightTrigger.SELECT_TILE = "select_tile"  --test edit map use

FightTrigger.POPULACE_CHANGE = "populace_change" -- populace_change

FightTrigger.CHARM_CREATURE = "charm_creature" --魅惑

FightTrigger.HURT_DATA = "hurt_data"

EventProtocol.extend(FightTrigger)

return FightTrigger