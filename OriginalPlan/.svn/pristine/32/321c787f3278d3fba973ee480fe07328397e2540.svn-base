#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
副本配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"dungeon")

# Erlang模块头说明，主要说明该文件作用，会自动添加-module(module_name).
# module_header函数隐藏了第三个参数，是指作者，因此也可以module_header(ur"礼包数据", module_name, "King")


# Erlang需要导出的函数接口, append与erlang的++也点类似，用于python的list操作
# Erlang函数一些注释，可以不写，但建议写出来

# 生成枚举的工具函数
def Field(module, str_enum):
    class_module = __builtin__.type(module, (object,), {})
    str_enum = str_enum.replace(" ", "")
    str_enum = str_enum.replace("\n", "")
    idx = 0
    for name in str_enum.split(","):  
        if '=' in name:  
            name,val = name.rsplit('=', 1)            
            if val.isalnum():               
                idx = eval(val)
        setattr(class_module, name.strip(), idx)  
        idx += 1
    return class_module

## 必须和excel里面的列保持一致的顺序
BaseColumn = """
    id,camp,aid,name,desc,dType,starRequest,fightType,dTimes,vit,pre_id,next_id,icon,x,y,
    level,base_drop,special_drop,chapter,drow_show,coin,
    heroExp,dialogs,openDays,atkCD,monster1,quickFinishItems,
    quickFinishNeedItems,monsterProduct,talk,hero_show,film,monsterDrop,
    decCountType,mercNum,vipLevelToDungeon,populace,card,
    commanderName,leaderLevel,leaderIcon,leaderScore,score1,score2,score3,tankStrAtt,tankStrDef,tankStrHP,
    planeStrAtt,planeStrDef,planeStrHP,soliderStrAtt,soliderStrDef,soliderStrHP,chariotStrAtt,
    chariotStrDef,chariotStrHP,first_pass_obtain_gold,isBoss, story_target, target_begin
"""
BattleColumn = """
    id,name,desc,populace,initMonster,posRefreshMonster,refreshMonster,loop
"""

ChuBingColumn ="""
    id,scene_id,populace,initMate,initMonster,posRefreshMonster,refreshMonster,
    loop,base_1,base_2,refreshMateMonster,mateLoop,roundRefreshMonster,protectMonster
"""

StarColumn = """
    index, s_type, detail
"""

FightColumn = """
    id, desc, winList, failList
"""

# 生成域枚举           
BaseField = Field('BaseField' , BaseColumn)
BattleField = Field('BattleField', BattleColumn)
ChuBingField = Field('ChuBingField', ChuBingColumn)
StarField = Field('StarField', StarColumn)
FightField = Field('FightField', FightColumn)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

dungeon_erl = "data_dungeon"
data_dungeon = module_header(ur"副本配置", dungeon_erl, "zm", "dungeon.xlsx", "data_dungeon.py")
data_dungeon.append("""
-include("dungeon.hrl").
-include("battle.hrl").
-include("hero_attr.hrl").


-export([
         get/1, 
         get_range/1, 
         get_type/1, 
         vip_clean_cd_cost/1, 
         vip_buy_num_cost/1, 
         vip_buy_acc_num_cost/1, 
         vip_buy_shuangta_num/1, 
         rand_monster/2, 
         get_star/1, 
         get_condition/1, 
         get_chapter_list/1,
         get_all_boss_dungeon_id/0,
         can_dungeon_top/1,
         king_boss_dungeon_list/0
        ]).

""")

dungeon_type = []
dungeon_range = []

king_boss_dungeon_id_start = 0
king_boss_dungeon_id_end = 0
dungeon_range.append("%% @doc 获取副本范围")
@load_sheel(work_book, ur"副本分类")
def get_dungeon_type(content):
    d_type = str(content[0])
    name = str(content[1])
    begin_id = int(content[2])
    end_id = int(content[3])
    dungeon_type.append("get_type(DungeonID) when DungeonID >= %d andalso DungeonID =< %d -> %s; %%%% %s"%(begin_id, end_id, d_type, name))
    dungeon_range.append("get_range(%s) -> {%d, %d}; %%%% %s"%(d_type, begin_id, end_id, name))

    global king_boss_dungeon_id_start
    global king_boss_dungeon_id_end
    if d_type == "king_boss":
        if king_boss_dungeon_id_start == 0 or king_boss_dungeon_id_start > begin_id:
            king_boss_dungeon_id_start = begin_id
        if king_boss_dungeon_id_end == 0 or king_boss_dungeon_id_end < end_id:
            king_boss_dungeon_id_end = end_id
    return []
