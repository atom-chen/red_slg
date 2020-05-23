#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
物品合成配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"item_com")

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
    item_id
    ,method
    ,need_items
"""

DeComColumn = """
    item_id,
    decom_items
"""
 
class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)

class FieldClassDecom:
    def __init__(self):
        enum(FieldClassDecom, DeComColumn)

# 生成域枚举           
BaseField = FieldClassBase()
DecomField = FieldClassDecom()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

item_com_erl = "data_item_com"
data_item_com = module_header(ur"物品合成配置表", item_com_erl, "zm", "item.xlsx", "data_item_com.py")
data_item_com.append("""
-export([com/2, decom/1, can_decom/1]).

""")

item_com_list = []
item_com_list.append("""
%% @doc 物品合成消耗以及获得 
%% @spec com(ItemID :: int(), Method::int()) -> list() """)

@load_sheel(work_book, ur"物品合成配置")
def get_item_com(content):
    item_id = int(content[BaseField.item_id])
    method = int(content[BaseField.method])
    need_items = get_str(content[BaseField.need_items], '')
    item_com_list.append("com(%d, %d) -> [{del_items, [%s]}, {add_items, [{%d, 1}]}]; "%(item_id, method, need_items, item_id))
    return []

get_item_com()
item_com_list.append("com(_, _) -> [].")

item_decom_list = []
item_decom_list.append("""
%% @doc 物品分解 消耗以及获得
%% @spec decom(ItemID::int()) -> list() """)

can_decom_list = []
can_decom_list.append("""
%% @doc 物品是否可以分解
%% @spec can_decom(ItemID::int()) -> false | true """)

@load_sheel(work_book, ur"物品分解配置")
def get_item_decom(content):
    item_id = int(content[DecomField.item_id])
    decom_items = get_str(content[DecomField.decom_items], '')
    item_decom_list.append("decom(%d) -> [{del_items, [{%d, 1}]}, {add_items, [%s]}];"%(item_id, item_id, decom_items))

    if decom_items != '':
        can_decom_list.append("can_decom(%d) -> true;"%(item_id))
    return []

get_item_decom()
item_decom_list.append("decom(_) -> [].")
can_decom_list.append("can_decom(_) -> false.")

data_item_com.extend(item_com_list)
data_item_com.extend(item_decom_list)
data_item_com.extend(can_decom_list)

gen_erl(item_com_erl, data_item_com)
