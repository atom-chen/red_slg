#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
活动配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"activity")

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
    actID
    ,actName
    ,iconName
    ,needLev
    ,actType
    ,Stime
    ,Etime
    ,needCount
    ,actDesc
    ,exp
    ,coin
    ,gold
    ,item
    ,oil
    ,live
    ,fun
    ,funParam
"""
BaseColumn1 = """
    liveID
    ,liveValue
    ,coin
    ,gold
    ,item
"""
 
class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)

class FieldClassBase1:
    def __init__(self):
        enum(FieldClassBase1, BaseColumn1)

# 生成域枚举           
BaseField = FieldClassBase()
BaseField1= FieldClassBase1()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

activitiy_erl = "data_activity"
data_activity = module_header(ur"活动配置", activitiy_erl, "zm", "activity.xlsx", "data_activity.py")
data_activity.append("""
-include("activity.hrl").

-export([get/1, get_all/0, get_type/1, get_reward/1, need_count/1, all_live/0, get_draw_live/1, get_live_value/1, begin_time/1, end_time/1]).

get_type(ActID) ->
    case ?MODULE:get(ActID) of
        false -> false;
        #act_base{act_type = Type} -> Type
    end.

get_reward(ActID) ->
    case ?MODULE:get(ActID) of
        false -> [];
        #act_base{reward = Reward} -> Reward
    end.

need_count(ActID) ->
    case ?MODULE:get(ActID) of
        false -> 999;
        #act_base{need_count = NeedCount} -> NeedCount
    end.

begin_time(ActID) ->
    case ?MODULE:get(ActID) of
        false -> 0;
        #act_base{begin_time = BeginTime} -> BeginTime * 3600
    end.

end_time(ActID) ->
    case ?MODULE:get(ActID) of
        false -> 0;
        #act_base{end_time = EndTime} -> EndTime * 3600
    end.
""")

act_base = []
act_base.append("%% @spec get(ActID :: int()) -> #act_base{} | false")
act_id_list = []

@load_sheel(work_book, ur"日常任务")
def get_act(content):
    act_id = int(content[BaseField.actID])
    act_type = int(content[BaseField.actType])
    need_lv = int(get_value(content[BaseField.needLev], 0))
    coin = int(get_value(content[BaseField.coin], 0))
    item = str(get_value(content[BaseField.item], ''))
    exp = int(get_value(content[BaseField.exp], 0))
    live = int(get_value(content[BaseField.live], 0))
    gold = int(get_value(content[BaseField.gold], 0))
    need_count = int(get_value(content[BaseField.needCount], 0))
    energy = int(get_value(content[BaseField.oil], 0))
    begin_time = int(get_value(content[BaseField.Stime], 0))
    end_time = int(get_value(content[BaseField.Etime], 0))

    act_base.append("""get({0}) ->
    #act_base{{
        act_id = {0}
        ,act_type = {1}
        ,need_lv = {2}
        ,reward = [{{add_coin, {3}}}, {{add_items, [{4}]}}, {{add_exp, {5}}}, {{add_gold, {6}}}, {{add_energy, {9}}}, {{add_live, {7}}}]
        ,need_count = {8}
        ,begin_time = {10}
        ,end_time = {11}
    }};""".format(act_id, act_type, need_lv, coin, item, exp, gold, live, need_count, energy, begin_time, end_time))
    act_id_list.append("%d"%(act_id))
    return []

get_act()
act_base.append("get(_) -> false.")

data_activity.extend(act_base)
data_activity.append("\n%% @spec get_all() -> list().")
data_activity.append("get_all() -> [%s]."%(",".join(act_id_list)))


live_draw = []
live_value = []
live_id_list = []
@load_sheel(work_book, ur"活跃度奖励")
def get_live_draw(content):
    live_id = int(content[BaseField1.liveID])
    live    = int(content[BaseField1.liveValue])
    coin    = int(content[BaseField1.coin])
    gold    = int(content[BaseField1.gold])
    item    = str(get_value(content[BaseField1.item], ''))
    live_draw.append("""get_draw_live({0}) -> [{{add_coin, {1}}}, {{add_gold, {2}}}, {{add_items, [{3}]}}]; """.format(live_id, coin, gold, item))
    live_value.append("""get_live_value({0}) -> {1};""".format(live_id, live))
    live_id_list.append("%d"%(live_id))
    return []

get_live_draw()
live_draw.append("get_draw_live(_) -> [].")
data_activity.extend(live_draw)
live_value.append("get_live_value(_) -> 0.")
data_activity.extend(live_value)
data_activity.append("\n%% @spec all_live() -> list().")
data_activity.append("all_live() -> [%s]."%(",".join(live_id_list)))

gen_erl(activitiy_erl, data_activity)