get_dungeon_type()
dungeon_type.append("get_type(_) -> {1, 0}.")
dungeon_range.append("get_range(_) -> {0, 0}.")

data_dungeon.extend(dungeon_type)
data_dungeon.extend(dungeon_range)

print king_boss_dungeon_id_start
print king_boss_dungeon_id_end

vip_clean_cd_cost_list = []
vip_buy_max_clean_cd = 0
vip_clean_cd_cost_list.append("%% @spec vip_clean_cd_cost(Num::int()) -> Gold::int()")
@load_sheel(work_book, ur"Sheet2")
def get_vip_clean_cd_cost(content):
    num = int(content[0])
    global vip_buy_max_clean_cd
    if num > vip_buy_max_clean_cd:
        vip_buy_max_clean_cd = num
    gold = int(content[1])
    vip_clean_cd_cost_list.append("vip_clean_cd_cost(%d) -> %d;"%(num, gold))
    return []

get_vip_clean_cd_cost()
vip_clean_cd_cost_list.append("vip_clean_cd_cost(_) -> vip_clean_cd_cost(%d)."%(vip_buy_max_clean_cd))
data_dungeon.extend(vip_clean_cd_cost_list)

vip_buy_num_cost_list = []
vip_buy_max_num = 0
vip_buy_num_cost_list.append("%% @spec vip_buy_num_cost(Num::int()) -> Gold::int()")

vip_buy_acc_num_cost_list = []
vip_buy_max_num = 0
vip_buy_max_acc_num = 0
vip_buy_acc_num_cost_list.append("%% @spec vip_buy_acc_num_cost(Num::int()) -> Gold::int()")

@load_sheel(work_book, ur"精英副本买次数收费")
def get_vip_buy_num_cost(content):
    num = int(content[0])
    global vip_buy_max_num
    global vip_buy_max_acc_num
    if num > vip_buy_max_num:
        vip_buy_max_num = num
    gold = int(content[1])
    acc_gold = int(content[2])
    if num > vip_buy_max_acc_num:
        vip_buy_max_acc_num = num
    vip_buy_num_cost_list.append("vip_buy_num_cost(%d) -> %d;"%(num, gold))
    vip_buy_acc_num_cost_list.append("vip_buy_acc_num_cost(%d) -> %d;"%(num, gold))
    return []

get_vip_buy_num_cost()
vip_buy_num_cost_list.append("vip_buy_num_cost(_) -> vip_buy_num_cost(%d)."%(vip_buy_max_num))
vip_buy_acc_num_cost_list.append("vip_buy_acc_num_cost(_) -> vip_buy_acc_num_cost(%d)."%(vip_buy_max_acc_num))
data_dungeon.extend(vip_buy_num_cost_list)
data_dungeon.extend(vip_buy_acc_num_cost_list)


vip_buy_shuangta_num = []
vip_buy_shuangta_num.append("vip_buy_shuangta_num(_) -> 0.")
data_dungeon.extend(vip_buy_shuangta_num)

rand_monster = []
rand_monster.append("rand_monster(_, _) -> {0, 0}.")
data_dungeon.extend(rand_monster)

