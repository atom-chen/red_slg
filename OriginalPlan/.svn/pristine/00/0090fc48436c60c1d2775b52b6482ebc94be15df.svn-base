#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
军阶配置表
@author: ZhaoMing
@deprecated: 2014年7月31日
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, module_php_header, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"commanderRank_thai")

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
    ,name
    ,icon
    ,minPower
    ,limit
    ,dungeonExpPercent
    ,mineSweepTime
    ,autoBuild
    ,crystalCollectionPer
    ,uraniumCollectionPer
    ,ironCollectionPer
    ,autoCollect
    ,tenLottery
    ,autoIron
    ,autoCrystal
    ,autoUranium
    ,dungeonCoin
    ,mintCoins
    ,desc
    ,goldPay
    ,coinPay
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

power_vip_erl = "data_power_vip_thai"
data_power_vip = module_header(ur"军阶配置表", power_vip_erl, "zm", "commanderRank_thai.xlsx", "data_power_vip_thai.py")

data_power_vip.append("""
-record(vip_conf, {
        vip_lev                        = 0
        ,power_vip_name                = <<>>
        ,min_power                     = 0
        ,dungeon_exp_percent           = 1
        ,mine_sweep_time               = 0
        ,can_auto_up_build             = false
        ,crystal_percent               = 1
        ,uranium_percent               = 1
        ,iron_percent                  = 1
        ,mine_auto_num                 = 0
        ,chest_10_percent              = 1
        ,gain_list                     = []
        ,gold2coin_iron_percent        = 1
        ,gold2coin_crystal_percent     = 1
        ,gold2coin_uranium_percent     = 1
        ,gold2coin_percent             = 1
        ,dungeon_coin_percent          = 1
    }).

-export([
         get/1
         ,get_all/0
         ,get_vip_lev/1
         ,dungeon_exp_percent/1
         ,crystal_percent/1
         ,uranium_percent/1
         ,iron_percent/1
         ,mine_auto_num/1
         ,chest_10_percent/1
         ,mine_sweep_time/1
         ,can_auto_up_build/1
         ,gain_list/1
         ,gold2coin_iron_percent/1
         ,gold2coin_crystal_percent/1
         ,gold2coin_uranium_percent/1
         ,gold2coin_percent/1
         ,dungeon_coin_percent/1
         ,power_vip_name/1
        ]).

%% ---------------------------------------------------------------------------
%% @doc 军阶名称
%% @spec power_vip_name(VipLev) -> binary()
%% ---------------------------------------------------------------------------
power_vip_name(VipLev) ->
    get_max_count(VipLev, #vip_conf.power_vip_name).

%% ---------------------------------------------------------------------------
%% @doc 战役结算黄金获得百分比增加
%% @spec dungeon_coin_percent(VipLev) -> number()
%% ---------------------------------------------------------------------------
dungeon_coin_percent(VipLev) ->
    get_max_count(VipLev, #vip_conf.dungeon_coin_percent).

%% ---------------------------------------------------------------------------
%% @doc 点金石加成
%% @spec gold2coin_percent(VipLev) -> number()
%% ---------------------------------------------------------------------------
gold2coin_percent(VipLev) ->
    get_max_count(VipLev, #vip_conf.gold2coin_percent).

%% ---------------------------------------------------------------------------
%% @doc 冶炼厂每小时自动产出铀资源百分比
%% @spec gold2coin_uranium_percent(VipLev) -> number()
%% ---------------------------------------------------------------------------
gold2coin_uranium_percent(VipLev) ->
    get_max_count(VipLev, #vip_conf.gold2coin_uranium_percent).

%% ---------------------------------------------------------------------------
%% @doc 冶炼厂每小时自动产出水晶资源百分比
%% @spec gold2coin_crystal_percent(VipLev) -> number()
%% ---------------------------------------------------------------------------
gold2coin_crystal_percent(VipLev) ->
    get_max_count(VipLev, #vip_conf.gold2coin_crystal_percent).

%% ---------------------------------------------------------------------------
%% @doc 冶炼厂每小时自动产出水晶资源百分比
%% @spec gold2coin_iron_percent(VipLev) -> number()
%% ---------------------------------------------------------------------------
gold2coin_iron_percent(VipLev) ->
    get_max_count(VipLev, #vip_conf.gold2coin_iron_percent).

%% ---------------------------------------------------------------------------
%% @doc 军饷
%% @spec gain_list(VipLev) -> list()
%% ---------------------------------------------------------------------------
gain_list(VipLev) ->
    get_max_count(VipLev, #vip_conf.gain_list).

%% ---------------------------------------------------------------------------
%% @doc 战役指挥官经验百份比
%% @spec dungeon_exp_percent(VipLev) -> number()
%% ---------------------------------------------------------------------------
dungeon_exp_percent(VipLev) ->
    get_max_count(VipLev, #vip_conf.dungeon_exp_percent).

%% ---------------------------------------------------------------------------
%% @doc 金矿争夺每天扫荡次数
%% @spec mine_sweep_time(VipLev) -> int()
%% ---------------------------------------------------------------------------
mine_sweep_time(VipLev) ->
    get_max_count(VipLev, #vip_conf.mine_sweep_time).

%% ---------------------------------------------------------------------------
%% @doc 建筑自动升级
%% @spec can_auto_up_build(VipLev) -> false | true
%% ---------------------------------------------------------------------------
can_auto_up_build(VipLev) ->
    get_max_count(VipLev, #vip_conf.can_auto_up_build).

%% ---------------------------------------------------------------------------
%% @doc 采集水晶百分比
%% @spec crystal_percent(VipLev) -> number()
%% ---------------------------------------------------------------------------
crystal_percent(VipLev) ->
    get_max_count(VipLev, #vip_conf.crystal_percent).

%% ---------------------------------------------------------------------------
%% @doc 采集铀百分比
%% @spec uranium_percent(VipLev) -> number()
%% ---------------------------------------------------------------------------
uranium_percent(VipLev) ->
    get_max_count(VipLev, #vip_conf.uranium_percent).

%% ---------------------------------------------------------------------------
%% @doc 采集铀百分比
%% @spec iron_percent(VipLev) -> number()
%% ---------------------------------------------------------------------------
iron_percent(VipLev) ->
    get_max_count(VipLev, #vip_conf.iron_percent).

mine_auto_num(VipLev) ->
    get_max_count(VipLev, #vip_conf.mine_auto_num).

%% ---------------------------------------------------------------------------
%% @doc 军需库10连抽n折
%% @spec chest_10_percent(VipLev) -> number()
%% ---------------------------------------------------------------------------
chest_10_percent(VipLev) ->
    get_max_count(VipLev, #vip_conf.chest_10_percent).

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
all_vip_list = []
vip_conf.append("%% @spec get(VipLev :: int()) -> #vip_base{} | false")
@load_sheel(work_book, ur"指挥官军阶")
def get_vip_conf(content):
    vip_lev = int(content[BaseField.vipLev])
    min_power = int(content[BaseField.minPower])
    get_vip.append("get_vip_lev(Power) when Power >= {0} -> {1};".format(min_power, vip_lev))
    dungeon_exp_percent = int(get_value(content[BaseField.dungeonExpPercent], 0))
    mine_sweep_time = int(get_value(content[BaseField.mineSweepTime], 0))
    can_auto_up_build = int(get_value(content[BaseField.autoBuild], 0))
    crystal_percent = int(get_value(content[BaseField.crystalCollectionPer], 0))
    uranium_percent = int(get_value(content[BaseField.uraniumCollectionPer], 0))
    iron_percent = int(get_value(content[BaseField.ironCollectionPer], 0))
    mine_auto_num = int(get_value(content[BaseField.autoCollect], 0))
    chest_10_percent = int(get_value(content[BaseField.tenLottery], 100))

    power_vip_name = get_str(content[BaseField.name], '')

    gold2coin_iron_percent = int(get_value(content[BaseField.autoIron], 0))
    gold2coin_crystal_percent = int(get_value(content[BaseField.autoCrystal], 0))
    gold2coin_uranium_percent = int(get_value(content[BaseField.autoUranium], 0))

    gold2coin_percent = int(get_value(content[BaseField.mintCoins], 0))

    dungeon_coin_percent = int(get_value(content[BaseField.dungeonCoin], 0))

    gold_pay = int(get_value(content[BaseField.goldPay], 0))
    coin_pay = int(get_value(content[BaseField.coinPay], 0))

    if int(get_value(content[BaseField.autoBuild], 0)) == 0:
        can_auto_up_build = "false"
    else :
        can_auto_up_build = "true"

    all_vip_list.append("%d"%(vip_lev))
    vip_conf.append("""get({0}) ->
    #vip_conf{{
        vip_lev = {0}
        ,min_power = {1}
        ,dungeon_exp_percent = {2}
        ,mine_sweep_time = {3}
        ,can_auto_up_build = {4}
        ,crystal_percent = {5}
        ,uranium_percent = {6}
        ,iron_percent = {7}
        ,mine_auto_num = {8}
        ,chest_10_percent = {9}
        ,gain_list = [{{add_gold, {10}}}, {{add_coin, {11}}}]
        ,gold2coin_iron_percent = {12}
        ,gold2coin_crystal_percent = {13}
        ,gold2coin_uranium_percent = {14}
        ,gold2coin_percent = {15}
        ,dungeon_coin_percent = {16}
        ,power_vip_name = <<"{17}">>
    }};""".format(
        vip_lev, 
        min_power,
        (dungeon_exp_percent + 100) / 100.0,
        mine_sweep_time,
        can_auto_up_build,
        (crystal_percent + 100) / 100.0,
        (uranium_percent + 100) / 100.0,
        (iron_percent + 100) / 100.0,
        mine_auto_num,
        chest_10_percent / 100.0,
        gold_pay, coin_pay,
        (gold2coin_iron_percent + 100) / 100.0,
        (gold2coin_crystal_percent + 100) / 100.0,
        (gold2coin_uranium_percent + 100) / 100.0,
        (gold2coin_percent + 100) / 100.0,
        (dungeon_coin_percent + 100) / 100.0,
        power_vip_name
        )
    )
    return []

get_vip_conf()
vip_conf.append("get(_) -> false.")
get_vip.append("%% @doc 根据战力数获得对应的vip等级")
get_vip.append("%% @spec get_vip_lev(Gold :: int()) -> VIPLev::int()")
get_vip = get_vip[::-1]
get_vip.append("get_vip_lev(_) -> 1.")

data_power_vip.extend(get_vip)
data_power_vip.extend(min_gold)
data_power_vip.extend(vip_conf)

data_power_vip.append("""
%% @doc 所有的VIP列表
%% @spec get_all() -> list()

get_all() -> [%s]. """%(",".join(all_vip_list)))


gen_erl(power_vip_erl, data_power_vip)
