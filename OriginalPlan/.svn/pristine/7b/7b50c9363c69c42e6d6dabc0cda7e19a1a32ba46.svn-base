#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
野外配置
@author: BenQi
@deprecated: 2015-11-13
'''
import os
import __builtin__

# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"wilderness")

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

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

TroopsIndex = """
    retreat_time
    ,repairiron_cost
    ,sendarmy_rate
    ,guard_rate
    ,sheild_time
    ,baserepair_time
    ,SOS_cd
    ,repair_time
    ,crystal
    ,iron
    ,uranium
    ,army_lostresourse
    ,protect_lev
    ,army_parameterA
    ,base_parameterA
    ,basebattle_resourse
    ,guildslayer
    ,ability_subtraction
    ,personalContribution
    ,guildsProsperouLose
    ,guildscoreD
    ,joblayer
    ,basemovecd
    ,gainitem
    ,transfer_item
    ,tran_cost
    ,rob_cost
    ,monster_cost
 """

MineLevIndex = """
    index
    ,max_opportunity
 """

MineBaseIndex = """
    index
    ,resoure_ID
    ,resoure_lev
    ,mine_effect
    ,reserves
    ,clean_reward
    ,clean_item
    ,max_velocity
 """

DistanceIndex = """
    distance
    ,tran_cost
    ,tranbase_cost
    ,decay_rate
    ,retreat_time
"""

RefreshMineIndex = """
    district_lev
    ,district
    ,mine_refresh_lev
    ,minerefresh_cd
    ,minerefresh_match
    ,monster_num_list
    ,monster_check_time
"""

MineNumIndex = """
    player_num
    ,mine_refresh_amount1
    ,mine_refresh_amount2
    ,mine_refresh_amount3
"""

ScreenMineIndex = """
    screen_id
    ,mine_id
    ,mine_axis
    ,mine_species
    ,mine_level
    ,mine_capcity
"""

ResourcesIndex = """
    count,
    cost_gold,
    cd_time,
    crystal,
    iron,
    uranium
"""

BlocksIndex = """
    index,
    data
"""

BlocksTypeIndex = """
    index,
    type
"""

MapIndex = """
    index,
    mapIndex
"""

MonsterRefreshIndex = """
    index,
    mainmonster,
    lead,
    ability,
    antiaircraft,
    fristblood,
    fristkill,
    herokill,
    reward,
    exp,
    coin,
    is_boss
"""

MonsterRewardIndex = """
    monster_id,
    item_list,
    first_item_list
"""

WildBaseIndex = """
    index,
    cavalry_num,
    wall_rescue,
    base_lev_reward,
    wallrepaircost
"""

WildRepairIndex = """
    repairforce, 
    require_iron
"""

TroopsField         = Field('TroopsField'       , TroopsIndex)
MineLevField        = Field('MineLevField'      , MineLevIndex)
MineBaseField       = Field('MineBaseField'     , MineBaseIndex)
DistanceField       = Field('DistanceField'     , DistanceIndex)
RefreshMineField    = Field('RefreshMineField'  , RefreshMineIndex)
MineNumField        = Field('MineNumField'      , MineNumIndex)
ScreenMineField     = Field('ScreenMineField'   , ScreenMineIndex)
ResourcesField      = Field('ResourcesField'    , ResourcesIndex)
BlocksField         = Field('BlocksField'       , BlocksIndex)
BlocksTypeField     = Field('BlocksTypeField'   , BlocksTypeIndex)
MapField            = Field('MapField'          , MapIndex)
MonsterRefreshField = Field('MonsterRefreshField', MonsterRefreshIndex)
MonsterRewardField  = Field('MonsterRewardField', MonsterRewardIndex)
WildBaseField       = Field('WildBaseField'     , WildBaseIndex)
WildRepairField     = Field('WildRepairField'   , WildRepairIndex)


wilderness_erl = "data_wilderness"
data_widlerness = module_header(ur"野外配置", wilderness_erl, "bq", "wilderness.xlsx", "data_wilderness.py")
# data_wilderness.append("-include(wilderness.hrl).")
data_widlerness.append("""
-export(
    [
        get_troops_base/0,
        get_mine_base/2,
        get_dis_mine/1,
        get_refresh_mine/1,
        get_refresh_mine_num/1,
        get_screen_mine_list/1,
        get_screen_mine/2,
        get_area_list/0,
        get_mine_rate_by_dis/1,
        get_mine_rate_by_lev/2,
        get_mine_num_rate/2,
        get_atk_cost_by_dis/1,
        buy_resources/2,
        get_area_refresh_cd/1,
        get_base_cost_by_dis/1,
        is_block/1,
        get_monster/1,
        get_monster_drop_id/1,
        get_monster_first_reward/1,
        get_area_monster_list/1,
        get_area_monster_cd/1,
        get_monster_lev_list/0,
        get_monster_reward_mine/1,
        get_monster_exp/1,
        get_monster_coin/1,
        get_retreat_time_by_dis/1,
        wild_base_info/0,
        get_troops_repair/1,
        get_monster_drop_reward/1,
        get_feats_reward/2
    ]).

-include("wilderness.hrl").
    
%% 根据距离计算采矿速度
get_mine_rate_by_dis(Dis) ->
    case get_dis_mine(Dis) of
        #dis_mine{mine_rate = MineRate} -> MineRate;
        _ -> 0
    end.

%% 根据矿信息计算采矿速度
get_mine_rate_by_lev(Type, Level) ->
    case get_mine_base(Type, Level) of
        #type_mine{mine_rate = MineRate} -> MineRate;
        _ -> 0
    end.

%% 根据矿信息获得最大储量系数
get_mine_num_rate(Type, Level) ->
    case get_mine_base(Type, Level) of
        #type_mine{mine_num_rate = MineNumRate} -> MineNumRate;
        _ -> 0
    end.

%% 根据距离计算传送消耗
get_atk_cost_by_dis(Dis) ->
    case get_dis_mine(Dis) of
        #dis_mine{tran_cost = TranCost} -> TranCost;
        _ -> []
    end.

%% 根据距离计算迁移基地消耗
get_base_cost_by_dis(Dis) ->
    case get_dis_mine(Dis) of
        #dis_mine{tran_base_cost = TranBaseCost} -> TranBaseCost;
        _ -> []
    end.

%% 根据距离计算撤退时间
get_retreat_time_by_dis(Dis) ->
    case get_dis_mine(Dis) of
        #dis_mine{retreat_time = RetreatTime} -> RetreatTime;
        _ -> 0
    end.

%% 获得区域刷矿CD
get_area_refresh_cd(AreaID) ->
    case get_refresh_mine(AreaID) of
        #refresh_mine{refresh_cd = RefreshCD} -> RefreshCD;
        _ -> 9999
    end.

%% 获得区域刷怪列表
get_area_monster_list(AreaID) ->
    case get_refresh_mine(AreaID) of
        #refresh_mine{monster_num_list = MonsterNumList} -> MonsterNumList;
        _ -> []
    end.

%% 获得区域刷怪CD
get_area_monster_cd(AreaID) ->
    case get_refresh_mine(AreaID) of
        #refresh_mine{monster_check_time = MonsterCheckTime} -> MonsterCheckTime;
        _ -> []
    end.

%% 获得野怪奖励
get_monster_reward_mine(MonsterLev) ->
    case get_monster(MonsterLev) of
        #wild_monster_base{reward = Reward} -> Reward;
        _ -> [0, 0, 0]
    end.

%% 获得野怪经验
get_monster_exp(MonsterLev) ->
    case get_monster(MonsterLev) of
        #wild_monster_base{exp = Exp} -> Exp;
        _ -> 0
    end.

%% 获得野怪经验
get_monster_coin(MonsterLev) ->
    case get_monster(MonsterLev) of
        #wild_monster_base{coin = Coin} -> Coin;
        _ -> 0
    end.

""")


troops_list = []
troops_list.append("%% @spec get_troops_base() -> #troops_base{}")

@load_sheel(work_book, ur"部队基本配置")
def get_troops_base(content):
    retreat_time    = int(content[TroopsField.retreat_time])
    repair_cost     = get_str(content[TroopsField.repairiron_cost], '')
    sendarmy_rate   = int(content[TroopsField.sendarmy_rate])
    guard_rate      = int(content[TroopsField.guard_rate])
    sheild_time     = int(content[TroopsField.sheild_time])
    base_repair_time= int(content[TroopsField.baserepair_time])
    help_cd         = int(content[TroopsField.SOS_cd])
    repair_time     = int(content[TroopsField.repair_time])
    crystal         = int(content[TroopsField.crystal])
    iron            = int(content[TroopsField.iron])
    uranium         = int(content[TroopsField.uranium])
    troops_lose_rate= int(content[TroopsField.army_lostresourse])
    protect_lev     = int(content[TroopsField.protect_lev])
    fight_exp_rate  = int(content[TroopsField.army_parameterA])
    base_resources  = int(content[TroopsField.base_parameterA])
    base_lose_rate  = int(content[TroopsField.basebattle_resourse])
    power_rate      = get_str(content[TroopsField.guildslayer], '')
    power_difference= get_str(content[TroopsField.ability_subtraction], '')
    union_add_exp   = int(content[TroopsField.personalContribution])
    union_del_exp   = int(content[TroopsField.guildsProsperouLose])
    revenge_rate    = int(content[TroopsField.guildscoreD])
    union_rate      = get_str(content[TroopsField.joblayer], '')
    base_move_cd    = int(content[TroopsField.basemovecd])
    init_item_list  = get_str(content[TroopsField.gainitem], '')
    transfer_item   = int(content[TroopsField.transfer_item])
    vigour_normal_cost = int(content[TroopsField.tran_cost])
    vigour_base_cost = int(content[TroopsField.rob_cost])
    vigour_monster_cost = int(content[TroopsField.monster_cost])

    troops_list.append("""get_troops_base() -> 
    #troops_base{
        retreat_time = %d,
        repair_cost = [%s],
        sendarmy_rate = %d,
        guard_rate = %d,
        sheild_time = %d,
        base_repair_time = %d,
        help_cd = %d,
        repair_time = %d,
        init_reward = [{add_crystal, %d}, {add_iron, %d}, {add_uranium, %d}],
        troops_lose_rate = %d,
        protect_lev = %d,
        fight_exp_rate = %d,
        base_resources = %d,
        base_lose_rate = %d,
        power_rate = tuple_to_list(%s),
        power_difference = [%s],
        union_add_exp = %d,
        union_del_exp = %d,
        revenge_rate = %d,
        union_rate = tuple_to_list(%s),
        base_move_cd = %d,
        init_item_list = [{add_items, [%s]}],
        transfer_item_id = %d,
        vigour_normal_cost = %d,
        vigour_base_cost = %d,
        vigour_monster_cost = %d
    }."""%(retreat_time, repair_cost, sendarmy_rate, guard_rate, sheild_time, base_repair_time, help_cd, repair_time, crystal, iron, uranium, troops_lose_rate, protect_lev, fight_exp_rate, base_resources, base_lose_rate, power_rate, power_difference, union_add_exp, union_del_exp, revenge_rate, union_rate, base_move_cd, init_item_list, transfer_item, vigour_normal_cost, vigour_base_cost, vigour_monster_cost))
    return []

get_troops_base()
data_widlerness.extend(troops_list)
        

mine_base_list = []
mine_base_list.append("%% @spec get_mine_base(Tpye::int(), Lev::int()) -> #type_mine{}")

@load_sheel(work_book, ur"矿基本配置")
def get_mine_base(content):
    type            = int(content[MineBaseField.resoure_ID])
    lev             = int(content[MineBaseField.resoure_lev])
    mine_num_rate   = int(content[MineBaseField.reserves])
    clean_reward    = get_str(content[MineBaseField.clean_reward], '')
    clean_item      = get_str(content[MineBaseField.clean_item], '')
    mine_rate       = int(content[MineBaseField.max_velocity])

    mine_base_list.append("""get_mine_base(%d, %d) -> 
    #type_mine{
        type = %d,
        lev = %d,
        mine_num_rate = %d,
        clean_reward = [%s],
        clean_item = [%s],
        mine_rate = %d
    };"""%(type, lev, type, lev, mine_num_rate, clean_reward, clean_item, mine_rate))
    return []

get_mine_base()
mine_base_list.append("get_mine_base(_, _) -> false.")
data_widlerness.extend(mine_base_list)

distance_list = []
distance_list.append("%% @spec get_dis_mine(Dis::int()) -> #dis_mine{}")
max_dis = 0
@load_sheel(work_book, ur"距离挂钩")
def get_dis_mine(content):
    dis             = int(content[DistanceField.distance])
    tran_cost       = int(content[DistanceField.tran_cost])
    tran_base_cost  = int(content[DistanceField.tranbase_cost])
    mine_rate       = int(content[DistanceField.decay_rate])
    retreat_time    = int(content[DistanceField.retreat_time])

    global max_dis 
    max_dis = dis

    distance_list.append("""get_dis_mine(Dis) when Dis =< %d -> 
    #dis_mine{
        dis = %d,
        tran_cost = [{del_crystal, %d}],
        tran_base_cost = [{del_gold, %d}],
        mine_rate = %d,
        retreat_time = %d
    };"""%(dis, dis, tran_cost, tran_base_cost, mine_rate, retreat_time))
    return []

get_dis_mine()
distance_list.append("get_dis_mine(_) -> get_dis_mine(%d)."%(max_dis))
data_widlerness.extend(distance_list)


refresh_mine_list = []
area_list = []
refresh_mine_list.append("%% @spec get_refresh_mine(Lev::int()) -> #refresh_mine{}")

@load_sheel(work_book, ur"矿的刷新基础配置")
def get_refresh_mine(content):
    id              = int(content[RefreshMineField.district_lev])
    district        = get_str(content[RefreshMineField.district], '')
    refresh_cd      = int(content[RefreshMineField.minerefresh_cd])
    screen_id_list  = get_str(content[RefreshMineField.minerefresh_match], '')
    monster_num_list= get_str(content[RefreshMineField.monster_num_list], '{}')
    monster_check_time= int(content[RefreshMineField.monster_check_time])

    refresh_mine_list.append("""get_refresh_mine(%d)-> 
    #refresh_mine{
        id          = %d,
        district    = [%s],
        refresh_cd  = %d,
        screen_id_list = [%s],
        monster_num_list = tuple_to_list(%s),
        monster_check_time = %d
    };"""%(id, id, district, refresh_cd, screen_id_list, monster_num_list, monster_check_time))

    area_list.append("%d"%(id))
    return []

get_refresh_mine()
refresh_mine_list.append("get_refresh_mine(_) -> false.")
data_widlerness.extend(refresh_mine_list)
data_widlerness.append("%% @spec get_area_list() -> list().")
data_widlerness.append("get_area_list() -> [%s]."%(",".join(area_list)))


mine_num_list = []
mine_num_list.append("%% @spec get_refresh_mine_num(RoleNum::int()) -> #refresh_mine_num{}")
max_role_num = 0
@load_sheel(work_book, ur"刷矿量随参与人数变化")
def get_mine_num(content):
    role_num    = int(content[MineNumField.player_num])
    area_mine_1 = get_str(content[MineNumField.mine_refresh_amount1], '{}')
    area_mine_2 = get_str(content[MineNumField.mine_refresh_amount2], '{}')
    area_mine_3 = get_str(content[MineNumField.mine_refresh_amount3], '{}')

    global max_role_num 
    max_role_num = role_num 

    mine_num_list.append("""get_refresh_mine_num(RoleNum) when RoleNum =< %d -> 
    #refresh_mine_num{
        role_num = %d,
        area_mine_1 = %s,
        area_mine_2 = %s,
        area_mine_3 = %s
    };"""%(role_num, role_num, area_mine_1, area_mine_2, area_mine_3))
    return []

get_mine_num()
mine_num_list.append("get_refresh_mine_num(_) -> get_refresh_mine_num(%d)."%(max_role_num))
data_widlerness.extend(mine_num_list)

resources_list = []
resources_list.append("%% @spec buy_resources(ResourcesID::int(), Count::int()) -> list()")
max_count = 0
@load_sheel(work_book, ur"野外资源购买")
def get_resourse(content):
    count       = int(content[ResourcesField.count])
    cost_gold   = int(content[ResourcesField.cost_gold])
    cd_time     = int(content[ResourcesField.cd_time])
    crystal     = int(content[ResourcesField.crystal])
    iron        = int(content[ResourcesField.iron])
    uranium     = int(content[ResourcesField.uranium])

    global max_count 
    max_count = count
    resources_list.append("""buy_resources(?CRYSTAL, %d)-> {[{del_gold, %d},{add_crystal, %d}], %d};"""%(count, cost_gold, crystal, cd_time))
    resources_list.append("""buy_resources(?IRON, %d)-> {[{del_gold, %d},{add_iron, %d}], %d};"""%(count, cost_gold, iron, cd_time))
    resources_list.append("""buy_resources(?URANIUM, %d)-> {[{del_gold, %d},{add_uranium, %d}], %d};"""%(count, cost_gold, uranium, cd_time))

    return []

get_resourse()
resources_list.append("buy_resources(ResourcesID, _) -> buy_resources(ResourcesID, %d)."%(max_count))
data_widlerness.extend(resources_list)

screen_base = {}
screen_list = []
screen_list.append("%% @spec get_screen_mine(ScreenID::int(), MineID::int()) -> #refresh_mine_num{}")

@load_sheel(work_book, ur"基础屏配置")
def get_screen_base(content):
    screen_id       = int(content[ScreenMineField.screen_id])
    mine_id         = int(content[ScreenMineField.mine_id])
    mine_pos_list   = get_str(content[ScreenMineField.mine_axis], '')
    mine_type       = int(content[ScreenMineField.mine_species])
    mine_level      = int(content[ScreenMineField.mine_level])
    mine_num_list   = get_str(content[ScreenMineField.mine_capcity], '{}')

    screen_base.setdefault(screen_id, [])
    screen_base[screen_id].append("%d"%(mine_id))

    screen_list.append("""get_screen_mine(%d, %d) -> 
    #screen_mine{
        screen_id = %d,
        mine_id = %d,
        mine_pos_list = [%s],
        mine_type = %d,
        mine_level = %d,
        mine_num_list = [%s]
    };"""%(screen_id, mine_id, screen_id, mine_id, mine_pos_list, mine_type, mine_level, mine_num_list))
    return []

get_screen_base()

screen_list.append("get_screen_mine(_, _) -> false.")

data_widlerness.append("%% @spec get_screen_mine_list(ScreenID::int()) -> list()")
for i in screen_base:
    data_widlerness.append("get_screen_mine_list(%d) -> [%s];"%(i, ",".join(screen_base[i])))
data_widlerness.append("get_screen_mine_list(_) -> [].")

data_widlerness.extend(screen_list)

block_list = {}
@load_sheel(work_book, ur"地表块配置")
def get_blocks(content):
    index = int(content[BlocksField.index])
    data  = get_str(content[BlocksField.data], '')

    block_list.setdefault(index, '')
    block_list[index] = data

    return []

get_blocks()

blocks_type = {}
@load_sheel(work_book, ur"地表元素索引表")
def get_blocks_type(content):
    index = int(content[BlocksTypeField.index])
    type  = int(content[BlocksTypeField.type])
    blocks_type.setdefault(index, 0)
    blocks_type[index] = type

    return []

get_blocks_type()

screen_length = 12
screen_num = 384 / 12
block_pos_list = []
data_widlerness.append("%% @spec get_block_list() -> list()")
@load_sheel(work_book, ur"大地图地表配置")
def get_map(content):
    index = int(content[MapField.index])
    map_index  = int(content[MapField.mapIndex])
    global screen_length
    global screen_num

    map_list = block_list[map_index].split(',')

    x = ((index - 1) % screen_num) * screen_length 
    y = ((index - 1) / screen_num) * screen_length

    # print index,x,y
    # print map_index
    for i in map_list:
        type = blocks_type[int(i)]
        if type != 0:
            block_pos_list.append("is_block({%d, %d}) -> true;"%(x,y))
        if ((x + 1) % screen_length) == 0:
            x = ((index - 1) % screen_num) * screen_length
            y = y + 1
        else:
            x = x + 1
    return []

get_map()

block_pos_list.append("is_block(_) -> false.")
data_widlerness.extend(block_pos_list)


monster_list = []
monster_list.append("%% @spec get_monster(Lev::int()) -> #wild_monster_base{}")
monster_lev_list = []

@load_sheel(work_book, ur"刷野怪配置")
def get_monster(content):
    lev             = int(content[MonsterRefreshField.index])
    monster_power   = int(content[MonsterRefreshField.ability])
    main_monster    = get_str(content[MonsterRefreshField.mainmonster], '')
    reward          = get_str(content[MonsterRefreshField.reward], '{0,0,0}')
    monster_list_1  = get_str(content[MonsterRefreshField.antiaircraft], '') 
    monster_list_2  = get_str(content[MonsterRefreshField.lead], '')
    exp             = int(content[MonsterRefreshField.exp])
    coin            = int(content[MonsterRefreshField.coin])
    
    is_boss         = int(content[MonsterRefreshField.is_boss])

    monster_list.append("""get_monster(%d)-> 
    #wild_monster_base{
        lev = %d,
        monster_power = %d,
        main_monster = [%s],
        reward = tuple_to_list(%s),
        monster_list_1 = [%s],
        monster_list_2 = %s,
        exp = %d,
        coin = %d,
        is_boss = %d
    };"""%(lev, lev, monster_power, main_monster, reward, monster_list_1, monster_list_2, exp, coin, is_boss))
    monster_lev_list.append("%d"%(lev))
    return []

get_monster()

monster_list.append("get_monster(_) -> false.")

data_widlerness.extend(monster_list)
data_widlerness.append("get_monster_lev_list() -> [%s]."%(",".join(monster_lev_list)))

monster_reward_list = []
monster_reward_list.append("%% @spec get_monster_drop_id(MonsterID::int()) -> DropID::int()")
monster_first_list = []
monster_first_list.append("%% @spec get_monster_first_reward(MonsterID::int()) -> item_list::list()")

@load_sheel(work_book, ur"野怪奖励配置")
def get_monster_drop_id(content):
    monster_id  = int(content[MonsterRewardField.monster_id])
    drop_id   = int(content[MonsterRewardField.item_list])
    first_item_list = get_str(content[MonsterRewardField.first_item_list], '')

    monster_reward_list.append("""get_monster_drop_id(%d)-> %d;"""%(monster_id, drop_id))
    monster_first_list.append("""get_monster_first_reward(%d) -> [%s];"""%(monster_id, first_item_list))
    return []

get_monster_drop_id()

monster_reward_list.append("get_monster_drop_id(_) -> false.")
monster_first_list.append("get_monster_first_reward(_) -> [].")

data_widlerness.extend(monster_reward_list)
data_widlerness.extend(monster_first_list)

drop_base = {}
@load_sheel(work_book, ur"野怪掉落ID")
def get_monster_drop_reward(content, all_content, row):
    drop_id   = int(prev(all_content, row, 0))
    item_list = get_str(content[1], '')

    drop_base.setdefault(drop_id, [])
    drop_base[drop_id].append("[%s]"%(item_list))
    return []

get_monster_drop_reward()

data_widlerness.append("%% @spec get_monster_drop_reward(DropID::int()) -> list()")
for i in drop_base:
    data_widlerness.append("get_monster_drop_reward(%d) -> [%s];"%(i, ",".join(drop_base[i])))
data_widlerness.append("get_monster_drop_reward(_) -> [].")

wild_base_info = []
wild_base_info.append("%% @spec wild_base_info() -> #wild_base_info{}")

@load_sheel(work_book, ur"城防基础")
def get_wild_base(content):
    protect_blood   = get_str(content[WildBaseField.cavalry_num], '')
    recovery_rate   = int(content[WildBaseField.wall_rescue])
    power_vip_resoures = get_str(content[WildBaseField.base_lev_reward], '')
    base_repair_cost = get_str(content[WildBaseField.wallrepaircost], '')

    wild_base_info.append("""wild_base_info()-> 
    #wild_base_info{
        protect_blood = [%s],
        recovery_rate = %d,
        power_vip_resoures = {%s},
        base_repair_cost = %s
    }."""%(protect_blood, recovery_rate, power_vip_resoures, base_repair_cost))

    return []

get_wild_base()

data_widlerness.extend(wild_base_info)

wild_repair_list = []
wild_repair_list.append("%% @spec get_troops_repair(Power :: Num()) -> Iron :: Num()")

max_require_iron = 0
@load_sheel(work_book, ur"维修战力对应所需要铁矿")
def get_wild_repair(content):
    repairforce   = int(content[WildRepairField.repairforce])
    require_iron  = int(content[WildRepairField.require_iron])
    global max_require_iron 
    max_require_iron = require_iron
    wild_repair_list.append("get_troops_repair(Power) when Power =< %d-> %d;"%(repairforce, require_iron))

    return []
get_wild_repair()

wild_repair_list.append("get_troops_repair(_) -> %d."%(max_require_iron))

data_widlerness.extend(wild_repair_list)

feats_list = []
@load_sheel(work_book, ur"战功领奖")
def get_wild_feats(content):
    index   = int(content[0])
    feats   = int(content[1])
    crystal = int(content[2])
    feats_list.append("get_feats_reward(%d, Feats) when Feats >= %d -> %d;"%(index, feats, crystal))

    return []
get_wild_feats()

feats_list.append("get_feats_reward(_, _) -> false.")

data_widlerness.extend(feats_list)



gen_erl(wilderness_erl, data_widlerness)