chubing_array = {}
@load_sheel(work_book, ur"出兵配置")
def get_chubing(content):
    id = int(content[ChuBingField.id])
    scene_id = int(content[ChuBingField.scene_id])
    populace = int(content[ChuBingField.populace])
    init_mate = get_str(content[ChuBingField.initMate], '')
    init_monster_list = get_str(content[ChuBingField.initMonster], '')
    pos_rf_monster_list = get_str(content[ChuBingField.posRefreshMonster], '')
    rf_monster_list = get_str(content[ChuBingField.refreshMonster], '')
    is_rf_loop = int(get_value(content[ChuBingField.loop], 0))
    base_1 = get_str(content[ChuBingField.base_1], '0, 0, 0')
    base_2 = get_str(content[ChuBingField.base_2], '0, 0, 0')
    rf_mate_monster_list = get_str(content[ChuBingField.refreshMateMonster], '')
    is_rf_mate_loop = int(get_value(content[ChuBingField.mateLoop], 0))
    init_mate_list = get_str(content[ChuBingField.initMate], '')
    round_rf_monster_list = get_str(content[ChuBingField.roundRefreshMonster], '')
    protect_monster_list = get_str(content[ChuBingField.protectMonster], '')
    chubing_array.setdefault(id, {})
    chubing_array[id]['scene_id'] = scene_id
    chubing_array[id]['populace'] = populace
    chubing_array[id]['init_mate'] = init_mate
    chubing_array[id]['init_monster_list'] = init_monster_list
    chubing_array[id]['pos_rf_monster_list'] = pos_rf_monster_list
    chubing_array[id]['rf_monster_list'] = rf_monster_list
    chubing_array[id]['is_rf_loop'] = is_rf_loop
    chubing_array[id]['base_1'] = base_1
    chubing_array[id]['base_2'] = base_2
    chubing_array[id]['rf_mate_monster_list'] = rf_mate_monster_list
    chubing_array[id]['is_rf_mate_loop'] = is_rf_mate_loop
    chubing_array[id]['init_mate_list'] = init_mate_list
    chubing_array[id]['round_rf_monster_list'] = round_rf_monster_list
    chubing_array[id]['protect_monster_list'] = protect_monster_list
    return []
get_chubing()


can_dungeon_top_list = []
can_dungeon_top_list.append("""
%% @doc 是否可以显示在副本记录中
%% @spec can_dungeon_top(DungeonID) -> false|true """)
dungeon_top_list = []

dungeon_base = []
chapter_list = {}
dungeon_base.append("%% @spec get(DungeonID :: int()) -> #dungeon_base{} | false")

