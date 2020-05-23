#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
vip配置表
@author: ZhaoMing
@deprecated: 2014年7月31日
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, module_php_header, gen_php

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"vip_tw")

# Erlang模块头说明，主要说明该文件作用，会自动添加-module(module_name).
# module_header函数隐藏了第三个参数，是指作者，因此也可以module_header(ur"礼包数据", module_name, "King")


# Erlang需要导出的函数接口, append与erlang的++也点类似，用于python的list操作
# Erlang函数一些注释，可以不写，但建议写出来

# 生成枚举的工具函数
def enum(module, str_enum):
    str_enum = str_enum.replace(" ", "")
    str_enum = str_enum.replace("\n", "")
    idx = 0  
    for name in str_enum.split(","):  
        if '=' in name:  
            name,val = name.rsplit('=', 1)            
            if val.isalnum():               
                idx = eval(val)  
        setattr(module, name.strip(), idx)  
        idx += 1

## 必须和excel里面的列保持一致的顺序
BaseColumn = """
    vipLev
    ,chargeGold
    ,gold2coinCount
    ,buyEnergyCount
    ,buyArenaCount
    ,includePrivilege
    ,friendNum
    ,doubleRenown
    ,startCount
    ,sweepRight
    ,openBox
    ,freeTime
    ,quickFinishDungeon
    ,maxBuildQueue
    ,canBattlefrontAuto
    ,autoBuild
    ,freeGuild
    ,VIPGift
    ,VIPGrowPlan
    ,troops_4
    ,troops_5
    ,donate
    ,resource
    ,defender
    ,tencast
    ,buyElites
    ,buyelitestimes
    ,wishDefaultFreeCount
    ,paper_dial_free_times
    ,paper_dial_max_times
    ,kingBossResetCount
    ,kingBossCanQuickFinish
    ,kingBossQuickFinishCostTime
    ,kingBossPreMinCostGold
"""
 
class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)

# 生成域枚举           
BaseField = FieldClassBase()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

vip_erl = "data_vip_tw"
data_vip = module_header(ur"vip配置表", vip_erl, "zm", "vip_tw.xlsx", "data_vip_tw.py")

vip_php = "base_vip_tw.cfg"
data_php_vip = module_php_header(ur"VIP配置", vip_php, "zm", "vip.xlsx", "data_vip.py")
php_vip_base = []
php_vip_base.append("""return $base_vip = array(
    0 => array('vip_lev' => 0, 'gold'=> 0),""")

