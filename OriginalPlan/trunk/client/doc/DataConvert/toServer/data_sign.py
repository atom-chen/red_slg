#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
签到配置
@author: ZhaoMing
@deprecated: 2014-11-24
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"sign")

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

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

sign_erl = "data_sign"
data_sign = module_header(ur"签到配置", sign_erl, "zm", "sign.xlsx", "data_sign.py")
data_sign.append("-export([get_reward/1, first_day/0, last_day/0, get_double_vip/1]).")

last_day = 0
first_day = 100
sign_reward = []
sign_vip = []
sign_reward.append("%% @spec get_reward(NthDay :: int()) -> list()")
sign_vip.append("%% @spec get_double_vip(NthDay :: int()) -> VipLev :: int()")

@load_sheel(work_book, ur"签到")
def get_sign_reward(content):
    global last_day
    global first_day
    nth_day = int(content[0])
    gold = int(get_value(content[1], 0))
    coin = int(get_value(content[2], 0))
    item_list = get_str(content[3], '')
    vip_lev = int(get_value(content[4], 0))
    sign_reward.append("get_reward(%d) -> [{add_gold, %d}, {add_coin, %d}, {add_items, [%s]}];"%(nth_day, gold, coin, item_list))
    sign_vip.append("get_double_vip(%d) -> %d;"%(nth_day, vip_lev))
    if first_day > nth_day:
        first_day = nth_day
    if last_day < nth_day:
        last_day = nth_day
    return []

get_sign_reward()
sign_reward.append("get_reward(_) -> [].")
data_sign.extend(sign_reward)
sign_vip.append("get_double_vip(_) -> 0.")
data_sign.extend(sign_vip)
data_sign.append("first_day() -> %d."%(first_day))
data_sign.append("last_day() -> %d."%(last_day))

gen_erl(sign_erl, data_sign)
