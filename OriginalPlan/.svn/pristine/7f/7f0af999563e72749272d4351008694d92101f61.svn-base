#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
功能开启送砖石
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_hrl_header, module_php_header, gen_erl, gen_hrl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"system_open")

# Erlang模块头说明，主要说明该文件作用，会自动添加-module(module_name).
# module_header函数隐藏了第三个参数，是指作者，因此也可以module_header(ur"礼包数据", module_name, "King")


# Erlang需要导出的函数接口, append与erlang的++也点类似，用于python的list操作
# Erlang函数一些注释，可以不写，但建议写出来

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

system_open_erl = "data_system_open"
data_open = module_header(ur"功能开启送砖石配置", system_open_erl, "zm", "system_open.xlsx", "data_system_open.py")
data_open_hrl =  module_hrl_header(ur"功能开启", "zm", "system_open.xlsx", "data_system_open.py")

data_open_hrl.append("""
-record(system_open, {
          id         = 0,
          lev        = 0,
          dungeon_id = 0,
          gold       = 0,
          is_open    = false
         }).
""")

data_open.append("""
-include("system_open.hrl").

-export([
         get/1, 
         get_sys_id_list_by_lev/1, 
         get_sys_id_list_by_dungeon_id/1
        ]).
""")

def_system_id_list = {
        1 : {"name": "NORMAL_DUNGEON", "note":"普通副本" } ,
        2 : {"name": "GOLD_DUNGEON"  , "note":"金矿副本" } ,
        3 : {"name": "TEAM_DUNGEON"  , "note":"组队副本" } ,
        4 : {"name": "BOSS"          , "note":"世界boss" } ,
        5 : {"name": "LEADER"        , "note":"指挥官"   } ,
        6 : {"name": "ARENA"         , "note":"竞技场"   } ,
        7 : {"name": "CITY"          , "note":"战争前线" } ,
        8 : {"name": "UNION"         , "note":"公会"     } ,
        9 : {"name": "FRIEND"        , "note":"好友"     } ,
        10: {"name": "BUILD_102"     , "note":"冶炼厂"   } ,
        11: {"name": "CHAT"          , "note":"聊天"     } ,
        12: {"name": "HERO_SHOW"     , "note":"部队(英雄展示)" } ,
        13: {"name": "CHEST"         , "note":"军需库"   } ,
        14: {"name": "UNION_DUNGEON" , "note":"公会副本" } ,
        15: {"name": "PVE"           , "note":"征战"     } ,
        16: {"name": "DAILY_DUNGEON" , "note":"争霸"     },
        17: {"name": "AGGRESS"       , "note":"抵抗侵略" } ,
        18: {"name": "EQM"           , "note":"军备"     } ,
        19: {"name": "BUILD_103"     , "note":"超级武器" } ,
        20: {"name": "GOLD2COIN"     , "note":"铸币厂"   } ,
        21: {"name": "WILDERNESS"    , "note":"野外"     } ,
        22: {"name": "BUILD_105"     , "note":"坦克工厂" } ,
        23: {"name": "BUILD_104"     , "note":"战车工厂" } ,
        24: {"name": "BUILD_106"     , "note":"空指部"   } ,
        25: {"name": "BUILD_107"     , "note":"兵营"     } ,  
        28: {"name": "ELITE_DUNGEON" , "note":"精英副本" } ,
        29: {"name": "BUILD_101"     , "note":"主基地"   } ,  
        100: {"name": "HERO_POETRY"  , "note":"英雄史诗" } ,
        }

sys_id_list_by_lev = {}
sys_id_list_by_dungeon_id = {}

sys_open_list = []
sys_open_list.append("""
%% 配置
%% get(SysID::int()) -> #system_open{} """)

@load_sheel(work_book, ur"Sheet1")
def get_conf(content):
    sys_id = int(content[0])
    lev = int(get_value(content[1], 0))
    gold = int(get_value(content[4], 0))
    
    if int(get_value(content[6], 0)) == 0:
        is_open = "true"
    else:
        is_open = "false"

    dungeon_id = int(get_value(content[7], 0))

    if dungeon_id != 0:
        dungeon_id = dungeon_id + 10000

    sys_open_list.append("""
get(%d) -> 
    #system_open{
     id = %d,
     lev = %d,
     dungeon_id = %d,
     gold = %d,
     is_open = %s
    }; """%(sys_id, sys_id, lev, dungeon_id, gold, is_open))

    if lev != 1 and is_open == "true":
        sys_id_list_by_lev.setdefault(lev, [])
        sys_id_list_by_lev[lev].append("%d"%(sys_id))

    if dungeon_id != 0 and is_open == "true":
        sys_id_list_by_dungeon_id.setdefault(dungeon_id, [])
        sys_id_list_by_dungeon_id[dungeon_id].append("%d"%(sys_id))

    return []

get_conf()

sys_open_list.append("get(_) -> false.")

for key in def_system_id_list.keys():
    data_open_hrl.append("-define(SYS_OPEN_ID_%s, %d). %%%% %s"%(def_system_id_list[key]["name"], key, def_system_id_list[key]["note"]))

data_open.extend(sys_open_list)

for key in sys_id_list_by_lev.keys():
    data_open.append("get_sys_id_list_by_lev(%d) -> [%s];"%(key, ",".join(sys_id_list_by_lev[key])))
data_open.append("get_sys_id_list_by_lev(_) -> [].")

for key in sys_id_list_by_dungeon_id.keys():
    data_open.append("get_sys_id_list_by_dungeon_id(%d) -> [%s];"%(key, ",".join(sys_id_list_by_dungeon_id[key])))
data_open.append("get_sys_id_list_by_dungeon_id(_) -> [].")

gen_erl(system_open_erl, data_open)
gen_hrl("system_open", data_open_hrl)