data_vip.append("""
-record(vip_conf, {
        vip_lev                        = 0
        ,buy_energy_count              = 0
        ,buy_coin_count                = 0
        ,buy_arena_count               = 0
        ,charge_gold                   = 0
        ,buy_dungeon_count             = 0
        ,can_open_dungeon_box          = false
        ,merc_num                      = 0
        ,stone_energy_num              = 0
        ,reset_world_boss_times        = 0
        ,buy_shuangta_count            = 0
        ,can_open_ship_count           = 0
        ,can_quick_finish_dungeon      = false
        ,buy_bomb_count                = 0
        ,max_friend_num                = 0
        ,can_arena_double_shengwang    = false
        ,aggress_start_wave            = 1
        ,can_open_aggress_quick_finish = false
        ,free_clean_build_cd_time      = 0
        ,max_build_queue               = 0
        ,can_battlefront_auto          = false
        ,can_auto_up_build             = false
        ,can_free_create_guild         = false
        ,has_wild_troops_4             = false
        ,has_wild_troops_5             = false
        ,donate_times                  = 0
        ,can_gold2coin_10              = false
        ,aggress_quick_finish_times    = 0 
        ,buy_dungeon_acc_count         = 0
        ,wish_default_free_count       = 0
        ,paper_dial_free_times         = 0
        ,paper_dial_max_times          = 0
        ,king_boss_reset_count         = 0
        ,king_boss_can_quick_finish    = false
        ,king_boss_quick_finish_cost_time = 100000
        ,king_boss_pre_min_cost_gold   = 10000
    }).

-export([
         buy_energy_count/1
         ,buy_coin_count/1
         ,buy_arena_count/1
         ,get_vip_lev/1
         ,min_charge_gold/1
         ,buy_dungeon_count/1
         ,buy_dungeon_acc_count/1
         ,can_open_dungeon_box/1
         ,get_merc_num/1
         ,buy_stone_energy_num/1
         ,get_charge_gold/1
         ,get_max_buy_times_for_world_boss/1
         ,buy_shuangta_count/1
         ,can_open_ship_count/1
         ,can_quick_finish_dungeon/1
         ,buy_bomb_count/1
         ,max_friend_num/1
         ,can_arena_double_shengwang/1
         ,aggress_start_wave/1
         ,can_open_aggress_quick_finish/1
         ,free_clean_build_cd_time/1
         ,max_build_queue/1
         ,can_battlefront_auto/1
         ,can_auto_up_build/1
         ,can_free_create_guild/1
         ,has_wild_troops_4/1
         ,has_wild_troops_5/1
         ,union_donate_times/1
         ,can_gold2coin_10/1
         ,aggress_quick_finish_times/1
         ,wish_default_free_count/1
         ,paper_dial_free_times/1
         ,paper_dial_max_times/1
         ,king_boss_reset_count/1
         ,king_boss_can_quick_finish/1
         ,king_boss_quick_finish_cost_time/1
         ,king_boss_pre_min_cost_gold/1

         %% 内部调用
         ,get/1
        ]).
%% ---------------------------------------------------------------------------
%% @doc 王牌挑战-元宝快速完成 
%% @spec king_boss_pre_min_cost_gold(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
king_boss_pre_min_cost_gold(VipLev) -> 
    get_max_count(VipLev, #vip_conf.king_boss_pre_min_cost_gold).

%% ---------------------------------------------------------------------------
%% @doc 王牌挑战-扫荡需要时间（秒）
%% @spec king_boss_quick_finish_cost_time(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
king_boss_quick_finish_cost_time(VipLev) -> 
    get_max_count(VipLev, #vip_conf.king_boss_quick_finish_cost_time).

%% ---------------------------------------------------------------------------
%% @doc 王牌挑战-是否可以开启扫荡
%% @spec king_boss_can_quick_finish(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
king_boss_can_quick_finish(VipLev) -> 
    get_max_count(VipLev, #vip_conf.king_boss_can_quick_finish).

%% ---------------------------------------------------------------------------
%% @doc 王牌挑战-重置次数
%% @spec king_boss_reset_count(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
king_boss_reset_count(VipLev) -> 
    get_max_count(VipLev, #vip_conf.king_boss_reset_count).

%% ---------------------------------------------------------------------------
%% @doc 许愿默认免费次数
%% @spec wish_default_free_count(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
wish_default_free_count(VipLev) -> 
    get_max_count(VipLev, #vip_conf.wish_default_free_count).

%% ---------------------------------------------------------------------------
%% @doc 是否可以免费创建公会
%% @spec can_gold2coin_10(VipLev :: int()) -> false|true
%% ---------------------------------------------------------------------------
can_gold2coin_10(VipLev) -> 
    get_max_count(VipLev, #vip_conf.can_gold2coin_10).

%% ---------------------------------------------------------------------------
%% @doc 是否可以免费创建公会
%% @spec can_free_create_guild(VipLev :: int()) -> false|true
%% ---------------------------------------------------------------------------
can_free_create_guild(VipLev) -> 
    get_max_count(VipLev, #vip_conf.can_free_create_guild).

%% ---------------------------------------------------------------------------
%% @doc 建筑是否可以自动升级
%% @spec can_auto_up_build(VipLev :: int()) -> false|true
%% ---------------------------------------------------------------------------
can_auto_up_build(VipLev) -> 
    get_max_count(VipLev, #vip_conf.can_auto_up_build).

%% ---------------------------------------------------------------------------
%% @doc 是否可以挂机
%% @spec can_battlefront_auto(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
can_battlefront_auto(VipLev) -> 
    get_max_count(VipLev, #vip_conf.can_battlefront_auto).

%% ---------------------------------------------------------------------------
%% @doc 最大建筑队列
%% @spec max_build_queue(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
max_build_queue(VipLev) -> 
    get_max_count(VipLev, #vip_conf.max_build_queue).

%% ---------------------------------------------------------------------------
%% @doc 建筑免费加速时间（小于多少秒免费加速）
%% @spec free_clean_build_cd_time(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
free_clean_build_cd_time(VipLev) -> 
    get_max_count(VipLev, #vip_conf.free_clean_build_cd_time).

%% ---------------------------------------------------------------------------
%% @doc 抵抗侵略可选开始波数
%% @spec aggress_start_wave(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
aggress_start_wave(VipLev) -> 
    get_max_count(VipLev, #vip_conf.aggress_start_wave).

%% ---------------------------------------------------------------------------
%% @doc 抵抗侵略是否可以快速完成
%% @spec can_open_aggress_quick_finish(VipLev :: int()) -> false | true
%% ---------------------------------------------------------------------------
can_open_aggress_quick_finish(VipLev) -> 
    get_max_count(VipLev, #vip_conf.can_open_aggress_quick_finish).

%% ---------------------------------------------------------------------------
%% @doc 声望是否可以翻倍
%% @spec can_arena_double_shengwang(VipLev :: int()) -> false | true
%% ---------------------------------------------------------------------------
can_arena_double_shengwang(VipLev) -> 
    get_max_count(VipLev, #vip_conf.can_arena_double_shengwang).

%% ---------------------------------------------------------------------------
%% @doc 最大好友数量
%% @spec max_friend_num(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
max_friend_num(VipLev) -> 
    get_max_count(VipLev, #vip_conf.max_friend_num).

%% ---------------------------------------------------------------------------
%% @doc 可购买炮弹值次数
%% @spec buy_bomb_count(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
buy_bomb_count(VipLev) -> 
    get_max_count(VipLev, #vip_conf.buy_bomb_count).

%% ---------------------------------------------------------------------------
%% @doc 可以开启飞艇个数
%% @spec can_open_ship_count(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
can_open_ship_count(VipLev) ->
    get_max_count(VipLev, #vip_conf.can_open_ship_count).

%% ---------------------------------------------------------------------------
%% @doc 是否可以扫荡
%% @spec can_quick_finish_dungeon(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
can_quick_finish_dungeon(VipLev) ->
    get_max_count(VipLev, #vip_conf.can_quick_finish_dungeon).

%% ---------------------------------------------------------------------------
%% @doc vip购买符石能量的次数
%% @spec buy_stone_energy_num(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
buy_stone_energy_num(VipLev) ->
    get_max_count(VipLev, #vip_conf.stone_energy_num).

%% ---------------------------------------------------------------------------
%% @doc vip购买副本的次数
%% @spec buy_dungeon_count(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
buy_dungeon_count(VipLev) ->
    get_max_count(VipLev, #vip_conf.buy_dungeon_count).


%% ---------------------------------------------------------------------------
%% @doc vip购买副本最大次数
%% @spec buy_dungeon_acc_count(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
buy_dungeon_acc_count(VipLev) ->
    get_max_count(VipLev, #vip_conf.buy_dungeon_acc_count).

%% ---------------------------------------------------------------------------
%% @doc vip购买体力的次数
%% @spec buy_energy_count(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
buy_energy_count(VipLev) ->
    get_max_count(VipLev, #vip_conf.buy_energy_count).

%% ---------------------------------------------------------------------------
%% @doc vip购买点金手的次数
%% @spec buy_coin_count(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
buy_coin_count(VipLev) ->
    get_max_count(VipLev, #vip_conf.buy_coin_count).

%% ---------------------------------------------------------------------------
%% @doc 双塔购买次数
%% @spec buy_shuangta_count(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
buy_shuangta_count(VipLev) ->
    get_max_count(VipLev, #vip_conf.buy_shuangta_count).

%% ---------------------------------------------------------------------------
%% @doc vip购买竞技场的次数
%% @spec buy_arena_count(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
buy_arena_count(VipLev) ->
    get_max_count(VipLev, #vip_conf.buy_arena_count).

%% ---------------------------------------------------------------------------
%% @doc 是否可以开vip宝箱
%% @spec can_open_dungeon_box(VipLev :: int()) -> false | true.
%% ---------------------------------------------------------------------------
can_open_dungeon_box(VipLev) ->
    get_max_count(VipLev, #vip_conf.can_open_dungeon_box).

%% ---------------------------------------------------------------------------
%% @doc vip派遣佣兵数量
%% @spec can_open_dungeon_box(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
get_merc_num(VipLev) ->
    get_max_count(VipLev, #vip_conf.merc_num).
    
%% ---------------------------------------------------------------------------
%% @doc 获取该等级所需充值元宝数量
%% @spec get_charge_gold(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
get_charge_gold(VipLev) ->
    get_max_count(VipLev, #vip_conf.charge_gold).

%% ---------------------------------------------------------------------------
%% @doc 获取购买世界BOSS挑战次数上限
%% @spec get_max_buy_times_for_world_boss(VipLev :: int()) -> int()
%% ---------------------------------------------------------------------------
get_max_buy_times_for_world_boss(VipLev) ->
    get_max_count(VipLev, #vip_conf.reset_world_boss_times).

%% ---------------------------------------------------------------------------
%% @doc 野外部队4
%% @spec has_wild_troops_4(VipLev :: int()) -> true | false
%% ---------------------------------------------------------------------------
has_wild_troops_4(VipLev) ->
    get_max_count(VipLev, #vip_conf.has_wild_troops_4).

%% ---------------------------------------------------------------------------
%% @doc 野外部队5
%% @spec has_wild_troops_4(VipLev :: int()) -> true | false
%% ---------------------------------------------------------------------------
has_wild_troops_5(VipLev) ->
    get_max_count(VipLev, #vip_conf.has_wild_troops_5).

%% ---------------------------------------------------------------------------
%% @doc 军团贡献次数
%% @spec union_donate_times(VipLev :: int()) -> Num :: integer()
%% ---------------------------------------------------------------------------
union_donate_times(VipLev) ->
    get_max_count(VipLev, #vip_conf.donate_times).

%% ---------------------------------------------------------------------------
%% @doc 每日抵抗侵略扫荡次数
%% @spec aggress_quick_finish_times(VipLev :: int()) -> Num :: integer()
%% ---------------------------------------------------------------------------
aggress_quick_finish_times(VipLev) ->
    get_max_count(VipLev, #vip_conf.aggress_quick_finish_times).


%% ---------------------------------------------------------------------------
%% @doc 图纸转盘免费次数
%% @spec paper_dial_free_times(VipLev :: int()) -> Num :: integer()
%% ---------------------------------------------------------------------------
paper_dial_free_times(VipLev) ->
    get_max_count(VipLev, #vip_conf.paper_dial_free_times).

%% ---------------------------------------------------------------------------
%% @doc 图纸转盘最大限制次数
%% @spec paper_dial_max_times(VipLev :: int()) -> Num :: integer()
%% ---------------------------------------------------------------------------
paper_dial_max_times(VipLev) ->
    get_max_count(VipLev, #vip_conf.paper_dial_max_times).


get_max_count(VipLev, Pos) ->
    case ?MODULE:get(VipLev) of
        false -> 
            Default = #vip_conf{},
            element(Pos, Default);
        VipConf -> 
            element(Pos, VipConf)
    end.


""")

