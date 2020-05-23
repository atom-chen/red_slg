#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
VIP签到
@author: ZhaoMing
@deprecated: 2014年7月31日
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"vip_dailygift")

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

vip_sign_erl = "data_vip_sign"
data_vip_sign = module_header(ur"VIP签到", vip_sign_erl, "zm", "vip_dailygift.xlsx", "data_vip_sign.py")
data_vip_sign.append("""
-export([gain_list/1]).
""")

gain_list = []
gain_list.append("""
%% @doc 签到奖励
%% @spec gain_list(VIPLev::int()) -> list() """)
@load_sheel(work_book, ur"Sheet1")
def get_gain(content):
    vip_lev = int(content[0])
    items = str(content[1])
    coin = int(get_value(content[2], 0))
    gold = int(get_value(content[3], 0))
    gain_list.append("gain_list(VIP) when VIP =:= %d -> [{add_items, [%s]}, {add_coin, %d}, {add_gold, %d}];"%(vip_lev, items, coin, gold))
    return []

get_gain()

gain_list.append("gain_list(_) -> [].")

data_vip_sign.extend(gain_list)

gen_erl(vip_sign_erl, data_vip_sign)
