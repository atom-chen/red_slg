#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
在线奖励配置
@author: kingwen
@deprecated: 2015-03-06
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"onlinereward")

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
    num,reward,count
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

online_gift_erl = "data_online_gift"
data_online_gift = module_header(ur"在线礼包", online_gift_erl, "csh", "onlinereward.xlsx", "data_onlinereward.py")
data_online_gift.append("""
-export([
         get_reward/1
         ,get_need_time/1
        ]).

get_need_time(_) -> 5 * 60.  
""")

max_count = 0
get_reward_list = []
@load_sheel(work_book, ur"Sheet1")
def get_online_conf(content):
    global max_count
    nth = int(content[BaseField.num])
    reward_list = get_str(content[BaseField.reward], '')
    count = int(get_value(content[BaseField.count], 1))
    get_reward_list.append("do_get_reward(%d) -> [{ItemID, Num} || {ItemID, Num, _} <- util:list_rands_by_rate([%s], %d)];"%(nth, reward_list, count))
    if nth > max_count:
        max_count = nth
    return []

get_online_conf()

get_reward_list.append("do_get_reward(_) -> [].")

data_online_gift.append("""
get_reward(Nth) ->
    RemNth = Nth rem %d,
    case RemNth of
        0 -> do_get_reward(%d);
        _ -> do_get_reward(RemNth)
    end.
"""%(max_count, max_count))

data_online_gift.extend(get_reward_list)

gen_erl(online_gift_erl, data_online_gift)