king_boss_dungeon_list = []
@load_sheel(work_book, ur"副本配置")
def get_dungeon(content):
    dungeon_id = int(content[BaseField.id])
    aid = int(content[BaseField.aid])
    name = get_str(content[BaseField.name], '')
    realm = get_str(content[BaseField.camp], '0')
    pre_id_list = get_str(content[BaseField.pre_id], '')
    dType = int(get_value(content[BaseField.dType], 0))
    fight_type = int(get_value(content[BaseField.fightType], 0))
    need_lev = int(get_value(content[BaseField.level], 0))
    base_drop = get_str(content[BaseField.base_drop], '')
    special_drop = get_str(content[BaseField.special_drop], '')
    chapter = int(get_value(content[BaseField.chapter], 0))
    energy = int(get_value(content[BaseField.vit], 0))
    max_count = int(get_value(content[BaseField.dTimes], 0))
    coin = int(get_value(content[BaseField.coin], 0))
    hero_exp = int(get_value(content[BaseField.heroExp], 0))
    week_day_list = get_str(content[BaseField.openDays], '1, 2, 3, 4, 5, 6, 7')
    cd_time = int(get_value(content[BaseField.atkCD], 90))
    quick_finish_items = str(get_value(content[BaseField.quickFinishItems], ''))
    quick_finish_need_items = str(get_value(content[BaseField.quickFinishNeedItems], ''))
    boss_drop = str(get_value(content[BaseField.monsterDrop], ''))
    dec_count_type = int(get_value(content[BaseField.decCountType], 0))
    ## star_require = int(get_value(content[BaseField.star_require], 0))
    star_require = 0
    goto_vip_lev = int(get_value(content[BaseField.vipLevelToDungeon], 0))
    ## populace = int(get_value(content[BaseField.populace], 0))
    ## init_monster_list = get_str(content[BaseField.initMonster], '')
    ## pos_rf_monster_list = get_str(content[BaseField.posRefreshMonster], '')
    ## rf_monster_list = get_str(content[BaseField.refreshMonster], '')
    ## is_rf_loop = int(get_value(content[BaseField.loop], 0))
    chubing_id = int(get_value(content[BaseField.monsterProduct], 0))
    star = str(get_value(content[BaseField.starRequest], ''))

    first_pass_obtain_gold = int(get_value(content[BaseField.first_pass_obtain_gold], 0))

    is_boss = int(get_value(content[BaseField.isBoss], 0))

    global king_boss_dungeon_id_start
    global king_boss_dungeon_id_end

    if dungeon_id >= king_boss_dungeon_id_start and dungeon_id <= king_boss_dungeon_id_end:
        king_boss_dungeon_list.append("%d"%(dungeon_id))

    if is_boss == 1:
        can_dungeon_top_list.append("can_dungeon_top(%d) -> true;"%(dungeon_id)) 
        dungeon_top_list.append("%d"%(dungeon_id))

    chapter_list.setdefault(chapter, [])
    chapter_list[chapter].append("%d"%(dungeon_id))

    score1      = int(get_value(content[BaseField.leaderScore], 0))
    score2      = int(get_value(content[BaseField.score1], 0))
    score3      = int(get_value(content[BaseField.score2], 0))
    score4      = int(get_value(content[BaseField.score3], 0))
    tank_atk    = int(get_value(content[BaseField.tankStrAtt], 0))
    tank_def    = int(get_value(content[BaseField.tankStrDef], 0))
    tank_hp     = int(get_value(content[BaseField.tankStrHP], 0))
    plane_atk   = int(get_value(content[BaseField.planeStrAtt], 0))
    plane_def   = int(get_value(content[BaseField.planeStrDef], 0))
    plane_hp    = int(get_value(content[BaseField.planeStrHP], 0))
    solider_atk = int(get_value(content[BaseField.soliderStrAtt], 0))
    solider_def = int(get_value(content[BaseField.soliderStrDef], 0))
    solider_hp  = int(get_value(content[BaseField.soliderStrHP], 0))
    chariot_atk = int(get_value(content[BaseField.chariotStrAtt], 0))
    chariot_def = int(get_value(content[BaseField.chariotStrDef], 0))
    chariot_hp  = int(get_value(content[BaseField.chariotStrHP], 0))
    leader_lev  = int(get_value(content[BaseField.leaderLevel], 0))

    dungeon_base.append("""get({0}) ->
    #dungeon_base{{
        aid = {1}
        ,id = {0}
        ,type = {2}
        ,pre_id_list = [{3}]
        ,fight_type = {33}
        ,need_lev = {4}
        ,base_drop = [{5}]
        ,special_drop = [{6}]
        ,boss_drop = [{15}]
        ,need_energy = {7}
        ,max_count = {8}
        ,coin = {9}
        ,hero_exp = {10}
        ,week_day_list = [{11}]
        ,cd_time = {12}
        ,quick_finish_items = [{13}]
        ,quick_finish_need_items = [{14}]
        ,dec_count_type = {16}
        ,need_pre_chapter_stars = {17}
        ,goto_vip_lev = {18}
        ,need_realm_list = [{19}]
        ,populace = {20},
        init_monster_list = [{21}],
        pos_rf_monster_list = [{22}],
        rf_monster_list = [{23}],
        is_rf_loop = {24},
        scene_id = {25},
        base_1 = {{{26}}},
        base_2 = {{{27}}},
        rf_mate_monster_list = [{28}],
        is_rf_mate_loop = {29},
        init_mate_list = [{30}],
        round_rf_monster_list = [{31}],
        protect_monster_list = [{32}],
        star_list = [{34}],
        leader_attrs = [{{?TANK_ATK, {35}}}, {{?TANK_DEF, {36}}},{{?TANK_HP, {37}}},{{?PLANE_ATK, {38}}},{{?PLANE_DEF, {39}}},{{?PLANE_HP, {40}}},{{?SOLIDER_ATK, {41}}},{{?SOLIDER_DEF, {42}}},{{?SOLIDER_HP, {43}}},{{?CHARIOT_ATK, {44}}},{{?CHARIOT_DEF, {45}}},{{?CHARIOT_HP, {46}}}],
        dungeon_name = <<"{47}">>,
        score1 = {48},
        score2 = {49},
        score3 = {50},
        score4 = {51},
        leader_lev = {52},
        first_pass_obtain_gold = {53}
    }}; """.format(
        dungeon_id, 
        aid, 
        dType, 
        pre_id_list, 
        need_lev, 
        base_drop, 
        special_drop, 
        energy, 
        max_count, 
        coin, 
        hero_exp, 
        week_day_list, 
        cd_time, 
        quick_finish_items, 
        quick_finish_need_items, 
        boss_drop, 
        dec_count_type, 
        star_require, 
        goto_vip_lev, 
        realm,
        chubing_array.get(chubing_id, {}).get('populace', 0),
        chubing_array.get(chubing_id, {}).get('init_monster_list', ''),
        chubing_array.get(chubing_id, {}).get('pos_rf_monster_list', ''),
        chubing_array.get(chubing_id, {}).get('rf_monster_list', ''),
        chubing_array.get(chubing_id, {}).get('is_rf_loop', 0),
        chubing_array.get(chubing_id, {}).get('scene_id', 0),
        chubing_array.get(chubing_id, {}).get('base_1', '0, 0, 0'),
        chubing_array.get(chubing_id, {}).get('base_2', '0, 0, 0'),
        chubing_array.get(chubing_id, {}).get('rf_mate_monster_list', ''),
        chubing_array.get(chubing_id, {}).get('is_rf_mate_loop', 0),
        chubing_array.get(chubing_id, {}).get('init_mate_list', ''),
        chubing_array.get(chubing_id, {}).get('round_rf_monster_list', ''),
        chubing_array.get(chubing_id, {}).get('protect_monster_list', ''),
        fight_type,
        star,
        tank_atk,
        tank_def,
        tank_hp,
        plane_atk,
        plane_def,
        plane_hp,
        solider_atk,
        solider_def,
        solider_hp,
        chariot_atk,
        chariot_def,
        chariot_hp,
        name,
        score1,
        score2,
        score3,
        score4,
        leader_lev,
        first_pass_obtain_gold
        ))
    return []