vip_conf = []
get_vip = []
min_gold = []
vip_conf.append("%% @spec get(VipLev :: int()) -> #vip_base{} | false")
task_id_list = []
@load_sheel(work_book, ur"Sheet1")
def get_vip_conf(content):
    vip_lev                    = int(content[BaseField.vipLev])
    buy_energy_count           = int(content[BaseField.buyEnergyCount])
    buy_coin_count             = int(content[BaseField.gold2coinCount])
    buy_arena_count            = int(content[BaseField.buyArenaCount])
    max_friend_num             = int(content[BaseField.friendNum])
    charge_gold                = int(content[BaseField.chargeGold])
    free_clean_build_cd_time   = int(get_value(content[BaseField.freeTime], 0))
    max_build_queue            = int(get_value(content[BaseField.maxBuildQueue], 1))
    donate_times               = int(content[BaseField.donate])
    aggress_quick_finish_times = int(content[BaseField.defender])
    buy_dungeon_count          = int(content[BaseField.buyElites])
    buy_dungeon_acc_count      = int(content[BaseField.buyelitestimes])
    wish_default_free_count    = int(content[BaseField.wishDefaultFreeCount])
    paper_dial_free_times      = int(content[BaseField.paper_dial_free_times])
    paper_dial_max_times       = int(content[BaseField.paper_dial_max_times])
    king_boss_reset_count      = int(content[BaseField.kingBossResetCount])
    king_boss_quick_finish_cost_time = int(content[BaseField.kingBossQuickFinishCostTime])
    king_boss_pre_min_cost_gold = int(content[BaseField.kingBossPreMinCostGold])

    if int(content[BaseField.kingBossCanQuickFinish]) == 1:
        king_boss_can_quick_finish = "true"
    else:
        king_boss_can_quick_finish = "false"
    

    if int(get_value(content[BaseField.autoBuild], 0)) == 0:
        can_auto_up_build = "false"
    else:
        can_auto_up_build = "true"

    if int(get_value(content[BaseField.tencast], 0)) == 0:
        can_gold2coin_10 = "false"
    else:
        can_gold2coin_10 = "true"

    if int(get_value(content[BaseField.freeGuild], 0)) == 0:
        can_free_create_guild = "false"
    else:
        can_free_create_guild = "true"

    php_vip_base.append("""    {0} => array('vip_lev' => {0}, 'gold' => {1}),""".format(vip_lev, charge_gold))
    
    if int(content[BaseField.canBattlefrontAuto]) == 1:
        can_battlefront_auto = "true"
    else:
        can_battlefront_auto = "false"

    if int(content[BaseField.doubleRenown]) == 1:
        can_arena_double_shengwang = "true"
    else:
        can_arena_double_shengwang = 'false'

    if int(content[BaseField.openBox]) == 1:
        can_open_dungeon_box = "true"
    else:
        can_open_dungeon_box = "false"

    if int(content[BaseField.quickFinishDungeon]) == 1:
        can_quick_finish_dungeon = "true"
    else:
        can_quick_finish_dungeon = "false"

    aggress_start_wave = int(get_value(content[BaseField.startCount], 1))

    if int(content[BaseField.sweepRight]) == 1: 
        can_open_aggress_quick_finish = 'true'
    else:
        can_open_aggress_quick_finish = 'false'

    if int(content[BaseField.troops_4]) == 1:
        has_wild_troops_4 = 'true'
    else:
        has_wild_troops_4 = 'false'

    if int(content[BaseField.troops_5]) == 1:
        has_wild_troops_5 = 'true'
    else:
        has_wild_troops_5 = 'false'

    get_vip.append("get_vip_lev(Gold) when Gold >= {0} -> {1};".format(charge_gold, vip_lev))
    min_gold.append("min_charge_gold(VipLev) when VipLev =:= {0} -> {1};".format(vip_lev, charge_gold))
    vip_conf.append("""get({0}) ->
    #vip_conf{{
        vip_lev = {0}
        ,buy_coin_count = {1}
        ,buy_arena_count = {2}
        ,charge_gold = {3}
        ,max_friend_num = {4}
        ,can_arena_double_shengwang = {5}
        ,aggress_start_wave = {6}
        ,can_open_aggress_quick_finish = {7}
        ,buy_energy_count = {8}
        ,can_open_dungeon_box = {9}
        ,free_clean_build_cd_time = {10}
        ,can_quick_finish_dungeon = {11}
        ,max_build_queue ={12}
        ,can_battlefront_auto = {13}
        ,can_auto_up_build = {14}
        ,can_free_create_guild = {15}
        ,has_wild_troops_4 = {16}
        ,has_wild_troops_5 = {17}
        ,donate_times = {18}
        ,can_gold2coin_10 = {19}
        ,aggress_quick_finish_times = {20}
        ,buy_dungeon_count = {21}
        ,buy_dungeon_acc_count = {22}
        ,wish_default_free_count = {23}
        ,paper_dial_free_times = {24}
        ,paper_dial_max_times = {25}
        ,king_boss_reset_count = {26}
        ,king_boss_can_quick_finish = {27}
        ,king_boss_quick_finish_cost_time = {28}
        ,king_boss_pre_min_cost_gold = {29}
    }};""".format(
        vip_lev, 
        buy_coin_count, 
        buy_arena_count, 
        charge_gold, 
        max_friend_num,
        can_arena_double_shengwang,
        aggress_start_wave,
        can_open_aggress_quick_finish,
        buy_energy_count,
        can_open_dungeon_box,
        free_clean_build_cd_time,
        can_quick_finish_dungeon,
        max_build_queue,
        can_battlefront_auto,
        can_auto_up_build,
        can_free_create_guild,
        has_wild_troops_4,
        has_wild_troops_5,
        donate_times,
        can_gold2coin_10,
        aggress_quick_finish_times,
        buy_dungeon_count,
        buy_dungeon_acc_count,
        wish_default_free_count,
        paper_dial_free_times,
        paper_dial_max_times,
        king_boss_reset_count,
        king_boss_can_quick_finish,
        king_boss_quick_finish_cost_time,
        king_boss_pre_min_cost_gold
        )
    )
    return []

get_vip_conf()
vip_conf.append("get(_) -> false.")
get_vip.append("%% @doc 根据充值元宝数获得对应的vip等级")
get_vip.append("%% @spec get_vip_lev(Gold :: int()) -> VIPLev::int()")
get_vip = get_vip[::-1]
get_vip.append("get_vip_lev(_) -> 0.")
min_gold.append("min_charge_gold(_) -> 0.")
php_vip_base.append(");")

data_vip.extend(get_vip)
data_vip.extend(min_gold)
data_vip.extend(vip_conf)

data_php_vip.extend(php_vip_base)

gen_erl(vip_erl, data_vip)
gen_php(vip_php, data_php_vip)