get_dungeon()
dungeon_base.append("get(_) -> false.")
can_dungeon_top_list.append("can_dungeon_top(_) -> false.")
data_dungeon.extend(dungeon_base)
data_dungeon.extend(can_dungeon_top_list)

data_dungeon.append("""
%% @doc 所有的boss关卡
%% @doc get_all_boss_dungeon_id() -> list() 
get_all_boss_dungeon_id() -> [%s]."""%(",".join(dungeon_top_list)))

data_dungeon.append("""
%% @doc 所有王牌挑战关卡
%% @spec king_boss_dungeon_list() -> list()
king_boss_dungeon_list() -> [%s]. """%(",".join(king_boss_dungeon_list)))

c_list = []
for chapter in chapter_list:
    c_list.append("get_chapter_list(%d) -> [%s];"%(chapter, ",".join(chapter_list[chapter])))

c_list.append("get_chapter_list(_) -> [].")
data_dungeon.append("%% @doc 获得章节列表副本")
data_dungeon.extend(c_list)


data_dungeon.append("%% @doc 获得星级条件列表")
star_list = []
@load_sheel(work_book, ur"星级条件")
def get_star(content):
    index = int(get_value(content[StarField.index], 0))
    s_type = int(get_value(content[StarField.s_type], 0))
    detail = int(get_value(content[StarField.detail], 0)) 
    star_list.append("""get_star(%d) -> [%d, %d];"""%(index, s_type, detail))
    return []
get_star()
star_list.append("get_star(_) -> [].")
data_dungeon.extend(star_list)

dungeon_base.append("%% @doc 获得战斗胜负判断")
condition_list = []
@load_sheel(work_book, ur"战斗形式配置")
def get_condition_list(content):
    id = int(get_value(content[FightField.id], 0))
    win_list = get_str(content[FightField.winList], '')
    fail_list = get_str(content[FightField.failList], '')
    condition_list.append("""get_condition(%d) -> 
    #condition{
        id = %d,
        win_list = [%s], 
        fail_list = [%s]
    };"""%(id, id, win_list, fail_list))
    return []

get_condition_list()
condition_list.append("get_condition(_) -> false.")
data_dungeon.extend(condition_list)


gen_erl(dungeon_erl, data_dungeon)
